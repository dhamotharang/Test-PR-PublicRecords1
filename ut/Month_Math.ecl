/** This function takes in YYYYMMDD or YYYYMM inDate format, and months offset.  Offset can be positive or negative.
   It is similar to ut.date_math, except instead of passing in the offset in days, you pass in the offset in months.
   Note: If you pass in a DD, it is possible that the new month doesn't have that many days in it - in this case we take
   the very last day of the new month.
**/
IMPORT STD;
EXPORT Month_Math(STRING8 pinput, INTEGER offset) := FUNCTION 
 tDate := TRIM(pinput,LEFT,RIGHT); 
 lDate := LENGTH(tDate); 
 
 patchPartialdate := MAP(lDate = 4 => tDate+'0001', 
                         lDate = 6 => tDate+'01', 
												 lDate = 6 AND tDate[5..6] = '00' => tDate[1..4]+'0101',
												 lDate = 8 AND tDate[5..8] = '0000' => tDate[1..4]+'0001',
												 tDate); 
 Result := (STRING) Std.Date.AdjustCalendar((UNSIGNED4)patchPartialdate, 0,offset,0);
 
 PatchResult :=  MAP(lDate <= 6 => Result[1..6], 
                     lDate = 8 AND tDate[5..8] = '0000' => Result[1..6],
										 Result); 
 
 RETURN PatchResult;  
 
 END;