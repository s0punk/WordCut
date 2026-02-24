import language_tool_python
import spacy

from word_list import get_dicts, get_spacy

# PyEnchant dicts loaded based on the user's file
dicts = None

# language_tool_python obj based on the user's file
tool = None

# Spacy obj based on the user's file
nlp = None

def setConfig(lang: str):
    dicts = get_dicts(lang)
    tool = language_tool_python.LanguageTool(lang)
    nlp = spacy.load(get_spacy(lang))