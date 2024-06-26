import Felgo 4.0
import QtQuick 2.0
import QtQuick.Controls 2.0

EntityBase {
    id: zombie

    // 僵尸的属性
    property var head: null
    property int hp: 500
    property int atk: 10
    property int state: 0
    property real speed: 80.0 * 33 / 1000 / 4.7
    property bool attack: false
    property bool beAttacked: false
    property bool dead: false
    property int line: 1
    property var yPositions: [100, 200, 300, 400, 500]
    property int z_x: Math.floor(x / 10)
    property int zombiesSpawned: 0

    // 边界矩形
    function boundingRect() {
        return Qt.rect(-80, -100, 200, 140);
    }

    // 绘制僵尸
    function paint(painter) {
        // 绘制逻辑
    }
    // 僵尸与植物子弹的碰撞检测
    function bulletCollision(bullet) {
        return bullet.type === "Bullet" && Math.abs(bullet.y - y) < 30 && Math.abs(bullet.x - x) < 30;
    }

    // 检测僵尸与植物子弹的碰撞并开始攻击
    function checkBulletCollision(bullets) {
        for (var i = 0; i < bullets.length; i++) {
            if (bulletCollision(bullets[i])) {
                beAttacked = true;
                hp -= bullets[i].damage;
                if (hp <= 0) {
                    dead = true;
                    // 在这里添加僵尸死亡的逻辑
                }
                bullets[i].destroy();
                break;
            }
        }
    }

    // 僵尸攻击植物的碰撞检测
    function plantCollision(plant) {
        return plant.type === "Plant" && Math.abs(plant.y - y) < 30 && Math.abs(plant.x - x) < 30;
    }

    // 检测僵尸与植物的碰撞并开始攻击
    function checkPlantCollision(plants) {
        for (var i = 0; i < plants.length; i++) {
            if (plantCollision(plants[i])) {
                attack = true;
                attackDetect();
                plants[i].hp -= atk;
                if (plants[i].hp <= 0) {
                    plants[i].destroy();
                }
                break;
            } else {
                attack = false;
                attackDetect();
            }
        }
    }

    // 僵尸实体
    AnimatedImage {
        id: zombieAnimation
        source: dead ? "" : "res/images/zombie/Zombie/Zombie.gif"
        playing: !dead

        // 移动动画
        NumberAnimation on x {
            id: move
            to: 0
            running: !dead
            duration: speed
        }

        // 死亡动画
        SequentialAnimation {
            id: deadAnimation
            NumberAnimation {
                target: zombieAnimation
                property: "opacity"
                to: 0
                duration: 1000
            }
            NumberAnimation {
                target: deadBody
                property: "opacity"
                to: 1
                duration: 1000
            }
            NumberAnimation {
                target: deadHead
                property: "opacity"
                to: 1
                duration: 1000
            }
            onStopped: {
                deadBody.source = ""
                deadHead.source = ""
            }
        }

        // 随机生成僵尸
        Timer {
            id: spawnTimer
            interval: Math.random() * 10000 + 5000 // 随机时间生成僵尸
            repeat: true
            running: true
            onTriggered: {
                if (zombiesSpawned < 5 || gameTimer.gameTime < 60000) {
                    // 生成普通僵尸
                    console.log("生成普通僵尸");
                    // 在这里添加生成僵尸的逻辑
                    zombiesSpawned++;
                } else {
                    // 生成其他类型的僵尸
                    console.log("生成其他类型的僵尸");
                    // 在这里添加生成僵尸的逻辑
                }
            }
        }

        // 记录游戏时间
        Timer {
            id: gameTimer
            interval: 1000
            repeat: true
            property int gameTime: 0
            onTriggered: {
                gameTime += 1000;
            }
        }
    }
}
