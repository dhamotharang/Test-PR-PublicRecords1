IMPORT Business_Header, ut;
export fAs_Business_Header_LA(

	dataset(layouts.base.LA) pInput = files().base.LA.qa

) :=
function

	LA_base := pInput;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Add unique record id to LA file
	//////////////////////////////////////////////////////////////////////////////////////////////
	Layout_LA_Local := 
	record
		UNSIGNED6 record_id := 0;
		layouts.base.LA;
	end;

	Layout_LA_Local AddRecordID(layouts.base.LA L) := 
	transform
		self := L;
		self.record_id := 0;
	end;

	LA_Init := PROJECT(LA_base, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(LA_Init, record_id, LA_Seq);

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH format
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout Translate_LA_To_BHF(Layout_LA_Local L, unsigned2 cnt) := 
	transform
	name_score := Business_Header.CleanName(l.clean_owner_name.fname,l.clean_owner_name.mname			,l.clean_owner_name.lname,l.clean_owner_name.name_suffix)[142];
	checkname := Business_Header.CheckPersonName(l.clean_owner_name.fname,l.clean_owner_name.mname			,l.clean_owner_name.lname,l.clean_owner_name.name_suffix);
	
	owner_is_company := if((integer)name_score < 2 and checkname, false, true);
	ownername := if(owner_is_company, l.rawfields.OwnerName, '');
	
	
		SELF.source										:= Source_Codes.LA;
		SELF.source_group 						:= trim(l.rawfields.FORMATTEDCREDENTIAL,left,right);
		SELF.group1_id 								:= L.record_id;
		SELF.vl_id    								:= self.source_group;
		SELF.vendor_id 								:= self.source_group;
		SELF.dt_first_seen						:= l.dt_first_seen;
		SELF.dt_last_seen							:= l.dt_last_seen;
		SELF.dt_vendor_first_reported	:= L.dt_vendor_first_reported;
		SELF.dt_vendor_last_reported	:= L.dt_vendor_last_reported;
		SELF.company_name							:= choose(cnt,l.rawfields.TradeName, ownername);
		SELF.prim_range								:= choose(cnt,L.Clean_trade_address.prim_range			,L.Clean_owner_address.prim_range				); 
		SELF.predir										:= choose(cnt,L.Clean_trade_address.predir					,L.Clean_owner_address.predir						);
		SELF.prim_name								:= choose(cnt,L.Clean_trade_address.prim_name				,L.Clean_owner_address.prim_name				);
		SELF.addr_suffix							:= choose(cnt,L.Clean_trade_address.addr_suffix			,L.Clean_owner_address.addr_suffix			);
		SELF.postdir									:= choose(cnt,L.Clean_trade_address.postdir					,L.Clean_owner_address.postdir					);
		SELF.unit_desig								:= choose(cnt,L.Clean_trade_address.unit_desig			,L.Clean_owner_address.unit_desig				);
		SELF.sec_range								:= choose(cnt,L.Clean_trade_address.sec_range				,L.Clean_owner_address.sec_range				);
		SELF.city											:= choose(cnt,L.Clean_trade_address.v_city_name			,L.Clean_owner_address.v_city_name			);
		SELF.state										:= choose(cnt,L.Clean_trade_address.st							,L.Clean_owner_address.st								);
		SELF.zip											:= choose(cnt,(UNSIGNED3)L.Clean_trade_address.zip	,(UNSIGNED3)L.Clean_owner_address.zip		);
		SELF.zip4											:= choose(cnt,(UNSIGNED2)L.Clean_trade_address.zip4	,(UNSIGNED2)L.Clean_owner_address.zip4	);
		SELF.county										:= choose(cnt,L.Clean_trade_address.fips_county			,L.Clean_owner_address.fips_county			);
		SELF.msa											:= choose(cnt,L.Clean_trade_address.msa							,L.Clean_owner_address.msa							);
		SELF.geo_lat									:= choose(cnt,L.Clean_trade_address.geo_lat					,L.Clean_owner_address.geo_lat					);			
		SELF.geo_long									:= choose(cnt,L.Clean_trade_address.geo_long				,L.Clean_owner_address.geo_long					);
		SELF.phone										:= (unsigned6)0; 
		SELF.phone_score 							:= IF(self.Phone = 0, 0, 1);;
		SELF.fein 										:= 0;
		SELF.current									:= TRUE;
		SELF.dppa 										:= FALSE;
	end;

	from_LA_proj := normalize(LA_Seq, 2,Translate_LA_To_BHF(LEFT,counter));

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Do standard BH rollup with no filter, group1_id rollup, or fixing the company name
	//////////////////////////////////////////////////////////////////////////////////////////////
//	LA_clean_rollup := Business_Header.As_Business_Header_Function(from_LA_proj, false, false, false);
	LA_clean_rollup := from_LA_proj(company_name != '');

	return LA_clean_rollup;

end;
