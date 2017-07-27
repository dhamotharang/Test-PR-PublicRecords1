import vehicleV2, header, codes, ut, VehicleCodes;

//generate sequence key for owner, lessor and lienholders
file_in := VehicleV2.Mapping_Experian_Updating_Temp_Party;
//file_in := dataset('~thor_data400::persist::experian_updating_temp_party', VehicleV2.Layout_Experian_Updating_temp_module.Layout_Experian_Updating_as_VehicleV2, flat);

VehicleV2.Layout_Experian_Updating_temp_module.layout_temp_party tslimowner(VehicleV2.Layout_Experian_Updating_temp_module.Layout_Experian_Updating_as_VehicleV2 L) := transform

self.Date_First_Seen := L.Dt_First_Seen;
self.Date_Last_Seen  := L.Dt_Last_Seen;
self.Date_Vendor_First_Reported := L.Dt_Vendor_First_Reported;
self.Date_Vendor_Last_Reported  := L.Dt_Vendor_Last_Reported;
self.State_Bitmap_Flag					:= 0;
self.Latest_Vehicle_Flag				:= '';
self.Latest_Vehicle_Iteration_Flag		:= '';
self.Orig_Sex 							:= '';
self.orig_province                      := '';
self.orig_country                       := '';
self.Append_DID							:= 0;
self.Append_DID_Score					:= 0;
self.Append_BDID						:= 0;
self.Append_BDID_Score					:= 0;
self.Append_DL_Number					:= '';
self.append_DOB                         := '';
self.append_SSN                         := '';
SELF.append_FEin                        := '';
self.Reg_First_Date						:= '';
self.Reg_Earliest_Effective_Date		:= '';
self.Reg_Latest_Effective_Date			:= '';
self.Reg_Latest_Expiration_Date         := '';
self.Reg_Decal_Number					:= '';
self.Reg_Decal_Year						:= '';
self.Reg_Status_Code					:= '';
self.Reg_Status_Desc					:= '';
self.Reg_True_License_Plate				:= '';
self.Reg_License_Plate					:= '';
self.Reg_License_State					:= '';
self.Reg_License_Plate_Type_Code		:= '';
self.Reg_License_Plate_Type_Desc		:= '';
self.Reg_Previous_License_State			:= '';
self.Reg_Previous_License_Plate			:= '';
self.reg_rollup_count                   := 0;
self.Ttl_Number							:= L.TITLE_NUMBERxBG9;
self.Ttl_Earliest_Issue_Date            := '';
self.Ttl_Latest_Issue_Date              := '';
self.Ttl_Previous_Issue_Date		    := L.PREVIOUS_TITLE_ISSUE_DATE;
self.Ttl_rollup_count                   := 1;
self.Ttl_Status_Code					:= L.TITLE_STATUS_CODE;
self.Ttl_Status_Desc					:= '';
self.Ttl_Odometer_Mileage				:= L.ODOMETER_MILEAGE;
self.Ttl_Odometer_Status_Code			:= L.ODOMETER_STATUS;
self.Ttl_Odometer_Status_Desc			:= '';
self.Ttl_Odometer_Date					:= L.ODOMETER_DATE;

self := L;
end;


veh_owner_slim := project(file_in(orig_name_type in ['1', '2', '7']), tslimowner(left));

veh_owner_dist := distribute(veh_owner_slim, hash(vehicle_key, iteration_key));
 
//rollup for a set of owner/lienholder/title 

owner_set_sort := sort(veh_owner_dist,         Vehicle_Key,
                                               -Iteration_Key,
                                               Orig_Name_Type,
                                               Orig_SSN,
											                         Orig_FEIN,
                                               Orig_Name,
                                              // Orig_DL_Number,
                                               Orig_DOB,
                                               prim_range,
                                               predir,
	                                             prim_name,
	                                             addr_suffix,
	                                             postdir,
	                                             unit_desig,
	                                             sec_range,
	                                          //  v_city_name,
	                                             st,
	                                             zip5,
                                               TTL_NUMBER ,
											                         Ttl_STATUS_CODE ,
                                               PREVIOUS_TITLE_STATE ,
											   -date_vendor_last_reported,
											   -title_issue_date,										       
											   ttl_PREVIOUS_ISSUE_DATE,               
											   Orig_Lien_Date,
             								   local);	
											   
										   
