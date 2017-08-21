import address;
export Layouts := module

export Layout_In_ebcdic := record
	ebcdic string2		State_Code	;
	ebcdic string1		Record_Type	;
	ebcdic string7		Batch_Creation_Date	;
	ebcdic string6		Batch_Creation_Time	;
	ebcdic string10		House	;
	ebcdic string2		Street_Direction_Prefix	;
	ebcdic string28		Street	;
	ebcdic string4		Street_Suffix	;
	ebcdic string2		Street_Direction_Post	;
	ebcdic string5		Zip_Code	;
	ebcdic string8		PO_Box	;
	ebcdic string4		Unit_Designator	;
	ebcdic string8		Unit	;
	ebcdic string30		City_Standardized	;
	ebcdic string30		City_Alternate_Name	;
	ebcdic string4		Zip_4	;
	ebcdic string7		Phone_Number	;
	ebcdic string3		Phone_Area_Code	;
	ebcdic string1		Phone_Listing	;
	ebcdic string7		Verified_Date	;
	ebcdic string7		Date_of_Knowledge	;
	ebcdic string20		Surname	;
	ebcdic string1		Primary_Occupant_Type	;
	ebcdic string25		Primary_Occupant_First_Name	;
	ebcdic string1		Primary_Occupant_Middle_Initial	;
	ebcdic string6		Primary_Occupant_Title	;
	ebcdic string7		Primary_Occupant_Date_of_Birth	;
	ebcdic string1		Primary_Occupant_Sex	;
	ebcdic string1		Secondary_Occupant_Type	;
	ebcdic string25		Secondary_Occupant_First_Name	;
	ebcdic string1		Secondary_Occupant_Middle_Initial	;
	ebcdic string6		Secondary_Occupant_Title	;
	ebcdic string7		Secondary_Occupant_Date_of_Birth	;
	ebcdic string1		Secondary_Occupant_Sex	;
	ebcdic string1		Third_Occupant_Type	;
	ebcdic string25		Third_Occupant_First_Name	;
	ebcdic string1		Third_Occupant_Middle_Initial	;
	ebcdic string6		Third_Occupant_Title	;
	ebcdic string7		Third_Occupant_Date_of_Birth	;
	ebcdic string1		Third_Occupant_Sex	;
	ebcdic string1		Fourth_Occupant_Type	;
	ebcdic string25		Fourth_Occupant_First_Name	;
	ebcdic string1		Fourth_Occupant_Middle_Initial	;
	ebcdic string6		Fourth_Occupant_Title	;
	ebcdic string7		Fourth_Occupant_Date_of_Birth	;
	ebcdic string1		Fourth_Occupant_Sex	;
	ebcdic string1		Fifth_Occupant_Type	;
	ebcdic string25		Fifth_Occupant_First_Name	;
	ebcdic string1		Fifth_Occupant_Middle_Initial	;
	ebcdic string6		Fifth_Occupant_Title	;
	ebcdic string7		Fifth_Occupant_Date_of_Birth	;
	ebcdic string1		Fifth_Occupant_Sex	;
	ebcdic string4		FillerDwelling_Size_Code	;
	ebcdic string3		FillerHomeowner_Probability	;
	ebcdic string5		FillerMedian_Home_Value	;
	ebcdic string1		AddDelete_Indicator	;
	ebcdic string10		MM_Reference_Sequence_Number	;
	ebcdic string1		DOB1_Indicator	;
	ebcdic string1		DOB2_Indicator	;
	ebcdic string1		DOB3_Indicator	;
	ebcdic string1		DOB4_Indicator	;
	ebcdic string1		DOB5_Indicator	;
end;

