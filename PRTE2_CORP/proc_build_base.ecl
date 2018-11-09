IMPORT  UT, PromoteSupers, std, Prte2, PRTE2_Corp, Address, AID, AID_Support;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

 

  //corp file
  d_corp_in := PROJECT(PRTE2_Corp.Files.corp2_corp_IN, 
                             TRANSFORM(Layouts.Corp_Base_Layout, 
                                       SElF := LEFT, 
                                       SELF := []
                                       )
                             ); 
  //uppercase and remove spaces from in file
  PRTE2.CleanFields(d_corp_in, d_corp_InClean);
  //Sequence records
  ut.MAC_Append_Rcid (d_corp_InClean,source_rec_id,d_corp_InCleanSeq); 
  
   //cont file
  d_cont_in := PROJECT(PRTE2_Corp.Files.corp2_cont_IN, 
                             TRANSFORM(Layouts.Cont_Base_Layout, 
                                       SElF := LEFT, 
                                       SELF := []
                                       )
                             ); 
  //uppercase and remove spaces from in file
  PRTE2.CleanFields(d_cont_in, d_cont_InClean);
  //Sequence records
  ut.MAC_Append_Rcid (d_cont_InClean,append_row_id,d_cont_InCleanSeq); 
  
  //put all addresses in one file for cleaning
  d_corp_addr := PROJECT(d_corp_InCleanSeq(cust_name <> ''), 
                             TRANSFORM(Layouts.temp_address_layout,
                                       SELF.corp_row_id := LEFT.source_rec_id;
                                       SElF := LEFT; 
                                       SELF := []
                                       )
                             ); 
    
  d_cont_addr := PROJECT(d_cont_InCleanSeq(cust_name <> ''), 
                             TRANSFORM(Layouts.temp_address_layout,
                                       SELF.cont_row_id := LEFT.append_row_id;
                                       SElF := LEFT; 
                                       SELF := []
                                       )
                             ); 
                             
  d_all_addr := d_corp_addr + d_cont_addr;
  
  //Address Cleaning
  d_all_addr_cleaned := PRTE2.AddressCleaner(d_all_addr,   
                                            ['corp_address1_line1', 'corp_address2_line1', 'corp_ra_address_line1', 'cont_address_line1'],
                                            ['corp_address1_line2', 'corp_address2_line2', 'corp_ra_address_line2', 'cont_address_line2'],
                                            [],
                                            [],
                                            [],
                                            ['corp_address1', 'corp_address2', 'corp_ra_address', 'cont_address'],
                                            ['corp_address1_rawaid', 'corp_address2_rawaid', 'corp_ra_address_rawaid', 'cont_address_rawaid']);
                                            
  
  //corp - Splitting New & Old Records
  d_corp_OldRecords := d_corp_InCleanSeq(cust_name = '' AND corp_key <> '');
  d_corp_NewRecords	:= d_corp_InCleanSeq(cust_name <> '' AND corp_key <> '');  

  //corp file - transforming addresses and generating bdid and linkid
  d_corp_NewRecordsClean := JOIN(d_all_addr_cleaned,
                                 d_corp_NewRecords, 
                                 LEFT.corp_row_id = RIGHT.source_rec_id,
                                 TRANSFORM( Layouts.Corp_Base_Layout,
                                            //move clean addresses to the correct fields
                                            SELF.corp_addr1_prim_range  :=  LEFT.corp_address1.prim_range;
                                            SELF.corp_addr1_predir      :=  LEFT.corp_address1.predir;
                                            SELF.corp_addr1_prim_name   :=  LEFT.corp_address1.prim_name;
                                            SELF.corp_addr1_addr_suffix :=  LEFT.corp_address1.addr_suffix;
                                            SELF.corp_addr1_postdir     :=  LEFT.corp_address1.postdir;
                                            SELF.corp_addr1_unit_desig  :=  LEFT.corp_address1.unit_desig;
                                            SELF.corp_addr1_sec_range   :=  LEFT.corp_address1.sec_range;
                                            SELF.corp_addr1_p_city_name :=  LEFT.corp_address1.p_city_name;
                                            SELF.corp_addr1_v_city_name :=  LEFT.corp_address1.v_city_name;
                                            SELF.corp_addr1_state       :=  LEFT.corp_address1.st;
                                            SELF.corp_addr1_zip5        :=  LEFT.corp_address1.zip;
                                            SELF.corp_addr1_zip4	      :=	LEFT.corp_address1.zip4;
                                            SELF.corp_addr1_cart	      :=	LEFT.corp_address1.cart;
                                            SELF.corp_addr1_cr_sort_sz	:=	LEFT.corp_address1.cr_sort_sz;
                                            SELF.corp_addr1_lot	        :=	LEFT.corp_address1.lot;
                                            SELF.corp_addr1_lot_order	  :=	LEFT.corp_address1.lot_order;
                                            SELF.corp_addr1_dpbc	      :=	LEFT.corp_address1.dbpc;
                                            SELF.corp_addr1_chk_digit	  :=	LEFT.corp_address1.chk_digit;
                                            SELF.corp_addr1_rec_type	  :=	LEFT.corp_address1.rec_type;
                                            SELF.corp_addr1_ace_fips_st	:=	LEFT.corp_address1.fips_state;
                                            SELF.corp_addr1_county	    :=	LEFT.corp_address1.fips_county;
                                            SELF.corp_addr1_geo_lat	    :=	LEFT.corp_address1.geo_lat;
                                            SELF.corp_addr1_geo_long	  :=	LEFT.corp_address1.geo_long;
                                            SELF.corp_addr1_msa	        :=	LEFT.corp_address1.msa;
                                            SELF.corp_addr1_geo_blk	    :=	LEFT.corp_address1.geo_blk;
                                            SELF.corp_addr1_geo_match	  :=	LEFT.corp_address1.geo_match;
                                            SELF.corp_addr1_err_stat	  :=	LEFT.corp_address1.err_stat;
                                            SELF.append_addr1_rawaid    :=  LEFT.corp_address1_rawaid;
                                            
                                            SELF.corp_addr2_prim_range  :=  LEFT.corp_address2.prim_range;
                                            SELF.corp_addr2_predir      :=  LEFT.corp_address2.predir;
                                            SELF.corp_addr2_prim_name   :=  LEFT.corp_address2.prim_name;
                                            SELF.corp_addr2_addr_suffix :=  LEFT.corp_address2.addr_suffix;
                                            SELF.corp_addr2_postdir     :=  LEFT.corp_address2.postdir;
                                            SELF.corp_addr2_unit_desig  :=  LEFT.corp_address2.unit_desig;
                                            SELF.corp_addr2_sec_range   :=  LEFT.corp_address2.sec_range;
                                            SELF.corp_addr2_p_city_name :=  LEFT.corp_address2.p_city_name;
                                            SELF.corp_addr2_v_city_name :=  LEFT.corp_address2.v_city_name;
                                            SELF.corp_addr2_state       :=  LEFT.corp_address2.st;
                                            SELF.corp_addr2_zip5        :=  LEFT.corp_address2.zip;
                                            SELF.corp_addr2_zip4	      :=	LEFT.corp_address2.zip4;
                                            SELF.corp_addr2_cart	      :=	LEFT.corp_address2.cart;
                                            SELF.corp_addr2_cr_sort_sz	:=	LEFT.corp_address2.cr_sort_sz;
                                            SELF.corp_addr2_lot	        :=	LEFT.corp_address2.lot;
                                            SELF.corp_addr2_lot_order	  :=	LEFT.corp_address2.lot_order;
                                            SELF.corp_addr2_dpbc	      :=	LEFT.corp_address2.dbpc;
                                            SELF.corp_addr2_chk_digit	  :=	LEFT.corp_address2.chk_digit;
                                            SELF.corp_addr2_rec_type	  :=	LEFT.corp_address2.rec_type;
                                            SELF.corp_addr2_ace_fips_st	:=	LEFT.corp_address2.fips_state;
                                            SELF.corp_addr2_county	    :=	LEFT.corp_address2.fips_county;
                                            SELF.corp_addr2_geo_lat	    :=	LEFT.corp_address2.geo_lat;
                                            SELF.corp_addr2_geo_long	  :=	LEFT.corp_address2.geo_long;
                                            SELF.corp_addr2_msa	        :=	LEFT.corp_address2.msa;
                                            SELF.corp_addr2_geo_blk	    :=	LEFT.corp_address2.geo_blk;
                                            SELF.corp_addr2_geo_match	  :=	LEFT.corp_address2.geo_match;
                                            SELF.corp_addr2_err_stat	  :=	LEFT.corp_address2.err_stat;
                                            SELF.append_addr2_rawaid    :=  LEFT.corp_address2_rawaid;

                                            SELF.corp_ra_prim_range   :=  LEFT.corp_ra_address.prim_range;
                                            SELF.corp_ra_predir       :=  LEFT.corp_ra_address.predir;
                                            SELF.corp_ra_prim_name    :=  LEFT.corp_ra_address.prim_name;
                                            SELF.corp_ra_addr_suffix  :=  LEFT.corp_ra_address.addr_suffix;
                                            SELF.corp_ra_postdir      :=  LEFT.corp_ra_address.postdir;
                                            SELF.corp_ra_unit_desig   :=  LEFT.corp_ra_address.unit_desig;
                                            SELF.corp_ra_sec_range    :=  LEFT.corp_ra_address.sec_range;
                                            SELF.corp_ra_p_city_name  :=  LEFT.corp_ra_address.p_city_name;
                                            SELF.corp_ra_v_city_name  :=  LEFT.corp_ra_address.v_city_name;
                                            SELF.corp_ra_state        :=  LEFT.corp_ra_address.st;
                                            SELF.corp_ra_zip5         :=  LEFT.corp_ra_address.zip;
                                            SELF.corp_ra_zip4	        :=	LEFT.corp_ra_address.zip4;
                                            SELF.corp_ra_cart	        :=	LEFT.corp_ra_address.cart;
                                            SELF.corp_ra_cr_sort_sz	  :=	LEFT.corp_ra_address.cr_sort_sz;
                                            SELF.corp_ra_lot	        :=	LEFT.corp_ra_address.lot;
                                            SELF.corp_ra_lot_order	  :=	LEFT.corp_ra_address.lot_order;
                                            SELF.corp_ra_dpbc	        :=	LEFT.corp_ra_address.dbpc;
                                            SELF.corp_ra_chk_digit	  :=	LEFT.corp_ra_address.chk_digit;
                                            SELF.corp_ra_rec_type	    :=	LEFT.corp_ra_address.rec_type;
                                            SELF.corp_ra_ace_fips_st	:=	LEFT.corp_ra_address.fips_state;
                                            SELF.corp_ra_county	      :=	LEFT.corp_ra_address.fips_county;
                                            SELF.corp_ra_geo_lat	    :=	LEFT.corp_ra_address.geo_lat;
                                            SELF.corp_ra_geo_long	    :=	LEFT.corp_ra_address.geo_long;
                                            SELF.corp_ra_msa	        :=	LEFT.corp_ra_address.msa;
                                            SELF.corp_ra_geo_blk	    :=	LEFT.corp_ra_address.geo_blk;
                                            SELF.corp_ra_geo_match	  :=	LEFT.corp_ra_address.geo_match;
                                            SELF.corp_ra_err_stat	    :=	LEFT.corp_ra_address.err_stat;
                                            SELF.append_ra_rawaid     :=  LEFT.corp_ra_address_rawaid;
                                            
                                            //Name cleaning
                                            CleanName					        := Address.CleanPersonFML73_fields(RIGHT.corp_ra_name);
                                            SELF.corp_ra_title1			  := CleanName.title;
                                            SELF.corp_ra_fname1				:= CleanName.fname;
                                            SELF.corp_ra_mname1				:= CleanName.mname;
                                            SELF.corp_ra_lname1				:= CleanName.lname;
                                            SELF.corp_ra_name_suffix1	:= CleanName.name_suffix;
                                            SELF.corp_ra_score1		    := CleanName.name_score;                                            
                                            
                                            SELF.corp_ra_cname1   := RIGHT.corp_legal_name;
                                            
                                            SELF.corp_phone10     := Address.CleanPhone(RIGHT.corp_phone_number);
                                            SELF.corp_ra_phone10  := Address.CleanPhone(RIGHT.corp_ra_phone_number);
                                            
                                            //Append ID(s)
                                            SELF.bdid := prte2.fn_AppendFakeID.bdid(RIGHT.corp_legal_name,	LEFT.corp_address1.prim_range,	LEFT.corp_address1.prim_name, LEFT.corp_address1.v_city_name, LEFT.corp_address1.st, LEFT.corp_address1.zip, RIGHT.cust_name);
                                            //generating linkids
                                            vLinkingIds := prte2.fn_AppendFakeID.LinkIds(RIGHT.corp_legal_name, (string9)RIGHT.link_fein, RIGHT.link_inc_date, LEFT.corp_address1.prim_range, LEFT.corp_address1.prim_name, 
                                                                                         LEFT.corp_address1.sec_range, LEFT.corp_address1.v_city_name, LEFT.corp_address1.st, LEFT.corp_address1.zip, RIGHT.cust_name);
                                        
                                            SELF.powid	:= vLinkingIds.powid;
                                            SELF.proxid	:= vLinkingIds.proxid;
                                            SELF.seleid	:= vLinkingIds.seleid;
                                            SELF.orgid	:= vLinkingIds.orgid;
                                            SELF.ultid	:= vLinkingIds.ultid;	   
                                         
                                            SELF.record_type := 'C';
                                            
                                            SELF := RIGHT;
                                            SELF := [];
                          
                                          )                                  
                                 );
  
  
  //Concatenating Original & New Records
  d_corp_base := d_corp_NewRecordsClean + d_corp_OldRecords;
  
  //corp - Splitting New & Old Records
  d_cont_OldRecords := d_cont_InCleanSeq(cust_name = '' AND corp_key <> '');
  d_cont_NewRecords	:= d_cont_InCleanSeq(cust_name <> '' AND corp_key <> '');  

  //cont file - transforming addresses, did, clean names
  d_cont_NewRecordsClean := JOIN(d_all_addr_cleaned,
                                 d_cont_NewRecords, 
                                 LEFT.cont_row_id = RIGHT.append_row_id,
                                 TRANSFORM( Layouts.Cont_Base_Layout,
                                            //move clean addresses to the correct fields
                                            SELF.cont_prim_range  :=  LEFT.cont_address.prim_range;
                                            SELF.cont_predir      :=  LEFT.cont_address.predir;
                                            SELF.cont_prim_name   :=  LEFT.cont_address.prim_name;
                                            SELF.cont_addr_suffix :=  LEFT.cont_address.addr_suffix;
                                            SELF.cont_postdir     :=  LEFT.cont_address.postdir;
                                            SELF.cont_unit_desig  :=  LEFT.cont_address.unit_desig;
                                            SELF.cont_sec_range   :=  LEFT.cont_address.sec_range;
                                            SELF.cont_p_city_name :=  LEFT.cont_address.p_city_name;
                                            SELF.cont_v_city_name :=  LEFT.cont_address.v_city_name;
                                            SELF.cont_state       :=  LEFT.cont_address.st;
                                            SELF.cont_zip5        :=  LEFT.cont_address.zip;
                                            SELF.cont_zip4	      :=	LEFT.cont_address.zip4;
                                            SELF.cont_cart	      :=	LEFT.cont_address.cart;
                                            SELF.cont_cr_sort_sz	:=	LEFT.cont_address.cr_sort_sz;
                                            SELF.cont_lot	        :=	LEFT.cont_address.lot;
                                            SELF.cont_lot_order	  :=	LEFT.cont_address.lot_order;
                                            SELF.cont_dpbc	      :=	LEFT.cont_address.dbpc;
                                            SELF.cont_chk_digit	  :=	LEFT.cont_address.chk_digit;
                                            SELF.cont_rec_type	  :=	LEFT.cont_address.rec_type;
                                            SELF.cont_ace_fips_st	:=	LEFT.cont_address.fips_state;
                                            SELF.cont_county	    :=	LEFT.cont_address.fips_county;
                                            SELF.cont_geo_lat	    :=	LEFT.cont_address.geo_lat;
                                            SELF.cont_geo_long	  :=	LEFT.cont_address.geo_long;
                                            SELF.cont_msa	        :=	LEFT.cont_address.msa;
                                            SELF.cont_geo_blk	    :=	LEFT.cont_address.geo_blk;
                                            SELF.cont_geo_match	  :=	LEFT.cont_address.geo_match;
                                            SELF.cont_err_stat	  :=	LEFT.cont_address.err_stat;
                                            SELF.append_cont_addr_rawaid  :=  LEFT.cont_address_rawaid;
                                            
                              
                                            SELF.corp_addr1_prim_range  :=  LEFT.corp_address1.prim_range;
                                            SELF.corp_addr1_predir      :=  LEFT.corp_address1.predir;
                                            SELF.corp_addr1_prim_name   :=  LEFT.corp_address1.prim_name;
                                            SELF.corp_addr1_addr_suffix :=  LEFT.corp_address1.addr_suffix;
                                            SELF.corp_addr1_postdir     :=  LEFT.corp_address1.postdir;
                                            SELF.corp_addr1_unit_desig  :=  LEFT.corp_address1.unit_desig;
                                            SELF.corp_addr1_sec_range   :=  LEFT.corp_address1.sec_range;
                                            SELF.corp_addr1_p_city_name :=  LEFT.corp_address1.p_city_name;
                                            SELF.corp_addr1_v_city_name :=  LEFT.corp_address1.v_city_name;
                                            SELF.corp_addr1_state       :=  LEFT.corp_address1.st;
                                            SELF.corp_addr1_zip5        :=  LEFT.corp_address1.zip;
                                            SELF.corp_addr1_zip4	      :=	LEFT.corp_address1.zip4;
                                            SELF.corp_addr1_cart	      :=	LEFT.corp_address1.cart;
                                            SELF.corp_addr1_cr_sort_sz	:=	LEFT.corp_address1.cr_sort_sz;
                                            SELF.corp_addr1_lot	        :=	LEFT.corp_address1.lot;
                                            SELF.corp_addr1_lot_order	  :=	LEFT.corp_address1.lot_order;
                                            SELF.corp_addr1_dpbc	      :=	LEFT.corp_address1.dbpc;
                                            SELF.corp_addr1_chk_digit	  :=	LEFT.corp_address1.chk_digit;
                                            SELF.corp_addr1_rec_type	  :=	LEFT.corp_address1.rec_type;
                                            SELF.corp_addr1_ace_fips_st	:=	LEFT.corp_address1.fips_state;
                                            SELF.corp_addr1_county	    :=	LEFT.corp_address1.fips_county;
                                            SELF.corp_addr1_geo_lat	    :=	LEFT.corp_address1.geo_lat;
                                            SELF.corp_addr1_geo_long	  :=	LEFT.corp_address1.geo_long;
                                            SELF.corp_addr1_msa	        :=	LEFT.corp_address1.msa;
                                            SELF.corp_addr1_geo_blk	    :=	LEFT.corp_address1.geo_blk;
                                            SELF.corp_addr1_geo_match	  :=	LEFT.corp_address1.geo_match;
                                            SELF.corp_addr1_err_stat	  :=	LEFT.corp_address1.err_stat;
                                            SELF.append_corp_addr_rawaid  :=  LEFT.corp_address1_rawaid;
                                                                              
                                            
                                            //Name cleaning
                                            CleanName					    := Address.CleanPersonFML73_fields(RIGHT.cont_name);
                                            SELF.cont_title			  := CleanName.title;
                                            SELF.cont_fname				:= CleanName.fname;
                                            SELF.cont_mname				:= CleanName.mname;
                                            SELF.cont_lname				:= CleanName.lname;
                                            SELF.cont_name_suffix	:= CleanName.name_suffix;
                                            SELF.cont_score		    := CleanName.name_score;
  
                                            SELF.cont_phone10 := Address.CleanPhone(RIGHT.cont_phone_number);
                                                                                             
                                            SELF.did :=  prte2.fn_AppendFakeID.did(CleanName.fname, CleanName.lname, RIGHT.link_ssn, RIGHT.link_dob, RIGHT.cust_name);
                                         
                                            SELF.record_type := 'C';
                                            
                                            SELF := RIGHT;
                                            SELF := [];
                                          )                                  
                                 );
