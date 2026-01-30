import argparse
from MIDI import MIDIFile

def process(input_file: str, output_file: str):
    midi_file = MIDIFile(input_file)
    midi_file.parse()

    print(midi_file)

    for tr_index, track in enumerate(midi_file):
        track.parse()
        for e_index, event in enumerate(track):
            print(event.message)
            print(event.time)





def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input", required=True)
    parser.add_argument("-o", "--output", required=True)

    args = parser.parse_args()
    parser.print_help()

    process(args.input, args.output)


if __name__ == "__main__":
    main()
