import address;
export Layouts :=
module
   shared max_size := _Dataset.max_record_size;
   
	 export Miscellaneous :=
   module
   
      export Cleaned_Dates :=
      record
         unsigned4      Validation_Date         ;
      end;
      
      export Cleaned_Phones :=
      record
         string10 Company_Phone_Number    ;
      end;
      
   end;
   
	 export Input :=
   module

			export raw_contacts :=
			record
         string20   CON_NAME_HONORIFIC            ;
         string60   CON_NAME_FIRST_NAME           ;
         string60   CON_NAME_MID_NAME             ;
         string60   CON_NAME_LAST_NAME            ;
         string3    CON_NAME_GEN_CD               ;
         string60   CON_NAME_TITLE                ;
         string4    CON_NAME_TITLE_CD             ;
			end;
			
			
      export Sprayed :=
      record
         string14   BIN                           ;
         string36   BUSINESS_NAME                 ;
         string30   BUSINESS_ADDRESS              ;
         string13   CITY                          ;
         string2    STATE                         ;
         string5    ZIP                           ;
         string4    PLUS4_ZIP                     ;
         string4    CARRIER_RTE                   ;
         string3    COUNTY_CODE                   ;
         string10   PHONE                         ;
         string4    MSA_CODE                      ;
         string1    RECENT_UPDT_CD                ;
         string1    YRS_IN_BUS_CD                 ;
         string4    YEAR_STARTED                  ;
         string1    HOTLINE_TYPE                  ;
         string6    HOTLINE_DATE_CCYYMM           ;
         string1    BUSINESS_TYPE                 ;
         string1    ADDRESS_TYPE                  ;
         string1    OXXFORD_LIFE_CYCLE            ;
         string1    EMPLOYEE_CODE                 ;
         string7    EMPLOYEE_ACTUAL               ;
         string7    ACTUAL_SALES                  ;
         string1    SALES_CODE                    ;
         string1    OWNERSHIP_CODE                ;
         string1    LOCATION_CODE                 ;
         string1    SIC_CODE_1_IC                 ;
         string8    SIC_CODE_1                    ;
         string8    SIC_CODE_2                    ;
         string8    SIC_CODE_3                    ;
         string8    SIC_CODE_4                    ;
         string10   Filler                        ;
         string3    EXEC_COUNT                    ;
         string3    EXEC_GENDER                   ;
         string20   EXEC_NAME_LAST                ;
         string10   EXEC_NAME_FIRST               ;
         string1    EXEC_MI                       ;
         string10   EXEC_TITLE                    ;
         string1    DEROG_LGL_IND                 ;
         string8    LGL_FILED_DATE                ;
         string9    LGL_LIABILTY_AMT              ;
         string1    UCC_DATA_IND                  ;
         string3    UCC_COUNT                     ;
         string8    INQUIRY_DATE                  ;
         string9    RECENT_HIGH_CRDT              ;
         string9    MEDIAN_CREDIT                 ;
         string3    COMB_TRADE_LINES              ;
         string3    COMB_TRADE_DBT                ;
         string9    COMB_TRADE_BAL                ;
         string3    PCT_CURRENT                   ;
         string3    PCT_31_60_PD                  ;
         string3    PCT_OVER_60_PD                ;
         string3    AGED_LINES                    ;
         string1    CREDIT_RATING                 ;
         string9    BCS_FILE_NUM                  ;
         string7    INTEL_SCORE                   ;
         string3    INTEL_PCT                     ;
         string5    INTEL_PROB                    ;
         string3    QTR1_AVG_DBT                  ;
         string3    QTR2_AVG_DBT                  ;
         string3    QTR3_AVG_DBT                  ;
         string3    QTR4_AVG_DBT                  ;
         string3    QTR5_AVG_DBT                  ;
         string7    MARKET_INTELLISCORE           ;
         string39   SIC_1_DESCRIPTION             ;
         string39   SIC_2_DESCRIPTION             ;
         string39   SIC_3_DESCRIPTION             ;
         string39   SIC_4_DESCRIPTION             ;
         string120  PRI_BUS_NAME                  ;
         string3    PRI_BUS_NAME_TYPE             ;
         string120  ALT_BUS_NAME                  ;
         string3    ALT_BUS_NAME_TYPE             ;
         string1    PRI_BUS_ADDR_LOC_TYPE         ;
         string40   PRI_BUS_CITY                  ;
         string25   PRI_BUS_COUNTY_NAME           ;
         string40   MAIL_BUS_CITY                 ;
         string2    MAIL_BUS_STATE                ;
         string5    MAIL_BUS_ZIP                  ;
         string4    MAIL_BUS_ZIP_PLUS4            ;
         string4    MAIL_BUS_CARRIER_RTE          ;
         string3    MAIL_BUS_FIPS_COU_CD          ;
         string25   MAIL_BUS_COUNTY_NAME          ;
         string1    PRI_PHONE_TYPE                ;
         string1    PRI_PHONE_VAL_IND             ;
         string1    ALT_PHONE_TYPE                ;
         string1    ALT_PHONE_CON_CD              ;
         string1    ALT_PHONE_VAL_IND             ;
         string10   ALT_PHONE_NUMBER              ;
         string9    TAX_ID2                       ;
         string9    TAX_ID3                       ;
         string9    TAX_ID4                       ;
         string100  URL                           ;
         string1    YRS_IN_BUS_DER_CD             ;
         string6    YR_MO_BUS_STARTED             ;
         string7    LOC_EMP_COUNT                 ;
         string7    LOC_SALES_AMT                 ;
         string7    CORP_EMP_COUNT                ;
         string1    CORP_EMP_SIZE_CD              ;
         string7    CORP_SALES_AMT                ;
         string1    CORP_SALES_SIZE_CD            ;
         string2    REC_UPD_CD                    ;
         string1    LEG_BUS_STR                   ;
         string1    LIM_LIAB_CORP_CD              ;
         string1    LOC_OPE_STR                   ;
         string1    OWNERSHIP_CD                  ;
         string1    AFFILIATE_IND                 ;
         string1    SUBSIDIARY_IND                ;
         string1    FORTUNE_1000_IND              ;
         string1    FRANCHISE_CD                  ;
         string1    COTTAGE_IND                   ;
         string1    PERSONAL_NAME_IND             ;
         string10   GEO_LATITUDE                  ;
         string10   GEO_LONGITUDE                 ;
         string1    OUT_OF_BUS_FLAG               ;
         string1    UNDELIVERABLE_FLAG            ;
         string1    PRI_SIC_DER_CD                ;
         string1    SEC_SIC_DER_CD                ;
         string1    THI_SIC_DER_CD                ;
         string1    FOU_SIC_DER_CD                ;
         string1    NAICS1_DER_CD                 ;
         string1    NAICS2_DER_CD                 ;
         string1    NAICS3_DER_CD                 ;
         string1    NAICS4_DER_CD                 ;
				 dataset(raw_contacts, count(5))	contacts;
         string2    filler1                       ;
         string5    Filler2                       ;
         string50   MSA_FULL_NAME                 ;
         string9    TAXID                         ;
         string1    Filler3                       ;
         string6    NAICS_1                       ;
         string6    NAICS_2                       ;
         string6    NAICS_3                       ;
         string6    NAICS_4                       ;
         string140  NAICS_BHDG_1                  ;
         string140  NAICS_BHDG_2                  ;
         string140  NAICS_BHDG_3                  ;
         string140  NAICS_BHDG_4                  ;
         string1    EOF_X                         ;
         string2    crlf                          ;
      
      end;
			
			export Companies :=
			record
         string14   BIN                           ;
         string36   BUSINESS_NAME                 ;
         string30   BUSINESS_ADDRESS              ;
         string13   CITY                          ;
         string2    STATE                         ;
         string5    ZIP                           ;
         string4    PLUS4_ZIP                     ;
         string4    CARRIER_RTE                   ;
         string3    COUNTY_CODE                   ;
         string10   PHONE                         ;
         string4    MSA_CODE                      ;
         string1    RECENT_UPDT_CD                ;
         string1    YRS_IN_BUS_CD                 ;
         string4    YEAR_STARTED                  ;
         string1    HOTLINE_TYPE                  ;
         string6    HOTLINE_DATE_CCYYMM           ;
         string1    BUSINESS_TYPE                 ;
         string1    ADDRESS_TYPE                  ;
         string1    OXXFORD_LIFE_CYCLE            ;
         string1    EMPLOYEE_CODE                 ;
         string7    EMPLOYEE_ACTUAL               ;
         string7    ACTUAL_SALES                  ;
         string1    SALES_CODE                    ;
         string1    OWNERSHIP_CODE                ;
         string1    LOCATION_CODE                 ;
         string1    SIC_CODE_1_IC                 ;
         string8    SIC_CODE_1                    ;
         string8    SIC_CODE_2                    ;
         string8    SIC_CODE_3                    ;
         string8    SIC_CODE_4                    ;
         string3    EXEC_COUNT                    ;
         string1    DEROG_LGL_IND                 ;
         string8    LGL_FILED_DATE                ;
         string9    LGL_LIABILTY_AMT              ;
         string1    UCC_DATA_IND                  ;
         string3    UCC_COUNT                     ;
         string8    INQUIRY_DATE                  ;
         string9    RECENT_HIGH_CRDT              ;
         string9    MEDIAN_CREDIT                 ;
         string3    COMB_TRADE_LINES              ;
         string3    COMB_TRADE_DBT                ;
         string9    COMB_TRADE_BAL                ;
         string3    PCT_CURRENT                   ;
         string3    PCT_31_60_PD                  ;
         string3    PCT_OVER_60_PD                ;
         string3    AGED_LINES                    ;
         string1    CREDIT_RATING                 ;
         string9    BCS_FILE_NUM                  ;
         string7    INTEL_SCORE                   ;
         string3    INTEL_PCT                     ;
         string5    INTEL_PROB                    ;
         string3    QTR1_AVG_DBT                  ;
         string3    QTR2_AVG_DBT                  ;
         string3    QTR3_AVG_DBT                  ;
         string3    QTR4_AVG_DBT                  ;
         string3    QTR5_AVG_DBT                  ;
         string7    MARKET_INTELLISCORE           ;
         string39   SIC_1_DESCRIPTION             ;
         string39   SIC_2_DESCRIPTION             ;
         string39   SIC_3_DESCRIPTION             ;
         string39   SIC_4_DESCRIPTION             ;
         string120  PRI_BUS_NAME                  ;
         string3    PRI_BUS_NAME_TYPE             ;
         string120  ALT_BUS_NAME                  ;
         string3    ALT_BUS_NAME_TYPE             ;
         string1    PRI_BUS_ADDR_LOC_TYPE         ;
         string40   PRI_BUS_CITY                  ;
         string25   PRI_BUS_COUNTY_NAME           ;
         string40   MAIL_BUS_CITY                 ;
         string2    MAIL_BUS_STATE                ;
         string5    MAIL_BUS_ZIP                  ;
         string4    MAIL_BUS_ZIP_PLUS4            ;
         string4    MAIL_BUS_CARRIER_RTE          ;
         string3    MAIL_BUS_FIPS_COU_CD          ;
         string25   MAIL_BUS_COUNTY_NAME          ;
         string1    PRI_PHONE_TYPE                ;
         string1    PRI_PHONE_VAL_IND             ;
         string1    ALT_PHONE_TYPE                ;
         string1    ALT_PHONE_CON_CD              ;
         string1    ALT_PHONE_VAL_IND             ;
         string10   ALT_PHONE_NUMBER              ;
         string9    TAX_ID2                       ;
         string9    TAX_ID3                       ;
         string9    TAX_ID4                       ;
         string100  URL                           ;
         string1    YRS_IN_BUS_DER_CD             ;
         string6    YR_MO_BUS_STARTED             ;
         string7    LOC_EMP_COUNT                 ;
         string7    LOC_SALES_AMT                 ;
         string7    CORP_EMP_COUNT                ;
         string1    CORP_EMP_SIZE_CD              ;
         string7    CORP_SALES_AMT                ;
         string1    CORP_SALES_SIZE_CD            ;
         string2    REC_UPD_CD                    ;
         string1    LEG_BUS_STR                   ;
         string1    LIM_LIAB_CORP_CD              ;
         string1    LOC_OPE_STR                   ;
         string1    OWNERSHIP_CD                  ;
         string1    AFFILIATE_IND                 ;
         string1    SUBSIDIARY_IND                ;
         string1    FORTUNE_1000_IND              ;
         string1    FRANCHISE_CD                  ;
         string1    COTTAGE_IND                   ;
         string1    PERSONAL_NAME_IND             ;
         string10   GEO_LATITUDE                  ;
         string10   GEO_LONGITUDE                 ;
         string1    OUT_OF_BUS_FLAG               ;
         string1    UNDELIVERABLE_FLAG            ;
         string1    PRI_SIC_DER_CD                ;
         string1    SEC_SIC_DER_CD                ;
         string1    THI_SIC_DER_CD                ;
         string1    FOU_SIC_DER_CD                ;
         string1    NAICS1_DER_CD                 ;
         string1    NAICS2_DER_CD                 ;
         string1    NAICS3_DER_CD                 ;
         string1    NAICS4_DER_CD                 ;
         string50   MSA_FULL_NAME                 ;
         string9    TAXID                         ;
         string6    NAICS_1                       ;
         string6    NAICS_2                       ;
         string6    NAICS_3                       ;
         string6    NAICS_4                       ;
         string140  NAICS_BHDG_1                  ;
         string140  NAICS_BHDG_2                  ;
         string140  NAICS_BHDG_3                  ;
         string140  NAICS_BHDG_4                  ;
			end;
			
			export Contacts := 
			record
         string14   BIN                           ;
         raw_contacts;
         string36   BUSINESS_NAME                 ;
         string30   BUSINESS_ADDRESS              ;
         string13   CITY                          ;
         string2    STATE                         ;
         string5    ZIP                           ;
         string4    PLUS4_ZIP                     ;
         string10   PHONE                         ;
			end;
			
   end;
   ////////////////////////////////////////////////////////////////////////
   // -- Base Layouts
   ////////////////////////////////////////////////////////////////////////
   export Base :=
	 module
	 
		 export Companies :=
		 record
				unsigned6                        Bdid                        := 0;
				unsigned1                        bdid_score                  := 0;
				unsigned4                        dt_first_seen                   ;
				unsigned4                        dt_last_seen                    ;
				unsigned4                        dt_vendor_first_reported        ;
				unsigned4                        dt_vendor_last_reported         ;
				input.Companies                  rawfields                       ;
				Address.Layout_Clean182_fips     Clean_Company_address           ;
		 end;
   
		 export Contacts :=
		 record
				unsigned6                        Did                         := 0;
				unsigned1                        did_score                   := 0;
				unsigned4                        dt_first_seen                   ;
				unsigned4                        dt_last_seen                    ;
				unsigned4                        dt_vendor_first_reported    		 ;
				unsigned4                        dt_vendor_last_reported     		 ;
				input.Contacts                   rawfields                       ;
				Address.Layout_Clean_Name        clean_contact_name              ;
				Address.Layout_Clean182_fips     Clean_Company_address           ;
		 end;

	 end;
	 ////////////////////////////////////////////////////////////////////////
   // -- Temporary Layouts for processing
   ////////////////////////////////////////////////////////////////////////
   export Temporary :=
   module
      
			export StandardizeCompanies := 
      record
         unsigned8                           unique_id   ;
         string100                           address1 ;
         string50                            address2 ;
         Base.Companies                               ;
      end;
			
			export StandardizeContacts := 
      record
         unsigned8                           unique_id  ;
         string100                           address1 	;
         string50                            address2 	;
         Base.Contacts                                  ;
      end;

      export UniqueIdCompanies := 
      record
         unsigned8                              unique_id   ;
         Base.Companies                                     ;
      end;
			
      export UniqueIdContacts := 
      record
         unsigned8                              unique_id   ;
         Base.Contacts                                     ;
      end;

      export DidSlim := 
      record
      
         unsigned8      unique_id            ;
         string20       fname                ;
         string20       mname                ;
         string20       lname                ;
         string5        name_suffix       ;
         string10    		prim_range        ;
         string28    		prim_name            ;
         string8        sec_range            ;
         string5        zip5                 ;
         string2        state                ;
         string10    		phone                ;
         unsigned6      did               := 0;
         unsigned1      did_score      := 0;
   
      end;
      export BdidSlim := 
      record
         unsigned8      unique_id               ;
         string100   company_name         ;
         string10    prim_range           ;
         string28    prim_name               ;
         string5        zip5                    ;
         string8        sec_range               ;
         string2        state                   ;
         string10    phone                   ;
         unsigned6      bdid              := 0;
         unsigned1      bdid_score     := 0;
				 string9			fein;
   
      end;
   end;
end;