VehicleV2.Layout_Experian_Updating_temp_module.layout_temp_party townerrollup(VehicleV2.Layout_Experian_Updating_temp_module.layout_temp_party L, VehicleV2.Layout_Experian_Updating_temp_module.layout_temp_party R) := transform

self.Ttl_Earliest_Issue_Date := vehiclev2.validate_date.fEarliestNonZeroDate(L.TITLE_ISSUE_DATE, R.TITLE_ISSUE_DATE);

self.Ttl_Latest_Issue_Date   := vehiclev2.validate_date.fLatestNonZeroDate(L.TITLE_ISSUE_DATE, R.TITLE_ISSUE_DATE);
								
self.Ttl_Rollup_Count        := L.Ttl_Rollup_Count + 1;

self.date_first_Seen := (unsigned)vehiclev2.validate_date.fEarliestNonZeroDate((string8)l.date_first_Seen, (string8)r.date_first_Seen);
self.date_last_Seen  := (unsigned)vehiclev2.validate_date.fLatestNonZeroDate((string8)l.date_last_Seen,  (string8)r.date_last_Seen);
self.date_vendor_First_Reported := (unsigned)vehiclev2.validate_date.fEarliestNonZeroDate((string8)l.date_vendor_First_Reported, (string8)r.date_vendor_First_Reported);
self.date_vendor_Last_Reported  := (unsigned)vehiclev2.validate_date.fLatestNonZeroDate((string8)l.date_vendor_Last_Reported, (string8)r.date_vendor_Last_Reported);
self.Orig_SSN := if(L.Orig_SSN <> '', L.Orig_SSN,r.Orig_SSN);
self.Orig_FEIN := if(L.Orig_FEIN <> '',L.Orig_FEIN, r.Orig_FEIN);
self.Orig_DOB := if(L.Orig_DOB <> '', L.Orig_DOB, r.Orig_DOB); 
self.ttl_PREVIOUS_ISSUE_DATE := if(L.ttl_PREVIOUS_ISSUE_DATE <> '', L.ttl_PREVIOUS_ISSUE_DATE, r.ttl_PREVIOUS_ISSUE_DATE);
self.Orig_Lien_Date := if(L.Orig_Lien_Date <> '', L.Orig_Lien_Date, r.Orig_Lien_Date);
self := L;

end;

owner_set_rollup := rollup(owner_set_sort, left.vehicle_key = right.vehicle_key
			   and left.Iteration_Key = right.Iteration_Key
			   and left.Orig_Name_Type = right.Orig_Name_Type
			   and ut.nneq(left.Orig_SSN,right.Orig_SSN)
			   and ut.nneq(left.Orig_FEIN, right.Orig_FEIN)
			   and left.Orig_Name = right.Orig_Name
			   and ut.nneq(left.Orig_DOB,right.Orig_DOB) 
			   and left.prim_range = right.prim_range
         and left.predir = right.predir
				 and left.prim_name = right.prim_name
				 and left.addr_suffix = right.addr_suffix
	       and left.postdir = right.postdir
	       and left.unit_desig = right.unit_desig
	       and left.sec_range = right.sec_range
	     //  and left.v_city_name = right.v_city_name
	       and left.st = right.st
	       and left.zip5 = right.zip5
			   and left.Ttl_NUMBER = right.Ttl_NUMBER
			   and ut.nneq(left.ttl_PREVIOUS_ISSUE_DATE ,right.ttl_PREVIOUS_ISSUE_DATE)
			   and left.Ttl_STATUS_CODE = right.Ttl_STATUS_CODE
			   and left.PREVIOUS_TITLE_STATE = right.PREVIOUS_TITLE_STATE
			   and ut.nneq(left.Orig_Lien_Date, right.Orig_Lien_Date),townerrollup(left, right),local);
                                              
											   											   
