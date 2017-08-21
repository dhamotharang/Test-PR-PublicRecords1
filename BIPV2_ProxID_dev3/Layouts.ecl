import 
// Business_DOT_SALT_micro4,
business_header,salt22,Business_DOT,BIPV2_Files;
export Layouts :=
module

	export linking := Business_Header.Layout_Business_Linking;
export CombinationRecord := RECORD
SALT22.UIDType DOTid1;
SALT22.UIDType DOTid2;
unsigned2 Basis_score; // Score allocated to the basis relationship
unsigned2 Dedup_Val; // Hash will be stored in here to dedup
unsigned2 Cnt; // Number of different matching basis
END;

export laydotbase :=
record
   unsigned6            rcid                                                                        ;
   unsigned6            dotid                                                                       ;
   unsigned6            empid                                                                       ;
   unsigned6            powid                                                                       ;
   unsigned6            proxid                                                                      ;
   unsigned6            orgid                                                                       ;
   unsigned6            ultid                                                                       ;
   string1              iscontact                                                                   ;
   string5              title                                                                       ;
   string20             fname                                                                       ;
   string20             mname                                                                       ;
   string20             lname                                                                       ;
   string5              name_suffix                                                                 ;
   string3              name_score                                                                  ;
   string1              iscorp                                                                      ;
   string120            company_name                                                                ;
   string50             company_name_type_raw                                                       ;
   string50             company_name_type_derived                                                   ;
   string1              cnp_hasnumber                                                               ;
   string250            cnp_name                                                                    ;
   string10             cnp_number                                                                  ;
   string10             cnp_btype                                                                   ;
   string20             cnp_lowv                                                                    ;
   boolean              cnp_translated                                                              ;
   integer4             cnp_classid                                                                 ;
   unsigned8            company_rawaid                                                              ;
   unsigned8            company_aceaid                                                              ;
   string10             prim_range                                                                  ;
   string2              predir                                                                      ;
   string28             prim_name                                                                   ;
   string4              addr_suffix                                                                 ;
   string2              postdir                                                                     ;
   string10             unit_desig                                                                  ;
   string8              sec_range                                                                   ;
   string25             p_city_name                                                                 ;
   string25             v_city_name                                                                 ;
   string2              st                                                                          ;
   string5              zip                                                                         ;
   string4              zip4                                                                        ;
   string4              cart                                                                        ;
   string1              cr_sort_sz                                                                  ;
   string4              lot                                                                         ;
   string1              lot_order                                                                   ;
   string2              dbpc                                                                        ;
   string1              chk_digit                                                                   ;
   string2              rec_type                                                                    ;
   string2              fips_state                                                                  ;
   string3              fips_county                                                                 ;
   string10             geo_lat                                                                     ;
   string11             geo_long                                                                    ;
   string4              msa                                                                         ;
   string7              geo_blk                                                                     ;
   string1              geo_match                                                                   ;
   string4              err_stat                                                                    ;
   string250            corp_legal_name                                                             ;
   string250            dba_name                                                                    ;
   string9              active_duns_number                                                          ;
   string9              hist_duns_number                                                            ;
   string9              active_enterprise_number                                                    ;
   string9              hist_enterprise_number                                                      ;
   string9              ebr_file_number                                                             ;
   string30             active_domestic_corp_key                                                    ;
   string30             hist_domestic_corp_key                                                      ;
   string30             foreign_corp_key                                                            ;
   string30             unk_corp_key                                                                ;
   string2              source                                                                      ;
   unsigned4            dt_first_seen                                                               ;
   unsigned4            dt_last_seen                                                                ;
   unsigned4            dt_vendor_first_reported                                                    ;
   unsigned4            dt_vendor_last_reported                                                     ;
   unsigned6            company_bdid                                                                ;
   string50             company_address_type_raw                                                    ;
   string9              company_fein                                                                ;
   string1              best_fein_indicator                                                         ;
   string10             company_phone                                                               ;
   string1              phone_type                                                                  ;
   string60             company_org_structure_raw                                                   ;
   unsigned4            company_incorporation_date                                                  ;
   string8              company_sic_code1                                                           ;
   string8              company_sic_code2                                                           ;
   string8              company_sic_code3                                                           ;
   string8              company_sic_code4                                                           ;
   string8              company_sic_code5                                                           ;
   string6              company_naics_code1                                                         ;
   string6              company_naics_code2                                                         ;
   string6              company_naics_code3                                                         ;
   string6              company_naics_code4                                                         ;
   string6              company_naics_code5                                                         ;
   string6              company_ticker                                                              ;
   string6              company_ticker_exchange                                                     ;
   string1              company_foreign_domestic                                                    ;
   string80             company_url                                                                 ;
   string2              company_inc_state                                                           ;
   string32             company_charter_number                                                      ;
   unsigned4            company_filing_date                                                         ;
   unsigned4            company_status_date                                                         ;
   unsigned4            company_foreign_date                                                        ;
   unsigned4            event_filing_date                                                           ;
   string50             company_name_status_raw                                                     ;
   string50             company_status_raw                                                          ;
   unsigned4            dt_first_seen_company_name                                                  ;
   unsigned4            dt_last_seen_company_name                                                   ;
   unsigned4            dt_first_seen_company_address                                               ;
   unsigned4            dt_last_seen_company_address                                                ;
   string34             vl_id                                                                       ;
   boolean              current                                                                     ;
   unsigned8            source_record_id                                                            ;
   unsigned2            phone_score                                                                 ;
   unsigned4            dt_first_seen_contact                                                       ;
   unsigned4            dt_last_seen_contact                                                        ;
   unsigned6            contact_did                                                                 ;
   string50             contact_type_raw                                                            ;
   string50             contact_job_title_raw                                                       ;
   string9              contact_ssn                                                                 ;
   unsigned4            contact_dob                                                                 ;
   string30             contact_status_raw                                                          ;
   string60             contact_email                                                               ;
   string30             contact_email_username                                                      ;
   string30             contact_email_domain                                                        ;
   string10             contact_phone                                                               ;
   string1              from_hdr                                                                    ;
   string35             company_department                                                          ;
   string50             company_address_type_derived                                                ;
   string60             company_org_structure_derived                                               ;
   string50             company_name_status_derived                                                 ;
   string50             company_status_derived                                                      ;
   string50             contact_type_derived                                                        ;
   string50             contact_job_title_derived                                                   ;
   string30             contact_status_derived                                                      ;
