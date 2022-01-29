echo off
rem ffmpeg -r 29  -i  " %%06d.bmp" test.mp4
ffmpeg -r 30 -i " %%06d.bmp" -c:v libx264 -vf "fps=25,format=yuv420p" out.mp4

pause 0

rem To take a list of images that are padded with zeros (pic0001.png, pic0002.png…. etc) 
rem use the following command:

rem ffmpeg -r 60 -f image2 -s 1920x1080 -i pic%04d.png -vcodec libx264 -crf 25  -pix_fmt yuv420p test.mp4
rem where the %04d means that zeros will be padded until the length of the string is 4 
rem i.e 0001…0020…0030…2000 and so on. If no padding is needed use something similar to pic%d.png or %d.png.

rem https://hamelot.io/visualization/using-ffmpeg-to-convert-a-set-of-images-into-a-video/