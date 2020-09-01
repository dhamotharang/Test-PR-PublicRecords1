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
    
    //Transform input file into ConsumerStatement base file
    clean_file := PROJECT(AddrClean, 
                                       TRANSFORM(PRTE2_ConsumerStatement.Layouts.Base,
                                                   SELF.addr_suffix  :=  LEFT.Clean_Address.addr_suffix;
                                                   SELF.cart         :=  LEFT.Clean_Address.cart;
                                                   SELF.chk_digit    :=  LEFT.Clean_Address.chk_digit;
                                                   SELF.county       :=  LEFT.Clean_Address.fips_county;
                                                   SELF.cr_sort_sz   :=  LEFT.Clean_Address.cr_sort_sz;
                                                   SELF.dbpc         :=  LEFT.Clean_Address.dbpc;
                                                   SELF.err_stat     :=  LEFT.Clean_Address.err_stat;
                                                   SELF.geo_blk      :=  LEFT.Clean_Address.geo_blk;
                                                   SELF.geo_lat      :=  LEFT.Clean_Address.geo_lat;
                                                   SELF.geo_long     :=  LEFT.Clean_Address.geo_long;
                                                   SELF.geo_match    :=  LEFT.Clean_Address.geo_match;
                                                   SELF.lot          :=  LEFT.Clean_Address.lot;
                                                   SELF.lot_order    :=  LEFT.Clean_Address.lot_order;
                                                   SELF.msa          :=  LEFT.Clean_Address.msa;
                                                   SELF.orig_city    :=  LEFT.Clean_Address.v_city_name;
                                                   SELF.orig_st      :=  LEFT.Clean_Address.st;
                                                   SELF.orig_zip     :=  LEFT.Clean_Address.zip;
                                                   SELF.orig_zip4    :=  LEFT.Clean_Address.zip4;
                                                   SELF.p_city_name  :=  LEFT.Clean_Address.p_city_name;
                                                   SELF.postdir      :=  LEFT.Clean_Address.postdir;
                                                   SELF.predir       :=  LEFT.Clean_Address.predir;
                                                   SELF.prim_name    :=  LEFT.Clean_Address.prim_name;
                                                   SELF.prim_range   :=  LEFT.Clean_Address.prim_range;
                                                   SELF.rec_type     :=  LEFT.Clean_Address.rec_type;
                                                   SELF.sec_range    :=  LEFT.Clean_Address.sec_range;
                                                   SELF.st           :=  LEFT.Clean_Address.st;
                                                   SELF.Statement_ID :=  LEFT.statementid_autofill;
                                                   SELF.unit_desig   :=  LEFT.Clean_Address.unit_desig;
                                                   SELF.v_city_name  :=  LEFT.Clean_Address.v_city_name;
                                                   SELF.zip          :=  LEFT.Clean_Address.zip;
                                                   SELF.zip4         :=  LEFT.Clean_Address.zip4;

                                                   SELF.orig_address   :=  LEFT.xstreetaddress;
                                                   SELF.orig_fname     :=  LEFT.xnamefirst;
                                                   SELF.fname          :=  LEFT.xnamefirst;
                                                   SELF.orig_mname     :=  LEFT.xnamemiddle;
                                                   SELF.mname          :=  LEFT.xnamemiddle;
                                                   SELF.orig_lname     :=  LEFT.xnamelast;
                                                   SELF.lname          :=  LEFT.xnamelast;
                                                   SELF.SSN            :=  LEFT.xsocialsecuritynumber;
                                                   SELF.name_suffix    :=  '';

                                                   SELF.DID            :=  LEFT.lexid;
                                                   SELF.consumer_text  :=  LEFT.Content;
                                                   SELF.date_created   :=  LEFT.dateadded_autofill;
                                                   SELF.Date_Submitted :=  LEFT.dateadded_autofill;

                                                    
    SELF := LEFT;
    SELF := [];));

    PromoteSupers.MAC_SF_BuildProcess(clean_file, Constants.Base_Prefix + 'ConsumerStatement', bld_base_INS, ,, TRUE);
    RETURN sequential(bld_base_INS);
    END;