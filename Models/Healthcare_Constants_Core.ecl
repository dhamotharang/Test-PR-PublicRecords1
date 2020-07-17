﻿EXPORT Healthcare_Constants_Core := MODULE
	export authorized_DPPA := 0;
	export inv_DPPA_msg := 'Supplied DPPAPurpose is not an approved usage value. ';
	export authorized_DMF := 0;
	export inv_DMF_msg := 'Supplied DMFPurpose is not an approved usage value. ';
	export authorized_FCRA := 0;
	export inv_FCRA_msg := 'Supplied FCRAPurpose is not an approved usage value. ';
	export authorized_GLBA := 6;
	export inv_GLBA_msg := 'Supplied GLBPurpose is not an approved usage value. ';
	export alt_GLBA := 1;
	export default_DataRestriction := '000000000000010000000000000000'; 
	export inv_DataRestriction_msg := 'A blank DataRestrictionMask value is supplied. ';
	export default_DataPermission := '000000000000000000000000000000';  
	export inv_DataPermission_msg := 'A blank DataPermissionMask value is supplied. ';
	export default_LeadIntegrity_Version := 4;
	export default_BocaShell_Version := 41;
	export default_ProfileBooster_Version := 1; //or v1/V1
	export default_ProfileBooster_AttributesVersionRequest := 'PBATTRV1';
	export default_onThor := false;
	export integer4 default_adl_score_filter_val := 80;
	export caredriver_suppression_list := ['IDSRCH','IDVAL','IDVFR','IDVPH','IVRAFR','IVSSN'];
END;