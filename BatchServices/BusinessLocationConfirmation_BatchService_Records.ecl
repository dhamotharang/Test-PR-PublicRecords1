IMPORT Advo, AutoStandardI, Business_Header, Business_Header_SS, BusReg,
       Corp2, Doxie, doxie_cbrs, ut, STD;
	
	BLC_Layouts := BusinessLocationConfirmation_BatchService_Layouts;
	BLC_Functions := BusinessLocationConfirmation_BatchService_Functions;
	BLC_Transforms := BusinessLocationConfirmation_BatchService_Transforms;
	BLC_Constants := BusinessLocationConfirmation_BatchService_Constants;
	UCase := STD.Str.ToUpperCase;
	
EXPORT BusinessLocationConfirmation_BatchService_Records(DATASET(BLC_Layouts.Input) input_data) := FUNCTION

  // Sorting input for the sequence numbers
  SortedInputData := SORT(input_data, acctno, company_name, owner_name_last, owner_name_middle, owner_name_first, fein, RECORD);

	Cleaned_Input := PROJECT(SortedInputData, BLC_Transforms.xfm_clean_input(LEFT, COUNTER));
	
 	//************************************************************************
	//*
  //* Split input into datasets that represent the specific cases being
	//* handled.  The major categories are those with address information and
	//* those without.  All subsequent subsets are derived from those two
	//* cases.
	//*
	//************************************************************************
	Input_With_Address := Cleaned_Input(prim_name != '');
	Input_Without_Address := Cleaned_Input(prim_name = '');
	
	Input_With_Proper_Address := Input_With_Address(z5 != '' OR (p_city_name != '' AND st != ''));
	
	Input_With_Company_Name := Input_With_Proper_Address(company_name != '');
	Input_With_Owner_Name := Input_With_Proper_Address(owner_name_first != '' OR owner_name_last != '');
	Input_With_Address_Only := Input_With_Proper_Address(company_name = '' AND owner_name_first = '' AND owner_name_middle = '' AND owner_name_last = '');
	
	Input_With_Fein := Input_Without_Address(company_name != '' AND fein != '');
	
	Input_With_City_State_Zip_Error := Input_With_Address(z5 = '' AND (p_city_name = '' OR st = ''));
	Input_With_Fein_Error := Input_Without_Address(fein = '');
	Input_With_Fein_Only_Error := Input_Without_Address(fein != '' AND company_name = '');
		
	//************************************************************************
	//*
  //* Take care of records with an address and a company name
	//*	
	//************************************************************************	
	
	// Find all BDIDs associated with a company name
	Company_Name_BDID_Recs := BLC_Functions.fn_find_bdids_and_append(Input_With_Company_Name);
			
	//************************************************************************
	//*
  //* Take care of records with an address and an owner name
	//*	
	//************************************************************************	

	// Find all BDIDs associated with an address (the owner name will be attached to all, regardless)
	Owner_Name_BDID_Recs := BLC_Functions.fn_find_bdids_and_append(Input_With_Owner_Name);
		
	// Find out who's really attached to what BDID
  glb_ok:=ut.PermissionTools.glb.ok(AutoStandardI.InterfaceTranslator.glb_purpose.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.glb_purpose.params)));
	Owner_Name_Result :=
	  DEDUP(
	    SORT(
	      JOIN(Owner_Name_BDID_Recs, Business_Header.Key_Business_Contacts_BDID,
	        KEYED(LEFT.bdid = RIGHT.bdid)
			    AND UCase(LEFT.input_owner_name_first) = RIGHT.fname
// For now, going to keep the matching a bit looser and not require the middle names exactly match
//		      AND UCase(LEFT.input_owner_name_middle) = RIGHT.mname
		      AND UCase(LEFT.input_owner_name_last) = RIGHT.lname
			    AND RIGHT.company_prim_name != ''
		      AND RIGHT.record_type = BLC_Constants.CURRENT AND
          (~right.glb OR glb_ok),
					BLC_Transforms.xfm_owner_name_input(LEFT, RIGHT)),
		    bdid, input_owner_name_last, input_owner_name_first, input_owner_name_middle, -contact_score, -date_last_seen, RECORD),
			bdid);
			
	//************************************************************************
	//*
  //* Take care of records with addresses only
	//*	
	//************************************************************************	
	
	// Find all BDIDs associated with an address only
	Address_Only_BDID_Recs := BLC_Functions.fn_find_bdids_and_append(Input_With_Address_Only);
	
	Address_Only_BDID_Projected_Recs :=
	  PROJECT(
		  Address_Only_BDID_Recs,
		  TRANSFORM(BLC_Layouts.Final_Plus,
			  SELF.address_only := 'Y';
				SELF := LEFT));
	
	//************************************************************************
	//*
  //* Take care of records with company name and FEIN only
	//*	
	//************************************************************************	
	
	Business_Header_SS.MAC_BDID_Append(Input_With_Fein, Fein_Recs, 1);
	
	Fein_Projected_Recs :=
	  PROJECT(
	    JOIN(Input_With_Fein, Fein_Recs,
		    LEFT.seq = RIGHT.seq),
			BLC_Layouts.Final_Plus);
		
	//************************************************************************
	//*
  //* Get a combined "best" dataset to work with
	//*	
	//************************************************************************
	
  // Combine 3 cases into 1: company name and address, address only, and company name and fein
	Combined_Recs := Company_Name_BDID_Recs + Address_Only_BDID_Projected_Recs + Fein_Projected_Recs;
	
	// Take combined result set and find the best information for each record
	Combined_Best_Result :=
	  JOIN(Combined_Recs, Business_Header.Key_BH_Best,
	    KEYED(LEFT.bdid = RIGHT.bdid),
		  BLC_Transforms.xfm_input_to_best(LEFT, RIGHT),
		  KEEP (1), LIMIT (0));
	  
  // Combine all the individual results into one dataset for final processing
	Combined_Result := Combined_Best_Result + Owner_Name_Result;	
	
	//************************************************************************
	//*
  //* This is the section containing code that must be applied to all
	//* records, regardless of what type they are.
	//*	
	//************************************************************************	
		
	// ** Find the earliest date first seen and the latest date last seen for each record **
  glb_purpose:=AutoStandardI.InterfaceTranslator.glb_purpose.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.glb_purpose.params));
  Raw_Dates_Result :=
	  PROJECT(
	    SORT(
        JOIN(Combined_Result, Business_Header_SS.Key_BH_BDID_pl,
          KEYED(LEFT.bdid = RIGHT.bdid)
          AND (RIGHT.dt_first_seen != 0 OR RIGHT.dt_last_seen != 0) AND
          ut.PermissionTools.glb.SrcOk(glb_purpose,right.source),
				  KEEP(20000), // This is an arbitrary number and should be good enough to get the proper info.
				  LIMIT(100000, SKIP)), // Hopefully no bdid has more than 100000 rows on the right side
	      company_name, bdid, RECORD),
		  BLC_Layouts.Date);
	
  Padded_Date_Records := PROJECT(Raw_Dates_Result, BLC_Transforms.PadDate(LEFT));

  Date_Records :=
	  DENORMALIZE(Combined_Result, Padded_Date_Records,
      LEFT.best_company_name = RIGHT.company_name
	    AND LEFT.bdid = RIGHT.bdid,
	    GROUP,
	    BLC_Transforms.DetermineDateSeen(LEFT, ROWS(RIGHT)));
			
	// Calculate the date_last_seen "x" months fields and change the dataset to the correct type
	Dates_Result := PROJECT(Date_Records, BLC_Transforms.xfm_date_last_seen_fields(LEFT));
	
	// ** Find the best SIC Code **
	SIC_Result :=
	  DENORMALIZE(Dates_Result, Business_Header.Key_SIC_Code,
		  KEYED(LEFT.bdid = RIGHT.bdid),
			GROUP,
			TRANSFORM(BLC_Layouts.Final_Plus,
			  // Find the most frequently used SIC Code.  If there are no winners or there's multiple results
				// with the same "highest count", then we use the smallest SIC Code for that group of records.
			  SELF.best_sic_code :=
					SORT(
					  TABLE(
							ROWS(RIGHT),
							{sic_code, UNSIGNED2 sic_code_count := COUNT(GROUP)},
							sic_code),
						-sic_code_count, (UNSIGNED)sic_code, RECORD)[1].sic_code;				
				SELF := LEFT;));
	
	// ** Attach needed information from ADVO **
	Advo_Result :=
	  JOIN(SIC_Result, Advo.Key_Addr1,
	    KEYED(LEFT.best_prim_name != ''
			      AND LEFT.best_zip = RIGHT.zip
						AND LEFT.best_prim_range = RIGHT.prim_range
						AND LEFT.best_prim_name = RIGHT.prim_name
		        AND LEFT.best_addr_suffix = RIGHT.addr_suffix
			      AND LEFT.best_predir = RIGHT.predir
			      AND LEFT.best_postdir = RIGHT.postdir
		        AND LEFT.best_sec_range = RIGHT.sec_range),
		  BLC_Transforms.xfm_advo_input(LEFT, RIGHT),
		  LEFT OUTER);
	
	// ** Check against Real Time Phones and/or EDA Phones to verify the phone **
  Address_Verify_Result := IF(BLC_Constants.INCLUDE_REAL_TIME_PHONES,
	                            BLC_Functions.fn_get_real_time_phone_info(Advo_Result),
															BLC_Functions.fn_get_gong_phone_info(Advo_Result, BLC_Constants.INCLUDE_REAL_TIME_PHONES));
	
  Different_Address_Verify_Result := BLC_Functions.fn_get_gong_phone_info_pt2(Address_Verify_Result);

	// ** Go against Business Registration (Accutrend) **
		
	// Those records with owner code of C are corporate data, which we do not want to process.
	// The same applies to any records with a type of INITIAL.  There's no need to process them because
	// the connection to Corp2 will take care of these records.  This reasoning was explained by Rosemary.
	Business_Registration_Recs :=
	  JOIN(Different_Address_Verify_Result, BusReg.key_busreg_company_bdid,
		  KEYED(LEFT.bdid = RIGHT.bdid)
			AND TRIM(RIGHT.ofc1_type, LEFT, RIGHT) != 'INITIAL'
			AND TRIM(RIGHT.ownr_code, LEFT, RIGHT) != 'C',
			BLC_Transforms.xfm_file_date(LEFT, RIGHT),
			LEFT OUTER);
			
	// Take the record that has the most recent filing date and figure out the field from that topmost record.
	// If we have a tie for the filing date, take the type that isn't empty first.
	Business_Registration_Result :=
	  PROJECT(
	    DEDUP(
	      SORT(Business_Registration_Recs,
		      acctno, seq, bdid, -actual_file_date, IF(business_registration_status != '', 0, 1), RECORD),
			  acctno, seq, bdid),
			BLC_Transforms.xfm_bus_reg_input(LEFT));

	// ** Attach needed information from Corp2 **
	// Note that the logic below may seem to get the "best", but with Corporate data, it's impossible to
	// know for sure.  We're simply presenting what we think is correct to the customer along with the 
	// knowledge that this should be viewed as part of the whole in determining if a business is truly active
	// or not.	
  Full_Corp2_Recs :=
	  JOIN(Business_Registration_Result, Corp2.Key_Corp_BdidPL,
		  KEYED(LEFT.bdid = RIGHT.bdid)
			AND RIGHT.record_type = BLC_Constants.CURRENT
			AND RIGHT.corp_ln_name_type_desc = 'LEGAL'
			AND LEFT.best_state = RIGHT.corp_state_origin,
			BLC_Transforms.get_corp_fields(LEFT, RIGHT),
			LEFT OUTER);
			
	Corp2_Deduped_Result :=
	  PROJECT(
		  DEDUP(
	      SORT(Full_Corp2_Recs,
		      acctno, seq, bdid, -corp_dt_last_seen, -corp_status_date),
				acctno, seq, bdid),
			BLC_Layouts.Final_Plus);
			
	Corp2_Tabled_Results :=
	  PROJECT(
	    TABLE(Full_Corp2_Recs, {bdid, UNSIGNED2 the_count := COUNT(GROUP)}, bdid, FEW),
		  BLC_Layouts.Corp_Count_Rec);
	
	Corp2_Result :=
	  JOIN(Corp2_Deduped_Result, Corp2_Tabled_Results,
		  LEFT.bdid = RIGHT.bdid,
			BLC_Transforms.xfm_corp2_input(LEFT, RIGHT),
			LEFT OUTER);
		
	// ** Attach business contact information (5 contacts worth) **
	list_of_bdids :=
	  DEDUP(
		  PROJECT(Corp2_Result, doxie_cbrs.layout_references),
			bdid);
  doxie_cbrs.layout_contacts ds_contacts_raw :=
	  doxie_cbrs.contact_records(list_of_bdids)(record_type = BLC_Constants.CURRENT AND TRIM(lname) != '');

  // Get all contacts that have a company address attached to them.  The newest ones are the ones we want.
	ds_contacts_with_ranking :=
	  PROJECT(
	    SORT(
	      JOIN(ds_contacts_raw, doxie_cbrs.executive_titles,
	        LEFT.company_title = RIGHT.stored_title
			    AND LEFT.company_prim_name != ''),
			  bdid, title_rank, lname, mname, fname, -dt_last_seen, RECORD),
			BLC_Layouts.Contact);

  // Ignoring the middle name, due to the same person having many variations on that field
  ds_contacts_deduped := DEDUP(ds_contacts_with_ranking, bdid, title_rank, lname, fname);
		
	Contact_Result :=
	  DENORMALIZE(
		  Corp2_Result, ds_contacts_deduped,
			LEFT.bdid = RIGHT.bdid,
			BLC_Transforms.xfm_contacts(LEFT, RIGHT, COUNTER));
		
	//************************************************************************
	//*
  //* Take care of the error records 
	//*
	//************************************************************************
	
	BLC_Layouts.Final_Plus xfm_fein_error_input(BLC_Layouts.BatchInput L) := TRANSFORM
	  SELF.error_message := 'The data for this record was incomplete.  If there is no address information, then there must be a FEIN and company name included.';
	  SELF := L;
	END;
	Fein_Error_Result := PROJECT(Input_With_Fein_Error, xfm_fein_error_input(LEFT));
	
	BLC_Layouts.Final_Plus xfm_fein_only_error_input(BLC_Layouts.BatchInput L) := TRANSFORM
	  SELF.error_message := 'The data for this record was incomplete.  There cannot be just a FEIN only, there must be a company name provided too.';
	  SELF := L;
	END;
	Fein_Only_Error_Result := PROJECT(Input_With_Fein_Only_Error, xfm_fein_only_error_input(LEFT));
	
	BLC_Layouts.Final_Plus xfm_city_state_zip_error_input(BLC_Layouts.BatchInput L) := TRANSFORM
	  SELF.error_message := 'The data for this record was incomplete.  There must either be a city and state combination or a zip code provided.';
	  SELF := L;
	END;
	City_State_Zip_Error_Result := PROJECT(Input_With_City_State_Zip_Error, xfm_city_state_zip_error_input(LEFT));
	
	Error_Result := Fein_Error_Result + Fein_Only_Error_Result + City_State_Zip_Error_Result;
	
	// ** Get final results **
	Final_Recs := Contact_Result + Error_Result;
	
  Final_Result :=
	  PROJECT(
		  SORT(Final_Recs, acctno, seq, RECORD),
			BLC_Layouts.Final);
	
