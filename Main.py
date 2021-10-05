from DocPartExtractor import *

mainPath = r"C:\Users\Ali Sadeghi Aghili\Downloads\TestDit"

filesName = docNameExtractor(mainPath)

brokersIPPorts = {}

for fileName in filesName:
    rawText = docTextExtractor(mainPath, fileName)
    wantedText = wantedTextExtractor(rawText)
    destIPs = destIPExtractor(wantedText)
    ports = portExtractor(wantedText)
    brokerName = brokerNameExtractor(fileName)
    brokersIPPorts[brokerName] = {"IPs": DestIPs, "Ports": Ports}
    
resultMaker(mainDirPath, brokersIPPorts)