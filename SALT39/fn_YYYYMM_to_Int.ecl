// unsigned2 ok up to 4K - let the grandkids worry about that one ....
/*This function takes a date in ANY of the formats (YYYYMM/YYYYMMDD/YYYYMMDDHHMMSS) and converts it to the reporteddate value (Rangefield value) by month. 
This means that the output will be the SAME for any of 200412 / 20041213 / 2004121301202. In all these cases year and month are the same and thats the only thing this 
function cares about. 
*/ 
EXPORT fn_YYYYMM_to_Int(UNSIGNED6 yyyymm) :=  FUNCTION//(UNSIGNED2)(yyyymm DIV 100 * 12 + yyyymm % 100 - 1);
//At this stage we assume that the dates have strlens of either 6 or 8 only. Also adding support for strlens of 14 (for yyyymmddhhmmss)
valid := CASE((LENGTH(TRIM((STRING) yyyymm))), 8 => yyyymm DIV 100, 14 => yyyymm DIV 100000000, yyyymm); //Convert data to yyyymm
/*
yyyymm_part := (unsigned4)((string)yyyymm[..6]);
//valid := IF(LENGTH(TRIM((string)yyyymm_part)) < 6, (unsigned4)(yyyymm_part * POWER(10 ,6-(LENGTH(TRIM((string)yyyymm_part))))) +1, yyyymm_part); // eg dt_xxx = 2002 will be considered as 200201
valid := yyyymm_part;
*/
month := valid % 100; 
RETURN IF(valid = 0, 0, (UNSIGNED2) (IF(month < 1 OR month > 12, 6, month) - 1 + valid DIV 100 * 12));
END;
