

import crim_common;
import crim_cp_ln;

export Layout_case_details_cp := RECORD
	INTEGER ecl_cade_id;
	crim_common.Layout_Moxie_Crim_Offender2.previous.offender_key;
	crim_cp_ln.Layout_cross_case_detail;
end
;
