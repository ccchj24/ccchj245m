import Felgo 4.0
import QtQuick 2.15
import QtQuick.Controls 2.0
GameWindow {
  id: gameWindow

  // 设置游戏状态
  property string gameState: "mainMenu"

  // 游戏场景
  Scene {
    id: gameScene

    // 示例的游戏元素，可以是玩家、敌人等
    Rectangle {
      width: 100
      height: 100
      color: "blue"
      anchors.centerIn: parent
      visible: gameWindow.gameState === "running"
    }

    // 暂停按钮
    Button {
      id: pauseButton
      text: "Pause"
      anchors.top: parent.top
      anchors.right: parent.right
      anchors.margins: 10

      onClicked: {
        gameWindow.gameState = "paused"
      }
    }

    // 暂停菜单
    Item {
      id: pauseMenu
      anchors.fill: parent
      visible: gameWindow.gameState === "paused"
      Rectangle {
        anchors.centerIn: parent
        width: 300
        height: 200
        color: "lightgray"
        border.color: "black"
        border.width: 2

        // 继续游戏按钮
        Button {
          text: "Resume"
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.top: parent.top
          anchors.margins: 20
          onClicked: {
            gameWindow.gameState = "running"
          }
        }

        // 退出游戏按钮
        Button {
          text: "Quit"
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.bottom: parent.bottom
          anchors.margins: 20
          onClicked: {
            Qt.quit()
          }
        }
      }
    }

    // 初始化游戏按钮
    Button {
      text: "Start Game"
      anchors.centerIn: parent
      visible: gameWindow.gameState === "mainMenu"
      onClicked: {
        gameWindow.gameState = "running"
      }
    }
  }

  // 主菜单页面
  MainMenu {
    id: mainMenu
    visible: gameWindow.gameState === "mainMenu"
    // 主菜单按钮等定义...

    // 返回主菜单按钮
    Button {
      text: "Return to Main Menu"
      anchors {
        horizontalCenter: parent.horizontalCenter
        bottom: parent.bottom
        margins: 20
      }
      onClicked: {
        gameWindow.gameState = "mainMenu"
      }
    }
  }
}
