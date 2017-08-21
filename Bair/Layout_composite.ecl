import address,BIPV2;

EXPORT Layout_composite := RECORD

		unsigned1   Prepped_rec_type:=0
		,unsigned6 eid_hash:=0
		,string23 eid:=''

		,UNSIGNED2 data_provider_id
		,STRING73 incident
		,STRING crime
		,string name_type
		,STRING orig_address
		,STRING50 orig_city
		,STRING5 orig_st
		,string10 orig_zip

		,string100 orig_sid
		,STRING27 vin
		,STRING25 plate
		,STRING30 plate_st
		,STRING41 make
		,STRING50 model
		,STRING30 style
		,STRING20 color
		,STRING8 year
		,string18  latitude
		,string20  longitude
		,STRING36 dl
		,STRING24 dl_st
		,string10  phone:=''
		,unsigned4  dob:=0
		,unsigned4  age:=0
		,string9  possible_ssn:=''

		,STRING50 orig_officer
		,STRING125 orig_name
		,STRING100 orig_moniker
		,string    orig_gender

		,STRING3 name_hint
		,STRING100 Prepped_name

		,STRING100 clean_company_name
		,address.Layout_Clean_Name.title
		,address.Layout_Clean_Name.fname
		,address.Layout_Clean_Name.mname
		,address.Layout_Clean_Name.lname
		,address.Layout_Clean_Name.name_suffix
		,string	Clean_gender
		,Integer	class_code
		,unsigned4 dt_first_seen:=0
		,unsigned4 dt_last_seen:=0
		,unsigned4 dt_vendor_first_reported:=0
		,unsigned4 dt_vendor_last_reported:=0

		,String60  Prepped_addr1:=''
		,String35  Prepped_addr2:=''

		,address.Layout_Clean182.prim_range
		,address.Layout_Clean182.predir
		,address.Layout_Clean182.prim_name
		,address.Layout_Clean182.addr_suffix
		,address.Layout_Clean182.postdir
		,address.Layout_Clean182.unit_desig
		,address.Layout_Clean182.sec_range
		,address.Layout_Clean182.p_city_name
		,address.Layout_Clean182.v_city_name
		,address.Layout_Clean182.st
		,address.Layout_Clean182.zip
		,address.Layout_Clean182.zip4
		,address.Layout_Clean182.cart
		,address.Layout_Clean182.cr_sort_sz
		,address.Layout_Clean182.lot
		,address.Layout_Clean182.lot_order
		,address.Layout_Clean182.dbpc
		,address.Layout_Clean182.chk_digit
		,address.Layout_Clean182.rec_type
		,string2		fips_st:=''
		,string3		county:=''
		,address.Layout_Clean182.geo_lat
		,address.Layout_Clean182.geo_long
		,address.Layout_Clean182.msa
		,address.Layout_Clean182.geo_blk
		,address.Layout_Clean182.geo_match
		,address.Layout_Clean182.err_stat

		,unsigned8 lexid:=0
		,unsigned1 lexid_score:=0

		,unsigned2 xadl2_Weight
		,unsigned2 xadl2_Score 
		,unsigned4 xadl2_keys_used // A bitmap of the keys used
		,unsigned2 xadl2_distance 
		,string20 xadl2_matches // Indicator of what fields contributed to the DID match.

		,UNSIGNED6 bdid:=0
		,UNSIGNED1 bdid_score := 0
		,BIPV2.IDlayouts.l_xlink_ids

 END;