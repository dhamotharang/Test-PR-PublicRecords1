import	ut
			 ,American_student_list
			 ,lib_stringlib;

export Proc_rollup_American_Student_List_base(string filedate) :=
function
			 
American_Student_List_base_super	:=	American_student_list.Cleaned_american_student_DID 
																		+ American_student_list.File_american_student_DID;
			 
Dist_Cleaned_american_student_base_super := distribute(American_Student_List_base_super, key);
							   
Sort_Dist_Cleaned_file := sort(Dist_Cleaned_american_student_base_super,local,RECORD,
							   EXCEPT Process_Date, Date_First_Seen, Date_Last_Seen,
							   Date_Vendor_First_Reported, Date_Vendor_Last_Reported);

Layout_outfile := RECORD
	American_student_list.layout_american_student_base;
end;

Layout_outfile  rollupXform(Layout_outfile l, Layout_outfile r) := transform
	self.Process_Date    := if(l.Process_Date > r.Process_Date, l.Process_Date, r.Process_Date);
	self.Date_First_Seen := if(l.Date_First_Seen > r.Date_First_Seen, r.Date_First_Seen, l.Date_First_Seen);
	self.Date_Last_Seen  := if(l.Date_Last_Seen  < r.Date_Last_Seen,  r.Date_Last_Seen,  l.Date_Last_Seen);
	self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
	self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
	self.Age  := if(l.Process_Date > r.Process_Date, l.AGE,r.AGE);
	self.COUNTY_NAME := if(r.COUNTY_NAME != '',r.COUNTY_NAME, l.COUNTY_NAME);
	self := l;
end;

// rollup_American_Student_List_base := rollup(Sort_Dist_Cleaned_file,rollupXform(LEFT,RIGHT),RECORD,
										  // EXCEPT Process_Date, Date_First_Seen, Date_Last_Seen,
										  // Date_Vendor_First_Reported, Date_Vendor_Last_Reported, AGE, COUNTY_NAME, local);

