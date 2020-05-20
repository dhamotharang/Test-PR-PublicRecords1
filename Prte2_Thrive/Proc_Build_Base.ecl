IMPORT UT, MDR, PromoteSupers, std, Prte2, Address, AID, AID_Support, Thrive, PRTE2_Thrive, AccountMonitoring, EPLS;

EXPORT Proc_Build_Base (STRING version)  := function

    //Input Files
    PRTE2.CleanFields(PRTE2_Thrive.Files.Input_INS, ds_clean_INS);

   //Address Cleaning
    AddrClean := PRTE2.AddressCleaner(ds_clean_INS,
                                      ['orig_addr'],  //address
                                      ['blank'],      //address
                                      ['orig_city'],  //city
                                      ['orig_state'], //statelog-*
                                      ['orig_zip5'],  //zip
                                      ['clean_address'], //clean_addr_out
                                      ['Temp_RawAID']);  //raw_aid_out
    
      
    //Clean Addresses
    combine_files_clean := PROJECT(AddrClean(orig_lname != ''),
                                       TRANSFORM(PRTE2_Thrive.Layouts.Base,
                                                 SELF.RawAID      :=  LEFT.Temp_RawAID;
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
                                                 SELF.fips_st     :=  LEFT.Clean_Address.fips_state;
                                                 SELF.fips_county :=  LEFT.Clean_Address.fips_county;
                                                 SELF.SRC         :=  LEFT.SRC;                                                 
                                                 SELF.persistent_record_id := if(left.src = 'TM', 'LT'+version, 'PD'+version)+intformat(Counter,10,1);  
                                                 SELF.geo_lat     :=  LEFT.Clean_Address.geo_lat;
                                                 SELF.geo_long    :=  LEFT.Clean_Address.geo_long;
                                                 SELF.msa         :=  LEFT.Clean_Address.msa;
                                                 SELF.geo_blk     :=  LEFT.Clean_Address.geo_blk;
                                                 SELF.geo_match   :=  LEFT.Clean_Address.geo_match;
                                                 SELF.err_stat    :=  LEFT.Clean_Address.err_stat;
                                                 SELF.record_sid  := 0;
                                                                                              
                                                 //Name cleaning with exceptions
                                                 SELF.title := '';
                                                 SELF.fname := LEFT.orig_fname;
                                                 SELF.mname := LEFT.orig_mname;
                                                 SELF.lname := LEFT.orig_lname;
                                                 SELF.name_suffix := LEFT.name_suffix;

                                                 //Phone Cleaning
                                                 SELF.clean_phone_home := ut.CleanPhone(LEFT.Phone_Home);
                                                 SELF.clean_phone_work := ut.CleanPhone(LEFT.Phone_Work);  
                                                 SELF.clean_phone_cell := ut.CleanPhone(LEFT.Phone_Cell);
                                                 
                                                 //LexID
                                                 SELF.DID := if(LEFT.did > 0, LEFT.did, PRTE2.FN_APPENDFAKEID.DID(SELF.fname, SELF.lname, LEFT.LINK_SSN, LEFT.LINK_DOB, LEFT.CUST_NAME)); 
                                                 
                                                 //Link_dob to Clean_dob
                                                 SELF.Clean_dob := LEFT.Link_dob;
   
    SELF := LEFT;
    SELF := [];));
       
    //Add Global_SID
    addGSFiltered := MDR.macGetGlobalSid(combine_files_clean,'Thrive','','global_sid');
   
   
   //Build Base
    PromoteSupers.MAC_SF_BuildProcess(addGSFiltered, Constants.Base_Prefix + 'Thrive', bld_base_boca,,,TRUE);
    RETURN sequential(bld_base_boca);
    END;