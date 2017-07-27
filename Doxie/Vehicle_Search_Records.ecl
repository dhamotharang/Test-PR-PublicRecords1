import doxie, ut, business_header;

Business_Header.doxie_MAC_Field_Declare()
qstring25 vid_value := '' : STORED('VID');
string2 st_code_value := '' : STORED('StateCode');
string20 veh_num_value := '' : STORED('VehicleNumber');

sif := record
	string FirstName := fname_val;
	string LastName := lname_val;
	string State := state_val;
	string SSN := ssn_value;
	string DID := did_value;
	unsigned6 BDID := bdid_value;
	string OtherLastName1 := olname1_val;
	string MiddleName := mname_val;
	string CompanyName := company_name_value;
	string OtherState1 := prev_state_val1l;
	string OtherState2 := prev_state_val2l;
	string City :=  city_val;
	string Zip := zip_val;
	unsigned2 ZipRadius := zipradius_value;
	string Phone := phone_value;
	string Addr := addr_value;
	string Tag := tag_value;
	string VIN := vin_value;
	string DriversLicense := dl_value;
	boolean PhoneticMatch :=  phonetics;
	boolean  AllowNickNames := nicknames;
	unsigned1 AgeLow := AgeLow_val;
	unsigned1 AgeHigh := AgeHigh_val;
	unsigned8 Dob := Dob_val;
	unsigned8 MaxResults := MaxResults_val;
	unsigned8 MaxResultsThisTime := MaxResultsThisTime_val;
	unsigned8 SkipRecords := SkipRecords_val;
	unsigned1 DPPAPurpose := DPPA_Purpose;
	unsigned1 GLBPurpose := GLB_Purpose;
	boolean Raw := raw_records;
	boolean Household := whole_house;
	string SeisintAdlService := adl_service_ip;
	boolean isANeighbor := true;
	boolean Report := report_records;
	string vid := vid_value;
	STRING SSNMask := ssn_mask_val;
	unsigned1 DLMask := dl_mask_val;
end;
  
doxie.MAC_LocalRemoteCombo(sif, doxie.Vehicle_Search_Local, 
						'doxie.vehicle_helper', neighbor_service, 
						doxie.Layout_VehicleSearch, vid != '',
						'Vehicle_Errors', results_out) 

xLayout :=
RECORD
	results_out;
	integer own_1_age;
	integer own_2_age;
	integer reg_1_age;
	integer reg_2_age;
END;

xLayout clean_up(results_out L) := transform
	self.own_1_ssn := if (dppa_purpose not in [1,4,6],'',L.own_1_ssn);
	self.own_2_ssn := if (dppa_purpose not in [1,4,6],'',L.own_2_ssn);
	self.reg_1_ssn := if (dppa_purpose not in [1,4,6],'',L.reg_1_ssn);
	self.reg_2_ssn := if (dppa_purpose not in [1,4,6],'',L.reg_2_ssn);
	SELF.own_1_age := ut.age((INTEGER)L.own_1_dob);
	SELF.own_2_age := ut.age((INTEGER)L.own_2_dob);
	SELF.reg_1_age := ut.age((INTEGER)L.reg_1_dob);
	SELF.reg_2_age := ut.age((INTEGER)L.reg_2_dob);
	self := L;
end;
results_clean := project(results_out,clean_up(LEFT));

export Vehicle_Search_Records := results_clean;