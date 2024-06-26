import Felgo 4.0
import QtQuick 2.0

Scene {
    id: menuScene

    // listen to the start button from anywhere, we use this to change the state in the GameWindow
    signal startPressed

    // background image for the menu
    Image {source:"../assets/img/titleScreen.png"; anchors.fill:parent}

    // background music for the menu
    BackgroundMusic {id: backgroundMusic; source:"../assets/snd/ZombieBreakTheme.mp3"}

    // custom play button
    Image {
        anchors.centerIn: parent
        source: Qt.resolvedUrl("../assets/img/playButton.png")
        MouseArea {
            // the mouse area fills the whole image
            anchors.fill: parent
            // when pressed we stop the music and call the signal startPressed
            onPressed: {
                //backgroundMusic.stop()
                startPressed()
            }
        }
    }
}
