/**
  *Function to return a calculated date by taking in starting date (YYYYMMDD) and offset.  
  *Offset is # of days and can be positive or negative.
  *If base,offset 0 retruns the todays date
 */

IMPORT STD; 

EXPORT STRING8 getDateOffset(INTEGER offset = 0, STRING8 base_date = (STRING)Std.Date.Today()) := FUNCTION

 tDate := TRIM(base_date,LEFT,RIGHT); 
 lDate := LENGTH(tDate);
 pDate := MAP(lDate = 4 => tDate+'1201',
              tDate[5..6] ='00'=> tDate[1..4]+'1201',
              lDate = 6 => tDate+'01' ,
              tDate[5..8] ='0000'=> tDate[1..4]+'1201',
              tDate);	 
				 
 Adjustoffset := IF(LENGTH(tDate) = 4 OR LENGTH(tDate) = 6 OR tDate[5..8]   ='0000' , offset-1, offset);

 returnDate := IF(offset=0, base_date, (STRING) Std.Date.AdjustDate((UNSIGNED4)pDate, 0,0,Adjustoffset));

 RETURN returnDate; 

END; 