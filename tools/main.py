import argparse
import json

from dataclasses import dataclass, asdict

from MIDI import MIDIFile
from MIDI.Events import MetaEvent, MIDIEvent


class UnsupportedMIDIFileError(Exception):
    pass


@dataclass
class KeyEvent:
    key: str
    start_time: float
    end_time: float


def process(input_file: str, bpm: int):
    midi_file = MIDIFile(input_file)
    midi_file.parse()

    print(midi_file)

    print(midi_file.division.division)
    print(midi_file.division.ticks)
    print(midi_file.division.smtpe)
    print(midi_file.division.ticksPerCrotchet)


    """
    division < 32768 : equals number of ticks per quarter-note; often equal to 960

    division >=32786 : number of subdivisions of a second as defined in the SMTPE Standard and on pages 116- of the MIDI Specification v1.0. Equals 32768 + 256 f + t where f identifies one of the standard MIDI time code formats, and signifies the number of frames per second, while f is the numbef of subdivisions within a frame (common values are 4, 8, 10, 80 and 100).
    """
    ticks_per_quarter_note = 960
    if midi_file.division.division < 32768:
        ticks_per_quarter_note = midi_file.division.ticksPerCrotchet
    else:
        raise UnsupportedMIDIFileError


    result: list[KeyEvent] = []
    previous_on_time: Dict[str, float] = {}
    for tr_index, track in enumerate(midi_file):
        track.parse()
        for e_index, event in enumerate(track):
            if isinstance(event, MetaEvent):
                pass
            elif isinstance(event, MIDIEvent):
                # Note ON or note OFF
                if event.command == 0x80 or event.command == 0x90:
                    time_in_seconds = event.time * (60 / bpm) / ticks_per_quarter_note

                    note = event.message.note.note
                    if event.message.onOff == "ON":
                        # Store start time
                        previous_on_time[note] = time_in_seconds
                    else:
                        # When receiving NOTE OFF, add data to results
                        start_time = previous_on_time[note]
                        result.append(
                            KeyEvent(note, start_time, time_in_seconds)
                        )

    return result




def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input", required=True)
    parser.add_argument("-o", "--output", required=True)
    parser.add_argument("-b", "--bpm", required=True, type=int)

    args = parser.parse_args()
    parser.print_help()

    result = process(args.input, args.bpm)

    json_str = json.dumps([asdict(item) for item in result], indent=4)

    with open(args.output, "w+") as file:
        file.write(json_str)


if __name__ == "__main__":
    main()
