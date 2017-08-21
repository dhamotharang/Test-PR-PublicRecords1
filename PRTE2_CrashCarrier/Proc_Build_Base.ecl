IMPORT  PromoteSupers, address,ut, Prte2;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

Layouts.Base ClnMain(files.crashcarrier_IN L) := TRANSFORM
	  string73 tempname                :=ut.CleanSpacesAndUpper(L.carrier_name);
		pname := Address.CleanPersonFML73_fields(tempName);
		//pname 							 	 					 := Address.CleanNameFields(tempName);
		self.title						 					 := pname.title;
		self.fname 						 					 := pname.fname;        
		self.mname 						 					 := pname.mname;
		self.lname 						 					 := pname.lname;		  
		self.name_suffix 			 					 := pname.name_suffix;
		self.name_score			   					 := pname.name_score;
																				
		TempPAddr					:= Address.CleanAddress182(TRIM(L.Carrier_Street,left,right),TRIM(L.Carrier_city,left,right) + ', '+
																								TRIM(L.Carrier_state,left,right) +' '+ TRIM((string)L.Carrier_zip_code,left,right));

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
		self.zip            := IF(trim(ClnZip) = '',(string)L.Carrier_zip_code,ClnZip);
		//self.zip						:= TempPAddr[117..121];
		self.zip4						:= TempPAddr[122..125];
		self.cart						:= TempPAddr[126..129];
		self.cr_sort_sz			:= TempPAddr[130];
		self.lot						:= TempPAddr[131..134];
		self.lot_order			:= TempPAddr[135];
		self.dbpc						:= TempPAddr[136..137];
		self.chk_digit			:= TempPAddr[138];
		self.rec_type				:= TempPAddr[139..140];
		self.fips_state			:= TempPAddr[141..142];
		//self.county					:= TempPAddr[143..145];	
		self.geo_lat				:= TempPAddr[146..155];
		self.geo_long				:= TempPAddr[156..166];
		self.msa						:= TempPAddr[167..170];
		SELF.geo_blk				:= TempPAddr[171..177];
		self.geo_match			:= TempPAddr[178];
		self.err_stat				:= TempPAddr[179..182];
		self.prep_addr_line1			:= Address.Addr1FromComponents(ut.CleanSpacesAndUpper(L.Carrier_street),'','','','','',''); 
		self.prep_addr_line_last	:= Address.Addr2FromComponents(ut.CleanSpacesAndUpper(L.carrier_city),ut.CleanSpacesAndUpper(L.carrier_State),TRIM((string)L.carrier_ZIP_code,left,right));
    
		self.raw.carrier_ID:=L.carrier_ID;		
		self.raw.crash_ID:=L.crash_ID;
	  self.raw.carrier_source_code:=L.carrier_source_code;
		self.raw.carrier_name:=L.carrier_name;
		self.raw.carrier_street:=L.carrier_street;
		self.raw.carrier_city:=L.carrier_city;
		self.raw.carrier_city_code:=L.carrier_city_code;
		self.raw.carrier_state:=L.carrier_state;
		self.raw.carrier_zip_code:=L.carrier_zip_code;
		self.raw.crash_colonia:=L.crash_colonia;
		self.raw.prefix:=L.prefix;
		self.raw.docket_number:=L.docket_number;
		self.raw.interstate:=L.interstate;
		self.raw.no_id_flag:=L.no_id_flag;
		self.raw.state_number:=L.state_number;
		self.raw.state_issuing_number:=L.state_issuing_number;
		self.cleaned_carrier_name:=L.carrier_name;
		self.cleaned_carrier_street:=L.carrier_street;
		self.cleaned_carrier_city:=L.carrier_city;
		self.cleaned_carrier_state:=L.carrier_state;
		self.cleaned_carrier_zip_code:=L.carrier_zip_code;
		self.cleaned_prefix:=L.prefix;
		SELF.did:= if(L.ssn != '',prte2.fn_AppendFakeID.did(self.fname, self.lname, L.ssn, L.dob, L.cust_name),0);
	 	SELF.bdid := if(L.fein != '',prte2.fn_AppendFakeID.bdid(L.carrier_name, self.prim_range, self.prim_name, L.carrier_city, L.carrier_state, L.carrier_zip_code, L.cust_name),0);     
	  vLinkingIds := prte2.fn_AppendFakeID.LinkIds(L.Carrier_name, L.fein, L.inc_date, self.prim_range, self.prim_name, self.sec_range, self.v_city_name, self.st, self.zip, L.cust_name);
    self.powid	:= vLinkingIds.powid;
    self.proxid	:= vLinkingIds.proxid;
    self.seleid	:= vLinkingIds.seleid;
    self.orgid	:= vLinkingIds.orgid;
    self.ultid	:= vLinkingIds.ultid;		
		self.source_rec_id := hash64(ut.CleanSpacesAndUpper(l.carrier_name),					
																 ut.CleanSpacesAndUpper(l.carrier_street),
																 ut.CleanSpacesAndUpper(l.carrier_city),		
																 ut.CleanSpacesAndUpper(l.carrier_state),
																 ut.CleanSpacesAndUpper(l.carrier_zip_code),
																 ut.CleanSpacesAndUpper(l.interstate),
																 ut.CleanSpacesAndUpper(l.no_id_flag),		
																 ut.CleanSpacesAndUpper(l.state_issuing_number)
																 );
		
		self := L;
		SELF := [];
	END;
df_business	:= PROJECT(files.crashcarrier_IN, ClnMain(left));

PromoteSupers.MAC_SF_BuildProcess(df_business,constants.Base_crashcarrier, writefile_business);
 
sequential(writefile_business);

Return 'success';
END;