//do transform

owner_set_rollup townerdate(owner_set_rollup L) := transform

self.Ttl_Earliest_Issue_Date := if(L.Ttl_Rollup_Count = 1, L.TITLE_ISSUE_DATE, L.Ttl_Earliest_Issue_Date);

self.Ttl_Latest_Issue_Date   := if(L.Ttl_Rollup_Count = 1, L.TITLE_ISSUE_DATE, L.Ttl_Latest_Issue_Date);                      

self.sequence_key   := self.Ttl_Latest_Issue_Date + (string6)l.date_vendor_Last_Reported[1..6] + 'O';					   

self := L;

end;

owner_latest_date := project(owner_set_rollup, townerdate(left));
			   
//setup owner flag fields

owner_out := VehicleV2.Mac_Setup_Latest_VehFlag.owner_latest_vehflag(owner_latest_date, true);

//generate sequence key for registrants and lessee

VehicleV2.Layout_Experian_Updating_temp_module.layout_temp_party tslimreg(file_in L) := transform

self.State_Bitmap_Flag					:= 0;
self.Latest_Vehicle_Flag				:= '';
self.Latest_Vehicle_Iteration_Flag		:= '';
self.History							:= L.history;
self.Date_First_Seen := L.Dt_First_Seen;
self.Date_Last_Seen  := L.Dt_Last_Seen;
self.Date_Vendor_First_Reported := L.Dt_Vendor_First_Reported;
self.Date_Vendor_Last_Reported  := L.Dt_Vendor_Last_Reported;
self.Orig_Lien_Date 					:= '';
self.orig_province                      := '';
self.orig_country                       := '';
self.Append_DID							:= 0;
self.Append_DID_Score					:= 0;
self.Append_BDID						:= 0;
self.Append_BDID_Score					:= 0;
self.Append_DL_Number					:= '';
self.Append_SSN							:= '';
self.Append_FEIN						:= '';
self.append_DOB                         := '';
self.Reg_First_Date						:= L.FIRST_REGISTRATION_DATE;
self.Reg_Earliest_Effective_Date		:= '';
self.Reg_Latest_Effective_Date		    := '';
self.Reg_Latest_Expiration_Date			:= '';
self.Reg_Rollup_Count					:= 1;
self.Reg_Decal_Number					:= L.decal_number;
self.Reg_Decal_Year						:= L.DECAL_YEAR;
self.Reg_Status_Code					:= L.REGISTRATION_STATUS_CODE;
self.Reg_Status_Desc					:= '';
self.Reg_True_License_Plate				:= L.TRUE_LICENSE_PLSTE_NUMBER;
self.Reg_License_Plate					:= L.LICENSE_PLATE_NUMBERxBG4;
self.Reg_License_State					:= L.LICENSE_STATE;
self.Reg_License_Plate_Type_Code		:= L.LICENSE_PLATE_CODE;
self.Reg_License_Plate_Type_Desc		:= VehicleCodes.GetLicensePlate(L.LICENSE_PLATE_CODE);
self.Reg_Previous_License_State			:= L.PREVIOUS_LICENSE_STATE;
self.Reg_Previous_License_Plate			:= L.PREVIOUS_LICENSE_PLATE_NUMBER;
self.Ttl_Number							:= '';
self.Ttl_Earliest_Issue_Date			:= '';
self.Ttl_Latest_Issue_Date              := '';
self.Ttl_Previous_Issue_Date            := '';
self.Ttl_Status_Code                    := '';
self.Ttl_Status_Desc					:= '';
self.Ttl_Odometer_Mileage				:= '';
self.Ttl_Odometer_Status_Code			:= '';
self.Ttl_Odometer_Status_Desc			:= '';
self.Ttl_Odometer_Date					:= '';
self.ttl_rollup_count                   := 0;
self := L;
end;

veh_reg_slim := project(file_in(orig_name_type in ['4','5']), tslimreg(left));

veh_reg_dist := distribute(veh_reg_slim, hash(vehicle_key, iteration_key));


string8 yyyymmdd(string date_field) := if(length(date_field) = 6, date_field + '01', date_field);

