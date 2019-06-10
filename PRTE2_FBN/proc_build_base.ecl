IMPORT  PromoteSupers, ut, NID, Address, BIPV2, STD,PRTE2;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

// dMain := files.fbnv2_business_IN;
// dMain_2 := files.fbnv2_contact_IN;

PRTE2.CleanFields(files.fbnv2_business_IN,BusinessCln);
PRTE2.CleanFields(files.fbnv2_contact_IN,ContactCln);


Layouts.Combined_Business_Base_ext ClnMain(BusinessCln L) := TRANSFORM
		// string73 tempname 		 					 := if(trim(L.Bus_name) = '', '',Address.CleanPersonFML73(L.bus_name));
		// pname 							 	 					 := Address.CleanNameFields(tempName);
		// self.title						 					 := pname.title;
		// self.fname 						 					 := pname.fname;        
		// self.mname 						 					 := pname.mname;
		// self.lname 						 					 := pname.lname;		  
		// self.name_suffix 			 					 := pname.name_suffix;
		// self.name_score			   					 := pname.name_score;
		self.bus_name			:= L.bus_name;																		
		TempPAddr					:= Address.CleanAddress182(TRIM(L.BUS_ADDRESS1,left,right),TRIM(L.Bus_city,left,right) + ', '+
																								TRIM(L.Bus_state,left,right) +' '+ TRIM((string)L.Bus_zip,left,right));

		self.prim_range 		:= TempPAddr[1..10];
		self.predir     		:= TempPAddr[11..12];
		self.prim_name			:= TempPAddr[13..40];
		self.addr_suffix		:= TempPAddr[41..44];
		self.postdir				:= TempPAddr[45..46];
		self.unit_desig			:= TempPAddr[47..56];
		self.sec_range			:= TempPAddr[57..64];
		self.p_city_name		:= TempPAddr[65..89];
		self.v_city_name		:= TempPAddr[90..114];
		self.st							:= TempPAddr[115..116];
		ClnZip							:= TempPAddr[117..121];
		self.zip            := IF(trim(ClnZip) = '',(string)L.Bus_zip,ClnZip);
		//self.zip						:= TempPAddr[117..121];
		self.zip4						:= TempPAddr[122..125];
		self.cart						:= TempPAddr[126..129];
		self.cr_sort_sz			:= TempPAddr[130];
		self.lot						:= TempPAddr[131..134];
		self.lot_order			:= TempPAddr[135];
		self.dbpc						:= TempPAddr[136..137];
		self.chk_digit			:= TempPAddr[138];
		self.rec_type				:= TempPAddr[139..140];
		//self.fips_state			:= TempPAddr[141..142];
		self.county					:= TempPAddr[143..145];	
		self.geo_lat				:= TempPAddr[146..155];
		self.geo_long				:= TempPAddr[156..166];
		self.msa						:= TempPAddr[167..170];
		SELF.geo_blk				:= TempPAddr[171..177];
		self.geo_match			:= TempPAddr[178];
		self.err_stat				:= TempPAddr[179..182];
		self.prep_addr_line1			:= Address.Addr1FromComponents(ut.CleanSpacesAndUpper(L.Bus_address1),'','','','','',''); 
		self.prep_addr_line_last	:= Address.Addr2FromComponents(ut.CleanSpacesAndUpper(L.Bus_city),ut.CleanSpacesAndUpper(L.Bus_State),TRIM((string)L.Bus_ZIP,left,right));
    self.bdid                 := prte2.fn_AppendFakeID.bdid(L.link_bus_name, self.prim_range,  self.prim_name,  self.v_city_name,  self.st,  self.zip,  L.cust_name);
		self.global_sid := 0;
    self.record_sid := 0;
		self := L;
		SELF := [];
	END;
	
df_business	:= PROJECT(BusinessCln, ClnMain(left));

