import Felgo 4.0
import QtQuick 2.0
import QtQuick.Controls 2.0

    Item {
      width: 800 // 根据您的游戏窗口宽度进行调整
      height: 120

      // 左侧：阳光显示
      Rectangle {
        width: 100
        height: 100
        color: "yellow"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        Text {
          text: "Sun: 1000" // 示例阳光点数，根据实际逻辑进行替换
          anchors.centerIn: parent
          font.bold: true
        }
      }

      // 植物卡片区域
      Row {
        anchors.fill: parent
        spacing: 10
        anchors.top: parent.top

        // 示例植物卡片（根据实际情况替换为 Card.qml 的使用）
        PlantCard {
          plantType: 0 // 示例植物类型，根据需要调整
          sunCost: 50 // 示例阳光成本，根据需要调整
        }

        PlantCard {
          plantType: 1 // 示例植物类型，根据需要调整
          sunCost: 100 // 示例阳光成本，根据需要调整
        }

        PlantCard {
          plantType: 2 // 示例植物类型，根据需要调整
          sunCost: 75 // 示例阳光成本，根据需要调整
        }

        // 根据需要添加更多的 PlantCard 组件
      }
    }

