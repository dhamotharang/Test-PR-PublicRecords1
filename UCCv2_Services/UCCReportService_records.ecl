import doxie, business_header, doxie_cbrs;

doxie.MAC_Header_Field_Declare()

EXPORT UCCReportService_records(BOOLEAN return_multiple_pages) := FUNCTION
	did := (unsigned6)did_value;
	dids := dataset([{did}], doxie.layout_references);
	bydid := UCCv2_Services.UCCRaw.get_tmsids_from_dids(dids,Party_Type);

	bdid := business_header.stored_bdid_value;
	bdids := dataset([{bdid}], doxie_cbrs.layout_references);
	bybdid := UCCv2_Services.UCCRaw.get_tmsids_from_bdids(bdids,,Party_Type);

	tmsids := 
		if(tmsid_value <> '', dataset([{tmsid_value}],UCCv2_Services.layout_tmsid)) +
		if(did > 0, bydid) +
		if(bdid > 0, bybdid);

	r := UCCv2_Services.UCCRaw.source_view.by_tmsid(tmsids,ssn_mask_value, return_multiple_pages,application_type_value);

	results := project(r, transform(recordof(r), self.penalt:=(left.penalt/uccPenalty.scale), self:=left));
	
	RETURN results;

END;