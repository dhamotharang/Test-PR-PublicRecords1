import address,AID;
export Layouts := module

	export load
	:=
	record
	// CONSUMER_ID
		string15 EXPERIAN_ENCRYPTED_PIN
		,string21 FILLERA1
	// CONSUMER_NAME_SECTION
		,string8 CONS_CRDT_CCYYMMDD
		,string8 FILLERA2

		,string32 LASTNAME
		,string32 FIRSTNAME
		,string32 MIDDLE_NAME
		,string32 SECOND_LASTNAME
		,string32 SPOUSE_FIRSTNAME
		,string1 GENERATION_CODE

	// CURRENT_ADDRESS_SECTION
		,string8 ADDR_CRDT_CCYYMMDD
		,string8 ADDR_UPDT_CCYYMMDD
		,string10 STREET_ID
		,string2 PRE_DIR
		,string32 STREET_NAME
		,string4 STREET_SUFFIX
		,string2 POST_DIR
		,string4 UNIT_TYPE
		,string8 UNIT_ID
		,string32 CITY_NAME
		,string2 STATE
		,string5    ZIP_CODE
		,string4    ZIP_PLUS_FOUR

	// CONSUMER_DATA_SECTION
		,string9 SSN
		,string8 DOB_CCYYMMDD
		,string10 PHONE_NUMBER
		,string1 GENDER
		,string9 FILLERB1

	// MISCELLANEOUS_DATA_SECTION
		,string32    RESERVED_FOR_FUTURE_USE

	// ADDITIONAL_NAMES_SECTION
		,string2 ADD_COUNT

		,string8 ADD_CREATE_DATE_1
		,string8 FILLER_1
		,string32 ADD_LASTNAME_1
		,string32 ADD_FIRSTNAME_1
		,string32 ADD_MIDDLE_NAME_1
		,string32 ADD_SECOND_LASTNAME_1
		,string1 ADD_GENERATION_CODE_1

		,string8 ADD_CREATE_DATE_2
		,string8 FILLER_2
		,string32 ADD_LASTNAME_2
		,string32 ADD_FIRSTNAME_2
		,string32 ADD_MIDDLE_NAME_2
		,string32 ADD_SECOND_LASTNAME_2
		,string1 ADD_GENERATION_CODE_2

		,string8 ADD_CREATE_DATE_3
		,string8 FILLER_3
		,string32 ADD_LASTNAME_3
		,string32 ADD_FIRSTNAME_3
		,string32 ADD_MIDDLE_NAME_3
		,string32 ADD_SECOND_LASTNAME_3
		,string1 ADD_GENERATION_CODE_3

	// PREV_ADDRESS_SECTION
		,string2 PREVADDR_COUNT

		,string8 PA_CRDT_CCYYMMDD_1
		,string8 PA_UPDT_CCYYMMDD_1
		,string10 PA_STREET_ID_1
		,string2 PA_PRE_DIR_1
		,string32 PA_STREET_NAME_1
		,string4 PA_STREET_SUFFIX_1
		,string2 PA_POST_DIR_1
		,string4 PA_UNIT_TYPE_1
		,string8 PA_UNIT_ID_1
		,string32 PA_CITY_NAME_1
		,string2 PA_STATE_1
		,string5 PA_ZIPCODE_1
		,string4 PA_ZIP4_1
		,string1 PA_FILLER_1

		,string8 PA_CRDT_CCYYMMDD_2
		,string8 PA_UPDT_CCYYMMDD_2
		,string10 PA_STREET_ID_2
		,string2 PA_PRE_DIR_2
		,string32 PA_STREET_NAME_2
		,string4 PA_STREET_SUFFIX_2
		,string2 PA_POST_DIR_2
		,string4 PA_UNIT_TYPE_2
		,string8 PA_UNIT_ID_2
		,string32 PA_CITY_NAME_2
		,string2 PA_STATE_2
		,string5 PA_ZIPCODE_2
		,string4 PA_ZIP4_2
		,string1 PA_FILLER_2

		,string8 PA_CRDT_CCYYMMDD_3
		,string8 PA_UPDT_CCYYMMDD_3
		,string10 PA_STREET_ID_3
		,string2 PA_PRE_DIR_3
		,string32 PA_STREET_NAME_3
		,string4 PA_STREET_SUFFIX_3
		,string2 PA_POST_DIR_3
		,string4 PA_UNIT_TYPE_3
		,string8 PA_UNIT_ID_3
		,string32 PA_CITY_NAME_3
		,string2 PA_STATE_3
		,string5 PA_ZIPCODE_3
		,string4 PA_ZIP4_3
		,string1 PA_FILLER_3

		,string8 PA_CRDT_CCYYMMDD_4
		,string8 PA_UPDT_CCYYMMDD_4
		,string10 PA_STREET_ID_4
		,string2 PA_PRE_DIR_4
		,string32 PA_STREET_NAME_4
		,string4 PA_STREET_SUFFIX_4
		,string2 PA_POST_DIR_4
		,string4 PA_UNIT_TYPE_4
		,string8 PA_UNIT_ID_4
		,string32 PA_CITY_NAME_4
		,string2 PA_STATE_4
		,string5 PA_ZIPCODE_4
		,string4 PA_ZIP4_4
		,string1 FILLER_4

		,string8 PA_CRDT_CCYYMMDD_5
		,string8 PA_UPDT_CCYYMMDD_5
		,string10 PA_STREET_ID_5
		,string2 PA_PRE_DIR_5
		,string32 PA_STREET_NAME_5
		,string4 PA_STREET_SUFFIX_5
		,string2 PA_POST_DIR_5
		,string4 PA_UNIT_TYPE_5
		,string8 PA_UNIT_ID_5
		,string32 PA_CITY_NAME_5
		,string2 PA_STATE_5
		,string5 PA_ZIPCODE_5
		,string4 PA_ZIP4_5
		,string1 FILLER_5

		,string8 PA_CRDT_CCYYMMDD_6
		,string8 PA_UPDT_CCYYMMDD_6
		,string10 PA_STREET_ID_6
		,string2 PA_PRE_DIR_6
		,string32 PA_STREET_NAME_6
		,string4 PA_STREET_SUFFIX_6
		,string2 PA_POST_DIR_6
		,string4 PA_UNIT_TYPE_6
		,string8 PA_UNIT_ID_6
		,string32 PA_CITY_NAME_6
		,string2 PA_STATE_6
		,string5 PA_ZIPCODE_6
		,string4 PA_ZIP4_6
		,string1 FILLER_6

		,string8 PA_CRDT_CCYYMMDD_7
		,string8 PA_UPDT_CCYYMMDD_7
		,string10 PA_STREET_ID_7
		,string2 PA_PRE_DIR_7
		,string32 PA_STREET_NAME_7
		,string4 PA_STREET_SUFFIX_7
		,string2 PA_POST_DIR_7
		,string4 PA_UNIT_TYPE_7
		,string8 PA_UNIT_ID_7
		,string32 PA_CITY_NAME_7
		,string2 PA_STATE_7
		,string5 PA_ZIPCODE_7
		,string4 PA_ZIP4_7
		,string1 FILLER_7

		,string8 PA_CRDT_CCYYMMDD_8
		,string8 PA_UPDT_CCYYMMDD_8
		,string10 PA_STREET_ID_8
		,string2 PA_PRE_DIR_8
		,string32 PA_STREET_NAME_8
		,string4 PA_STREET_SUFFIX_8
		,string2 PA_POST_DIR_8
		,string4 PA_UNIT_TYPE_8
		,string8 PA_UNIT_ID_8
		,string32 PA_CITY_NAME_8
		,string2 PA_STATE_8
		,string5 PA_ZIPCODE_8
		,string4 PA_ZIP4_8
		,string1 FILLER_8

		,string8 PA_CRDT_CCYYMMDD_9
		,string8 PA_UPDT_CCYYMMDD_9
		,string10 PA_STREET_ID_9
		,string2 PA_PRE_DIR_9
		,string32 PA_STREET_NAME_9
		,string4 PA_STREET_SUFFIX_9
		,string2 PA_POST_DIR_9
		,string4 PA_UNIT_TYPE_9
		,string8 PA_UNIT_ID_9
		,string32 PA_CITY_NAME_9
		,string2 PA_STATE_9
		,string5 PA_ZIPCODE_9
		,string4 PA_ZIP4_9
		,string1 FILLER_9

		,string8 PA_CRDT_CCYYMMDD_10
		,string8 PA_UPDT_CCYYMMDD_10
		,string10 PA_STREET_ID_10
		,string2 PA_PRE_DIR_10
		,string32 PA_STREET_NAME_10
		,string4 PA_STREET_SUFFIX_10
		,string2 PA_POST_DIR_10
		,string4 PA_UNIT_TYPE_10
		,string8 PA_UNIT_ID_10
		,string32 PA_CITY_NAME_10
		,string2 PA_STATE_10
		,string5 PA_ZIPCODE_10
		,string4 PA_ZIP4_10
		,string1 FILLER_10

		,string8 PA_CRDT_CCYYMMDD_11
		,string8 PA_UPDT_CCYYMMDD_11
		,string10 PA_STREET_ID_11
		,string2 PA_PRE_DIR_11
		,string32 PA_STREET_NAME_11
		,string4 PA_STREET_SUFFIX_11
		,string2 PA_POST_DIR_11
		,string4 PA_UNIT_TYPE_11
		,string8 PA_UNIT_ID_11
		,string32 PA_CITY_NAME_11
		,string2 PA_STATE_11
		,string5 PA_ZIPCODE_11
		,string4 PA_ZIP4_11
		,string1 FILLER_11

		,string8 PA_CRDT_CCYYMMDD_12
		,string8 PA_UPDT_CCYYMMDD_12
		,string10 PA_STREET_ID_12
		,string2 PA_PRE_DIR_12
		,string32 PA_STREET_NAME_12
		,string4 PA_STREET_SUFFIX_12
		,string2 PA_POST_DIR_12
		,string4 PA_UNIT_TYPE_12
		,string8 PA_UNIT_ID_12
		,string32 PA_CITY_NAME_12
		,string2 PA_STATE_12
		,string5 PA_ZIPCODE_12
		,string4 PA_ZIP4_12
		,string1 FILLER_12

		,string8 PA_CRDT_CCYYMMDD_13
		,string8 PA_UPDT_CCYYMMDD_13
		,string10 PA_STREET_ID_13
		,string2 PA_PRE_DIR_13
		,string32 PA_STREET_NAME_13
		,string4 PA_STREET_SUFFIX_13
		,string2 PA_POST_DIR_13
		,string4 PA_UNIT_TYPE_13
		,string8 PA_UNIT_ID_13
		,string32 PA_CITY_NAME_13
		,string2 PA_STATE_13
		,string5 PA_ZIPCODE_13
		,string4 PA_ZIP4_13
		,string1 FILLER_13

		,string8 PA_CRDT_CCYYMMDD_14
		,string8 PA_UPDT_CCYYMMDD_14
		,string10 PA_STREET_ID_14
		,string2 PA_PRE_DIR_14
		,string32 PA_STREET_NAME_14
		,string4 PA_STREET_SUFFIX_14
		,string2 PA_POST_DIR_14
		,string4 PA_UNIT_TYPE_14
		,string8 PA_UNIT_ID_14
		,string32 PA_CITY_NAME_14
		,string2 PA_STATE_14
		,string5 PA_ZIPCODE_14
		,string4 PA_ZIP4_14
		,string1 FILLER_14

		,string8 PA_CRDT_CCYYMMDD_15
		,string8 PA_UPDT_CCYYMMDD_15
		,string10 PA_STREET_ID_15
		,string2 PA_PRE_DIR_15
		,string32 PA_STREET_NAME_15
		,string4 PA_STREET_SUFFIX_15
		,string2 PA_POST_DIR_15
		,string4 PA_UNIT_TYPE_15
		,string8 PA_UNIT_ID_15
		,string32 PA_CITY_NAME_15
		,string2 PA_STATE_15
		,string5 PA_ZIPCODE_15
		,string4 PA_ZIP4_15
		,string1 FILLER_15

		,string8 PA_CRDT_CCYYMMDD_16
		,string8 PA_UPDT_CCYYMMDD_16
		,string10 PA_STREET_ID_16
		,string2 PA_PRE_DIR_16
		,string32 PA_STREET_NAME_16
		,string4 PA_STREET_SUFFIX_16
		,string2 PA_POST_DIR_16
		,string4 PA_UNIT_TYPE_16
		,string8 PA_UNIT_ID_16
		,string32 PA_CITY_NAME_16
		,string2 PA_STATE_16
		,string5 PA_ZIPCODE_16
		,string4 PA_ZIP4_16
		,string1 FILLER_16

		,string8 PA_CRDT_CCYYMMDD_17
		,string8 PA_UPDT_CCYYMMDD_17
		,string10 PA_STREET_ID_17
		,string2 PA_PRE_DIR_17
		,string32 PA_STREET_NAME_17
		,string4 PA_STREET_SUFFIX_17
		,string2 PA_POST_DIR_17
		,string4 PA_UNIT_TYPE_17
		,string8 PA_UNIT_ID_17
		,string32 PA_CITY_NAME_17
		,string2 PA_STATE_17
		,string5 PA_ZIPCODE_17
		,string4 PA_ZIP4_17
		,string1 FILLER_17

		,string8 PA_CRDT_CCYYMMDD_18
		,string8 PA_UPDT_CCYYMMDD_18
		,string10 PA_STREET_ID_18
		,string2 PA_PRE_DIR_18
		,string32 PA_STREET_NAME_18
		,string4 PA_STREET_SUFFIX_18
		,string2 PA_POST_DIR_18
		,string4 PA_UNIT_TYPE_18
		,string8 PA_UNIT_ID_18
		,string32 PA_CITY_NAME_18
		,string2 PA_STATE_18
		,string5 PA_ZIPCODE_18
		,string4 PA_ZIP4_18
		,string1 FILLER_18

		,string8 PA_CRDT_CCYYMMDD_19
		,string8 PA_UPDT_CCYYMMDD_19
		,string10 PA_STREET_ID_19
		,string2 PA_PRE_DIR_19
		,string32 PA_STREET_NAME_19
		,string4 PA_STREET_SUFFIX_19
		,string2 PA_POST_DIR_19
		,string4 PA_UNIT_TYPE_19
		,string8 PA_UNIT_ID_19
		,string32 PA_CITY_NAME_19
		,string2 PA_STATE_19
		,string5 PA_ZIPCODE_19
		,string4 PA_ZIP4_19
		,string1 FILLER_19

		,string8 PA_CRDT_CCYYMMDD_20
		,string8 PA_UPDT_CCYYMMDD_20
		,string10 PA_STREET_ID_20
		,string2 PA_PRE_DIR_20
		,string32 PA_STREET_NAME_20
		,string4 PA_STREET_SUFFIX_20
		,string2 PA_POST_DIR_20
		,string4 PA_UNIT_TYPE_20
		,string8 PA_UNIT_ID_20
		,string32 PA_CITY_NAME_20
		,string2 PA_STATE_20
		,string5 PA_ZIPCODE_20
		,string4 PA_ZIP4_20
		,string1 FILLER_20

		,string8 PA_CRDT_CCYYMMDD_21
		,string8 PA_UPDT_CCYYMMDD_21
		,string10 PA_STREET_ID_21
		,string2 PA_PRE_DIR_21
		,string32 PA_STREET_NAME_21
		,string4 PA_STREET_SUFFIX_21
		,string2 PA_POST_DIR_21
		,string4 PA_UNIT_TYPE_21
		,string8 PA_UNIT_ID_21
		,string32 PA_CITY_NAME_21
		,string2 PA_STATE_21
		,string5 PA_ZIPCODE_21
		,string4 PA_ZIP4_21
		,string1 FILLER_21

		,string8 PA_CRDT_CCYYMMDD_22
		,string8 PA_UPDT_CCYYMMDD_22
		,string10 PA_STREET_ID_22
		,string2 PA_PRE_DIR_22
		,string32 PA_STREET_NAME_22
		,string4 PA_STREET_SUFFIX_22
		,string2 PA_POST_DIR_22
		,string4 PA_UNIT_TYPE_22
		,string8 PA_UNIT_ID_22
		,string32 PA_CITY_NAME_22
		,string2 PA_STATE_22
		,string5 PA_ZIPCODE_22
		,string4 PA_ZIP4_22
		,string1 FILLER_22

		,string8 PA_CRDT_CCYYMMDD_23
		,string8 PA_UPDT_CCYYMMDD_23
		,string10 PA_STREET_ID_23
		,string2 PA_PRE_DIR_23
		,string32 PA_STREET_NAME_23
		,string4 PA_STREET_SUFFIX_23
		,string2 PA_POST_DIR_23
		,string4 PA_UNIT_TYPE_23
		,string8 PA_UNIT_ID_23
		,string32 PA_CITY_NAME_23
		,string2 PA_STATE_23
		,string5 PA_ZIPCODE_23
		,string4 PA_ZIP4_23
		,string1 FILLER_23

		,string8 PA_CRDT_CCYYMMDD_24
		,string8 PA_UPDT_CCYYMMDD_24
		,string10 PA_STREET_ID_24
		,string2 PA_PRE_DIR_24
		,string32 PA_STREET_NAME_24
		,string4 PA_STREET_SUFFIX_24
		,string2 PA_POST_DIR_24
		,string4 PA_UNIT_TYPE_24
		,string8 PA_UNIT_ID_24
		,string32 PA_CITY_NAME_24
		,string2 PA_STATE_24
		,string5 PA_ZIPCODE_24
		,string4 PA_ZIP4_24
		,string1 FILLER_24
		,string4 FILLER 
		,string1 CRLF
	end;

	export update
	:=
	record
		load
	end;

	export deletes
	:=
	record
		load.EXPERIAN_ENCRYPTED_PIN
		,string86 filler
	end;

	export deceased
	:=
	record
		load.EXPERIAN_ENCRYPTED_PIN
		,string86 filler
	end;

	export base
	:=
	record
		string3   Prepped_rec_type:=''
		,boolean   IsUpdating:=false
		,boolean   IsCurrent:=false
		,boolean   IsDelete := false
		,boolean   IsDeceased := false

		,unsigned6 did:=0
		,unsigned  did_score:=0
		,address.Layout_Clean_Name.title
		,address.Layout_Clean_Name.fname
		,address.Layout_Clean_Name.mname
		,address.Layout_Clean_Name.lname
		,address.Layout_Clean_Name.name_suffix

		,unsigned4 dt_first_seen:=0
		,unsigned4 dt_last_seen:=0
		,String60  Prepped_addr1:=''
		,String35  Prepped_addr2:=''

		,unsigned4 dt_vendor_first_reported:=0
		,unsigned4 dt_vendor_last_reported:=0

		,string10  phone:=''
		,string9   ssn:=''
		,integer4  dob:=0

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
		,string3		fips_county:=''
		,address.Layout_Clean182.geo_lat
		,address.Layout_Clean182.geo_long
		,address.Layout_Clean182.msa
		,address.Layout_Clean182.geo_blk
		,address.Layout_Clean182.geo_match
		,address.Layout_Clean182.err_stat

		,AID.Common.xAID	RawAID:=0
		,unsigned8 nid:=0

		,string2 src:='EN'
		,string32 orig_fname
		,string32 orig_mname
		,string32 orig_lname
		,string5 orig_name_suffix

		,string8 orig_crdt_ccyymmdd
		,string8 orig_updt_ccyymmdd
		,string10 orig_prim_range
		,string2 orig_predir
		,string32 orig_prim_name
		,string4 orig_addr_suffix
		,string2 orig_postdir
		,string4 orig_unit_desig
		,string8 orig_sec_range
		,string32 orig_city
		,string2 orig_st
		,string5 orig_zip
		,string4 orig_zip4

		,string9 orig_ssn
		,string8 orig_dob
		,string10 orig_phone
		,string1 orig_gender
		,load.EXPERIAN_ENCRYPTED_PIN
		
	end;

end;