reg_set_sort := sort(veh_reg_dist,                                         
                                  vehicle_key,
								                  -Iteration_Key , 
								                  Orig_Name_Type,
                                  Orig_SSN,
								                  Orig_FEIN,
                                  Orig_Name,
                                 // Orig_DL_Number,
                                  Orig_DOB,
                                  prim_range,
                                  predir,
	                                prim_name,
	                                addr_suffix,
	                                postdir,
	                                unit_desig,
	                                sec_range,
	                              //  v_city_name,
	                                st,
	                                zip5,
                                  Reg_License_Plate , 
                                  Reg_First_Date,                                    
                                  //reg_DECAL_NUMBER ,                       
                                  //Reg_Decal_Year ,                         
                                  Reg_Status_Code ,           
                                  Reg_License_Plate_Type_Code ,                 
                                  Reg_True_License_Plate ,
								                  -date_vendor_last_reported,
                                  local);								  
reg_set_sort tregrollup(reg_set_sort L, reg_set_sort R) := transform

self.Reg_Earliest_Effective_Date := vehiclev2.validate_date.fEarliestNonZeroDate(L.REGISTRATION_EFFECTIVE_DATE, R.REGISTRATION_EFFECTIVE_DATE);
self.Reg_Latest_Effective_Date   := vehiclev2.validate_date.fLatestNonZeroDate(L.REGISTRATION_EFFECTIVE_DATE, R.REGISTRATION_EFFECTIVE_DATE);
self.Reg_Latest_Expiration_Date  := vehiclev2.validate_date.fLatestNonZeroDate(yyyymmdd(L.REGISTRATION_EXPIRATION_DATE), yyyymmdd(R.REGISTRATION_EXPIRATION_DATE));
self.Reg_Rollup_Count := L.Reg_Rollup_Count + 1;
self.reg_decal_number := if(L.REGISTRATION_EFFECTIVE_DATE > R.REGISTRATION_EFFECTIVE_DATE, L.reg_decal_number,R.reg_decal_number);
self.date_first_Seen := (unsigned)vehiclev2.validate_date.fEarliestNonZeroDate((string8)l.date_first_Seen, (string8)r.date_first_Seen);
self.date_last_Seen  := (unsigned)vehiclev2.validate_date.fLatestNonZeroDate((string8)l.date_last_Seen,  (string8)r.date_last_Seen);
self.date_vendor_First_Reported := (unsigned)vehiclev2.validate_date.fEarliestNonZeroDate((string8)l.date_vendor_First_Reported, (string8)r.date_vendor_First_Reported);
self.date_vendor_Last_Reported  := (unsigned)vehiclev2.validate_date.fLatestNonZeroDate((string8)l.date_vendor_Last_Reported, (string8)r.date_vendor_Last_Reported);
self.Orig_SSN := if(L.Orig_SSN <> '', L.Orig_SSN,r.Orig_SSN);
self.Orig_FEIN := if(L.Orig_FEIN <> '',L.Orig_FEIN, r.Orig_FEIN);
self.Orig_DOB := if(L.Orig_DOB <> '', L.Orig_DOB, r.Orig_DOB); 
self.Reg_License_Plate := if(L.Reg_License_Plate <> '',L.Reg_License_Plate, r.Reg_License_Plate);
self.Reg_First_Date := if(L.Reg_First_Date <> '', L.Reg_First_Date, r.Reg_First_Date);
self.Reg_True_License_Plate := if(L.Reg_True_License_Plate <> '', L.Reg_True_License_Plate, r.Reg_True_License_Plate);
self := L;


end;

