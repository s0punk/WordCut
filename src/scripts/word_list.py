from os.path import basename

import enchant

spacy = [
    "en_core_web_lg",
    "fr_core_news_lg",
]

def read_word_list(file: str):
    try:
        with open(file, "r", encoding="utf-8") as fc:
            return fc.read().replace("\r\n", "\n").split("\n")

    except Exception as e:
        print(f"Unable to parse {file}: {e}")
        return []
    
def get_lang_code(file: str):
    return basename(file).replace(".txt", "")

def get_dicts(lang: str):
    dicts = []
    broker = enchant.Broker()

    for l in broker.list_languages():
        if lang in l:
            dicts.append(enchant.Dict(l))

    return dicts

def get_spacy(lang: str):
    for s in spacy:
        if lang in s:
            return s
        
    return None

def chunks(lst, n):
    res = []
    for i in range(0, len(lst), n):
        res.append(lst[i:i + n])

    return res