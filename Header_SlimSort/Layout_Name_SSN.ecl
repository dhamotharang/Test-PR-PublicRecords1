import header,header_slimsort;
h := header.file_headers;
export Layout_Name_SSN := record
	h.did;
	//h.preGLB_DID;
	header_slimsort.Layout_Name_SSN_NoDID;	
	boolean near_name := false;
    //unsigned2 preGLB_ssn_dids := 0;
    //unsigned2 preGLB_ssn_fname_dids := 0;
    //unsigned2 preGLB_ssn_fname_suffix_dids := 0;
    //unsigned2 preGLB_ssn_fullname_dids := 0;
  end;