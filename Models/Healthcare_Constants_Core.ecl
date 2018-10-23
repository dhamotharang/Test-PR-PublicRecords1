EXPORT Healthcare_Constants_Core := MODULE
	export authorized_DPPA := 0;
	export authorized_GLBA := 6;
	export default_DataRestriction := '000000000000010000000000000000'; 
	export default_DataPermission := '000000000000000000000000000000';  
	export default_LeadIntegrity_Version := 4;
	export default_BocaShell_Version := 41;
	export default_ProfileBooster_Version := 1; //or v1/V1
	export default_ProfileBooster_AttributesVersionRequest := 'PBATTRV1';
	export default_onThor := false;
	export integer4 default_adl_score_filter_val := 80;
END;