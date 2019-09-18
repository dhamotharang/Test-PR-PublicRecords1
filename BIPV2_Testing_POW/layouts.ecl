import BIPV2;

EXPORT layouts := 
MODULE

export newrec := record
	BIPV2.Key_BH_Linking_Ids.key;
	unsigned8 bdid;
	unsigned8 bdid_orig;
end;

END;