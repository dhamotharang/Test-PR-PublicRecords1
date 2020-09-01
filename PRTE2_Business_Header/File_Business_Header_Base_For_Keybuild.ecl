import ut, lib_fileservices, business_header, header_services, mdr;

export File_Business_Header_Base_for_keybuild :=
function

	in_hdr := PRTE2_Business_Header.files().base.business_headers.keybuild;
	in_hdr_layout := recordof(in_hdr);

	dreturndataset := project(Business_Header.Prep_Build.applyDidAddressBusiness_sup2(in_hdr), Business_Header.Layout_Business_Header_Base_Plus_Orig);

	return dreturndataset;

end;