/*
 * Copyright (C) 2016 Patrizio Bekerle -- http://www.bekerle.com
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
 * for more details.
 *
 */

#pragma once

#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QPlainTextEdit>
#include <QWidget>

class QTextEditSearchWidget : public QWidget
{
    Q_OBJECT
public:
    explicit QTextEditSearchWidget(QPlainTextEdit *parent = 0);
    void doSearch(bool searchDown = true);

protected:
    QPlainTextEdit *_textEdit;
    QLabel *_label;
    QLineEdit *_searchLineEdit;
    QPushButton *_closeButton;
    QPushButton *_searchUpButton;
    QPushButton *_searchDownButton;
    bool eventFilter(QObject *obj, QEvent *event);

signals:

public slots:
    void activate();
    void deactivate();
    void doSearchDown();
    void doSearchUp();

protected slots:
    void searchLineEditTextChanged(const QString &arg1);
};
