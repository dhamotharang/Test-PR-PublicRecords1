IMPORT  UT, PromoteSupers, std, Prte2, PRTE2_Corp, Address, AID, AID_Support,mdr;
PRTE2.CleanFields(files.inquiry_In, inquiry_in_work);

dsCleanFile := PRTE2.AddressCleaner(inquiry_in_work,  
                                      ['person_q_address','bus_q_address'],
                                      ['dummy','dummy2'],
                                      ['person_q_city','bus_q_city'],
                                      ['person_q_state','bus_q_state'],
                                      ['person_q_zip','bus_q_zip'],
                                      ['clean_address_person','clean_address_bus'],
                                      ['addr_rawaid','addr_rawaid2']
                                      );
																			

dsFile	:=	Project(dsCleanFile, Transform(base_layout,
 
self.person_q_fname:= left.person_q_first_name;
self.person_q_mname:= left.person_q_middle_name;
self.person_q_lname:= left.person_q_last_name;
			
			 
self.person_q_prim_range:= left.clean_address_person.prim_range;
self.person_q_predir:= left.clean_address_person.predir;
self.person_q_prim_name:= left.clean_address_person.prim_name;
self.person_q_addr_suffix:= left.clean_address_person.addr_suffix;
self.person_q_postdir:= left.clean_address_person.postdir;
self.person_q_unit_desig:= left.clean_address_person.unit_desig;
self.person_q_sec_range:= left.clean_address_person.sec_range;
self.person_q_v_city_name:= left.clean_address_person.v_city_name;
self.person_q_st:= left.clean_address_person.st;
self.person_q_zip5:= left.clean_address_person.zip;
self.person_q_zip4:= left.clean_address_person.zip4;
self.person_q_addr_rec_type:= left.clean_address_person.rec_type;
self.person_q_fips_state:= left.clean_address_person.fips_state;
self.person_q_fips_county:= left.clean_address_person.fips_county;
self.person_q_geo_lat:= left.clean_address_person.geo_lat;
self.person_q_geo_long:= left.clean_address_person.geo_long;
self.person_q_geo_blk:= left.clean_address_person.geo_blk;
self.person_q_geo_match:= left.clean_address_person.geo_match;
self.person_q_err_stat:= left.clean_address_person.err_stat;

//Bus
self.bus_q10_prim_range:= left.clean_address_bus.prim_range;
self.bus_q2_predir:= left.clean_address_bus.predir;
self.bus_q28_prim_name:= left.clean_address_bus.prim_name;
self.bus_q4_addr_suffix:= left.clean_address_bus.addr_suffix;
self.bus_q2_postdir:= left.clean_address_bus.postdir;
self.bus_q10_unit_desig:= left.clean_address_bus.unit_desig;
self.bus_q8_sec_range:= left.clean_address_bus.sec_range;
self.bus_q25_v_city_name:= left.clean_address_bus.v_city_name;
self.bus_q2_st:= left.clean_address_bus.st;
self.bus_q5_zip5:= left.clean_address_bus.zip;
self.bus_q4_zip4:= left.clean_address_bus.zip4;
self.bus_q2_addr_rec_type:= left.clean_address_bus.rec_type;
self.bus_q2_fips_state:= left.clean_address_bus.fips_state;
self.bus_q3_fips_county:= left.clean_address_bus.fips_county;
self.bus_q10_geo_lat:= left.clean_address_bus.geo_lat;
self.bus_q11_geo_long:= left.clean_address_bus.geo_long;
self.bus_q7_geo_blk:= left.clean_address_bus.geo_blk;
self.bus_q1_geo_match:= left.clean_address_bus.geo_match;
self.bus_q4_err_stat:= left.clean_address_bus.err_stat;

SELF.appended_bdid := if(left.bus_q_cname !='',prte2.fn_AppendFakeID.bdid(left.bus_q_cname,self.bus_q10_prim_range,	self.bus_q28_prim_name, 
                                 self.bus_q25_v_city_name, self.bus_q2_st, self.bus_q5_zip5, left.cust_name),0);
                            
vLinkingIds := prte2.fn_AppendFakeID.LinkIds(left.bus_q_cname, (string9)left.link_fein, left.link_inc_date,self.bus_q10_prim_range, self.bus_q28_prim_name, 
               self.bus_q8_sec_range, self.bus_q25_v_city_name, self.bus_q2_st, self.bus_q5_zip5, left.cust_name);
               SELF.powid	:= if(left.bus_q_cname !='',vLinkingIds.powid,0);
               SELF.proxid	:= if(left.bus_q_cname !='',vLinkingIds.proxid,0);
               SELF.seleid	:= if(left.bus_q_cname !='',vLinkingIds.seleid,0);
               SELF.orgid	:= if(left.bus_q_cname !='',vLinkingIds.orgid,0);
               SELF.ultid	:= if(left.bus_q_cname !='',vLinkingIds.ultid,0);	   
                                         
   self := left;
   self := [];
	 ));
	 
addGlobalSID 	 := mdr.macGetGlobalSID(dsFile,'InquiryTracking_Virtual','','ccpa_global_sid'); 

PromoteSupers.MAC_SF_BuildProcess(addGlobalSID,constants.Base_Inquiry, base_file);
	
Export proc_build_base:=base_file;