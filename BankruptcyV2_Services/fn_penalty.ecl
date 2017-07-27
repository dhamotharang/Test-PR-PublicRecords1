import AutoStandardI, doxie, bankruptcyv3, bankruptcyv2_services;

gm 							:= AutoStandardI.GlobalModule();
inner_params := input.params;

temp_mod_one := module(project(gm,inner_params,opt))end;
temp_mod_two := module(project(gm,inner_params,opt))
	export firstname := gm.entity2_firstname;
	export middlename := gm.entity2_middlename;
	export lastname := gm.entity2_lastname;
	export unparsedfullname := gm.entity2_unparsedfullname;
	export allownicknames := gm.entity2_allownicknames;
	export phoneticmatch := gm.entity2_phoneticmatch;
	export companyname := gm.entity2_companyname;
	export addr := gm.entity2_addr;
	export city := gm.entity2_city;
	export state := gm.entity2_state;
	export zip := gm.entity2_zip;
	export zipradius := gm.entity2_zipradius;
	export phone := gm.entity2_phone;
	export fein := gm.entity2_fein;
	export bdid := gm.entity2_bdid;
	export did := gm.entity2_did;
	export ssn := gm.entity2_ssn;
end;


export fn_penalty(recordof(bankruptcyv3.key_bankruptcyV3_search_full_bip()) l) := function
 
		tempmodi_1 := module(project(temp_mod_one,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
							export boolean allow_wildcard := false;
							export string city_field := l.v_city_name;
							export string city2_field := '';
							export string county_field := '';
							export string did_field := l.did;
							export string dob_field := '';
							export string fname_field := l.fname;
							export string lname_field := l.lname;
							export string mname_field := l.mname;
							export string phone_field := l.phone;
							export string pname_field := l.prim_name;
							export string postdir_field := l.postdir;
							export string prange_field := l.prim_range;
							export string predir_field := l.predir;
							export string ssn_field := IF(l.ssn<>'' and l.ssn[9]<>'',l.ssn,l.app_ssn);
							export string state_field := l.st;
							export string suffix_field := l.addr_suffix;
							export string zip_field := l.zip;
						end;
		tempmodi_2 := module(project(temp_mod_two,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
					export boolean allow_wildcard := false;
					export string city_field := l.v_city_name;
					export string city2_field := '';
					export string county_field := '';
					export string did_field := l.did;
					export string dob_field := '';
					export string fname_field := l.fname;
					export string lname_field := l.lname;
					export string mname_field := l.mname;
					export string phone_field := l.phone;
					export string pname_field := l.prim_name;
					export string postdir_field := l.postdir;
					export string prange_field := l.prim_range;
					export string predir_field := l.predir;
					export string ssn_field := IF(l.ssn<>'' and l.ssn[9]<>'',l.ssn,l.app_ssn);
					export string state_field := l.st;
					export string suffix_field := l.addr_suffix;
					export string zip_field := l.zip;
				end;
			tempmodbn_1 := module(project(temp_mod_one,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
				export string cname_field := l.cname;
			end;
			tempmodbn_2 := module(project(temp_mod_two,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
				export string cname_field := l.cname;
			end;
			tempmodf_1 := module(project(temp_mod_one,AutoStandardI.LIBIN.PenaltyI_FEIN.full,opt))
				export string fein_field := l.tax_id;
			end;
			tempmodf_2 := module(project(temp_mod_two,AutoStandardI.LIBIN.PenaltyI_FEIN.full,opt))
				export string fein_field := l.tax_id;
			end;
			tempmodb_1 := module(project(temp_mod_one,AutoStandardI.LIBIN.PenaltyI_BDID.full,opt))
				export string bdid_field := l.bdid;
			end;
			tempmodb_2 := module(project(temp_mod_two,AutoStandardI.LIBIN.PenaltyI_BDID.full,opt))
				export string bdid_field := l.bdid;
			end;
			
			penalt_1 := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempmodi_1) + 
									AutoStandardI.LIBCALL_PenaltyI_BDID.val(tempmodb_1) +
									AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbn_1) +
									AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tempmodf_1);
			
			penalt_2 := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempmodi_2) + 
									AutoStandardI.LIBCALL_PenaltyI_BDID.val(tempmodb_2) +
									AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbn_2) + 
									AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tempmodf_2);
			penalt := if(gm.TwoPartySearch, max(penalt_1,penalt_2),penalt_1); 
								
	return penalt;
end;