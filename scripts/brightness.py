import argparse
import subprocess
import os

def get_brightness():
    result = subprocess.run(
        [os.path.expanduser("~/devlix/scripts/brightness_l.sh")],
        capture_output=True,
        text=True
    )
    return float(result.stdout.strip())

def i_b():
    global brits
    if brits >= 1:
        print("MAX brightness")
        brits = 1
        subprocess.run(["xrandr", "--output", "eDP", "--brightness", str(brits)])
    else:
        print("brightness up")
        brits = brits + 0.05
        subprocess.run(["xrandr", "--output", "eDP", "--brightness", str(brits)])

def d_b():
    global brits
    if brits <= 0.05:
        print("You can't lower the brightness more than 5%")
        brits = 0.05
        subprocess.run(["xrandr", "--output", "eDP", "--brightness", str(brits)])
    else:
        print("brightness down")
        brits = brits - 0.05
        subprocess.run(["xrandr", "--output", "eDP", "--brightness", str(brits)])

parser = argparse.ArgumentParser(description="Control brightness")
parser.add_argument("action", choices=["up", "down"], help="Choose 'up' to increase or 'down' to decrease brightness")
args = parser.parse_args()

brits = get_brightness()

if args.action == "up":
    i_b()
elif args.action == "down":
    d_b()