ds_business_linkids := project(df_business, transform(layouts.Combined_Business_Base_ext,
																													  self.bdid := prte2.fn_AppendFakeID.bdid(left.link_bus_name, left.prim_range,  left.prim_name,  left.v_city_name,  left.st,  left.zip,  left.cust_name);
		
																															vLinkingIds := Prte2.fn_AppendFakeID.LinkIds(left.link_bus_name, left.link_fein, left.link_inc_date, left.prim_range, left.prim_name, left.sec_range, 
																																																																													left.v_city_name, left.st, left.zip, left.cust_name);
																															self.powid				:= vLinkingIds.powid;
																															self.proxid			:= vLinkingIds.proxid;
																															self.seleid			:= vLinkingIds.seleid;
																															self.orgid				:= vLinkingIds.orgid;
																															self.ultid				:= vLinkingIds.ultid;
																															self := left;
																															self	:= [];
																															));

Layouts.Combined_Contact_Base_Ext	 ClnMain_2(ContactCln L) := TRANSFORM
		string73 tempname 		 					 := if(trim(L.Contact_name) = '', '',Address.CleanPersonFML73(L.contact_name));
		pname 							 	 					 := Address.CleanNameFields(tempName);
		self.title						 					 := pname.title;
		self.fname 						 					 := pname.fname;        
		self.mname 						 					 := pname.mname;
		self.lname 						 					 := pname.lname;		  
		self.name_suffix 			 					 := pname.name_suffix;
		self.name_score			   					 := pname.name_score;
																				
		TempPAddr					:= Address.CleanAddress182(TRIM(L.CONTACT_ADDR,left,right),TRIM(L.Contact_city,left,right) + ', '+
																								TRIM(L.Contact_state,left,right) +' '+ TRIM((string)L.Contact_zip,left,right));

		self.prim_range 		:= TempPAddr[1..10];
		self.predir     		:= TempPAddr[11..12];
		self.prim_name			:= TempPAddr[13..40];
		self.addr_suffix		:= TempPAddr[41..44];
		self.postdir				:= TempPAddr[45..46];
		self.unit_desig			:= TempPAddr[47..56];
		self.sec_range			:= TempPAddr[57..64];
		self.p_city_name		:= TempPAddr[65..89];
		self.v_city_name		:= TempPAddr[90..114];
		self.st							:= TempPAddr[115..116];
		Clnzip							:= TempPAddr[117..121];
		self.zip            := IF(trim(Clnzip) = '',(string) L.Contact_zip, Clnzip);
		//self.zip						:= TempPAddr[117..121];
		self.zip4						:= TempPAddr[122..125];
		self.cart						:= TempPAddr[126..129];
		self.cr_sort_sz			:= TempPAddr[130];
		self.lot						:= TempPAddr[131..134];
		self.lot_order			:= TempPAddr[135];
		self.dbpc						:= TempPAddr[136..137];
		self.chk_digit			:= TempPAddr[138];
		self.rec_type				:= TempPAddr[139..140];
		//self.fips_state			:= TempPAddr[141..142];
		self.county					:= TempPAddr[143..145];	
		self.geo_lat				:= TempPAddr[146..155];
		self.geo_long				:= TempPAddr[156..166];
		self.msa						:= TempPAddr[167..170];
		SELF.geo_blk				:= TempPAddr[171..177];
		self.geo_match			:= TempPAddr[178];
		self.err_stat				:= TempPAddr[179..182];
		self.prep_addr_line1			:= Address.Addr1FromComponents(ut.CleanSpacesAndUpper(L.CONTACT_ADDR),'','','','','',''); 
		self.prep_addr_line_last	:= Address.Addr2FromComponents(ut.CleanSpacesAndUpper(L.Contact_city),ut.CleanSpacesAndUpper(L.Contact_State),TRIM((string)L.Contact_ZIP,left,right));
    // self.bdid := 0;    
		self.Did:=Prte2.fn_AppendFakeID.did(self.fname, self.lname, l.ssn, (string)l.dob, l.cust_name);		
    self.global_sid := 0;
    self.record_sid := 0;
    self := L;   
	 SELF := [];
	END;

df_contact	:= PROJECT(ContactCln, ClnMain_2(left));

PromoteSupers.MAC_SF_BuildProcess(ds_business_linkids,constants.Base_fbnv2_Business, writefile_business);

PromoteSupers.MAC_SF_BuildProcess(df_contact,constants.Base_fbnv2_Contact, writefile_contact);

sequential(writefile_business,writefile_contact);

Return 'success';
END;