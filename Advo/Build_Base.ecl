import ut, did_add, header_slimsort, didville,watchdog,doxie,header, lib_stringlib;

advo_in:=Advo.Files.File_In;

//******************Slim in file to clean addresses
advo_slim := project(advo_in , transform(advo.layouts.Layout_slim, self := left));

advo_slim_nonblank := advo_slim(trim(STREET_NAME,left,right) <> '' or
															trim(City_Name,left,right)  <> '' or
	  	                                                    trim(State_Code,left,right) <> '' or
															trim(ZIP_5,left,right)   <> '');

advo_slim_d := distribute(advo_slim_nonblank, hash(ZIP_5,STREET_NUM,STREET_PRE_DIRectional,STREET_NAME,STREET_POST_DIRectional,STREET_SUFFIX,Secondary_Unit_Designator,Secondary_Unit_Number,City_name,State_Code));
advo_d := distribute(advo_in, hash(ZIP_5,STREET_NUM,STREET_PRE_DIRectional,STREET_NAME,STREET_POST_DIRectional,STREET_SUFFIX,Secondary_Unit_Designator,Secondary_Unit_Number,City_name,State_Code));

advo_slim_s := sort( advo_slim_d, ZIP_5,STREET_NUM,STREET_PRE_DIRectional,STREET_NAME,STREET_POST_DIRectional,STREET_SUFFIX,Secondary_Unit_Designator,Secondary_Unit_Number,City_name,State_Code, local);
advo_s := sort( advo_d , ZIP_5,STREET_NUM,STREET_PRE_DIRectional,STREET_NAME,STREET_POST_DIRectional,STREET_SUFFIX,Secondary_Unit_Designator,Secondary_Unit_Number,City_name,State_Code, local);


advo_slim_dedp := dedup( advo_slim_s, ZIP_5,STREET_NUM,STREET_PRE_DIRectional,STREET_NAME,STREET_POST_DIRectional,STREET_SUFFIX,Secondary_Unit_Designator,Secondary_Unit_Number, City_name, State_code, local);

//******************Clean deduped addresses
Advo.Layouts.Layout_Slim_clean t_clean_adrr (advo_slim_dedp le) := TRANSFORM
	string address1 := StringLib.StringCleanSpaces(trim(le.STREET_NUM,left, right) + ' ' + trim(le.STREET_PRE_DIRectional,left, right) + ' ' + trim(le.STREET_NAME,left, right)  + ' ' + trim(le.STREET_POST_DIRectional,left, right) + ' ' + trim(le.STREET_SUFFIX,left, right));
	string address2 := StringLib.StringCleanSpaces(trim(le.Secondary_Unit_Designator,left, right) + ' ' + trim(le.Secondary_Unit_Number,left, right));
	self.CleanAddress := addrcleanlib.cleanaddress182(Address1 + ' ' + Address2, le.City_Name + ' ' + le.State_Code + ' ' + le.ZIP_5);
	self := le;
end;

advo_clean := PROJECT(advo_slim_dedp, t_clean_adrr(LEFT));

