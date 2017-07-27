IMPORT BatchServices, codes, iesp, ut;

// SAMPLE INPUT JOHN SMITH FORT WORTH TX

SHARED get_business_description(string1 bus_code) := function


	string_layout := record
		string30 business_activity_name;
	end;

	business_desc := project(Codes.Key_Codes_V3(file_name=BatchServices.constants.DEA_CODESV3_FILE AND code=bus_code),
                 transform(string_layout,
								   self.business_activity_name  := left.long_desc;
									));
 
			return(if (bus_code <> '', business_desc[1].business_activity_name, ''));								
									
	end;

EXPORT layout_DEA_Batch_out xfm_DEA_make_flat(BatchServices.Layouts.DEA.rec_results_raw_penalty le,
                                              DATASET(BatchServices.Layouts.DEA.rec_results_raw_penalty) allRows) := 
	TRANSFORM
	
		SELF.acctno                := le.acctno;
		// 1
		self.First_name_1          := allRows[1].fname;
		self.Middle_name_1         := allRows[1].mname;
		self.Last_name_1           := allRows[1].lname;
		self.ssn_1                 := allRows[1].best_ssn;
		self.Company_name_1        := allRows[1].cname;
		
		self.Business_type_1 := get_business_description(allRows[1].business_activity_code);
		       
		self.Address_1_1           := trim(allRows[1].prim_range, left, right) + ' '  + trim(allRows[1].predir, left, right) + ' ' +
		                              trim(allRows[1].prim_name, left, right)  + ' '  + trim(allRows[1].addr_suffix, left, right) + ' ' + trim(allRows[1].postdir, left, right);
	  self.Address_2_1           := allRows[1].unit_desig + ' ' + allRows[1].sec_range;
		
		self.City_1                := allRows[1].p_city_name;
		self.State_1               := allRows[1].st;
		self.Zip_1                 := allRows[1].zip + if (allRows[1].zip4 <> '', '-' + allRows[1].zip4, '');
		
		SELF.DEA_Number_1        := allRows[1].dea_registration_number;		
		SELF.DrugSchedule_1      := allRows[1].drug_schedules;
		SELF.Expiration_date_1   := allRows[1].Expiration_Date;
		
		// 2
		self.First_name_2          := allRows[2].fname;
		self.Middle_name_2         := allRows[2].mname;
		self.Last_name_2           := allRows[2].lname;
		self.ssn_2                 := allRows[2].best_ssn;
		self.Company_name_2        := allRows[2].cname;

	  self.Business_type_2  := get_business_description(allRows[2].business_activity_code);
        
		self.Address_1_2           := trim(allRows[2].prim_range, left, right) + ' '  + trim(allRows[2].predir, left, right) + ' ' +
		                              trim(allRows[2].prim_name, left, right)  + ' '  + trim(allRows[2].addr_suffix, left, right) + ' ' + trim(allRows[2].postdir, left, right);
	  self.Address_2_2           := allRows[2].unit_desig + ' ' + allRows[2].sec_range;
	
		self.City_2                := allRows[2].p_city_name;
		self.State_2               := allRows[2].st;
		self.Zip_2                 := allRows[2].zip + if (allRows[2].zip4 <> '', '-' + allRows[2].zip4, '');
		
		SELF.DEA_Number_2        := allRows[2].dea_registration_number;		
		SELF.DrugSchedule_2      := allRows[2].Drug_Schedules;	
		SELF.Expiration_date_2   := allRows[2].Expiration_Date;
		
		// 3
		self.First_name_3          := allRows[3].fname;
		self.Middle_name_3         := allRows[3].mname;
		self.Last_name_3           := allRows[3].lname;
		self.ssn_3                 := allRows[3].best_ssn;
		self.Company_name_3        := allRows[3].cname;
	
		self.Business_type_3 := get_business_description(allRows[3].business_activity_code);
        
		self.Address_1_3           := trim(allRows[3].prim_range, left, right) + ' '  + trim(allRows[3].predir, left, right) + ' ' +
		                              trim(allRows[3].prim_name, left, right)  + ' '  + trim(allRows[3].addr_suffix, left, right) + ' ' + trim(allRows[3].postdir, left, right);
	  self.Address_2_3           := allRows[3].unit_desig + ' ' + allRows[3].sec_range;
	
		self.City_3                := allRows[3].p_city_name;
		self.State_3               := allRows[3].st;
		self.Zip_3                 := allRows[3].zip + if (allRows[3].zip4 <> '', '-' + allRows[3].zip4, '');
		
		SELF.DEA_Number_3        := allRows[3].dea_registration_number;		
		SELF.DrugSchedule_3      := allRows[3].Drug_Schedules;
		SELF.Expiration_date_3   := allRows[3].Expiration_Date;
		
		// 4
		self.First_name_4          := allRows[4].fname;
		self.Middle_name_4         := allRows[4].mname;
		self.Last_name_4           := allRows[4].lname;
		self.ssn_4                 := allRows[4].best_ssn;
		self.Company_name_4        := allRows[4].cname;
		
		self.Business_type_4 := get_business_description(allRows[4].business_activity_code);
        
		self.Address_1_4           := trim(allRows[4].prim_range, left, right) + ' '  + trim(allRows[4].predir, left, right) + ' ' +
		                              trim(allRows[4].prim_name, left, right)  + ' '  + trim(allRows[4].addr_suffix, left, right) + ' ' + trim(allRows[4].postdir, left, right);
	  self.Address_2_4           := allRows[4].unit_desig + ' ' + allRows[4].sec_range;
		
		self.City_4                := allRows[4].p_city_name;
		self.State_4               := allRows[4].st;
		self.Zip_4                 := allRows[4].zip + if (allRows[4].zip4 <> '', '-' + allRows[4].zip4, '');
		
		SELF.DEA_Number_4        := allRows[4].dea_registration_number;		
		SELF.DrugSchedule_4      := allRows[4].Drug_Schedules;
		SELF.Expiration_date_4   := allRows[4].Expiration_Date;
		
		//5 
		self.First_name_5          := allRows[5].fname;
		self.Middle_name_5         := allRows[5].mname;
		self.Last_name_5           := allRows[5].lname;
		self.ssn_5                 := allRows[5].best_ssn;
		self.Company_name_5        := allRows[5].cname;
	
		self.Business_type_5 := get_business_description(allRows[5].business_activity_code);
		
        
		self.Address_1_5           := trim(allRows[5].prim_range, left, right) + ' '  + trim(allRows[5].predir, left, right) + ' ' +
		                              trim(allRows[5].prim_name, left, right)  + ' '  + trim(allRows[5].addr_suffix, left, right) + ' ' + trim(allRows[5].postdir, left, right);
	  self.Address_2_5           := allRows[5].unit_desig + ' ' + allRows[5].sec_range;
		
		self.City_5                := allRows[5].p_city_name;
		self.State_5               := allRows[5].st;
		self.Zip_5                 := allRows[5].zip + if (allRows[5].zip4 <> '', '-' + allRows[5].zip4, '');
		
		SELF.DEA_Number_5        := allRows[5].dea_registration_number;		
		SELF.DrugSchedule_5      := allRows[5].Drug_Schedules;
		SELF.Expiration_date_5   := allRows[5].Expiration_Date;
		
		// 6
		self.First_name_6          := allRows[6].fname;
		self.Middle_name_6         := allRows[6].mname;
		self.Last_name_6           := allRows[6].lname;
		self.ssn_6                 := allRows[6].best_ssn;
		self.Company_name_6        := allRows[6].cname;
		
		self.Business_type_6 := get_business_description(allRows[6].business_activity_code);
		
        
		self.Address_1_6           := trim(allRows[6].prim_range, left, right) + ' '  + trim(allRows[6].predir, left, right) + ' ' +
		                              trim(allRows[6].prim_name, left, right)  + ' '  + trim(allRows[6].addr_suffix, left, right) + ' ' + trim(allRows[6].postdir, left, right);
	  self.Address_2_6           := allRows[6].unit_desig + ' ' + allRows[6].sec_range;
	
		self.City_6                := allRows[6].p_city_name;
		self.State_6               := allRows[6].st;
		self.Zip_6                 := allRows[6].zip + if (allRows[6].zip4 <> '', '-' + allRows[6].zip4, '');
		
		SELF.DEA_Number_6        := allRows[6].dea_registration_number;		
		SELF.DrugSchedule_6      := allRows[6].Drug_Schedules;	
		SELF.Expiration_date_6   := allRows[6].Expiration_Date;
		
		// 7
		self.First_name_7          := allRows[7].fname;
		self.Middle_name_7         := allRows[7].mname;
		self.Last_name_7           := allRows[7].lname;
		self.ssn_7                 := allRows[7].best_ssn;
		self.Company_name_7        := allRows[7].cname;
		
		self.Business_type_7 := get_business_description(allRows[7].business_activity_code);
		
        
		self.Address_1_7           := trim(allRows[7].prim_range, left, right) + ' '  + trim(allRows[7].predir, left, right) + ' ' +
		                              trim(allRows[7].prim_name, left, right)  + ' '  + trim(allRows[7].addr_suffix, left, right) + ' ' + trim(allRows[7].postdir, left, right);
	  self.Address_2_7           := allRows[7].unit_desig + ' ' + allRows[7].sec_range;
	
		self.City_7                := allRows[7].p_city_name;
		self.State_7               := allRows[7].st;
		self.Zip_7                 := allRows[7].zip + if (allRows[7].zip4 <> '', '-' + allRows[7].zip4, '');
		
		SELF.DEA_Number_7        := allRows[7].dea_registration_number;		
		SELF.DrugSchedule_7      := allRows[7].Drug_Schedules;
		SELF.Expiration_date_7   := allRows[7].Expiration_Date;

		// 8
		self.First_name_8          := allRows[8].fname;
		self.Middle_name_8         := allRows[8].mname;
		self.Last_name_8           := allRows[8].lname;
		self.ssn_8                 := allRows[8].best_ssn;
		self.Company_name_8        := allRows[8].cname;
		
		self.Business_type_8 := get_business_description(allRows[8].business_activity_code);
		
        
		self.Address_1_8           := trim(allRows[8].prim_range, left, right) + ' '  + trim(allRows[8].predir, left, right) + ' ' +
		                              trim(allRows[8].prim_name, left, right)  + ' '  + trim(allRows[8].addr_suffix, left, right) + ' ' + trim(allRows[8].postdir, left, right);
	  self.Address_2_8           := allRows[8].unit_desig + ' ' + allRows[8].sec_range;
		self.City_8                := allRows[8].p_city_name;
		self.State_8               := allRows[8].st;
		self.Zip_8                 := allRows[8].zip + if (allRows[8].zip4 <> '', '-' + allRows[8].zip4, '');
		
		SELF.DEA_Number_8        := allRows[8].dea_registration_number;		
		SELF.DrugSchedule_8      := allRows[8].Drug_Schedules;
		SELF.Expiration_date_8   := allRows[8].Expiration_Date;

		
		// 9
		self.First_name_9          := allRows[9].fname;
		self.Middle_name_9         := allRows[9].mname;
		self.Last_name_9           := allRows[9].lname;
		self.ssn_9                 := allRows[9].best_ssn;
		self.Company_name_9        := allRows[9].cname;
		
		self.Business_type_9 := get_business_description(allRows[9].business_activity_code);
		
        
		self.Address_1_9           := trim(allRows[9].prim_range, left, right) + ' '  + trim(allRows[9].predir, left, right) + ' ' +
		                              trim(allRows[9].prim_name, left, right)  + ' '  + trim(allRows[9].addr_suffix, left, right) + ' ' + trim(allRows[9].postdir, left, right);
	  self.Address_2_9           := allRows[9].unit_desig + ' ' + allRows[9].sec_range;
		self.City_9                := allRows[9].p_city_name;
		self.State_9               := allRows[9].st;
		self.Zip_9                 := allRows[9].zip + if (allRows[9].zip4 <> '', '-' + allRows[9].zip4, '');
		
		SELF.DEA_Number_9        := allRows[9].dea_registration_number;		
		SELF.DrugSchedule_9      := allRows[9].Drug_Schedules;
		SELF.Expiration_date_9   := allRows[9].Expiration_Date;
		
		//10
		self.First_name_10          := allRows[10].fname;
		self.Middle_name_10         := allRows[10].mname;
		self.Last_name_10           := allRows[10].lname;
		self.ssn_10                 := allRows[10].best_ssn;
		self.Company_name_10        := allRows[10].cname;
		
		self.Business_type_10 := get_business_description(allRows[10].business_activity_code);
		
        
		self.Address_1_10           := trim(allRows[10].prim_range, left, right) + ' '  + trim(allRows[10].predir, left, right) + ' ' +
		                              trim(allRows[10].prim_name, left, right)  + ' '  + trim(allRows[10].addr_suffix, left, right) + ' ' + trim(allRows[10].postdir, left, right);
	  self.Address_2_10           := allRows[10].unit_desig + ' ' + allRows[10].sec_range;
		self.City_10                := allRows[10].p_city_name;
		self.State_10               := allRows[10].st;
		self.Zip_10                 := allRows[10].zip + if (allRows[10].zip4 <> '', '-' + allRows[10].zip4, '');
		
		SELF.DEA_Number_10        := allRows[10].dea_registration_number;		
		SELF.DrugSchedule_10      := allRows[10].Drug_Schedules;
		SELF.Expiration_date_10   := allRows[10].Expiration_Date;
	
		SELF                       := le;		
	END;