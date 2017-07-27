import business_header,doxie_cbrs;

export report := FUNCTION

bdid := business_header.stored_bdid_value;
bdids := dataset([{bdid}], doxie_cbrs.layout_references);
bybdid := ebr_services.ebr_raw.get_file_number_from_bdids(bdids);

STRING10 file_number := '' : STORED('FileNumber');

file_numbers := 
	if(file_number <> '', dataset([{file_number}],ebr_services.layout_file_number),
		 if(bdid > 0, bybdid));

r := ebr_services.ebr_raw.report_view.by_file_number(file_numbers);

RETURN r;

END;