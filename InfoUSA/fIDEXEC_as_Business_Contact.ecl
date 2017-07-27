import business_header, infousa, ut, address;

export fIDEXEC_as_Business_Contact(dataset(InfoUSA.Layout_Cleaned_IDEXEC_file) pIDEXEC)
 :=
  function

	IDEXEC_IN := pIDEXEC;

	//not inlcude these information here

	/*
	IDEXEC_IN_filter := infousa.Cleaned_IDEXEC_file(Exec_Clean_lname <> ''and Exec_Title = '' and Func_Resp_1 = '' and Func_Resp_2 = ''
											 and Func_Resp_3 = '' and Func_Resp_4 = '' and Func_Resp_5 = '' and Func_Resp_6 = '' 
											 and Func_Resp_7 = '' and Func_Resp_8 = '' and Func_Resp_9 = '' and Func_Resp_10 = ''
											 and Func_Resp_11 = '' and Func_Resp_12 = '' and Func_Resp_13 = '' and Func_Resp_14 = ''
											 and Func_Resp_15 = '' and Func_Resp_16 = '' and Func_Resp_17 = '' and Func_Resp_18 = ''
											 and Func_Resp_19 = '' and Func_Resp_20 = '' and Func_Resp_21 = '' and Func_Resp_22 = ''
											 and Func_Resp_23 = '');
											 

	layout_IDEXEC_slim := record

	string company_title;
	infoUSA.Layout_Cleaned_IDEXEC_file;
	end;

	layout_IDEXEC_slim tslimcompanytitle(infousa.Layout_Cleaned_IDEXEC_file L, integer C) := transform

	self.company_title := choose(C,stringlib.stringtouppercase(L.Exec_Title), stringlib.stringtouppercase(L.Func_Resp_1),stringlib.stringtouppercase(L.Func_Resp_2),
								 stringlib.stringtouppercase(L.Func_Resp_3), stringlib.stringtouppercase(L.Func_Resp_4), stringlib.stringtouppercase(L.Func_Resp_5), 
								 stringlib.stringtouppercase(L.Func_Resp_6), stringlib.stringtouppercase(L.Func_Resp_7), stringlib.stringtouppercase(L.Func_Resp_8),
								 stringlib.stringtouppercase(L.Func_Resp_9), stringlib.stringtouppercase(L.Func_Resp_10), stringlib.stringtouppercase(L.Func_Resp_11),
								 stringlib.stringtouppercase(L.Func_Resp_12), stringlib.stringtouppercase(L.Func_Resp_13), stringlib.stringtouppercase(L.Func_Resp_14), 
								 stringlib.stringtouppercase(L.Func_Resp_15), stringlib.stringtouppercase(L.Func_Resp_16), stringlib.stringtouppercase(L.Func_Resp_17),
								 stringlib.stringtouppercase(L.Func_Resp_18), stringlib.stringtouppercase(L.Func_Resp_19), stringlib.stringtouppercase(L.Func_Resp_20),
								 stringlib.stringtouppercase(L.Func_Resp_21), stringlib.stringtouppercase(L.Func_Resp_22), stringlib.stringtouppercase(L.Func_Resp_23)); 
								 
	self := L;

	end;

	IDEXEC_slim1 := normalize(IDEXEC_IN, 24, tslimcompanytitle(LEFT, counter));


	layout_IDEXEC_slim tformat(infoUSA.Layout_Cleaned_IDEXEC_file L) := transform

	self.company_title  := '';
	self                := L;
	end;

	IDEXEC_slim2 := project(IDEXEC_IN_filter,tformat(left));

	IDEXEC_slim  := IDEXEC_slim1(company_title <> '')  + IDEXEC_slim2;
								 
	IDEXEC_slim_filter := IDEXEC_slim(Exec_Clean_lname <> '' and firm_name = '' and former_name1 = '' and former_name2 = '');*/

	//split exec_title to company department
	/*
	layout_IDEXEC_temp := record
	string company_department;
	boolean flag;
	infoUSA.Layout_Cleaned_IDEXEC_file;
	end;

	searchpattern1 := '^(.*)-(.*)$';
	searchpattern2 := '^(.*),(.*)$';

	layout_IDEXEC_temp tformat(infoUSA.Layout_Cleaned_IDEXEC_file L) := transform

	self.flag := if(regexfind('CO-',stringlib.stringtouppercase(L.Exec_Title)), true, false);

	self.company_department := if(self.flag = false, (if(REGEXFIND(searchpattern1, trim(L.Exec_Title, left, right)) = true, REGEXFIND(searchpattern1,trim(L.Exec_Title, left, right), 2), 
					   if(REGEXFIND(searchpattern2, trim(L.Exec_Title, left, right)) = true, REGEXFIND(searchpattern2,trim(L.Exec_Title, left, right), 1), ''))), '');

	self.Exec_Title := if(self.flag = false, (if(REGEXFIND(searchpattern1, trim(L.Exec_Title, left, right)) = true, REGEXFIND(searchpattern1,trim(L.Exec_Title, left, right), 1), 
					   if(REGEXFIND(searchpattern2, trim(L.Exec_Title, left, right)) = true, REGEXFIND(searchpattern2,trim(L.Exec_Title, left, right), 2),L.Exec_Title))),L.Exec_Title);	


	self := L;

	end;

	IDEXEC_temp := project(IDEXEC_IN, tformat(left));*/

	//mapping to business contact

	business_header.Layout_Business_Contact_Full tIDEXECtoHEADER(infoUSA.Layout_Cleaned_IDEXEC_file L, integer C) := transform

	self.title                := L.Exec_Clean_title;
	self.fname                := L.Exec_Clean_fname;
	self.mname                := L.Exec_Clean_mname;
	self.lname                := L.Exec_Clean_lname;
	self.name_suffix          := L.Exec_Clean_name_suffix;
	self.company_title        := trim(stringlib.stringtouppercase(L.Exec_Title), left, right);
	self.vendor_id            := L.idexec_key;
	self.source               := 'II';
	self.name_score           := Business_Header.CleanName(L.Exec_Clean_fname,L.Exec_Clean_mname,L.Exec_Clean_lname, L.Exec_Clean_name_suffix)[142];
	self.prim_range		      := L.Firm_Address_Clean_prim_range ;
	self.predir			      := L.Firm_Address_Clean_predir;
	self.prim_name	          := L.Firm_Address_Clean_prim_name;
	self.addr_suffix	      := L.Firm_Address_Clean_addr_suffix;
	self.postdir		      := L.Firm_Address_Clean_postdir;
	self.unit_desig		      := L.Firm_Address_Clean_unit_desig;
	self.sec_range		      := L.Firm_Address_Clean_sec_range;
	self.city			      := L.Firm_Address_Clean_p_city_name;
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
	SELF.company_city         := L.Firm_Address_Clean_p_city_name;
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
