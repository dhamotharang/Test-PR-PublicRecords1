IMPORT PRTE2_ATF, ATF, ut, PromoteSupers, NID, Address, BIPV2, STD, MDR, AID, AID_Support, PRTE2;
#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION
  

  //Input
  dATAF := PRTE2_ATF.files.ATF_Firearms_in;

  //Create persist, add source code for all records
  PRTE2_ATF.layouts.Base_ext xfrm(dATAF L) := TRANSFORM
    self.source := if(L.record_type='F',MDR.sourceTools.src_Federal_Firearms,MDR.sourceTools.src_Federal_Explosives);
    self.bdid 	:= if(L.bdid = '0','',intformat((integer)L.bdid, 12, 1));
    self.bdid_score := intformat((integer)L.bdid_score,3,1);
    self.DID_out := if(L.did_out = '0','',intformat((integer)L.did_out, 12, 1));
    self.d_score := intformat((integer)L.d_score,3,1);
    
    //Fix zipcode as spreadsheet removes leading zero
    self.Premise_orig_Zip := if(length(trim(L.Premise_orig_Zip)) < 5, INTFORMAT((integer)L.Premise_orig_Zip,5,1),L.Premise_orig_Zip);
    self.Mail_Zip_Code 		:= if(length(trim(L.Mail_Zip_Code)) < 5, INTFORMAT((integer)L.Mail_Zip_Code,5,1),L.Mail_Zip_Code);

    self.persistent_record_id	:= HASH64(L.rec_code,
                                          trim(L.license_number,left,right),
                                          trim(L.Lic_Regn,left,right),
                                          trim(L.Lic_Dist,left,right),
                                          trim(L.Lic_Cnty,left,right),
                                          trim(L.Lic_Type,left,right),
                                          trim(L.Lic_Xprdte,left,right),
                                          trim(L.License_Name,left,right),
                                          trim(L.Business_Name,left,right),
                                          trim(L.Premise_Street,left,right),
                                          trim(L.Premise_City,left,right),
                                          trim(L.Premise_State,left,right),
                                          trim(L.Premise_orig_Zip,left,right),
                                          trim(L.Mail_Street,left,right),
                                          trim(L.Mail_City,left,right),
                                          trim(L.Mail_State,left,right), 
                                          trim(L.Mail_Zip_Code,left,right),
                                          trim(L.Voice_Phone,left,right)
                                          // 08/03/17 DCC - removed clean fields from persistent_record_id hash.  
                                          //                note: prod needs updating as well
                                          // ,
                                          // trim(L.license1_fname,left,right),
                                          // trim(L.license1_mname,left,right),
                                          // trim(L.license1_lname,left,right),
                                          // trim(L.license1_name_suffix,left,right),
                                          // trim(L.license1_cname,left,right),
                                          // trim(L.license2_fname,left,right),
                                          // trim(L.license2_mname,left,right),
                                          // trim(L.license2_lname,left,right),
                                          // trim(L.license2_name_suffix,left,right),
                                          // trim(L.license2_cname,left,right),
                                          // trim(L.business_cname,left,right)
                                          );
    self := L;
    self := [];
  END;

  pBase_out	:= PROJECT(dATAF, xfrm(left));

  //separate old and new records
   dExistingRecords := pBase_out(cust_name = '');
   dNewRecords	:= pBase_out(cust_name <> '');  
    
    //Address Cleaning
    dNewRecordsAddrClean := PRTE2.AddressCleaner(dNewRecords,   
                                              ['premise_street', 'mail_street'],                                              
                                              ['dummy1', 'dummy2'], //these are fake fields.  The address cleaner will use the fields below to create the prepped city_state_zip line
                                              ['premise_city', 'mail_city'],
                                              ['premise_state', 'mail_state'],                                              
                                              ['premise_orig_zip', 'mail_zip_code'],
                                              ['premise_address', 'mail_address'],
                                              ['premise_address_rawaid', 'mail_address_rawaid']);
                                              
                                        
    
    //Clean name/business
    PRTE2_ATF.Layouts.Base_ext	xformBase(dNewRecordsAddrClean L) := 
    TRANSFORM																	
        //Name Cleaning
				clean_name := Address.Clean_n_Validate_Name(L.License_Name, 'L').CleanNameRecord;
        v_lname := trim(L.License_Name[1..STD.Str.Find(L.License_Name, ',', 1) -1], right);
        v_fmid := trim(std.str.filterout(trim(L.License_Name[STD.Str.Find(L.License_Name, ',', 1)..], right),','), left,right);
        v_fname := trim(v_fmid[1..STD.Str.Find(v_fmid, ' ', 1) -1], right);
        v_mname := trim(v_fmid[length(v_fname)+1..], left,right);
        SELF.license1_title := clean_name.title;
        SELF.license1_fname := if(clean_name.fname = v_fname, clean_name.fname, v_fname); 
        SELF.license1_mname := if(clean_name.mname = v_mname, clean_name.mname, v_mname); 
        SELF.license1_lname := if(clean_name.lname = v_lname, clean_name.lname, v_lname);
        SELF.license1_name_suffix := clean_name.name_suffix;
        SELF.license1_score := clean_name.name_score;

        // clean_name	:= Address.Clean_n_Validate_Name(L.License_Name, 'L').CleanNameRecord;
        
        // SELF.license1_title				:= clean_name.title;
        // SELF.license1_fname	      := clean_name.fname;      
        // SELF.license1_mname	      := clean_name.mname;      
        // SELF.license1_lname	      := clean_name.lname;
        // SELF.license1_name_suffix	:= clean_name.name_suffix;
        // SELF.license1_score	  := clean_name.name_score;

        //Addresses
        SELF.premise_prim_range       :=  L.premise_address.prim_range;
        SELF.premise_predir           :=  L.premise_address.predir;
        SELF.premise_prim_name        :=  L.premise_address.prim_name;
        SELF.premise_suffix           :=  L.premise_address.addr_suffix;
        SELF.premise_postdir          :=  L.premise_address.postdir;
        SELF.premise_unit_desig       :=  L.premise_address.unit_desig;
        SELF.premise_sec_range        :=  L.premise_address.sec_range;
        SELF.premise_p_city_name      :=  L.premise_address.p_city_name;
        SELF.premise_v_city_name      :=  L.premise_address.v_city_name;
        SELF.premise_st               :=  L.premise_address.st;
        SELF.premise_zip              :=  L.premise_address.zip;
        SELF.premise_zip4             :=  L.premise_address.zip4;
        SELF.premise_cart             :=  L.premise_address.cart;
        SELF.premise_cr_sort_sz       :=  L.premise_address.cr_sort_sz;
        SELF.premise_lot              :=  L.premise_address.lot;
        SELF.premise_lot_order        :=  L.premise_address.lot_order;
        SELF.premise_dpbc             :=  L.premise_address.dbpc;
        SELF.premise_chk_digit        :=  L.premise_address.chk_digit;
        SELF.premise_rec_type         :=  L.premise_address.rec_type;
        SELF.premise_fips_st          :=  L.premise_address.fips_state;
        SELF.premise_fips_county      :=  L.premise_address.fips_county;
        SELF.premise_geo_lat          :=  L.premise_address.geo_lat;
        SELF.premise_geo_long         :=  L.premise_address.geo_long;
        SELF.premise_msa              :=  L.premise_address.msa;
        SELF.premise_geo_blk          :=  L.premise_address.geo_blk;
        SELF.premise_geo_match        :=  L.premise_address.geo_match;
        SELF.premise_err_stat         :=  L.premise_address.err_stat;
        
        SELF.mail_prim_range  :=  L.mail_address.prim_range;
        SELF.mail_predir      :=  L.mail_address.predir;
        SELF.mail_prim_name   :=  L.mail_address.prim_name;
        SELF.mail_suffix      :=  L.mail_address.addr_suffix;
        SELF.mail_postdir     :=  L.mail_address.postdir;
        SELF.mail_unit_desig  :=  L.mail_address.unit_desig;
        SELF.mail_sec_range   :=  L.mail_address.sec_range;
        SELF.mail_p_city_name :=  L.mail_address.p_city_name;
        SELF.mail_v_city_name :=  L.mail_address.v_city_name;
        SELF.mail_st          :=  L.mail_address.st;
        SELF.mail_zip         :=  L.mail_address.zip;
        SELF.mail_zip4        :=  L.mail_address.zip4;
        SELF.mail_cart        :=  L.mail_address.cart;
        SELF.mail_cr_sort_sz  :=  L.mail_address.cr_sort_sz;
        SELF.mail_lot         :=  L.mail_address.lot;
        SELF.mail_lot_order   :=  L.mail_address.lot_order;
        SELF.mail_dpbc        :=  L.mail_address.dbpc;
        SELF.mail_chk_digit   :=  L.mail_address.chk_digit;
        SELF.mail_rec_type    :=  L.mail_address.rec_type;
        SELF.mail_fips_st     :=  L.mail_address.fips_state;
        SELF.mail_fips_county :=  L.mail_address.fips_county;
        SELF.mail_geo_lat     :=  L.mail_address.geo_lat;
        SELF.mail_geo_long    :=  L.mail_address.geo_long;
    
        //Append ID(s)
        SELF.DID_out  := (string)prte2.fn_AppendFakeID.did(clean_name.fname, clean_name.lname, L.link_ssn, L.link_dob, L.cust_name);
        SELF.bdid := (string)prte2.fn_AppendFakeID.bdid(L.business_name,	L.premise_address.prim_range,	L.premise_address.prim_name, L.premise_address.v_city_name, L.premise_address.st, L.premise_address.zip, L.cust_name);
        //generating linkids
        vLinkingIds := prte2.fn_AppendFakeID.LinkIds(L.business_name, L.link_fein, L.link_inc_date, L.premise_address.prim_range,	L.premise_address.prim_name, 
                                                     L.premise_address.sec_range, L.premise_address.v_city_name, L.premise_address.st, L.premise_address.zip, L.cust_name);
        SELF.powid    := vLinkingIds.powid;
        SELF.proxid   := vLinkingIds.proxid;
        SELF.seleid   := vLinkingIds.seleid;
        SELF.orgid    := vLinkingIds.orgid;
        SELF.ultid    := vLinkingIds.ultid;            
        
        SELF := L;
        SELF := [];
    END;
    
    dNewRecordsClean := project(dNewRecordsAddrClean, xformBase(left));

    //Concatenating Original & New Records
    dFinal := dNewRecordsClean + dExistingRecords;

    PromoteSupers.Mac_SF_BuildProcess(dFinal, Constants.BASE_ATF, writefile,,,,filedate);

    RETURN writefile;

END;
