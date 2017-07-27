// =========================================================================================================
// Returns deadco's info from the source file;
// Result is: 
//   penalized;
//   pulled by bdid, tmsid
// The output layout is shared among subreport and search views (it's a little larger than any one of those)
// =========================================================================================================

IMPORT InfoUSA, ut, doxie, codes, suppress, census_data, AutoStandardI;

out_rec := DeadcoV2_Services.layouts.ReportSearchShared;
 
EXPORT out_rec GetDeadcoByID (GROUPED DATASET (DeadcoV2_Services.layouts.id) in_ids) := FUNCTION

  // fetch franchise description (up to 6 different values)
  fr_rec := DeadcoV2_Services.layouts.layout_franchise;
  GetFranchise (string scode, string fr_code) := FUNCTION
    set of string1 fr_codes := [fr_code[1], fr_code[2], fr_code[3], fr_code[4], fr_code[5], fr_code[6]];
    key_read := InfoUSA.Key_ABIUS_FranCode (keyed (sic_code = scode), keyed (franchise_char IN fr_codes));
    franchise := LIMIT (key_read, 6, keyed, SKIP); // up to 6 chars only
    return PROJECT (franchise (description != ''), fr_rec);
  END;

  out_rec GetCommonInfo (DeadcoV2_Services.layouts.id L, InfoUSA.key_deadco_abi_number R) := TRANSFORM

		tempmodindvname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
			export boolean allow_wildcard := false;
			export string fname_field := r.name.fname;
			export string lname_field := r.name.lname;
			export string mname_field := r.name.mname;
		end;
		tempmodaddr := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
			export boolean allow_wildcard := false;
			export string city_field := R.addr.p_city_name;
			export string city2_field := '';
			export string pname_field := R.addr.prim_name;
			export string postdir_field := R.addr.postdir;
			export string prange_field := R.addr.prim_range;
			export string predir_field := R.addr.predir;
			export string state_field := R.addr.st;
			export string suffix_field := R.addr.addr_suffix;
			export string zip_field := R.addr.zip5;
		end;
		tempmodcounty := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_County.full,opt))
			export string county_field := R.addr.fips_county;
		end;
		tempmodphone := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
			export string phone_field := R.phone;
		end;
		SELF.penalt :=
			AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname) +
			AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr) +
			AutoStandardI.LIBCALL_PenaltyI_County.val(tempmodcounty) +
			AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone);

    // create secondary SICs descriptions child
    sec_sics := DATASET ([
      {R.SECONDARY_SIC_1, R.secondary_sic_desc1}, {R.SECONDARY_SIC_2, R.secondary_sic_desc2},
      {R.SECONDARY_SIC_3, R.secondary_sic_desc3}, {R.SECONDARY_SIC_4, R.secondary_sic_desc4}
    ], DeadcoV2_Services.layouts.layout_secondary_sic) (code != '');
    SELF.SECONDARY_SIC := sec_sics;

    //create franchise descriptions child
    SELF.franchise := GetFranchise (R.sic_cd, R.franchise_cd);

    SELF.name := R.name;

    SELF.addr.state := codes.general.state_long (R.addr.st);	
    SELF.addr.county := ''; //this one is done below
    SELF.addr := R.addr;

    SELF.gender_exp := codes.GENERAL.gender (stringlib.stringtouppercase (R.GENDER_CD)[1]);
    SELF := R;
  END;
  
  fetched := JOIN (in_ids, InfoUSA.key_deadco_abi_number,
                   keyed (Left.abi_number = Right.abi_number),
                   GetCommonInfo (Left, Right),
                   KEEP (1)); //unique

  //TODO: pull by bdid, abi_number?

  // add county name
  census_data.MAC_Fips2County_Keyed (fetched, addr.st, addr.fips_county, addr.county, ds_cnty_1);

  res := ds_cnty_1;
  RETURN res;
END;
