#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQuickView>
#include <QQmlContext>
#include <QDateTime>
#include <QQmlFileSelector>
#include <QFileInfo>

#include "deviceinterface.h"

#ifdef Q_OS_IOS
#include "iosutility.h"
#endif

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setOrganizationName("TaylorCunningham");
    app.setOrganizationDomain("taylor.cunningham");
    app.setApplicationName(QFileInfo(app.applicationFilePath()).baseName());

    QQuickView view;

    DeviceInterface *deviceInterface = new DeviceInterface();
    // Store this object in a static pointer so static methods can update the instance for permissions and stuff.
    DeviceInterface::m_instance = deviceInterface;
    // Check if notification permission is granted. If not, permissionGranted signal is connected to askNotificationPermission() and will ask.
    deviceInterface->checkNotificationsPermitted();
    // Store this object as a context property so QML can easily schedule/push notifications.
    view.engine()->rootContext()->setContextProperty(QLatin1String("DeviceInterface"),
                                                     deviceInterface);

    view.connect(view.engine(), SIGNAL(quit()), &app, SLOT(quit()));
    new QQmlFileSelector(view.engine(), &view);
    view.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    view.setResizeMode(QQuickView::SizeRootObjectToView);

    if (QGuiApplication::platformName() == QLatin1String("android") ||
          QGuiApplication::platformName() == QLatin1String("ios")) {
        view.showFullScreen();
    } else {
        qDebug() << "Not showing full screen";
        view.show();
    }

//    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
