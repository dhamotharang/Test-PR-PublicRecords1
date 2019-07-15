	IMPORT AID,Address;

	EXPORT layouts := MODULE
	
export input	:=record
	string40 orig_HHID
 ,string20 orig_PID
 ,string30 orig_FNAME
 ,string1 orig_MNAME
 ,string30 orig_LNAME
 ,string10 orig_SUFFIX
 ,string1 orig_GENDER
 ,string2 orig_AGE
 ,string6 orig_DOB
 ,string1 orig_HHNBR
 ,string1 orig_TOT_MALES
 ,string1 orig_TOT_FEMALES
 ,string20 orig_ADDRID
 ,string64 orig_ADDRESS
 ,string10 orig_HOUSE
 ,string2 orig_PREDIR
 ,string28 orig_STREET
 ,string4 orig_STRTYPE
 ,string2 orig_POSTDIR
 ,string4 orig_APTTYPE
 ,string8 orig_APTNBR
 ,string28 orig_CITY
 ,string2 orig_STATE
 ,string5 orig_ZIP
 ,string4 orig_Z4
 ,string3 orig_DPC
 ,string1 orig_Z4TYPE
 ,string4 orig_CRTE
 ,string1 orig_DPV
 ,string1 orig_VACANT
 ,string4 orig_MSA
 ,string5 orig_CBSA
 ,string3 orig_County_Code
 ,string1 orig_Time_Zone
 ,string1 orig_Daylight_Savings
 ,string1 orig_Lat_Long_Assignment_Level
 ,string11 orig_Latitude
 ,string11 orig_Longitude
 ,string10 orig_TelephoneNumber_1
 ,string1 orig_ValidationFlag_1
 ,string8 orig_ValidationDate_1
 ,string1 orig_DMA_TPS_DNC_Flag_1
 ,string10 orig_TelephoneNumber_2
 ,string1 orig_Validation_Flag_2
 ,string8 orig_Validation_Date_2
 ,string1 orig_DMA_TPS_DNC_Flag_2
 ,string10 orig_TelephoneNumber_3
 ,string1 orig_ValidationFlag_3
 ,string8 orig_ValidationDate_3
 ,string1 orig_DMA_TPS_DNC_Flag_3
 ,string10 orig_TelephoneNumber_4
 ,string1 orig_ValidationFlag_4
 ,string8 orig_ValidationDate_4
 ,string1 orig_DMA_TPS_DNC_Flag_4
 ,string10 orig_TelephoneNumber_5
 ,string1 orig_ValidationFlag_5
 ,string8 orig_ValidationDate_5
 ,string1 orig_DMA_TPS_DNC_Flag_5
 ,string10 orig_TelephoneNumber_6
 ,string1 orig_ValidationFlag_6
 ,string8 orig_ValidationDate_6
 ,string1 orig_DMA_TPS_DNC_Flag_6
 ,string10 orig_TelephoneNumber_7
 ,string1 orig_ValidationFlag_7
 ,string8 orig_ValidationDate_7
 ,string1 orig_DMA_TPS_DNC_Flag_7
 ,string1 orig_TOT_PHONES
 ,string3 orig_Length_of_Residence
 ,string1 orig_Homeowner
 ,string1 orig_EstimatedIncome
 ,string1 orig_Dwelling_Type
 ,string1 orig_Married
 ,string1 orig_CHILD
 ,string1 orig_NBRCHILD
 ,string1 orig_TeenCD
 ,string1 orig_Percent_Range_Black
 ,string1 orig_Percent_Range_White
 ,string1 orig_Percent_Range_Hispanic
 ,string1 orig_Percent_Range_Asian
 ,string1 orig_Percent_Range_English_Speaking
 ,string1 orig_Percnt_Range_Spanish_Speaking
 ,string1 orig_Percent_Range_Asian_Speaking
 ,string1 orig_Percent_Range_SFDU
 ,string1 orig_Percent_Range_MFDU
 ,string1 orig_MHV
 ,string1 orig_MOR
 ,string1 orig_CAR
 ,string3 orig_MEDSCHL
 ,string1 orig_Penetration_Range_WhiteCollar 
 ,string1 orig_Penetration_Range_BlueCollar
 ,string1 orig_Penetration_Range_OtherOccupation 
 ,string1 orig_DEMOLEVEL
 ,string6 orig_RECDATE