//OUTPUT(Input_With_Address, named('haveaddress'));
//OUTPUT(Input_Without_Address, named('noaddress'));
//OUTPUT(Input_With_Company_Name, named('companyname'));
//OUTPUT(Input_With_Owner_Name, named('ownername'));
//OUTPUT(Input_With_Address_Only, named('addressonly'));
//OUTPUT(Input_With_Fein, named('feinonly'));
//OUTPUT(Input_With_FEIN_Error, named('badinputFEIN'));
//OUTPUT(Input_With_City_State_Zip_Error, named('badinputCITYZIP'));

//OUTPUT(Company_Name_BDID_Recs, named('listofcompanynameBDIDS'));

//OUTPUT(Owner_Name_BDID_Recs, named('listofownernameBDIDS'));
//OUTPUT(Owner_Name_Result, named('ownernameRESULTS'));

//OUTPUT(Address_Only_BDID_Recs, named('listofaddressBDIDsAUTOHEADER'));
//OUTPUT(Address_Only_BDID_Projected_Recs, named('addressPROJECTEDrecs'));

//OUTPUT(Fein_Recs, named('FEINmacbdidconnection'));
//OUTPUT(Fein_Projected_Recs, named('FEINprojectedRECS'));

//OUTPUT(Combined_Recs, named('combinedRECS'));
//OUTPUT(Combined_Best_Result, named('combinedbestRESULTS'));
//OUTPUT(Combined_Result, named('combinedRESULTS'));

