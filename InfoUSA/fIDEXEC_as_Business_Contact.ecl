import business_header, infousa, ut, address,mdr;

export fIDEXEC_as_Business_Contact(dataset(InfoUSA.Layout_IDEXEC_Base) pIDEXEC)
 :=
  function

	IDEXEC_IN := pIDEXEC;

	//mapping to business contact

	business_header.Layout_Business_Contact_Full_New tIDEXECtoHEADER(InfoUSA.Layout_IDEXEC_Base L, integer C) := transform

	self.title                := L.Exec_Clean_title;
	self.fname                := L.Exec_Clean_fname;
	self.mname                := L.Exec_Clean_mname;
	self.lname                := L.Exec_Clean_lname;
	self.name_suffix          := L.Exec_Clean_name_suffix;
	self.company_title        := trim(stringlib.stringtouppercase(L.Exec_Title), left, right);
	self.vl_id                := L.idexec_key;
	self.vendor_id            := L.idexec_key;
	self.source               := MDR.sourceTools.src_INFOUSA_IDEXEC;
	self.name_score           := Business_Header.CleanName(L.Exec_Clean_fname,L.Exec_Clean_mname,L.Exec_Clean_lname, L.Exec_Clean_name_suffix)[142];
	self.prim_range		      := L.Firm_Address_Clean_prim_range ;
	self.predir			      := L.Firm_Address_Clean_predir;
	self.prim_name	          := L.Firm_Address_Clean_prim_name;
	self.addr_suffix	      := L.Firm_Address_Clean_addr_suffix;
	self.postdir		      := L.Firm_Address_Clean_postdir;
	self.unit_desig		      := L.Firm_Address_Clean_unit_desig;
	self.sec_range		      := L.Firm_Address_Clean_sec_range;
	self.city			      := L.Firm_Address_Clean_v_city_name;
	self.state			      := L.Firm_Address_Clean_st;
	self.zip 			      := (unsigned3)L.Firm_Address_Clean_zip;
	self.zip4			      := (unsigned2)L.Firm_Address_Clean_zip4;
	self.county			      := L.Firm_Address_Clean_fipscounty;
	self.msa			      := L.Firm_Address_Clean_msa;
	self.geo_lat		      := L.Firm_Address_Clean_geo_lat;
	self.geo_long		      := L.Firm_Address_Clean_geo_long;
	SELF.company_name         := choose(C,stringlib.stringtouppercase(L.firm_name),stringlib.stringtouppercase(L.former_name1),stringlib.stringtouppercase(L.former_name2)); 
	self.company_source_group := '';
	SELF.company_prim_range   := L.Firm_Address_Clean_prim_range;
	SELF.company_predir       := L.Firm_Address_Clean_predir;
	SELF.company_prim_name    := L.Firm_Address_Clean_prim_name;
	SELF.company_addr_suffix  := L.Firm_Address_Clean_addr_suffix;
	SELF.company_postdir      := L.Firm_Address_Clean_postdir;
	SELF.company_unit_desig   := L.Firm_Address_Clean_unit_desig;
	SELF.company_sec_range    := L.Firm_Address_Clean_sec_range;
	SELF.company_city         := L.Firm_Address_Clean_v_city_name;
	SELF.company_state        := L.Firm_Address_Clean_st;
	SELF.company_zip          := (UNSIGNED3)L.Firm_Address_Clean_zip;
	SELF.company_zip4         := (UNSIGNED2)L.Firm_Address_Clean_zip4;
	self.company_phone        := (UNSIGNED6)((UNSIGNED8)address.cleanphone(L.loc_telePhone));
	self.company_fein         := 0;
	self.phone                := (unsigned6)((unsigned8)address.cleanphone(L.loc_telePhone));
	self.email_address        := L.Web_Address;
	SELF.dt_first_seen        := 0;//waiting for reply from dayton
	SELF.dt_last_seen         := 0;//waiting for reply from dayton
	self.record_type          := 'C';
	self.rawaid								:= L.raw_aid;
	//self.company_department   := trim(stringlib.stringtouppercase(L.company_department), left, right);
	//self := L;

	end;

	IDEXEC_header := normalize(IDEXEC_in,3,tIDEXECtoHEADER(LEFT, COUNTER));

	// Removed extra contacts with blank addresses
	IDEXEC_dist := distribute(IDEXEC_header, hash(trim(vendor_id), trim(company_name)));

	IDEXEC_sort := sort(IDEXEC_dist, vendor_id, company_name,
						 fname, mname, lname, name_suffix, company_title, phone, if(zip <> 0, 0, 1), zip, prim_name, prim_range, 
						 local);

	IDEXEC_dedup := dedup(IDEXEC_sort,
								 left.vendor_id = right.vendor_id and
								 left.company_name = right.company_name and
								 left.fname= right.fname and
								 left.mname = right.mname and
								 left.lname = right.lname and
								 left.name_suffix = right.name_suffix and
								 left.company_title = right.company_title and
								 ((left.zip = right.zip and
								 left.prim_name = right.prim_name and
								 left.prim_range = right.prim_range) or
								 (left.zip <> 0 and right.zip = 0)),
								 local);

	IDEXEC_dedup_filtered	:=	IDEXEC_dedup((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));
	
	return IDEXEC_dedup_filtered;
	
  end
 ;