export Layout_In := record
	string2		State_Code	;
	string1		Record_Type	;
	string7		Batch_Creation_Date	;
	string6		Batch_Creation_Time	;
	string10	House	;
	string2		Street_Direction_Prefix	;
	string28	Street	;
	string4		Street_Suffix	;
	string2		Street_Direction_Post	;
	string5		Zip_Code	;
	string8		PO_Box	;
	string4		Unit_Designator	;
	string8		Unit	;
	string30	City_Standardized	;
	string30	City_Alternate_Name	;
	string4		Zip_4	;
	string7		Phone_Number	;
	string3		Phone_Area_Code	;
	string1		Phone_Listing	;
	string7		Verified_Date	;
	string7		Date_of_Knowledge	;
	string20	Surname	;
	string1		Primary_Occupant_Type	;
	string25	Primary_Occupant_First_Name	;
	string1		Primary_Occupant_Middle_Initial	;
	string6		Primary_Occupant_Title	;
	string7		Primary_Occupant_Date_of_Birth	;
	string1		Primary_Occupant_Sex	;
	string1		Secondary_Occupant_Type	;
	string25	Secondary_Occupant_First_Name	;
	string1		Secondary_Occupant_Middle_Initial	;
	string6		Secondary_Occupant_Title	;
	string7		Secondary_Occupant_Date_of_Birth	;
	string1		Secondary_Occupant_Sex	;
	string1		Third_Occupant_Type	;
	string25	Third_Occupant_First_Name	;
	string1		Third_Occupant_Middle_Initial	;
	string6		Third_Occupant_Title	;
	string7		Third_Occupant_Date_of_Birth	;
	string1		Third_Occupant_Sex	;
	string1		Fourth_Occupant_Type	;
	string25	Fourth_Occupant_First_Name	;
	string1		Fourth_Occupant_Middle_Initial	;
	string6		Fourth_Occupant_Title	;
	string7		Fourth_Occupant_Date_of_Birth	;
	string1		Fourth_Occupant_Sex	;
	string1		Fifth_Occupant_Type	;
	string25	Fifth_Occupant_First_Name	;
	string1		Fifth_Occupant_Middle_Initial	;
	string6		Fifth_Occupant_Title	;
	string7		Fifth_Occupant_Date_of_Birth	;
	string1		Fifth_Occupant_Sex	;
	string4		FillerDwelling_Size_Code	;
	string3		FillerHomeowner_Probability	;
	string5		FillerMedian_Home_Value	;
	string1		AddDelete_Indicator	;
	string10	MM_Reference_Sequence_Number	;
	string1		DOB1_Indicator	;
	string1		DOB2_Indicator	;
	string1		DOB3_Indicator	;
	string1		DOB4_Indicator	;
	string1		DOB5_Indicator	;
end;

export Layout_name := record
  string46 Norm_Occupant_Name
end;


export Layout_name_clean := record
	string46    Norm_Occupant_Name;
	string73	Clean_name	;
end;


export Layout_address := record
	string10	House	;
	string2		Street_Direction_Prefix	;
	string28	Street	;
	string4		Street_Suffix	;
	string2		Street_Direction_Post	;
	string8		PO_Box	;
	string4		Unit_Designator	;
	string8		Unit	;
	string30	City_Standardized	;
	string30	City_Alternate_Name	;
	string5		Zip_Code	;
	string4		Zip_4	;
	string2		State_Code	;
end;

export Layout_address_clean := record
	Layout_address;
	string182   clean_addr;
end;

export Layout_name_norm := record
	 Layout_In;
	 unsigned1  Occupant_Number;
	 string1	Norm_Occupant_Type	;
	 string46	Norm_Occupant_Name	;
	 string6	Norm_Occupant_Title	;
	 string7	Norm_Occupant_Date_of_Birth	;
	 string1	Norm_Occupant_Sex	;
	 string1	Norm_DOB_Indicator	;
end;


export Layout_name_norm_clean_name := record
	 Layout_name_norm;
	 string73 clean_name;
end;

export Layout_Base := record
     Layout_name_norm_clean_name;
	 string8	clean_DOB	;
	 string10   clean_phone;
	 address.Layout_Clean_Name.title;
	 address.Layout_Clean_Name.fname;
	 address.Layout_Clean_Name.mname;
	 address.Layout_Clean_Name.lname;
	 address.Layout_Clean_Name.name_suffix;
	 address.Layout_Clean_Name.name_score;
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
	 address.Layout_Clean182.county;
	 address.Layout_Clean182.geo_lat;
	 address.Layout_Clean182.geo_long;
	 address.Layout_Clean182.msa;
	 address.Layout_Clean182.geo_blk;
	 address.Layout_Clean182.geo_match;
	 address.Layout_Clean182.err_stat;
	 string8  date_first_seen := '';
	 string8  date_last_seen := '';
	 string8  date_vendor_first_reported := '';
	 string8  date_vendor_last_reported := '';
	 unsigned6	did       :=0;
	 unsigned1	did_score :=0;
	 string1  latest_file_flag;  //Flag to indicate if the record came in the latest update file
end;
end;