IMPORT ut, PromoteSupers, mdr, prte2, bipv2, prte_bip,std, address, aid;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

    //Uppercase, CleanSpaces, AND remove unprintable characters
    PRTE2.CleanFields(files.incoming_boca,dsForeclosureBoca);

    //add sequence number
    LayoutForeclosureSeq := RECORD
      UNSIGNED8 sequence := 0;
      Layouts.base;
      //fields needed for address cleaning prep
      STRING150	Append_Prep_Address1_Situs1;
      STRING150	Append_Prep_Address1_Situs2;
    END;

    ds_init := PROJECT(dsForeclosureBoca, 
                       TRANSFORM(LayoutForeclosureSeq, 
                                 SELF := LEFT, 
                                 SELF := []
                                 )
                       ); 

    ut.MAC_Sequence_Records(ds_init, sequence, ds_sequenced);

    //Boca file
    RECORDOF(ds_sequenced)	tPrepFile(RECORDOF(ds_sequenced)	 pInput) := TRANSFORM
      SELF.BOCA_ALPHA_IND 							:= 'B';
      SELF.property_address_zip_code_1 	:= IF(LENGTH(TRIM(pInput.property_address_zip_code_1))<5, 
                                                INTFORMAT((INTEGER)pInput.property_address_zip_code_1,5,1),																																																				
                                                pInput.property_address_zip_code_1);

      SELF.property_address_zip_code_2 	:= IF(LENGTH(TRIM(pInput.property_address_zip_code_2))<5, 
                                                INTFORMAT((INTEGER)pInput.property_address_zip_code_2,5,1), 
                                                pInput.property_address_zip_code_2);

    //Populate Foreclosure ID when blank																												
      SELF.foreclosure_id								:=	IF(pInput.foreclosure_id <> '', pInput.foreclosure_id,
                                                IF(pInput.parcel_number_unmatched_id <> '',
                                                  IF(TRIM(pInput.first_defendant_borrower_owner_last_name,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_first_name,LEFT,RIGHT) <> '',
                                                      StringLib.StringFindReplace(TRIM(pInput.parcel_number_unmatched_id,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_last_name,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_first_name,LEFT,RIGHT), ' ', ''),
                                                      StringLib.StringFindReplace(TRIM(pInput.parcel_number_unmatched_id,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_company_name,LEFT,RIGHT), ' ', '')
                                                   ),
                                                IF(TRIM(pInput.first_defendant_borrower_owner_last_name,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_first_name,LEFT,RIGHT) <> '',
                                                      StringLib.StringFindReplace('FC' + INTFORMAT(pInput.sequence, 8, 1) + TRIM(pInput.first_defendant_borrower_owner_last_name,LEFT,RIGHT) + TRIM(pInput.first_defendant_borrower_owner_first_name,LEFT,RIGHT), ' ', ''),
                                                      StringLib.StringFindReplace('FC' + INTFORMAT(pInput.sequence, 8, 1) + TRIM(pInput.first_defendant_borrower_company_name,LEFT,RIGHT), ' ', '')																
                                                    )
                                                        ));

                                                        
        SELF.Append_Prep_Address1_Situs1 := address.fn_addr_clean_prep(std.str.cleanspaces(pInput.situs_house_number_1 + ' '+ pInput.situs_direction_1 +' '+
                                                                                          pInput.situs_street_name_1 + ' '+ pInput.situs_mode_1 + ' '+
                                                                                          pInput.apartment_unit),'first');
                                                                                          
        SELF.Append_Prep_Address1_Situs2 := address.fn_addr_clean_prep(std.str.cleanspaces(pInput.situs_house_number_2 + ' '+ pInput.situs_direction_2 +' '+
                                                                                          pInput.situs_street_name_2 + ' '+ pInput.situs_mode_2 + ' '+
                                                                                          pInput.apartment_unit_2),'first');
                                                        
      SELF := pInput; 
      SELF := [];
    END;
    rsForeclosureFormattedID :=  PROJECT(ds_sequenced, tPrepFile(LEFT)); 


    //Splitting New & Existing Records
    dsNewRecords := rsForeclosureFormattedID(cust_name <> '');
    dsExistingRecords := rsForeclosureFormattedID(cust_name = '');

 
    //Address Cleaning
    dNewRecordsAddrClean := PRTE2.AddressCleaner(dsNewRecords,   
                                              ['Append_Prep_Address1_Situs1', 'Append_Prep_Address1_Situs2'],                                              
                                              ['dummy1', 'dummy2'], //these are fake fields.  The address cleaner will use the fields below to create the prepped city_state_zip line
                                              ['property_city_1', 'property_city_2'], 
                                              ['property_state_1', 'property_state_2'],                                              
                                              ['property_address_zip_code_1', 'property_address_zip_code_2'],
                                              ['situs1', 'situs2'],
                                              ['situs1Rawaid', 'situs2Rawaid']);
                                              
                          
	    //Clean name/business
    RECORDOF(ds_sequenced) 	CleanNewRecords(dNewRecordsAddrClean L) := 
    TRANSFORM																	
        //Addresses
        SELF.situs1_RawAID				    :=	L.situs1Rawaid;
        SELF.situs1_prim_range		  :=	L.situs1.prim_range;
        SELF.situs1_predir	       :=	L.situs1.predir;
        SELF.situs1_prim_name			  :=	L.situs1.prim_name;
        SELF.situs1_addr_suffix	  :=	L.situs1.addr_suffix;
        SELF.situs1_postdir			    :=	L.situs1.postdir;
        SELF.situs1_unit_desig		  :=	L.situs1.unit_desig;		
        SELF.situs1_sec_range			  := L.situs1.sec_range;
        SELF.situs1_p_city_name	  :=	L.situs1.p_city_name;
        SELF.situs1_v_city_name   :=	L.situs1.v_city_name;
        SELF.situs1_st						      :=	L.situs1.st;
        SELF.situs1_zip           :=	L.situs1.zip;
        SELF.situs1_zip4          :=	L.situs1.zip4;
        SELF.situs1_cart          :=	L.situs1.cart;
        SELF.situs1_cr_SORT_sz    :=	L.situs1.cr_SORT_sz;
        SELF.situs1_lot           :=	L.situs1.lot;
        SELF.situs1_lot_order     :=	L.situs1.lot_order;
        SELF.situs1_dpbc          :=	L.situs1.dbpc;
        SELF.situs1_chk_digit     :=	L.situs1.chk_digit;
        SELF.situs1_record_type   :=	L.situs1.rec_type;
        SELF.situs1_ace_fips_st   :=	L.situs1.fips_state;
        SELF.situs1_fipscounty    :=	L.situs1.fips_county;
        SELF.situs1_geo_lat       :=	L.situs1.geo_lat;
        SELF.situs1_geo_long      :=	L.situs1.geo_long;
        SELF.situs1_msa           :=	L.situs1.msa;
        SELF.situs1_geo_blk       :=	L.situs1.geo_blk;
        SELF.situs1_geo_match     :=	L.situs1.geo_match;
        SELF.situs1_err_stat      :=	L.situs1.err_stat;
          
        SELF.situs2_RawAID        :=	L.situs2Rawaid;
        SELF.situs2_prim_range    :=	L.situs2.prim_range;
        SELF.situs2_predir        :=	L.situs2.predir;
        SELF.situs2_prim_name     :=	L.situs2.prim_name;
        SELF.situs2_addr_suffix   :=	L.situs2.addr_suffix;
        SELF.situs2_postdir       :=	L.situs2.postdir;
        SELF.situs2_unit_desig    :=	L.situs2.unit_desig;
        SELF.situs2_sec_range     :=	L.situs2.sec_range;
        SELF.situs2_p_city_name   :=	L.situs2.p_city_name;
        SELF.situs2_v_city_name   :=	L.situs2.v_city_name;
        SELF.situs2_st            :=	L.situs2.st;
        SELF.situs2_zip           :=	L.situs2.zip;
        SELF.situs2_zip4          :=	L.situs2.zip4;
        SELF.situs2_cart          :=	L.situs2.cart;
        SELF.situs2_cr_SORT_sz    :=	L.situs2.cr_SORT_sz;
        SELF.situs2_lot           :=	L.situs2.lot;
        SELF.situs2_lot_order     :=	L.situs2.lot_order;
        SELF.situs2_dpbc          :=	L.situs2.dbpc;
        SELF.situs2_chk_digit     :=	L.situs2.chk_digit;
        SELF.situs2_record_type   :=	L.situs2.rec_type;
        SELF.situs2_ace_fips_st   :=	L.situs2.fips_state;
        SELF.situs2_fipscounty    :=	L.situs2.fips_county;
        SELF.situs2_geo_lat       :=	L.situs2.geo_lat;
        SELF.situs2_geo_long      :=	L.situs2.geo_long;
        SELF.situs2_msa           :=	L.situs2.msa;
        SELF.situs2_geo_blk       :=	L.situs2.geo_blk;
        SELF.situs2_geo_match     :=	L.situs2.geo_match;
        SELF.situs2_err_stat      :=	L.situs2.err_stat;
    
       //Clean Name
        v_clean_name1					:= Address.CleanPersonFML73_fields(TRIM(L.first_defendant_borrower_owner_first_name) + ' ' + TRIM(L.first_defendant_borrower_owner_last_name)); 
        v_clean_name2					:= Address.CleanPersonFML73_fields(TRIM(L.second_defendant_borrower_owner_first_name) +	' ' + TRIM(L.second_defendant_borrower_owner_last_name)); 
        v_clean_name3					:= Address.CleanPersonFML73_fields(TRIM(L.third_defendant_borrower_owner_first_name) + ' ' + TRIM(L.third_defendant_borrower_owner_last_name)); 
        v_clean_name4					:= Address.CleanPersonFML73_fields(TRIM(L.fourth_defendant_borrower_owner_first_name) + ' ' + TRIM(L.fourth_defendant_borrower_owner_last_name)); 

							//Plaintiff Names
				    v_clean_name5					:= Address.CleanPersonFML73_fields(TRIM(L.plaintiff_1)); 
							 v_clean_name7					:= Address.CleanPersonFML73_fields(TRIM(L.plaintiff_2)); 
				    v_plaintiff_1					:= if(L.name5_link_fein <> '' and L.name5_link_inc_date <> '',L.plaintiff_1,'');
						  v_plaintiff_2 		  := if(L.name7_link_fein <> '' and L.name7_link_inc_date <> '',L.plaintiff_2,'');
							
							
        SELF.name1_prefix	  :=	v_clean_name1.title;
        SELF.name1_first		  :=	v_clean_name1.fname;	
        SELF.name1_middle	  :=	v_clean_name1.mname;
        SELF.name1_last     :=	v_clean_name1.lname;
        SELF.name1_suffix   :=	v_clean_name1.name_suffix;
        SELF.name1_score    :=	v_clean_name1.name_score;
        SELF.name1_company  :=	L.first_defendant_borrower_company_name;

        SELF.name2_prefix   :=	v_clean_name2.title;
        SELF.name2_first		  :=	v_clean_name2.fname;	
        SELF.name2_middle   :=	v_clean_name2.mname;
        SELF.name2_last	    :=	v_clean_name2.lname;
        SELF.name2_suffix   :=	v_clean_name2.name_suffix;
        SELF.name2_score    :=	v_clean_name2.name_score;
        SELF.name2_company  :=	L.second_defendant_borrower_company_name;

        SELF.name3_prefix   :=	v_clean_name3.title;
        SELF.name3_first    :=	v_clean_name3.fname;
        SELF.name3_middle   :=	v_clean_name3.mname;
        SELF.name3_last	    :=	v_clean_name3.lname;
        SELF.name3_suffix   :=	v_clean_name3.name_suffix;
        SELF.name3_score    :=	v_clean_name3.name_score;
        SELF.name3_company  :=	L.third_defendant_borrower_company_name;
        
        SELF.name4_prefix   :=	v_clean_name4.title;
        SELF.name4_first    :=	v_clean_name4.fname;
        SELF.name4_middle   :=	v_clean_name4.mname;
        SELF.name4_last	    :=	v_clean_name4.lname;
        SELF.name4_suffix   :=	v_clean_name4.name_suffix;
        SELF.name4_score    :=	v_clean_name4.name_score;
        SELF.name4_company  :=	L.fourth_defendant_borrower_company_name;
				
							 SELF.name5_prefix   :=	if(L.name5_link_dob <> '' and L.name5_link_ssn <> '',v_clean_name5.title,'');
        SELF.name5_first    := if(L.name5_link_dob <> '' and L.name5_link_ssn <> '',v_clean_name5.fname,'');
        SELF.name5_middle   :=	if(L.name5_link_dob <> '' and L.name5_link_ssn <> '',v_clean_name5.mname,'');
        SELF.name5_last	    :=	if(L.name5_link_dob <> '' and L.name5_link_ssn <> '',v_clean_name5.lname,'');
        SELF.name5_suffix   :=	if(L.name5_link_dob <> '' and L.name5_link_ssn <> '',v_clean_name5.name_suffix,'');
        SELF.name5_score    :=	if(L.name5_link_dob <> '' and L.name5_link_ssn <> '',v_clean_name5.name_score,'');
        SELF.name5_company  :=	v_plaintiff_1;
				
								SELF.name6_prefix   :=	'';
        SELF.name6_first    :=	'';
        SELF.name6_middle   :=	'';
        SELF.name6_last	    :=	'';
        SELF.name6_suffix   :=	'';
        SELF.name6_score    :=	'';
        SELF.name6_company  :=	'';
				
				  
				    SELF.name7_prefix   :=	if(L.name7_link_dob <> '' and L.name7_link_ssn <> '',v_clean_name7.title,'');
        SELF.name7_first    :=	if(L.name7_link_dob <> '' and L.name7_link_ssn <> '',v_clean_name7.fname,'');
        SELF.name7_middle   :=	if(L.name7_link_dob <> '' and L.name7_link_ssn <> '',v_clean_name7.mname,'');
        SELF.name7_last	    :=	if(L.name7_link_dob <> '' and L.name7_link_ssn <> '',v_clean_name7.lname,'');
        SELF.name7_suffix   :=	if(L.name7_link_dob <> '' and L.name7_link_ssn <> '',v_clean_name7.name_suffix,'');
        SELF.name7_score    :=	if(L.name7_link_dob <> '' and L.name7_link_ssn <> '',v_clean_name7.name_score,'');
        SELF.name7_company  :=	v_plaintiff_2;

        //Append ID(s)
        SELF.name1_did			:= (string) prte2.fn_AppendFakeID.did(v_clean_name1.fname, v_clean_name1.lname, L.name1_link_ssn, L.name1_dob, L.cust_name);
        SELF.name1_bdid  := (string) prte2.fn_AppendFakeID.bdid(L.first_defendant_borrower_company_name, L.situs1.prim_range, L.situs1.prim_name,L.situs1.v_city_name, L.situs1.st, L.situs1.zip, L.cust_name);

        SELF.name2_did			:= (string) prte2.fn_AppendFakeID.did(v_clean_name2.fname, v_clean_name2.lname, L.name2_link_ssn, L.name2_dob, L.cust_name);
        SELF.name2_bdid  := (string) prte2.fn_AppendFakeID.bdid(L.second_defendant_borrower_company_name, L.situs1.prim_range, L.situs1.prim_name,L.situs1.v_city_name, L.situs1.st, L.situs1.zip, L.cust_name);
        
        SELF.name3_did			:= (string) prte2.fn_AppendFakeID.did(v_clean_name3.fname, v_clean_name3.lname, L.name1_link_ssn, L.name3_dob, L.cust_name);
        SELF.name3_bdid  := (string) prte2.fn_AppendFakeID.bdid(L.third_defendant_borrower_company_name, L.situs1.prim_range, L.situs1.prim_name,L.situs1.v_city_name, L.situs1.st, L.situs1.zip, L.cust_name);

        SELF.name4_did			:= (string) prte2.fn_AppendFakeID.did(v_clean_name4.fname, v_clean_name4.lname, L.name4_link_ssn, L.name4_dob, L.cust_name);
        SELF.name4_bdid  := (string) prte2.fn_AppendFakeID.bdid(L.fourth_defendant_borrower_company_name, L.situs1.prim_range, L.situs1.prim_name,L.situs1.v_city_name, L.situs1.st, L.situs1.zip, L.cust_name);

								SELF.name5_did			:= (string) prte2.fn_AppendFakeID.did(v_clean_name5.fname, v_clean_name5.lname, L.name5_link_ssn, L.name5_link_dob, L.cust_name);
        SELF.name5_bdid  := (string) prte2.fn_AppendFakeID.bdid(v_plaintiff_1, L.situs1.prim_range, L.situs1.prim_name,L.situs1.v_city_name, L.situs1.st, L.situs1.zip, L.cust_name);
				
				    SELF.name7_did			:= (string) prte2.fn_AppendFakeID.did(v_clean_name7.fname, v_clean_name7.lname, L.name7_link_ssn, L.name7_link_dob, L.cust_name);
        SELF.name7_bdid  := (string) prte2.fn_AppendFakeID.bdid(v_plaintiff_2, L.situs1.prim_range, L.situs1.prim_name,L.situs1.v_city_name, L.situs1.st, L.situs1.zip, L.cust_name);
                   
        vLinkingIds_name1 := prte2.fn_AppendFakeID.LinkIds(L.first_defendant_borrower_company_name, L.name1_fein, L.name1_inc_date, L.situs1.prim_range, L.situs1.prim_name, L.situs1.sec_range, L.situs1.v_city_name, L.situs1.st, L.situs1.zip, L.cust_name);
        vLinkingIds_name2 := prte2.fn_AppendFakeID.LinkIds(L.second_defendant_borrower_company_name, L.name2_fein, L.name2_inc_date, L.situs1.prim_range, L.situs1.prim_name, L.situs1.sec_range, L.situs1.v_city_name, L.situs1.st, L.situs1.zip, L.cust_name);
        vLinkingIds_name3 := prte2.fn_AppendFakeID.LinkIds(L.third_defendant_borrower_company_name, L.name3_fein, L.name3_inc_date, L.situs1.prim_range, L.situs1.prim_name, L.situs1.sec_range, L.situs1.v_city_name, L.situs1.st, L.situs1.zip, L.cust_name);
        vLinkingIds_name4 := prte2.fn_AppendFakeID.LinkIds(L.fourth_defendant_borrower_company_name, L.name4_fein, L.name4_inc_date, L.situs1.prim_range, L.situs1.prim_name, L.situs1.sec_range, L.situs1.v_city_name, L.situs1.st, L.situs1.zip, L.cust_name);
          
								vLinkingIds_name5 := prte2.fn_AppendFakeID.LinkIds(v_plaintiff_1, L.name5_link_fein, L.name5_link_inc_date, L.situs1.prim_range, L.situs1.prim_name, L.situs1.sec_range, L.situs1.v_city_name, L.situs1.st, L.situs1.zip, L.cust_name);
								vLinkingIds_name7 := prte2.fn_AppendFakeID.LinkIds(v_plaintiff_2, L.name7_link_fein, L.name7_link_inc_date, L.situs1.prim_range, L.situs1.prim_name, L.situs1.sec_range, L.situs1.v_city_name, L.situs1.st, L.situs1.zip, L.cust_name);
        
								SELF.name1.proxid := vLinkingIds_name1.proxid;
        SELF.name1.seleid	:= vLinkingIds_name1.seleid;
       	SELF.name1.orgid	 := vLinkingIds_name1.orgid;
        SELF.name1.ultid  := vLinkingIds_name1.ultid;

        SELF.name2.proxid	:= vLinkingIds_name2.proxid;
        SELF.name2.seleid	:= vLinkingIds_name2.seleid;
        SELF.name2.orgid  := vLinkingIds_name2.orgid;
        SELF.name2.ultid  := vLinkingIds_name2.ultid;

        SELF.name3.proxid	:= vLinkingIds_name3.proxid;
        SELF.name3.seleid	:= vLinkingIds_name3.seleid;
        SELF.name3.orgid  := vLinkingIds_name3.orgid;
        SELF.name3.ultid  := vLinkingIds_name3.ultid;

        SELF.name4.proxid	:= vLinkingIds_name4.proxid;
        SELF.name4.seleid	:= vLinkingIds_name4.seleid;
        SELF.name4.orgid  := vLinkingIds_name4.orgid;
        SELF.name4.ultid  := vLinkingIds_name4.ultid;  
				
								SELF.name5.proxid	:= vLinkingIds_name5.proxid;
        SELF.name5.seleid	:= vLinkingIds_name5.seleid;
        SELF.name5.orgid  := vLinkingIds_name5.orgid;
        SELF.name5.ultid  := vLinkingIds_name5.ultid;    
				
				    SELF.name7.proxid	:= vLinkingIds_name7.proxid;
        SELF.name7.seleid	:= vLinkingIds_name7.seleid;
        SELF.name7.orgid  := vLinkingIds_name7.orgid;
        SELF.name7.ultid  := vLinkingIds_name7.ultid;   
        
        SELF := L;
        SELF := [];
    END;
    
    dNewRecordsClean := PROJECT(dNewRecordsAddrClean, CleanNewRecords(LEFT));
   
    dAllRecords := dsExistingRecords + dNewRecordsClean;

    Layouts.Normalized 	NormalizeRecords(dAllRecords l, UNSIGNED1 nameCounter) := TRANSFORM
      SELF.name_first       := CHOOSE(nameCounter,l.name1_first,l.name2_first,l.name3_first,l.name4_first,l.name5_first,l.name6_first,l.name7_first,l.name8_first);
      SELF.name_middle      := CHOOSE(nameCounter,l.name1_middle,l.name2_middle,l.name3_middle,l.name4_middle,l.name5_middle,l.name6_middle,l.name7_middle,l.name8_middle);
      SELF.name_last        := CHOOSE(nameCounter,l.name1_last,l.name2_last,l.name3_last,l.name4_last,l.name5_last,l.name6_last,l.name7_last,l.name8_last);
      SELF.name_suffix      := CHOOSE(nameCounter,l.name1_suffix,l.name2_suffix,l.name3_suffix,l.name4_suffix,l.name5_suffix,l.name6_suffix,l.name7_suffix,l.name8_suffix);
      SELF.name_Company     := CHOOSE(nameCounter,l.name1_company,l.name2_company,l.name3_company,l.name4_company,l.name5_company,l.name6_company,l.name7_company,l.name8_company);	
      SELF.ssn              := CHOOSE(nameCounter,l.name1_ssn,l.name2_ssn,l.name3_ssn,l.name4_ssn,l.name5_ssn,l.name6_ssn,l.name7_ssn,l.name8_ssn);	
      SELF.did              := CHOOSE(nameCounter,(INTEGER)l.name1_did,(INTEGER)l.name2_did,(INTEGER)l.name3_did,(INTEGER)l.name4_did,(INTEGER)l.name5_did,(INTEGER)l.name6_did,(INTEGER)l.name7_did,(INTEGER)l.name8_did);
      SELF.did_score        := CHOOSE(nameCounter,(INTEGER)l.name1_did_score,(INTEGER)l.name2_did_score,(INTEGER)l.name3_did_score,(INTEGER)l.name4_did_score,(INTEGER)l.name5_did_score,(INTEGER)l.name6_did_score,(INTEGER)l.name7_did_score,(INTEGER)l.name8_did_score);
      SELF.bdid             := CHOOSE(nameCounter,(INTEGER)l.name1_bdid,(INTEGER)l.name2_bdid,(INTEGER)l.name3_bdid,(INTEGER)l.name4_bdid,(INTEGER)l.name5_bdid,(INTEGER)l.name6_bdid,(INTEGER)l.name7_bdid,(INTEGER)l.name8_bdid);
      SELF.bdid_score       := CHOOSE(nameCounter,(INTEGER)l.name1_bdid_score,(INTEGER)l.name2_bdid_score,(INTEGER)l.name3_bdid_score,(INTEGER)l.name4_bdid_score,(INTEGER)l.name5_bdid_score,(INTEGER)l.name6_bdid_score,(INTEGER)l.name7_bdid_score,(INTEGER)l.name8_bdid_score);
						SELF.ProxID										 := CHOOSE(nameCounter,l.name1.proxid,l.name2.proxid,l.name3.proxid,l.name4.proxid,l.name5.proxid,l.name6.proxid,l.name7.proxid,l.name8.proxid);
						SELF.SELEID											:= CHOOSE(nameCounter,l.name1.seleid,l.name2.seleid,l.name3.seleid,l.name4.seleid,l.name5.seleid,l.name6.seleid,l.name7.seleid,l.name8.seleid);
						SELF.OrgID												:= CHOOSE(nameCounter,l.name1.orgid,l.name2.orgid,l.name3.orgid,l.name4.orgid,l.name5.orgid,l.name6.orgid,l.name7.orgid,l.name8.orgid);
						SELF.UltID												:= CHOOSE(nameCounter,l.name1.ultid,l.name2.ultid,l.name3.ultid,l.name4.ultid,l.name5.ultid,l.name6.ultid,l.name7.ultid,l.name8.ultid);
      
						SELF.site_prim_range 	:=l.situs1_prim_range;
      SELF.site_predir      :=l.situs1_predir;
      SELF.site_prim_name   :=l.situs1_prim_name;
      SELF.site_addr_suffix	:=l.situs1_addr_suffix;
      SELF.site_postdir			  :=l.situs1_postdir;
      SELF.site_unit_desig  :=l.situs1_unit_desig;
      SELF.site_sec_range   :=l.situs1_sec_range;
      SELF.site_p_city_name	:=l.situs1_p_city_name;
      SELF.site_v_city_name	:=l.situs1_v_city_name;
      SELF.site_st          :=l.situs1_st;
      SELF.site_zip         :=l.situs1_zip;
      SELF.site_zip4				    :=l.situs1_zip4;
      SELF.name_indicator   := nameCounter;
      SELF.source           := IF(l.deed_category = 'N',MDR.sourceTools.src_Foreclosures_Delinquent,MDR.sourceTools.src_Foreclosures);
      SELF := l;
    END;
    ds_name_Normalized := NORMALIZE(dAllRecords,8,NormalizeRecords(LEFT,counter));


    // by address
    Layouts.Normalized 		NORMALIZE_Addr_Records(Layouts.Normalized l, UNSIGNED1 c) := TRANSFORM
      SELF.site_prim_range 	:= CHOOSE(c,l.site_prim_range,l.situs2_prim_range);
      SELF.site_predir 			  := CHOOSE(c,l.site_predir,l.situs2_predir);
      SELF.site_prim_name   := CHOOSE(c,l.site_prim_name,l.situs2_prim_name);
      SELF.site_addr_suffix	:= CHOOSE(c,l.site_addr_suffix,l.situs2_addr_suffix);
      SELF.site_postdir     := CHOOSE(c,l.site_postdir,l.situs2_postdir);
      SELF.site_unit_desig  := CHOOSE(c,l.site_unit_desig,l.situs2_unit_desig);
      SELF.site_sec_range   := CHOOSE(c,l.site_sec_range,l.situs2_sec_range);
      SELF.site_p_city_name	:= CHOOSE(c,l.site_p_city_name,l.situs2_p_city_name);
      SELF.site_v_city_name	:= CHOOSE(c,l.site_v_city_name,l.situs2_v_city_name);
      SELF.site_st					     := CHOOSE(c,l.site_st,l.situs2_st);
      SELF.site_zip	        := CHOOSE(c,l.site_zip,l.situs2_zip);
      SELF.site_zip4				    := CHOOSE(c,l.site_zip4,l.situs2_zip4);
      SELF := l;
    END;

    ds_Normalized := NORMALIZE(ds_name_Normalized(name_first != '' OR name_last != '' OR name_company != ''), IF((LEFT.situs2_prim_name='' AND (LEFT.situs2_zip='' or LEFT.situs2_zip='00000')),1,2),NORMALIZE_Addr_Records(LEFT,counter));

    //Populate Linkids field
    normalised_linkids 		:= DEDUP(SORT(DISTRIBUTE(ds_Normalized, HASH(foreclosure_id)),RECORD,LOCAL),RECORD,all);

    RECORDOF(ds_sequenced) 	DeNormalizeRecords(RECORDOF(ds_sequenced) l, Layouts.Normalized r) := TRANSFORM
      SELF.name1_did        := IF(r.name_indicator=1, INTFORMAT(r.did,12,0), l.name1_did);
      SELF.name1_did_score  := IF(r.name_indicator=1, (string)r.did_score, l.name1_did_score);
      SELF.name1_ssn        := IF(r.name_indicator=1, r.ssn, l.name1_ssn);
      SELF.name1_bdid       := IF(r.name_indicator=1, INTFORMAT(r.bdid,12,0), l.name1_bdid);
      SELF.name1_bdid_score := IF(r.name_indicator=1, (string)r.bdid_score, l.name1_bdid_score);
      SELF.name1.DotID      := IF(r.name_indicator=1, r.DotID, 		  0);
      SELF.name1.DotScore   := IF(r.name_indicator=1, r.DotScore,	  0);
      SELF.name1.DotWeight  := IF(r.name_indicator=1, r.DotWeight,  0);
      SELF.name1.EmpID      := IF(r.name_indicator=1, r.EmpID, 		  0);
      SELF.name1.EmpScore   := IF(r.name_indicator=1, r.EmpScore,   0);
      SELF.name1.EmpWeight  := IF(r.name_indicator=1, r.EmpWeight,  0);
      SELF.name1.POWID      := IF(r.name_indicator=1, r.POWID, 		  0);
      SELF.name1.POWScore   := IF(r.name_indicator=1, r.POWScore,   0);
      SELF.name1.POWWeight  := IF(r.name_indicator=1, r.POWWeight,  0);;
      SELF.name1.ProxID     := IF(r.name_indicator=1, r.ProxID, 	  0);
      SELF.name1.ProxScore  := IF(r.name_indicator=1, r.ProxScore,  0);
      SELF.name1.ProxWeight	:= IF(r.name_indicator=1, r.ProxWeight, 0);
      SELF.name1.SeleID     := IF(r.name_indicator=1, r.SeleID, 	  0);
      SELF.name1.SeleScore  := IF(r.name_indicator=1, r.SeleScore,  0);
      SELF.name1.SeleWeight	:= IF(r.name_indicator=1, r.SeleWeight, 0);	
      SELF.name1.OrgID      := IF(r.name_indicator=1, r.OrgID,			0);
      SELF.name1.OrgScore   := IF(r.name_indicator=1, r.OrgScore, 	0);
      SELF.name1.OrgWeight  := IF(r.name_indicator=1, r.OrgWeight,  0);
      SELF.name1.UltID      := IF(r.name_indicator=1, r.UltID, 		 	0);
      SELF.name1.UltScore   := IF(r.name_indicator=1, r.UltScore, 	0);
      SELF.name1.UltWeight  := IF(r.name_indicator=1, r.UltWeight,  0);


      SELF.name2_did        := IF(r.name_indicator=2, INTFORMAT(r.did,12,0), l.name2_did);
      SELF.name2_did_score 	:= IF(r.name_indicator=2, (string)r.did_score, l.name2_did_score);
      SELF.name2_ssn        := IF(r.name_indicator=2, r.ssn, l.name2_ssn);
      SELF.name2_bdid       := IF(r.name_indicator=2, INTFORMAT(r.bdid,12,0), l.name2_bdid);
      SELF.name2_bdid_score := IF(r.name_indicator=2, (string)r.bdid_score, l.name2_bdid_score);
      SELF.name2.DotID      := IF(r.name_indicator=2, r.DotID, 		  0);
      SELF.name2.DotScore   := IF(r.name_indicator=2, r.DotScore,	  0);
      SELF.name2.DotWeight  := IF(r.name_indicator=2, r.DotWeight,  0);
      SELF.name2.EmpID      := IF(r.name_indicator=2, r.EmpID, 		  0);
      SELF.name2.EmpScore   := IF(r.name_indicator=2, r.EmpScore,   0);
      SELF.name2.EmpWeight  := IF(r.name_indicator=2, r.EmpWeight,  0);
      SELF.name2.POWID      := IF(r.name_indicator=2, r.POWID, 		  0);
      SELF.name2.POWScore   := IF(r.name_indicator=2, r.POWScore,   0);
      SELF.name2.POWWeight  := IF(r.name_indicator=2, r.POWWeight,  0);
      SELF.name2.ProxID     := IF(r.name_indicator=2, r.ProxID, 	  0);
      SELF.name2.ProxScore  := IF(r.name_indicator=2, r.ProxScore,  0);
      SELF.name2.ProxWeight	:= IF(r.name_indicator=2, r.ProxWeight, 0);
      SELF.name2.SeleID     := IF(r.name_indicator=2, r.SeleID, 	  0);
      SELF.name2.SeleScore  := IF(r.name_indicator=2, r.SeleScore,  0);
      SELF.name2.SeleWeight	:= IF(r.name_indicator=2, r.SeleWeight, 0);		
      SELF.name2.OrgID      := IF(r.name_indicator=2, r.OrgID, 			0);
      SELF.name2.OrgScore	  := IF(r.name_indicator=2, r.OrgScore, 	0);
      SELF.name2.OrgWeight  := IF(r.name_indicator=2, r.OrgWeight,  0);
      SELF.name2.UltID      := IF(r.name_indicator=2, r.UltID, 		 	0);
      SELF.name2.UltScore   := IF(r.name_indicator=2, r.UltScore, 	0);
      SELF.name2.UltWeight  := IF(r.name_indicator=2, r.UltWeight,  0);
      
      SELF.name3_did        := IF(r.name_indicator=3, INTFORMAT(r.did,12,0), l.name3_did);
      SELF.name3_did_score 	:= IF(r.name_indicator=3, (string)r.did_score, l.name3_did_score);
      SELF.name3_ssn        := IF(r.name_indicator=3, r.ssn, l.name3_ssn);
      SELF.name3_bdid       := IF(r.name_indicator=3, INTFORMAT(r.bdid,12,0), l.name3_bdid);
      SELF.name3_bdid_score := IF(r.name_indicator=3, (string)r.bdid_score, l.name3_bdid_score);
      SELF.name3.DotID      := IF(r.name_indicator=3, r.DotID, 		  0);
      SELF.name3.DotScore   := IF(r.name_indicator=3, r.DotScore,	  0);
      SELF.name3.DotWeight  := IF(r.name_indicator=3, r.DotWeight,  0);
      SELF.name3.EmpID      := IF(r.name_indicator=3, r.EmpID,      0);
      SELF.name3.EmpScore   := IF(r.name_indicator=3, r.EmpScore,   0);
      SELF.name3.EmpWeight  := IF(r.name_indicator=3, r.EmpWeight,  0);
      SELF.name3.POWID      := IF(r.name_indicator=3, r.POWID, 		  0);
      SELF.name3.POWScore   := IF(r.name_indicator=3, r.POWScore,   0);
      SELF.name3.POWWeight  := IF(r.name_indicator=3, r.POWWeight,  0);
      SELF.name3.ProxID     := IF(r.name_indicator=3, r.ProxID, 	  0);
      SELF.name3.ProxScore  := IF(r.name_indicator=3, r.ProxScore,  0);
      SELF.name3.ProxWeight	:= IF(r.name_indicator=3, r.ProxWeight, 0);
      SELF.name3.SeleID     := IF(r.name_indicator=3, r.SeleID, 	  0);
      SELF.name3.SeleScore  := IF(r.name_indicator=3, r.SeleScore,  0);
      SELF.name3.SeleWeight	:= IF(r.name_indicator=3, r.SeleWeight, 0);		
      SELF.name3.OrgID      := IF(r.name_indicator=3, r.OrgID,			0);
      SELF.name3.OrgScore   := IF(r.name_indicator=3, r.OrgScore, 	0);
      SELF.name3.OrgWeight  := IF(r.name_indicator=3, r.OrgWeight,  0);
      SELF.name3.UltID      := IF(r.name_indicator=3, r.UltID, 		 	0);
      SELF.name3.UltScore	  := IF(r.name_indicator=3, r.UltScore, 	0);
      SELF.name3.UltWeight  := IF(r.name_indicator=3, r.UltWeight,  0);
      
      SELF.name4_did        := IF(r.name_indicator=4, INTFORMAT(r.did,12,0), l.name4_did);
      SELF.name4_did_score 	:= IF(r.name_indicator=4, (string)r.did_score, l.name4_did_score);
      SELF.name4_ssn        := IF(r.name_indicator=4, r.ssn, l.name4_ssn);
      SELF.name4_bdid       := IF(r.name_indicator=4, INTFORMAT(r.bdid,12,0), l.name4_bdid);
      SELF.name4_bdid_score := IF(r.name_indicator=4, (string)r.bdid_score, l.name4_bdid_score);
      SELF.name4.DotID      := IF(r.name_indicator=4, r.DotID, 		  0);
      SELF.name4.DotScore   := IF(r.name_indicator=4, r.DotScore,	  0);
      SELF.name4.DotWeight  := IF(r.name_indicator=4, r.DotWeight,  0);
      SELF.name4.EmpID      := IF(r.name_indicator=4, r.EmpID,      0);
      SELF.name4.EmpScore   := IF(r.name_indicator=4, r.EmpScore,   0);
      SELF.name4.EmpWeight  := IF(r.name_indicator=4, r.EmpWeight,  0);
      SELF.name4.POWID      := IF(r.name_indicator=4, r.POWID, 		  0);
      SELF.name4.POWScore   := IF(r.name_indicator=4, r.POWScore,   0);
      SELF.name4.POWWeight  := IF(r.name_indicator=4, r.POWWeight,  0);
      SELF.name4.ProxID     := IF(r.name_indicator=4, r.ProxID, 	  0);
      SELF.name4.ProxScore  := IF(r.name_indicator=4, r.ProxScore,  0);
      SELF.name4.ProxWeight	:= IF(r.name_indicator=4, r.ProxWeight, 0);
      SELF.name4.SeleID     := IF(r.name_indicator=4, r.SeleID, 	  0);
      SELF.name4.SeleScore  := IF(r.name_indicator=4, r.SeleScore,  0);
      SELF.name4.SeleWeight	:= IF(r.name_indicator=4, r.SeleWeight, 0);			
      SELF.name4.OrgID      := IF(r.name_indicator=4, r.OrgID,			0);
      SELF.name4.OrgScore   := IF(r.name_indicator=4, r.OrgScore, 	0);
      SELF.name4.OrgWeight  := IF(r.name_indicator=4, r.OrgWeight,  0);
      SELF.name4.UltID      := IF(r.name_indicator=4, r.UltID, 		 	0);
      SELF.name4.UltScore   := IF(r.name_indicator=4, r.UltScore, 	0);
      SELF.name4.UltWeight  := IF(r.name_indicator=4, r.UltWeight,  0);
      
      SELF.name5_did        := IF(r.name_indicator=5, INTFORMAT(r.did,12,0), l.name5_did);
      SELF.name5_did_score 	:= IF(r.name_indicator=5, (string)r.did_score, l.name5_did_score);
      SELF.name5_ssn        := IF(r.name_indicator=5, r.ssn, l.name5_ssn);
      SELF.name5_bdid       := IF(r.name_indicator=5, INTFORMAT(r.bdid,12,0), l.name5_bdid);
      SELF.name5_bdid_score := IF(r.name_indicator=5, (string)r.bdid_score, l.name5_bdid_score);
      SELF.name5.DotID      := IF(r.name_indicator=5, r.DotID, 		  0);
      SELF.name5.DotScore   := IF(r.name_indicator=5, r.DotScore,	  0);
      SELF.name5.DotWeight  := IF(r.name_indicator=5, r.DotWeight,  0);
      SELF.name5.EmpID      := IF(r.name_indicator=5, r.EmpID,      0);
      SELF.name5.EmpScore   := IF(r.name_indicator=5, r.EmpScore,   0);
      SELF.name5.EmpWeight  := IF(r.name_indicator=5, r.EmpWeight,  0);
      SELF.name5.POWID      := IF(r.name_indicator=5, r.POWID, 		  0);
      SELF.name5.POWScore   := IF(r.name_indicator=5, r.POWScore,   0);
      SELF.name5.POWWeight  := IF(r.name_indicator=5, r.POWWeight,  0);
      SELF.name5.ProxID     := IF(r.name_indicator=5, r.ProxID, 	  0);
      SELF.name5.ProxScore  := IF(r.name_indicator=5, r.ProxScore,  0);
      SELF.name5.ProxWeight	:= IF(r.name_indicator=5, r.ProxWeight, 0);
      SELF.name5.SeleID     := IF(r.name_indicator=5, r.SeleID, 	  0);
      SELF.name5.SeleScore  := IF(r.name_indicator=5, r.SeleScore,  0);
      SELF.name5.SeleWeight	:= IF(r.name_indicator=5, r.SeleWeight, 0);			
      SELF.name5.OrgID      := IF(r.name_indicator=5, r.OrgID,			0);
      SELF.name5.OrgScore   := IF(r.name_indicator=5, r.OrgScore, 	0);
      SELF.name5.OrgWeight  := IF(r.name_indicator=5, r.OrgWeight,  0);
      SELF.name5.UltID      := IF(r.name_indicator=5, r.UltID, 		 	0);
      SELF.name5.UltScore	  := IF(r.name_indicator=5, r.UltScore, 	0);
      SELF.name5.UltWeight  := IF(r.name_indicator=5, r.UltWeight,  0);	
      
      SELF.name6_did        := IF(r.name_indicator=6, INTFORMAT(r.did,12,0), l.name6_did);
      SELF.name6_did_score 	:= IF(r.name_indicator=6, (string)r.did_score, l.name6_did_score);
      SELF.name6_ssn        := IF(r.name_indicator=6, r.ssn, l.name6_ssn);
      SELF.name6_bdid       := IF(r.name_indicator=6, INTFORMAT(r.bdid,12,0), l.name6_bdid);
      SELF.name6_bdid_score := IF(r.name_indicator=6, (string)r.bdid_score, l.name6_bdid_score);
      SELF.name6.DotID      := IF(r.name_indicator=6, r.DotID, 		  0);
      SELF.name6.DotScore	  := IF(r.name_indicator=6, r.DotScore,	  0);
      SELF.name6.DotWeight  := IF(r.name_indicator=6, r.DotWeight,  0);
      SELF.name6.EmpID      := IF(r.name_indicator=6, r.EmpID,      0);
      SELF.name6.EmpScore   := IF(r.name_indicator=6, r.EmpScore,   0);
      SELF.name6.EmpWeight  := IF(r.name_indicator=6, r.EmpWeight,  0);
      SELF.name6.POWID      := IF(r.name_indicator=6, r.POWID, 		  0);
      SELF.name6.POWScore   := IF(r.name_indicator=6, r.POWScore,   0);
      SELF.name6.POWWeight  := IF(r.name_indicator=6, r.POWWeight,  0);
      SELF.name6.ProxID     := IF(r.name_indicator=6, r.ProxID, 	  0);
      SELF.name6.ProxScore  := IF(r.name_indicator=6, r.ProxScore,  0);
      SELF.name6.ProxWeight	:= IF(r.name_indicator=6, r.ProxWeight, 0);
      SELF.name6.SeleID     := IF(r.name_indicator=6, r.SeleID, 	  0);
      SELF.name6.SeleScore  := IF(r.name_indicator=6, r.SeleScore,  0);
      SELF.name6.SeleWeight	:= IF(r.name_indicator=6, r.SeleWeight, 0);			
      SELF.name6.OrgID      := IF(r.name_indicator=6, r.OrgID,			0);
      SELF.name6.OrgScore   := IF(r.name_indicator=6, r.OrgScore, 	0);
      SELF.name6.OrgWeight  := IF(r.name_indicator=6, r.OrgWeight,  0);
      SELF.name6.UltID      := IF(r.name_indicator=6, r.UltID, 		 	0);
      SELF.name6.UltScore   := IF(r.name_indicator=6, r.UltScore, 	0);
      SELF.name6.UltWeight  := IF(r.name_indicator=6, r.UltWeight,  0);

      SELF.name7_did        := IF(r.name_indicator=7, INTFORMAT(r.did,12,0), l.name7_did);
      SELF.name7_did_score 	:= IF(r.name_indicator=7, (string)r.did_score, l.name7_did_score);
      SELF.name7_ssn        := IF(r.name_indicator=7, r.ssn, l.name7_ssn);
      SELF.name7_bdid       := IF(r.name_indicator=7, INTFORMAT(r.bdid,12,0), l.name7_bdid);
      SELF.name7_bdid_score := IF(r.name_indicator=7, (string)r.bdid_score, l.name7_bdid_score);
      SELF.name7.DotID      := IF(r.name_indicator=7, r.DotID, 		  0);
      SELF.name7.DotScore   := IF(r.name_indicator=7, r.DotScore,	  0);
      SELF.name7.DotWeight  := IF(r.name_indicator=7, r.DotWeight,  0);
      SELF.name7.EmpID      := IF(r.name_indicator=7, r.EmpID,      0);
      SELF.name7.EmpScore   := IF(r.name_indicator=7, r.EmpScore,   0);
      SELF.name7.EmpWeight  := IF(r.name_indicator=7, r.EmpWeight,  0);
      SELF.name7.POWID      := IF(r.name_indicator=7, r.POWID, 		  0);
      SELF.name7.POWScore	  := IF(r.name_indicator=7, r.POWScore,   0);
      SELF.name7.POWWeight  := IF(r.name_indicator=7, r.POWWeight,  0);
      SELF.name7.ProxID     := IF(r.name_indicator=7, r.ProxID, 	  0);
      SELF.name7.ProxScore  := IF(r.name_indicator=7, r.ProxScore,  0);
      SELF.name7.ProxWeight	:= IF(r.name_indicator=7, r.ProxWeight, 0); 
      SELF.name7.SeleID	    := IF(r.name_indicator=7, r.SeleID, 	  0);
      SELF.name7.SeleScore  := IF(r.name_indicator=7, r.SeleScore,  0);
      SELF.name7.SeleWeight	:= IF(r.name_indicator=7, r.SeleWeight, 0);			
      SELF.name7.OrgID      := IF(r.name_indicator=7, r.OrgID,			0);
      SELF.name7.OrgScore   := IF(r.name_indicator=7, r.OrgScore, 	0);
      SELF.name7.OrgWeight  := IF(r.name_indicator=7, r.OrgWeight,  0);
      SELF.name7.UltID      := IF(r.name_indicator=7, r.UltID, 		 	0);
      SELF.name7.UltScore   := IF(r.name_indicator=7, r.UltScore, 	0);
      SELF.name7.UltWeight  := IF(r.name_indicator=7, r.UltWeight,  0);

      SELF.name8_did        := IF(r.name_indicator=8, INTFORMAT(r.did,12,0), l.name8_did);
      SELF.name8_did_score 	:= IF(r.name_indicator=8, (string)r.did_score, l.name8_did_score);
      SELF.name8_ssn        := IF(r.name_indicator=8, r.ssn, l.name8_ssn);
      SELF.name8_bdid       := IF(r.name_indicator=8, INTFORMAT(r.bdid,12,0), l.name8_bdid);
      SELF.name8_bdid_score := IF(r.name_indicator=8, (string)r.bdid_score, l.name8_bdid_score);	
      SELF.name8.DotID      := IF(r.name_indicator=8, r.DotID, 		  0);
      SELF.name8.DotScore   := IF(r.name_indicator=8, r.DotScore,	  0);
      SELF.name8.DotWeight  := IF(r.name_indicator=8, r.DotWeight,  0);
      SELF.name8.EmpID      := IF(r.name_indicator=8, r.EmpID,      0);
      SELF.name8.EmpScore   := IF(r.name_indicator=8, r.EmpScore,   0);
      SELF.name8.EmpWeight  := IF(r.name_indicator=8, r.EmpWeight,  0);
      SELF.name8.POWID      := IF(r.name_indicator=8, r.POWID, 		  0);
      SELF.name8.POWScore   := IF(r.name_indicator=8, r.POWScore,   0);
      SELF.name8.POWWeight  := IF(r.name_indicator=8, r.POWWeight,  0);
      SELF.name8.ProxID     := IF(r.name_indicator=8, r.ProxID, 	  0);
      SELF.name8.ProxScore  := IF(r.name_indicator=8, r.ProxScore,  0);
      SELF.name8.ProxWeight	:= IF(r.name_indicator=8, r.ProxWeight, 0);
      SELF.name8.SeleID     := IF(r.name_indicator=8, r.SeleID, 	  0);
      SELF.name8.SeleScore  := IF(r.name_indicator=8, r.SeleScore,  0);
      SELF.name8.SeleWeight	:= IF(r.name_indicator=8, r.SeleWeight, 0);			
      SELF.name8.OrgID      := IF(r.name_indicator=8, r.OrgID,			0);
      SELF.name8.OrgScore   := IF(r.name_indicator=8, r.OrgScore, 	0);
      SELF.name8.OrgWeight  := IF(r.name_indicator=8, r.OrgWeight,  0);
      SELF.name8.UltID      := IF(r.name_indicator=8, r.UltID, 		 	0);
      SELF.name8.UltScore   := IF(r.name_indicator=8, r.UltScore, 	0);
      SELF.name8.UltWeight  := IF(r.name_indicator=8, r.UltWeight,  0);
      
      SELF := l;
    END;


    //DISTRIBUTE the data before DENORMALIZE to avoid skewing
    foreclosureInDist					:=	DISTRIBUTE(dAllRecords, HASH32(sequence));
    foreclosureNormalizedDist	:=	DISTRIBUTE(ds_Normalized, HASH32(sequence));


    foreclosureBase := DENORMALIZE(foreclosureInDist, foreclosureNormalizedDist,
                                    LEFT.sequence = right.sequence,	
                                    DeNormalizeRecords(LEFT,right));

    PromoteSupers.Mac_SF_BuildProcess(normalised_linkids,Constants.base_prefix_name+ '_Normalized',normalised_out,,,,filedate);													
    PromoteSupers.Mac_SF_BuildProcess(PROJECT(foreclosureInDist,Layouts.base),Constants.base_prefix_name,base_out,,,,filedate);																

    writeFiles := sequential(normalised_out,base_out);	
    RETURN writeFiles;

END;