d_cont_NewRecordsClean2 := JOIN(d_cont_NewRecordsClean,
                             d_corp_NewRecordsClean,
                             LEFT.corp_key=RIGHT.corp_key,
                             TRANSFORM(prte2_Corp.Layouts.cont_Base_Layout,
														               SELF.bdid := RIGHT.bdid,
																					        SELF.powid	:=  RIGHT.powid;
                             SELF.proxid	:= RIGHT.proxid;
                             SELF.seleid	:= RIGHT.seleid;
                             SELF.orgid	:=  RIGHT.orgid;
                             SELF.ultid	:=  RIGHT.ultid;	   
                             SELF := LEFT));

   
  //Concatenating Original & New Records
  d_cont_base := d_cont_NewRecordsClean2 + d_cont_OldRecords; 
 
 
  //event file
  d_event_in := PROJECT(PRTE2_Corp.Files.corp2_event_IN, 
                             TRANSFORM(Layouts.Event_Base_Layout, 
                                       SElF := LEFT, 
                                       SELF := []
                                       )
                             ); 
                             
  //uppercase and remove spaces from in file
  PRTE2.CleanFields(d_event_in, d_event_InClean);
  
  //Splitting New & Old Records
  d_event_OldRecords := d_event_InClean(cust_name = '' AND corp_key <> '');
  
  //assign bdid from matching corp records to the new event records
  d_event_NewRecords := JOIN(d_event_InClean(cust_name <> '' AND corp_key <> ''),
                             d_corp_Base,
                             LEFT.corp_key=RIGHT.corp_key,
                             TRANSFORM(Layouts.Event_Base_Layout,SELF.bdid := RIGHT.bdid, SELF.record_type := 'C', SELF := LEFT));


  //Concatenating Original & New Records
  d_event_Base := d_event_NewRecords + d_event_OldRecords;
  
  
   //stock file
  d_stock_in := PROJECT(PRTE2_Corp.Files.corp2_stock_IN, 
                             TRANSFORM(Layouts.stock_Base_Layout, 
                                       SElF := LEFT, 
                                       SELF := []
                                       )
                             ); 
                             
  //uppercase and remove spaces from in file
  PRTE2.CleanFields(d_stock_in, d_stock_InClean);
  
  //Splitting New & Old Records
  d_stock_OldRecords := d_stock_InClean(cust_name = '' AND corp_key <> '');
  
  //assign bdid from matching corp records to the new stock records
  d_stock_NewRecords := JOIN(d_stock_InClean(cust_name <> '' AND corp_key <> ''),
                             d_corp_Base,
                             LEFT.corp_key=RIGHT.corp_key,
                             TRANSFORM(Layouts.stock_Base_Layout,SELF.bdid := RIGHT.bdid, SELF.record_type := 'C', SELF := LEFT));


  //Concatenating Original & New Records
  d_stock_Base := d_stock_NewRecords + d_stock_OldRecords;  

   //ar file
  d_ar_in := PROJECT(PRTE2_Corp.Files.corp2_ar_IN, 
                             TRANSFORM(Layouts.AR_Base_Layout, 
                                       SElF := LEFT, 
                                       SELF := []
                                       )
                             ); 
                             
  //uppercase and remove spaces from in file
  PRTE2.CleanFields(d_ar_in, d_ar_InClean);
  
  //Splitting New & Old Records
  d_ar_OldRecords := d_ar_InClean(cust_name = '' AND corp_key <> '');
  
  //assign bdid from matching corp records to the new ar records
  d_ar_NewRecords := JOIN(d_ar_InClean(cust_name <> '' AND corp_key <> ''),
                             d_corp_Base,
                             LEFT.corp_key=RIGHT.corp_key,
                             TRANSFORM(Layouts.AR_Base_Layout,SELF.bdid := RIGHT.bdid, SELF.record_type := 'C', SELF := LEFT));


  //Concatenating Original & New Records
  d_ar_Base := d_ar_NewRecords + d_ar_OldRecords;
    
  PromoteSupers.MAC_SF_BuildProcess(d_corp_Base,constants.Base_Corp2_corp, writefile_corp,,,,filedate);
  PromoteSupers.MAC_SF_BuildProcess(d_cont_Base,constants.Base_Corp2_cont, writefile_cont,,,,filedate);  
  PromoteSupers.MAC_SF_BuildProcess(d_ar_Base,constants.Base_Corp2_AR, writefile_AR,,,,filedate);
  PromoteSupers.MAC_SF_BuildProcess(d_event_Base,constants.Base_Corp2_event, writefile_event,,,,filedate);
  PromoteSupers.MAC_SF_BuildProcess(d_stock_Base,constants.Base_Corp2_stock, writefile_stock,,,,filedate);
  
  RETURN SEQUENTIAL(writefile_corp, writefile_cont, writefile_AR, writefile_event, writefile_stock);

END;