import header;
h := header.file_headers;
export Layout_Name_Phone := record
	h.did;
	//h.preGLB_DID;
	header_slimsort.Layout_Name_Phone_NoDID;
	//unsigned2 preGLB_phone_dids := 0;
    //unsigned2 preGLB_phone_fname_dids := 0;
    //unsigned2 preGLB_phone_fname_suffix_dids := 0;
    //unsigned2 preGLB_phone_fullname_dids := 0;
  end;