IMPORT Business_Header, ut;
export fAs_Business_Header_TX(dataset(layouts.base.TX) pInput) :=
function

	TX_base := pInput;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Add unique record id to TX file
	//////////////////////////////////////////////////////////////////////////////////////////////
	Layout_TX_Local := 
	record
		UNSIGNED6 record_id := 0;
		layouts.base.TX;
	end;

	Layout_TX_Local AddRecordID(layouts.base.TX L) := 
	transform
		self := L;
		self.record_id := 0;
	end;

	TX_Init := PROJECT(TX_base, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(TX_Init, record_id, TX_Seq);

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH format
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout Translate_TX_To_BHF(Layout_TX_Local L, unsigned2 cnt) := 
	transform
		SELF.source										:= Source_Codes.TX;
		SELF.source_group 						:= trim(l.rawfields.clp,left,right);
		SELF.group1_id 								:= L.record_id;
		SELF.vl_id 								    := trim(l.rawfields.clp,left,right);
		SELF.vendor_id 								:= trim(l.rawfields.clp,left,right);
		SELF.dt_first_seen						:= l.dt_first_seen;
		SELF.dt_last_seen							:= l.dt_last_seen;
		SELF.dt_vendor_first_reported	:= L.dt_vendor_first_reported;
		SELF.dt_vendor_last_reported	:= L.dt_vendor_last_reported;
		SELF.company_name							:= map(cnt = 1 or cnt = 3 => if(l.clean_owner_name.lname			= '',l.rawfields.owner		, '')
																															,if(l.clean_tradename_name.lname	= '',l.rawfields.tradename, '')									
																			);
		SELF.prim_range								:= if(cnt = 1 OR cnt = 2,L.Clean_location_address.prim_range			,L.Clean_mailing_address.prim_range				);
		SELF.predir										:= if(cnt = 1 OR cnt = 2,L.Clean_location_address.predir					,L.Clean_mailing_address.predir						);
		SELF.prim_name								:= if(cnt = 1 OR cnt = 2,L.Clean_location_address.prim_name				,L.Clean_mailing_address.prim_name				);
		SELF.addr_suffix							:= if(cnt = 1 OR cnt = 2,L.Clean_location_address.addr_suffix			,L.Clean_mailing_address.addr_suffix			);
		SELF.postdir									:= if(cnt = 1 OR cnt = 2,L.Clean_location_address.postdir					,L.Clean_mailing_address.postdir					);
		SELF.unit_desig								:= if(cnt = 1 OR cnt = 2,L.Clean_location_address.unit_desig			,L.Clean_mailing_address.unit_desig				);
		SELF.sec_range								:= if(cnt = 1 OR cnt = 2,L.Clean_location_address.sec_range				,L.Clean_mailing_address.sec_range				);
		SELF.city											:= if(cnt = 1 OR cnt = 2,L.Clean_location_address.v_city_name			,L.Clean_mailing_address.v_city_name			);
		SELF.state										:= if(cnt = 1 OR cnt = 2,L.Clean_location_address.st							,L.Clean_mailing_address.st								);
		SELF.zip											:= if(cnt = 1 OR cnt = 2,(UNSIGNED3)L.Clean_location_address.zip	,(UNSIGNED3)L.Clean_mailing_address.zip		);
		SELF.zip4											:= if(cnt = 1 OR cnt = 2,(UNSIGNED2)L.Clean_location_address.zip4	,(UNSIGNED2)L.Clean_mailing_address.zip4	);
		SELF.county										:= if(cnt = 1 OR cnt = 2,L.Clean_location_address.fips_county			,L.Clean_mailing_address.fips_county			);
		SELF.msa											:= if(cnt = 1 OR cnt = 2,L.Clean_location_address.msa							,L.Clean_mailing_address.msa							);
		SELF.geo_lat									:= if(cnt = 1 OR cnt = 2,L.Clean_location_address.geo_lat					,L.Clean_mailing_address.geo_lat					);				
		SELF.geo_long									:= if(cnt = 1 OR cnt = 2,L.Clean_location_address.geo_long				,L.Clean_mailing_address.geo_long					);
		SELF.phone										:= (unsigned6)l.clean_phone;                                                       
		SELF.phone_score 							:= IF(self.Phone = 0, 0, 1);
		SELF.fein 										:= 0;
		SELF.current									:= TRUE;
		SELF.dppa 										:= FALSE;
	end;

	from_TX_proj := normalize(TX_Seq, 4,Translate_TX_To_BHF(LEFT,counter));

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Do standard BH rollup with no filter, group1_id rollup, or fixing the company name
	//////////////////////////////////////////////////////////////////////////////////////////////
//	TX_clean_rollup := Business_Header.As_Business_Header_Function(from_TX_proj, false, false, false);
	TX_clean_rollup := from_TX_proj(company_name != '');

	return TX_clean_rollup;

end;
