import QtQuick 2.4
import com.canonical.Oxide 1.19
import Ubuntu.Components 1.3
import QtQuick.Window 2.1

Window {
    id: window

    color: "white"

    minimumWidth: units.gu(50)
    minimumHeight: units.gu(80)

    width: units.gu(80)
    height: units.gu(80)

    Component.onCompleted: {
        UbuntuApplication.applicationName = "sverzegnassi.hextris"
    }

    WebView {
        id: view
        anchors.fill: parent
        visible: view.loadProgress == 100

        url: Qt.resolvedUrl("www/index.html")

        // From Ogra's container
        preferences.localStorageEnabled: true
        preferences.allowFileAccessFromFileUrls: true
        preferences.allowUniversalAccessFromFileUrls: true
        preferences.appCacheEnabled: true

        context: WebContext { }
    }

    SplashScreen {
        anchors.fill: parent
        visible: !view.visible
        loadProgress: view.loadProgress
    }
}
