import QtQuick
import Felgo 4.0

// 僵尸
EntityBase {
    id: basiczombie

    // 僵尸的属性
    property real attack: 10
    property real speed: 80.0 * 33 / 1000 / 4.7
    property real health: 500
    property real yPositions: [100, 200, 300, 400, 500]
    property int currentYIndex: 2
    property bool isWalking1: true

    // 僵尸的外观
    AnimatedImage {
        id: zombieWalk1Animation
        source: "qrc:/ZombieWalk1.gif"
        fillMode: Image.PreserveAspectFit
        playing: isWalking1
        frameCount: 2
        currentFrame: 0
    }

    AnimatedImage {
        id: zombieWalk2Animation
        source: "qrc:/ZombieWalk2.gif"
        fillMode: Image.PreserveAspectFit
        playing: !isWalking1
        frameCount: 2
        currentFrame: 0
    }

    // 更新僵尸的位置
    function updatePosition() {
        x += (isWalking1 ? speed : -speed)
        y = yPositions[currentYIndex]
    }

    // 更新僵尸的动画
    Timer {
        interval: 250
        running: true
        repeat: true
        onTriggered: {
            updatePosition()
            isWalking1 = !isWalking1
            zombieWalk1Animation.currentFrame = (zombieWalk1Animation.currentFrame + 1) % zombieWalk1Animation.frameCount
            zombieWalk2Animation.currentFrame = (zombieWalk2Animation.currentFrame + 1) % zombieWalk2Animation.frameCount
        }
    }
}
