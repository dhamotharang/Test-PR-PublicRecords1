// high cannot be null (or it would have been trapped)
// other_low cannot be null (or would have been trapped)
lownull(INTEGER high,INTEGER other_low,INTEGER other_high,INTEGER null_value)
  := MAP( other_low > high => high-other_low,
	        other_high = null_value OR other_high >= high => high-other_low+1,
					other_high-other_low+1 );
					
// other_high cannot be null (or would have been trapped)
// lows cannot be null (or would have exited earlier)
highnull(INTEGER low,INTEGER other_low,INTEGER other_high,INTEGER null_value)
  := IF( other_high < low, other_high-low, other_high-MAX(low,other_low)+1 );
					
export fn_ComputeRangeOverlap(INTEGER low_left,INTEGER high_left,INTEGER low_right,INTEGER high_right,INTEGER null_value) 
    := MAP (
		low_left = null_value AND high_left = null_value OR
		low_right = null_value AND high_right = null_value => 0, // One side is null
		low_left = null_value AND low_right = null_value OR
		high_left = null_value AND high_right = null_value => 1, // Two infinite overlapping ranges
		low_left = null_value => lownull(high_left,low_right,high_right,null_value),
		low_right = null_value => lownull(high_right,low_left,high_left,null_value),
		high_left = null_value => highnull(low_left,low_right,high_right,null_value),
		high_right = null_value => highnull(low_right,low_left,high_left,null_value),
		high_left < low_right => high_left-low_right,
		high_right < low_left => high_right-low_left,
		MIN(high_left,high_right)-MAX(low_left,low_right)+1);
