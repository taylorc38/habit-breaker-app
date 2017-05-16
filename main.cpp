#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQuickView>
#include <QQmlContext>
#include <QDateTime>
#include <QQmlFileSelector>
#include <QFileInfo>
#include <QDir>
#include <QCryptographicHash>

#include "sqlmodel.h"
#include "iosutility.h"
#import <QStandardPaths>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setOrganizationName("TaylorCunningham");
    app.setOrganizationDomain("taylor.cunningham");
    app.setApplicationName(QFileInfo(app.applicationFilePath()).baseName());

    QQuickView view;
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