//******************Append clean addresses
Advo.Layouts.Layout_Common_Out  t_append_clean( advo_s le, advo_clean ri) :=transform

    trimUpper(string s):=function
     return stringlib.StringToUpperCase(trim(s,left,right));
    end;
	
    self.prim_range							:= ri.CleanAddress[	1	..	10	];
	self.predir								:= ri.CleanAddress[	11	..	12	];
	self.prim_name							:= ri.CleanAddress[	13	..	40	];
	self.addr_suffix						:= ri.CleanAddress[	41	..	44	];
	self.postdir							:= ri.CleanAddress[	45	..	46	];
	self.unit_desig							:= ri.CleanAddress[	47	..	56	];
	self.sec_range							:= ri.CleanAddress[	57	..	64	];
	self.p_city_name						:= ri.CleanAddress[	65	..	89	];
	self.v_city_name						:= ri.CleanAddress[	90	..	114	];
	self.st									:= ri.CleanAddress[	115	..	116	];
	self.zip								:= ri.CleanAddress[	117	..	121	];
	self.zip4								:= ri.CleanAddress[	122	..	125	];
	self.cart								:= ri.CleanAddress[	126	..	129	];
	self.cr_sort_sz							:= ri.CleanAddress[	130	..	130	];
	self.lot								:= ri.CleanAddress[	131	..	134	];
	self.lot_order							:= ri.CleanAddress[	135	..	135	];
	self.dbpc								:= ri.CleanAddress[	136	..	137	];
	self.chk_digit							:= ri.CleanAddress[	138	..	138	];
	self.rec_type							:= ri.CleanAddress[	139	..	140	];
	self.fips_county						:= ri.CleanAddress[	141	..	142	];
	self.county								:= ri.CleanAddress[	143	..	145	];
	self.geo_lat							:= ri.CleanAddress[	146	..	155	];
	self.geo_long							:= ri.CleanAddress[	156	..	166	];
	self.msa								:= ri.CleanAddress[	167	..	170	];
	self.geo_blk							:= ri.CleanAddress[	171	..	177	];
	self.geo_match							:= ri.CleanAddress[	178	..	178	];
	self.err_stat							:= ri.CleanAddress[	179	..	182	];
	
    self.Address_Vacancy_Indicator			:=trimUpper(le.Address_Vacancy_Indicator );
	self.Throw_Back_Indicator				:=trimUpper(le.Throw_Back_Indicator );
	self.Seasonal_Delivery_Indicator		:=trimUpper(le.Seasonal_Delivery_Indicator );
	self.DND_Indicator						:=trimUpper(le.DND_Indicator );
	self.College_Indicator					:=trimUpper(le.College_Indicator );
	self.Address_Style_Flag					:=trimUpper(le.Address_Style_Flag );
	self.Drop_Indicator						:=trimUpper(le.Drop_Indicator );
	self.Residential_or_Business_Ind		:=trimUpper(le.Residential_or_Business_Ind );
	self.County_Name						:=trimUpper(le.County_Name );
	self.OWGM_Indicator						:=trimUpper(le.OWGM_Indicator );
	self.Record_Type_Code					:=trimUpper(le.Record_Type_Code );
	self.Mixed_Address_Usage				:=trimUpper(le.Mixed_Address_Usage );
	self.Update_Date						:=le.Update_Date;
    self.File_Release_Date				    :=le.File_Release_Date;
    self.Override_file_release_date			:=le.Override_file_release_date;
    self.College_Start_Suppression_Date		:=le.College_Start_Suppression_Date;
    self.College_End_Suppression_Date	    :=le.College_End_Suppression_Date;
	self.Route_Num							:=trimUpper(le.Route_Num);
	self.WALK_Sequence						:=trim(le.WALK_Sequence ,left,right);
	self.STREET_PRE_DIRectional				:=trim(le.STREET_PRE_DIRectional ,left,right);
	self.STREET_POST_DIRectional			:=trim(le.STREET_POST_DIRectional ,left,right);
	self.STREET_SUFFIX						:=trimupper(le.STREET_SUFFIX);
	self.Secondary_Unit_Designator			:=trimUpper(le.Secondary_Unit_Designator);
	self.Secondary_Unit_Number				:=trim(le.Secondary_Unit_Number,left,right);
    self.Seasonal_Start_Suppression_Date	:=le.Seasonal_Start_Suppression_Date;
	self.Seasonal_End_Suppression_Date		:=trim(le.Seasonal_End_Suppression_Date ,left,right);
    self.Simplify_Address_Count				:=trim(le.Simplify_Address_Count ,left,right);
    self.DPBC_Digit							:=trim(le.DPBC_Digit ,left,right);
    self.DPBC_Check_Digit				    :=trim(le.DPBC_Check_Digit	 ,left,right);
    self.County_Num							:=trim(le.County_Num ,left,right);
    self.State_Num							:=trim(le.State_Num ,left,right);
    self.Congressional_District_Number		:=trim(le.Congressional_District_Number ,left,right);
    self.ADVO_Key						    :=trim(le.ADVO_Key ,left,right);
    self.Address_Type					    :=trim(le.Address_Type ,left,right);
	self.date_first_seen                	:= if(trim(le.Update_Date,all) <> '', 
													stringlib.stringfindreplace(le.Update_Date[1..10],'-',''),
													if(trim(le.file_release_date,all) <> '',  stringlib.stringfindreplace(le.file_release_date[1..10],'-',''),
													stringlib.stringfindreplace(le.Override_file_release_date[1..10],'-','')));
	self.date_last_seen                 	:= if(trim(le.Update_Date,all) <> '', 
													stringlib.stringfindreplace(le.Update_Date[1..10],'-',''),
													if(trim(le.file_release_date,all) <> '',  stringlib.stringfindreplace(le.file_release_date[1..10],'-',''),
													stringlib.stringfindreplace(le.Override_file_release_date[1..10],'-','')));
	self.date_vendor_first_reported     	:= version;
	self.date_vendor_last_reported      	:= version;
	self.active_flag						:= 'Y';
	self                          			:= le	;
	self                          			:= [];
