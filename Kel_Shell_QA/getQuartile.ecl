Layout := RECORD
STRING Quartile1;
STRING Quartile3;
END;

IMPORT R, ut, python3;
EXPORT dataset(layout) getQuartile(set of real nums) := embed(python3)

import math


nums.sort() 
low_mid = int(round( ( len(nums) + 1 ) / 4.0 ))-1
lq = nums[low_mid]

try:
    high_mid = ( len( nums ) - 1 ) * 0.75
    uq = nums[ high_mid ]
except TypeError:  
    ceil = int( math.ceil( high_mid ) )
    floor = int( math.floor( high_mid ) )
    uq = ( nums[ ceil ] + nums[ floor ] ) / 2
  
return [(str(lq),str(uq))]   
endembed;