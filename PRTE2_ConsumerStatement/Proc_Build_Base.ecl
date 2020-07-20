IMPORT UT, PromoteSupers, std, Prte2, Address, AID, AID_Support, PRTE2_ConsumerStatement, AccountMonitoring, EPLS;
EXPORT Proc_build_base := FUNCTION

    //Input Files
    PRTE2.CleanFields(PRTE2_ConsumerStatement.Files.Input, ds_clean_INS);


    //Address Cleaning
    AddrClean := PRTE2.AddressCleaner(ds_clean_INS,
                                      ['xstreetaddress'], //address
                                      ['dummy1'],         //address
                                      ['xcity'],          //city
                                      ['xstate'],         //statelog
                                      ['xzip'],           //zip
                                      ['clean_address'],  //clean_addr_out
                                      ['Temp_RawAID']);   //raw_aid_out
    
    //Layout_SAM info
    clean_file := PROJECT(AddrClean, 
                                       TRANSFORM(PRTE2_ConsumerStatement.Layouts.Base,
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
                                                 SELF.county      :=  LEFT.Clean_Address.fips_county;
                                                 SELF.geo_lat     :=  LEFT.Clean_Address.geo_lat;
                                                 SELF.geo_long    :=  LEFT.Clean_Address.geo_long;
                                                 SELF.msa         :=  LEFT.Clean_Address.msa;
                                                 SELF.geo_blk     :=  LEFT.Clean_Address.geo_blk;
                                                 SELF.geo_match   :=  LEFT.Clean_Address.geo_match;
                                                 SELF.err_stat    :=  LEFT.Clean_Address.err_stat;
                                                 SELF.orig_fname  := LEFT.xnamefirst;
                                                 SELF.orig_lname  := LEFT.xnamelast;
                                                 SELF.orig_mname  := LEFT.xnamemiddle;
                                                 SELF.orig_city   := LEFT.xcity;
                                                 SELF.orig_st     := LEFT.xstate;
                                                 SELF.orig_zip    := LEFT.xzip;
                                                 SELF.orig_zip4   := LEFT.xzip4;
                                                 SELF.DID         := LEFT.lexid;
                                                 SELF.orig_address := LEFT.xstreetaddress;
                                                 SELF.consumer_text := LEFT.Content;
                                                 SELF.Statement_ID := LEFT.statementid_autofill;
                                                 SELF.Date_Submitted := LEFT.dateadded_autofill;
                                                 SELF.SSN := LEFT.xsocialsecuritynumber;
                                                 SELF.date_created := LEFT.dateadded_autofill;
                                                 SELF.fname := SELF.orig_fname;       
                                                 SELF.mname := SELF.orig_mname;      
                                                 SELF.lname := SELF.orig_lname;  
                                                 SELF.name_suffix := LEFT.xnamesuffix;
                                                    
    SELF := LEFT;
    SELF := [];));

    PromoteSupers.MAC_SF_BuildProcess(clean_file, Constants.Base_Prefix + 'ConsumerStatement', bld_base_INS, ,, TRUE);
    RETURN sequential(bld_base_INS);
    END;