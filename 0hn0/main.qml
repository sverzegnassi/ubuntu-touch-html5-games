import QtQuick 2.4
import com.canonical.Oxide 1.19
import Ubuntu.Components 1.3
import QtQuick.Window 2.1

Window {
    id: window

    property string appId: "sverzegnassi.0hn0"

    color: "#FFFFFF"

    minimumWidth: units.gu(50)
    minimumHeight: units.gu(80)

    width: units.gu(80)
    height: units.gu(80)

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

        // From Ogra's container
        onNavigationRequested: {
            var url = request.url.toString();

            // Refuse request. Open all the link externally
            request.action = NavigationRequest.ActionReject
            console.warn("Opening remote: " + url);

            Qt.openUrlExternally(url)
        }

        context: WebContext {
            dataPath: "/home/phablet/.config/" + appId
            sessionCookieMode: {
                if (typeof webContextSessionCookieMode !== 'undefined') {
                    if (webContextSessionCookieMode === "persistent") {
                        return WebContext.SessionCookieModePersistent
                    } else if (webContextSessionCookieMode === "restored") {
                        return WebContext.SessionCookieModeRestored
                    }
                }
            }
        }
    }

    SplashScreen {
        anchors.fill: parent
        visible: !view.visible
        loadProgress: view.loadProgress
    }
}
