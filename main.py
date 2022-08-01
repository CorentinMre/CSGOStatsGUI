import sys
import os

from threading import Thread
import requests
from bs4 import BeautifulSoup
#Importing the 'CSGOStats' class
import CSGOStats

# IMPORT MODULES
from PySide6.QtGui import QGuiApplication, QIcon
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal

# Main Window Class
class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)


    # Signals To Send Data
    resultSearch = Signal('QVariant')
    error = Signal()
    playersFound = Signal(list)

    # Function Start Game
    @Slot(str)
    def search(self, namePlayer:str):

        def searchPlayer():
            try:
                def getSteamId(name:str):
                    nameForSteam = name.replace(" ", "+")
                    steam_url = f"https://steamcommunity.com/search/SearchCommunityAjax?text={nameForSteam}&filter=users&sessionid=csgostats&steamid_user=false"
                    req = requests.get(steam_url, headers={"User-Agent": "Mozilla/5.0"}, cookies= {"sessionid": "csgostats"})
                    html = req.json()["html"]
                    soup_object = BeautifulSoup(html, "html.parser")
                    playerInfos = soup_object.find_all("div",{"class":"search_row"})
                    playerFound = []
                    
                    for player in playerInfos:
                        playerFound.append({"name":player.find("a",{"class":"searchPersonaName"}).text,
                                            "description":player.find("div",{"class":"searchPersonaInfo"}).text,#html
                                            "avatarUrl":player.find("img")["src"],
                                            "steamid":player.find("a",{"class":"searchPersonaName"}).get("href").split("/")[-1]})
                    return playerFound

                
                playerFound = getSteamId(namePlayer)

                if playerFound != []:
                    self.playersFound.emit(playerFound)

            except:
                self.error.emit()


        thread = Thread(target=searchPlayer)
        thread.start()
    

    @Slot(str)
    def getInfoPlayer(self, steamId):

        def getInfoPlayer():
            try:
                player = CSGOStats.CSGOStats(steamId, detailsMatches=False)
                player.getWeapons()
                player.getMaps()
                self.resultSearch.emit(player.stats)
            except:
                self.error.emit()

        
        thread = Thread(target=getInfoPlayer)
        thread.start()

            
# INSTACE CLASS
if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    app.setWindowIcon(QIcon("images/stat.png"))
    engine = QQmlApplicationEngine()

    # Get Context
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)

    # Load QML File
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    # Check Exit App
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
