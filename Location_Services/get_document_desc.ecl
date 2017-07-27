import codes,LN_PropertyV2_Services;

export get_document_desc(string vendor_source_flag, string code_value) := function
	
		code_file		:= LN_PropertyV2_Services.consts.deeds_codefile;
		vsource := LN_PropertyV2_Services.fn_vendor_source(vendor_source_flag);
		return Codes.KeyCodes(code_file, 'DOCUMENT_TYPE', vsource, code_value, true);
end;