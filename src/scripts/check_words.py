import argparse
import enchant
from word_list import read_word_list, get_lang_code

parser = argparse.ArgumentParser()
parser.add_argument("-f", type=str)
args = parser.parse_args()

def find_invalid_words(file: str):
    lang = get_lang_code(file)
    words = read_word_list(file)

    d = enchant.Dict(lang)

    invalids = []

    for w in words:
        pass
        #if word_frequency(w, lang, wordlist="best") == 0:
        #    invalids.append(w)

    return invalids

if __name__ == "__main__":
    if args.f is None:
        print("ERROR: No word list provided. Provide one with the -f flag.\nE.g: 'en.txt'")
        exit(1)

    file = args.f

    print(f"Detected language: {get_lang_code(file)}\n")
    
    while (True):
        print("1. Find invalid words")
        choice = input("Choose an option: ")

        if choice == "1":
            words = find_invalid_words(file)

            for w in words:
                print(w)
            print(f"Found {len(words)} invalid words in {file}:")

