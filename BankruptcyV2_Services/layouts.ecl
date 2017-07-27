import bankruptcyv3, BIPV2, iesp;

export layouts :=
	module
		// LAYOUT ROLLUP CONSTANTS
		export NAMES_PER_PARTY     := iesp.Constants.BANKRPT.MaxPersonNames;
		export ADDRESSES_PER_PARTY := iesp.Constants.BANKRPT.MaxPersonAddresses;
		export PHONES_PER_PARTY    := iesp.Constants.BANKRPT.MaxPersonPhones;
		export EMAILS_PER_PARTY    := iesp.Constants.BANKRPT.MaxPersonEmails;
		export PARTIES_PER_ROLLUP  := iesp.Constants.BANKRPT.MaxDebtors; // separate limit for each party would be better
		export STATUSES_PER_ROLLUP := iesp.Constants.BANKRPT.MaxStatusHistory;
		export COMMENTS_PER_ROLLUP := iesp.Constants.BANKRPT.MaxComments;

		// KEY TO ROLL UP RECORDS
		export layout_rollup_key :=
			record
				bankruptcyv3.key_bankruptcyV3_search_full_bip().tmsid;
			end;
		// KEY TO IDENTIFY SINGLE PARTIES
		export layout_party_subkey :=
			record
				string1 debtor_type_1;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().did;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().bdid;
				BIPV2.IDlayouts.l_header_ids;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().app_ssn;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().ssn;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().app_tax_id;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().tax_id;
        boolean HasCriminalConviction;
        boolean IsSexualOffender;
			end;
		export layout_debtor_addl := 
		record
			// bankruptcyv3.key_bankruptcyV3_search_full_bip().chapter;
			// bankruptcyv3.key_bankruptcyV3_search_full_bip().corp_flag;
			// bankruptcyv3.key_bankruptcyV3_search_full_bip().disposition;
			// bankruptcyv3.key_bankruptcyV3_search_full_bip().pro_se_ind;
			// bankruptcyv3.key_bankruptcyV3_search_full_bip().converted_date;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().caseID;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().defendantID;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().recID;
			// bankruptcyv3.key_bankruptcyV3_search_full_bip().filing_type;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().business_flag;
			// bankruptcyv3.key_bankruptcyV3_search_full_bip().discharged;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_county;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().ssnSrc;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().srcDesc;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().ssnMatch;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().srcMtchDesc;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().ssnMSrc;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().screen;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().screenDesc;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().dCode;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().dCodeDesc;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().dispType;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().dispTypeDesc;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().dispReason;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().statusDate;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().holdCase;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().dateVacated;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().dateTransferred;
			bankruptcyv3.key_bankruptcyV3_search_full_bip().activityReceipt;
		end;
		// LAYOUT FOR ADDRESSES
		export layout_address :=
			record
			  bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_addr1;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_addr2;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_city;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_st;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_zip5;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_zip4;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_county;
			
				bankruptcyv3.key_bankruptcyV3_search_full_bip().prim_range;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().predir;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().prim_name;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().addr_suffix;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().postdir;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().unit_desig;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().sec_range;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().p_city_name;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().v_city_name;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().st;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().zip;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().zip4;
			end;
			// LAYOUT TO HOLD KEYS AND ADDRESS DATA
			export layout_address_ext :=
				record
					layout_rollup_key;
					layout_party_subkey;
					layout_address;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
				end;
			// LAYOUT TO ROLL UP ADDRESSES ON KEYS
			export layout_address_roll :=
				record
					layout_rollup_key;
					layout_party_subkey;
					dataset(layout_address) addresses{maxcount(ADDRESSES_PER_PARTY)};
					bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
				end;
		// LAYOUT FOR PHONES
		export layout_phone :=
			record
				bankruptcyv3.key_bankruptcyV3_search_full_bip().phone;
				bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_fax;
				string4	 timezone :='';
			end;
			// LAYOUT TO HOLD KEYS AND PHONE DATA
			export layout_phone_ext :=
				record
					layout_rollup_key;
					layout_party_subkey;
					layout_phone;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
				end;
			// LAYOUT TO ROLL UP PHONES ON KEYS
			export layout_phone_roll :=
				record
					layout_rollup_key;
					layout_party_subkey;
					dataset(layout_phone) phones{maxcount(PHONES_PER_PARTY)};
					bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
				end;
			// LAYOUT FOR NAMES
			export layout_name :=
				record		
					bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_name;					
					bankruptcyv3.key_bankruptcyV3_search_full_bip().cname;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().lname;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().fname;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().mname;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().name_suffix;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().did;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().bdid;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().app_ssn;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().ssn;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().app_tax_id;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().tax_id;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().debtor_type;
				end;
			// LAYOUT TO HOLD KEYS AND NAME DATA
			export layout_name_ext :=
				record
					layout_rollup_key or layout_party_subkey or layout_name;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
				end;
			// LAYOUT TO ROLL UP NAMES ON KEYS
			export layout_name_roll :=
				record
					layout_rollup_key;
					layout_party_subkey;
					dataset(layout_name) names{maxcount(NAMES_PER_PARTY)};
					bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
				end;
			//LAYOUT FOR EMAILS
			export layout_email := record
				bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_email;
			end;
			// LAYOUT TO HOLD KEYS AND EMAIL DATA
			export layout_email_ext :=
				record
					layout_rollup_key;
					layout_party_subkey;
					layout_email;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
				end;
			// LAYOUT TO ROLL UP EMAILS ON KEYS
			export layout_email_roll :=
				record
					layout_rollup_key;
					layout_party_subkey;
					dataset(layout_email) emails{maxcount(EMAILS_PER_PARTY)};
					bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
				end;
			// LAYOUT FOR PARTIES
			export layout_party :=
				record
					layout_party_subkey;
					layout_debtor_addl;
					dataset(layout_name) names{maxcount(NAMES_PER_PARTY)};
					dataset(layout_address) addresses{maxcount(ADDRESSES_PER_PARTY)};
					dataset(layout_phone) phones{maxcount(PHONES_PER_PARTY)};
					dataset(layout_email) emails{maxcount(EMAILS_PER_PARTY)};
				end;
			export layout_party_slim := 
				record
					layout_party and not layout_debtor_addl;
				end;
				
			// LAYOUT TO HOLD KEY AND PARTY DATA AND TO JOIN NAME, ADDR, PHONE
			export layout_party_ext :=
				record
					layout_rollup_key;
					layout_party;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
				end;
			// LAYOUT TO ROLL UP PARTIES ON TMSID
			export layout_party_roll :=
				record
					layout_rollup_key;
					dataset(layout_party) parties{maxcount(PARTIES_PER_ROLLUP)};
					bankruptcyv3.key_bankruptcyV3_search_full_bip().date_last_seen;
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
					dataset(layout_status) statuses{maxcount(STATUSES_PER_ROLLUP)};
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
					dataset(layout_comment) comments{maxcount(COMMENTS_PER_ROLLUP)};
				end;
				
			export matched_party_name_rec := rECORD
			    bankruptcyv3.key_bankruptcyV3_search_full_bip().orig_name;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().cname;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().lname;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().fname;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().mname;
			END;
			
			export Matched_party_rec := RECORD
					string1 party_type;
					matched_party_name_rec parsed_party;
					layout_address address;
			END;
			// FINAL FULL OUTPUT LAYOUT
			export layout_rollup :=
				record
					bankruptcyv3.key_bankruptcyv3_main_full().tmsid;
          boolean isDeepDive;
					unsigned2 penalt;
					Matched_party_rec matched_party;
					dataset(layout_party) debtors{maxcount(PARTIES_PER_ROLLUP)};
					dataset(layout_party_slim) attorneys{maxcount(PARTIES_PER_ROLLUP)};
					dataset(layout_party_slim) trustees{maxcount(PARTIES_PER_ROLLUP)};
					dataset(layout_status) status_history{maxcount(STATUSES_PER_ROLLUP)};
					dataset(layout_comment) comment_history{maxcount(COMMENTS_PER_ROLLUP)};
					bankruptcyv3.key_bankruptcyv3_main_full().case_number;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().chapter; //was in the BKv2 main key
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
					bankruptcyv3.key_bankruptcyV3_search_full_bip().pro_se_ind; //was in the BKv2 main key
					bankruptcyv3.key_bankruptcyv3_main_full().reopen_date;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().converted_date; //was in the BKv2 main key
					string8 disposed_date; //in SearchV3 key, renamed discharged
					bankruptcyv3.key_bankruptcyv3_main_full().case_closing_date;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().disposition; //was in the BKv2 main key
					string10 orig_filing_type; //in SearchV3 key, renamed filing_type
					string10 orig_filing_type_ex;
					bankruptcyv3.key_bankruptcyv3_main_full().filer_type;
					string10 filer_type_ex;
					bankruptcyv3.key_bankruptcyV3_search_full_bip().corp_flag; //was in the BKv2 main key
					bankruptcyv3.key_bankruptcyv3_main_full().filing_status;
					bankruptcyv3.key_bankruptcyv3_main_full().orig_filing_date;
					bankruptcyv3.key_bankruptcyv3_main_full().orig_chapter;
					//addtl fields from Bkv3 main key
					bankruptcyv3.key_bankruptcyv3_main_full().method_dismiss;
					bankruptcyv3.key_bankruptcyv3_main_full().case_status;
					bankruptcyv3.key_bankruptcyv3_main_full().SplitCase;
					bankruptcyv3.key_bankruptcyv3_main_full().FiledInError;
					bankruptcyv3.key_bankruptcyv3_main_full().dateReclosed;
					bankruptcyv3.key_bankruptcyv3_main_full().trusteeID;
					bankruptcyv3.key_bankruptcyv3_main_full().caseID;
					bankruptcyv3.key_bankruptcyv3_main_full().barDate;
					bankruptcyv3.key_bankruptcyv3_main_full().transferIn;
					bankruptcyv3.key_bankruptcyv3_main_full().planConfDate;
					bankruptcyv3.key_bankruptcyv3_main_full().confHearDate;
					bankruptcyv3.key_bankruptcyv3_main_full().delete_flag;
					//all these fields are used to fill trustees 
					// bankruptcyv3.key_bankruptcyv3_main_full().trusteeName;
					// bankruptcyv3.key_bankruptcyv3_main_full().trusteeAddress;
					// bankruptcyv3.key_bankruptcyv3_main_full().trusteeCity;
					// bankruptcyv3.key_bankruptcyv3_main_full().trusteeState;
					// bankruptcyv3.key_bankruptcyv3_main_full().trusteeZip;
					// bankruptcyv3.key_bankruptcyv3_main_full().trusteeZip4;
					// bankruptcyv3.key_bankruptcyv3_main_full().trusteePhone;
					// bankruptcyv3.key_bankruptcyv3_main_full().trusteeEmail;
					// bankruptcyv3.key_bankruptcyv3_main_full().DID;
					// bankruptcyv3.key_bankruptcyv3_main_full().app_SSN;
				end;
	end;
	