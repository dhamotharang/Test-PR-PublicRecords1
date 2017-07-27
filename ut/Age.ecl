/**
 * Returns Age for Dates in format of YYYYMMDD
 **/
IMPORT STD; 
EXPORT Age(UNSIGNED4 DOB, UNSIGNED4 asOfDate = Std.Date.Today() ) := FUNCTION 
 tDOB            := TRIM((STRING)DOB,LEFT,RIGHT);
 lDOB            := LENGTH(tDOB);
 PatchPartialDOB := (UNSIGNED)MAP(lDOB=4 => tDOB+'0000',
                                  lDOB=6 => tDOB+'00',
												          tDOB); 
 Result  := IF(PatchPartialDOB = 0 OR asOfDate <= PatchPartialDOB,0,Std.Date.YearsBetween(PatchPartialDOB ,asOfDate)); 
 RETURN Result ; 
END ; 