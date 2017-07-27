import AutoStandardI;
import BankruptcyV3_Services, bankruptcyv3, codes;

export fn_boolean_rollup(
	dataset(bankruptcyv3_services.layouts.layout_tmsid_ext) in_tmsids0,
	unsigned in_limit,
	string6 in_ssn_mask,
	boolean in_isSearch = false,
	string1 in_party_type = '',
	boolean isFCRA = false,
	string32 appType
	) :=
		function
			in_tmsids := in_tmsids0;
			temp_records_search :=
				join(
					in_tmsids,
					bankruptcyV3.key_bankruptcyV3_search_full_bip(isFCRA),
					keyed(left.tmsid = right.tmsid),
					transform(
						BankruptcyV3_Services.Layout_key_bankruptcyV3_search_full_bip_plus_case_numbers,
						self.full_case_number := '',
            self := right,
						self := left),
					limit(0),
          keep(BankruptcyV3_Services.consts.KEEP_LIMIT));
					
      // Pull any debtor records that are in the pull file
			temp_records_searchD := if (isFCRA, temp_records_search(name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR), fn_pullIDs(temp_records_search(name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),false,apptype));
			// Now, join back against our TMSIDs... and leave only those TMSIDs that have NO suppressed debtors.
			in_tmsids_less_pulled_by_debtor := JOIN(in_tmsids, DEDUP(SORT(temp_records_searchD,tmsid),tmsid),
				LEFT.tmsid = RIGHT.tmsid,
				TRANSFORM(LEFT));
			
			// Pull any attorney records that are in the pull file
			temp_records_searchA := if (isFCRA, temp_records_search(name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.ATTORNEY), fn_pullIDs(temp_records_search(name_type[1]=BankruptcyV3_Services.consts.NAME_TYPES.ATTORNEY),true,apptype)); // TRUE here means to pull ONLY the attorney being suppressed, not ALL attorneys
			// Pull any other records that are in the pull file
			temp_records_searchOthers := if (isFCRA, temp_records_search(name_type[1]<>BankruptcyV3_Services.consts.NAME_TYPES.ATTORNEY AND name_type[1] <> BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),
			                                         fn_pullIds(temp_records_search(name_type[1]<>BankruptcyV3_Services.consts.NAME_TYPES.ATTORNEY AND name_type[1]<>BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR),true,apptype)); // this may be the empty set all the time??
			// Add together all records NOT pulled (including debtors)
			temp_records := sort(temp_records_searchD + temp_records_searchA + temp_records_searchOthers, tmsid);     					
					

			temp_records_main :=
				join(
					in_tmsids_less_pulled_by_debtor,
					bankruptcyV3.key_bankruptcyV3_main_full(isFCRA),
					keyed(left.tmsid = right.tmsid),
					transform(
						{recordof(bankruptcyV3.key_bankruptcyV3_main_full()),boolean isDeepDive, boolean suppressT},
						self.SuppressT := false;
						self := right,
						self := left),
					limit(0),
          keep(BankruptcyV3_Services.consts.KEEP_LIMIT));
					
      temp_records_main_final := if (isFCRA, temp_records_main, bankruptcyv3_services.fn_pullTrusteeIds(temp_records_main,appType)); // NO FCRA??
			
			temp_top_slim :=
				project(
					temp_records_main_final,
					transform(
						bankruptcyv3_services.layouts.layout_rollup,
						self.filer_type_ex := codes.BANKRUPTCIES.FILER_TYPE(left.filer_type),
						self.trustee.DID := if (left.suppressT, '', left.DID);
						self.trustee.trusteeID := left.trusteeID;
						self.trustee.app_SSN := if (left.suppressT, '', left.app_SSN);
					  self.trustee.orig_name := if (left.suppressT, '', left.trusteeName);
						self.trustee.orig_address := if (left.suppressT, '', left.trusteeAddress);
						self.trustee.orig_city := if (left.suppressT, '', left.trusteeCity);
						self.trustee.orig_st := if (left.suppressT, '', left.trusteeState);
						self.trustee.orig_zip := if (left.suppressT, '', left.trusteeZip);
						self.trustee.orig_zip4 := if (left.suppressT, '', left.trusteeZip4);
						self.trustee.phone := if (left.suppressT, '', left.trusteePhone);
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
						tempmod := module(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
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
							export string ssn_field := left.ssn;
							export string state_field := left.st;
							export string suffix_field := left.addr_suffix;
							export string zip_field := left.zip;
						end;
						self.penalt := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempmod),
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
						self := left),
					left outer);
			temp_top_add_debtors := join(
				temp_top_join,
				bankruptcyv3_services.fn_rollup_debtors(temp_records_searchD,in_ssn_mask),
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
			temp_top_add_status :=
				if(in_isSearch,
					temp_top_add_attorneys,
					join(
						temp_top_add_attorneys,
						bankruptcyv3_services.fn_rollup_statuses(
							project(
								temp_records_main,
								recordof(bankruptcyv3.key_bankruptcyV3_main_full()))),
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
						bankruptcyv3_services.fn_rollup_comments(
							project(
								temp_records_main,
								recordof(bankruptcyv3.key_bankruptcyV3_main_full()))),
						left.tmsid = right.tmsid,
						transform(
							recordof(temp_top_dedup),
							self.comment_history := right.comments,
							self := left),
						left outer));
			return
				temp_top_add_comments;
		end;
		