reg_set_rollup := rollup(reg_set_sort,						  
		Header.ConvertYYYYMMToNumberOfMonths((integer)Right.REGISTRATION_EFFECTIVE_DATE) < Header.ConvertYYYYMMToNumberOfMonths((integer)Left.REGISTRATION_EXPIRATION_DATE) + 2
         and left.vehicle_key = right.vehicle_key
			   and left.Iteration_Key = right.Iteration_Key
			   and left.Orig_Name_Type = right.Orig_Name_Type
			   and ut.nneq(left.Orig_SSN,right.Orig_SSN)
			   and ut.nneq(left.Orig_FEIN, right.Orig_FEIN)
			   and left.Orig_Name = right.Orig_Name
			   and ut.nneq(left.Orig_DOB,right.Orig_DOB) 
			   and left.prim_range = right.prim_range
         and left.predir = right.predir
				 and left.prim_name = right.prim_name
				 and left.addr_suffix = right.addr_suffix
	       and left.postdir = right.postdir
	       and left.unit_desig = right.unit_desig
	       and left.sec_range = right.sec_range
	      // and left.v_city_name = right.v_city_name
	       and left.st = right.st
	       and left.zip5 = right.zip5
			   and ut.nneq(left.Reg_License_Plate,right.Reg_License_Plate)
			   and ut.nneq(left.Reg_First_Date,right.Reg_First_Date)
			   and left.Reg_Status_Code = right.Reg_Status_Code
			   and left.Reg_License_Plate_Type_Code = right.Reg_License_Plate_Type_Code
			   and ut.nneq(left.Reg_True_License_Plate, right.Reg_True_License_Plate),
			   tregrollup(left, right),local);
								  
//do transform

ConvertYYYYMMToNumberOfMonths(integer pInput) := 
	 (((integer)(pInput[1..4])*12) + ((integer)(pInput[5..6])));
	 
reg_set_rollup tregdate(reg_set_rollup L) := transform

  //set-up to handle cases where the latest expiration date is way in the future
  //if the latest expiration date is 10 years in the future, don't use it (unless it's the only one)
  integer nbr_months_lt_exp_dt := ConvertYYYYMMToNumberOfMonths((integer)L.Reg_latest_Expiration_Date);
  integer nbr_months_today     := ConvertYYYYMMToNumberOfMonths((integer)ut.GetDate);
  
self.Reg_Earliest_Effective_Date := if(L.Reg_Rollup_Count = 1, L.REGISTRATION_EFFECTIVE_DATE, L.Reg_Earliest_Effective_Date);
self.Reg_Latest_Effective_Date   := if(L.Reg_Rollup_Count = 1, L.REGISTRATION_EFFECTIVE_DATE, L.Reg_Latest_Effective_Date);
self.Reg_Latest_Expiration_Date  := if(L.Reg_Rollup_Count = 1 or nbr_months_lt_exp_dt-nbr_months_today>120, L.REGISTRATION_Expiration_DATE, L.Reg_latest_Expiration_Date);
self.sequence_key   := self.Reg_Latest_Effective_Date + (string6)L.date_vendor_Last_Reported[1..6] + 'R';					   

self := L;

end;

reg_latest_date := project(reg_set_rollup, tregdate(left));


//setup flag fields

reg_out := VehicleV2.Mac_Setup_Latest_VehFlag.reg_latest_vehflag(reg_latest_date, true);

//Add Registration_Status_Description
file_reg_add_field      := owner_out + reg_out;


file_codesV3_desc       := Codes.File_Codes_V3_In(file_name = 'VEHICLE_REGISTRATION' 
						and field_name = 'REGISTRATION_STATUS_CODE');
reg_codeV3_nojoin       := file_reg_add_field(REG_STATUS_CODE = '');

file_reg_add_field tjoin2(file_reg_add_field L, file_codesV3_desc R ) := transform
self.Reg_Status_Desc := R.long_desc;
self := L;
end;

reg_codesV3_join         := JOIN(file_reg_add_field(REG_STATUS_CODE<>''), 
							file_codesV3_desc(code<>''), 
							left.REG_STATUS_CODE = right.code and 
							left.state_origin = right.field_name2, 
							tjoin2(left, right),
							LEFT OUTER, lookup);

reg_concat               := reg_codeV3_nojoin+reg_codesV3_join;

//export Mapping_Experian_Updating_Party := reg_concat;
			   
export Mapping_Experian_Updating_Party := reg_concat:persist('~thor_data400::persist::experian_updating_party') ;