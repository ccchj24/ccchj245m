import Felgo 4.0
import QtQuick 2.0
import QtQuick.Controls
GameWindow {
    id: gameWindow

    Scene {
        id: gameScene
        // 示例僵尸类
        EntityBase {
            id: zombie
            entityType: "Zombie"
            width: 100
            height: 100
            x: 600
            y: 300


            // 检查僵尸是否进入左边界
            onXChanged: {
                gameLogic.checkZombiePosition(zombie)
            }

            Component.onCompleted: gameLogic.registerZombie(zombie)
            onDestroyed: gameLogic.unregisterZombie(zombie)
        }

        // 游戏失败动画
        Rectangle {
            id: gameOverScreen
            color: "black"
            opacity: 0
            anchors.fill: parent
            visible: false

            Text {
                text: "Game Over"
                color: "white"
                font.pixelSize: 50
                anchors.centerIn: parent
            }

            SequentialAnimation {
                id: gameOverAnimation
                NumberAnimation { target: gameOverScreen; property: "opacity"; to: 0.8; duration: 1000 }
                PauseAnimation { duration: 2000 }
                ScriptAction { script: { gameWindow.close() } }
            }
        }

        // 游戏胜利动画
        Rectangle {
            id: victoryScreen
            color: "green"
            opacity: 0
            anchors.fill: parent
            visible: false

            Text {
                text: "Victory!"
                color: "white"
                font.pixelSize: 50
                anchors.centerIn: parent
            }

            SequentialAnimation {
                id: victoryAnimation
                NumberAnimation { target: victoryScreen; property: "opacity"; to: 0.8; duration: 1000 }
                PauseAnimation { duration: 2000 }
                ScriptAction { script: { gameWindow.close() } }
            }
        }
    }

    // GameLogic类
    QtObject {
        id: gameLogic
        property int remainingZombies: 0

        function registerZombie(zombie) {
            remainingZombies++
        }

        function unregisterZombie(zombie) {
            remainingZombies--
            if (remainingZombies == 0) {
                victoryScreen.visible = true
                victoryAnimation.start()
            }
        }

        function checkZombiePosition(zombie) {
            if (zombie.x <= 0) {
                gameOverScreen.visible = true
                gameOverAnimation.start()
            }
        }
    }
}
