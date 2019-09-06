import ut,promotesupers,prte_csv, Address,Prte2,AID,AID_Support,std, PRTE2_Domains;
#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION
  
  //uppercase and remove spaces from in file
  PRTE2.CleanFields(Files.file_in, dInClean);
  
  //Splitting New & Exisitng Records
  dExistingRecords := PROJECT(dInClean(cust_name = ''), TRANSFORM(Layouts.layout_base, SElF := LEFT, SELF := [])); 
  dNewRecords			 := dInClean(cust_name <> ''); 

  //Address Cleaning
  dAddressCleaned := PRTE2.AddressCleaner(	dNewRecords,   
                                            ['registrant_address1','admin_address1','tech_address1'],
                                            ['registrant_address2','admin_address2','tech_address2'],
                                            [],
                                            [],
                                            [],
                                            ['registrant_address','admin_address','tech_address'],
                                            ['registrant_rawaid','admin_rawaid','tech_rawaid']);
                                            
  //Transforming Name & Address 																			
  Layouts.layout_base	xformBase(dAddressCleaned	L) := 
  TRANSFORM																	
      //Name Cleaning
      clean_admin_name	:= Address.Clean_n_Validate_Name(L.admin_name, 'L').CleanNameRecord;
      
      SELF.title				:= clean_admin_name.title;
      SELF.fname	      := clean_admin_name.fname;      
      SELF.mname	      := clean_admin_name.mname;      
      SELF.lname	      := clean_admin_name.lname;
      SELF.name_suffix	:= clean_admin_name.name_suffix;
      SELF.name_score	  := clean_admin_name.name_score;

      SELF.admin_fname	:= clean_admin_name.fname;
      SELF.admin_mname	:= clean_admin_name.mname;
      SELF.admin_lname	:= clean_admin_name.lname;

      //move clean addresses to the correct fields
      SELF.state        :=  L.registrant_address.st;				
      SELF.zip          :=  L.registrant_address.zip;				
      SELF.dbpc				  :=  '';
      SELF              :=  L.registrant_address;
 
      SELF.registrant_prim_range :=  L.registrant_address.prim_range;
      SELF.registrant_predir     :=  L.registrant_address.predir;
      SELF.registrant_prim_name  :=  L.registrant_address.prim_name;
      SELF.registrant_suffix     :=  L.registrant_address.addr_suffix;
      SELF.registrant_postdir    :=  L.registrant_address.postdir;
      SELF.registrant_unit_desig :=  L.registrant_address.unit_desig;
      SELF.registrant_sec_range  :=  L.registrant_address.sec_range;
      SELF.registrant_p_city_name:=  L.registrant_address.p_city_name;
      SELF.registrant_v_city_name:=  L.registrant_address.v_city_name;
      SELF.registrant_state      :=  L.registrant_address.st;
      SELF.registrant_zip        :=  L.registrant_address.zip;
  
      SELF.admin_prim_range :=  L.admin_address.prim_range;
      SELF.admin_predir     :=  L.admin_address.predir;
      SELF.admin_prim_name  :=  L.admin_address.prim_name;
      SELF.admin_suffix     :=  L.admin_address.addr_suffix;
      SELF.admin_postdir    :=  L.admin_address.postdir;
      SELF.admin_unit_desig :=  L.admin_address.unit_desig;
      SELF.admin_sec_range  :=  L.admin_address.sec_range;
      SELF.admin_p_city_name:=  L.admin_address.p_city_name;
      SELF.admin_v_city_name:=  L.admin_address.v_city_name;
      SELF.admin_state      :=  L.admin_address.st;
      SELF.admin_zip        :=  L.admin_address.zip;
      SELF.admin_zip4       :=  L.admin_address.zip4;
      SELF.admin_cart       :=  L.admin_address.cart;
      SELF.admin_cr_sort_sz :=  L.admin_address.cr_sort_sz;
      SELF.admin_lot        :=  L.admin_address.lot;
      SELF.admin_lot_order  :=  L.admin_address.lot_order;
      SELF.admin_dbpc       :=  L.admin_address.dbpc;
      SELF.admin_chk_digit  :=  L.admin_address.chk_digit;
      SELF.admin_rec_type   :=  L.admin_address.rec_type;
      SELF.admin_county     :=  L.admin_address.fips_county;
      SELF.admin_geo_lat    :=  L.admin_address.geo_lat;
      SELF.admin_geo_long   :=  L.admin_address.geo_long;
      SELF.admin_msa        :=  L.admin_address.msa;
      SELF.admin_geo_blk    :=  L.admin_address.geo_blk;
      SELF.admin_geo_match  :=  L.admin_address.geo_match;
      SELF.admin_err_stat   :=  L.admin_address.err_stat;

      SELF.tech_prim_range :=  L.tech_address.prim_range;
      SELF.tech_predir     :=  L.tech_address.predir;
      SELF.tech_prim_name  :=  L.tech_address.prim_name;
      SELF.tech_suffix     :=  L.tech_address.addr_suffix;
      SELF.tech_postdir    :=  L.tech_address.postdir;
      SELF.tech_unit_desig :=  L.tech_address.unit_desig;
      SELF.tech_sec_range  :=  L.tech_address.sec_range;
      SELF.tech_p_city_name:=  L.tech_address.p_city_name;
      SELF.tech_v_city_name:=  L.tech_address.v_city_name;
      SELF.tech_state      :=  L.tech_address.st;
      SELF.tech_zip        :=  L.tech_address.zip;
      SELF.tech_zip4       :=  L.tech_address.zip4;
      SELF.tech_cart       :=  L.tech_address.cart;
      SELF.tech_cr_sort_sz :=  L.tech_address.cr_sort_sz;
      SELF.tech_lot        :=  L.tech_address.lot;
      SELF.tech_lot_order  :=  L.tech_address.lot_order;
      SELF.tech_dbpc       :=  L.tech_address.dbpc;
      SELF.tech_chk_digit  :=  L.tech_address.chk_digit;
      SELF.tech_rec_type   :=  L.tech_address.rec_type;
      SELF.tech_county     :=  L.tech_address.fips_county;
      SELF.tech_geo_lat    :=  L.tech_address.geo_lat;
      SELF.tech_geo_long   :=  L.tech_address.geo_long;
      SELF.tech_msa        :=  L.tech_address.msa;
      SELF.tech_geo_blk    :=  L.tech_address.geo_blk;
      SELF.tech_geo_match  :=  L.tech_address.geo_match;
      SELF.tech_err_stat   :=  L.tech_address.err_stat;
    
      //Append ID(s)
      SELF.did  := prte2.fn_AppendFakeID.did(clean_admin_name.fname, clean_admin_name.lname, L.link_ssn, L.link_dob, L.cust_name);
      SELF.bdid := prte2.fn_AppendFakeID.bdid(L.registrant_name,	L.registrant_address.prim_range,	L.registrant_address.prim_name, L.registrant_address.v_city_name, L.registrant_address.st, L.registrant_address.zip, L.cust_name);
      //generating linkids
      vLinkingIds := prte2.fn_AppendFakeID.LinkIds(L.registrant_name, L.link_fein, L.link_inc_date, L.registrant_address.prim_range, L.registrant_address.prim_name, 
                                                   L.registrant_address.sec_range, L.registrant_address.v_city_name, L.registrant_address.st, L.registrant_address.zip, L.cust_name);
  
      SELF.powid	:= vLinkingIds.powid;
      SELF.proxid	:= vLinkingIds.proxid;
      SELF.seleid	:= vLinkingIds.seleid;
      SELF.orgid	:= vLinkingIds.orgid;
      SELF.ultid	:= vLinkingIds.ultid;	     
      
			self.global_sid := 0;
			self.record_sid := 0;
      SELF := L;
      SELF := [];
  END;
  
  dNewRecordsClean := project(dAddressCleaned, xformBase(left));
  
 
  //Concatenating Original & New Records
  dFinal := dNewRecordsClean + dExistingRecords;
  //Sequence internetservices_id
  ut.MAC_Sequence_Records_NewRec(dFinal,Layouts.layout_base,internetservices_id,dInternetServicesSeq);
  //Sequence source_rec_id
  ut.MAC_Append_Rcid (dInternetServicesSeq,source_rec_id,dFinalSeq);

  PromoteSupers.MAC_SF_BuildProcess(dFinalSeq,constants.Base_Domains, writefile);

 RETURN writefile;

END;
