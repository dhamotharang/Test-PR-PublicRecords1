IMPORT FraudShared;
EXPORT Append_PreviousValues (
		dataset(FraudShared.Layouts.Base.Main) FileBase
   ,dataset(FraudShared.Layouts.Base.Main) Previous_Build = FraudShared.Files().Base.Main.QA 
) := FUNCTION

	building_base := distribute(pull(FileBase), hash32(record_id));
	previous_base := distribute(pull(Previous_Build), hash32(record_id)) ;

	J_previous_values := join (
		previous_base,
		building_base,
		left.record_id = right.record_id,
		transform(FraudShared.Layouts.Base.Main,

			// Pull Previous Addresses
			SELF.clean_address.prim_range				:= if(left.record_id=right.record_id, LEFT.clean_address.prim_range,	RIGHT.clean_address.prim_range);
			SELF.clean_address.predir						:= if(left.record_id=right.record_id, LEFT.clean_address.predir,			RIGHT.clean_address.predir);
			SELF.clean_address.prim_name				:= if(left.record_id=right.record_id, LEFT.clean_address.prim_name,		RIGHT.clean_address.prim_name);
			SELF.clean_address.addr_suffix			:= if(left.record_id=right.record_id, LEFT.clean_address.addr_suffix,	RIGHT.clean_address.addr_suffix);
			SELF.clean_address.postdir					:= if(left.record_id=right.record_id, LEFT.clean_address.postdir,			RIGHT.clean_address.postdir);
			SELF.clean_address.unit_desig				:= if(left.record_id=right.record_id, LEFT.clean_address.unit_desig,	RIGHT.clean_address.unit_desig);
			SELF.clean_address.sec_range				:= if(left.record_id=right.record_id, LEFT.clean_address.sec_range,		RIGHT.clean_address.sec_range);
			SELF.clean_address.p_city_name			:= if(left.record_id=right.record_id, LEFT.clean_address.p_city_name,	RIGHT.clean_address.p_city_name);
			SELF.clean_address.v_city_name			:= if(left.record_id=right.record_id, LEFT.clean_address.v_city_name, RIGHT.clean_address.v_city_name);
			SELF.clean_address.st								:= if(left.record_id=right.record_id, LEFT.clean_address.st,					RIGHT.clean_address.st);
			SELF.clean_address.zip							:= if(left.record_id=right.record_id, LEFT.clean_address.zip,					RIGHT.clean_address.zip);
			SELF.clean_address.zip4							:= if(left.record_id=right.record_id, LEFT.clean_address.zip4,				RIGHT.clean_address.zip4);
			SELF.clean_address.cart							:= if(left.record_id=right.record_id, LEFT.clean_address.cart,				RIGHT.clean_address.cart);
			SELF.clean_address.cr_sort_sz				:= if(left.record_id=right.record_id, LEFT.clean_address.cr_sort_sz,	RIGHT.clean_address.cr_sort_sz);
			SELF.clean_address.lot							:= if(left.record_id=right.record_id, LEFT.clean_address.lot,					RIGHT.clean_address.lot);
			SELF.clean_address.lot_order				:= if(left.record_id=right.record_id, LEFT.clean_address.lot_order,		RIGHT.clean_address.lot_order);
			SELF.clean_address.dbpc							:= if(left.record_id=right.record_id, LEFT.clean_address.dbpc,				RIGHT.clean_address.dbpc);
			SELF.clean_address.chk_digit				:= if(left.record_id=right.record_id, LEFT.clean_address.chk_digit,		RIGHT.clean_address.chk_digit);
			SELF.clean_address.rec_type					:= if(left.record_id=right.record_id, LEFT.clean_address.rec_type,		RIGHT.clean_address.rec_type);
			SELF.clean_address.fips_state 			:= if(left.record_id=right.record_id, LEFT.clean_address.fips_state,	RIGHT.clean_address.fips_state);
			SELF.clean_address.fips_county			:= if(left.record_id=right.record_id, LEFT.clean_address.fips_county,	RIGHT.clean_address.fips_county);
			SELF.clean_address.geo_lat					:= if(left.record_id=right.record_id, LEFT.clean_address.geo_lat,			RIGHT.clean_address.geo_lat);
			SELF.clean_address.geo_long					:= if(left.record_id=right.record_id, LEFT.clean_address.geo_long,		RIGHT.clean_address.geo_long);
			SELF.clean_address.msa							:= if(left.record_id=right.record_id, LEFT.clean_address.msa,					RIGHT.clean_address.msa);
			SELF.clean_address.geo_blk					:= if(left.record_id=right.record_id, LEFT.clean_address.geo_blk,			RIGHT.clean_address.geo_blk);
			SELF.clean_address.geo_match				:= if(left.record_id=right.record_id, LEFT.clean_address.geo_match,		RIGHT.clean_address.geo_match);
			SELF.clean_address.err_stat					:= if(left.record_id=right.record_id, LEFT.clean_address.err_stat,		RIGHT.clean_address.err_stat);
			SELF.address_1								:= if(left.record_id=right.record_id, LEFT.address_1, RIGHT.address_1);
			SELF.address_2								:= if(left.record_id=right.record_id, LEFT.address_2, RIGHT.address_2);

			SELF.additional_address.clean_address.prim_range	:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.prim_range,		RIGHT.additional_address.clean_address.prim_range); //prim_range
			SELF.additional_address.clean_address.predir			:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.predir,				RIGHT.additional_address.clean_address.predir); //predir
			SELF.additional_address.clean_address.prim_name		:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.prim_name,		RIGHT.additional_address.clean_address.prim_name); //prim_name
			SELF.additional_address.clean_address.addr_suffix	:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.addr_suffix,	RIGHT.additional_address.clean_address.addr_suffix); //addr_suffix
			SELF.additional_address.clean_address.postdir			:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.postdir,			RIGHT.additional_address.clean_address.postdir); //postdir
			SELF.additional_address.clean_address.unit_desig	:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.unit_desig,		RIGHT.additional_address.clean_address.unit_desig); //unit_desig
			SELF.additional_address.clean_address.sec_range		:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.sec_range,		RIGHT.additional_address.clean_address.sec_range); //sec_range
			SELF.additional_address.clean_address.p_city_name	:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.p_city_name,	RIGHT.additional_address.clean_address.p_city_name); //p_city_name
			SELF.additional_address.clean_address.v_city_name	:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.v_city_name,	RIGHT.additional_address.clean_address.v_city_name); //v_city_name
			SELF.additional_address.clean_address.st					:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.st,						RIGHT.additional_address.clean_address.st); //st
			SELF.additional_address.clean_address.zip					:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.zip,					RIGHT.additional_address.clean_address.zip); //zip
			SELF.additional_address.clean_address.zip4				:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.zip4,					RIGHT.additional_address.clean_address.zip4); //zip4
			SELF.additional_address.clean_address.cart				:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.cart,					RIGHT.additional_address.clean_address.cart); //cart
			SELF.additional_address.clean_address.cr_sort_sz	:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.cr_sort_sz,		RIGHT.additional_address.clean_address.cr_sort_sz); //cr_sort_sz
			SELF.additional_address.clean_address.lot					:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.lot,					RIGHT.additional_address.clean_address.lot); //lot
			SELF.additional_address.clean_address.lot_order		:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.lot_order,		RIGHT.additional_address.clean_address.lot_order); //lot_order
			SELF.additional_address.clean_address.dbpc				:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.dbpc,					RIGHT.additional_address.clean_address.dbpc); //dbpc
			SELF.additional_address.clean_address.chk_digit		:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.chk_digit,		RIGHT.additional_address.clean_address.chk_digit); //chk_digit
			SELF.additional_address.clean_address.rec_type		:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.rec_type,			RIGHT.additional_address.clean_address.rec_type); //rec_type
			SELF.additional_address.clean_address.fips_state	:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.fips_state, 	RIGHT.additional_address.clean_address.fips_state); //fips_state
			SELF.additional_address.clean_address.fips_county	:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.fips_county, 	RIGHT.additional_address.clean_address.fips_county); //fips_county
			SELF.additional_address.clean_address.geo_lat			:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.geo_lat,			RIGHT.additional_address.clean_address.geo_lat); //geo_lat
			SELF.additional_address.clean_address.geo_long		:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.geo_long,			RIGHT.additional_address.clean_address.geo_long); //geo_long
			SELF.additional_address.clean_address.msa					:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.msa,					RIGHT.additional_address.clean_address.msa); //msa
			SELF.additional_address.clean_address.geo_blk			:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.geo_blk,			RIGHT.additional_address.clean_address.geo_blk); //geo_blk
			SELF.additional_address.clean_address.geo_match		:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.geo_match,		RIGHT.additional_address.clean_address.geo_match); //geo_match
			SELF.additional_address.clean_address.err_stat		:= if(left.record_id=right.record_id, LEFT.additional_address.clean_address.err_stat,			RIGHT.additional_address.clean_address.err_stat); //err_stat		
			SELF.additional_address.address_1					:= if(left.record_id=right.record_id, LEFT.address_1, RIGHT.address_1);
			SELF.additional_address.address_2					:= if(left.record_id=right.record_id, LEFT.address_2, RIGHT.address_2);
			
			// Pull Previous DID's
			SELF.did														:= if(left.record_id=right.record_id, LEFT.did, 			RIGHT.did);
			SELF.did_score											:= if(left.record_id=right.record_id, LEFT.did_score, RIGHT.did_score);
			
			SELF := RIGHT),
		RIGHT OUTER,
		LOCAL
	);	

	return (J_previous_values);
END;