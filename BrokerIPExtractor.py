from os import listdir
from os.path import isfile, join
import win32com.client
import re
import pandas as pd

mainDirPath = "D:\BrokersIPs"
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
    brokerName = re.sub(r"Port (Openining|Opening) Form.*\d+[ -]+", "", fileName).replace('Kargozari', "").replace(".doc", "").replace(".docx", "").strip()
    brokersIPPorts[brokerName] = {"IPs": DestIPs, "Ports": Ports}

with open(join(mainDirPath ,"brokersIPPorts.txt"), "w") as file:
    print(brokersIPPorts, file = file)
    
dataFrame = pd.DataFrame(brokersIPPorts).transpose().to_csv(join(mainDirPath ,"brokersIPPorts.csv"), sep = ",")
