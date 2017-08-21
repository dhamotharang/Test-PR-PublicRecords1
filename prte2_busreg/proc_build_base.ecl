IMPORT  prte2_busreg,PromoteSupers,busreg,prte2,std,AID,Address,ut;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION
In_file := prte2_busreg.files.DS_busreg_ext(cust_name != '');
   AddressDataSet := PRTE2.AddressCleaner(in_file,
	 ['ofc1_add','ra_add','mail_add','loc_add','ofc2_add','ofc3_add','ofc4_add','ofc5_add','ofc6_add'],
   ['ofc1_addr_2','ra_addr_2','mail_addr_2','loc_addr_2','ofc2_addr_2','ofc3_addr_2','ofc4_addr_2','ofc5_addr_2','ofc6_addr_2'],
   ['ofc1_city','ra_city', 'mail_city','loc_city','ofc2_city','ofc3_city','ofc4_city','ofc5_city','ofc6_city'],
   ['ofc1_state','ra_state', 'mail_state','loc_state','ofc2_state','ofc3_state','ofc4_state','ofc5_state','ofc6_state'],
   ['ofc1_zip_orig','ra_zip_orig','mail_zip_orig','loc_zip_orig','ofc2_zip','ofc3_zip','ofc4_zip','ofc5_zip','ofc6_zip'],
   ['ofc1_address','ra_address','mail_address','loc_address','ofc2_address','ofc3_address','ofc4_address','ofc5_address','ofc6_address'],
   ['ofc1_rawaid','ra_rawaid','mail_rawaid','loc_rawaid','ofc2_rawaid','ofc3_rawaid','ofc4_rawaid','ofc5_rawaid','ofc6_rawaid']) ;

 
