import address, AID, BIPV2;

export Layouts :=
module

	shared max_size := _Dataset().max_record_size;

	export Miscellaneous :=
	module
	
		export Cleaned_Dates :=
		record

			unsigned4    start_date   ;
			unsigned4    file_date    ;
			unsigned4    ccyymmdd     ;
			unsigned4    form_date    ;
			unsigned4    exp_date     ;
			unsigned4    disol_date   ;
			unsigned4    rpt_date     ;
			unsigned4    renew_date   ;
			unsigned4    chang_date   ;
			unsigned4    appt_date    ;
			unsigned4    fisc_date_   ;
			unsigned4		 proc_date		;

		end;
		
		export Cleaned_Phones :=
		record

			string10 biz_phone	;
			string10 ofc1_phone	;
			string10 ra_phone		;

		end;
		
	end;

	export Input :=
	module
	
		export Sprayed :=
		record
		
			string40   ofc1_name		;	
			string5    ofc1_title   ;
			string1    ofc1_gender  ;
			string50   ofc1_add     ;
			string30   ofc1_suite   ;
			string30   ofc1_city    ;
			string2    ofc1_state   ;
			string5    ofc1_zip     ;
			string3    ofc1_ac      ;
			string10   ofc1_phone   ;
			string15   ofc1_fein    ;
			string12   ofc1_ssn     ;
			string15   ofc1_type    ;
			string50   company      ;
			string50   mail_add     ;
			string30   mail_suite   ;
			string30   mail_city    ;
			string2    mail_state   ;
			string5    mail_zip     ;
			string4    mail_zip4    ;
			string1    mail_key     ;
			string15   county       ;
			string15   country      ;
			string25   district     ;
			string3    biz_ac       ;
			string10   biz_phone    ;
			string4    sic          ;
			string6    naics        ;
			string100  descript     ;
			string4    emp_size     ;
			string5    own_size     ;
			string2    corpcode     ;
			string9    sos_code     ;
			string1    filing_cod   ;
			string2    state_code   ;
			string2    status       ;
			string20   filing_num   ;
			string15   ctrl_num     ;
			string8    start_date   ;
			string8    file_date    ;
			string8    form_date    ;
			string8    exp_date     ;
			string8    disol_date   ;
			string8    rpt_date     ;
			string8    chang_date   ;
			string50   loc_add      ;
			string30   loc_suite    ;
			string30   loc_city     ;
			string2    loc_state    ;
			string5    loc_zip      ;
			string4    loc_zip4     ;
			string40   ofc2_name    ;
			string5    ofc2_title   ;
			string50   ofc2_add     ;
			string50   ofc2_csz     ;
			string15   ofc2_fein    ;
			string12   ofc2_ssn     ;
			string40   ofc3_name    ;
			string5    ofc3_title   ;
			string50   ofc3_add     ;
			string50   ofc3_csz     ;
			string15   ofc3_fein    ;
			string12   ofc3_ssn     ;
			string40   ofc4_name    ;
			string5    ofc4_title   ;
			string50   ofc4_add     ;
			string50   ofc4_csz     ;
			string15   ofc4_fein    ;
			string12   ofc4_ssn     ;
			string40   ofc5_name    ;
			string5    ofc5_title   ;
			string50   ofc5_add     ;
			string50   ofc5_csz     ;
			string15   ofc5_fein    ;
			string12   ofc5_ssn     ;
			string40   ofc6_name    ;
			string5    ofc6_title   ;
			string50   ofc6_add     ;
			string50   ofc6_csz     ;
			string15   ofc6_fein    ;
			string12   ofc6_ssn     ;
			string8    Fee         	;
			string8    Fee_2        ;
			string11   tax_cl       ;
			string15   perm_type    ;
			string4    page         ;
			string4    volume       ;
			string20   comments			;
			string10   jurisdiction	;
			string25	 ADCRecordNo  ;
			string2    crlf					;

		end;
		
		export Old :=
		record
			string40   ofc1_name			;
			string5    ofc1_title     ;
			string25   first          ;
			string1    mi             ;
			string25   last           ;
			string5    suffix         ;
			string1    gender         ;
			string1    ownr_code      ;
			string1    xcode          ;
			string50   company        ;
			string50   mail_add       ;
			string30   mail_suite     ;
			string30   mail_city      ;
			string2    mail_state     ;
			string5    mail_zip       ;
			string4    mail_zip4      ;
			string1    mail_key       ;
			string15   county         ;
			string15   country        ;
			string25   district       ;
			string1    citylimits     ;
			string3    biz_ac         ;
			string10   biz_phone      ;
			string3    fax_ac         ;
			string10   fax_num        ;
			string4    sic            ;
			string6    naics          ;
			string59   descript       ;
			string4    emp_size       ;
			string2    own_size       ;
			string2    corpcode       ;
			string4    sos_code       ;
			string4    filing_cod     ;
			string2    state_code     ;
			string2    status         ;
			string50   stat_des       ;
			string2    lic_sts        ;
			string3    lic_type       ;
			string20   filing_num     ;
			string15   licid          ;
			string5    acct_num       ;
			string15   co_fei         ;
			string15   ctrl_num       ;
			string8    start_date     ;
			string12   file_date      ;
			string8    ccyymmdd       ;
			string8    form_date      ;
			string8    exp_date       ;
			string8    disol_date     ;
			string8    rpt_date       ;
			string8    renew_date     ;
			string8    chang_date     ;
			string8    appt_date      ;
			string8    fisc_date_     ;
			string10   duration       ;
			string50   loc_add        ;
			string30   loc_suite      ;
			string30   loc_city       ;
			string2    loc_state      ;
			string5    loc_zip        ;
			string4    loc_zip4       ;
			string10   loc_idx        ;
			string50   ofc1_add       ;
			string30   ofc1_suite     ;
			string30   ofc1_city      ;
			string2    ofc1_state     ;
			string10   ofc1_zip       ;
			string3    ofc1_ac        ;
			string10   ofc1_phone     ;
			string15   ofc1_fein      ;
			string12   ofc1_ssn       ;
			string15   ofc1_type      ;
			string40   ofc2_name      ;
			string5    ofc2_title     ;
			string50   ofc2_add       ;
			string50   ofc2_csz       ;
			string15   ofc2_fein      ;
			string12   ofc2_ssn       ;
			string40   ofc3_name      ;
			string5    ofc3_title     ;
			string50   ofc3_add       ;
			string50   ofc3_csz       ;
			string15   ofc3_fein      ;
			string12   ofc3_ssn       ;
			string40   ofc4_name      ;
			string5    ofc4_title     ;
			string50   ofc4_add       ;
			string50   ofc4_csz       ;
			string15   ofc4_fein      ;
			string12   ofc4_ssn       ;
			string40   ofc5_name      ;
			string5    ofc5_title     ;
			string50   ofc5_add       ;
			string50   ofc5_csz       ;
			string15   ofc5_fein      ;
			string12   ofc5_ssn       ;
			string40   ofc6_name      ;
			string5    ofc6_title     ;
			string50   ofc6_add       ;
			string50   ofc6_csz       ;
			string15   ofc6_fein      ;
			string12   ofc6_ssn       ;
			string8    ra_date        ;
			string15   ra_file        ;
			string30   ra_name        ;
			string50   ra_add         ;
			string30   ra_suite       ;
			string30   ra_city        ;
			string2    ra_state       ;
			string10   ra_zip         ;
			string3    ra_ac          ;
			string10   ra_phone       ;
			string5    class          ;
			string10   stock_iss      ;
			string7    stock_par      ;
			string10   stock_type     ;
			string7    stock_cap      ;
			string7    paidn_cap      ;
			string8    fee            ;
			string8    fee_2          ;
			string8    fee_3          ;
			string1    tax_cl         ;
			string10   act            ;
			string10   chapter        ;
			string4    page           ;
			string4    volume         ;
			string20   comments       ;
			string30   email          ;
			string20   user_name      ;
			string1    dsf            ;
			string1    hmbase         ;
			string1    ho             ;
			string1    solicit        ;
			string10   fips           ;
			string14   record_no      ;
			string4    misc_code      ;
			string1    agent_key      ;
			string8    proc_date      ;
			string25	 ADCRecordNo  ;
			string2    crlf           ;
		end;                        

		export Old2 :=
		record
			string25   first          ;
			string1    mi             ;
			string25   last           ;
			string5    suffix         ;
			string1    gender         ;
			string1    ownr_code      ;
			string1    xcode          ;
			string50   company        ;
			string50   mail_add       ;
			string30   mail_suite     ;
			string30   mail_city      ;
			string2    mail_state     ;
			string5    mail_zip       ;
			string4    mail_zip4      ;
			string1    mail_key       ;
			string15   county         ;
			string15   country        ;
			string25   district       ;
			string1    citylimits     ;
			string3    biz_ac         ;
			string10   biz_phone      ;
			string3    fax_ac         ;
			string10   fax_num        ;
			string4    sic            ;
			string6    naics          ;
			string59   descript       ;
			string4    emp_size       ;
			string2    own_size       ;
			string2    corpcode       ;
			string4    sos_code       ;
			string4    filing_cod     ;
			string2    state_code     ;
			string2    status         ;
			string50   stat_des       ;
			string2    lic_sts        ;
			string3    lic_type       ;
			string20   filing_num     ;
			string15   licid          ;
			string5    acct_num       ;
			string15   co_fei         ;
			string15   ctrl_num       ;
			string8    start_date     ;
			string12   file_date      ;
			string8    ccyymmdd       ;
			string8    form_date      ;
			string8    exp_date       ;
			string8    disol_date     ;
			string8    rpt_date       ;
			string8    renew_date     ;
			string8    chang_date     ;
			string8    appt_date      ;
			string8    fisc_date_     ;
			string10   duration       ;
			string50   loc_add        ;
			string30   loc_suite      ;
			string30   loc_city       ;
			string2    loc_state      ;
			string5    loc_zip        ;
			string4    loc_zip4       ;
			string10   loc_idx        ;
			string30   ofc1_suite     ;
			string30   ofc1_city      ;
			string2    ofc1_state     ;
			string10   ofc1_zip       ;
			string3    ofc1_ac        ;
			string10   ofc1_phone     ;
			string15   ofc1_type      ;

			string40   ofc1_name			;
			string5    ofc1_title     ;
			string50   ofc1_add       ;
			string50   ofc1_csz       ;
			string15   ofc1_fein      ;
			string12   ofc1_ssn       ;

			string40   ofc2_name      ;
			string5    ofc2_title     ;
			string50   ofc2_add       ;
			string50   ofc2_csz       ;
			string15   ofc2_fein      ;
			string12   ofc2_ssn       ;
			string40   ofc3_name      ;
			string5    ofc3_title     ;
			string50   ofc3_add       ;
			string50   ofc3_csz       ;
			string15   ofc3_fein      ;
			string12   ofc3_ssn       ;
			string40   ofc4_name      ;
			string5    ofc4_title     ;
			string50   ofc4_add       ;
			string50   ofc4_csz       ;
			string15   ofc4_fein      ;
			string12   ofc4_ssn       ;
			string40   ofc5_name      ;
			string5    ofc5_title     ;
			string50   ofc5_add       ;
			string50   ofc5_csz       ;
			string15   ofc5_fein      ;
			string12   ofc5_ssn       ;
			string40   ofc6_name      ;
			string5    ofc6_title     ;
			string50   ofc6_add       ;
			string50   ofc6_csz       ;
			string15   ofc6_fein      ;
			string12   ofc6_ssn       ;
			string8    ra_date        ;
			string15   ra_file        ;
			string30   ra_name        ;
			string50   ra_add         ;
			string30   ra_suite       ;
			string30   ra_city        ;
			string2    ra_state       ;
			string10   ra_zip         ;
			string3    ra_ac          ;
			string10   ra_phone       ;
			string5    class          ;
			string10   stock_iss      ;
			string7    stock_par      ;
			string10   stock_type     ;
			string7    stock_cap      ;
			string7    paidn_cap      ;
			string8    fee            ;
			string8    fee_2          ;
			string8    fee_3          ;
			string1    tax_cl         ;
			string10   act            ;
			string10   chapter        ;
			string4    page           ;
			string4    volume         ;
			string20   comments       ;
			string30   email          ;
			string20   user_name      ;
			string1    dsf            ;
			string1    hmbase         ;
			string1    ho             ;
			string1    solicit        ;
			string10   fips           ;
			string14   record_no      ;
			string4    misc_code      ;
			string1    agent_key      ;
			string8    proc_date      ;
			string25	 ADCRecordNo  ;
			string2    crlf           ;
		end;                        

		export lofficers :=
		record
			string40   ofc_name      ;
			string5    ofc_title     ;
			string50   ofc_add       ;
			string50   ofc_csz       ;
			string15   ofc_fein      ;
			string12   ofc_ssn       ;
    end;
		
		export Old3 :=
		record
			string25   first          ;
			string1    mi             ;
			string25   last           ;
			string5    suffix         ;
			string1    gender         ;
			string1    ownr_code      ;
			string1    xcode          ;
			string50   company        ;
			string50   mail_add       ;
			string30   mail_suite     ;
			string30   mail_city      ;
			string2    mail_state     ;
			string5    mail_zip       ;
			string4    mail_zip4      ;
			string1    mail_key       ;
			string15   county         ;
			string15   country        ;
			string25   district       ;
			string1    citylimits     ;
			string3    biz_ac         ;
			string10   biz_phone      ;
			string3    fax_ac         ;
			string10   fax_num        ;
			string4    sic            ;
			string6    naics          ;
			string59   descript       ;
			string4    emp_size       ;
			string2    own_size       ;
			string2    corpcode       ;
			string4    sos_code       ;
			string4    filing_cod     ;
			string2    state_code     ;
			string2    status         ;
			string50   stat_des       ;
			string2    lic_sts        ;
			string3    lic_type       ;
			string20   filing_num     ;
			string15   licid          ;
			string5    acct_num       ;
			string15   co_fei         ;
			string15   ctrl_num       ;
			string8    start_date     ;
			string12   file_date      ;
			string8    ccyymmdd       ;
			string8    form_date      ;
			string8    exp_date       ;
			string8    disol_date     ;
			string8    rpt_date       ;
			string8    renew_date     ;
			string8    chang_date     ;
			string8    appt_date      ;
			string8    fisc_date_     ;
			string10   duration       ;
			string50   loc_add        ;
			string30   loc_suite      ;
			string30   loc_city       ;
			string2    loc_state      ;
			string5    loc_zip        ;
			string4    loc_zip4       ;
			string10   loc_idx        ;
			string30   ofc1_suite     ;
			string30   ofc1_city      ;
			string2    ofc1_state     ;
			string10   ofc1_zip       ;
			string3    ofc1_ac        ;
			string10   ofc1_phone     ;
			string15   ofc1_type      ;
			lofficers	 officers[6]		;
			string8    ra_date        ;
			string15   ra_file        ;
			string30   ra_name        ;
			string50   ra_add         ;
			string30   ra_suite       ;
			string30   ra_city        ;
			string2    ra_state       ;
			string10   ra_zip         ;
			string3    ra_ac          ;
			string10   ra_phone       ;
			string5    class          ;
			string10   stock_iss      ;
			string7    stock_par      ;
			string10   stock_type     ;
			string7    stock_cap      ;
			string7    paidn_cap      ;
			string8    fee            ;
			string8    fee_2          ;
			string8    fee_3          ;
			string1    tax_cl         ;
			string10   act            ;
			string10   chapter        ;
			string4    page           ;
			string4    volume         ;
			string20   comments       ;
			string30   email          ;
			string20   user_name      ;
			string1    dsf            ;
			string1    hmbase         ;
			string1    ho             ;
			string1    solicit        ;
			string10   fips           ;
			string14   record_no      ;
			string4    misc_code      ;
			string1    agent_key      ;
			string8    proc_date      ;
			string25	 ADCRecordNo  ;
			string2    crlf           ;
		end;                        

	end;                          
                                
	//////////////////////////////;//////////////////////////////////////////
	// -- Base Layouts           
	////////////////////////////////////////////////////////////////////////
	export Base :=
	module
		export full :=
		record
			unsigned6												Bdid												:= 0;
			unsigned1												bdid_score									:= 0;
			UNSIGNED6												br_id														;     //Linking field to contact records
			unsigned4 											dt_first_seen										;
			unsigned4 											dt_last_seen										;
			unsigned4 											dt_vendor_first_reported				;
			unsigned4 											dt_vendor_last_reported					;
			string1													record_type											;
			
			unsigned4												record_date											;
			input.old												rawfields												;
			Address.Layout_Clean_Name				clean_officer1_name							;
			Address.Layout_Clean_Name				clean_officer2_name							;
			Address.Layout_Clean_Name				clean_officer3_name							;
			Address.Layout_Clean_Name				clean_officer4_name							;
			Address.Layout_Clean_Name				clean_officer5_name							;
			Address.Layout_Clean_Name				clean_officer6_name							;
			Address.Layout_Clean182_fips		Clean_mailing_address						;
			Address.Layout_Clean182_fips		Clean_location_address					;
			Address.Layout_Clean182_fips		Clean_ra_address								;
			Address.Layout_Clean182_fips		Clean_officer1_address					;
			Address.Layout_Clean182_fips		Clean_officer2_address					;
			Address.Layout_Clean182_fips		Clean_officer3_address					;
			Address.Layout_Clean182_fips		Clean_officer4_address					;
			Address.Layout_Clean182_fips		Clean_officer5_address					;
			Address.Layout_Clean182_fips		Clean_officer6_address					;
			Miscellaneous.Cleaned_Dates			clean_dates											;
			Miscellaneous.Cleaned_Phones		clean_phones										;
		end;
		
		export full2 :=
		record
			unsigned6												Bdid												:= 0;
			unsigned1												bdid_score									:= 0;
			UNSIGNED6												br_id														;     //Linking field to contact records
			unsigned4 											dt_first_seen										;
			unsigned4 											dt_last_seen										;
			unsigned4 											dt_vendor_first_reported				;
			unsigned4 											dt_vendor_last_reported					;
			string1													record_type											;		

			unsigned4												record_date											;
			input.old2											rawfields												;
			Address.Layout_Clean_Name				clean_officer1_name							;
			Address.Layout_Clean_Name				clean_officer2_name							;
			Address.Layout_Clean_Name				clean_officer3_name							;
			Address.Layout_Clean_Name				clean_officer4_name							;
			Address.Layout_Clean_Name				clean_officer5_name							;
			Address.Layout_Clean_Name				clean_officer6_name							;
			Address.Layout_Clean182_fips		Clean_mailing_address						;
			Address.Layout_Clean182_fips		Clean_location_address					;
			Address.Layout_Clean182_fips		Clean_ra_address								;
			Address.Layout_Clean182_fips		Clean_officer1_address					;
			Address.Layout_Clean182_fips		Clean_officer2_address					;
			Address.Layout_Clean182_fips		Clean_officer3_address					;
			Address.Layout_Clean182_fips		Clean_officer4_address					;
			Address.Layout_Clean182_fips		Clean_officer5_address					;
			Address.Layout_Clean182_fips		Clean_officer6_address					;
			Miscellaneous.Cleaned_Dates			clean_dates											;
			Miscellaneous.Cleaned_Phones		clean_phones										;
		end;

		export full3 :=
		record
			unsigned6												Bdid												:= 0;
			unsigned1												bdid_score									:= 0;
			UNSIGNED6												br_id														;     //Linking field to contact records
			unsigned4 											dt_first_seen										;
			unsigned4 											dt_last_seen										;
			unsigned4 											dt_vendor_first_reported				;
			unsigned4 											dt_vendor_last_reported					;
			string1													record_type											;
			
			unsigned4												record_date											;
			input.old3											rawfields												;
			Address.Layout_Clean_Name				clean_officer_name[6]						;
			Address.Layout_Clean182_fips		Clean_mailing_address						;
			Address.Layout_Clean182_fips		Clean_location_address					;
			Address.Layout_Clean182_fips		Clean_ra_address								;
			Address.Layout_Clean182_fips		Clean_officer1_address					;
			Address.Layout_Clean182_fips		Clean_officer2_address					;
			Address.Layout_Clean182_fips		Clean_officer3_address					;
			Address.Layout_Clean182_fips		Clean_officer4_address					;
			Address.Layout_Clean182_fips		Clean_officer5_address					;
			Address.Layout_Clean182_fips		Clean_officer6_address					;
			Miscellaneous.Cleaned_Dates			clean_dates											;
			Miscellaneous.Cleaned_Phones		clean_phones										;
		end;

		export AID2	:=	Record
			full2;
			string100				Clean_mailing_address1	;
			string50				Clean_mailing_address2	;
			string100				Clean_location_address1	;
			string50				Clean_location_address2	;
			string100				Clean_RA_address1				;
			string50				Clean_RA_address2			 	;		
			string100				Clean_officer1_address1	;
			string50				Clean_officer1_address2	;
			string100				Clean_officer2_address1	;
			string50				Clean_officer2_address2	;
			string100				Clean_officer3_address1	;
			string50				Clean_officer3_address2	;
			string100				Clean_officer4_address1	;
			string50				Clean_officer4_address2	;
			string100				Clean_officer5_address1	;
			string50				Clean_officer5_address2	;
			string100				Clean_officer6_address1	;
			string50				Clean_officer6_address2	;			
			AID.Common.xAID	Append_MailRawAID		:=	0;
			AID.Common.xAID	Append_MailACEAID		:=	0;
			
			AID.Common.xAID	Append_LocRawAID		:=	0;
			AID.Common.xAID	Append_LocACEAID		:=	0;

			AID.Common.xAID	Append_RARawAID			:=	0;
			AID.Common.xAID	Append_RAACEAID			:=	0;
			
			AID.Common.xAID	Append_Off1RawAID		:=	0;
			AID.Common.xAID	Append_Off1ACEAID		:=	0;
			
			AID.Common.xAID	Append_Off2RawAID		:=	0;	
			AID.Common.xAID	Append_Off2ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off3RawAID		:=	0;	
			AID.Common.xAID	Append_Off3ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off4RawAID		:=	0;
			AID.Common.xAID	Append_Off4ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off5RawAID		:=	0;
			AID.Common.xAID	Append_Off5ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off6RawAID		:=	0;
			AID.Common.xAID	Append_Off6ACEAID		:=	0;	
			
		end;			

		export AID3	:=	Record
			full3;
			string100				Clean_mailing_address1	;
			string50				Clean_mailing_address2	;
			string100				Clean_location_address1	;
			string50				Clean_location_address2	;
			string100				Clean_RA_address1				;
			string50				Clean_RA_address2			 	;		
			string100				Clean_officer1_address1	;
			string50				Clean_officer1_address2	;
			string100				Clean_officer2_address1	;
			string50				Clean_officer2_address2	;
			string100				Clean_officer3_address1	;
			string50				Clean_officer3_address2	;
			string100				Clean_officer4_address1	;
			string50				Clean_officer4_address2	;
			string100				Clean_officer5_address1	;
			string50				Clean_officer5_address2	;
			string100				Clean_officer6_address1	;
			string50				Clean_officer6_address2	;			
			AID.Common.xAID	Append_MailRawAID		:=	0;
			AID.Common.xAID	Append_MailACEAID		:=	0;
			
			AID.Common.xAID	Append_LocRawAID		:=	0;
			AID.Common.xAID	Append_LocACEAID		:=	0;

			AID.Common.xAID	Append_RARawAID			:=	0;
			AID.Common.xAID	Append_RAACEAID			:=	0;
			
			AID.Common.xAID	Append_Off1RawAID		:=	0;
			AID.Common.xAID	Append_Off1ACEAID		:=	0;
			
			AID.Common.xAID	Append_Off2RawAID		:=	0;	
			AID.Common.xAID	Append_Off2ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off3RawAID		:=	0;	
			AID.Common.xAID	Append_Off3ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off4RawAID		:=	0;
			AID.Common.xAID	Append_Off4ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off5RawAID		:=	0;
			AID.Common.xAID	Append_Off5ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off6RawAID		:=	0;
			AID.Common.xAID	Append_Off6ACEAID		:=	0;	
			
		end;			
		export AID	:=	Record
			full;
			string100				Clean_mailing_address1	;
			string50				Clean_mailing_address2	;
			string100				Clean_location_address1	;
			string50				Clean_location_address2	;
			string100				Clean_RA_address1				;
			string50				Clean_RA_address2			 	;		
			string100				Clean_officer1_address1	;
			string50				Clean_officer1_address2	;
			string100				Clean_officer2_address1	;
			string50				Clean_officer2_address2	;
			string100				Clean_officer3_address1	;
			string50				Clean_officer3_address2	;
			string100				Clean_officer4_address1	;
			string50				Clean_officer4_address2	;
			string100				Clean_officer5_address1	;
			string50				Clean_officer5_address2	;
			string100				Clean_officer6_address1	;
			string50				Clean_officer6_address2	;			
			AID.Common.xAID	Append_MailRawAID		:=	0;
			AID.Common.xAID	Append_MailACEAID		:=	0;
			
			AID.Common.xAID	Append_LocRawAID		:=	0;
			AID.Common.xAID	Append_LocACEAID		:=	0;

			AID.Common.xAID	Append_RARawAID			:=	0;
			AID.Common.xAID	Append_RAACEAID			:=	0;
			
			AID.Common.xAID	Append_Off1RawAID		:=	0;
			AID.Common.xAID	Append_Off1ACEAID		:=	0;
			
			AID.Common.xAID	Append_Off2RawAID		:=	0;	
			AID.Common.xAID	Append_Off2ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off3RawAID		:=	0;	
			AID.Common.xAID	Append_Off3ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off4RawAID		:=	0;
			AID.Common.xAID	Append_Off4ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off5RawAID		:=	0;
			AID.Common.xAID	Append_Off5ACEAID		:=	0;	
			
			AID.Common.xAID	Append_Off6RawAID		:=	0;
			AID.Common.xAID	Append_Off6ACEAID		:=	0;	
			UNSIGNED8 source_rec_id						  :=  0;  //Added for BIP2V2 project
			BIPV2.IDlayouts.l_xlink_ids;								//Added for BIP2V2 project
		end;			
		
		export companies :=
		RECORD
			UNSIGNED6 bdid;
			UNSIGNED6 br_id;     //Linking field to contact records
			STRING8   dt_first_seen;
			STRING8   dt_last_seen;
			STRING1   record_type;
			STRING8  record_date;
			STRING40 OFC1_NAME;
			STRING5  OFC1_TITLE;
			STRING25 FIRST_NAME;
			STRING1  MI;
			STRING25 LAST_NAME;
			STRING5  SUFFIX;
			STRING1  GENDER;
			STRING1  OWNR_CODE;     // 'C' indicates OFC1 is a corporation
			STRING1  XCODE;
			STRING50 COMPANY_NAME;
			STRING50 MAIL_ADD;
			STRING30 MAIL_SUITE;
			STRING30 MAIL_CITY;
			STRING2  MAIL_STATE;
			STRING5  MAIL_ZIP_ORIG;
			STRING4  MAIL_ZIP4_ORIG;
			STRING1  MAIL_KEY;
			STRING15 COUNTY;
			STRING15 COUNTRY;
			STRING25 DISTRICT;
			STRING1	 CITYLIMITS;
			STRING3  BIZ_AC;
			STRING10 BIZ_PHONE;
			STRING3  FAX_AC;
			STRING10 FAX_NUM;
			STRING4  SIC;
			STRING6  NAICS;
			STRING59 DESCRIPT;
			STRING4  EMP_SIZE;
			STRING2  OWN_SIZE;
			STRING2  CORPCODE;
			STRING4  SOS_CODE;
			STRING4  FILING_COD;
			STRING2  STATE_CODE;
			STRING2  STATUS;
			STRING50 STAT_DES;
			STRING2  LIC_STS;
			STRING3  LIC_TYPE;
			STRING20 FILING_NUM;
			STRING15 LICID;
			STRING5  ACCT_NUM;
			STRING15 CO_FEI;
			STRING15 CTRL_NUM;
			STRING8  START_DATE;
			STRING12 FILE_DATE;
			STRING8  CCYYMMDD;
			STRING8  FORM_DATE;
			STRING8  EXP_DATE;
			STRING8  DISOL_DATE;
			STRING8  RPT_DATE;
			STRING8  RENEW_DATE;
			STRING8  CHANG_DATE;
			STRING8  APPT_DATE;
			STRING8  FISC_DATE_;
			STRING10 DURATION;
			STRING50 LOC_ADD;
			STRING30 LOC_SUITE;
			STRING30 LOC_CITY;
			STRING2  LOC_STATE;
			STRING5  LOC_ZIP_ORIG;
			STRING4  LOC_ZIP4_ORIG;
			STRING10 LOC_IDX;
			STRING50 OFC1_ADD;
			STRING30 OFC1_SUITE;
			STRING30 OFC1_CITY;
			STRING2  OFC1_STATE;
			STRING10 OFC1_ZIP_ORIG;
			STRING3  OFC1_AC;
			STRING10 OFC1_PHONE;
			STRING15 OFC1_FEIN;
			STRING12 OFC1_SSN;
			STRING15 OFC1_TYPE;
			STRING8  RA_DATE;
			STRING15 RA_FILE;
			STRING30 RA_NAME;
			STRING50 RA_ADD;
			STRING30 RA_SUITE;
			STRING30 RA_CITY;
			STRING2  RA_STATE;
			STRING10 RA_ZIP_ORIG;
			STRING3  RA_AC;
			STRING10 RA_PHONE;
			STRING5  CLASS;
			STRING10 STOCK_ISS;
			STRING7  STOCK_PAR;
			STRING10 STOCK_TYPE;
			STRING7  STOCK_CAP;
			STRING7  PAIDN_CAP;
			STRING8  FEE;
			STRING8  FEE_2;
			STRING8  FEE_3;
			STRING1  TAX_CL;
			STRING10 ACT;
			STRING10 CHAPTER;
			STRING4  PAGE;
			STRING4  VOLUME;
			STRING20 COMMENTS;
			STRING30 EMAIL_ADDR;
			STRING20 USER_NAME;
			STRING1  DSF;
			STRING1  HMBASE;
			STRING1  HO;
			STRING1  SOLICIT;
			STRING10 FIPS;
			STRING14 RECORD_NO;
			STRING4  MISC_CODE;
			STRING1  AGENT_KEY;
			STRING8  PROC_DATE;
			Address.Layout_Clean182_fips		Clean_mailing_address						;
			Address.Layout_Clean182_fips		Clean_location_address					;
			Address.Layout_Clean182_fips		Clean_ra_address								;
			Address.Layout_Clean182_fips		Clean_officer1_address					;
			Address.Layout_Clean_Name				clean_officer1_name							;
			STRING10 company_phone10;
			STRING10 ofc1_phone10;
			STRING10 ra_phone10;

		END;
		
		export contacts :=
		record
			UNSIGNED6 did;
			UNSIGNED6 bdid;
			UNSIGNED6 br_id;
			STRING8   dt_first_seen;
			STRING8   dt_last_seen;
			STRING1   record_type;
			STRING40 NAME;
			STRING5  TITLE;
			STRING50 ADD;
			STRING50 CSZ;
			STRING15 FEIN;
			STRING12 SSN;
			STRING10 PHONE;
			Address.Layout_Clean_Name clean_name;
			Address.Layout_Clean182_fips clean_address;

		end;

	end;

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module

		export StandardizeInput :=
		record

		unsigned8		unique_id								;
		base.AID														;

		end;

		export StandardizeInput2 :=
		record

		unsigned8		unique_id								;
		base.AID2														;

		end;

		export StandardizeInput3 :=
		record

		unsigned8		unique_id								;
		base.AID3														;

		end;

		export UniqueIdFull := 
		record

			unsigned8		unique_id							;

			Base.full													;

		end;

		export UniqueIdContacts := 
		record

			unsigned8										unique_id	;

			Layout_BusReg_Contact									;

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
			string25    p_city_name				;			
			string2			state							;
			string10		phone							;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			string20 		fname							;
			string20 		mname							;
			string20 		lname							;
			BIPV2.IDlayouts.l_xlink_ids		;		 //Added for BIP2 project
			unsigned8		source_rec_id			;    //Added for BIP2 project
			string2			source						;		 //Added for BIP2 project
		end;

	end;

end;