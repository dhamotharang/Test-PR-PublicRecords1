IMPORT _control,PRTE_CSV,header,ut,Address;

EXPORT Proc_Build_Header_Wild_Keys(STRING pIndexVersion):=FUNCTION

	header_proj_out := PRTE.Get_Header_Base;

	rKeyheader_wild__fname_small:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__fname_small;};
	
	rKeyheader_wild__lname_fname:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__lname_fname;};
	rKeyheader_wild__phone:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__phone;};
	rKeyheader_wild__pname_prange_st_city_sec_range_lname:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__pname_prange_st_city_sec_range_lname;};
	rKeyheader_wild__pname_zip_name_range:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__pname_zip_name_range;};
	rKeyheader_wild__ssn_did:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__ssn_did;};
	rKeyheader_wild__st_city_fname_lname:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__st_city_fname_lname;};
	rKeyheader_wild__st_fname_lname:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__st_fname_lname;};
	rKeyheader_wild__zip_lname_fname:={PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__zip_lname_fname;};

	dKeyheader_wild__fname_small:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__fname_small,rKeyheader_wild__fname_small);
	rKeyheader_wild__fname_small prKeyheader_wild__fname_small(header_proj_out l) := transform
	self.zip := (integer4)l.zip;
	self := l;
	self := [];

	end;
	
	dKeyheader_wild__fname_small1 := project(header_proj_out,prKeyheader_wild__fname_small(left));
	
	dKeyheader_wild__lname_fname:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__lname_fname,rKeyheader_wild__lname_fname);
	
	rKeyheader_wild__lname_fname prKeyheader_wild__lname_fname(header_proj_out l) := transform
	self.s4 := (unsigned2)l.ssn4;
	self := l;
	self := [];

	end;
	
	dKeyheader_wild__lname_fname1 := project(header_proj_out,prKeyheader_wild__lname_fname(left));
	
	dKeyheader_wild__phone:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__phone,rKeyheader_wild__phone);
	prte.header_ds_macro(prKeyheader_wild__phone,rKeyheader_wild__phone,header_proj_out,dKeyheader_wild__phone1);
	dKeyheader_wild__pname_prange_st_city_sec_range_lname:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__pname_prange_st_city_sec_range_lname,rKeyheader_wild__pname_prange_st_city_sec_range_lname);
	prte.header_ds_macro(prKeyheader_wild__pname_prange_st_city_sec_range_lname,rKeyheader_wild__pname_prange_st_city_sec_range_lname,header_proj_out,dKeyheader_wild__pname_prange_st_city_sec_range_lname1);
	dKeyheader_wild__pname_zip_name_range:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__pname_zip_name_range,rKeyheader_wild__pname_zip_name_range);
	rKeyheader_wild__pname_zip_name_range prKeyheader_wild__pname_zip_name_range(header_proj_out l) := transform
	self.zip := (integer4)l.zip;
	self := l;
	self := [];
	end;
	
	dKeyheader_wild__pname_zip_name_range1 := project(header_proj_out,prKeyheader_wild__pname_zip_name_range(left));
	dKeyheader_wild__ssn_did:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__ssn_did,rKeyheader_wild__ssn_did);
	prte.header_ds_macro(prKeyheader_wild__ssn_did,rKeyheader_wild__ssn_did,header_proj_out,dKeyheader_wild__ssn_did1);
	dKeyheader_wild__st_city_fname_lname:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__st_city_fname_lname,rKeyheader_wild__st_city_fname_lname);
	prte.header_ds_macro(prKeyheader_wild__st_city_fname_lname,rKeyheader_wild__st_city_fname_lname,header_proj_out,dKeyheader_wild__st_city_fname_lname1);
	dKeyheader_wild__st_fname_lname:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__st_fname_lname,rKeyheader_wild__st_fname_lname);
	rKeyheader_wild__st_fname_lname prKeyheader_wild__st_fname_lname(header_proj_out l) := transform
	self.zip := (integer4)l.zip;
	self.s4 := (unsigned2)l.ssn4;
	self := l;
	self := [];
	end;
	dKeyheader_wild__st_fname_lname1 := project(header_proj_out,prKeyheader_wild__st_fname_lname(left));
	
	dKeyheader_wild__zip_lname_fname:=PROJECT(PRTE_CSV.Header_Wild.dthor_data400__key__header_wild__zip_lname_fname,rKeyheader_wild__zip_lname_fname);
	rKeyheader_wild__zip_lname_fname prKeyheader_wild__zip_lname_fname(header_proj_out l) := transform
	self.zip := (integer4)l.zip;
	self.s4 := (unsigned2)l.ssn4;
	self := l;
	self := [];
	end;
	dKeyheader_wild__zip_lname_fname1 := project(header_proj_out,prKeyheader_wild__zip_lname_fname(left));
	
	fulldKeyheader_wild__fname_small := dKeyheader_wild__fname_small + dKeyheader_wild__fname_small1;
	kKeyheader_wild__fname_small:=INDEX(fulldKeyheader_wild__fname_small,{fulldKeyheader_wild__fname_small},'~prte::key::header_wild::'+pIndexVersion+'::fname_small');
	fulldKeyheader_wild__lname_fname := dKeyheader_wild__lname_fname + dKeyheader_wild__lname_fname1;
	kKeyheader_wild__lname_fname:=INDEX(fulldKeyheader_wild__lname_fname,{fulldKeyheader_wild__lname_fname},'~prte::key::header_wild::'+pIndexVersion+'::lname.fname');
	fulldKeyheader_wild__phone := dKeyheader_wild__phone + dKeyheader_wild__phone1;
	kKeyheader_wild__phone:=INDEX(fulldKeyheader_wild__phone,{fulldKeyheader_wild__phone},'~prte::key::header_wild::'+pIndexVersion+'::phone');
	fulldKeyheader_wild__pname_prange_st_city_sec_range_lname := dKeyheader_wild__pname_prange_st_city_sec_range_lname + dKeyheader_wild__pname_prange_st_city_sec_range_lname1;
	kKeyheader_wild__pname_prange_st_city_sec_range_lname:=INDEX(fulldKeyheader_wild__pname_prange_st_city_sec_range_lname,{fulldKeyheader_wild__pname_prange_st_city_sec_range_lname},'~prte::key::header_wild::'+pIndexVersion+'::pname.prange.st.city.sec_range.lname');
	fulldKeyheader_wild__pname_zip_name_range := dKeyheader_wild__pname_zip_name_range + dKeyheader_wild__pname_zip_name_range1;
	kKeyheader_wild__pname_zip_name_range:=INDEX(fulldKeyheader_wild__pname_zip_name_range,{fulldKeyheader_wild__pname_zip_name_range},'~prte::key::header_wild::'+pIndexVersion+'::pname.zip.name.range');
	fulldKeyheader_wild__ssn_did := dKeyheader_wild__ssn_did + dKeyheader_wild__ssn_did1;
	kKeyheader_wild__ssn_did:=INDEX(fulldKeyheader_wild__ssn_did,{fulldKeyheader_wild__ssn_did},'~prte::key::header_wild::'+pIndexVersion+'::ssn.did');
	fulldKeyheader_wild__st_city_fname_lname := dKeyheader_wild__st_city_fname_lname + dKeyheader_wild__st_city_fname_lname1;
	kKeyheader_wild__st_city_fname_lname:=INDEX(fulldKeyheader_wild__st_city_fname_lname,{fulldKeyheader_wild__st_city_fname_lname},'~prte::key::header_wild::'+pIndexVersion+'::st.city.fname.lname');
	fulldKeyheader_wild__st_fname_lname := dKeyheader_wild__st_fname_lname + dKeyheader_wild__st_fname_lname1;
	kKeyheader_wild__st_fname_lname:=INDEX(fulldKeyheader_wild__st_fname_lname,{fulldKeyheader_wild__st_fname_lname},'~prte::key::header_wild::'+pIndexVersion+'::st.fname.lname');
	fulldKeyheader_wild__zip_lname_fname := dKeyheader_wild__zip_lname_fname + dKeyheader_wild__zip_lname_fname1;
	kKeyheader_wild__zip_lname_fname:=INDEX(fulldKeyheader_wild__zip_lname_fname,{fulldKeyheader_wild__zip_lname_fname},'~prte::key::header_wild::'+pIndexVersion+'::zip.lname.fname');

	RETURN
    SEQUENTIAL(
      PARALLEL(
				BUILDINDEX(kKeyheader_wild__fname_small,UPDATE),
				BUILDINDEX(kKeyheader_wild__lname_fname,UPDATE),
				BUILDINDEX(kKeyheader_wild__phone,UPDATE),
				BUILDINDEX(kKeyheader_wild__pname_prange_st_city_sec_range_lname,UPDATE),
				BUILDINDEX(kKeyheader_wild__pname_zip_name_range,UPDATE),
				BUILDINDEX(kKeyheader_wild__ssn_did,UPDATE),
				BUILDINDEX(kKeyheader_wild__st_city_fname_lname,UPDATE),
				BUILDINDEX(kKeyheader_wild__st_fname_lname,UPDATE),
				BUILDINDEX(kKeyheader_wild__zip_lname_fname,UPDATE)
			)/*,
			PRTE.UpdateVersion('PersonHeaderKeys',pIndexVersion,_control.MyInfo.EmailAddressNormal,'B','N','N')*/
		);

end;
