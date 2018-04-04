import tools,address; 
EXPORT Standardize_Entity       := 
module

export address(
			
			dataset(Layouts.Base.Main) pBaseFile ) := 
function		

		prepped_Addresses := dedup(table(pBaseFile,{address_1, address_2}) + table(pBaseFile,{additional_address.address_1,additional_address.address_2}),all);
		
		Clean_Addresses := project( prepped_Addresses ,transform( Layouts.address_cleaner,
				Clean_Address_182 								:= if (left.address_2 != '', address.CleanAddress182(left.address_1, left.address_2), '');
				self.address_1										:= left.address_1;
				self.address_2										:= left.address_2;
				self.clean_address.prim_range			:= Clean_Address_182[1..10]					; //prim_range
				self.clean_address.predir					:= Clean_Address_182[11..12]				; //predir
				self.clean_address.prim_name			:= Clean_Address_182[13..40]				; //prim_name
				self.clean_address.addr_suffix		:= Clean_Address_182[41..44]				; //addr_suffix
				self.clean_address.postdir				:= Clean_Address_182[45..46]				; //postdir
				self.clean_address.unit_desig			:= Clean_Address_182[47..56]				; //unit_desig
				self.clean_address.sec_range			:= Clean_Address_182[57..64]				; //sec_range
				self.clean_address.p_city_name		:= Clean_Address_182[65..89]				; //p_city_name
				self.clean_address.v_city_name		:= Clean_Address_182[90..114]				; //v_city_name
				self.clean_address.st							:= Clean_Address_182[115..116]			; //st
				self.clean_address.zip						:= Clean_Address_182[117..121]			; //zip
				self.clean_address.zip4						:= Clean_Address_182[122..125]			; //zip4
				self.clean_address.cart						:= Clean_Address_182[126..129]			; //cart
				self.clean_address.cr_sort_sz			:= Clean_Address_182[130]						; //cr_sort_sz
				self.clean_address.lot						:= Clean_Address_182[131..134]			; //lot
				self.clean_address.lot_order			:= Clean_Address_182[135]						; //lot_order
				self.clean_address.dbpc						:= Clean_Address_182[136..137]			; //dpbc
				self.clean_address.chk_digit			:= Clean_Address_182[138]						; //chk_digit
				self.clean_address.rec_type				:= Clean_Address_182[139..140]			; //record_type
				self.clean_address.fips_state 		:= Clean_Address_182[141..142]			; //ace_fips_state
				self.clean_address.fips_county		:= Clean_Address_182[143..145]			; //county
				self.clean_address.geo_lat				:= Clean_Address_182[146..155]			; //geo_lat
				self.clean_address.geo_long				:= Clean_Address_182[156..166]			; //geo_long
				self.clean_address.msa						:= Clean_Address_182[167..170]			; //msa
				self.clean_address.geo_blk				:= Clean_Address_182[171..177]			; //geo_blk
				self.clean_address.geo_match			:= Clean_Address_182[178]						; //geo_match
				self.clean_address.err_stat				:= Clean_Address_182[179..182]			; //err_stat				
				self								              := left															;
			));

		  Layouts.Base.Main addCleanAddress(Layouts.Base.Main L, Layouts.address_cleaner R) := TRANSFORM
				self.clean_address.prim_range			:= R.clean_address.prim_range;	 
				self.clean_address.predir			 		:= R.clean_address.predir;			 
				self.clean_address.prim_name		 	:= R.clean_address.prim_name;		 
				self.clean_address.addr_suffix		:= R.clean_address.addr_suffix;		 
				self.clean_address.postdir			 	:= R.clean_address.postdir;			 
				self.clean_address.unit_desig			:= R.clean_address.unit_desig;		 
				self.clean_address.sec_range		 	:= R.clean_address.sec_range;		 
				self.clean_address.p_city_name		:= R.clean_address.p_city_name;		 
				self.clean_address.v_city_name		:= R.clean_address.v_city_name;		 
				self.clean_address.st				 			:= R.clean_address.st;				 
				self.clean_address.zip				 		:= R.clean_address.zip;				 
				self.clean_address.zip4				 		:= R.clean_address.zip4;				 
				self.clean_address.cart				 		:= R.clean_address.cart;				 
				self.clean_address.cr_sort_sz			:= R.clean_address.cr_sort_sz;		 
				self.clean_address.lot				 		:= R.clean_address.lot;				 
				self.clean_address.lot_order		 	:= R.clean_address.lot_order;		 
				self.clean_address.dbpc				 		:= R.clean_address.dbpc;				 
				self.clean_address.chk_digit		 	:= R.clean_address.chk_digit;		 
				self.clean_address.rec_type				:= R.clean_address.rec_type;			 
				self.clean_address.fips_state 		:= R.clean_address.fips_state; 		 
				self.clean_address.fips_county		:= R.clean_address.fips_county;		 
				self.clean_address.geo_lat			 	:= R.clean_address.geo_lat;			 
				self.clean_address.geo_long				:= R.clean_address.geo_long;			 
				self.clean_address.msa				 		:= R.clean_address.msa;				 
				self.clean_address.geo_blk			 	:= R.clean_address.geo_blk;			 
				self.clean_address.geo_match		 	:= R.clean_address.geo_match;		 
				self.clean_address.err_stat				:= R.clean_address.err_stat;			
				SELF := L;
			END;
			
			pBaseFile2 := join(
																			distribute(pBaseFile,hash(address_1,address_2)),
																			distribute(Clean_Addresses,hash(address_1,address_2)),
																		 left.address_1 = right.address_1 and left.address_2 = right.address_2,
																		 addCleanAddress(LEFT,RIGHT),
																		 LEFT OUTER,
																		 LOCAL);

		  Layouts.Base.Main addCleanAAddress(Layouts.Base.Main L, Layouts.address_cleaner R) := TRANSFORM
				self.additional_address.clean_address.prim_range			:= R.clean_address.prim_range;	 
				self.additional_address.clean_address.predir			 		:= R.clean_address.predir;			 
				self.additional_address.clean_address.prim_name		 	:= R.clean_address.prim_name;		 
				self.additional_address.clean_address.addr_suffix		:= R.clean_address.addr_suffix;		 
				self.additional_address.clean_address.postdir			 	:= R.clean_address.postdir;			 
				self.additional_address.clean_address.unit_desig		 	:= R.clean_address.unit_desig;		 
				self.additional_address.clean_address.sec_range		 	:= R.clean_address.sec_range;		 
				self.additional_address.clean_address.p_city_name		:= R.clean_address.p_city_name;		 
				self.additional_address.clean_address.v_city_name		:= R.clean_address.v_city_name;		 
				self.additional_address.clean_address.st				 			:= R.clean_address.st;				 
				self.additional_address.clean_address.zip				 		:= R.clean_address.zip;				 
				self.additional_address.clean_address.zip4				 		:= R.clean_address.zip4;				 
				self.additional_address.clean_address.cart				 		:= R.clean_address.cart;				 
				self.additional_address.clean_address.cr_sort_sz		 	:= R.clean_address.cr_sort_sz;		 
				self.additional_address.clean_address.lot				 		:= R.clean_address.lot;				 
				self.additional_address.clean_address.lot_order		 	:= R.clean_address.lot_order;		 
				self.additional_address.clean_address.dbpc				 		:= R.clean_address.dbpc;				 
				self.additional_address.clean_address.chk_digit		 	:= R.clean_address.chk_digit;		 
				self.additional_address.clean_address.rec_type			 	:= R.clean_address.rec_type;			 
				self.additional_address.clean_address.fips_state 		:= R.clean_address.fips_state; 		 
				self.additional_address.clean_address.fips_county		:= R.clean_address.fips_county;		 
				self.additional_address.clean_address.geo_lat			 	:= R.clean_address.geo_lat;			 
				self.additional_address.clean_address.geo_long			 	:= R.clean_address.geo_long;			 
				self.additional_address.clean_address.msa				 		:= R.clean_address.msa;				 
				self.additional_address.clean_address.geo_blk			 	:= R.clean_address.geo_blk;			 
				self.additional_address.clean_address.geo_match		 	:= R.clean_address.geo_match;		 
				self.additional_address.clean_address.err_stat			 	:= R.clean_address.err_stat;			
				SELF := L;
			END;
			
			pBaseFile3 := join(
																			distribute(pBaseFile2,hash(additional_address.address_1,additional_address.address_2)),
																			distribute(Clean_Addresses,hash(address_1,address_2)),			
																		 left.additional_address.address_1 = right.address_1 and left.additional_address.address_2 = right.address_2,
																		 addCleanAAddress(LEFT,RIGHT),
																		 LEFT OUTER,
																		 LOCAL);

			
	return pBaseFile3;
end;


export Phone(dataset(Layouts.Base.Main) pBaseFile) :=
function

	tools.mac_AppendCleanPhone(pBaseFile	    ,phone_number	,dphone_number	,clean_phones.phone_number	,,true);
	tools.mac_AppendCleanPhone(dphone_number	,cell_phone		,dcell_phone		,clean_phones.cell_phone		,,true);
  tools.mac_AppendCleanPhone(dcell_phone	  ,Work_phone		,dWork_phone		,clean_phones.Work_phone	,,true);

  return dWork_phone;
	
end;
end; 
