import bankruptcyv3, doxie, doxie_cbrs,address, banko, BIPV2, FFD;
export layouts :=
	module
	
		// EXT REF LAYOUTS
		export layout_tmsid_ext :=
			record
				string50 tmsid;
				boolean isdeepdive;
				string30 acctno := '';	
				string30 matchcode := '';
			end;
		
		export layout_did_ext :=
			record
				doxie.layout_references;
				boolean isdeepdive;
			end;	
	
		export layout_bdid_ext :=
			record
				doxie_cbrs.layout_references;
				boolean isdeepdive;
		end;
		
		export layout_bip_ext :=
			record
				string50 tmsid;
				BIPV2.IDlayouts.l_key_ids_bare;
		end;
			
		export layout_casenumber_ext :=
			record
				bankruptcyv3.key_bankruptcyv3_main_full().orig_case_number;
				bankruptcyv3.key_bankruptcyv3_main_full().filing_jurisdiction;
				boolean isdeepdive;
			end;
	
		// KEY TO ROLL UP RECORDS
		export layout_rollup_key :=
			record
				bankruptcyv3.key_bankruptcyv3_search_full_bip().tmsid;
			end;
		// KEY TO IDENTIFY SINGLE PARTIES
		export layout_party_subkey :=
			record
				string1 debtor_type_1;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().did;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().bdid;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().app_ssn;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().ssn;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().app_tax_id;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().tax_id;
			end;
		export layout_debtor_addl := 
			record
				bankruptcyv3.key_bankruptcyv3_search_full_bip().chapter;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().corp_flag;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().disposition;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().pro_se_ind;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().converted_date;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().caseID;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().recID;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().filing_type;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().business_flag;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().discharged;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_county;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().ssnSrc;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().srcDesc;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().ssnMatch;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().srcMtchDesc;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().ssnMSrc;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().screen;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().screenDesc;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().dCode;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().dCodeDesc;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().dispType;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().dispTypeDesc;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().dispReason;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().statusDate;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().holdCase;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().dateVacated;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().dateTransferred;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().activityReceipt;
				string person_filter_id := '';
				string2 debtor_type := '';
			end;
		// LAYOUT FOR ADDRESSES
		export layout_address :=
			record
			  bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_addr1;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_addr2;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_city;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_st;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_zip5;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_zip4;
				
				bankruptcyv3.key_bankruptcyv3_search_full_bip().prim_range;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().predir;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().prim_name;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().addr_suffix;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().postdir;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().unit_desig;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().sec_range;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().p_city_name;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().v_city_name;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().st;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().zip;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().zip4;
			end;
			// LAYOUT TO HOLD KEYS AND ADDRESS DATA
			export layout_address_ext :=
				record
					layout_rollup_key;
					layout_party_subkey;
					layout_address;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
				end;
			// LAYOUT TO ROLL UP ADDRESSES ON KEYS
			export layout_address_roll :=
				record
					layout_rollup_key;
					layout_party_subkey;
					dataset(layout_address) addresses{maxcount(consts.ADDRESSES_PER_PARTY)};
					bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
				end;
		// LAYOUT FOR PHONES
		export layout_phone :=
			record
				bankruptcyv3.key_bankruptcyv3_search_full_bip().phone;
				bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_fax;
				string4	 timezone :='';
			end;
			// LAYOUT TO HOLD KEYS AND PHONE DATA
			export layout_phone_ext :=
				record
					layout_rollup_key;
					layout_party_subkey;
					layout_phone;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
				end;
			// LAYOUT TO ROLL UP PHONES ON KEYS
			export layout_phone_roll :=
				record
					layout_rollup_key;
					layout_party_subkey;
					dataset(layout_phone) phones{maxcount(consts.PHONES_PER_PARTY)};
					bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
				end;
			// LAYOUT FOR NAMES
			export layout_name :=
				record
				  bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_name;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_lname;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_fname;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_mname;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_name_suffix;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().cname;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().lname;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().fname;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().mname;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().name_suffix;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().did;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().bdid;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().app_ssn;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().ssn;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().app_tax_id;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().tax_id;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().debtor_type;
				end;
			// LAYOUT TO HOLD KEYS AND NAME DATA
			export layout_name_ext :=
				record
					layout_rollup_key or layout_party_subkey or layout_name;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
				end;
			// LAYOUT TO ROLL UP NAMES ON KEYS
			export layout_name_roll :=
				record
					layout_rollup_key;
					layout_party_subkey;
					dataset(layout_name) names{maxcount(consts.NAMES_PER_PARTY)};
					bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
				end;
			// LAYOUT FOR EMAILS
			export layout_email :=
				record
				  bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_email;
				end;
		// LAYOUT TO HOLD KEYS AND EMAIL DATA
			export layout_email_ext :=
				record
					layout_rollup_key;
					layout_party_subkey;
					layout_email;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
				end;
			// LAYOUT TO ROLL UP EMAILS ON KEYS
			export layout_email_roll :=
				record
					layout_rollup_key;
					layout_party_subkey;
					dataset(layout_email) emails{maxcount(consts.EMAILS_PER_PARTY)};
					bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
				end;

			export withdrawn_status_rec := record
				string10 withdrawnid := '';
				string8 withdrawndate := '';
				string35 withdrawndisposition := '';
				string8 withdrawndispositiondate := '';
			end;
			// LAYOUT FOR PARTIES
			export layout_party :=
				record
					layout_party_subkey;
					layout_debtor_addl;
					dataset(layout_name) names{maxcount(consts.NAMES_PER_PARTY)};
					dataset(layout_address) addresses{maxcount(consts.ADDRESSES_PER_PARTY)};
					dataset(layout_phone) phones{maxcount(consts.PHONES_PER_PARTY)};
					dataset(layout_email) emails{maxcount(consts.EMAILS_PER_PARTY)};
					withdrawn_status_rec WithdrawnStatus;
					FFD.Layouts.CommonRawRecordElements;  // FCRA FFD
				end;
			export layout_party_slim :=
				record
					layout_party_subkey;
					dataset(layout_name) names{maxcount(consts.NAMES_PER_PARTY)};
					dataset(layout_address) addresses{maxcount(consts.ADDRESSES_PER_PARTY)};
					dataset(layout_phone) phones{maxcount(consts.PHONES_PER_PARTY)};
					dataset(layout_email) emails{maxcount(consts.EMAILS_PER_PARTY)};
				end;
			// LAYOUT TO HOLD KEY AND PARTY DATA AND TO JOIN NAME, ADDR, PHONE
			export layout_party_ext :=
				record
					layout_rollup_key;
					layout_party;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
				end;
			// LAYOUT TO ROLL UP PARTIES ON TMSID
			export layout_party_roll :=
				record
					layout_rollup_key;
					dataset(layout_party) parties{maxcount(consts.PARTIES_PER_ROLLUP)};
					bankruptcyv3.key_bankruptcyv3_search_full_bip().date_last_seen;
				end;
			// LAYOUT FOR STATUSES
			export layout_status :=
				record
					bankruptcyv3.key_bankruptcyv3_main_full().status.status_date;
					bankruptcyv3.key_bankruptcyv3_main_full().status.status_type;
				end;
			// LAYOUT TO HOLD KEY AND STATUS DATA
			export layout_status_ext :=
				record
					bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
					layout_status;
				end;
			// LAYOUT TO ROLL UP STATUSES ON TMSID
			export layout_status_roll :=
				record
					bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
					dataset(layout_status) statuses{maxcount(consts.STATUSES_PER_ROLLUP)};
				end;
			// LAYOUT FOR COMMENTS
			export layout_comment :=
				record
					bankruptcyv3.key_bankruptcyv3_main_full().comments.filing_date;
					bankruptcyv3.key_bankruptcyv3_main_full().comments.description;
				end;
			// LAYOUT TO HOLD KEY AND COMMENT DATA
			export layout_comment_ext :=
				record
					bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
					layout_comment;
				end;
			// LAYOUT TO ROLL UP COMMENTS ON TMSID
			export layout_comment_roll :=
				record
					bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
					dataset(layout_comment) comments{maxcount(consts.COMMENTS_PER_ROLLUP)};
				end;
			// LAYOUT TO HOLD DOCKET DATA
			export layout_docket :=
				record
					banko.Layout_BankoFile_FixedRec.DocketText;
					banko.Layout_BankoFile_FixedRec.FiledDate;
					banko.Layout_BankoFile_FixedRec.Pacer_EnteredDate;
					banko.Layout_BankoFile_FixedRec.PacerCaseID;
					banko.Layout_BankoFile_FixedRec.AttachmentURL;
					banko.Layout_BankoFile_FixedRec.EntryNumber;
					banko.Layout_BankoFile_FixedRec.DocketEntryID;
					banko.Layout_BankoFile_FixedRec.DRCategoryEventID;
					banko.Layout_BankoFile_FixedRec.EnteredDate;
					Banko.BankoJoinRecord.CatEvent_Description;
					Banko.BankoJoinRecord.CatEvent_Category;
				end;
			export layout_docket_ext := 
				record
					bankruptcyv3.key_bankruptcyV3_main_full().tmsid;
					layout_docket;
				end;
			// LAYOUT TO ROLL UP DOCKET TEXT ON TMSID
			export layout_docket_roll :=
				record
					bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
					dataset(layout_docket) dockets{maxcount(consts.DOCKETS_PER_ROLLUP)};
				end;
				
			export matched_party_name_rec := rECORD
					bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_name;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().cname;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().lname;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().fname;
					bankruptcyv3.key_bankruptcyv3_search_full_bip().mname;
			END;
			
			export Matched_party_rec := RECORD
					string1 party_type;
					string14 did;
					matched_party_name_rec parsed_party;
					layout_address address;
			END;
			
			export layout_trustee := RECORD
					bankruptcyv3.key_bankruptcyv3_main_full().DID;
					bankruptcyv3.key_bankruptcyv3_main_full().trusteeID;
					bankruptcyv3.key_bankruptcyv3_main_full().app_SSN;
					typeof(bankruptcyv3.key_bankruptcyv3_main_full().trusteeName) orig_name;
					address.Layout_Clean_Name;
					typeof(bankruptcyv3.key_bankruptcyv3_main_full().trusteeAddress) orig_address;
					typeof(bankruptcyv3.key_bankruptcyv3_main_full().trusteeCity) orig_city;
					typeof(bankruptcyv3.key_bankruptcyv3_main_full().trusteeState) orig_st;
					typeof(bankruptcyv3.key_bankruptcyv3_main_full().trusteeZip) orig_zip;
					typeof(bankruptcyv3.key_bankruptcyv3_main_full().trusteeZip4) orig_zip4;
					address.Layout_Clean182;
					typeof(bankruptcyv3.key_bankruptcyv3_main_full().trusteePhone) phone;
			END;
			
			
			// FINAL FULL OUTPUT LAYOUT
			export layout_rollup :=
				record
					bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
          boolean isDeepDive;
					unsigned2 penalt;
					Matched_party_rec matched_party;
					dataset(layout_party) debtors{maxcount(consts.PARTIES_PER_ROLLUP)};
					dataset(layout_party_slim) attorneys{maxcount(consts.PARTIES_PER_ROLLUP)};
					dataset(layout_status) status_history{maxcount(consts.STATUSES_PER_ROLLUP)};
					dataset(layout_comment) comment_history{maxcount(consts.COMMENTS_PER_ROLLUP)};
					dataset(layout_docket) docket_history{maxcount(consts.DOCKETS_PER_ROLLUP)};
					bankruptcyv3.key_bankruptcyv3_main_full().case_number;
          STRING24 full_case_number;
          bankruptcyv3.key_bankruptcyv3_main_full().date_filed;
					bankruptcyv3.key_bankruptcyv3_main_full().court_code;
					bankruptcyv3.key_bankruptcyv3_main_full().court_name;
					bankruptcyv3.key_bankruptcyv3_main_full().court_location;
					bankruptcyv3.key_bankruptcyv3_main_full().casetype;
					bankruptcyv3.key_bankruptcyv3_main_full().filing_jurisdiction;
					bankruptcyv3.key_bankruptcyv3_main_full().judge_name;
					bankruptcyv3.key_bankruptcyv3_main_full().judges_identification;
					bankruptcyv3.key_bankruptcyv3_main_full().meeting_date;
					bankruptcyv3.key_bankruptcyv3_main_full().meeting_time;
					bankruptcyv3.key_bankruptcyv3_main_full().address_341;
					bankruptcyv3.key_bankruptcyv3_main_full().assets_no_asset_indicator;
					bankruptcyv3.key_bankruptcyv3_main_full().assets;
					bankruptcyv3.key_bankruptcyv3_main_full().liabilities;
					bankruptcyv3.key_bankruptcyv3_main_full().claims_deadline;
					bankruptcyv3.key_bankruptcyv3_main_full().complaint_deadline;
					bankruptcyv3.key_bankruptcyv3_main_full().reopen_date;
					bankruptcyv3.key_bankruptcyv3_main_full().case_closing_date;
					bankruptcyv3.key_bankruptcyv3_main_full().filer_type;
					string10 filer_type_ex;
					bankruptcyv3.key_bankruptcyv3_main_full().filing_status;
					bankruptcyv3.key_bankruptcyv3_main_full().orig_filing_date;
					bankruptcyv3.key_bankruptcyv3_main_full().orig_chapter;
					// new in V3
					bankruptcyv3.key_bankruptcyv3_main_full().SplitCase;
					bankruptcyv3.key_bankruptcyv3_main_full().FiledInError;
					bankruptcyv3.key_bankruptcyv3_main_full().dateReclosed;
					bankruptcyv3.key_bankruptcyv3_main_full().caseID;
					bankruptcyv3.key_bankruptcyv3_main_full().barDate;
					bankruptcyv3.key_bankruptcyv3_main_full().transferIn;
					bankruptcyv3.key_bankruptcyV3_main_full().AssocCode;
					layout_trustee trustee;
					boolean has_docket_info := false;
					BIPV2.IDlayouts.l_header_ids;
					FFD.Layouts.CommonRawRecordElements;  // FCRA FFD
				end;
	end;
	