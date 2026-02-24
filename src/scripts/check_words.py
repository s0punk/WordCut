import os
import argparse
import enchant
import tqdm
import language_tool_python
from word_list import get_dicts, read_word_list, get_lang_code, chunks
from colorama import Fore, Style

parser = argparse.ArgumentParser()
parser.add_argument("-f", type=str)
args = parser.parse_args()

def find_invalid_words(file: str):
    words = read_word_list(file)
    lang = get_lang_code(file)

    invalids = []

    print("Checking words...")
    for w in tqdm.tqdm(words):
        if not check_word(w):
            invalids.append(w)

    print("Double checking invalid words...")
    invalids = double_check_words(invalids)
    
    try:
       os.makedirs("output", exist_ok=True)
       with open(f"output/invalid_words_{lang}.txt", "w", encoding='utf-8') as file:
            print(f"Writing invalid words to output/invalid_words_{lang}.txt")
            for w in tqdm.tqdm(range(len(invalids))):
                file.write(invalids[w])
                if w < len(invalids) - 1:
                    file.write("\n")
    except Exception as e:
        print(f"Could not save the invalid word list: {e}")

    return invalids

def remove_words(in_file: str, from_file: str):
    wtd = read_word_list(in_file)
    words = read_word_list(from_file)
    lang = get_lang_code(from_file)

    print("Removing words...")
    for w in tqdm.tqdm(wtd):
        words.remove(w)

    try:
       os.makedirs("output", exist_ok=True)
       with open(f"output/currated_words_{lang}.txt", "w", encoding='utf-8') as file:
            print(f"Writing invalid words to output/currated_words_{lang}.txt")
            for w in tqdm.tqdm(range(len(words))):
                file.write(words[w])
                if w < len(words) - 1:
                    file.write("\n")
    except Exception as e:
        print(f"Could not save the currated word list: {e}")

def check_word(word: str):
    for d in dicts:
        if d.check(word):
            return True
    
    return False

def double_check_words(invalid_words: list):
    truly_invalids = []

    for chunk in tqdm.tqdm(chunks(invalid_words, 500)):
        context = " ".join(chunk)
        res = tool.check(context)

        for match in res:
            if match.category != "TYPOS":
                continue
            
            end = context.find(" ", match.offset)
            truly_invalids.append(context[match.offset:(end if end != -1 else None)])

    return truly_invalids

def get_suggestions(word: str):
    suggestions = set()

    for d in dicts:
        s = d.suggest(word)
        for ss in s:
            suggestions.add(ss)

    return suggestions

if __name__ == "__main__":
    if args.f is None:
        print("No word list provided. Provide one with the -f flag.\nE.g: 'en.txt'")
        exit(1)

    file = args.f

    lang = get_lang_code(file)
    print(f"Detected language: {lang}")

    global dicts, tool
    dicts = get_dicts(lang)
    tool = language_tool_python.LanguageTool(lang)

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
            if not word_exists:
                print(f"Other suggestions: {get_suggestions(word)}")
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
