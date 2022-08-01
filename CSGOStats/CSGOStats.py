

import requests
from bs4 import BeautifulSoup


class CSGOStats:

    def __init__(self, steam_id:str, detailsMatches:bool = True):
        self.steam_id = steam_id
        self.detailsMatches = detailsMatches

        self.url_overview = f"http://api.tracker.gg/api/v2/csgo/standard/profile/steam/{self.steam_id}?__cf_chl_f_tk=csgoStats"
        self.url_weapons = f"http://api.tracker.gg/api/v2/csgo/standard/profile/steam/{self.steam_id}/segments/weapon?__cf_chl_f_tk=csgoStats"
        self.url_maps = f"http://api.tracker.gg/api/v2/csgo/standard/profile/steam/{self.steam_id}/segments/map?__cf_chl_f_tk=csgoStats"

        self.month = { "fr" : ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"],
                       "en" : ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]}

        self.stats = self.getStats()


    def _get(self, url:str, cookies:dict = None):
        
        return requests.get(url, headers={"User-Agent": "Mozilla/5.0"},cookies=cookies)


    def getStats(self) -> dict:

        req = self._get(f"https://www.playerauctions.com/api/csgo/playerprofile?filter={self.steam_id}")
        self.steam_id = req.json()["result"]["steamid"]

        req = self._get(f"https://api.csgostats.gg/player/{self.steam_id}")

        

        soup = BeautifulSoup(req.text, "html.parser")
        scripts = soup.find_all("script")

        data = {}
        for i in scripts:
            if "var stats =" in i.text:
                data = eval(i.text.split("= ")[1].split(";")[0])
                data["name"] = soup.find("div", {"id": "player-name"}).text
                data["urlAvatar"] = soup.find("div", {"class": "player-ident-outer"}).find("img")["src"]
                data["rankImg"] = soup.find("div", {"class" : "player-ranks"}).find("img")["src"]
                data["mostInformation"] = f"https://api.csgostats.gg/player/{self.steam_id}"
                data["giveOnTheLastMatches"] = len(data["matches"])

                if self.detailsMatches:
                    for i in range(len(data["matches"])):
                        mapNum = str(data["matches"][i])
                        data["matches"][i] = self.getMatchsStats(f"https://api.csgostats.gg/match/{mapNum}")
                break
        data["globalStats"] = self.getOverview()
        
        listLastUpdate = data["last"].split("-")
        data["last"] = str(int(listLastUpdate[2].split(" ")[0])) + " " + self.month["en"][int(listLastUpdate[1])-1] + " " + listLastUpdate[0] + " | " + listLastUpdate[2].split(" ")[1]
        
        return data
    
    def getOverview(self):
        req = self._get(self.url_overview)
        return req.json()["data"]["segments"][0]["stats"]
    
    def getWeapons(self):
        req = self._get(self.url_weapons)
        self.stats["weapons"] = req.json()["data"]
        return req.json()
    
    def getMaps(self):
        req = self._get(self.url_maps)
        self.stats["maps"] = req.json()["data"]
        return req.json()



if __name__ == "__main__":

    player = CSGOStats("misterchaos192",detailsMatches=False)
    player.getStats()
    player.getWeapons()
    player.getMaps()
    print(player.stats["last"])
    #jsonString = json.dumps(player.stats)
    #jsonFile = open("data.json", "w")
    #jsonFile.write(jsonString)
    #jsonFile.close()



# url importante https://csgostats.gg/player/76561198184620681/ajax/played-with?vac=0&offset=0&mode=comp&date_start=&date_end=&order=games&source=csgo


