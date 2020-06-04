IMPORT FraudShared,address,tools;
EXPORT Append_CleanAddress (
	 dataset(FraudShared.Layouts.Base.Main) FileBase
) := FUNCTION

	AddressCache := Files().Base.AddressCache.QA;
	
	pAddressCache	:= Project(AddressCache,Transform(recordof(left)
													,self.prim_range	:= stringlib.stringfilterout(left.prim_range,'.?<&>*@!\\$=+%~\'')
													,self.prim_name		:= stringlib.stringfilterout(left.prim_name,'.?<&>*@!\\$=+%~\'')
													,self.sec_range		:= stringlib.stringfilterout(left.sec_range,'.?<&>*@!\\$=+%~\'')
													,self:=left));	
	pFileBase			:= PROJECT(FileBase,Transform(recordof(left)
													,self.clean_address.prim_range	:= stringlib.stringfilterout(left.clean_address.prim_range,'.?<&>*@!\\$=+%~\'')
													,self.clean_address.prim_name		:= stringlib.stringfilterout(left.clean_address.prim_name,'.?<&>*@!\\$=+%~\'')
													,self.clean_address.sec_range		:= stringlib.stringfilterout(left.clean_address.sec_range,'.?<&>*@!\\$=+%~\'')
													,self:=left));
	
	dFileBase 		:= DISTRIBUTE(PULL(pFileBase), 
		HASH(
		clean_address.prim_range,
		clean_address.predir,
		clean_address.prim_name,
		clean_address.addr_suffix,
		clean_address.postdir,
		clean_address.unit_desig,
		clean_address.sec_range,
		clean_address.p_city_name,
		clean_address.v_city_name,
		clean_address.zip,
		clean_address.st
		));


	dAddressCache	:= DISTRIBUTE(PULL(pAddressCache), 
		HASH(
		prim_range,
		predir,
		prim_name,
		addr_suffix,
		postdir,
		unit_desig,
		sec_range,
		p_city_name,
		v_city_name,
		zip,
		st
	));
	
	FraudShared.Layouts.Base.Main T_Append_Main_Address_From_Cache(FraudShared.Layouts.Base.Main L, FraudGovPlatform.Layouts.Base.AddressCache R) := TRANSFORM
	
			FOUND := IF(	
						L.clean_address.prim_range = R.prim_range AND
						L.clean_address.predir = R.predir AND
						L.clean_address.prim_name = R.prim_name AND
						L.clean_address.addr_suffix = R.addr_suffix AND
						L.clean_address.postdir = R.postdir AND
						L.clean_address.unit_desig = R.unit_desig AND
						L.clean_address.sec_range = R.sec_range AND
						L.clean_address.p_city_name = R.p_city_name AND
						L.clean_address.v_city_name = R.v_city_name AND
						L.clean_address.zip = R.zip AND
						L.clean_address.st = R.st				
				, TRUE, FALSE);
			
			SELF.clean_address.prim_range				:= if(FOUND, R.prim_range,		L.clean_address.prim_range);
			SELF.clean_address.predir						:= if(FOUND, R.predir,				L.clean_address.predir);
			SELF.clean_address.prim_name				:= if(FOUND, R.prim_name,			L.clean_address.prim_name);
			SELF.clean_address.addr_suffix			:= if(FOUND, R.addr_suffix,		L.clean_address.addr_suffix);
			SELF.clean_address.postdir					:= if(FOUND, R.postdir,				L.clean_address.postdir);
			SELF.clean_address.unit_desig				:= if(FOUND, R.unit_desig,		L.clean_address.unit_desig);
			SELF.clean_address.sec_range				:= if(FOUND, R.sec_range,			L.clean_address.sec_range);
			SELF.clean_address.p_city_name			:= if(FOUND, R.p_city_name,		L.clean_address.p_city_name);
			SELF.clean_address.v_city_name			:= if(FOUND, R.v_city_name, 	L.clean_address.v_city_name);
			SELF.clean_address.st								:= if(FOUND, R.st,						L.clean_address.st);
			SELF.clean_address.zip							:= if(FOUND, R.zip,						L.clean_address.zip);
			SELF.clean_address.zip4							:= if(FOUND, R.zip4,					L.clean_address.zip4);
			SELF.clean_address.cart							:= if(FOUND, R.cart,					L.clean_address.cart);
			SELF.clean_address.cr_sort_sz				:= if(FOUND, R.cr_sort_sz,		L.clean_address.cr_sort_sz);
			SELF.clean_address.lot							:= if(FOUND, R.lot,						L.clean_address.lot);
			SELF.clean_address.lot_order				:= if(FOUND, R.lot_order,			L.clean_address.lot_order);
			SELF.clean_address.dbpc							:= if(FOUND, R.dbpc,					L.clean_address.dbpc);
			SELF.clean_address.chk_digit				:= if(FOUND, R.chk_digit,			L.clean_address.chk_digit);
			SELF.clean_address.rec_type					:= if(FOUND, R.rec_type,			L.clean_address.rec_type);
			SELF.clean_address.fips_state 			:= if(FOUND, R.fips_state,		L.clean_address.fips_state);
			SELF.clean_address.fips_county			:= if(FOUND, R.fips_county,		L.clean_address.fips_county);
			SELF.clean_address.geo_lat					:= if(FOUND, R.geo_lat,				L.clean_address.geo_lat);
			SELF.clean_address.geo_long					:= if(FOUND, R.geo_long,			L.clean_address.geo_long);
			SELF.clean_address.msa							:= if(FOUND, R.msa,						L.clean_address.msa);
			SELF.clean_address.geo_blk					:= if(FOUND, R.geo_blk,				L.clean_address.geo_blk);
			SELF.clean_address.geo_match				:= if(FOUND, R.geo_match,			L.clean_address.geo_match);
			SELF.clean_address.err_stat					:= if(FOUND, R.err_stat,			L.clean_address.err_stat);
			SELF.address_1											:= if(FOUND, 
				tools.AID_Helpers.fRawFixLine1( trim(R.prim_range) + ' ' +  trim(R.predir) + ' ' + trim(R.prim_name) +' '+ trim(R.addr_suffix) +' '+ trim(R.postdir) +' '+ trim(R.unit_desig) +' '+ trim(R.sec_range)),
				tools.AID_Helpers.fRawFixLine1( trim(L.clean_address.prim_range) + ' ' +  trim(L.clean_address.predir) + ' ' + trim(L.clean_address.prim_name) +' '+ trim(L.clean_address.addr_suffix) +' '+ trim(L.clean_address.postdir) +' '+ trim(L.clean_address.unit_desig) +' '+trim(L.clean_address.sec_range)));
			SELF.address_2											:= if(FOUND, 
				tools.AID_Helpers.fRawFixLineLast( stringlib.stringtouppercase(trim(R.v_city_name) + if( R.v_city_name !='' and( R.st != '' or R.zip !=''), ', ', '') + trim(R.st) +' '+ trim(R.zip))),
				tools.AID_Helpers.fRawFixLineLast( stringlib.stringtouppercase(trim(L.clean_address.v_city_name) + if(L.clean_address.v_city_name != '' and (L.clean_address.st !='' or L.clean_address.zip !=''), ', ', '') + trim(L.clean_address.st) + ' ' + trim(L.clean_address.zip))));
			SELF := L;
	END;
	
	J_Main_Addresses_Cleared_From_Cache := JOIN(
		dFileBase,
		dAddressCache,
		LEFT.clean_address.prim_range = RIGHT.prim_range AND
		LEFT.clean_address.predir = RIGHT.predir AND
		LEFT.clean_address.prim_name = RIGHT.prim_name AND
		LEFT.clean_address.addr_suffix = RIGHT.addr_suffix AND
		LEFT.clean_address.postdir = RIGHT.postdir AND
		LEFT.clean_address.unit_desig = RIGHT.unit_desig AND
		LEFT.clean_address.sec_range = RIGHT.sec_range AND
		LEFT.clean_address.p_city_name = RIGHT.p_city_name AND
		LEFT.clean_address.v_city_name = RIGHT.v_city_name AND
		LEFT.clean_address.zip = RIGHT.zip AND
		LEFT.clean_address.st = RIGHT.st,
		T_Append_Main_Address_From_Cache(LEFT,RIGHT),
		LEFT OUTER,
		LOCAL
	);

	Main_Addresses_To_Clean := J_Main_Addresses_Cleared_From_Cache( clean_address.err_stat = '');

	FraudShared.Layouts.Base.Main T_Clean_Main_Address( FraudShared.Layouts.Base.Main L ) := TRANSFORM 

	//*********************************************  CleanAddress182  **************************************************//
				address_1 := stringlib.stringfilterout(tools.AID_Helpers.fRawFixLine1( trim(l.Street_1) + ' ' +  trim(l.Street_2)),'.?<&>*@!\\$=+%~\'');
				address_2 := tools.AID_Helpers.fRawFixLineLast( stringlib.stringtouppercase(trim(l.city) + if(l.state != '', ', ', '') + trim(l.state)  + ' ' + trim(l.zip)[1..5]));
				Clean_Address_182 :=  if (trim(l.Street_1)!='' or trim(l.Street_2)!='' or trim(l.city)!='' or trim(l.state)!='' or trim(l.zip) != '', address.CleanAddress182(address_1, address_2), '');
	//******************************************************************************************************************//

				SELF.clean_address.prim_range			:= Clean_Address_182[1..10]		; //prim_range
				SELF.clean_address.predir					:= Clean_Address_182[11..12]		; //predir
				SELF.clean_address.prim_name			:= Clean_Address_182[13..40]		; //prim_name
				SELF.clean_address.addr_suffix		:= Clean_Address_182[41..44]		; //addr_suffix
				SELF.clean_address.postdir				:= Clean_Address_182[45..46]		; //postdir
				SELF.clean_address.unit_desig			:= Clean_Address_182[47..56]		; //unit_desig
				SELF.clean_address.sec_range			:= Clean_Address_182[57..64]		; //sec_range
				SELF.clean_address.p_city_name		:= Clean_Address_182[65..89]		; //p_city_name
				SELF.clean_address.v_city_name		:= Clean_Address_182[90..114]	; //v_city_name
				SELF.clean_address.st							:= Clean_Address_182[115..116]	; //st
				SELF.clean_address.zip						:= Clean_Address_182[117..121]	; //zip
				SELF.clean_address.zip4						:= Clean_Address_182[122..125]	; //zip4
				SELF.clean_address.cart						:= Clean_Address_182[126..129]	; //cart
				SELF.clean_address.cr_sort_sz			:= Clean_Address_182[130]			; //cr_sort_sz
				SELF.clean_address.lot						:= Clean_Address_182[131..134]	; //lot
				SELF.clean_address.lot_order			:= Clean_Address_182[135]			; //lot_order
				SELF.clean_address.dbpc						:= Clean_Address_182[136..137]	; //dpbc
				SELF.clean_address.chk_digit			:= Clean_Address_182[138]			; //chk_digit
				SELF.clean_address.rec_type				:= Clean_Address_182[139..140]	; //record_type
				SELF.clean_address.fips_state 		:= Clean_Address_182[141..142]	; //ace_fips_state
				SELF.clean_address.fips_county		:= Clean_Address_182[143..145]	; //county
				SELF.clean_address.geo_lat				:= Clean_Address_182[146..155]	; //geo_lat
				SELF.clean_address.geo_long				:= Clean_Address_182[156..166]	; //geo_long
				SELF.clean_address.msa						:= Clean_Address_182[167..170]	; //msa
				SELF.clean_address.geo_blk				:= Clean_Address_182[171..177]	; //geo_blk
				SELF.clean_address.geo_match			:= Clean_Address_182[178]			; //geo_match
				SELF.clean_address.err_stat				:= Clean_Address_182[179..182]	; //err_stat		
				SELF.address_1										:= tools.AID_Helpers.fRawFixLine1( trim(Clean_Address_182[1..10]) + ' ' +  trim(Clean_Address_182[11..12]) + ' ' +  trim(Clean_Address_182[13..40]) +' '+ trim(Clean_Address_182[41..44]) +' '+ trim(Clean_Address_182[45..46]) +' '+ trim(Clean_Address_182[47..56]) +' '+ trim(Clean_Address_182[57..64]));
				SELF.address_2										:= tools.AID_Helpers.fRawFixLineLast( stringlib.stringtouppercase(trim(Clean_Address_182[90..114]) + if(Clean_Address_182[90..114] !='' and (Clean_Address_182[115..116] != '' or Clean_Address_182[117..121] !=''), ', ', '') + trim(Clean_Address_182[115..116]) + ' ' + trim(Clean_Address_182[117..121])));
				SELF															:= L;
		END;
	
	P_Main_Addresses_Cleaned := PROJECT(Main_Addresses_To_Clean , T_Clean_Main_Address(LEFT));

	Main_Addresses_Cleaned := J_Main_Addresses_Cleared_From_Cache( clean_address.err_stat != '');
	Main_Addresses := P_Main_Addresses_Cleaned + Main_Addresses_Cleaned;
	
	RETURN (Main_Addresses);

END;