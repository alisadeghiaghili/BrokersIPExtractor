from os import listdir
from os.path import isfile, join
import win32com.client
import re

mainDirPath = r"C:\Users\Ali Sadeghi Aghili\Downloads\TestDit"
filesName = [fileName for fileName in listdir(mainDirPath) if (not fileName.startswith('~')) and fileName.endswith('.doc')]


brokersIPPorts = {}

for fileName in filesName:
    word = win32com.client.Dispatch("Word.Application")
    word.visible = False
    wb = word.Documents.Open(join(mainDirPath, fileName))
    doc = word.ActiveDocument
    text = doc.Range().text
    text = re.findall("Expire.*From Inside", text)[0].replace("From Inside", "")
    DestIPs = re.findall('\d{,3}\\.\d{,3}\\.\d{,3}\\.\d{,3}', text)[1::2]
    Ports = re.findall('11\d{3}', text)
    brokerName = re.findall("Kargozari.*", fileName)[0].replace('Kargozari', "").replace(".doc", "").strip()
    brokersIPPorts[brokerName] = {"IPs": DestIPs, "Ports": Ports}

with open(join(mainDirPath ,"brokersIPPorts.txt"), "w") as file:
    print(brokersIPPorts, file = file)