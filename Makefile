# Makefile for WiringRP-Python

.DEFAULT_GOAL := build

PKG_NAME := wiringrp-python
VERSION := 1.0.1
DEB_VERSION := $(VERSION)-1

DESTDIR ?= /usr
PREFIX ?= $(DESTDIR)

.PHONY: install uninstall clean deb source binary build

export $(dpkg-architecture -aarm64)

install:
	python3 setup.py install --prefix=$(PREFIX) --install-lib=$(PREFIX)/lib/python3/dist-packages --single-version-externally-managed  --record=install_record.txt

uninstall:

deb:
	@fakeroot dh binary

source:
	@tar -cJf ../$(PKG_NAME)_$(VERSION).orig.tar.xz --exclude=debian ./

binary: deb
build: install

clean:
	python3 setup.py clean
	@dh_clean

