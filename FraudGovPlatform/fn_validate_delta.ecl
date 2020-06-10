Import FraudGovPlatform,FraudShared;
EXPORT fn_validate_delta(
	dataset(FraudShared.Layouts.Base.Main) FileBase,
    dataset(FraudShared.Layouts.Base.Main) Previous_Build = FraudShared.Files().Base.Main.QA 
) := FUNCTION

previous_delta := Previous_Build(regexfind('delta',source,nocase));

FirstRinID := FraudGovPlatform.Constants().FirstRinID;

Non_Deltabase	:= FileBase(~regexfind('delta',source,nocase));

Deltabase_	:= FileBase(regexfind('delta',source,nocase));

without_did 	:= Deltabase_(DID=0);	
with_did_rawlinkid 		:= Deltabase_(DID > 0 and rawlinkid>0);
with_did_no_rawlinkid 		:= Deltabase_(DID >0 and rawlinkid=0);

FraudShared.Layouts.Base.Main T_Did_Pii_Clean(FraudShared.Layouts.Base.Main L) := TRANSFORM
			DidMatch 																					:= MAP(L.Rawlinkid < FirstRinId and L.did < FirstRinid  and L.Rawlinkid=L.did => TRUE
																															,L.Rawlinkid < FirstRinId and L.did < FirstRinid  and L.Rawlinkid<>L.did => FALSE
																															,L.Rawlinkid < FirstRinId and L.did >= FirstRinid  => FALSE
																															,L.Rawlinkid >= FirstRinId and L.did < FirstRinid  => TRUE
																															,L.Rawlinkid >= FirstRinId and L.did >= FirstRinid AND L.Rawlinkid=L.did => TRUE
																															,L.Rawlinkid >= FirstRinId and L.did >= FirstRinid AND L.Rawlinkid<>L.did => FALSE
																															, TRUE);
			SELF.Did																					:= if(DidMatch,	L.did, L.RawlinkId);
			SELF.Did_score																		:= if(DidMatch,	L.did_score, 0);
			SELF.ssn																					:= if(DidMatch,	L.ssn,'');
			SELF.dob																					:= if(DidMatch,	L.dob,'');
			SELF.clean_ssn																		:= if(DidMatch,	L.clean_ssn,'');
			SELF.clean_dob																		:= if(DidMatch,	L.clean_dob,'');
			SELF.phone_number																	:= if(DidMatch,	L.phone_number,'');
			SELF.cell_phone																		:= if(DidMatch,	L.cell_phone,'');
			SELF.clean_phones.phone_number										:= if(DidMatch,	L.clean_phones.phone_number,'');
			SELF.clean_phones.cell_phone											:= if(DidMatch,	L.clean_phones.cell_phone,'');
			SELF.raw_title																		:= if(DidMatch,	L.raw_title,'');
			SELF.raw_first_name																:= if(DidMatch,	L.raw_first_name,'');
			SELF.raw_middle_name															:= if(DidMatch,	L.raw_middle_name,'');
			SELF.raw_last_name																:= if(DidMatch,	L.raw_last_name,'');
			SELF.raw_orig_suffix															:= if(DidMatch,	L.raw_orig_suffix,'');
			SELF.raw_full_name																:= if(DidMatch,	L.raw_full_name,'');
			SELF.cleaned_name.title														:= if(DidMatch,	L.cleaned_name.title,'');
			SELF.cleaned_name.fname														:= if(DidMatch,	L.cleaned_name.fname,'');
			SELF.cleaned_name.mname														:= if(DidMatch,	L.cleaned_name.mname,'');
			SELF.cleaned_name.lname														:= if(DidMatch,	L.cleaned_name.lname,'');
			SELF.cleaned_name.name_suffix											:= if(DidMatch,	L.cleaned_name.name_suffix,'');
			SELF.cleaned_name.name_score											:= if(DidMatch,	L.cleaned_name.name_score,'');
			SELF.street_1																			:= if(DidMatch,	L.street_1,'');
			SELF.street_2																			:= if(DidMatch,	L.street_2,'');
			SELF.city																					:= if(DidMatch,	L.city,'');
			SELF.state																				:= if(DidMatch,	L.state,'');
			SELF.zip																					:= if(DidMatch,	L.zip,'');
			SELF.clean_zip																		:= if(DidMatch,	L.clean_zip,'');
			SELF.gps_coordinates															:= if(DidMatch,	L.gps_coordinates,'');
			SELF.address_date																	:= if(DidMatch,	L.address_date,'');
			SELF.address_type																	:= if(DidMatch,	L.address_type,'');
			SELF.clean_address.prim_range											:= if(DidMatch, L.clean_address.prim_range,'');
			SELF.clean_address.predir													:= if(DidMatch, L.clean_address.predir,'');
			SELF.clean_address.prim_name											:= if(DidMatch, L.clean_address.prim_name,'');
			SELF.clean_address.addr_suffix										:= if(DidMatch, L.clean_address.addr_suffix,'');
			SELF.clean_address.postdir												:= if(DidMatch, L.clean_address.postdir,'');
			SELF.clean_address.unit_desig											:= if(DidMatch, L.clean_address.unit_desig,'');
			SELF.clean_address.sec_range											:= if(DidMatch, L.clean_address.sec_range,'');
			SELF.clean_address.p_city_name										:= if(DidMatch, L.clean_address.p_city_name,'');
			SELF.clean_address.v_city_name										:= if(DidMatch, L.clean_address.v_city_name,'');
			SELF.clean_address.st															:= if(DidMatch, L.clean_address.st,'');
			SELF.clean_address.zip														:= if(DidMatch, L.clean_address.zip,'');
			SELF.clean_address.zip4														:= if(DidMatch, L.clean_address.zip4,'');
			SELF.clean_address.cart														:= if(DidMatch, L.clean_address.cart,'');
			SELF.clean_address.cr_sort_sz											:= if(DidMatch, L.clean_address.cr_sort_sz,'');
			SELF.clean_address.lot														:= if(DidMatch, L.clean_address.lot,'');
			SELF.clean_address.lot_order											:= if(DidMatch, L.clean_address.lot_order,'');
			SELF.clean_address.dbpc														:= if(DidMatch, L.clean_address.dbpc,'');
			SELF.clean_address.chk_digit											:= if(DidMatch, L.clean_address.chk_digit,'');
			SELF.clean_address.rec_type												:= if(DidMatch, L.clean_address.rec_type,'');
			SELF.clean_address.fips_state 										:= if(DidMatch, L.clean_address.fips_state,'');
			SELF.clean_address.fips_county										:= if(DidMatch, L.clean_address.fips_county,'');
			SELF.clean_address.geo_lat												:= if(DidMatch, L.clean_address.geo_lat,'');
			SELF.clean_address.geo_long												:= if(DidMatch, L.clean_address.geo_long,'');
			SELF.clean_address.msa														:= if(DidMatch, L.clean_address.msa,'');
			SELF.clean_address.geo_blk												:= if(DidMatch, L.clean_address.geo_blk,'');
			SELF.clean_address.geo_match											:= if(DidMatch, L.clean_address.geo_match,'');
			SELF.clean_address.err_stat												:= if(DidMatch, L.clean_address.err_stat,'');
			SELF.address_1																		:= if(DidMatch, L.address_1,'');
			SELF.address_2																		:= if(DidMatch, L.address_2,'');
			SELF.additional_address.street_1									:= if(DidMatch,	L.additional_address.street_1,'');
			SELF.additional_address.street_2									:= if(DidMatch,	L.additional_address.street_2,'');
			SELF.additional_address.city											:= if(DidMatch,	L.additional_address.city,'');
			SELF.additional_address.state											:= if(DidMatch,	L.additional_address.state,'');
			SELF.additional_address.zip												:= if(DidMatch,	L.additional_address.zip,'');
			SELF.additional_address.address_type							:= if(DidMatch,	L.additional_address.address_type,'');
			SELF.additional_address.address_1									:= if(DidMatch,	L.additional_address.address_1,'');
			SELF.additional_address.address_2									:= if(DidMatch,	L.additional_address.address_2,'');
			SELF.additional_address.clean_address.prim_range	:= if(DidMatch, L.additional_address.clean_address.prim_range,'');
			SELF.additional_address.clean_address.predir			:= if(DidMatch, L.additional_address.clean_address.predir,'');
			SELF.additional_address.clean_address.prim_name		:= if(DidMatch, L.additional_address.clean_address.prim_name,'');
			SELF.additional_address.clean_address.addr_suffix	:= if(DidMatch, L.additional_address.clean_address.addr_suffix,'');
			SELF.additional_address.clean_address.postdir			:= if(DidMatch, L.additional_address.clean_address.postdir,'');
			SELF.additional_address.clean_address.unit_desig	:= if(DidMatch, L.additional_address.clean_address.unit_desig,'');
			SELF.additional_address.clean_address.sec_range		:= if(DidMatch, L.additional_address.clean_address.sec_range,'');
			SELF.additional_address.clean_address.p_city_name	:= if(DidMatch, L.additional_address.clean_address.p_city_name,'');
			SELF.additional_address.clean_address.v_city_name	:= if(DidMatch, L.additional_address.clean_address.v_city_name,'');
			SELF.additional_address.clean_address.st					:= if(DidMatch, L.additional_address.clean_address.st,'');
			SELF.additional_address.clean_address.zip					:= if(DidMatch, L.additional_address.clean_address.zip,'');
			SELF.additional_address.clean_address.zip4				:= if(DidMatch, L.additional_address.clean_address.zip4,'');
			SELF.additional_address.clean_address.cart				:= if(DidMatch, L.additional_address.clean_address.cart,'');
			SELF.additional_address.clean_address.cr_sort_sz	:= if(DidMatch, L.additional_address.clean_address.cr_sort_sz,'');
			SELF.additional_address.clean_address.lot					:= if(DidMatch, L.additional_address.clean_address.lot,'');
			SELF.additional_address.clean_address.lot_order		:= if(DidMatch, L.additional_address.clean_address.lot_order,'');
			SELF.additional_address.clean_address.dbpc				:= if(DidMatch, L.additional_address.clean_address.dbpc,'');
			SELF.additional_address.clean_address.chk_digit		:= if(DidMatch, L.additional_address.clean_address.chk_digit,'');
			SELF.additional_address.clean_address.rec_type		:= if(DidMatch, L.additional_address.clean_address.rec_type,'');
			SELF.additional_address.clean_address.fips_state 	:= if(DidMatch, L.additional_address.clean_address.fips_state,'');
			SELF.additional_address.clean_address.fips_county	:= if(DidMatch, L.additional_address.clean_address.fips_county,'');
			SELF.additional_address.clean_address.geo_lat			:= if(DidMatch, L.additional_address.clean_address.geo_lat,'');
			SELF.additional_address.clean_address.geo_long		:= if(DidMatch, L.additional_address.clean_address.geo_long,'');
			SELF.additional_address.clean_address.msa					:= if(DidMatch, L.additional_address.clean_address.msa,'');
			SELF.additional_address.clean_address.geo_blk			:= if(DidMatch, L.additional_address.clean_address.geo_blk,'');
			SELF.additional_address.clean_address.geo_match		:= if(DidMatch, L.additional_address.clean_address.geo_match,'');
			SELF.additional_address.clean_address.err_stat		:= if(DidMatch, L.additional_address.clean_address.err_stat,'');
			SELF																							:= L;
			END;
			
			
pDid_Pii_Clean	:= Project(with_did_rawlinkid,T_Did_Pii_Clean(Left));

//Join with previous delta to extract previous record_id if any match found.

jdid_pii_clean := Join(Previous_delta,pDid_Pii_Clean,
												left.source=right.source
											and left.source_rec_id = right.source_rec_id
											,Transform(recordof(right)
											,self.record_id := if(left.source=right.source and left.source_rec_id=right.source_rec_id,left.record_id,right.record_id)
											,self:=right)
											,right outer);
Main_Clean	:= Non_Deltabase + without_did + with_did_no_rawlinkid + jdid_pii_clean;

Return Main_Clean;

END;