end;

advo_clean_final	:=	join(advo_s,advo_clean, left.ZIP_5 = right.ZIP_5 and
												left.STREET_NUM = right.STREET_NUM and
												left.STREET_PRE_DIRectional = right.STREET_PRE_DIRectional and
												left.STREET_NAME = right.STREET_NAME and
												left.STREET_POST_DIRectional = right.STREET_POST_DIRectional and
												left.STREET_SUFFIX = right.STREET_SUFFIX and
												left.Secondary_Unit_Designator = right.Secondary_Unit_Designator and
												left.Secondary_Unit_Number = right.Secondary_Unit_Number and
												left.City_name = right.City_name and
												left.State_code = right.State_code,
												t_append_clean(left, right), left outer, local);

//******************Eliminate Duplications
advo_history :=  Files.File_Cleaned_Base;
advo_active_flag_reset := project(advo_history, transform(Advo.Layouts.Layout_Common_Out, self.active_flag := 'N', self := left));

advo_all := if(FileServices.GetSuperFileSubCount(Superfile_List.Base_File_Out) = 0, advo_clean_final,  advo_clean_final + advo_active_flag_reset);


advo_all_d := distribute(advo_all, hash(State_code,zip_5,STREET_NUM, STREET_PRE_DIRectional, STREET_NAME));

advo_all_s := sort( advo_all_d, 
				    State_Code	,
					ZIP_5	,
					STREET_NUM	,
					STREET_PRE_DIRectional	,
					STREET_NAME	,
					STREET_POST_DIRectional	,
					STREET_SUFFIX	,
					Secondary_Unit_Designator	,
					Secondary_Unit_Number	,
					Route_Num	,
					ZIP_4   	,
					WALK_Sequence	,					
					Address_Vacancy_Indicator	,
					Throw_Back_Indicator	,
					Seasonal_Delivery_Indicator	,
					Seasonal_Start_Suppression_Date	,
					Seasonal_End_Suppression_Date	,
					DND_Indicator	,
					College_Indicator	,
					College_Start_Suppression_Date	,
					College_End_Suppression_Date	,
					Address_Style_Flag	,
					Simplify_Address_Count	,
					Drop_Indicator	,
					Residential_or_Business_Ind	,
					DPBC_Digit	,
					DPBC_Check_Digit	,
					Override_file_release_date	,
					County_Num	,
					County_Name	,
					City_Name	,
					State_Num	,
					Congressional_District_Number	,
					OWGM_Indicator	,
					Record_Type_Code	,
					ADVO_Key	,
					Address_Type	,
					Mixed_Address_Usage	,
					prim_range,
					predir,
					prim_name,
					addr_suffix,
					postdir,
					unit_desig,
					sec_range,
					p_city_name,
					v_city_name,
					st,
					zip,
					zip4,
					cart,
					cr_sort_sz,
					lot,
					lot_order,
					dbpc,
					chk_digit,
					rec_type,
					fips_county,
					county,
					geo_lat,
					geo_long,
					msa,
					geo_blk,
					geo_match,
					err_stat,
					-active_flag,
					-date_last_seen,
local);

Advo.Layouts.Layout_Common_Out t_rollup (advo_all_s le, advo_all_s ri) := transform
 self.date_first_seen := (string8) ut.min2((unsigned)le.date_first_seen, (unsigned)ri.date_first_seen);
 self.date_last_seen :=  (string8)ut.max2((unsigned)le.date_last_seen, (unsigned)ri.date_last_seen);
 self.date_vendor_first_reported := (string8)ut.min2((unsigned)le.date_vendor_first_reported, (unsigned)ri.date_vendor_first_reported);
 self.date_vendor_last_reported := (string8) ut.max2((unsigned)le.date_vendor_last_reported, (unsigned)ri.date_vendor_last_reported);
 self := le;
  
end;

advo_all_r := rollup(advo_all_s, 
					t_rollup(left, right), record,
					except update_date , file_release_date, date_first_seen,date_last_seen, date_vendor_first_reported, date_vendor_last_reported, Override_file_release_date, active_flag,
					local);

export Build_Base := advo_all_r;