import os
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

for [src, dst] in links:
    if os.path.islink(dst):
        os.unlink(dst)
