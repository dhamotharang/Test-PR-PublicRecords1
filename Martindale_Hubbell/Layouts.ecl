import address, bipv2;
export Layouts :=
module

	shared max_size := _Dataset().max_record_size;

	export Miscellaneous :=
	module
	
		export Organizations :=
		module
		
			export Cleaned_Phones :=
			record

				string10 CONTACT_FAXS_FAX_NUMBER										;
				string10 CONTACT_PHONES_PHONE_NUMBER								;

			end;
				
		end;
		
		export Affiliated_Individuals :=
		module
		
			export Cleaned_Dates :=
			record

				unsigned4		date_of_birth					;
				unsigned4		ROSTERAUDIT_DATE			;

			end;
			export Cleaned_Phones :=
			record

				string10 CONTACT_FAXS_FAX_NUMBER										;
				string10 CONTACT_PHONES_PHONE_NUMBER								;
				string10 HEADER_AFF_INDIV_INDIV_CELL_PHONE_NUMBER		;
				string10 HEADER_AFF_INDIV_INDIV_FAX_FAX_NUMBER			;
				string10 HEADER_AFF_INDIV_INDIV_PHONE_PHONE_NUMBER	;

			end;

		end;

		export Unaffiliated_Individuals :=
		module
		
			export Cleaned_Dates :=
			record

				unsigned4		ROSTERAUDIT_DATE			;

			end;

		end;

	
	end;




	export Input :=
	module
	
		export Sprayed :=
		record, maxlength(max_size)
		
			string line {maxlength(max_size)};
		
		end;

		export Parsed :=
		module

			export Affiliated_Individuals :=
			record, maxlength(max_size)
				string HEADER_AFF_INDIV_ARMEDFORCES                                   ;
				string HEADER_AFF_INDIV_CORPTITLE                                     ;
				string HEADER_AFF_INDIV_DECEASED                                      ;
				string HEADER_AFF_INDIV_DEVOTES                                       ;
				string HEADER_AFF_INDIV_GOVTTITLE                                     ;
				string HEADER_AFF_INDIV_INDIV_AUDIT_ATTYNO                            ;
				string HEADER_AFF_INDIV_INDIV_AUDIT_ATTYSEQ                           ;
				string HEADER_AFF_INDIV_INDIV_AUDIT_INDIV_ID                          ;
				string HEADER_AFF_INDIV_INDIV_AUDIT_ISLN                              ;
				string HEADER_AFF_INDIV_INDIV_AUDIT_LISTING_ID                        ;
				string HEADER_AFF_INDIV_INDIV_AUDIT_LISTING_TYPE                      ;
				string HEADER_AFF_INDIV_INDIV_AUDIT_ORG_LID                           ;
				string HEADER_AFF_INDIV_INDIV_AUDIT_ORG_VID                           ;
				string HEADER_AFF_INDIV_INDIV_AUDIT_SOLO                              ;
				string HEADER_AFF_INDIV_INDIV_AUDIT_SORTKEY                           ;
				string HEADER_AFF_INDIV_INDIV_AUDIT_SUB_TYPE                          ;
				string HEADER_AFF_INDIV_INDIV_AUDIT_VERSION_ID                        ;
				string HEADER_AFF_INDIV_INDIV_BIOG_SECTION                            ;
				string HEADER_AFF_INDIV_INDIV_BIOG_SKETCH                             ;
				string HEADER_AFF_INDIV_INDIV_CELL_PHONE_NUMBER                       ;
				string HEADER_AFF_INDIV_INDIV_EMAIL_EMAIL_ADDR                        ;
				string HEADER_AFF_INDIV_INDIV_FAX_FAX_NUMBER                          ;
				string HEADER_AFF_INDIV_INDIV_PHONE_PHONE_NUMBER                      ;
				string HEADER_AFF_INDIV_INDIV_PP_ADMIT_STATE                          ;
				string HEADER_AFF_INDIV_INDIV_PP_ADMIT_TEXT                           ;
				string HEADER_AFF_INDIV_INDIV_PP_ADMIT_YEAR                           ;
				string HEADER_AFF_INDIV_INDIV_PP_AGENCIES                             ;
				string HEADER_AFF_INDIV_INDIV_PP_ALSO_TEXT                            ;
				string HEADER_AFF_INDIV_INDIV_PP_BIOG_TEXT                            ;
				string HEADER_AFF_INDIV_INDIV_PP_BORN_TEXT                            ;
				string HEADER_AFF_INDIV_INDIV_PP_BORN_YEAR                            ;
				string HEADER_AFF_INDIV_INDIV_PP_EDUC_EDUCATION                       ;
				string HEADER_AFF_INDIV_INDIV_PP_EDUC_FLDEDUC_DEGREE                  ;
				string HEADER_AFF_INDIV_INDIV_PP_EDUC_FLDEDUC_GRADYEAR                ;
				string HEADER_AFF_INDIV_INDIV_PP_EDUC_FLDEDUC_HONORS                  ;
				string HEADER_AFF_INDIV_INDIV_PP_EDUC_FLDEDUC_NAME                    ;
				string HEADER_AFF_INDIV_INDIV_PP_EDUC_FLDEDUC_TYPE                    ;
				string HEADER_AFF_INDIV_INDIV_PP_LANGUAGES                            ;
				string HEADER_AFF_INDIV_INDIV_PP_LEG_SUPPORT_TITLE                    ;
				string HEADER_AFF_INDIV_INDIV_PP_MEMBER_ABA                           ;
				string HEADER_AFF_INDIV_INDIV_PP_MEMBER_CBA                           ;
				string HEADER_AFF_INDIV_INDIV_PP_MEMBER_IBA                           ;
				string HEADER_AFF_INDIV_INDIV_PP_MEMBER_PARSETEXT                     ;
				string HEADER_AFF_INDIV_INDIV_PP_NOTADMIT                             ;
				string HEADER_AFF_INDIV_INDIV_PP_PRACTICEAREA_PRACTAREA               ;
				string HEADER_AFF_INDIV_INDIV_PP_PRACTICEAREA_PRACTAREA_AREA          ;
				string HEADER_AFF_INDIV_INDIV_PP_PRACTICEAREA_PRACTAREA_PCTOFTIME     ;
				string HEADER_AFF_INDIV_INDIV_PP_RATING                               ;
				string HEADER_AFF_INDIV_INDIV_PP_REPCASES                             ;
				string HEADER_AFF_INDIV_INDIV_PP_RESPONSIBILITY_RESPONSIB_AREA        ;
				string HEADER_AFF_INDIV_INDIV_PP_SECTION                              ;
				string HEADER_AFF_INDIV_INDIV_URL_URL_ADDR                            ;
				string HEADER_AFF_INDIV_INDIV_URL_URL_HOTLINK                         ;
				string HEADER_AFF_INDIV_MULTIOFFICE                                   ;
				string HEADER_AFF_INDIV_NAME_DISPLAY_NAME                             ;
				string HEADER_AFF_INDIV_NAME_FIRSTNAME                                ;
				string HEADER_AFF_INDIV_NAME_LASTNAME                                 ;
				string HEADER_AFF_INDIV_NAME_ORG_NAME                                 ;
				string HEADER_AFF_INDIV_NAME_PREFIX                                   ;
				string HEADER_AFF_INDIV_NAME_SUFFIX                                   ;
				string HEADER_AFF_INDIV_POSITION                                      ;
				string HEADER_AFF_INDIV_ROSTERINFO_ROSTER_MEMBER_SINCE                ;
				string HEADER_AFF_INDIV_ROSTERINFO_ROSTER_MEMBERSHIP                  ;
				string HEADER_AFF_INDIV_ROSTERINFO_ROSTER_ROSTER_NAME                 ;
				string HEADER_AFF_INDIV_ROSTERINFO_ROSTER_ROSTERAUDIT_DATE            ;
				string HEADER_AFF_INDIV_ROSTERINFO_ROSTER_SOURCE_ID                   ;
				string HEADER_AFF_INDIV_ROSTERINFO_ROSTER_STATUS                      ;			
			end;
			
			export Organizations :=
			record, maxlength(max_size)
				string CONTACT                                                        ;
				string CONTACT_BLDG                                                   ;
				string CONTACT_CITY                                                   ;
				string CONTACT_COUNTRY                                                ;
				string CONTACT_COUNTY_COUNTY_NAME                                     ;
				string CONTACT_COUNTY_PHRASE                                          ;
				string CONTACT_EMAILS_EMAIL                                           ;
				string CONTACT_EMAILS_EMAIL_ADDR                                      ;
				string CONTACT_FAXS_FAX                                               ;
				string CONTACT_FAXS_FAX_NUMBER                                        ;
				string CONTACT_PHONES_PHONE                                           ;
				string CONTACT_PHONES_PHONE_NUMBER                                    ;
				string CONTACT_POBOX                                                  ;
				string CONTACT_STATE                                                  ;
				string CONTACT_STREET                                                 ;
				string CONTACT_URLS_URL_ADDR                                          ;
				string CONTACT_URLS_URL_HOTLINK                                       ;
				string CONTACT_XREFTEXT                                               ;
				string CONTACT_ZIP                                                    ;
				string ESTABLISH                                                      ;
				string FORMERLY                                                       ;
				dataset(Affiliated_Individuals) HEADER_AFF_INDIV							                      ;
				string HEADER_CD_HEADING                                              ;
				string HEADER_HEADING                                                 ;
				string INFO_COUNTRY                                                   ;
				string INFO_SORTCITY                                                  ;
				string INFO_SORTCOUNTRY                                               ;
				string INFO_STATE                                                     ;
				string LANGUAGES                                                      ;
				string LFAINFO_LFA                                                    ;
				string MAILADDR_MCITY                                                 ;
				string MAILADDR_MPOBOX                                                ;
				string MAILADDR_MSTATE                                                ;
				string MAILADDR_MSTREET                                               ;
				string MAILADDR_MZIP                                                  ;
				string MULTIOFFICE                                                    ;
				string NAME_CORP_BIOG_NAME                                            ;
				string NAME_DISPLAY_NAME                                              ;
				string NAME_FIRSTNAME                                                 ;
				string NAME_LASTNAME                                                  ;
				string NAME_ORG_NAME                                                  ;
				string NAME_PREFIX                                                    ;
				string NAME_SUFFIX                                                    ;
				string ORG_AUDIT_BARREG                                               ;
				string ORG_AUDIT_FIRMNO                                               ;
				string ORG_AUDIT_FIRMSEQNO                                            ;
				string ORG_AUDIT_LISTING_ID                                           ;
				string ORG_AUDIT_LISTING_TYPE                                         ;
				string ORG_AUDIT_LOCATION_SIZE                                        ;
				string ORG_AUDIT_MAINPOINT                                            ;
				string ORG_AUDIT_ORG_TYPE                                             ;
				string ORG_AUDIT_ORGID                                                ;
				string ORG_AUDIT_PREF_TYPE                                            ;
				string ORG_AUDIT_SIZE                                                 ;
				string ORG_AUDIT_SOLO                                                 ;
				string ORG_AUDIT_SORTKEY                                              ;
				string ORG_AUDIT_SUB_TYPE                                             ;
				string ORG_AUDIT_VERSION_ID                                           ;
				string ORG_AUDIT_XREF_LID                                             ;
				string ORG_AUDIT_XREF_VID                                             ;
				string ORG_BIOG_ADDLSEE                                               ;
				string ORG_BIOG_BIOG_CLIENTS                                          ;
				string ORG_BIOG_POSTINDIVTEXT                                         ;
				string ORG_BIOG_PREINDIVTEXT                                          ;
				string ORG_BIOG_REVISER                                               ;
				string ORG_BIOG_SECTION                                               ;
				string ORG_PP_PATENT_PATENT                                           ;
				string ORG_PP_PATENT_PATENT_SOP                                       ;
				string ORG_PP_PATENT_PERSONNEL                                        ;
				string ORG_PP_PERSONNEL                                               ;
				string ORG_PP_PP_CLIENTS                                              ;
				string ORG_PP_RATING                                                  ;
				string ORG_PP_SECTION                                                 ;
				string OTHEROFF                                                       ;
				string PARTNER                                                        ;
				string PROFILE                                                        ;
				string SOP                                                            ;	
			
			end;
			
			export Unaffiliated_Individuals :=
			record, maxlength(max_size)
				string ADMIT_STATE                                            := xmltext('ADMIT/STATE');
				string ADMIT_YEAR                                             := xmltext('ADMIT/YEAR');
				string ARMEDFORCES                                            := xmltext('ARMEDFORCES');
				string BORN_YEAR                                              := xmltext('BORN/YEAR');
				string CITY                                                   := xmltext('CITY');
				string CORP_IND                                               := xmltext('CORP.IND');
				string COUNTRY                                                := xmltext('COUNTRY');
				string COUNTY_COUNTY_NAME                                     := xmltext('COUNTY/COUNTY.NAME'[1]);
				string COUNTY_PHRASE                                          := xmltext('COUNTY/PHRASE');
				string DEVOTES                                                := xmltext('DEVOTES');
				string EDUC_FLDEDUC_DEGREE                                    := xmltext('EDUC/FLDEDUC/DEGREE'[1]);
				string EDUC_FLDEDUC_NAME                                      := xmltext('EDUC/FLDEDUC/NAME'[1]);
				string EDUC_FLDEDUC_TYPE                                      := xmltext('EDUC/FLDEDUC/TYPE'[1]);
				string INDIV_AUDIT_ATTYNO                                     := xmltext('INDIV.AUDIT/ATTYNO');
				string INDIV_AUDIT_ATTYSEQ                                    := xmltext('INDIV.AUDIT/ATTYSEQ');
				string INDIV_AUDIT_INDIV_ID                                   := xmltext('INDIV.AUDIT/INDIV.ID');
				string INDIV_AUDIT_ISLN                                       := xmltext('INDIV.AUDIT/ISLN');
				string INDIV_AUDIT_LISTING_ID                                 := xmltext('INDIV.AUDIT/LISTING.ID');
				string INDIV_AUDIT_LISTING_TYPE                               := xmltext('INDIV.AUDIT/LISTING.TYPE');
				string INDIV_AUDIT_SORTKEY                                    := xmltext('INDIV.AUDIT/SORTKEY');
				string INDIV_AUDIT_SUB_TYPE                                   := xmltext('INDIV.AUDIT/SUB.TYPE');
				string INDIV_AUDIT_VERSION_ID                                 := xmltext('INDIV.AUDIT/VERSION.ID');
				string INFO_COUNTRY                                           := xmltext('INFO/COUNTRY');
				string INFO_SORTCITY                                          := xmltext('INFO/SORTCITY');
				string INFO_SORTCOUNTRY                                       := xmltext('INFO/SORTCOUNTRY');
				string INFO_STATE                                             := xmltext('INFO/STATE');
				string MEMBER_ABA                                             := xmltext('MEMBER/ABA');
				string MEMBER_CBA                                             := xmltext('MEMBER/CBA');
				string MEMBER_IBA                                             := xmltext('MEMBER/IBA');
				string MULTIOFFICE                                            := xmltext('MULTIOFFICE');
				string NAME_DISPLAY_NAME                                      := xmltext('NAME/DISPLAY.NAME');
				string NAME_FIRSTNAME                                         := xmltext('NAME/FIRSTNAME');
				string NAME_LASTNAME                                          := xmltext('NAME/LASTNAME');
				string NAME_SUFFIX                                            := xmltext('NAME/SUFFIX');
				string NOTADMIT                                               := xmltext('NOTADMIT');
				string POBOX                                                  := xmltext('POBOX');
				string PRACTICEAREA_PRACTAREA_AREA                            := xmltext('PRACTICEAREA/PRACTAREA/AREA'[1]);
				string PRACTICEAREA_PRACTAREA_PCTOFTIME                       := xmltext('PRACTICEAREA/PRACTAREA/PCTOFTIME'[1]);
				string RATING                                                 := xmltext('RATING');
				string ROSTERINFO_ROSTER_MEMBER_SINCE                         := xmltext('ROSTERINFO/ROSTER/MEMBER.SINCE'[1]);
				string ROSTERINFO_ROSTER_MEMBERSHIP                           := xmltext('ROSTERINFO/ROSTER/MEMBERSHIP'[1]);
				string ROSTERINFO_ROSTER_ROSTER_NAME                          := xmltext('ROSTERINFO/ROSTER/ROSTER.NAME'[1]);
				string ROSTERINFO_ROSTER_ROSTERAUDIT_DATE                     := xmltext('ROSTERINFO/ROSTER/ROSTERAUDIT.DATE'[1]);
				string ROSTERINFO_ROSTER_SOURCE_ID                            := xmltext('ROSTERINFO/ROSTER/SOURCE.ID'[1]);
				string ROSTERINFO_ROSTER_STATUS                               := xmltext('ROSTERINFO/ROSTER/STATUS'[1]);
				string SECTION                                                := xmltext('SECTION');
				string STATE                                                  := xmltext('STATE');
				string STREET                                                 := xmltext('STREET');
				string TITLE                                                  := xmltext('TITLE');
				string ZIP                                                    := xmltext('ZIP');

			end;
			
			export Affiliated_Individuals_plus :=
			record, maxlength(max_size)

				Affiliated_Individuals																								;
				string CONTACT_BLDG                                                   ;
				string CONTACT_CITY                                                   ;
				string CONTACT_COUNTRY                                                ;
				string CONTACT_COUNTY_COUNTY_NAME                                     ;
				string CONTACT_COUNTY_PHRASE                                          ;
				string CONTACT_EMAILS_EMAIL                                           ;
				string CONTACT_EMAILS_EMAIL_ADDR                                      ;
				string CONTACT_FAXS_FAX                                               ;
				string CONTACT_FAXS_FAX_NUMBER                                        ;
				string CONTACT_PHONES_PHONE                                           ;
				string CONTACT_PHONES_PHONE_NUMBER                                    ;
				string CONTACT_POBOX                                                  ;
				string CONTACT_STATE                                                  ;
				string CONTACT_STREET                                                 ;
				string CONTACT_URLS_URL_ADDR                                          ;
				string CONTACT_URLS_URL_HOTLINK                                       ;
				string CONTACT_XREFTEXT                                               ;
				string CONTACT_ZIP                                                    ;
				string ORG_AUDIT_FIRMNO                                               ;
				string ORG_AUDIT_FIRMSEQNO                                            ;
				string ORG_AUDIT_LISTING_ID                                           ;
				string ORG_AUDIT_LISTING_TYPE                                         ;
				string ORG_AUDIT_LOCATION_SIZE                                        ;
				string ORG_AUDIT_MAINPOINT                                            ;
				string ORG_AUDIT_ORG_TYPE                                             ;
				string ORG_AUDIT_ORGID                                                ;

			end;
		
		end;
		
	end;

	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=
	module
	
		export Organizations :=
		record, maxlength(max_size)
		  bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
			unsigned6																		Bdid													:= 0;
			unsigned1																		bdid_score										:= 0;
			unsigned8																		RawAid_mailing								:= 0;
			unsigned8																		RawAid_Location								:= 0;
			unsigned8																		RawAid_contact_mailing				:= 0;
			unsigned8																		RawAid_contact_Location				:= 0;
			unsigned8																		ACEAID_mailing								:= 0;
			unsigned8																		ACEAID_Location								:= 0;
			unsigned8																		ACEAID_contact_mailing				:= 0;
			unsigned8																		ACEAID_contact_Location				:= 0;			
			unsigned4 																	dt_first_seen										;
			unsigned4 																	dt_last_seen										;
			unsigned4 																	dt_vendor_first_reported				;
			unsigned4 																	dt_vendor_last_reported					;
			string																			record_type											;

			input.Parsed.Organizations - HEADER_AFF_INDIV	rawfields											;
			Address.Layout_Clean182_fips								Clean_mailing_address						;
			Address.Layout_Clean182_fips								Clean_location_address					;
			Address.Layout_Clean182_fips								Clean_contact_mailing_address		;
			Address.Layout_Clean182_fips								Clean_contact_location_address	;

			Miscellaneous.Organizations.Cleaned_Phones	clean_phones										;
			Address.Layout_Clean_Name										clean_name											;
			string100																		contact_mailing_address1;
			string50																		contact_mailing_address2;
			string100																		contact_location_address1;
			string50																		contact_location_address2;
			string100																		mailing_address1;
			string50																		mailing_address2;
			string100																		location_address1;
			string50																		location_address2;			
		end;

		export Affiliated_Individuals :=
		record, maxlength(max_size)
		  bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
			unsigned6																		Bdid												:= 0;
			unsigned1																		bdid_score									:= 0;
			unsigned6																		Did													:= 0;
			unsigned1																		did_score										:= 0;
			unsigned8																		RawAid_mailing							:= 0;
			unsigned8																		RawAid_Location							:= 0;
		  unsigned8																		AceAID_Mailing							:= 0;		
		  unsigned8																		AceAID_Location							:= 0;					
			unsigned4 																	dt_first_seen										;
			unsigned4 																	dt_last_seen										;
			unsigned4 																	dt_vendor_first_reported				;
			unsigned4 																	dt_vendor_last_reported					;
			string																			record_type											;

			input.Parsed.Affiliated_Individuals_plus		rawfields												;
			Address.Layout_Clean_Name										clean_contact_name							;
			Address.Layout_Clean182_fips								Clean_contact_mailing_address		;
			Address.Layout_Clean182_fips								Clean_contact_location_address	;

			Miscellaneous.Affiliated_Individuals.Cleaned_Dates		clean_dates						;	
			Miscellaneous.Affiliated_Individuals.Cleaned_Phones		clean_phones					;

			string100																		contact_mailing_address1				;
			string50																		contact_mailing_address2				;
			string100																		contact_location_address1				;
			string50																		contact_location_address2				;			
		
		end;

		export Unaffiliated_Individuals :=
		record, maxlength(max_size)
			unsigned6																		Did													:= 0;
			unsigned1																		did_score										:= 0;
			unsigned8																		RawAid_mailing							:= 0;
			unsigned8																		RawAid_Location							:= 0;
			unsigned8																		ACEAid_mailing							:= 0;
			unsigned8																		ACEAid_Location							:= 0;			
			unsigned4 																	dt_first_seen										;
			unsigned4 																	dt_last_seen										;
			unsigned4 																	dt_vendor_first_reported				;
			unsigned4 																	dt_vendor_last_reported					;
			string																			record_type											;

			input.Parsed.Unaffiliated_Individuals				rawfields												;
			Address.Layout_Clean_Name										clean_contact_name							;
			Address.Layout_Clean182_fips								Clean_contact_mailing_address		;
			Address.Layout_Clean182_fips								Clean_contact_location_address	;

			Miscellaneous.Unaffiliated_Individuals.Cleaned_Dates			clean_dates				;

			string100 																	contact_mailing_address1;
			string50 																		contact_mailing_address2;
			string100 																	contact_location_address1;
			string50 																		contact_location_address2;			

		end;

	end;

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module
	
		export org_dates := 
		record
			
			string rosterdate;
		
		end;
		export Organizations :=
		record, maxlength(max_size)

			unsigned8										unique_id;
 			base.Organizations;
			dataset(org_dates)  				dates;
		end;
		
		export Organizations_AID :=
		record, maxlength(max_size)

			unsigned8										unique_id;
 			base.Organizations;
		end;		
	
		export Affiliated_Individuals :=
		record, maxlength(max_size)

			unsigned8										unique_id;
			base.Affiliated_Individuals;

		end;
		

		export Unaffiliated_Individuals :=
		record, maxlength(max_size)

			unsigned8										unique_id;
			base.Unaffiliated_Individuals;

		end;
		
		export Organizations_uniqueid :=
		record, maxlength(max_size)

			unsigned8										unique_id									;

			base.Organizations																		;
		end;
	
		export Affiliated_Individuals_uniqueid :=
		record, maxlength(max_size)

			unsigned8										unique_id									;

			base.Affiliated_Individuals																			;

		end;
	
		export Unaffiliated_Individuals_uniqueid :=
		record, maxlength(max_size)

			unsigned8										unique_id									;

			base.Unaffiliated_Individuals																			;

		end;

		export DidSlim := 
		record
		
			unsigned8		unique_id				;
			string20 		fname						;
			string20 		mname						;
			string20 		lname						;
			string5  		name_suffix			;
			string10  	prim_range			;
			string28		prim_name				;
			string8			sec_range				;
			string5			zip5						;
			string2			state						;
			string10		phone						;
			string8			dob							;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
	
		end;

		export BdidSlim := 
		record

			unsigned8		unique_id					;
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string25    city              ;
			string2			state							;
			string10		phone							;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			string      email         := '';
			string			URL						:= '';
			string20		Contact_fname := '';
			string20		Contact_mname := '';
			string20  	Contact_lname := '';
			bipv2.IDlayouts.l_xlink_ids    ;
			
		end;
		
		export Orgs :=
		record

			string		Bdid						;
			string		ORG_AUDIT_FIRMNO;
		
		end;

		export AffIndiv :=
		record

			string		Did							;
			string		isln						;
		
		end;

		export UnaffIndiv :=
		record

			string		Did							;
			string		isln						;
		
		end;

	export unafflayslimmh := 
	record

		string20	lname					;
		string20 	fname 				;
		string20	mname					;
		string2		mail_st				;
		string2 	loc_st 				;
		string2 	admit_st 			;
			string4	loc_err_stat	;
			string4	mail_err_stat	;
		string4		born_year			;
		string25	mail_city			;
		string25	loc_city			;
		string50	country			;
		string		ISLN					;
	end;

	export unafflayhdrextra := 
	record
		string20	lname					;
		string20 	fname 				;
		string20	mname					;
		integer4  dob;
		string25  city_name;
		string2   st;
		string10  phone;
	end;

		export unaff_redid := 
		record
			Base.Unaffiliated_Individuals;
			unsigned8		cnt;
			integer1		score;
		integer1		mname_score;
		integer1		dob_score;
		integer1		city_score;
		integer1		phone_score;
		integer1		state_score;
			unafflayslimmh 		mh_fields		;
			unafflayhdrextra	hdr_fields	;
		end;

		export afflayslimmh := 
		record

			string20	lname					;
			string20 	fname 				;
			string20	mname					;
			string2		mail_st				;
			string2 	loc_st 				;
			string2		admit_st			;
			string4		born_year			;
			string25	mail_city			;
			string25	loc_city			;
			string4	loc_err_stat	;
			string4	mail_err_stat	;
		string50	country			;
			string10	contact_fax		;									
			string10	contact_phone	;							
			string10	indiv_cell		;
			string10	indiv_fax			;		
			string10	indiv_phone		;
			string		ISLN					;
			string		attyno				;

		end;

		export afflayhdrextra := 
		record
			string20  fname;
			string20  mname;
			string20  lname;
			integer4  dob;
			string25  city_name;
			string10  phone;
			string2   st;
		end;
		
		export aff_redid := 
		record
			Base.Affiliated_Individuals	;
			unsigned8				cnt					;
			integer1				score				;
			integer1				mname_score	;
			integer1				dob_score		;
			integer1				city_score	;
			integer1				phone_score	;
			integer1				state_score	;
			afflayslimmh 		mh_fields		;
			afflayhdrextra	hdr_fields	;
		end;

	end;


end;