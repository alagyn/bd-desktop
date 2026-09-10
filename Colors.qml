
pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    /* CSS HSL */
    /*
    --honey-bronze: hsla(37, 82%, 61%, 1);
    --amaranth: hsla(352, 60%, 55%, 1);
    --pale-sky: hsla(195, 34%, 82%, 1);
    --baltic-blue: hsla(207, 49%, 37%, 1);
    --yale-blue: hsla(200, 100%, 18%, 1);
    */
    // , #d1495b, #c0d8e0
    readonly property color bgPrimary: "#003D5B"
    readonly property color bgSecondary: "#30638e"
    readonly property color highlight: "#edae49"
    
    /*
    readonly property color bgPrimary: Qt.rgba(0.1, 0.2, 0.39, 1)
    readonly property color bgSecondary: Qt.rgba(0.33, 0.47, 0.87, 1)
    readonly property color highlight: Qt.rgba(0.98, 0.73, 0.36, 1)
    */
    readonly property color fgLight: Qt.rgba(1, 1, 1, 1)
    readonly property color fgDark: Qt.rgba(0, 0, 0, 1)

    readonly property real barInnerMargin: 20

    function multi_lerp(colors, t)
    {
        var idx = Math.floor(t * (colors.length - 1))
        if (idx == colors.length - 1)
        {
            idx -= 1
        }
        const chunk = 1 / colors.length
        const trueMin = idx * chunk
        const trueMax = trueMin + chunk
        const trueT = (t - trueMin) / (trueMax - trueMin)
        
        const c1 = colors[idx]
        const c2 = colors[idx + 1]

        if (c1 === undefined || c2 === undefined)
        {
            return "white"
        }

        return hsv_lerp(c1, c2, trueT)
    }

    function hsv_lerp(c1, c2, t)
    {
        const h = lerp(c1.hsvHue, c2.hsvHue, t)
        const s = lerp(c1.hsvSaturation, c2.hsvSaturation, t)
        const v = lerp(c1.hsvValue, c2.hsvValue, t)

        return Qt.hsva(h, s, v, 1)
    }

    function lerp(a, b, t)
    {
        return (b - a) * t + a
    }

}
