from os.path import basename

def read_word_list(file: str):
    try:
        with open(file, "r", encoding="utf-8") as fc:
            return fc.read().replace("\r\n", "\n").split("\n")

    except:
        print(f"ERROR: Unable to parse {file}")
        return []
    
def get_lang_code(file: str):
    return basename(file).replace(".txt", "")