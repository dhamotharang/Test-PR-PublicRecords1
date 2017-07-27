// unsigned2 ok up to 4K - let the grandkids worry about that one ....
export fn_YYYYMM_to_Int(UNSIGNED4 yyyymm) :=  FUNCTION//(UNSIGNED2)(yyyymm DIV 100 * 12 + yyyymm % 100 - 1);
//At this stage we assume that the dates have strlens of either 6 or 8 only
valid := IF((LENGTH(TRIM((STRING) yyyymm))) = 8, yyyymm DIV 100, yyyymm);
month := valid % 100;
RETURN (UNSIGNED2) (IF(month < 1 OR month > 12, 6, month) - 1 + valid DIV 100 * 12);
END;
