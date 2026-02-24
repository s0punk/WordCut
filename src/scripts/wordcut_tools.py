import argparse
import os
from colorama import Fore, Style
import enchant
from scripts import remove_words
from scripts.check_words import check_word, double_check_words, find_invalid_words
from scripts.config import setConfig
from scripts.word_list import get_lang_code

parser = argparse.ArgumentParser()
parser.add_argument("-f", type=str)
args = parser.parse_args()

if __name__ == "__main__":
    if args.f is None:
        print("No word list provided. Provide one with the -f flag.\nE.g: 'en.txt'")
        exit(1)

    file = args.f

    lang = get_lang_code(file)
    print(f"Detected language: {lang}")

    setConfig(lang)

    broker = enchant.Broker()

    while (True):
        print("\n")
        print(f"{Fore.YELLOW}1. Find invalid words")
        print("2. Check a word")
        print("3. Delete words from file")
        print("4. See current dictionnary providers")
        print("5. See available languages")
        print("9. Quit")
        choice = input(f"{Style.RESET_ALL}Choose an option: ")
        print("\n")

        if choice == "1":
            words = find_invalid_words(file)

            print(f"Found {len(words)} invalid words in {file}:")
            print(f"Invalid word list is at {os.getcwd()}/ouput/invalid_words_{lang}.txt")
        if choice == "2":
            word = input("Enter the word to check: ")
            word_exists = check_word(word)
            if not word_exists:
                word_exists = word in double_check_words([word])
            print(f"{Fore.GREEN if word_exists else Fore.RED}{word}{Style.RESET_ALL}")
        if choice == "3":
            words_file = input("Enter the words list's path (words to delete): ")
            remove_words(words_file, file)

        if choice == "4":
            providers = broker.describe()
            for p in providers:
                print(p.name)
            print(f"Found {len(providers)} providers")
        if choice == "5":
            languages = broker.list_dicts()
            for l in languages:
                print(l)
            print(f"Found {len(languages)} languages")
        if choice == "9":
            exit(0)