end;

export corpkey_fields := 
record
     string30            domestic_corp_key                                                      ;
     string30            AK_foreign_corp_key                                                    ;
     string30            AL_foreign_corp_key                                                    ;
     string30            AR_foreign_corp_key                                                    ;
     string30            AZ_foreign_corp_key                                                    ;
     string30            CA_foreign_corp_key                                                    ;
     string30            CO_foreign_corp_key                                                    ;
     string30            CT_foreign_corp_key                                                    ;
     string30            DC_foreign_corp_key                                                    ;
     string30            DE_foreign_corp_key                                                    ;
     string30            FL_foreign_corp_key                                                    ;
     string30            GA_foreign_corp_key                                                    ;
     string30            HI_foreign_corp_key                                                    ;
     string30            IA_foreign_corp_key                                                    ;
     string30            ID_foreign_corp_key                                                    ;
     string30            IL_foreign_corp_key                                                    ;
     string30            IN_foreign_corp_key                                                    ;
     string30            KS_foreign_corp_key                                                    ;
     string30            KY_foreign_corp_key                                                    ;
     string30            LA_foreign_corp_key                                                    ;
     string30            MA_foreign_corp_key                                                    ;
     string30            MD_foreign_corp_key                                                    ;
     string30            ME_foreign_corp_key                                                    ;
     string30            MI_foreign_corp_key                                                    ;
     string30            MN_foreign_corp_key                                                    ;
     string30            MO_foreign_corp_key                                                    ;
     string30            MS_foreign_corp_key                                                    ;
     string30            MT_foreign_corp_key                                                    ;
     string30            NC_foreign_corp_key                                                    ;
     string30            ND_foreign_corp_key                                                    ;
     string30            NE_foreign_corp_key                                                    ;
     string30            NH_foreign_corp_key                                                    ;
     string30            NJ_foreign_corp_key                                                    ;
     string30            NM_foreign_corp_key                                                    ;
     string30            NV_foreign_corp_key                                                    ;
     string30            NY_foreign_corp_key                                                    ;
     string30            OH_foreign_corp_key                                                    ;
     string30            OK_foreign_corp_key                                                    ;
     string30            OR_foreign_corp_key                                                    ;
     string30            PA_foreign_corp_key                                                    ;
     string30            PR_foreign_corp_key                                                    ;
     string30            RI_foreign_corp_key                                                    ;
     string30            SC_foreign_corp_key                                                    ;
     string30            SD_foreign_corp_key                                                    ;
     string30            TN_foreign_corp_key                                                    ;
     string30            TX_foreign_corp_key                                                    ;
     string30            UT_foreign_corp_key                                                    ;
     string30            VA_foreign_corp_key                                                    ;
     string30            VI_foreign_corp_key                                                    ;
     string30            VT_foreign_corp_key                                                    ;
     string30            WA_foreign_corp_key                                                    ;
     string30            WI_foreign_corp_key                                                    ;
     string30            WV_foreign_corp_key                                                    ;
     string30            WY_foreign_corp_key                                                    ;
end;

//	export orig_DOT_Base := Business_DOT.Files.l_dot;
	export orig_DOT_Base := BIPV2_Files.layout_dotid;
  
	export DOT_Base := 
  record
    orig_DOT_Base;
    corpkey_fields;
  end;

//	export attfile_duns_entum := {dot_base.proxid,dot_base.duns_number,dot_base.enterprise_number};
	export attfile_contact 		:= {dot_base.proxid,string73 contact};

end;