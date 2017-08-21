 import liensV2 ;

liensV2.Layout_Liens_temp_Base main_mapping_format(LiensV2.Layout_liens_ilfdln L) := transform

self.tmsid                           :=  L.tmsid   ;
self.rmsid                           :=  L.rmsid   ;
self.process_date                    :=  L.process_date  ;
self.record_code                     :=  '';
self.date_vendor_removed             :=  '';
self.filing_jurisdiction             :=  'IL';
self.filing_state                    :=  L.STATE_ORIGIN;
self.orig_filing_number              :=  L.LIEN_DOC;
self.orig_filing_type                :=  L.TYPE;
self.orig_filing_date                :=  L.FILING_DATE ;
self.orig_filing_time                :=  '';
self.filing_status                   :=  '';
self.filing_status_desc              :=  L.STATUS;
self.case_number                     :=  '';
self.filing_number                   :=  L.RELEASE_DOC;
self.filing_type_desc                := '' ;
self.filing_date                     := '' ;
self.filing_time                     := '' ;
self.vendor_entry_date               := '' ;
self.judge                           := '' ;
self.case_title                      := '' ;
self.filing_book                     := '' ;
self.filing_page                     := '' ;
self.release_date                    := L.RELEASE_DATE ;
self.amount                          := L.AMOUNT ;
self.eviction                        := '' ;
self.judg_satisfied_date             := '' ;
self.judg_vacated_date               := '' ;
self.tax_code                        := '' ;
self.irs_serial_number               := '' ;
self.effective_date                  := '' ;
self.lapse_date                      := '' ;
self.orig_full_debtorname            := L.orig_DEBTOR ;
self.debtor_name                     := L.DEBTOR ; 
self.debtor_lname                    := '' ;
self.debtor_fname                    := '' ;
self.debtor_mname                    := '' ;
self.debtor_suffix                   := '' ;
self.debtor_tax_id                   := L.DEBTOR_FEIN ;
self.debtor_ssn                      := L.SSN ;
self.debtor_address1                 := L.ADDRESS ;
self.debtor_address2                 := '';
self.debtor_city                     := L.CITY ;
self.debtor_state                    := L.STATE ;
self.debtor_zip5                     := L.ZIP;
self.debtor_zip4                     := '' ;
self.debtor_country                  := '' ;
self.creditor_name                   := L.SECURED_PARTY ;
//self.Creditor_addressess           := '' ;
self.creditor_address1               := '';
self.creditor_address2               := '';
self.creditor_city                   := '';
self.creditor_state                  := '' ;
self.creditor_zip5                   := '' ;
self.creditor_zip4                   := '' ;
self.creditor_country                := '' ;
self.atty_Name                       := '' ;
self.atty_address1                    := '' ;
self.atty_address2                    := '' ;
self.atty_city                       := '' ;
self.atty_state                      := '' ;
self.atty_zip5                        := '' ;
self.atty_zip4                        := '' ;
self.atty_phone                      := '' ;
//Filing Office
self.agency                          := '' ;
self.agency_city                     := '' ;
self.agency_state                    := 'IL' ;
self.agency_county                   := L.COUNTY ;

//Cleaned fields


//self.clean_debtor_pname              := L.clean_debtor_pname  


self.clean_debtor_title					:=      L.clean_debtor_pname[1..5]			    ;
self.clean_debtor_fname					:=      L.clean_debtor_pname[6..25]			    ;
self.clean_debtor_mname					:=      L.clean_debtor_pname[26..45]			;
self.clean_debtor_lname					:=      L.clean_debtor_pname[46..65]			;
self.clean_debtor_name_suffix	   		:=      L.clean_debtor_pname[66..70]			;
self.clean_debtor_score				    :=      L.clean_debtor_pname[71..73]            ;

//self.clean_debtor_address             :=      L.clean_debtor_addressess                   		
self.clean_debtor_prim_range 		    := 		L.clean_debtor_address[1..10]				;
self.clean_debtor_predir     		    :=		L.clean_debtor_address[11..12]				;
self.clean_debtor_prim_name			    := 		L.clean_debtor_address[13..40]				;
self.clean_debtor_addr_suffix		    := 		L.clean_debtor_address[41..44]				;
self.clean_debtor_postdir				:=		L.clean_debtor_address[45..46]				;
self.clean_debtor_unit_desig			:= 		L.clean_debtor_address[47..56]				;
self.clean_debtor_sec_range				:= 		L.clean_debtor_address[57..64]				;
self.clean_debtor_p_city_name			:= 		L.clean_debtor_address[65..89]				;
self.clean_debtor_v_city_name			:= 		L.clean_debtor_address[90..114]			    ;
self.clean_debtor_st					:= 		L.clean_debtor_address[115..116]			;
self.clean_debtor_zip					:=		L.clean_debtor_address[117..121]			;
self.clean_debtor_zip4					:=		L.clean_debtor_address[122..125]			;
self.clean_debtor_cart					:=		L.clean_debtor_address[126..129]			;
self.clean_debtor_cr_sort_sz			:=		L.clean_debtor_address[130]				    ;
self.clean_debtor_lot					:=		L.clean_debtor_address[131..134]			;
self.clean_debtor_lot_order				:=		L.clean_debtor_address[135]				    ;
self.clean_debtor_dpbc					:=		L.clean_debtor_address[136..137]			;
self.clean_debtor_chk_digit				:=		L.clean_debtor_address[138]				    ;
self.clean_debtor_record_type			:=		L.clean_debtor_address[139..140]			;
self.clean_debtor_ace_fips_st			:=		L.clean_debtor_address[141..142]			;
self.clean_debtor_fipscounty			:=		L.clean_debtor_address[143..145]			;
self.clean_debtor_geo_lat				:=		L.clean_debtor_address[146..155]			;
self.clean_debtor_geo_long				:=		L.clean_debtor_address[156..166]			;
self.clean_debtor_msa					:=		L.clean_debtor_address[167..170]			;
self.clean_debtor_geo_match				:=		L.clean_debtor_address[178]				    ;
self.clean_debtor_err_stat				:=		L.clean_debtor_address[179..182]		    ;

self.clean_debtor_cname                 :=      L.clean_debtor_cname                        ;

end;

export Mapping_ILFDLN := project(liensV2.file_ILFDLN_in, main_mapping_format(left)) ;


