#include "src/cpp/fileutils.h"
#include "src/cpp/windowswindowfilter.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    WindowsWindowFilter windowsWindowFilter;
    app.installNativeEventFilter(&windowsWindowFilter);

    QQmlApplicationEngine engine;
    engine.addImportPath(":/");
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    FileUtils fu;
    engine.rootContext()->setContextProperty("fileUtils", &fu);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    if ( !engine.rootObjects().isEmpty() ) {
        QWindow *window = qobject_cast<QWindow*>(engine.rootObjects().constFirst());
        if ( window )
            windowsWindowFilter.setWindow(window);
    }

    return QGuiApplication::exec();
}