DS_busreg_out	:=	Project(AddressDataSet,
Transform(Layouts.Layout_In_ext,
string73 tempname              :=ut.CleanSpacesAndUpper(left.ofc1_name);
pname                          := Address.CleanPersonFML73_fields(tempName);
self.ofc1_name_prefix			 	   := pname.title;
self.ofc1_name_first 					 := pname.fname;        
self.ofc1_name_middle 				 := pname.mname;
self.ofc1_name_last 			 		 := pname.lname;		  
self.ofc1_name_suffix 			   := pname.name_suffix;
self.ofc1_name_score			   	 := pname.name_score;
self.ofc1_prim_range := left.ofc1_address.prim_range;
self.ofc1_predir := left.ofc1_address.predir;
self.ofc1_prim_name := left.ofc1_address.prim_name;
self.ofc1_addr_suffix := left.ofc1_address.addr_suffix;
self.ofc1_postdir := left.ofc1_address.postdir;
self.ofc1_unit_desig := left.ofc1_address.unit_desig;
self.ofc1_sec_range := left.ofc1_address.sec_range;
self.ofc1_p_city_name := left.ofc1_address.p_city_name;
self.ofc1_v_city_name := left.ofc1_address.v_city_name;
self.ofc1_st := left.ofc1_address.st;
self.ofc1_zip := left.ofc1_address.zip;
self.ofc1_zip4 := left.ofc1_address.zip4;
self.ofc1_cart := left.ofc1_address.cart;
self.ofc1_cr_sort_sz := left.ofc1_address.cr_sort_sz;
self.ofc1_lot := left.ofc1_address.lot;
self.ofc1_lot_order := left.ofc1_address.lot_order;
self.ofc1_dpbc := left.ofc1_address.dbpc;
self.ofc1_chk_digit := left.ofc1_address.chk_digit;
self.ofc1_record_type := left.ofc1_address.rec_type;
self.ofc1_ace_fips_st := left.ofc1_address.fips_state;
self.ofc1_fipscounty := left.ofc1_address.fips_county;
self.ofc1_geo_lat := left.ofc1_address.geo_lat;
self.ofc1_geo_long := left.ofc1_address.geo_long;
self.ofc1_msa := left.ofc1_address.msa;
self.ofc1_geo_blk := left.ofc1_address.geo_blk;
self.ofc1_geo_match := left.ofc1_address.geo_match;
self.ofc1_err_stat := left.ofc1_address.err_stat;


//RA
self.ra_prim_range := left.ra_address.prim_range;
self.ra_predir :=     left.ra_address.predir;
self.ra_prim_name :=  left.ra_address.prim_name;
self.ra_addr_suffix := left.ra_address.addr_suffix;
self.ra_postdir :=     left.ra_address.postdir;
self.ra_unit_desig :=  left.ra_address.unit_desig;
self.ra_sec_range :=   left.ra_address.sec_range;
self.ra_p_city_name := left.ra_address.p_city_name;
self.ra_v_city_name := left.ra_address.v_city_name;
self.ra_st :=          left.ra_address.st;
self.ra_zip :=         left.ra_address.zip;
self.ra_zip4 :=        left.ra_address.zip4;
self.ra_cart :=        left.ra_address.cart;
self.ra_cr_sort_sz :=  left.ra_address.cr_sort_sz;
self.ra_lot :=         left.ra_address.lot;
self.ra_lot_order :=   left.ra_address.lot_order;
self.ra_dpbc :=        left.ra_address.dbpc;
self.ra_chk_digit :=   left.ra_address.chk_digit;
self.ra_record_type := left.ra_address.rec_type;
self.ra_ace_fips_st := left.ra_address.fips_state;
self.ra_fipscounty :=  left.ra_address.fips_county;
self.ra_geo_lat :=     left.ra_address.geo_lat;
self.ra_geo_long :=    left.ra_address.geo_long;
self.ra_msa :=         left.ra_address.msa;
self.ra_geo_blk :=     left.ra_address.geo_blk;
self.ra_geo_match :=   left.ra_address.geo_match;
self.ra_err_stat :=    left.ra_address.err_stat;


//MAIL
self.Company_Name   :=ut.CleanSpacesAndUpper(left.Company_Name);
self.mail_prim_range := left.mail_address.prim_range;
self.mail_predir :=     left.mail_address.predir;
self.mail_prim_name :=  left.mail_address.prim_name;
self.mail_addr_suffix := left.mail_address.addr_suffix;
self.mail_postdir :=     left.mail_address.postdir;
self.mail_unit_desig :=  left.mail_address.unit_desig;
self.mail_sec_range :=   left.mail_address.sec_range;
self.mail_p_city_name := left.mail_address.p_city_name;
self.mail_v_city_name := left.mail_address.v_city_name;
self.mail_st :=          left.mail_address.st;
self.mail_zip :=         left.mail_address.zip;
self.mail_zip4 :=        left.mail_address.zip4;
self.mail_cart :=        left.mail_address.cart;
self.mail_cr_sort_sz :=  left.mail_address.cr_sort_sz;
self.mail_lot :=         left.mail_address.lot;
self.mail_lot_order :=   left.mail_address.lot_order;
self.mail_dpbc :=        left.mail_address.dbpc;
self.mail_chk_digit :=   left.mail_address.chk_digit;
self.mail_record_type := left.mail_address.rec_type;
self.mail_ace_fips_st := left.mail_address.fips_state;
self.mail_fipscounty :=  left.mail_address.fips_county;
self.mail_geo_lat :=     left.mail_address.geo_lat;
self.mail_geo_long :=    left.mail_address.geo_long;
self.mail_msa :=         left.mail_address.msa;
self.mail_geo_blk :=     left.mail_address.geo_blk;
self.mail_geo_match :=   left.mail_address.geo_match;
self.mail_err_stat :=    left.mail_address.err_stat;

//LOC
 self.loc_prim_range := left.loc_address.prim_range;
 self.loc_predir :=     left.loc_address.predir;
 self.loc_prim_name :=  left.loc_address.prim_name;
 self.loc_addr_suffix := left.loc_address.addr_suffix;
 self.loc_postdir :=     left.loc_address.postdir;
 self.loc_unit_desig :=  left.loc_address.unit_desig;
 self.loc_sec_range :=   left.loc_address.sec_range;
 self.loc_p_city_name := left.loc_address.p_city_name;
 self.loc_v_city_name := left.loc_address.v_city_name;
 self.loc_st :=          left.loc_address.st;
 self.loc_zip :=         left.loc_address.zip;
 self.loc_zip4 :=        left.loc_address.zip4;
 self.loc_cart :=        left.loc_address.cart;
 self.loc_cr_sort_sz :=  left.loc_address.cr_sort_sz;
 self.loc_lot :=         left.loc_address.lot;
 self.loc_lot_order :=   left.loc_address.lot_order;
 self.loc_dpbc :=        left.loc_address.dbpc;
 self.loc_chk_digit :=   left.loc_address.chk_digit;
 self.loc_record_type := left.loc_address.rec_type;
 self.loc_ace_fips_st := left.loc_address.fips_state;
 self.loc_fipscounty :=  left.loc_address.fips_county;
 self.loc_geo_lat :=     left.loc_address.geo_lat;
 self.loc_geo_long :=    left.loc_address.geo_long;
 self.loc_msa :=         left.loc_address.msa;
 self.loc_geo_blk :=     left.loc_address.geo_blk;
 self.loc_geo_match :=   left.loc_address.geo_match;
 self.loc_err_stat :=    left.loc_address.err_stat;
 
 //OFC2
  string73 tempname2                    :=ut.CleanSpacesAndUpper(left.ofc2_name);
  pname2                              	:= Address.CleanPersonFML73_fields(tempName2);
	self.clean_officer2_name_title        := pname2.title;
  self.clean_officer2_name_fname        := pname2.fname;        
  self.clean_officer2_name_mname        := pname2.mname;
  self.clean_officer2_name_lname        := pname2.lname;		  
  self.clean_officer2_name_name_suffix  := pname2.name_suffix;
  self.clean_officer2_name_name_score   := pname2.name_score;
  self.clean_officer2_address_prim_range := left.ofc2_address.prim_range;
  self.clean_officer2_address_predir     := left.ofc2_address.predir;
  self.clean_officer2_address_prim_name :=  left.ofc2_address.prim_name;
	self.clean_officer2_address_addr_suffix :=  left.ofc2_address.addr_suffix;
	self.clean_officer2_address_postdir :=  left.ofc2_address.postdir;
	self.clean_officer2_address_unit_desig :=  left.ofc2_address.unit_desig;
	self.clean_officer2_address_sec_range :=  left.ofc2_address.sec_range;
	self.clean_officer2_address_p_city_name :=  left.ofc2_address.p_city_name;
  self.clean_officer2_address_v_city_name :=  left.ofc2_address.v_city_name;
	self.clean_officer2_address_st :=  left.ofc2_address.st;
	self.clean_officer2_address_zip :=  left.ofc2_address.zip;
	self.clean_officer2_address_zip4 :=  left.ofc2_address.zip4;
	self.clean_officer2_address_cart :=  left.ofc2_address.cart;
	self.clean_officer2_address_cr_sort_sz :=  left.ofc2_address.cr_sort_sz;
	self.clean_officer2_address_lot :=  left.ofc2_address.lot;
	self.clean_officer2_address_lot_order :=  left.ofc2_address.lot_order;
	self.clean_officer2_address_dbpc :=  left.ofc2_address.dbpc;
	self.clean_officer2_address_chk_digit :=  left.ofc2_address.chk_digit;
	self.clean_officer2_address_rec_type :=  left.ofc2_address.rec_type;
	self.clean_officer2_address_fips_state :=  left.ofc2_address.fips_state;
	self.clean_officer2_address_fips_county :=  left.ofc2_address.fips_county;
	self.clean_officer2_address_geo_lat :=  left.ofc2_address.geo_lat;
	self.clean_officer2_address_geo_long :=  left.ofc2_address.geo_long;
	self.clean_officer2_address_msa :=  left.ofc2_address.msa;
	self.clean_officer2_address_geo_blk :=  left.ofc2_address.geo_blk;
	self.clean_officer2_address_geo_match :=  left.ofc2_address.geo_match;
	self.clean_officer2_address_err_stat :=  left.ofc2_address.err_stat;

//OFC3
  string73 tempname3                     :=ut.CleanSpacesAndUpper(left.ofc3_name);
  pname3                                := Address.CleanPersonFML73_fields(tempName3);
	self.clean_officer3_name_title        := pname3.title;
	self.clean_officer3_name_fname        := pname3.fname;        
	self.clean_officer3_name_mname        := pname3.mname;
	self.clean_officer3_name_lname        := pname3.lname;		  
	self.clean_officer3_name_name_suffix  := pname3.name_suffix;
	self.clean_officer3_name_name_score   := pname3.name_score;
  self.clean_officer3_address_prim_range := left.ofc3_address.prim_range;
  self.clean_officer3_address_predir     := left.ofc3_address.predir;
  self.clean_officer3_address_prim_name :=  left.ofc3_address.prim_name;
	self.clean_officer3_address_addr_suffix :=  left.ofc3_address.addr_suffix;
	self.clean_officer3_address_postdir :=  left.ofc3_address.postdir;
	self.clean_officer3_address_unit_desig :=  left.ofc3_address.unit_desig;
	self.clean_officer3_address_sec_range :=  left.ofc3_address.sec_range;
	self.clean_officer3_address_p_city_name :=  left.ofc3_address.p_city_name;
  self.clean_officer3_address_v_city_name :=  left.ofc3_address.v_city_name;
	self.clean_officer3_address_st :=  left.ofc3_address.st;
	self.clean_officer3_address_zip :=  left.ofc3_address.zip;
	self.clean_officer3_address_zip4 :=  left.ofc3_address.zip4;
	self.clean_officer3_address_cart :=  left.ofc3_address.cart;
	self.clean_officer3_address_cr_sort_sz :=  left.ofc3_address.cr_sort_sz;
	self.clean_officer3_address_lot :=  left.ofc3_address.lot;
	self.clean_officer3_address_lot_order :=  left.ofc3_address.lot_order;
	self.clean_officer3_address_dbpc :=  left.ofc3_address.dbpc;
	self.clean_officer3_address_chk_digit :=  left.ofc3_address.chk_digit;
	self.clean_officer3_address_rec_type :=  left.ofc3_address.rec_type;
	self.clean_officer3_address_fips_state :=  left.ofc3_address.fips_state;
	self.clean_officer3_address_fips_county :=  left.ofc3_address.fips_county;
	self.clean_officer3_address_geo_lat :=  left.ofc3_address.geo_lat;
	self.clean_officer3_address_geo_long :=  left.ofc3_address.geo_long;
	self.clean_officer3_address_msa :=  left.ofc3_address.msa;
	self.clean_officer3_address_geo_blk :=  left.ofc3_address.geo_blk;
	self.clean_officer3_address_geo_match :=  left.ofc3_address.geo_match;
	self.clean_officer3_address_err_stat :=  left.ofc3_address.err_stat;

//OFC4
 string73 tempname4                     :=ut.CleanSpacesAndUpper(left.ofc4_name);
	pname4                                := Address.CleanPersonFML73_fields(tempName4);
	self.clean_officer4_name_title        := pname4.title;
	self.clean_officer4_name_fname        := pname4.fname;        
	self.clean_officer4_name_mname        := pname4.mname;
	self.clean_officer4_name_lname        := pname4.lname;		  
	self.clean_officer4_name_name_suffix  := pname4.name_suffix;
	self.clean_officer4_name_name_score   := pname4.name_score;
  self.clean_officer4_address_prim_range := left.ofc4_address.prim_range;
  self.clean_officer4_address_predir     := left.ofc4_address.predir;
  self.clean_officer4_address_prim_name :=  left.ofc4_address.prim_name;
	self.clean_officer4_address_addr_suffix :=  left.ofc4_address.addr_suffix;
	self.clean_officer4_address_postdir :=  left.ofc4_address.postdir;
	self.clean_officer4_address_unit_desig :=  left.ofc4_address.unit_desig;
	self.clean_officer4_address_sec_range :=  left.ofc4_address.sec_range;
	self.clean_officer4_address_p_city_name :=  left.ofc4_address.p_city_name;
  self.clean_officer4_address_v_city_name :=  left.ofc4_address.v_city_name;
	self.clean_officer4_address_st :=  left.ofc4_address.st;
	self.clean_officer4_address_zip :=  left.ofc4_address.zip;
	self.clean_officer4_address_zip4 :=  left.ofc4_address.zip4;
	self.clean_officer4_address_cart :=  left.ofc4_address.cart;
	self.clean_officer4_address_cr_sort_sz :=  left.ofc4_address.cr_sort_sz;
	self.clean_officer4_address_lot :=  left.ofc4_address.lot;
	self.clean_officer4_address_lot_order :=  left.ofc4_address.lot_order;
	self.clean_officer4_address_dbpc :=  left.ofc4_address.dbpc;
	self.clean_officer4_address_chk_digit :=  left.ofc4_address.chk_digit;
	self.clean_officer4_address_rec_type :=  left.ofc4_address.rec_type;
	self.clean_officer4_address_fips_state :=  left.ofc4_address.fips_state;
	self.clean_officer4_address_fips_county :=  left.ofc4_address.fips_county;
	self.clean_officer4_address_geo_lat :=  left.ofc4_address.geo_lat;
	self.clean_officer4_address_geo_long :=  left.ofc4_address.geo_long;
	self.clean_officer4_address_msa :=  left.ofc4_address.msa;
	self.clean_officer4_address_geo_blk :=  left.ofc4_address.geo_blk;
	self.clean_officer4_address_geo_match :=  left.ofc4_address.geo_match;
	self.clean_officer4_address_err_stat :=  left.ofc4_address.err_stat;

//OFC5
 string73 tempname5                     :=ut.CleanSpacesAndUpper(left.ofc5_name);
	pname5                                := Address.CleanPersonFML73_fields(tempName5);
	self.clean_officer5_name_title        := pname5.title;
	self.clean_officer5_name_fname        := pname5.fname;        
	self.clean_officer5_name_mname        := pname5.mname;
	self.clean_officer5_name_lname        := pname5.lname;		  
	self.clean_officer5_name_name_suffix  := pname5.name_suffix;
	self.clean_officer5_name_name_score   := pname5.name_score;
  self.clean_officer5_address_prim_range := left.ofc5_address.prim_range;
  self.clean_officer5_address_predir     := left.ofc5_address.predir;
  self.clean_officer5_address_prim_name :=  left.ofc5_address.prim_name;
	self.clean_officer5_address_addr_suffix :=  left.ofc5_address.addr_suffix;
	self.clean_officer5_address_postdir :=  left.ofc5_address.postdir;
	self.clean_officer5_address_unit_desig :=  left.ofc5_address.unit_desig;
	self.clean_officer5_address_sec_range :=  left.ofc5_address.sec_range;
	self.clean_officer5_address_p_city_name :=  left.ofc5_address.p_city_name;
  self.clean_officer5_address_v_city_name :=  left.ofc5_address.v_city_name;
	self.clean_officer5_address_st :=  left.ofc5_address.st;
	self.clean_officer5_address_zip :=  left.ofc5_address.zip;
	self.clean_officer5_address_zip4 :=  left.ofc5_address.zip4;
	self.clean_officer5_address_cart :=  left.ofc5_address.cart;
	self.clean_officer5_address_cr_sort_sz :=  left.ofc5_address.cr_sort_sz;
	self.clean_officer5_address_lot :=  left.ofc5_address.lot;
	self.clean_officer5_address_lot_order :=  left.ofc5_address.lot_order;
	self.clean_officer5_address_dbpc :=  left.ofc5_address.dbpc;
	self.clean_officer5_address_chk_digit :=  left.ofc5_address.chk_digit;
	self.clean_officer5_address_rec_type :=  left.ofc5_address.rec_type;
	self.clean_officer5_address_fips_state :=  left.ofc5_address.fips_state;
	self.clean_officer5_address_fips_county :=  left.ofc5_address.fips_county;
	self.clean_officer5_address_geo_lat :=  left.ofc5_address.geo_lat;
	self.clean_officer5_address_geo_long :=  left.ofc5_address.geo_long;
	self.clean_officer5_address_msa :=  left.ofc5_address.msa;
	self.clean_officer5_address_geo_blk :=  left.ofc5_address.geo_blk;
	self.clean_officer5_address_geo_match :=  left.ofc5_address.geo_match;
	self.clean_officer5_address_err_stat :=  left.ofc5_address.err_stat;
	
	//OFC6
	string73 tempname6                     :=ut.CleanSpacesAndUpper(left.ofc6_name);
	pname6                                := Address.CleanPersonFML73_fields(tempName6);
	self.clean_officer6_name_title        := pname6.title;
	self.clean_officer6_name_fname        := pname6.fname;        
	self.clean_officer6_name_mname        := pname6.mname;
	self.clean_officer6_name_lname        := pname6.lname;		  
	self.clean_officer6_name_name_suffix  := pname6.name_suffix;
	self.clean_officer6_name_name_score   := pname6.name_score;
  self.clean_officer6_address_prim_range := left.ofc6_address.prim_range;
  self.clean_officer6_address_predir     := left.ofc6_address.predir;
  self.clean_officer6_address_prim_name :=  left.ofc6_address.prim_name;
	self.clean_officer6_address_addr_suffix :=  left.ofc6_address.addr_suffix;
	self.clean_officer6_address_postdir :=  left.ofc6_address.postdir;
	self.clean_officer6_address_unit_desig :=  left.ofc6_address.unit_desig;
	self.clean_officer6_address_sec_range :=  left.ofc6_address.sec_range;
	self.clean_officer6_address_p_city_name :=  left.ofc6_address.p_city_name;
  self.clean_officer6_address_v_city_name :=  left.ofc6_address.v_city_name;
	self.clean_officer6_address_st :=  left.ofc6_address.st;
	self.clean_officer6_address_zip :=  left.ofc6_address.zip;
	self.clean_officer6_address_zip4 :=  left.ofc6_address.zip4;
	self.clean_officer6_address_cart :=  left.ofc6_address.cart;
	self.clean_officer6_address_cr_sort_sz :=  left.ofc6_address.cr_sort_sz;
	self.clean_officer6_address_lot :=  left.ofc6_address.lot;
	self.clean_officer6_address_lot_order :=  left.ofc6_address.lot_order;
	self.clean_officer6_address_dbpc :=  left.ofc6_address.dbpc;
	self.clean_officer6_address_chk_digit :=  left.ofc6_address.chk_digit;
	self.clean_officer6_address_rec_type :=  left.ofc6_address.rec_type;
	self.clean_officer6_address_fips_state :=  left.ofc6_address.fips_state;
	self.clean_officer6_address_fips_county :=  left.ofc6_address.fips_county;
	self.clean_officer6_address_geo_lat :=  left.ofc6_address.geo_lat;
	self.clean_officer6_address_geo_long :=  left.ofc6_address.geo_long;
	self.clean_officer6_address_msa :=  left.ofc6_address.msa;
	self.clean_officer6_address_geo_blk :=  left.ofc6_address.geo_blk;
	self.clean_officer6_address_geo_match :=  left.ofc6_address.geo_match;
	self.clean_officer6_address_err_stat :=  left.ofc6_address.err_stat;

 self.bdid :=  prte2.fn_AppendFakeID.bdid(left.Company_name, self.mail_prim_range, 
									       self.mail_prim_name, self.mail_v_city_name,self.mail_st,self.mail_zip, Left.cust_name);   
	

 vLinkingIds := prte2.fn_AppendFakeID.LinkIds(left.Company_name, Left.link_fein, Left.link_inc_date, 
 									        self.mail_prim_range,self.mail_prim_name, self.mail_sec_range, self.mail_v_city_name,self.mail_st,self.mail_zip, Left.cust_name);
    	
		self.powid  := vLinkingIds.powid;
    self.proxid	:= vLinkingIds.proxid;
    self.seleid	:= vLinkingIds.seleid;
    self.orgid	:= vLinkingIds.orgid;
    self.ultid	:= vLinkingIds.ultid;	

self:=LEFT; 
self:=[];
));
  OldAddressDataSet:= files.busreg_in(cust_name = '');
  NewAddressDataSet:=project(DS_busreg_out,Layouts.Layout_In);
  FullAddressDataSet:=OldAddressDataSet + NewAddressDataSet;

  PromoteSupers.MAC_SF_BuildProcess(FullAddressDataSet,Constants.busreg_base, writefile);

  RETURN writefile;

end;
