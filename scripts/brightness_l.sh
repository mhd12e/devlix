#!/bin/bash

xrandr --verbose | grep -i brightness | awk '{print $2}'
