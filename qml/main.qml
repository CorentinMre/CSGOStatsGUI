import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Timeline 1.0
import "controls"

Window{
    id: window
    width: 1000
    height: 600
    maximumWidth: 1000
    maximumHeight : 600
    x : Screen.width / 2 - width / 2
    y : Screen.height / 2 - height / 2
    visible: true
    color: "#00ffffff"
    title: qsTr("CSGOStats")

    // SET FLAGS
    flags: Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint | Qt.CustomizeWindowHint  | Qt.WindowTitleHint | Qt.Window | Qt.FramelessWindowHint

    // SET MATERIAL STYLE
    Material.theme: Material.Dark
    Material.accent: Material.LightBlue
    FontLoader { id: alfaSlabOneFont; source: "../images/fonts/Alfa_Slab_One/AlfaSlabOne.ttf" }

    // Internal functions
    QtObject{
        id: internal


        function search(){
            blockLoader.visible = true
            backend.search(inputNamePlayer.text)
        }

        function getStats(steamid){
            blockLoader.visible = true
            backend.getInfoPlayer(steamid)
        }
    }

    Image {
        id: background
        x: 0
        y: 35
        anchors.fill: parent
        source: "../images/bg.jpg"
        fillMode: Image.TileHorizontally



        Rectangle {
            id: recHome
            x: 285
            y: 35
            width: 431
            height: 565
            visible: true
            color: "#00ffffff"

            Rectangle {
                id: recLogo
                x: 60
                height: 207
                opacity: 0
                visible: true
                color: "#9069fa"
                radius: 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 60
                anchors.leftMargin: 105
                anchors.topMargin: 31
                anchors.rightMargin: 105

                Image{
                    id: imgLogo
                    x: 78
                    y: 23
                    width: 163
                    height: 140
                    source: "../images/stat.png"
                    anchors.horizontalCenterOffset: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 15
                }

                Text{
                    id: lblNameApp
                    x: 79
                    y: 158
                    width: 214
                    height: 63
                    text: qsTr("CSGO Statistics")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font { family: alfaSlabOneFont.name; pointSize: 17}
                    anchors.verticalCenterOffset: 72
                    anchors.horizontalCenterOffset: -2
                    color: "#ffffff"
                    anchors.horizontalCenter: parent.horizontalCenter

                }
            }

            Button {
                id: btnSearch
                y: 315
                width: 98
                height: 46
                opacity: 1
                text: qsTr("Rechercher")
                anchors.bottom: parent.bottom
                anchors.horizontalCenterOffset: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 204
                z: 0
                onClicked: internal.search()
            }
            BlockLoader {
                id: blockLoader
                x: 174
                y: 375
                width: 69
                height: 34
                opacity: 1
                visible: false
                spacing: 4
                verticalBlockCount: 2
                horizontalBlockCount: 3
            }

            Rectangle {
                id: recNameOfRec
                x: 68
                y: 489
                height: 40
                opacity: 1
                color: "#9069fa"
                radius: 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 60
                anchors.rightMargin: 59
                anchors.topMargin: 503
                anchors.leftMargin: 61

                Text {
                    id: lblNameOfRec
                    x: 75
                    y: -39
                    width: 250
                    height: 40
                    color: "#ffffff"
                    text: qsTr("Ozirys Production")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.verticalCenterOffset: 0
                    anchors.horizontalCenterOffset: 0
                    font.pointSize: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            TextField {
                id: inputNamePlayer
                y: 265
                width: 175
                height: 44
                opacity: 1
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Nom du joueur")
                onAccepted : internal.search()
            }

            Rectangle {
                id: recError
                x: 75
                y: 498
                height: 34
                visible: false
                color: "#ff065b"
                radius: 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 60
                Text {
                    id: lblError
                    x: 75
                    y: -39
                    color: "#ffffff"
                    text: qsTr("Le profil du joueur est privé")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 10
                }

                Rectangle {
                    id: rectangle
                    x: 219
                    y: -11
                    width: 20
                    height: 19
                    color: "#9069fa"
                    radius: 10

                    Button {
                        id: btnCloseError
                        x: 0
                        y: -3
                        width: 20
                        height: 26
                        opacity: 1
                        text: "\u2715"
                        flat: true
                        down: false
                        font.italic: false
                        font.pointSize: 17
                        z: 0
                        font.family: "ChromiumAATTest"
                        font.bold: false
                        onClicked: recError.visible = false
                    }
                }

                anchors.rightMargin: 102
                anchors.topMargin: 439
                anchors.leftMargin: 102
            }





        }




        Rectangle {
            id: recInfoPlayer
            visible: false
            color: "#00ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 437
            anchors.bottomMargin: 0
            anchors.topMargin: 35

            Button {
                id: btnMaps
                x: 476
                width: 79
                height: 37
                opacity: 1
                text: qsTr("Maps")
                anchors.top: parent.top
                anchors.topMargin: 0
                z: 0
                onClicked: {
                    recStatistics.visible = false
                    recOverview.visible = false
                    recWeapons.visible = false
                    recMaps.visible = true
                }
            }

            Button {
                id: btnWeapons
                x: 364
                width: 106
                height: 37
                opacity: 1
                text: qsTr("Weapons")
                anchors.top: parent.top
                anchors.topMargin: 0
                z: 0
                onClicked: {
                    recMaps.visible = false
                    recStatistics.visible = false
                    recOverview.visible = false
                    recWeapons.visible = true
                }
            }

            ToolSeparator {
                id: toolSeparator
                x: 0
                y: -8
                width: 25
                height: 573
            }

            Text {
                id: lblNamePlayer
                x: 75
                y: -39
                width: 75
                height: 24
                color: "#ffffff"
                text: "Player"
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                font.family: "Alfa Slab One"
                anchors.verticalCenterOffset: -201
                font.pointSize: 15
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -115
            }

            Image {
                id: imgAvarar
                x: 23
                y: 16
                width: 100
                height: 100
                source: ""

            }

            Text {
                id: lblBasicInfo
                x: 129
                y: 103
                width: 213
                height: 13
                color: "#ffffff"
                text: qsTr("informations")
                verticalAlignment: Text.AlignBottom
                font.pointSize: 13
                font.bold: false
            }

            Button {
                id: btnStatistics
                x: 248
                width: 106
                height: 37
                opacity: 1
                text: qsTr("Statistics")
                anchors.top: parent.top
                anchors.topMargin: 0
                z: 0
                onClicked: {
                    recOverview.visible = false
                    recMaps.visible = false
                    recWeapons.visible = false
                    recStatistics.visible = true
                }
            }

            Button {
                id: btnOverview
                x: 129
                width: 106
                height: 37
                opacity: 1
                text: qsTr("Overview")
                anchors.top: parent.top
                anchors.topMargin: 0
                z: 0
                onClicked: {
                    recMaps.visible = false
                    recWeapons.visible = false
                    recStatistics.visible = false
                    recOverview.visible = true
                }
            }

            Rectangle {
                id: recOverview
                x: 15
                y: 128
                width: 548
                height: 433
                visible: false
                color: "#00ffffff"

                Rectangle {
                    id: reclblOverview
                    x: 0
                    y: 12
                    height: 32
                    color: "#9069fa"
                    radius: 0
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 60
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    Text {
                        id: lblInfo
                        color: "#ffffff"
                        text: "Overview"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                        font.pointSize: 10
                    }
                }

                Text {
                    id: lblKd
                    x: 17
                    y: 87
                    width: 93
                    height: 46
                    color: "#e09f44"
                    text: qsTr("K/D:")
                    font.pixelSize: 40
                    font.italic: true
                }

                Text {
                    id: lblResultKD
                    x: 22
                    y: 154
                    width: 116
                    height: 51
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 45
                    maximumLineCount: 5
                    font.bold: true
                }

                Text {
                    id: lblHeadshot
                    x: 255
                    y: 87
                    width: 263
                    height: 46
                    color: "#e09f44"
                    text: qsTr("HEADSHOT%:")
                    font.pixelSize: 40
                    font.italic: true
                }

                Text {
                    id: lblResultHeadshot
                    x: 255
                    y: 154
                    width: 116
                    height: 51
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 45
                    font.bold: true
                }

                Text {
                    id: lblWin
                    x: 17
                    y: 274
                    width: 93
                    height: 46
                    color: "#e09f44"
                    text: qsTr("WIN%:")
                    font.pixelSize: 40
                    font.italic: true
                }

                Text {
                    id: lblResultWin
                    x: 22
                    y: 341
                    width: 116
                    height: 51
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 45
                    font.bold: true
                }

                Text {
                    id: lblAccuracy
                    x: 255
                    y: 274
                    width: 263
                    height: 46
                    color: "#e09f44"
                    text: qsTr("ACCURACY%:")
                    font.pixelSize: 40
                    font.italic: true
                }

                Text {
                    id: lblResultAccuracy
                    x: 255
                    y: 341
                    width: 116
                    height: 51
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 45
                    font.bold: true
                }

                ToolSeparator {
                    id: toolSeparator1
                    x: 209
                    y: 75
                    width: 25
                    height: 304
                }

                ToolSeparator {
                    id: toolSeparator2
                    x: 232
                    y: 29
                    width: 25
                    height: 419
                    rotation: 90
                }
            }

            Rectangle {
                id: recStatistics
                x: 15
                y: 128
                width: 548
                height: 433
                visible: false
                color: "#00ffffff"
                Rectangle {
                    id: reclblStatistics
                    x: 0
                    y: 12
                    height: 32
                    color: "#9069fa"
                    radius: 0
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 60
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    Text {
                        id: lblInfo1
                        color: "#ffffff"
                        text: "Statistics"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                        font.pointSize: 10
                    }
                    anchors.topMargin: 0
                }

                Text {
                    id: lblScore
                    x: 8
                    y: 59
                    width: 64
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Score:")
                    font.pixelSize: 15
                    font.italic: true
                }

                Text {
                    id: lblDeath
                    x: 144
                    y: 59
                    width: 64
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Death:")
                    font.pixelSize: 15
                    font.italic: true
                }

                Text {
                    id: lblDamage
                    x: 286
                    y: 59
                    width: 64
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Damage:")
                    font.pixelSize: 15
                    font.italic: true
                }

                Text {
                    id: lblShotFired
                    x: 288
                    y: 253
                    width: 88
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Shots fired:")
                    font.pixelSize: 15
                    font.italic: true
                }

                Text {
                    id: lblShotHit
                    x: 421
                    width: 64
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Shot hit:")
                    anchors.top: lblScore.bottom
                    font.pixelSize: 15
                    anchors.topMargin: 167
                    font.italic: true
                }

                Text {
                    id: lblSniperKilled
                    x: 144
                    width: 100
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Sniper killed:")
                    anchors.top: lblDeath.bottom
                    font.pixelSize: 15
                    anchors.topMargin: 70
                    font.italic: true
                }

                Text {
                    id: lblBombPlanted
                    x: 288
                    width: 118
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Bomb planted:")
                    anchors.top: lblDamage.bottom
                    font.pixelSize: 15
                    anchors.topMargin: 70
                    font.italic: true
                }

                Text {
                    id: lblBombDefused
                    x: 429
                    y: 157
                    width: 111
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Bomb defuse:")
                    font.pixelSize: 15
                    font.italic: true
                }

                Text {
                    id: lblMoneyEarned
                    x: 8
                    y: 253
                    width: 118
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Money earned:")
                    font.pixelSize: 15
                    font.italic: true
                }

                Text {
                    id: lblHostageRecused
                    x: 132
                    width: 113
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Hostages Rescued:")
                    anchors.top: lblSniperKilled.bottom
                    font.pixelSize: 15
                    anchors.topMargin: 70
                    font.italic: true
                }

                Text {
                    id: lblMVP
                    x: 8
                    width: 64
                    height: 27
                    color: "#e09f44"
                    text: qsTr("MVP:")
                    anchors.top: lblBombPlanted.bottom
                    font.pixelSize: 15
                    anchors.topMargin: -27
                    font.italic: true
                }

                Text {
                    id: lblWins
                    x: 8
                    width: 52
                    height: 22
                    color: "#e09f44"
                    text: qsTr("Wins:")
                    anchors.top: lblBombDefused.bottom
                    font.pixelSize: 15
                    anchors.topMargin: 167
                    font.italic: true
                }

                Text {
                    id: lblLosses
                    x: 144
                    width: 64
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Losses:")
                    anchors.top: lblMoneyEarned.bottom
                    font.pixelSize: 15
                    anchors.topMargin: 70
                    font.italic: true
                }

                Text {
                    id: lblMatchesPlayed
                    x: 280
                    width: 100
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Matches played:")
                    anchors.top: lblHostageRecused.bottom
                    font.pixelSize: 15
                    anchors.topMargin: 70
                    font.italic: true
                }

                Text {
                    id: lblRoundPlayed
                    x: 421
                    y: 350
                    width: 118
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Round played:")
                    font.pixelSize: 15
                    font.italic: true
                }

                ToolSeparator {
                    id: toolSeparator3
                    x: 118
                    y: 38
                    width: 25
                    height: 395
                }

                ToolSeparator {
                    id: toolSeparator4
                    x: 257
                    y: 38
                    width: 25
                    height: 395
                }

                ToolSeparator {
                    id: toolSeparator5
                    x: 399
                    y: 38
                    width: 25
                    height: 395
                }

                Text {
                    id: lblResultScore
                    x: 13
                    y: 92
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultDeath
                    x: 144
                    y: 92
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultDamage
                    x: 288
                    y: 92
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultHeadshotNb
                    x: 421
                    y: 92
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblDamage1
                    x: 421
                    y: 59
                    width: 64
                    height: 27
                    color: "#e09f44"
                    text: qsTr("Headshots:")
                    font.pixelSize: 15
                    font.italic: true
                }

                Text {
                    id: lblResultMVP
                    x: 13
                    y: 195
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultSniperKilled
                    x: 144
                    y: 195
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultBombPlanted
                    x: 288
                    y: 195
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultBombDefused
                    x: 421
                    y: 195
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultMoneyEarned
                    x: 13
                    y: 286
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultHostageRecused
                    x: 144
                    y: 286
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultShotFired
                    x: 288
                    y: 286
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultShotsHit
                    x: 421
                    y: 286
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultWins
                    x: 13
                    y: 389
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultLosses
                    x: 144
                    y: 389
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultMatchesPlayed
                    x: 288
                    y: 389
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }

                Text {
                    id: lblResultRoundPlayed
                    x: 421
                    y: 389
                    width: 72
                    height: 30
                    color: "#ffffff"
                    text: qsTr("1.41")
                    font.pixelSize: 25
                    minimumPixelSize: 15
                    fontSizeMode: Text.Fit
                    font.bold: true
                }
            }

            Rectangle {
                id: recWeapons
                x: 15
                y: 128
                width: 548
                height: 433
                visible: false
                color: "#00ffffff"
                clip: true

                ScrollView {
                    x: 0
                    y: 38
                    width: 548
                    height: 400

                    Column {
                        x: 8
                        y: 3
                        spacing: 2

                        Repeater {
                            id: repeaterWeapons
                            model: [{

                                    "metadata": {
                                        "name": "AK-47",
                                        "imageUrl": "https://trackercdn.com/cdn/tracker.gg/csgo/weapons/197_icon-ak47.png"
                                    },
                                    "stats": {
                                        "kills": {
                                            "displayValue": "470"
                                        },
                                        "shotsFired": {
                                            "displayValue": "10,462"
                                        },
                                        "shotsHit": {
                                            "displayValue": "1,597"
                                        },
                                        "shotsAccuracy": {
                                            "displayValue": "15.3%"
                                        }
                                    }
                                }]

                            Rectangle {
                                width: 530
                                height: 70
                                color: "#00000000"
                                border.color: "#9069fa"
                                Image {
                                    x:5
                                    y:8
                                    width: 70
                                    height: 32
                                    source: modelData["metadata"]["imageUrl"].replace("https","http")
                                }
                                Text {
                                    x:20
                                    y:45
                                    color: "#ffffff"
                                    text: modelData["metadata"]["name"]
                                }


                                Text {
                                    x:140
                                    y:15
                                    color: "#ffffff"
                                    text: modelData["stats"]["kills"]["displayValue"]+ " Kills"
                                }
                                Text {
                                    x:140
                                    y:45
                                    color: "#ffffff"
                                    text: modelData["stats"]["shotsFired"]["displayValue"]+ " Shots Fired"
                                }
                                Text {
                                    x:300
                                    y:15
                                    color: "#ffffff"
                                    text: modelData["stats"]["shotsHit"]["displayValue"]+ " Shots Hit"
                                }
                                Text {
                                    x:300
                                    y:45
                                    color: "#ffffff"
                                    text: modelData["stats"]["shotsAccuracy"]["displayValue"]+ " Shots Accuracy"
                                }
                            }


                        }

                    }
                }
                Rectangle {
                    id: reclblWeapons
                    x: 0
                    y: 12
                    height: 32
                    color: "#9069fa"
                    radius: 0
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 60
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    Text {
                        id: lblInfo2
                        color: "#ffffff"
                        text: "Weapons"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                        font.pointSize: 10
                    }
                    anchors.topMargin: 0
                }


            }

            Text {
                id: lblLastUpdate
                x: 129
                y: 43
                width: 252
                height: 21
                color: "#ffffff"
                text: qsTr("Last update: ")
                font.pixelSize: 13
                verticalAlignment: Text.AlignBottom
            }

            Image {
                id: imgRank
                x: 455
                y: 66
                width: 88
                height: 35
                source: ""
            }

            Rectangle {
                id: recMaps
                x: 15
                y: 128
                width: 548
                height: 433
                visible: false
                color: "#00ffffff"
                clip: true
                ScrollView {
                    x: 0
                    y: 38
                    width: 548
                    height: 400
                    Column {
                        x: 8
                        y: 3
                        Repeater {
                            id: repeaterMaps
                            model: [{

                                    "metadata": {
                                        "name": "AK-47",
                                        "imageUrl": "https://trackercdn.com/cdn/tracker.gg/csgo/maps/ar_baggage.jpg"
                                    },
                                    "stats": {
                                        "rounds": {
                                            "displayValue": "22"
                                        },
                                        "wins": {
                                            "displayValue": "4"
                                        }
                                    }
                                }]
                            Rectangle {
                                width: 530
                                height: 70
                                color: "#00000000"
                                border.color: "#9069fa"
                                Image {
                                    x: 5
                                    y: 8
                                    width: 120
                                    height: 60
                                    source: modelData["metadata"]["imageUrl"].replace("https","http")
                                }

                                Text {
                                    x: 130
                                    y: 30
                                    color: "#ffffff"
                                    text: modelData["metadata"]["name"]
                                }

                                Text {
                                    x: 250
                                    y: 30
                                    color: "#ffffff"
                                    text: modelData["stats"]["rounds"]["displayValue"]+ " Rounds"
                                }
                                Text {
                                    x: 400
                                    y: 30
                                    color: "#ffffff"
                                    text: modelData["stats"]["wins"]["displayValue"]+ " Wins"
                                }

                            }

                        }
                        spacing: 2
                    }
                }

                Rectangle {
                    id: reclblMaps
                    x: 0
                    y: 12
                    height: 32
                    color: "#9069fa"
                    radius: 0
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 60
                    Text {
                        id: lblInfo4
                        color: "#ffffff"
                        text: "Maps"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                        font.pointSize: 10
                    }
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                }
            }

        }

        Rectangle {
            id: recPlayersFound
            visible: false
            color: "#00ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 437
            anchors.bottomMargin: 0
            anchors.topMargin: 35
            anchors.rightMargin: 0

            ScrollView {
                x: 8
                y: 14
                width: 547
                height: 543
                Column {
                    x: 15
                    y: 3
                    Repeater {
                        id: repeaterPlayersFound
                        Rectangle {
                            width: 530
                            height: 70
                            color: "#00000000"
                            border.color: "#9069fa"
                            Button{
                                anchors.fill: parent
                                flat: true
                                onClicked: internal.getStats(modelData["steamid"])
                                Image {
                                    x: 5
                                    y: 8
                                    width: 55
                                    height: 55
                                    source: modelData["avatarUrl"].replace("https","http")
                                }

                                Text {
                                    x: 70
                                    y: 30
                                    color: "#ffffff"
                                    text: modelData["name"]
                                }

                                //Text {
                               //     x: 70
                             //       y: 30
                              //      color: "#ffffff"
                              //      text: "Description: " + modelData["description"]
                             //   }


                            }


                        }
                        model: [{"name": "AK-47", "description":"Leo Urahara", "avatarUrl": "https://avatars.akamai.steamstatic.com/07c6992293fe0088dc1826fffcfcf7bd89ff2ba9_medium.jpg"}]
                    }
                    spacing: 2
                }
            }

            ToolSeparator {
                id: toolSeparator6
                x: 0
                y: -8
                width: 25
                height: 573
            }
        }

        Rectangle {
            id: recTopBar
            x: 0
            y: 0
            width: 400
            height: 35
            color: "#151515"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top


            Image {
                id: iconApp
                width: 36
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                source: "../images/stat.png"
                anchors.leftMargin: 3
                anchors.bottomMargin: 3
                anchors.topMargin: 3
                fillMode: Image.PreserveAspectFit
            }

            Rectangle {
                id: recBtns
                x: 330
                width: 70
                height: 35
                visible: true
                color: "#00ffffff"
                anchors.right: parent.right
                anchors.top: parent.top

                Button {
                    id: btnMin
                    width: 35
                    height: 47
                    opacity: 1
                    text: qsTr("—")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    font.underline: false
                    font.strikeout: false
                    flat: true
                    font.italic: true
                    font.bold: true
                    font.family: "LED Real"
                    font.pointSize: 15
                    anchors.leftMargin: 0
                    z: 0
                    onClicked: window.showMinimized()
                }

                Button {
                    id: btnClose
                    x: 35
                    width: 35
                    height: 47
                    opacity: 1
                    text: "\u2715"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    down: false
                    flat: true
                    font.italic: false
                    font.bold: false
                    font.pointSize: 17
                    font.family: "ChromiumAATTest"
                    anchors.rightMargin: 0
                    z: 0
                    onClicked: window.close()
                }
            }

            Label {
                id: lblNameOfGame
                color: "#c3cbdd"
                text: qsTr("CSGOStats")
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 70
                anchors.leftMargin: 45
                font.pointSize: 10
            }

            DragHandler {
                onActiveChanged: if(active){
                                     window.startSystemMove()
                                 }
            }

        }


        PropertyAnimation{
            id: moveRecHome
            target: recHome
            properties: "x"
            to: 0
            duration: 1000
            easing.type: Easing.OutQuint
        }

    }//end backgroundImage

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                running: true
                duration: 1000
                loops: 1
                to: 1000
                from: 0
            }
        ]
        startFrame: 0
        endFrame: 2000
        enabled: true

        KeyframeGroup {
            target: recLogo
            property: "opacity"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 436
                value: 1
            }
        }

        KeyframeGroup {
            target: inputNamePlayer
            property: "opacity"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 544
                value: 1
            }
        }

        KeyframeGroup {
            target: btnSearch
            property: "opacity"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 628
                value: 1
            }
        }

        KeyframeGroup {
            target: recNameOfRec
            property: "opacity"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 763
                value: 1
            }
        }

    }


    Connections {
        target: backend

        function onError(){
            blockLoader.visible = false
            recError.visible = true
        }

        function onPlayersFound(data){
            recInfoPlayer.visible = false
            blockLoader.visible = false
            moveRecHome.running = true
            repeaterPlayersFound.model = data
            recPlayersFound.visible = true
        }


        function onResultSearch(data){
            recPlayersFound.visible = false
            blockLoader.visible = false
            
            ////////////////////////////////////

            recStatistics.visible = false
            recWeapons.visible = false
            recMaps.visible = false
            recInfoPlayer.visible = true
            recOverview.visible = true

            // console.log(dict(data))
            lblNamePlayer.text = data["name"]
            imgAvarar.source = data["urlAvatar"].replace("https","http")
            lblLastUpdate.text = "Last update: " + data["last"]
            imgRank.source = "../images/rankImg/"+data["rank"]+".png"
            lblBasicInfo.text = data["globalStats"]["timePlayed"]["displayValue"] + " | " + data["globalStats"]["wins"]["displayValue"] + " Wins | " + data["globalStats"]["kills"]["displayValue"]+ " Kills"
            lblResultKD.text = data["globalStats"]["kd"]["displayValue"]
            lblResultHeadshot.text = data["globalStats"]["headshotPct"]["displayValue"]
            lblResultWin.text = data["globalStats"]["wlPercentage"]["displayValue"]
            lblResultAccuracy.text = data["globalStats"]["shotsAccuracy"]["displayValue"]

            //Statistics

            lblResultScore.text = data["globalStats"]["score"]["displayValue"]
            lblResultDeath.text = data["globalStats"]["deaths"]["displayValue"]
            lblResultDamage.text = data["globalStats"]["damage"]["displayValue"]
            lblResultHeadshotNb.text = data["globalStats"]["headshots"]["displayValue"]
            lblResultMVP.text = data["globalStats"]["mvp"]["displayValue"]
            lblResultSniperKilled.text = data["globalStats"]["snipersKilled"]["displayValue"]
            lblResultBombPlanted.text = data["globalStats"]["bombsPlanted"]["displayValue"]
            lblResultBombDefused.text = data["globalStats"]["bombsDefused"]["displayValue"]
            lblResultMoneyEarned.text = data["globalStats"]["moneyEarned"]["displayValue"]
            lblResultHostageRecused.text = data["globalStats"]["hostagesRescued"]["displayValue"]
            lblResultShotFired.text = data["globalStats"]["shotsFired"]["displayValue"]
            lblResultShotsHit.text = data["globalStats"]["shotsHit"]["displayValue"]
            lblResultWins.text = data["globalStats"]["wins"]["displayValue"]
            lblResultLosses.text = data["globalStats"]["losses"]["displayValue"]
            lblResultMatchesPlayed.text = data["globalStats"]["matchesPlayed"]["displayValue"]
            lblResultRoundPlayed.text = data["globalStats"]["roundsPlayed"]["displayValue"]

            //Weapons

            repeaterWeapons.model = data["weapons"]

            //Maps

            repeaterMaps.model = data["maps"]
        }

    }

}
/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}D{i:111}D{i:120}
}
##^##*/
