import doxie, doxie_cbrs;

EXPORT layout_ids := record
	LiensV2_Services.layout_TMSID; //acctno, TMSID
	doxie.layout_references; //did
end;