//OUTPUT(Raw_Dates_Result, named('rawDATES'));
//OUTPUT(Dates_Result, named('companywithDATERESULTS'));

//OUTPUT(SIC_Result, named('companywithSICcodes'));

//OUTPUT(Advo_Result, named('companywithadvoRESULTS'));

//OUTPUT(Address_Verify_Result, named('companynameaddressverify'));
//OUTPUT(Different_Address_Verify_Result, named('companyDIFFERENTnameaddressverify'));

//OUTPUT(Business_Registration_Recs, named('busregrecords'));
//OUTPUT(Business_Registration_Result, named('busregRESULTS'));

//OUTPUT(Full_Corp2_Recs, named('FULLcorp2RESULTS'));
//OUTPUT(Corp2_Result, named('companywithcorp2RESULTS'));

//OUTPUT(list_of_bdids, named('listofBDIDs'));
//OUTPUT(ds_contacts_raw, named('contactsforsaidBDIDs'));
//OUTPUT(ds_contacts_with_ranking, named('contactsforsaidBDIDswithRANKING'));
//OUTPUT(ds_contacts_deduped, named('contactsforsaidBDIDswithRANKINGDEDUPED'));
//OUTPUT(Contact_Result, named('CONTACTcompanynameoutput'));

//OUTPUT(Error_Result, named('errorresults'));

//OUTPUT(Final_Recs, named('finalrecordsUNdedupedetc'));
//OUTPUT(COUNT(Final_Result), named('finalrecordsCOUNT'));
	
	RETURN Final_Result;
	
END;
