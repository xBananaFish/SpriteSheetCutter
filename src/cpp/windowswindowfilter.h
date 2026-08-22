#ifndef WINDOWSWINDOWFILTER_H
#define WINDOWSWINDOWFILTER_H

#include <QAbstractNativeEventFilter>
#include <QWindow>

class WindowsWindowFilter : public QAbstractNativeEventFilter
{
public:
    void setWindow(QWindow *window);
    bool nativeEventFilter(const QByteArray &eventType, void *message, qintptr *result);


private:
    quintptr m_windowId = 0;
};

#endif // WINDOWSWINDOWFILTER_H
