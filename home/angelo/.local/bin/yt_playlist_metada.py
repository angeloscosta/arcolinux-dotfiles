import textwrap
import youtube_dl

playlists = [
    "https://www.youtube.com/playlist?list=PLut_SAFcI3Q5Xi3vhjqBYgB_jSZnjsVOL"
]

for playlist in playlists:

    with youtube_dl.YoutubeDL({"ignoreerrors": True, "quiet": True}) as ydl:
        playlist_dict = ydl.extract_info(playlist, download=False)

    # Pretty-printing the video information (optional)
    for video in playlist_dict["entries"]:
        print("\n" + "*" * 60 + "\n")

        if not video:
            print("ERROR: Unable to get info. Continuing...")
            continue

        # for prop in ["thumbnail", "id", "title", "description", "duration"]:
        for prop in ["title", "description", "duration"]:
            print(prop + "\n" +
                textwrap.indent(str(video.get(prop)), "    | ", lambda _: True)
            )

