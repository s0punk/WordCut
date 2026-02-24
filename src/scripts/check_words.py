import os
import tqdm
from word_list import read_word_list, get_lang_code, chunks
from scripts import config

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
            for w in range(len(invalids)):
                file.write(invalids[w])
                if w < len(invalids) - 1:
                    file.write("\n")
    except Exception as e:
        print(f"Could not save the invalid word list: {e}")

    return invalids

def check_word(word: str):
    for d in config.dicts:
        if d.check(word):
            return True
    
    return False

def double_check_words(invalid_words: list):
    truly_invalids = []

    for chunk in tqdm.tqdm(chunks(invalid_words, 500)):
        truly_invalids.extend(check_spelling(chunk))
        truly_invalids.extend(check_proper_nouns(chunk))

    return truly_invalids

def check_spelling(invalid_words: list):
    misspelled_words = []

    context = " ".join(invalid_words)
    res = config.tool.check(context)

    for match in res:
        if match.category != "TYPOS":
            continue
        
        end = context.find(" ", match.offset)
        misspelled_words.append(context[match.offset:(end if end != -1 else None)])
    
    return misspelled_words

def check_proper_nouns(invalid_words: list):
    proper_nouns = []

    context = ". ".join(invalid_words)
    res = config.nlp(context)

    for token in res:
        if token.pos_ == "PROPN":
            proper_nouns.append(str(token))

    return proper_nouns