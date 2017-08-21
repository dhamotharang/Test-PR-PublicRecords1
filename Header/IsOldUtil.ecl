//Filters any records that are older than age_yrs years from the pVersion date value. 
//If source is specified, the src field is used.  Otherwise, it is assumed the file is all utility
import mdr;
EXPORT IsOldUtil(pVersion, file_has_src = 'true', dt_vendor_last_reported_field = 'dt_vendor_last_reported', src_field = 'src', age_yrs = 5) := MACRO
#if(file_has_src)
		mdr.sourceTools.sourceIsUtility(src_field) and
		((dt_vendor_last_reported_field + pVersion [7..8])[..8]) < ut.date_math (pVersion, -((age_yrs * 365.00) + 2.00)) 
#else
		((dt_vendor_last_reported_field + pVersion [7..8])[..8]) < ut.date_math (pVersion, -((age_yrs * 365.00) + 2.00))  
#end
ENDMACRO;


