# convert input.mp4 to output gif with scale to 320p, and trim from 0s to 10s  
ffmpeg -t 00.00.10.000 -i input.mp4 -vf "fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 output.gif
