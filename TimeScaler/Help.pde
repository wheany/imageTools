/* Help Section

Required Inputs:
files must be placed in the 'data' folder inside the sketch
- frames - number of frames to process
- digits - how many digits in file name sequence
- start - the first number in sequence, typically 0 or 1
- filename - the name of the file without sequence numbers
- filetype - the file type, typically .png
- outputFolder - name of the output folder to create

Options:
- fade adds weight to all frames, which retards the amount that a slow moving
section will be compressed. Images with low contrast or slow movement should
be run with a low value (0-75) while high contrast or fast sequences should
use a much higher value. There is no upper limit to this value, but effects
become negligible above 250.
- smooth2D and smooth3D are part of a smoothing algorithm run on each frame to
reduce the grain of the shift. The amount of operations it takes increases as
(2n+1)^3, so numbers should be kept low (0-5 and 0-3 respectively) to reduce
processing time. 


end */
