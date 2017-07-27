f_best := Business_Header.File_Prep_Business_Header_Best_Plus;

layout_best_index := RECORD
	f_best.bdid;	
	f_best.__filepos;
END;

EXPORT Key_Prep_BH_Best := INDEX(
	f_best, layout_best_index, 
	'~thor_data400::key::business_header.Best' + thorlib.wuid());