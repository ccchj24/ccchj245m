import Felgo 4.0
import QtQuick 2.0

Item {
    // our GameScene will set the texts, so we make them public accessible
    property alias killedText : killed.text
    property alias cityText : city.text

    // display number of killed zombies
    Text {
        id: killed
        color: "red"
    }

    // display city name
    Text {
        id: gameMenu
        color: "red"
        anchors.right: parent.right
    }
    Button {
        anchors.right: parent.right
        anchors.top: parent.top
        text: "Game Menu"
        onClicked: {
            gameMenu.visible = true
            // 暂停游戏逻辑
        }
    }
}
