



import crim_common;
import Crim_CP_LN;

export Layout_criminal_sentences_cp := RECORD
	INTEGER ecl_cade_id;
	INTEGER ecl_charge_id;
	crim_common.Layout_Moxie_Court_Offenses.offender_key;
	mi9.layout_cross_criminal_sentences;
end;

