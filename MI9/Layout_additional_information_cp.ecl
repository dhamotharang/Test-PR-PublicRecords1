

import crim_common;
import crim_cp_ln;

export Layout_additional_information_cp := RECORD
	INTEGER ecl_cade_id;
	crim_common.Layout_Moxie_Crim_Offender2.previous.offender_key;
	mi9.layout_cross_additional_information;
end;



