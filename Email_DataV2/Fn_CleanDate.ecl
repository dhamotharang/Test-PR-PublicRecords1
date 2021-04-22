IMPORT STD, Scrubs;
EXPORT Fn_CleanDate (string8 dt_in) := FUNCTION
	dt_fmtd := STD.Date.ConvertDateFormatMultiple(dt_in,['%Y%m%d'],'%Y%m%d');
	RETURN IF(Scrubs.fn_valid_date(dt_fmtd) > 0 and length(trim(dt_in)) = 8,dt_fmtd,dt_in);
END;