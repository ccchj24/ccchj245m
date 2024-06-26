import Felgo 4.0
import QtQuick 2.0
import QtQuick.Controls 2.0


EntityBase {
      id: plantCard
      entityType: "PlantCard"
      width: 100
      height: 120
      // 其他属性...

      MouseArea {
        anchors.fill: parent
        onClicked: {
          // 发出信号，通知游戏逻辑处理植物卡片的点击事件
          console.log("Plant card clicked for plant type:", plantType);
        }
      }

      Item {
        anchors.fill: parent
        opacity: 1 // 根据可用性或游戏逻辑调整不透明度

        Image {
          id: imgPlant
          source: "images/plant_" + plantType + ".png" // 假设植物图片的命名规则为 plant_0.png、plant_1.png 等
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.top: parent.top
        }

        Rectangle {
          id: cooldownOverlay
          width: parent.width
          height: parent.height
          color: "black"
          opacity: 0 // 初始完全透明
          radius: 5
          visible: false // 初始不可见

          Text {
            anchors.centerIn: parent
            text: "Cooldown" // 显示冷却状态或计时器
            color: "white"
            font.bold: true
          }
        }

        states: [
          State {
            name: "coolingDown"
            when: cooldownOverlay.visible
            PropertyChanges { target: cooldownOverlay; opacity: 0.5 }
            PropertyChanges { target: imgPlant; opacity: 0.5 }
          }
        ]

        transitions: [
          Transition {
            from: "*"
            to: "coolingDown"
            NumberAnimation { target: cooldownOverlay; property: "opacity"; duration: 1000; easing.type: Easing.InOutQuad; }
            NumberAnimation { target: imgPlant; property: "opacity"; duration: 1000; easing.type: Easing.InOutQuad; }
          }
        ]

        Component.onCompleted: {
          // 示例冷却效果触发
          // 这只是一个示例，实际逻辑取决于您的游戏实现
          // 假设冷却时间为毫秒
          cooldownOverlay.visible = true;
          cooldownOverlay.state = "coolingDown";
          setTimeout(function() {
            cooldownOverlay.visible = false;
          }, 5000); // 冷却时间为毫秒（在此示例中为5秒）
        }
      }
    }


