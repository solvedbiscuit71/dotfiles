import os
import shutil
import json

HOME = os.environ.get("HOME")

def remove_tilde(path):
    return path.replace("~", HOME)

links = []
with open(".script/setup.json") as setupFile:
    data = json.loads(setupFile.read())
    for [key, values] in data.items():
        if type(values) is list:
            for value in values:
                links.append((remove_tilde(key), remove_tilde(value)))
        else:
            links.append((remove_tilde(key), remove_tilde(values)))

if not os.path.isdir(".backup"):
    os.mkdir(".backup")

for path in links:
    if os.path.exists(path[1]) and not os.path.islink(path[1]):
        shutil.move(path[1], ".backup")

if not os.path.isdir(f"{HOME}/.config"):
    os.mkdir(f"{HOME}/.config")

for [src, dst] in links:
    if not os.path.exists(dst):
        os.symlink(src, dst)
