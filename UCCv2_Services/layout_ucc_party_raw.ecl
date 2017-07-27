import uccv2, ffd, UCCv2_Services;

export layout_ucc_party_raw := record
	UCCv2_Services.layout_ucc_party_raw_src;
	unsigned8 persistent_record_id:=0;
	FFD.Layouts.CommonRawRecordElements;
end;