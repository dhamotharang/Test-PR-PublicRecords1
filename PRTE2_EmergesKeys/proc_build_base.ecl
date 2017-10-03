IMPORT  PromoteSupers,prte2,std,AID,Address,ut;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

PRTE2.CleanFields(files.CCW_hunting_fishing_IN, in_file);

ds_file := in_file(cust_name != '');

AddressDataSet := PRTE2.AddressCleaner(ds_file,
	 ['resaddr1','mail_addr1'],
	 ['resaddr2','mail_addr2'],
	 ['res_city','mail_city'],
	 ['res_state','mail_state'],
	 ['res_zip','mail_zip'],
	 ['res_address','mail_address'],
   ['res_rawaid','mail_rawaid']);
	 

DS_emerges_out	:=	Project(AddressDataSet,
Transform(Layouts.Hunters_Base_Layout,

FullName	:= ut.CleanSpacesAndUpper(left.fname_in +' '+ left.mname_in +' '+ left.lname_in +
																			IF(left.name_suffix_in <> '', ' '+ left.name_suffix_in,''));


CleanName	:= Address.CleanPersonFML73_fields(FullName);

self.title          			 	   := CleanName.title;
self.fname                     := CleanName.fname;
self.mname          					 := CleanName.mname;        
self.lname            				 := CleanName.lname;
self.name_suffix    			 		 := CleanName.name_suffix;		  
self.score_on_input	   	       := CleanName.name_score;

self.prim_range := left.res_address.prim_range;
self.predir := left.res_address.predir;
self.prim_name := left.res_address.prim_name;
self.suffix := left.res_address.addr_suffix;
self.postdir := left.res_address.postdir;
self.unit_desig := left.res_address.unit_desig;
self.sec_range := left.res_address.sec_range;
self.p_city_name := left.res_address.p_city_name;
self.city_name := left.res_address.v_city_name;
self.st := left.res_address.st;
self.zip := left.res_address.zip;
self.zip4 := left.res_address.zip4;
self.cart := left.res_address.cart;
self.cr_sort_sz := left.res_address.cr_sort_sz;
self.lot := left.res_address.lot;
self.lot_order := left.res_address.lot_order;
self.dpbc := left.res_address.dbpc;
self.chk_digit := left.res_address.chk_digit;
self.record_type := left.res_address.rec_type;
self.ace_fips_st := left.res_address.fips_state;
self.county := left.res_address.fips_county;
self.geo_lat := left.res_address.geo_lat;
self.geo_long := left.res_address.geo_long;
self.msa := left.res_address.msa;
self.geo_blk := left.res_address.geo_blk;
self.geo_match := left.res_address.geo_match;
self.err_stat := left.res_address.err_stat;

self.mail_prim_range := left.mail_address.prim_range;
self.mail_predir := left.mail_address.predir;
self.mail_prim_name := left.mail_address.prim_name;
self.mail_addr_suffix := left.mail_address.addr_suffix;
self.mail_postdir := left.mail_address.postdir;
self.mail_unit_desig := left.mail_address.unit_desig;
self.mail_sec_range := left.mail_address.sec_range;
self.mail_p_city_name := left.mail_address.p_city_name;
self.mail_v_city_name := left.mail_address.v_city_name;
self.mail_st := left.mail_address.st;
self.mail_zip := left.mail_address.zip;
self.mail_zip4 := left.mail_address.zip4;
self.mail_cart := left.mail_address.cart;
self.mail_cr_sort_sz := left.mail_address.cr_sort_sz;
self.mail_lot := left.mail_address.lot;
self.mail_lot_order := left.mail_address.lot_order;
self.mail_dpbc := left.mail_address.dbpc;
self.mail_chk_digit := left.mail_address.chk_digit;
self.mail_record_type := left.mail_address.rec_type;
self.mail_ace_fips_st := left.mail_address.fips_state;
self.mail_fipscounty := left.mail_address.fips_county;
self.mail_geo_lat := left.mail_address.geo_lat;
self.mail_geo_long := left.mail_address.geo_long;
self.mail_msa := left.mail_address.msa;
self.mail_geo_blk := left.mail_address.geo_blk;
self.mail_geo_match := left.mail_address.geo_match;
self.mail_err_stat := left.mail_address.err_stat;

SELF.did :=  prte2.fn_AppendFakeID.did(self.fname, self.lname, left.link_ssn, left.link_dob, left.cust_name);

self.persistent_record_id := HASH64(
left.best_ssn
+left.source_state
+left.source_code
+left.file_acquired_date
+left._use
+left.title_in
+left.lname_in
+left.fname_in
+left.mname_in
+left.maiden_prior
+left.name_suffix_in
+left.votefiller
+left.dob
+left.maiden_name
+left.regdate
+left.race
+left.gender
+left.poliparty
+left.phone
+left.work_phone
+left.active_status
+left.votefiller2
+left.voterstatus
+left.resaddr1
+left.resaddr2
+left.res_city
+left.res_state
+left.res_zip
+left.res_county
+left.mail_addr1
+left.mail_addr2
+left.mail_city
+left.mail_state
+left.mail_zip
+left.mail_county
+left.historyfiller
+left.huntfishperm
+left.license_type_mapped
+left.datelicense
+left.homestate
+left.resident
+left.nonresident
+left.hunt
+left.fish
+left.combosuper
+left.sportsman
+left.trap
+left.archery
+left.muzzle
+left.drawing
+left.day1
+left.day3
+left.day7
+left.day14to15
+left.dayfiller
+left.seasonannual
+left.lifetimepermit
+left.landowner
+left.family
+left.junior
+left.seniorcit
+left.crewmemeber
+left.retarded
+left.indian
+left.serviceman
+left.disabled
+left.lowincome
+left.regioncounty
+left.blind
+left.huntfiller
+left.freshwater
+left.saltwater
+left.lakesandresevoirs
+left.setlinefish
+left.fallfishing
+left.snowmobile
+left.biggame
+left.smallgame
+left.gun
+left.bonus
+left.lottery
+left.huntfill1
+left.PreyType
);
self:=LEFT; 
self:=[];
));

df_hunting_fishing_old := PROJECT(Files.CCW_hunting_fishing_IN(cust_name = ''), layouts.Hunters_Base_Layout);

df_hunting_fishing := df_hunting_fishing_old + DS_emerges_out;

df_ccw := PROJECT(Files.CCW_IN, layouts.CCW_Base_Layout);

PromoteSupers.MAC_SF_BuildProcess(df_hunting_fishing,constants.Base_Hunters, writefile_hunting_fishing);

PromoteSupers.MAC_SF_BuildProcess(df_ccw,constants.Base_CCW, writefile_ccw);

sequential(writefile_hunting_fishing,writefile_ccw);

Return 'success';
END;