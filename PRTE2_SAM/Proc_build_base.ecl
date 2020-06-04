IMPORT UT, PromoteSupers, std, Prte2, Address, AID, AID_Support, SAM, PRTE2_Sam, AccountMonitoring, EPLS, SAM_Services;
EXPORT Proc_build_base := FUNCTION

    //Input Files
    PRTE2.CleanFields(PRTE2_SAM.Files.Input_Boca, ds_clean_Boca);  
    PRTE2.CleanFields(PRTE2_SAM.Files.Input_INS, ds_clean_INS);
    ds_Boca_INS := ds_clean_Boca + ds_clean_INS;

    //Address Cleaning
    AddrClean := PRTE2.AddressCleaner(ds_Boca_INS,
                                      ['address_1'],     //address
                                      ['dummy1'],        //address
                                      ['city'],          //city
                                      ['state'],         //statelog-*
                                      ['zipcode'],       //zip
                                      ['clean_address'], //clean_addr_out
                                      ['Temp_RawAID']);  //raw_aid_out
    
    //Layout_SAM info
    combine_files_clean := PROJECT(AddrClean, 
                                       TRANSFORM(PRTE2_SAM.Layouts.Base,
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
                                                 SELF.CNAME       :=  LEFT.NAME; 

                                            //Name cleaning
                                            CleanName             := Address.CleanPersonFML73_fields(LEFT.firstname+' '+LEFT.middlename+' '+LEFT.lastname);
                                                 SELF.title       := CleanName.title;
                                                 SELF.fname       := CleanName.fname;
                                                 SELF.mname       := CleanName.mname;
                                                 SELF.lname       := CleanName.lname;
                                                 SELF.name_suffix := CleanName.name_suffix;
                                                 SELF.name_score  := CleanName.name_score;
                                                 SELF.DID         := if(LEFT.did > 0, LEFT.did, PRTE2.FN_APPENDFAKEID.DID(CleanName.fname, CleanName.lname, LEFT.LINK_SSN, LEFT.LINK_DOB, LEFT.CUST_NAME));
                                                 SELF.bdid        := prte2.fn_AppendFakeID.bdid(LEFT.Name, LEFT.Clean_Address.prim_range, LEFT.Clean_Address.prim_name, 
                                                                                                LEFT.Clean_Address.v_city_name, LEFT.Clean_Address.st, 
                                                                                                LEFT.Clean_Address.zip, LEFT.cust_name);
                                         
                                            //Fake ID
                                            vLinkingIds := prte2.fn_AppendFakeID.LinkIds(LEFT.name, LEFT.link_fein, LEFT.link_inc_date, LEFT.Clean_Address.prim_range, 
                                                                                         LEFT.Clean_Address.prim_name, LEFT.Clean_Address.sec_range, LEFT.Clean_Address.v_city_name, 
                                                                                         LEFT.Clean_Address.st, LEFT.Clean_Address.zip, LEFT.cust_name);
     
                                                 SELF.powid   := vLinkingIds.powid;
                                                 SELF.proxid  := vLinkingIds.proxid;
                                                 SELF.seleid  := vLinkingIds.seleid;
                                                 SELF.orgid   := vLinkingIds.orgid;
                                                 SELF.ultid   := vLinkingIds.ultid;
    
    SELF := LEFT;
    SELF := [];));

    PromoteSupers.MAC_SF_BuildProcess(combine_files_clean, Constants.Base_Prefix + 'SAM', bld_base_boca, ,, TRUE);
    RETURN sequential(bld_base_boca);
    END;