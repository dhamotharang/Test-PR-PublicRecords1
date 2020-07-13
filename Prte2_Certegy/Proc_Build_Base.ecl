IMPORT UT, MDR, PROMOTESUPERS, STD, PRTE2, ADDRESS, PRTE2_CERTEGY, CERTEGY, AID, AID_SUPPORT, ACCOUNTMONITORING, EPLS;

EXPORT Proc_Build_Base := FUNCTION

    //Input Files
    PRTE2.CleanFields(PRTE2_Certegy.Files.Input_INS, DS_CLEAN_INS);
        
    TempLayout := record
      PRTE2_certegy.Layouts.INPUT;
      string50 concat_address1;
    end;    
        
    //Project GE file into base layout
    DS_CLEAN_INS_temp := PROJECT(DS_CLEAN_INS, 
                                 TRANSFORM(tempLayout, 
                                            self.concat_address1 := std.str.CleanSpaces(trim(left.orig_house_bldg_num)) + ' ' 
                                                                  + std.str.CleanSpaces(trim(left.orig_street_name) + ' ' 
                                                                  + std.str.CleanSpaces(trim(left.orig_apt_num))); 
                                            self := left; 
                                            self := []
                                          ));        
        
        
    //Address Cleaning
    AddrClean := PRTE2.AddressCleaner(DS_CLEAN_INS_temp,
                                      ['concat_address1'], //address
                                      ['blank'], //address
                                      ['orig_city'],  //city
                                      ['orig_state'], //statelog
                                      ['orig_zip '], //zip
                                      ['clean_address'], //clean_addr_out
                                      ['Temp_RawAID']); //raw_aid_out
    
    //Clean Addresses
    Clean_INS := PROJECT(AddrClean,
                                       TRANSFORM(PRTE2_Certegy.Layouts.Base,
                                                 SELF.prim_range  :=  LEFT.Clean_Address.prim_range;
                                                 SELF.predir      :=  LEFT.Clean_Address.predir;
                                                 SELF.prim_name   :=  LEFT.Clean_Address.prim_name;
                                                 SELF.addr_suffix :=  LEFT.Clean_Address.addr_suffix;
                                                 SELF.postdir     :=  LEFT.Clean_Address.postdir;
                                                 SELF.unit_desig  :=  LEFT.Clean_Address.unit_desig;
                                                 SELF.sec_range   :=  LEFT.Clean_Address.sec_range;
                                                 SELF.p_city_name :=  LEFT.Clean_Address.p_city_name;
                                                 SELF.v_city_name :=  LEFT.Clean_Address.v_city_name;
                                                 SELF.st          :=  LEFT.Clean_Address.st;
                                                 SELF.zip         :=  LEFT.Clean_Address.zip;
                                                 SELF.zip4        :=  LEFT.Clean_Address.zip4;
                                                 SELF.cart        :=  LEFT.Clean_Address.cart;
                                                 SELF.cr_sort_sz  :=  LEFT.Clean_Address.cr_sort_sz;
                                                 SELF.lot         :=  LEFT.Clean_Address.lot;
                                                 SELF.lot_order   :=  LEFT.Clean_Address.lot_order;
                                                 SELF.dbpc        :=  LEFT.Clean_Address.dbpc;
                                                 SELF.chk_digit   :=  LEFT.Clean_Address.chk_digit;
                                                 SELF.rec_type    :=  LEFT.Clean_Address.rec_type;
                                                 SELF.fips_county :=  LEFT.Clean_Address.fips_county;
                                                 SELF.geo_lat     :=  LEFT.Clean_Address.geo_lat;
                                                 SELF.geo_long    :=  LEFT.Clean_Address.geo_long;
                                                 SELF.msa         :=  LEFT.Clean_Address.msa;
                                                 SELF.geo_blk     :=  LEFT.Clean_Address.geo_blk;
                                                 SELF.geo_match   :=  LEFT.Clean_Address.geo_match;
                                                 SELF.err_stat    :=  LEFT.Clean_Address.err_stat;
                                                 
                                                 SELF.orig_house_bldg_num := LEFT.orig_house_bldg_num;
                                                 SELF.orig_street_name := LEFT.orig_street_name; 
                                                 SELF.orig_apt_num := LEFT.orig_apt_num;
                                                 SELF.orig_city := LEFT.orig_city;
                                                 SELF.orig_state := LEFT.orig_state;
                                                 SELF.orig_zip := LEFT.orig_zip;
                                                 SELF.county :=  LEFT.Clean_Address.fips_county;
                                                 SELF.orig_unit_desc := LEFT.Clean_Address.unit_desig;                                                 
                                                 SELF.orig_street_pre_dir := LEFT.Clean_Address.Predir;
                                                 SELF.orig_street_suffix := LEFT.Clean_Address.addr_suffix;
                                                 SELF.orig_street_post_dir := LEFT.Clean_Address.postdir;
                                                                                                  
                                                 //Name cleaning
                                                 SELF.title := '';
                                                 SELF.fname := left.orig_first_name;
                                                 SELF.mname := left.orig_mid_name;
                                                 SELF.lname := left.orig_last_name; 
                                                 SELF.name_suffix := LEFT.name_suffix;
                                                                                                  
                                                 //Phone Cleaning
                                                 SELF.orig_home_tel_area := ut.CleanPhone(LEFT.clean_hphone);
                                                 SELF.orig_home_tel_num  := ut.CleanPhone(LEFT.clean_hphone);
                                                 //LexID
                                                 SELF.DID := if(LEFT.did > 0, LEFT.did, PRTE2.FN_APPENDFAKEID.DID(SELF.fname, SELF.lname, 
                                                                              LEFT.LINK_SSN, LEFT.LINK_DOB, LEFT.CUST_NAME)); 
                                                 
                                                 //Link_dob to Clean_dob
                                                 SELF.Clean_dob := LEFT.Link_dob;
                                                 SELF.Clean_ssn := LEFT.Link_ssn;
                                                 
    SELF := LEFT;  //map matching fields from raw to base                               
    SELF := [];)); //map all other fields blank

    //Add Global_SID
    //addGSFiltered := MDR.macGetGlobalSid(combine_files_clean,'CertegyKeys','','global_sid'); //Global_SID has not yet been updated in the lookup table. 
                      //When the lookup table has been updated, uncomment the macro for global_SID and remove it from the address cleaning transform.  
    
    //Build Base
    PromoteSupers.MAC_SF_BuildProcess(Clean_INS, Constants.Base_Prefix + 'Certegy', bld_base_boca,,,TRUE);
    RETURN sequential(bld_base_boca);
    END;