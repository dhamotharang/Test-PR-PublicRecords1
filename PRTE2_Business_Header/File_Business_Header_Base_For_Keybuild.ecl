import ut, lib_fileservices, business_header, header_services, mdr;

export File_Business_Header_Base_for_keybuild :=
function

	in_hdr := PRTE2_Business_Header.files().base.business_headers.keybuild;
	in_hdr_layout := recordof(in_hdr);

	// Start of code to suppress data based on an MD5 Hash of DID+Address
	Suppression_Layout := header_services.Supplemental_Data.layout_in;

	header_services.Supplemental_Data.mac_verify('didaddressbusiness_sup.txt',Suppression_Layout,supp_ds_func);
	 
	Suppression_In := supp_ds_func();

	dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

	rHashDIDAddress := header_services.Supplemental_Data.layout_out;

	rFullOut_HashDIDAddress := record
	 Business_Header.Layout_Business_Header_Base_Plus;
	 rHashDIDAddress;
	end;

	rFullOut_HashDIDAddress tHashDIDAddress(in_hdr_layout l) := transform                            
	 self.hval := hashmd5(intformat(l.bdid,15,1),(string)l.state,(string)l.zip,(string)l.city,
										(string)l.prim_name,(string)l.prim_range,(string)l.predir,(string)l.addr_suffix,(string)l.postdir,(string)l.sec_range);
	 self := l;
	end;

	dHeader_withMD5 := project(in_hdr, tHashDIDAddress(left));

	Business_Header.Layout_Business_Header_Base_Plus_Orig tSuppress(dHeader_withMD5 l) := transform
	 self := l;
	end;

	full_out_suppress := join(dHeader_withMD5,dSuppressedIn,
														left.hval = right.hval,
								tSuppress(left),
								left only,lookup);

	dall := full_out_suppress;

	dreturndataset := dall;

	return dreturndataset;

end;