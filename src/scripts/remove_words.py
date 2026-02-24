import os
import tqdm

from word_list import get_lang_code, read_word_list

def remove_words(in_file: str, from_file: str):
    wtd = read_word_list(in_file)
    words = read_word_list(from_file)
    lang = get_lang_code(from_file)

    print("Removing words...")
    for w in tqdm.tqdm(wtd):
        try:
            words.remove(w)
        except:
            pass # ignore if w not in list already

    try:
       os.makedirs("output", exist_ok=True)
       with open(f"output/currated_words_{lang}.txt", "w", encoding='utf-8') as file:
            print(f"Writing new word list to output/currated_words_{lang}.txt")
            for w in range(len(words)):
                file.write(words[w])
                if w < len(words) - 1:
                    file.write("\n")
    except Exception as e:
        print(f"Could not save the currated word list: {e}")