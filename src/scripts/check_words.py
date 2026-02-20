import os
import argparse
import enchant
from word_list import read_word_list, get_lang_code
from colorama import Fore, Style

parser = argparse.ArgumentParser()
parser.add_argument("-f", type=str)
args = parser.parse_args()

def find_invalid_words(file: str):
    lang = get_lang_code(file)
    words = read_word_list(file)

    # TODO: load all fr_* dictionnaries and mark a word as invalid only if no
    # dictionnary has the word
    d = enchant.Dict(lang)

    invalids = []

    for w in words:
        if not d.check(w):
            invalids.append(w)
    
    try:
       os.makedirs("output")
       with open(f"output/invalid_words_{lang}.txt", "w", encoding='utf-8') as file:
            for w in invalids:
                file.write(w + "\n")
    except:
        print("Could not save the invalid word list")

    return invalids

if __name__ == "__main__":
    if args.f is None:
        print("ERROR: No word list provided. Provide one with the -f flag.\nE.g: 'en.txt'")
        exit(1)

    file = args.f

    broker = enchant.Broker()
    lang = get_lang_code(file)
    d = enchant.Dict(lang)

    print(f"Detected language: {lang}")

    while (True):
        print("\n")
        print(f"{Fore.YELLOW}1. Find invalid words")
        print("2. Check a word")
        print("3. See current dictionnary providers")
        print("4. See available languages")
        print("9. Quit")
        choice = input(f"{Style.RESET_ALL}Choose an option: ")
        print("\n")

        if choice == "1":
            words = find_invalid_words(file)

            print(f"Found {len(words)} invalid words in {file}:")
            print(f"Invalid word list is at {os.getcwd()}/ouput/invalid_words_{lang}.txt")
        if choice == "2":
            word = input("Enter the word to check: ")
            word_exists = d.check(word)
            print(f"{Fore.GREEN if word_exists else Fore.RED}{word}{Style.RESET_ALL}")
            print(f"Other suggestions: {d.suggest(word)}")

        if choice == "3":
            providers = broker.describe()
            for p in providers:
                print(p.name)
            print(f"Found {len(providers)} providers")
        if choice == "4":
            languages = broker.list_dicts()
            for l in languages:
                print(l)
            print(f"Found {len(languages)} languages")
        if choice == "9":
            exit(0)

