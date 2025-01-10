import json

with open('Videos/Wallpaper/YouTube/Space Rock.json', 'r') as file:
    data = json.load(file)

title_to_find = "Astrophysics - everytime I pick up the phone (Lyric Video)"

for item in data:
    if 'title' in item and item['title'] == title_to_find:
        print(item['url'])

