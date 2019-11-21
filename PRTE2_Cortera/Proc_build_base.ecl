﻿IMPORT Cortera, UT, PromoteSupers, std, Prte2, PRTE2_Cortera, Address, AID, AID_Support;
EXPORT Proc_build_base := FUNCTION

//Input Files
PRTE2.CleanFields(PRTE2_Cortera.Files.Input_Boca, ds_clean_Boca);
PRTE2.CleanFields(PRTE2_Cortera.Files.Input_INS, ds_clean_INS);

    //Address Cleaning
    AddrClean := PRTE2.AddressCleaner(ds_clean_Boca,
                                      ['address'],
                                      ['BLANK'],
                                      ['city'],
                                      ['state'],
                                      ['postalcode'],
                                      ['clean_address'],
                                      ['temp_rawaid']);

    ds_Boca_out := Project(AddrClean, Transform(PRTE2_cortera.Layouts.rlayout,
                                                 self.rawaid      :=  left.temp_rawaid;
                                                 self.prim_range  :=  left.Clean_Address.prim_range;
                                                 self.predir      :=  left.Clean_Address.predir;
                                                 self.prim_name   :=  left.Clean_Address.prim_name;
                                                 self.addr_suffix :=  left.Clean_Address.addr_suffix;
                                                 self.postdir     :=  left.Clean_Address.postdir;
                                                 self.unit_desig  :=  left.Clean_Address.unit_desig;
                                                 self.sec_range   :=  left.Clean_Address.sec_range;
                                                 self.p_city_name :=  left.Clean_Address.p_city_name;
                                                 self.v_city_name :=  left.Clean_Address.v_city_name;
                                                 self.st          :=  left.Clean_Address.st;
                                                 self.zip         :=  left.Clean_Address.zip;
                                                 self.zip4        :=  left.Clean_Address.zip4;
                                                 self.cart        :=  left.Clean_Address.cart;
                                                 self.cr_sort_sz  :=  left.Clean_Address.cr_sort_sz;
                                                 self.lot         :=  left.Clean_Address.lot;
                                                 self.lot_order   :=  left.Clean_Address.lot_order;
                                                 self.dbpc        :=  left.Clean_Address.dbpc;
                                                 self.chk_digit   :=  left.Clean_Address.chk_digit;
                                                 self.rec_type    :=  left.Clean_Address.rec_type;
                                                 self.county      :=  left.Clean_Address.fips_county;
                                                 self.geo_lat     :=  left.Clean_Address.geo_lat;
                                                 self.geo_long    :=  left.Clean_Address.geo_long;
                                                 self.msa         :=  left.Clean_Address.msa;
                                                 self.geo_blk     :=  left.Clean_Address.geo_blk;
                                                 self.geo_match   :=  left.Clean_Address.geo_match;
                                                 self.err_stat    :=  left.Clean_Address.err_stat; 
    
    //Populate BDID
    SELF.bdid   := prte2.fn_AppendFakeID.bdid(left.Name, SELF.prim_range, SELF.prim_name, SELF.v_city_name, SELF.st, SELF.zip, left.cust_name);
    
    //Fake ID
    vLinkingIds := prte2.fn_AppendFakeID.LinkIds(left.name, left.link_fein, left.link_inc_date, self.prim_range, self.prim_name, self.sec_range, self.v_city_name, self.st, self.zip, left.cust_name);
    
      SELF.powid   := vLinkingIds.powid;
      SELF.proxid  := vLinkingIds.proxid;
      SELF.seleid  := vLinkingIds.seleid;
      SELF.orgid     := vLinkingIds.orgid;
      SELF.ultid     := vLinkingIds.ultid;
    
      SELF.persistent_record_id := (left.link_id << 32) + left.dt_vendor_first_reported;
      SELF.clean_phone := ut.CleanPhone(left.PHONE);
      SELF.clean_fax := ut.CleanPhone(left.FAX);
      SELF.current := true;
    
    SELF := Left;
    SELF := [];));
    
    //Combine Boca and Insurance Files
    combine_files_clean := ds_Boca_out + ds_clean_INS;
    Header_File := Project(combine_files_clean,
                                       Transform(PRTE2_cortera.Layouts.base,
                                                 SElF := LEFT,
                                                 SELF := []
                                                )
                                      );
    
    Attribute_File := Project(combine_files_clean,
                                            Transform(PRTE2_cortera.Layouts.Attributes_Out,
                                                      SELF.ultimate_linkid   := LEFT.LINK_ID;
                                                      SELF := LEFT,
                                                      SELF := []
                                                     )
                                           );
    //Build Base
    PromoteSupers.MAC_SF_BuildProcess(Header_File, Constants.Base_Prefix + 'header', bld_base_hdr, ,, true);
    PromoteSupers.MAC_SF_BuildProcess(Attribute_File, Constants.Base_Prefix + 'Attributes', bld_base_attr, ,, true);
    return sequential(bld_base_hdr, bld_base_attr);
    end;
    
    // EXPORT proc_build_base := bld_base;


