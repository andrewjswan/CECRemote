## CECREMOTE (x86/x64)
[![GitHub](https://img.shields.io/github/license/andrewjswan/CECRemote?color=blue)](https://github.com/andrewjswan/CECRemote/blob/master/LICENSE)
[![GitHub release (latest SemVer including pre-releases)](https://img.shields.io/github/v/release/andrewjswan/CECRemote?include_prereleases)](https://github.com/andrewjswan/CECRemote/releases)
[![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/downloads-pre/andrewjswan/CECRemote/latest/total?label=release@downloads)](https://github.com/andrewjswan/CECRemote/releases)
[![CECRemote x86](https://img.shields.io/badge/CECRemote-x86-orange?logo=windows&logoColor=white)](https://github.com/andrewjswan/CECRemote/releases)[![CECRemote x64](https://img.shields.io/badge/x64-blue?logoColor=white)](https://github.com/andrewjswan/CECRemote/releases)
[![StandWithUkraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

CecRemote is a remote control plugin for the MediaPortal media center software (http://www.team-mediaportal.com). 
It allows you to control MediaPortal with your TV’s remote using HDMI-CEC signals.

# Features

- fully customizable key mappings
- automatically power on TV when MediaPortal starts
- automatically power off TV when MediaPortal is closed, system enters sleep or computer is powered off
- option to set the HDMI device type that is reported to TV

# Requirements

- libCEC compatible USB-CEC adapter (from Pulse-Eight)
- TV that supports HDMI-CEC

# Getting started

Once you have installed and configured MediaPortal, download latest version of the plugin and install it. Plugin is distributed in MediaPortal extension installer format, so installation is easy. Make sure that you have USB-CEC adapter drivers installed and adapter firmware is up-to-date. Set at least the correct HDMI-port from plugin settings and you’re ready to start controlling Media Portal with your TV’s remote.

# Compilation

To compile CECRemote, you need Visual Studio 2019(+) and the following dependencies:

- Media Portal 1.31.100 or newer (references to libraries in Media Portal install dir)
- libCEC 6.0.0 (reference to LibCecSharp)

This project uses libCEC (https://github.com/Pulse-Eight/libcec)
libCEC(R) is a trademark of Pulse-Eight Limited.
