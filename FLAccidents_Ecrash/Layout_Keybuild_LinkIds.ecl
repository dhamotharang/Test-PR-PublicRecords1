IMPORT BIPV2;

EXPORT Layout_Keybuild_LinkIds := RECORD
	BIPV2.IDlayouts.l_xlink_ids;	//Added for BIPV2 project
	STRING12 b_did;
  STRING40 accident_nbr;
  STRING40 orig_accnbr;
END;