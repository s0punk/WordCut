import argparse
import enchant
from word_list import read_word_list, get_lang_code
from colorama import init, Fore, Style

parser = argparse.ArgumentParser()
parser.add_argument("-f", type=str)
args = parser.parse_args()

def find_invalid_words(file: str):
    lang = get_lang_code(file)
    words = read_word_list(file)

    d = enchant.Dict(lang)

    invalids = []

    for w in words:
        if not d.check(w):
            invalids.append(w)

    return invalids

if __name__ == "__main__":
    if args.f is None:
        print("ERROR: No word list provided. Provide one with the -f flag.\nE.g: 'en.txt'")
        exit(1)

    file = args.f

    broker = enchant.Broker()
    d = enchant.Dict(get_lang_code(file))

    print(f"Detected language: {get_lang_code(file)}")

    while (True):
        print("\n")
        print(f"{Fore.YELLOW}1. Find invalid words")
        print("2. Check a word")
        print("3. See current dictionnary providers")
        print("4. See available languages")
        choice = input(f"{Style.RESET_ALL}Choose an option: ")
        print("\n")

        if choice == "1":
            words = find_invalid_words(file)

            for w in words:
                print(w)
            print(f"Found {len(words)} invalid words in {file}:")
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
            languages = broker.list_languages()
            for l in languages:
                print(l)
            print(f"Found {len(languages)} languages")