rollup_American_Student_List_base := rollup(Sort_Dist_Cleaned_file,rollupXform(LEFT,RIGHT),
	LEFT.DID = RIGHT.DID AND
	LEFT.KEY = RIGHT.KEY AND
	LEFT.SSN = RIGHT.SSN AND
	LEFT.DID = RIGHT.DID AND
	LEFT.HISTORICAL_FLAG = RIGHT.HISTORICAL_FLAG AND
	LEFT.FULL_NAME = RIGHT.FULL_NAME AND
	LEFT.FIRST_NAME = RIGHT.FIRST_NAME AND
	LEFT.LAST_NAME = RIGHT.LAST_NAME AND
	LEFT.ADDRESS_1 = RIGHT.ADDRESS_1 AND
	LEFT.ADDRESS_2 = RIGHT.ADDRESS_2 AND
	LEFT.CITY = RIGHT.CITY AND
	LEFT.STATE = RIGHT.STATE AND
	LEFT.ZIP = RIGHT.ZIP AND
	LEFT.ZIP_4 = RIGHT.ZIP_4 AND
	LEFT.CRRT_CODE = RIGHT.CRRT_CODE AND
	LEFT.DELIVERY_POINT_BARCODE = RIGHT.DELIVERY_POINT_BARCODE AND
	LEFT.ZIP4_CHECK_DIGIT = RIGHT.ZIP4_CHECK_DIGIT AND
	LEFT.ADDRESS_TYPE_CODE = RIGHT.ADDRESS_TYPE_CODE AND
	LEFT.ADDRESS_TYPE = RIGHT.ADDRESS_TYPE AND
	LEFT.COUNTY_NUMBER = RIGHT.COUNTY_NUMBER AND
	LEFT.GENDER_CODE = RIGHT.GENDER_CODE AND
	LEFT.GENDER = RIGHT.GENDER AND
	LEFT.BIRTH_DATE = RIGHT.BIRTH_DATE AND
	LEFT.DOB_FORMATTED = RIGHT.DOB_FORMATTED AND
	LEFT.TELEPHONE = RIGHT.TELEPHONE AND
	LEFT.CLASS = RIGHT.CLASS AND
	LEFT.COLLEGE_CLASS = RIGHT.COLLEGE_CLASS AND
	LEFT.COLLEGE_NAME[1..23] = RIGHT.COLLEGE_NAME[1..23] AND
	LEFT.COLLEGE_MAJOR = RIGHT.COLLEGE_MAJOR AND
	LEFT.COLLEGE_CODE = RIGHT.COLLEGE_CODE AND
	LEFT.COLLEGE_CODE_EXPLODED = RIGHT.COLLEGE_CODE_EXPLODED AND
	LEFT.COLLEGE_TYPE = RIGHT.COLLEGE_TYPE AND
	LEFT.COLLEGE_TYPE_EXPLODED = RIGHT.COLLEGE_TYPE_EXPLODED AND
	LEFT.HEAD_OF_HOUSEHOLD_FIRST_NAME = RIGHT.HEAD_OF_HOUSEHOLD_FIRST_NAME AND
	LEFT.HEAD_OF_HOUSEHOLD_GENDER_CODE = RIGHT.HEAD_OF_HOUSEHOLD_GENDER_CODE AND
	LEFT.HEAD_OF_HOUSEHOLD_GENDER = RIGHT.HEAD_OF_HOUSEHOLD_GENDER AND
	LEFT.INCOME_LEVEL_CODE = RIGHT.INCOME_LEVEL_CODE AND
	LEFT.INCOME_LEVEL = RIGHT.INCOME_LEVEL AND
	LEFT.FILE_TYPE = RIGHT.FILE_TYPE AND
	LEFT.title = RIGHT.title AND
	LEFT.fname = RIGHT.fname AND
	LEFT.mname = RIGHT.mname AND
	LEFT.lname = RIGHT.lname AND
	LEFT.name_suffix = RIGHT.name_suffix AND
	LEFT.name_score = RIGHT.name_score AND
	LEFT.prim_range = RIGHT.prim_range AND
	LEFT.predir = RIGHT.predir AND
	LEFT.prim_name = RIGHT.prim_name AND
	LEFT.addr_suffix = RIGHT.addr_suffix AND
	LEFT.postdir = RIGHT.postdir AND
	LEFT.unit_desig = RIGHT.unit_desig AND
	LEFT.sec_range = RIGHT.sec_range AND
	LEFT.p_city_name = RIGHT.p_city_name AND
	LEFT.v_city_name = RIGHT.v_city_name AND
	LEFT.st = RIGHT.st AND
	LEFT.z5 = RIGHT.z5 AND
	LEFT.zip4 = RIGHT.zip4 AND
	LEFT.cart = RIGHT.cart AND
	LEFT.cr_sort_sz = RIGHT.cr_sort_sz AND
	LEFT.lot = RIGHT.lot AND
	LEFT.lot_order = RIGHT.lot_order AND
	LEFT.dpbc = RIGHT.dpbc AND
	LEFT.chk_digit = RIGHT.chk_digit AND
	LEFT.rec_type = RIGHT.rec_type AND
	LEFT.ace_fips_st = RIGHT.ace_fips_st AND
	LEFT.fips_county = RIGHT.fips_county AND
	LEFT.geo_lat = RIGHT.geo_lat AND
	LEFT.geo_long = RIGHT.geo_long AND
	LEFT.msa = RIGHT.msa AND
	LEFT.geo_blk = RIGHT.geo_blk AND
	LEFT.geo_match = RIGHT.geo_match AND
	LEFT.err_stat = RIGHT.err_stat,						
local);

//Separate records without a did and flag them as 'I' (invalid for keys)											
ASL_Rollup_No_DID	:=	rollup_American_Student_List_base(DID = 0);
ASL_Rollup_DID	:=	rollup_American_Student_List_base(DID <> 0);
											
dsSort			:= sort(ASL_Rollup_DID, DID);
dsGroup     := group(dsSort, DID);
dsSortGroup := sort(dsGroup, -process_date);											
											
Layout_outfile SetRecordType(Layout_outfile L, Layout_outfile R) := transform
	self.HISTORICAL_FLAG  	:= if(l.HISTORICAL_FLAG = '', 'C', 'H');
	self										:= r;
end;
	
American_Student_List_base_flagged_DID := group(iterate(dsSortGroup, SetRecordType(left, right)));		
								
Layout_outfile SetRecordTypeInvalid(Layout_outfile pInput) := transform
	self.HISTORICAL_FLAG  	:= 'I';
	self										:= pInput;
end;								

American_Student_List_base_flagged_NoDID	:=	PROJECT(ASL_Rollup_No_DID, SetRecordTypeInvalid(left));

American_Student_List_base_flagged	:=	American_Student_List_base_flagged_DID + American_Student_List_base_flagged_NoDID;
								
RETURN	American_Student_List_base_flagged;

END;