// =========================================================================================================
// Returns CALBUS's info from the source file; Used for search/report/subreport
// TODO: change comments below
// Assumptions:
//    only most recent records (for any given abi-number) are used;
//    contacts are rolled into child dataset, ordered by title-hierarchy; 
//    in rare cases when records (per contact) have different addresses, address is taken from the
//       "most VIP" contact (actually, all business info is taken from such a record);
//
// Result is penalized;
// The output layout is shared among subreport and search views (it's a little larger than any one of those)
// =========================================================================================================

IMPORT CALBUS, ut, doxie, codes, suppress, census_data, standard, AutoStandardI;

OUT_REC := CALBUS_Services.layouts.Layout_Common;
 
EXPORT out_rec GetCalbusByID (GROUPED DATASET (CALBUS_Services.layouts.id) in_ids) := FUNCTION

  doxie.MAC_Header_Field_Declare (); // unfortunately: only to get input city name! Should be gone after interfaces are done

  // choose best match (for penalties) between postal/vicinity cities
  GetBestCity (string25 vcity, string25 pcity) := MAP (
    vcity = '' => pcity, 
    pcity = '' => vcity,
    ut.StringSimilar (vcity, city_value) <= ut.StringSimilar (pcity, city_value) => vcity, pcity
  );

  // Fetch common info, calculating penalty for every record.
  OUT_REC GetCommonInfo (CALBUS.Key_CALBUS_Account_Nbr L) := TRANSFORM
    SELF.account_number := L.account_number;

		tempmodaddrbus := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
			export boolean allow_wildcard := false;
			export string city_field := GetBestCity (L.business_v_city_name, L.business_p_city_name);
			export string city2_field := '';
			export string pname_field := L.business_prim_name;
			export string postdir_field := L.business_postdir;
			export string prange_field := L.business_prim_range;
			export string predir_field := L.business_predir;
			export string state_field := L.business_st;
			export string suffix_field := L.business_addr_suffix;
			export string zip_field := L.business_zip5;
		end;
		
		tempmodaddrmail := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
			export boolean allow_wildcard := false;
			export string city_field := GetBestCity (L.mailing_v_city_name, L.mailing_p_city_name);
			export string city2_field := '';
			export string pname_field := L.mailing_prim_name;
			export string postdir_field := L.mailing_postdir;
			export string prange_field := L.mailing_prim_range;
			export string predir_field := L.mailing_predir;
			export string state_field := L.mailing_st;
			export string suffix_field := L.mailing_addr_suffix;
			export string zip_field := L.mailing_zip5;
		end;
		
		tempmodindvname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
			export boolean allow_wildcard := false;
			export string fname_field := L.Owner_fname;
			export string lname_field := L.Owner_lname;
			export string mname_field := L.Owner_mname;
		end;

		tempmodfirmname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
			export string cname_field := L.FIRM_NAME;
		end;

		tempmodownername := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
			export string cname_field := L.OWNER_NAME;
		end;
		
    addr_bus_penalty := AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddrbus); 
    addr_mail_penalty := AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddrmail);
		indv_name_penalty := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname);
		firm_name_penalty := AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodfirmname);
		owner_name_penalty := AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodownername);
		
    SELF.penalt := indv_name_penalty + 
									 min(firm_name_penalty,owner_name_penalty) +
									 min(addr_bus_penalty,addr_mail_penalty);

    // this transform will go away, when keys are adjusted to using named address layouts.
    SELF.business.prim_range := l.business_prim_range;
    SELF.business.predir := l.business_predir;
    SELF.business.prim_name := l.business_prim_name;
    SELF.business.addr_suffix := l.business_addr_suffix;
    SELF.business.postdir := l.business_postdir;
    SELF.business.unit_desig := l.business_unit_desig;
    SELF.business.sec_range := l.business_sec_range;
    SELF.business.p_city_name := l.business_p_city_name;
    SELF.business.v_city_name := l.business_v_city_name;
    SELF.business.st := l.business_st;
    SELF.business.zip5 := l.business_zip5;
    SELF.business.zip4 := l.business_zip4;
    SELF.business.fips_state := l.business_fips_state;
    SELF.business.fips_county := l.business_fips_county;
    SELF.business.addr_rec_type := l.business_addr_rec_type;
    // SELF.business.foreign_zip := l.business_foreign_zip;
    // SELF.business.foreign_country_name := l.business_country_name;

    SELF.mailing.prim_range := l.mailing_prim_range;
    SELF.mailing.predir := l.mailing_predir;
    SELF.mailing.prim_name := l.mailing_prim_name;
    SELF.mailing.addr_suffix := l.mailing_addr_suffix;
    SELF.mailing.postdir := l.mailing_postdir;
    SELF.mailing.unit_desig := l.mailing_unit_desig;
    SELF.mailing.sec_range := l.mailing_sec_range;
    SELF.mailing.p_city_name := l.mailing_p_city_name;
    SELF.mailing.v_city_name := l.mailing_v_city_name;
    SELF.mailing.st := l.mailing_st;
    SELF.mailing.zip5 := l.mailing_zip5;
    SELF.mailing.zip4 := l.mailing_zip4;
    SELF.mailing.fips_state := l.mailing_fips_state;
    SELF.mailing.fips_county := l.mailing_fips_county;
    SELF.mailing.addr_rec_type := l.mailing_addr_rec_type;
    // SELF.mailing.foreign_zip := l.business_foreign_zip;
    // SELF.mailing.foreign_country_name := l.business_country_name;

    // set state
    SELF.business.state := codes.general.state_long (L.business_st);	
    SELF.mailing.state := codes.general.state_long (L.business_st);	

    // county full name calculated after
    SELF.business.county := '';
    SELF.mailing.county := '';

    // clean owner name
	  SELF.name.title := L.Owner_title;
	  SELF.name.fname := L.Owner_fname;
	  SELF.name.mname := L.Owner_mname;
	  SELF.name.lname := L.Owner_lname;
	  SELF.name.name_suffix := L.Owner_name_suffix;
	  SELF.name.name_score := L.Owner_name_score;

    SELF := L;
  END;

  src_fetched := JOIN (in_ids, CALBUS.Key_CALBUS_Account_Nbr,
                   keyed (Left.account_number = Right.account_number),
									 transform(right),
                   // GetCommonInfo (Right),
                   KEEP (1000)); // 1:1 relation
	
	fetched := project(dedup(sort(src_fetched,account_number,-process_date),account_number),GetCommonInfo(Left));

  // fetched := src_fetched;
  // add county name
  census_data.MAC_Fips2County_Keyed (fetched, business.st, business.fips_county, business.county, ds_cnty);
  census_data.MAC_Fips2County_Keyed (ds_cnty, mailing.st, mailing.fips_county, mailing.county, ds_cnty_2);

  res := ds_cnty_2;
  RETURN res;
END;