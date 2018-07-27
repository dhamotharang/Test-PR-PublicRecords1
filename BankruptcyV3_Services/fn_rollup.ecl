import AutoStandardI, bankruptcyv3, bankruptcyv3_services, codes, 
       doxie, doxie_cbrs, banko, suppress;

export fn_rollup(
	dataset(doxie.layout_references) in_dids,
	dataset(doxie_cbrs.layout_references) in_bdids,
	dataset(bankruptcyv3_services.layouts.layout_tmsid_ext) in_tmsids0,
	unsigned in_limit,
	string6 in_ssn_mask,
	boolean in_isSearch = false,
	boolean in_all_bks_for_all_debtors = false,
	string1 in_party_type = '',
	string2 in_filing_jurisdiction = '',
	boolean isFCRA = false,
	string4 in_SSNLast4 = '',
	boolean include_dockets = false,
	string8 lower_entered_date = '',
	string8 upper_entered_date = '',
	string32 appType,
  boolean isCaseNumberSearch = false
	) :=
		function 
			doxie.MAC_Header_Field_Declare(isFCRA)
			
			//special search case for partial SSNs otherwise go standard method of finding DIDs.
			                                        //force FCRA only when using SSNLast4 until it is needed and KEY is built.
			 in_tmsids1 := if (in_SSNLast4 <> '' and isFCRA, 
			                    bankruptcy_ids_ssn4(in_limit,in_SSNLast4, in_filing_jurisdiction,in_party_type,lname_value,fname_value,isFCRA),
                    		    bankruptcy_ids(in_dids,in_bdids,in_tmsids0,in_limit,in_party_type, isFCRA,isCaseNumberSearch)
			                    );
  
			temp_records_search0 :=
				join(
					in_tmsids1,
					bankruptcyv3.key_bankruptcyv3_search_full_bip(isFCRA),
					keyed(left.tmsid = right.tmsid),
					transform(BankruptcyV3_Services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers,
            self.full_case_number        := '',
						self                         := right,
						self                         := left),
					limit(0),
          keep(BankruptcyV3_Services.consts.KEEP_LIMIT));
			
			temp_debtor_dids := project(dedup(sort(temp_records_search0((unsigned)did != 0 and name_type[1] = BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),did),did),transform(doxie.layout_references,self.did := (unsigned)left.did));
			temp_debtor_bdids := project(dedup(sort(temp_records_search0((unsigned)bdid != 0 and name_type[1] = BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),bdid),bdid),transform(doxie_cbrs.layout_references,self.bdid := (unsigned)left.bdid));
			temp_addl_tmsids := bankruptcyv3_services.bankruptcy_ids(temp_debtor_dids,temp_debtor_bdids,in_tmsids0(false),if(in_limit = 0,0,in_limit - count(in_tmsids1)),in_party_type, isFCRA,isCaseNumberSearch);
			in_tmsids := in_tmsids1 + if(in_all_bks_for_all_debtors and (in_limit = 0 or count(in_tmsids1) < in_limit),temp_addl_tmsids);
      
			temp_records_search1 :=
				join(
					temp_addl_tmsids,
					bankruptcyv3.key_bankruptcyv3_search_full_bip(isFCRA),
					keyed(left.tmsid = right.tmsid),
					transform(bankruptcyv3_services.Layout_key_bankruptcyv3_search_full_bip_plus_case_numbers,
					  self.full_case_number        := '',
						self                         := right,
						self                         := left),
					limit(0),
          keep(BankruptcyV3_Services.consts.KEEP_LIMIT));

			temp_records_search := temp_records_search0 + if(in_all_bks_for_all_debtors and (in_limit = 0 or count(in_tmsids1) < in_limit),temp_records_search1);
			// Pull any debtor records that are in the pull file
			temp_records_searchD := if (isFCRA, temp_records_search(name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR), BankruptcyV3_Services.fn_pullIDs(temp_records_search(name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),false,appType));
			// Now, join back against our TMSIDs... and leave only those TMSIDs that have NO suppressed debtors.
			in_tmsids_less_pulled_by_debtor := JOIN(in_tmsids, DEDUP(SORT(temp_records_searchD,tmsid),tmsid),
				LEFT.tmsid = RIGHT.tmsid,
				TRANSFORM(LEFT));
			
			// Pull any attorney records that are in the pull file
			temp_records_searchA := if (isFCRA, temp_records_search(name_type[1]='A'), BankruptcyV3_Services.fn_pullIDs(temp_records_search(name_type[1]='A'),true,appType)); // TRUE here means to pull ONLY the attorney being suppressed, not ALL attorneys
			// Pull any other records that are in the pull file
			temp_records_searchOthers := if (isFCRA, temp_records_search(name_type[1]<>'A' AND name_type[1]<>BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),
			                                 BankruptcyV3_Services.fn_pullIds(temp_records_search(name_type[1]<>'A' AND name_type[1]<>BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),true,appType)); // this may be the empty set all the time??
			// Add together all records NOT pulled (including debtors)
			temp_records := sort(temp_records_searchD + temp_records_searchA + temp_records_searchOthers, tmsid);
			
      //			
      // need to add to temp_records_search the TMSID of the trustee record
			//
			// 
			// pull IDs using the party info, then join those IDs back against the input set of tmsids
			
			temp_records_main := 
				join(
					in_tmsids_less_pulled_by_debtor,
					bankruptcyv3.key_bankruptcyv3_main_full(isFCRA),
					keyed(left.tmsid = right.tmsid),
					transform(
						{recordof(bankruptcyv3.key_bankruptcyv3_main_full()),boolean isDeepDive, boolean suppressT}, 											
						self.suppressT := false;
					  self           := right,
						self           := left),
					limit(0),
          keep(BankruptcyV3_Services.consts.KEEP_LIMIT));
					
			temp_records_main_final := if(isFCRA, temp_records_main, bankruptcyv3_services.fn_pullTrusteeIDs(temp_records_main,appType));
			
			// filter by jurisdiction if provided
			temp_records_main_jur := IF(in_filing_jurisdiction <> '', 
																	temp_records_main_final(filing_jurisdiction = in_filing_jurisdiction),
																	temp_records_main_final);
																	
      // call suppress macro to suppress the trustee app_ssn field based on app_ssn setting.																	
      Suppress.MAC_Mask(temp_records_main_jur, temp_records_main_jur_suppressed, app_ssn, null, true, false, maskVal:=in_ssn_mask);																	
					
			temp_top_slim :=
				project(
					temp_records_main_jur_suppressed,
					transform(
						bankruptcyv3_services.layouts.layout_rollup,
						self.filer_type_ex := codes.BANKRUPTCIES.FILER_TYPE(left.filer_type),
						self.trustee.DID := if (left.suppressT,'', left.DID);
						self.trustee.trusteeID := left.trusteeID;
						self.trustee.app_SSN := if (left.suppressT, '', left.app_SSN);
					  self.trustee.orig_name := if (left.suppressT, '', left.trusteeName);
						self.trustee.orig_address := if (left.suppressT, '', left.trusteeAddress);
						self.trustee.orig_city := if (left.suppressT, '', left.trusteeCity);
						self.trustee.orig_st := if (left.suppressT, '', left.trusteeState);
						self.trustee.orig_zip := if (left.suppressT, '', left.trusteeZip);
						self.trustee.orig_zip4 := if (left.suppressT, '', left.trusteeZip4);
						self.trustee.phone := if (left.suppressT, '', left.trusteePhone);
						// cleaned names							
						self.trustee := if (~left.suppressT, left);   // pick up all cleaned name/address fields
						self := left,
						self := []));
						
			temp_top_dedup :=
				dedup(
					sort(
						temp_top_slim,
						tmsid,record),
					tmsid);
			temp_pen_slim :=
				project(
					temp_records,
					transform(
						bankruptcyv3_services.layouts.layout_rollup,
						tempmodi := module(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
							export boolean allow_wildcard := false;
							export string city_field := left.v_city_name;
							export string city2_field := '';
							export string county_field := '';
							export string did_field := left.did;
							export string dob_field := '';
							export string fname_field := left.fname;
							export string lname_field := left.lname;
							export string mname_field := left.mname;
							export string phone_field := left.phone;
							export string pname_field := left.prim_name;
							export string postdir_field := left.postdir;
							export string prange_field := left.prim_range;
							export string predir_field := left.predir;
							export string ssn_field := IF(left.ssn<>'' and left.ssn[9]<>'',left.ssn,left.app_ssn);
							export string state_field := left.st;
							export string suffix_field := left.addr_suffix;
							export string zip_field := left.zip;
						end;
						tempmodbn := module(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
							export string cname_field := left.cname;
						end;
						tempmodf := module(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_FEIN.full,opt))
							export string fein_field := left.tax_id;
						end;
						tempmodb := module(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_BDID.full,opt))
							export string bdid_field := left.bdid;
						end;
						self.penalt :=
							AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempmodi)+
							AutoStandardI.LIBCALL_PenaltyI_BDID.val(tempmodb) +
							AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbn) +
							AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tempmodf),
						self.matched_party.party_type := IF(DisplayMatchedParty_value
						                                   ,IF(left.name_type=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR
						                                   ,left.debtor_type
																							 ,left.name_type)
																							 ,''),
						self.matched_party.parsed_party := IF(DisplayMatchedParty_value,LEFT),
						self.matched_party.address :=  IF(DisplayMatchedParty_value,LEFT),
						self.matched_party.did := left.did,
						self := left,
						self := []));
			temp_pen_dedup :=
				dedup(
					sort(
						temp_pen_slim,
						tmsid,penalt,record),
					tmsid);
			temp_top_join :=
				join(
					temp_top_dedup,
					temp_pen_dedup,
					left.tmsid = right.tmsid,
					transform(
						recordof(temp_pen_dedup),
						self.penalt := right.penalt,
						dmp := not left.isdeepdive;
						self.matched_party.party_type := if(dmp, right.matched_party.party_type,''),
						self.matched_party.parsed_party := if(dmp , right.matched_party.parsed_party),
						self.matched_party.address := if(dmp , right.matched_party.address),
						self.matched_party.did := if(dmp, right.matched_party.did, ''),
						self.ultid := right.ultid,
						self.orgid := right.orgid,
						self.seleid := right.seleid,
						self.proxid := right.proxid,
						self.powid := right.powid,
						self.empid := right.empid,
						self.dotid := right.dotid,
						self := left),
					left outer);
			temp_top_add_debtors := join(
				temp_top_join,
				bankruptcyv3_services.fn_rollup_debtors(temp_records_searchD, in_ssn_mask),
				left.tmsid = right.tmsid,
				transform(
					recordof(temp_top_dedup),
					self.debtors := right.parties,
					self := left), 
				left outer);
			temp_top_add_attorneys :=
				if(in_isSearch,
					temp_top_add_debtors,
					join(
						temp_top_add_debtors,
						bankruptcyv3_services.fn_rollup_parties(temp_records_searchA,in_ssn_mask),
						left.tmsid = right.tmsid,
						transform(
							recordof(temp_top_dedup),
							self.attorneys := project(right.parties, layouts.layout_party_slim),
							self := left),
						left outer));
						
			temp_records_main_full := project(temp_records_main_jur,
																				recordof(bankruptcyv3.key_bankruptcyv3_main_full()));
						
			temp_top_add_status :=
				if(in_isSearch,
					temp_top_add_attorneys,
					join(
						temp_top_add_attorneys,
						bankruptcyv3_services.fn_rollup_statuses(temp_records_main_full),
						left.tmsid = right.tmsid,
						transform(
							recordof(temp_top_dedup),
							self.status_history := right.statuses,
							self := left),
						left outer));
			temp_top_add_comments :=
				if(in_isSearch,
					temp_top_add_status,
					join(
						temp_top_add_status,
						bankruptcyv3_services.fn_rollup_comments(temp_records_main_full),
						left.tmsid = right.tmsid,
						transform(
							recordof(temp_top_dedup),
							self.comment_history := right.comments,
							self := left),
						left outer));
				
			/* key containing docket info
         since we are getting case number from the TMSID, we only need to 
         hit the banko.Key_Banko_courtcode_casenumber key
         (NOT: banko.Key_Banko_courtcode_fullcasenumber ) */
      k_docket := banko.Key_Banko_courtcode_casenumber(isFCRA);
      
			/* functions for use in getting temp_add_docket_flag */
			court_code_from_tmsid (string tmsid) := tmsid[3..7];
			case_number_from_tmsid(string tmsid) := tmsid[8.. ];
			
			/* 
				populate flag that tells client whether extra dockets info is available.
				we only started collecting docket (bk events) data in Nov. of 2009,
				so extra dockets info is only available on some cases, 
				and only available for some of the events on some cases. 
				(i.e. only those events after 11/2009 of that case)
			
        JIRA RR - 10730 => a new key was created to contain the full case number, so 
        Add full case number/BKCaseNumber while adding docket flag

        Because we are replacing a project with the following join, we only
        need to keep(1)
      */
 
			temp_add_docket_flag := 
        JOIN(temp_top_add_comments, 
             k_docket,
             court_code_from_tmsid (trim(left.tmsid,all)) = right.court_code and
						 case_number_from_tmsid(trim(left.tmsid,all)) = right.casekey,  
						 transform(recordof(left), 
											 self.has_docket_info := court_code_from_tmsid (trim(left.tmsid,all)) = right.court_code and
						                                   case_number_from_tmsid(trim(left.tmsid,all)) = right.casekey,
                        self.full_case_number := right.BKCaseNumber,
                        self := left),
                        left outer,
                        keep(BankruptcyV3_Services.consts.MAX_PER_COURT_CASE_LOOKUP)); 
 
      temp_top_add_dockets :=
				if(in_isSearch or not include_dockets,
					temp_add_docket_flag,
					join(temp_add_docket_flag,
						bankruptcyv3_services.fn_rollup_dockets(temp_records_main_full, isFCRA, lower_entered_date, upper_entered_date),
						left.tmsid = right.tmsid,
						transform(
							recordof(temp_top_add_comments),
							self.docket_history := right.dockets,
							self := left),
						left outer));

       // output(in_tmsids1 , named('in_tmsids1'));				
			 // output(temp_records_search0, named('temp_records_search0'));
       // output(temp_records_search, named('temp_records_search'));		
			 // output(temp_records_searchA, named('temp_records_searchA'));
			 // output(temp_records_searchD, named('temp_records_searchD'));
			 // output(temp_records_search_pulled, named('temp_records_search_pulled'));
			 // output(tmsids_pulled, named('tmsids_pulled_v3'));
			 // output(temp_records_main, named('temp_records_mainv3'));
			 // output(trusteesPulled, named('trusteesPulledv3'));	 
			 // output(temp_records_main_jur, named('temp_records_main_jur'),overwrite);
			 // output(temp_top_slim, named('temp_top_slimv3'), overwrite);
			  // output(temp_top_join, named('tmp_top_joinv3'));
			  // output(temp_top_add_debtors, named('temp_top_add_debtors'));
				return  sort(temp_top_add_dockets,-orig_filing_date,-date_filed,record);
			
		end;
		