end;	
	

export orig_base	:=record
  input;
	address.Layout_Clean_Name.title;
  address.Layout_Clean_Name.fname;
  address.Layout_Clean_Name.mname;
  address.Layout_Clean_Name.lname;
  address.Layout_Clean_Name.name_suffix;
	address.Layout_Clean182.prim_range;
	address.Layout_Clean182.predir;
	address.Layout_Clean182.prim_name;
	address.Layout_Clean182.addr_suffix;
	address.Layout_Clean182.postdir;
	address.Layout_Clean182.unit_desig;
	address.Layout_Clean182.sec_range;
	address.Layout_Clean182.p_city_name;
	address.Layout_Clean182.v_city_name;
	address.Layout_Clean182.st;
	address.Layout_Clean182.zip;
	address.Layout_Clean182.zip4;
	address.Layout_Clean182.cart;
	address.Layout_Clean182.cr_sort_sz;
	address.Layout_Clean182.lot;
	address.Layout_Clean182.lot_order;
	address.Layout_Clean182.dbpc;
	address.Layout_Clean182.chk_digit;
	address.Layout_Clean182.rec_type;
	string2	fips_st				:='';
	string3	fips_county		:='';
	address.Layout_Clean182.geo_lat;
	address.Layout_Clean182.geo_long;
	address.Layout_Clean182.msa;
	address.Layout_Clean182.geo_blk;
	address.Layout_Clean182.geo_match;
	address.Layout_Clean182.err_stat;
	UNSIGNED6 did 				:= 0;	
	UNSIGNED1 did_score 	:= 0;
	string10 	clean_Phone;
	string8 	clean_DOB;	
	string8 	date_first_seen  	:= 	'0';
	string8 	date_last_seen 		:=	'0';
	UNSIGNED6 Date_vendor_first_reported;
	UNSIGNED6 Date_vendor_last_reported;
	string1 record_type;
	string2 src;
	AID.Common.xAID		RawAID;
	end;
	
	
export base	:=record
 input;
 address.Layout_Clean_Name.title;
 address.Layout_Clean_Name.fname;
 address.Layout_Clean_Name.mname;
 address.Layout_Clean_Name.lname;
 address.Layout_Clean_Name.name_suffix;
 address.Layout_Clean182.prim_range;
 address.Layout_Clean182.predir;
 address.Layout_Clean182.prim_name;
 address.Layout_Clean182.addr_suffix;
 address.Layout_Clean182.postdir;
 address.Layout_Clean182.unit_desig;
 address.Layout_Clean182.sec_range;
 address.Layout_Clean182.p_city_name;
 address.Layout_Clean182.v_city_name;
 address.Layout_Clean182.st;
 address.Layout_Clean182.zip;
 address.Layout_Clean182.zip4;
 address.Layout_Clean182.cart;
 address.Layout_Clean182.cr_sort_sz;
 address.Layout_Clean182.lot;
 address.Layout_Clean182.lot_order;
 address.Layout_Clean182.dbpc;
 address.Layout_Clean182.chk_digit;
 address.Layout_Clean182.rec_type;
 string2		fips_st:='';
 string3		fips_county:='';
 address.Layout_Clean182.geo_lat;
 address.Layout_Clean182.geo_long;
 address.Layout_Clean182.msa;
 address.Layout_Clean182.geo_blk;
 address.Layout_Clean182.geo_match;
 address.Layout_Clean182.err_stat;
 UNSIGNED6 did 							:= 0;	
 UNSIGNED1 did_score 				:= 0;
 string10  clean_Phone;
 string8	clean_DOB;	
 string8 	date_first_seen  	:='0';
 string8 	date_last_seen 		:='0';
 UNSIGNED6 Date_vendor_first_reported;
 UNSIGNED6 Date_vendor_last_reported;
 string1  record_type;
 string2 	src;
 AID.Common.xAID		RawAID;
 UNSIGNED6 LexHHID 					:= 0;
 //Added for CCPA-10
 UNSIGNED4 global_sid;
 UNSIGNED8 record_sid;
 end;
	
END;