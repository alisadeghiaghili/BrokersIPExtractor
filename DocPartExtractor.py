import re
import win32com.client
from os.path import join
from os import listdir

def docNameExtractor(mainDirPath):   
    filesName = [fileName for fileName in listdir(mainDirPath) if (not fileName.startswith('~')) and fileName.endswith('.doc')]
    return filesName 

def docTextExtractor(mainDirPath, fileName):
    word = win32com.client.Dispatch("Word.Application")
    word.visible = False
    wb = word.Documents.Open(join(mainDirPath, fileName))
    doc = word.ActiveDocument
    text = doc.Range().text
    return text

def wantedTextExtractor(rawText):
    wantedText = re.findall("Expire.*From Inside", rawText)[0].replace("From Inside", "")
    return wantedText 

def destIPExtractor(wantedText): 
    destIPs = re.findall('\d{,3}\\.\d{,3}\\.\d{,3}\\.\d{,3}', wantedText)[1::2]
    return destIPs

def portExtractor(wantedText):
    ports = re.findall('11\d{3}', wantedText)
    return ports

def brokerNameExtractor(fileName):
    brokerName = re.findall("Kargozari.*", fileName)[0].replace('Kargozari', "").replace(".doc", "").strip()
    return brokerName 

def resultMaker(mainDirPath, brokersIPPorts):
    with open(join(mainDirPath ,"brokersIPPorts.txt"), "w") as file:
        print(brokersIPPorts, file = file)