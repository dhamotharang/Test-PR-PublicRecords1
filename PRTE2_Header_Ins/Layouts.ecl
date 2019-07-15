/* ********************************************************************************************
PRTE2_Header_Ins.Layouts
MUST SWITCH TO THE NEW BOCA BUSINESS CASE BUILD PROCESSES - FOR NOW MUST KEEP THE SAME FILE NAMES
NOTE: We only need file info here for 
a) Spray/DeSpray and the data preparation we used to do during the build before the append.
b) Our Base file and 
c) any research/maintenance
************************************************************************************ */


IMPORT prte_csv, PRTE2_LNProperty;

EXPORT Layouts := MODULE

	EXPORT Base_Layout 				:= prte_csv.ge_header_base.layout_payload;
	EXPORT Relative_Layout 	:= prte_csv.ge_header_base.layout_payload-rtitle;

END;