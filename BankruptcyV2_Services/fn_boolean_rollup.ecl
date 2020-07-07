import AutoStandardI;
import bankruptcyv3, codes, doxie, bankruptcyv2_services, ut, Suppress;
export fn_boolean_rollup(
	dataset(bankruptcyv2_services.layout_tmsid_ext) in_tmsids0,
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
					BankruptcyV3.key_bankruptcyV3_search_full_bip(isFCRA),
					keyed(left.tmsid = right.tmsid),
					transform(
						recordof(BankruptcyV3.key_bankruptcyV3_search_full_bip()),
						self := right,
						self := left),
					keep(1000));
     // Pull any debtor records that are in the pull file
			temp_records_searchD := if (isFCRA, temp_records_search(name_type[1]='D'), bankruptcyv2_services.fn_pullIDs(temp_records_search(name_type[1]='D'),false,appType));
			// Now, join back against our TMSIDs... and leave only those TMSIDs that have NO suppressed debtors.
			in_tmsids_less_pulled_by_debtor := JOIN(in_tmsids, DEDUP(SORT(temp_records_searchD,tmsid),tmsid),
				LEFT.tmsid = RIGHT.tmsid,
				TRANSFORM(LEFT));
			
			// Pull any attorney records that are in the pull file
			temp_records_searchA := if (isFCRA, temp_records_search(name_type[1]='A'), bankruptcyv2_services.fn_pullIDs(temp_records_search(name_type[1]='A'),true,appType)); // TRUE here means to pull ONLY the attorney being suppressed, not ALL attorneys
      temp_records_searchT := if (isFCRA, temp_records_search(name_type[1]='T'), bankruptcyv2_services.fn_pullIDs(temp_records_search(name_type[1]='T'), true,appType)); // true here mean to pull only the trustee being suppressed, not all trustees			
			// Pull any other records that are in the pull file
			temp_records_searchOthers := if (isFCRA, temp_records_search(name_type[1]<>'A' AND name_type[1]<>'D' AND name_type[1]<>'T'),
			                bankruptcyv2_services.fn_pullIds(temp_records_search(name_type[1]<>'A' AND name_type[1]<>'D' AND name_type[1]<>'T'),true,appType)); // this may be the empty set all the time??
			// Add together all records NOT pulled (including debtors)
			temp_records := sort(temp_records_searchD + temp_records_searchA + temp_records_searchT + temp_records_searchOthers, tmsid);
			
			//Trustee information with Bkv2 used to be available in the search key; however, in the Bkv3 it is available in the main key.
			//Below we are making sure to assign timezone if trustee information are requested
			//In addition, some fields used to be available in Bkv2 main key but are now available in the Bkv2 search key so we are also adding these now.
			temp_rec_main := record
				recordof(bankruptcyV3.key_bankruptcyV3_main_full());
				string4	 timezone :='';
				boolean isDeepDive;
			end;
			
			temp_records_main0 :=
				join(
					in_tmsids_less_pulled_by_debtor,
					bankruptcyv3.key_bankruptcyV3_main_full(isFCRA),
					keyed(left.tmsid = right.tmsid),
					transform(
						temp_rec_main,						
						self := right,
						self := left),
					keep(1000));
					
			Suppress.MAC_Mask(temp_records_main0, trustees_masked, app_SSN, null, true, false, maskVal:=in_ssn_mask);
			ut.getTimeZone(trustees_masked,trusteePhone,timezone,temp_records_main_w_tzone);			
			temp_records_main := if(in_isSearch, temp_records_main0, temp_records_main_w_tzone);
			
			BankruptcyV2_Services.layouts.layout_party_slim to_trustee(temp_rec_main L) := transform
				self.names := project(L, transform(BankruptcyV2_Services.layouts.layout_name,
					self.orig_name := left.trusteeName,
					self.ssn			 := left.app_ssn, //there is no ssn field
					self := left,
					self := [])); //no app_tax_id and tax_id fields
				self.addresses := project(L, transform(BankruptcyV2_Services.layouts.layout_address,
					self.orig_addr1 := left.trusteeAddress,
					self.orig_city := left.trusteeCity,
					self.orig_st := left.trusteeState,
					self.orig_zip5 := left.trusteeZip,
					self.orig_zip4 := left.trusteeZip4,
					self := left,
					self := [])); //orig_addr2, orig_county 
				self.phones := project(L, transform(BankruptcyV2_Services.layouts.layout_phone,
					self.phone := left.trusteePhone,
					self.timezone := left.timezone,
					self.orig_fax := '')); //no fax field
				self.emails := project(L, transform(BankruptcyV2_Services.layouts.layout_email,
					self.orig_email := left.trusteeEmail));
				self 			:= L;
				self.ssn	:= L.app_SSN;
				self 			:= []; //no app_tax_id, tax_id and BDID and BIP fields
			end;
			
			temp_top_slim :=
				join(
					temp_records_main,
					temp_records_search,
					left.tmsid = right.tmsid,
					transform(
						bankruptcyv2_services.layouts.layout_rollup,
						self.filer_type_ex := codes.BANKRUPTCIES.FILER_TYPE(left.filer_type),
						self.trustees							:= if(~in_isSearch, project(left, to_trustee(left)));
						//fields that were in BKv2 main but now are in BKv3 search
						self.orig_filing_type_ex 	:= codes.BANKRUPTCIES.FILING_TYPE(right.filing_type),
						self.orig_filing_type		 	:= right.filing_type,
						self.chapter						 	:= right.chapter,
						self.pro_se_ind					 	:= right.pro_se_ind,
						self.disposed_date			 	:= right.discharged,
						self.disposition					:= right.disposition,
						self.corp_flag						:= right.corp_flag,
						self.converted_date				:= right.converted_date,
						self := left,
						self := []),
					LIMIT(0), KEEP(1));
			temp_top_dedup :=
				dedup(
					sort(
						temp_top_slim,
						tmsid,record),
					tmsid);
			temp_pen_slim :=
				project(
					temp_records_search,
					transform(
						bankruptcyv2_services.layouts.layout_rollup,
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
				bankruptcyv2_services.fn_rollup_debtors(temp_records_searchD,in_ssn_mask),
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
						bankruptcyv2_services.fn_rollup_parties(temp_records_searchA,in_ssn_mask),
						left.tmsid = right.tmsid,
						transform(
							recordof(temp_top_dedup),
							self.attorneys := project(right.parties, BankruptcyV2_Services.layouts.layout_party_slim),
							self := left),
						left outer));
			temp_top_add_status :=
				if(in_isSearch,
					temp_top_add_attorneys,
					join(
						temp_top_add_attorneys,
						bankruptcyv2_services.fn_rollup_statuses(
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
						bankruptcyv2_services.fn_rollup_comments(
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
		