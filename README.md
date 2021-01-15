# Downloading from Twitcasting.tv
An explanation on how to download videos from the website 'twitcasting.tv' using FFmpeg

# Introduction
In the past (yesterday as of writing this), it was possible to download videos from Twitcasting by replacing parts of a link (http://dl01.twitcasting.tv/(id)/download/(number)?dl=1) with the corresponding video's channel and it's numerical ID. Unfortunately, it (as of today) has been patched and removed.   

Fortunately, there is another method that still works, and (most likely) will never be patched.

## Requirements
A computer, and a web browser.  
This tutorial assumes you are using Windows (7/8/10) and Google Chrome, however, any modern OS and browser should work. 

## Step 1: Acquiring video URLs
When you watch a VOD from Twitcasting, it first has to find it's corresponding .m3u8 file, which contains a link to all the fragments of the video. The first step to downloading a video is to find the link to this file.   

If you know how to use your respective browser's developer console, you can find the video element on the page and copy down the links from the element's data-movie-playlist section. Since Twitcasting splits up streams longer than 1 hour into multiple parts, you may find multiple links, so you should copy them all down, the order in which they appear in the data-movie-playlist is the same as the split videos. The links are enclosed within a large portion of JSON data.

If you are not familiar with the above, then you can also do a simpler method. Open up your browser's developer console (F12 on Chrome, search up it's equivalent on your browser), and paste the following JavaScript code. It should return all the .m3u8 links you need.
### **Please do not paste random code into your developer console unless you understand it.**
```js
let a=[];for(let _ of JSON.parse(document.querySelector("video")["dataset"]["moviePlaylist"]))a.push(_.source?.url);console.log(a.join("\n"))
```
Since it's dangerous to paste in code which you do not understand, I'll try to explain how this works.
```js
let a=[]; // This initializes an empty list for use in the next line

/* This line finds the element of the webpage that contains the list of links, and adds all of them to the list created above */
for (let _ of JSON.parse(document.querySelector("video")["dataset"]["moviePlaylist"]))   
    a.push(_.source?.url);

console.log(a.join("\n")) // This line prints out the contents of the list created in the first line, separated by a new line.
```
### **Please do not paste random code into your developer console unless you understand it.**
<br />

## Step 2: Downloading the videos
Once you have the .m3u8 links from the previous step, you can now move on to downloading the actual videos. For this, you will need a program called FFmpeg, which you can download [here](https://ffmpeg.org/download.html). Window's users specifically can download from [here](https://ffmpeg.zeranoe.com/builds/) instead, just leave all the options untouched and press "**Download Build**". Either way, this should give you a zip archive, which you should extract to somewhere accessible, preferably your desktop or downloads folder.

Then, open up your command prompt (or terminal in the case of MacOS/Linux users), and cd into your extracted folder. You can open a command prompt (cmd.exe) on windows by either searching 'cmd.exe' on your windows search bar or pressing _Windows Key + R_ and typing cmd.exe. To CD into the folder, please find the location where you extracted your FFmpeg archive. For example, if you extracted it into your desktop, you should type the command `cd C:\Users\(YourUsername)\Desktop\(FFmpegFolder)\bin`. Please replace `(YourUsername)` with your windows username and `(FFmpegFolder)` with the name of your FFmpeg folder, which by default will look something like `ffmpeg-YYYYMMDD-XXXXXXX-win64-static`.

Once you have done that, you may proceed to download the videos. Assuming you have correctly cd-ed into the right folder, you can paste in this command.
```bat
ffmpeg.exe -protocol_whitelist file,http,https,tcp,tls,crypto -i {link} -c copy {name}.mkv
```
You need to replace {link} with one of the .m3u8 links you grabbed back in step 1, and you need to replace {name} with the name of the file you want it to be saved as. It will be saved to the bin subfolder of your FFmpeg folder.

Importantly, note that the file extension of the saved file is .mkv. You cannot change this to .mp4 as the download will not work properly, but you may convert it to mp4 after it has finished downloading (_See bottom for FFmpeg command to convert .mkv to .mp4_)

Once you have completed all of this, your download should start. It will display quite a lot of text, but this is normal. If the text is either yellow or red, however, this means that a problem has occurred. Usually, the best course of action is to cancel the download (either close the command prompt or press _CTRL + C_) and restart it by retyping/pasting the command. While it is downloading, do not turn your computer off, and try not to do anything else while it is still running. Down the bottom of the command prompt, there should be a speed value, which looks like 1.234x. This means that for every second, FFmpeg is downloading 1.234 seconds of the video, and using some basic maths this will allow you to figure out how long the download will take. Please note that if your internet is not that strong it may take more than an hour for each hour-long part.

## Appendix A: Converting .mkv to .mp4
Run the following command, replacing the words within the braces (braces = {}). Do not keep the braces.
```
ffmpeg -i {input}.mkv -codec copy {output}.mp4
```

## What to do I do if this doesn't work?
Please open an issue on this GitHub repo, since it's probably the best way of getting in contact with me. 
