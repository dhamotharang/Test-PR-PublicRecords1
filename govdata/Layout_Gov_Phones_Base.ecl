import BIPV2;
EXPORT Layout_Gov_Phones_Base := RECORD
	UNSIGNED6 bdid;
	QSTRING20 unique_id;
	UNSIGNED6 phone;
	Layout_Gov_Phones_In;
	bipv2.IDlayouts.l_xlink_ids;
END;