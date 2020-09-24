IMPORT Data_Services, STD, FLAccidents_Ecrash;

EXPORT fn_FL_Fiers_Extraction(STRING Pdate = (STRING) STD.Date.CurrentDate(TRUE)) := FUNCTION
 
  SequencingRecSummary := RECORD
		UNSIGNED recid;
		STRING line;
		END;

  //Used for CSV header record								
  VehicleHeader := 'Vehicle_ID,' + 
		'Creation_Date,' + 
		'Incident_ID,' + 
		'VIN,' + 	
		'VIN_Status,' + 
		'Damaged_Areas_Derived1,' + 
		'Damaged_Areas_Derived2,' + 
		'Airbags_Deployed_Derived,' + 
		'Vehicle_Towed_Derived,' + 
		'Unit_Type,' + 
		'Unit_Number,' + 
		'Registration_State,' + 
		'Registration_Year,' + 
		'License_Plate,' + 
		'Make,' + 
		'Model_Yr,' + 
		'Model,' + 
		'Body_Type_Category,' + 
		'Total_Occupants_in_Vehicle,' + 
		'Special_Function_in_Transport,' + 
		'Special_Function_in_Transport_Other_Unit,' + 
		'Emergency_Use,' + 
		'Posted_Satutory_Speed_Limit,' + 
		'Direction_of_Travel_Before_Crash,' + 
		'Trafficway_Description,' + 
		'Traffic_Control_Device_Type,' + 
		'Vehicle_Maneuver_Action_Prior1,' + 
		'Vehicle_Maneuver_Action_Prior2,' + 
		'Impact_Area1,' + 
		'Impact_Area2,' + 
		'Event_Sequence1,' + 
		'Event_Sequence2,' + 
		'Event_Sequence3,' + 
		'Event_Sequence4,' + 
		'Most_Harmful_Event_for_Vehicle,' + 
		'Bus_Use,' + 
		'Vehicle_Hit_and_Run,' + 
		'Vehicle_Towed,' + 
		'Contributing_Circumstances_v1,' + 
		'Contributing_Circumstances_v2,' + 
		'Contributing_Circumstances_v3,' + 
		'Contributing_Circumstances_v4,' + 
		'On_Street,' + 
		'Vehicle_Color,' + 
		'Estimated_Speed,' + 
		'Car_Fire,' + 
		'Vehicle_Damage_Amount,' + 
		'Contributing_Factors1,' + 
		'Contributing_Factors2,' + 
		'Contributing_Factors3,' + 
		'Contributing_Factors4,' + 
		'Other_Contributing_Factors1,' + 
		'Other_Contributing_Factors2,' + 
		'Other_Contributing_Factors3,' + 
		'Vision_Obscured1,' + 
		'Vision_Obscured2,' + 
		'Vehicle_on_Road,' + 
		'Ran_Off_Road,' + 
		'Skidding_Occurred,' + 
		'Vehicle_Incident_Location1,' + 
		'Vehicle_Incident_Location2,' + 
		'Vehicle_Incident_Location3,' + 
		'Vehicle_Disabled,' + 
		'Vehicle_Removed_To,' + 
		'Removed_By,' + 
		'Tow_Requested_by_Driver,' + 
		'Solicitation,' + 
		'Other_Unit_Vehicle_Damage_Amount,' + 
		'Other_Unit_Model_Year,' + 
		'Other_Unit_Make,' + 
		'Other_Unit_Model,' + 
		'Other_Unit_VIN,' + 
		'Other_Unit_VIN_Status,' + 
		'Other_Unit_Body_Type_Category,' + 
		'Other_Unit_Registration_State,' + 
		'Other_Unit_Registration_Year,' + 
		'Other_Unit_License_Plate,' + 
		'Other_Unit_Color,' + 
		'Other_Unit_Type,' + 
		'Damaged_Areas1,' + 
		'Damaged_Areas2,' + 
		'Parked_Vehicle,' + 
		'Damage_Rating1,' + 
		'Damage_Rating2,' + 
		'Vehicle_Inventoried,' + 
		'Vehicle_Defect_Apparent,' + 
		'Defect_May_Have_Contributed1,' + 
		'Defect_May_Have_Contributed2,' + 
		'Registration_Expiration,' + 
		'Owner_Driver_Type,' + 
		'Make_Code,' + 
		'Number_Trailing_Units,' + 
		'Vehicle_Position,' + 
		'Vehicle_Type,' + 
		'Motorcycle_Engine_Size,' + 
		'Motorcycle_Driver_Educated,' + 
		'Motorcycle_Helmet_Type,' + 
		'Motorcycle_Passenger,' + 
		'Motorcycle_Helmet_Stayed_On,' + 
		'Motorcycle_Helmet_DOT_Snell,' + 
		'Motorcycle_Saddlebag_Trunk,' + 
		'Motorcycle_Trailer,' + 
		'Pedacycle_Passenger,' + 
		'Pedacycle_Headlights,' + 
		'Pedacycle_Helmet,' + 
		'Pedacycle_Rear_Reflectors,' + 
		'CDL_Required,' + 
		'Truck_Bus_Supplement_Required,' + 
		'Unit_Damage_Amount,' + 
		'Airbag_Switch,' + 
		'Underride_Override_Damage,' + 
		'Vehicle_Attachment,' + 
		'Action_on_Impact,' + 
		'Speed_Detection_Method,' + 
		'Non_Motorist_Direction_of_Travel_From,' + 
		'Non_Motorist_Direction_of_Travel_To,' + 
		'Vehicle_Use,' + 
		'Department_Unit_Number,' + 
		'Equipment_in_Use_at_Time_of_Accident,' + 
		'Actions_of_Police_Vehicle,' + 
		'Vehicle_Command_ID,' + 
		'Traffic_Control_Device_Inoperative,' + 
		'Direction_of_Impact1,' + 
		'Direction_of_Impact2,' + 
		'Ran_Off_Road_Direction,' + 
		'VIN_Other_Unit_Number,' + 
		'Damaged_Area_Generic,' + 
		'Vision_Obscured_Description,' + 
		'Inattention_Description,' + 
		'Contributing_Circumstances_Defect_Description,' + 
		'Contributing_Circumstances_Other_Descriptioin,' + 
		'Vehicle_Maneuver_Action_Prior_Other_Description,' + 
		'Vehicle_Special_Use,' + 
		'Vehicle_Type_Extended1,' + 
		'Vehicle_Type_Extended2,' + 
		'Fixed_Object_Direction1,' + 
		'Fixed_Object_Direction2,' + 
		'Fixed_Object_Direction3,' + 
		'Fixed_Object_Direction4,' + 
		'Vehicle_Left_at_Scene,' + 
		'Vehicle_Impounded,' + 
		'Vehicle_Driven_From_Scene,' + 
		'On_Cross_Street,' + 
		'Actions_of_Police_Vehicle_Description,' + 
		'Avoidance_Maneuver,' + 
		'Insurance_Expiration_Date,' + 
		'Insurance_Policy_Number,' + 
		'Insurance_Company,' + 
		'avoidance_maneuver2,' + 
		'avoidance_maneuver3,' + 
		'avoidance_maneuver4,' + 
		'damaged_areas_severity1,' + 
		'damaged_areas_severity2,' + 
		'vehicle_outside_city_indicator,' + 
		'vehicle_outside_city_distance_miles,' + 
		'vehicle_outside_city_direction,' + 
		'vehicle_crash_cityplace,' + 
		'Insurance_Company_Standardized,' +  
		'Insurance_Company_Phone_Number,' +  
		'Insurance_Effective_Date,' + 
		'Proof_of_Insurance,' + 
		'Insurance_Expired,' + 
		'Insurance_Exempt,' + 
		'Insurance_Type,' + 
		'Insurance_Company_Code,' +
		'Insurance_Policy_Holder,' + 
		'Is_Tag_Converted,' + 
		'VIN_Original,' + 
		'Make_Original,' + 
		'Model_Original,' + 
		'Model_Year_Original,' + 
		'Other_Unit_VIN_Original,' + 
		'Other_Unit_Make_Original,' + 
		'Other_Unit_Model_Original,' + 
		'Other_Unit_Model_Year_Original,' + 
		'initial_point_of_contact,' + 
		'vehicle_driveable,' + 
		'commercial_vehicle,' + 
		'number_of_lanes,' + 
		'divided_highway,' + 
		'not_in_transport,' + 
		'other_unit_number,' + 
		'other_unit_length,' + 
		'other_unit_axles,' + 
		'other_unit_plate_expiration,' + 
		'other_unit_permanent_registration,' + 	
		'other_unit_model_year2,' + 
		'other_unit_make2,' + 
		'other_unit_vin2,' + 
		'other_unit_registration_state2,' + 
		'other_unit_registration_year2,' + 
		'other_unit_license_plate2,' + 
		'other_unit_number2,' + 
		'other_unit_length2,' + 
		'other_unit_axles2,' + 
		'other_unit_plate_expiration2,' + 
		'other_unit_permanent_registration2,' + 
		'other_unit_type2,' + 
		'other_unit_model_year3,' + 
		'other_unit_make3,' +  
		'other_unit_vin3,' + 
		'other_unit_registration_state3,' + 
		'other_unit_registration_year3,' + 
		'other_unit_license_plate3,' + 
		'other_unit_number3,' + 
		'other_unit_length3,' + 
		'other_unit_axles3,' + 
		'other_unit_plate_expiration3,' + 
		'other_unit_permanent_registration3,' + 
		'other_unit_type3,' + 
		'damaged_areas3,' + 
		'speed_limit_posted,' + 
		'Report_Damage_Extent,' + 
		'Report_Vehicle_Type,' + 
		'Report_Traffic_Control_Device_Type,' + 	
		'Report_Contributing_Circumstances_v,' + 	
		'Report_Vehicle_Maneuver_Action_Prior,' + 	
		'Report_Vehicle_Body_Type,' +
		'Report_Road_Condition,' + 
		'Event_Sequence,';
						
  IncidentHeader := 'Incident_ID,' + 
		'Creation_Date,' + 
		'Work_Type_ID,' + 
		'Report_ID,' + 
		'Agency_ID,' + 
		'Sent_to_HPCC_DateTime,' + 
		'Corrected_Incident,' + 
		'CRU_Order_ID,' + 
		'CRU_Sequence_Nbr,' + 
		'Loss_State_Abbr,' + 
		'Report_Type_ID,' + 
		'Hash_Key,' + 
		'Case_Identifier,' + 
		'Crash_County,' + 
		'County_Cd,' + 
		'Crash_CityPlace,' + 
		'Crash_City,' + 
		'City_Code,' + 
		'First_Harmful_Event,' + 
		'First_Harmful_Event_Location,' + 
		'Manner_Crash_Impact1,' + 
		'Weather_Condition1,' + 
		'Weather_Condition2,' + 
		'Light_Condition1,' + 
		'Light_Condition2,' + 
		'Road_Surface_Condition,' + 
		'Contributing_Circumstances_Environmental1,' + 
		'Contributing_Circumstances_Environmental2,' + 
		'Contributing_Circumstances_Environmental3,' + 
		'Contributing_Circumstances_Environmental4,' + 
		'Contributing_Circumstances_Road1,' + 
		'Contributing_Circumstances_Road2,' + 
		'Contributing_Circumstances_Road3,' + 
		'Contributing_Circumstances_Road4,' + 
		'Relation_to_Junction,' + 
		'Intersection_Type,' + 
		'School_Bus_Related,' + 
		'Work_Zone_Related,' + 
		'Work_Zone_Location,' + 
		'Work_Zone_Type,' + 
		'Work_Zone_Workers_Present,' + 
		'Work_Zone_Law_Enforcement_Present,' + 
		'Crash_Severity,' + 
		'Number_of_Vehicles,' + 
		'Total_Nonfatal_Injuries,' + 
		'Total_Fatal_Injuries,' + 
		'Day_of_Week,' + 
		'Roadway_Curvature,' + 
		'Part_of_National_Highway_System,' + 
		'Roadway_Functional_Class,' + 
		'Access_Control,' + 
		'RR_Crossing_ID,' + 
		'Roadway_Lighting,' + 
		'Traffic_Control_Type_at_Intersection1,' + 
		'Traffic_Control_Type_at_Intersection2,' + 
		'NCIC_Number,' + 
		'State_Report_Number,' + 
		'ORI_Number,' + 
		'Crash_Date,' + 
		'Crash_Time,' + 
		'Lattitude,' + 
		'Longitude,' + 
		'Milepost1,' + 
		'Milepost2,' + 
		'Address_Number,' + 
		'Loss_Street,' + 
		'Loss_Street_Route_Number,' + 
		'loss_street_type,' + 
		'Loss_Street_Speed_Limit,' + 
		'Incident_Location_Indicator,' + 
		'Loss_Cross_Street,' + 
		'Loss_Cross_Street_Route_Number,' + 
		'Loss_Cross_Street_Intersecting_Route_Segment,' + 
		'Loss_Cross_Street_Type,' + 
		'Loss_Cross_Street_Speed_Limit,' + 
		'Loss_Cross_Street_Number_of_Lanes,' + 
		'Loss_Cross_Street_Orientation,' + 
		'Loss_Cross_Street_Route_Sign,' + 
		'At_Node_Number,' + 
		'Distance_From_Node_Feet,' + 
		'Distance_From_Node_Miles,' + 
		'Next_Node_Number,' + 
		'Next_Roadway_Node_Number,' + 
		'Direction_of_Travel,' + 
		'Next_Street,' + 
		'Next_Street_Type,' + 
		'Next_Street_Suffix,' + 
		'Before_or_After_Next_Street,' + 
		'Next_Street_Distance_Feet,' + 
		'Next_Street_Distance_Miles,' + 
		'Next_Street_Direction,' + 
		'Next_Street_Route_Segment,' + 
		'Continuing_Toward_Street,' + 
		'Continuing_Street_Suffix,' + 
		'Continuing_Street_Direction,' + 
		'Continuting_Street_Route_Segment,' + 
		'City_Type,' + 
		'Outside_City_Indicator,' + 
		'Outside_City_Direction,' + 
		'Outside_City_Distance_Feet,' + 
		'Outside_City_Distance_Miles,' + 
		'Crash_Type,' + 
		'Motor_Vehicle_Involved_With,' + 
		'Report_Investigation_Type,' + 
		'Incident_Hit_and_Run,' + 
		'Tow_Away,' + 
		'Date_Notified,' + 
		'Time_Notified,' + 
		'Notification_Method,' + 
		'Officer_Arrival_Time,' + 
		'Officer_Report_Date,' + 
		'Officer_Report_Time,' + 
		'Officer_ID,' + 
		'Officer_Department,' + 
		'Officer_Rank,' + 
		'Officer_Command,' + 
		'Officer_Tax_ID_Number,' + 
		'Completed_Report_Date,' + 
		'Supervisor_Check_Date,' + 
		'Supervisor_Check_Time,' + 
		'Supervisor_ID,' + 
		'Supervisor_Rank,' + 
		'Reviewers_Name,' + 
		'Road_Surface,' + 
		'Roadway_Alignment,' + 
		'Traffic_Way_Description,' + 
		'Traffic_Flow,' + 
		'Property_Damage_Involved,' + 
		'Property_Damage_Description1,' + 
		'Property_Damage_Description2,' + 
		'Property_Damage_Estimate1,' + 
		'Property_Damage_Estimate2,' + 
		'Incident_Damage_Over_Limit,' + 
		'Property_Owner_Notified,' + 
		'Government_Property,' + 
		'Accident_Condition,' + 
		'Unusual_Road_Condition1,' + 
		'Unusual_Road_Condition2,' + 
		'Number_of_Lanes,' + 
		'Divided_Highway,' + 
		'Most_Harmful_Event,' + 
		'Second_Harmful_Event,' + 
		'EMS_Notified_Date,' + 
		'EMS_Arrival_Date,' + 
		'Hospital_Arrival_Date,' + 
		'Injured_Taken_By,' + 
		'Injured_Taken_To,' + 
		'Incident_Transported_for_Medical_Care,' + 
		'Photographs_Taken,' + 
		'Photographed_By,' + 
		'Photographer_ID,' + 
		'Photography_Agency_Name,' + 
		'Agency_Name,' + 
		'Judicial_District,' + 
		'Precinct,' + 
		'Beat,' + 
		'Location_Type,' + 
		'Shoulder_Type,' + 
		'Investigation_Complete,' + 
		'Investigation_Not_Complete_Why,' + 
		'Investigating_Officer_Name,' + 
		'Investigation_Notification_Issued,' + 
		'Agency_Type,' + 
		'No_Injury_Tow_Involved,' + 
		'Injury_Tow_Involved,' + 
		'LARS_Code1,' + 
		'LARS_Code2,' + 
		'Private_Property_Incident,' + 
		'Accident_Involvement,' + 
		'Local_Use,' + 
		'Street_Prefix,' + 
		'Street_Suffix,' + 
		'Toll_Road,' + 
		'Street_Description,' + 
		'Cross_Street_Address_Number,' + 
		'Cross_Street_Prefix,' + 
		'Cross_Street_Suffix,' + 
		'Report_Complete,' + 
		'Dispatch_Notified,' + 
		'Counter_Report,' + 
		'Road_Type,' + 
		'Agency_Code,' + 
		'Public_Property_Employee,' + 
		'Bridge_Related,' + 
		'Ramp_Indicator,' + 
		'To_or_From_Location,' + 
		'Complaint_Number,' + 
		'School_Zone_Related,' + 
		'Notify_DOT_Maintenance,' + 
		'Special_Location,' + 
		'Route_Segment,' + 
		'Route_Sign,' + 
		'Route_Category_Street,' + 
		'Route_Category_Cross_Street,' + 
		'Route_Category_Next_Street,' + 
		'Lane_Closed,' + 
		'Lane_Closure_Direction,' + 
		'Lane_Direction,' + 
		'Traffic_Detoured,' + 
		'Time_Closed,' + 
		'Pedestrian_Signals,' + 
		'Work_Zone_Speed_Limit,' + 
		'Work_Zone_Shoulder_Median,' + 
		'Work_Zone_Intermittent_Moving,' + 
		'Work_Zone_Flagger_Control,' + 
		'Special_Work_Zone_Characteristics,' + 
		'Lane_Number,' + 
		'Offset_Distance_Feet,' + 
		'Offset_Distance_MIles,' + 
		'Offset_Direction,' + 
		'ASRU_Code,' + 
		'MP_Grid,' + 
		'Number_of_Qualifying_Units,' + 
		'Number_of_HazMat_Vehicles,' + 
		'Number_of_Buses_Involved,' + 
		'Number_Taken_to_Treatment,' + 
		'Number_Vehicles_Towed,' + 
		'Vehicle_at_Fault_Unit_Number,' + 
		'Time_Officer_Cleared_Scene,' + 
		'Total_Minutes_on_Scene,' + 
		'Motorists_Report,' + 
		'Fatality_Involved,' + 
		'Local_DOT_Index_Number,' + 
		'DOR_Number,' + 
		'Hospital_Code,' + 
		'Special_Jurisdiction,' + 
		'Document_Type,' + 
		'Distance_Was_Measured,' + 
		'Street_Orientation,' + 
		'Intersecting_Route_Segment,' + 
		'Primary_Fault_Indicator,' + 
		'First_Harmful_Event_Pedestrian,' + 
		'Reference_Markers,' + 
		'Other_Officer_on_Scene,' + 
		'Other_Officer_Badge_Number,' + 
		'Supplemental_Report,' + 
		'Supplemental_Type,' + 
		'Amended_Report,' + 
		'Corrected_Report,' + 
		'State_Highway_Related,' + 
		'Roadway_Lighting_Condition,' + 
		'Vendor_Reference_Number,' + 
		'Duplicate_Copy_Unit_Number,' + 
		'Other_City_Agency_Description,' + 
		'Notifcation_Description,' + 
		'Primary_Collision_Improper_Driving_Description,' + 
		'Weather_Other_Description,' + 
		'Crash_Type_Description,' + 
		'Motor_Vehicle_Involved_With_Animal_Description,' + 
		'Motor_Vehicle_Involved_With_Fixed_Object_Description,' + 
		'Motor_Vehicle_Involved_With_Other_Object_Description,' + 
		'Other_Investigation_Time,' + 
		'Milepost_Detail,' + 
		'Utility_Pole_Number1,' + 
		'Utility_Pole_Number2,' + 
		'Utility_Pole_Number3,' + 
		'Utility_Pole_Number4,' + 
		'Incident_Special_Use,' + 
		'Felony_Misdemeanor_Involved,' + 
		'Duplicate_Copy_Required,' + 
		'Highway_District_at_Scene,' + 
		'Distance_Was_Approximated,' + 
		'Avoidance_Maneuver,' + 
		'Investigation_at_Scene,' + 
		'Accident_Investigation_Site,' + 
		'Narrative,' + 
		'Narrative_Continuance,' + 
		'Report_Has_Coversheet,' + 
		'Crash_Time_AM,' + 
		'Crash_Time_PM,' + 
		'Time_Notified_AM,' + 
		'Time_Notified_PM,' + 
		'EMS_Notified_Time,' + 
		'EMS_Arrival_Time,' + 
		'First_Aid_By ,' +  
		'Person_First_Aid_Party_Type  ,' +  
		'Person_First_Aid_Party_Type_Description ,' + 
		'Source_ID,' + 
		'traffic_control_condition,' + 
		'intersection_related,' + 	
		'special_study_local,' + 	
		'special_study_state,' + 	
		'off_road_vehicle_involved,' + 	
		'location_type2	,' + 
		'speed_limit_posted,' + 
		'traffic_control_damage_notify_date,' + 
		'traffic_control_damage_notify_time	,' + 
		'traffic_control_damage_notify_name,' + 	
		'public_property_damaged,' + 
		'replacement_report	,' + 
		'deleted_report,' + 
		'next_street_prefix	 ,' + 
		'incident_damage_amount,' +  
		'dot_use,' + 	
		'number_of_persons_involved,' + 	
		'unusual_road_condition_other_description	,' + 
		'number_of_narrative_sections	,' + 
		'CAD_number	,' + 
		'visibility	,' + 
		'accident_at_intersection,' + 
		'accident_not_at_intersection	,' + 
		'first_harmful_event_within_interchange	,' + 
		'injury_involved,' + 
		'Vendor_Code,' + 	
		'Report_Property_Damage,' + 	
		'Report_Collision_Type,' + 	
		'Report_First_Harmful_Event,' + 	
		'Report_Light_Condition,' + 	
		'Report_Weather_Condition,' + 
		'Report_Road_Condition,' + 
		'cru_agency_id,' + 
		'cru_agency_name,' + 
		'Vendor_Report_Id	,' + 
		'is_available_for_public	,' + 
		'has_addendum	,' + 
		'report_agency_ori	,' + 
		'report_status,' + 
		'ReportLinkID,' + 
		'Page_Count,' + 
		'is_delete,' + 
		'last_update_date,' + 
		'Contrib_source,' + 
		'Date_Report_Submitted,' + 
		'Releasable,' + 
		'Platform,' + 
		'Agency_Report_Number,' + 
		'Dispatch_Time,' + 
		'Photograph_Type,' + 
		'Ready_To_Sell_Data,' + 
		'Posted_Satutory_Speed_Limit,' + 
		'Dispatch_Date,' + 
		'Drug_Involvement,' + 
		'Alcohol_Involved,' + 
		'Geo_Coded_Latitude,' + 
		'Geo_Coded_Longitude,' + 
		'Direction_Of_Impact,'; 
						
  PersonHeader := 'Person_ID,' + 
		'Creation_Date,' + 
		'Incident_ID,' + 
		'Person_Number,' + 
		'Sex,' + 
		'Person_Type,' + 
		'Injury_Status,' + 
		'Vehicle_Unit_Number,' + 
		'Seating_Position1,' + 
		'Safety_Equipment_Restraint1,' + 
		'Safety_Equipment_Restraint2,' + 
		'Safety_Equipment_Helmet,' + 
		'Air_Bag_Deployed,' + 
		'Ejection,' + 
		'Drivers_License_Jurisdiction,' + 
		'DL_Number_Class,' + 
		'DL_Number_CDL,' + 
		'DL_Number_endorsements,' + 
		'Driver_Actions_at_Time_of_Crash1,' + 
		'Driver_Actions_at_Time_of_Crash2,' + 
		'Driver_Actions_at_Time_of_Crash3,' + 
		'Driver_Actions_at_Time_of_Crash4,' + 
		'Violation_Codes,' + 
		'Condition_at_Time_of_Crash1,' + 
		'Condition_at_Time_of_Crash2,' + 
		'Law_Enforcement_Suspects_Alcohol_Use,' + 
		'Alcohol_Test_Status,' + 
		'Alcohol_Test_Type,' + 
		'Alcohol_Test_Result,' + 
		'Law_Enforcement_Suspects_Drug_Use,' + 
		'Drug_Test_Given,' + 
		'Non_Motorist_Actions_Prior_to_Crash1,' + 
		'Non_Motorist_Actions_Prior_to_Crash2,' + 
		'Non_Motorist_Actions_at_Time_of_Crash,' + 
		'Non_Motorist_Location_at_Time_of_Crash,' + 
		'Non_Motorist_Safety_Equipment1,' + 
		'Age,' + 
		'Driver_License_Restrictions1,' + 
		'Drug_Test_Type,' + 
		'Drug_Test_Result1,' + 
		'Drug_Test_Result2,' + 
		'Drug_Test_Result3,' + 
		'Drug_Test_Result4,' + 
		'Injury_Area,' + 
		'Injury_Description,' + 
		'Motorcyclist_Head_Injury,' + 
		'Party_ID,' + 
		'Same_as_Driver,' + 
		'Address_Same_as_Driver,' + 
		'Last_Name,' + 
		'First_Name,' + 
		'Middle_Name,' + 
		'Name_Suffx,' + 
		'Date_of_Birth,' + 
		'Address,' + 
		'City,' + 
		'State,' + 
		'Zip_Code,' + 
		'Home_Phone,' + 
		'Business_Phone,' + 
		'Insurance_Company,' + 
		'Insurance_Company_Phone_Number,' + 
		'Insurance_Policy_Number,' + 
		'Insurance_Effective_Date,' + 
		'SSN,' + 
		'Drivers_License_Number,' + 
		'Drivers_License_Expiration,' + 
		'Eye_Color,' + 
		'Hair_Color,' + 
		'Height,' + 
		'Weight,' + 
		'Race,' + 
		'Pedestrian_Cyclist_Visibility,' + 
		'First_Aid_By,' + 
		'Person_First_Aid_Party_Type,' + 
		'Person_First_Aid_Party_Type_Description,' + 
		'Deceased_At_Scene,' + 
		'Death_Date,' + 
		'Death_TIme,' + 
		'Extricated,' + 
		'Alcohol_Drug_Use,' + 
		'Physical_Defects,' + 
		'Driver_Residence,' + 
		'ID_Type,' + 
		'Proof_of_Insurance,' + 
		'Insurance_Expired,' + 
		'Insurance_Exempt,' + 
		'Insurance_Type,' + 
		'Violent_Crime_Victim_Notified,' + 
		'Insurance_Company_Code,' + 
		'Refused_Medical_Treatment,' + 
		'Safety_Equipment_Available_or_Used,' + 
		'Apartment_Number,' + 
		'Licensed_Driver,' + 
		'Physical_Emotional_Status,' + 
		'Driver_Presence,' + 
		'Ejection_Path,' + 
		'State_Person_ID,' + 
		'Contributed_to_Collision,' + 
		'Person_Transported_for_Medical_Care,' + 
		'Transported_by_Agency_Type,' + 
		'Transported_To,' + 
		'Non_Motorist_Driver_License_Number,' + 
		'Air_Bag_Type,' + 
		'Cell_Phone_Use,' + 
		'Driver_License_Restriction_Compliance,' + 
		'Driver_License_endorsement_Compliance,' + 
		'Driver_License_Compliance,' + 
		'Contributing_Circumstances_p1,' + 
		'Contributing_Circumstances_p2,' + 
		'Contributing_Circumstances_p3,' + 
		'Contributing_Circumstances_p4,' + 
		'Passenger_Number,' + 
		'Person_Deleted,' + 
		'Owner_Lessee,' + 
		'Driver_Charged,' + 
		'Motorcycle_Eye_Protection,' + 
		'Motorcycle_Long_Sleeves,' + 
		'Motorcycle_Long_Pants,' + 
		'Motorcycle_Over_Ankle_Boots,' + 
		'Contributing_Circumstances_Environmental_Non_Incident1,' + 
		'Contributing_Circumstances_Environmental_Non_Incident2,' + 
		'Alcohol_Drug_Test_Given,' + 
		'Alcohol_Drug_Test_Type,' + 
		'Alcohol_Drug_Test_Result,' + 
		'Law_Enforcement_Suspects_Alcohol_Use1,' + 
		'Law_Enforcement_Suspects_Drug_Use1,' + 
		'Solicitation,' +  
		'drivers_license_type,' +  
		'alcohol_test_type_refused,' + 	
		'alcohol_test_type_not_offered,' +  
		'alcohol_test_type_field,' + 	
		'alcohol_test_type_pbt,' +  
		'alcohol_test_type_breath,' +  
		'alcohol_test_type_blood,' +  
		'alcohol_test_type_urine,' +  
		'trapped,' +  
		'dl_number_cdl_endorsements,' + 
		'dl_number_cdl_restrictions,' +  
		'dl_number_cdl_exempt,' +  
		'dl_number_cdl_medical_card,' +  
		'interlock_device_in_use,' +  
		'drug_test_type_blood,' +  
		'drug_test_type_urine,' + 
		'driver_distracted_by,' + 	
		'non_motorist_type,' + 	
		'seating_position_row,' + 	
		'seating_position_seat,' +  
		'seating_position_description,' + 	
		'transported_id_number,' + 	
		'witness_number,' +  
		'date_of_birth_derived,' + 
		'Report_Injury_Status,' +  
		'Address2,' + 
		'Condition_At_Time_Of_Crash,' + 
		'Drug_Use_Suspected,' + 
		'Alcohol_Use_Suspected,' + 
		'Drug_Test_Status,' + 
		'Report_Contributing_Circumstances_P,' + 
		'Driver_Actions_At_Time_Of_Crash,' + 
		'Prior_Nonmotorist_Action,' + 
		'Pedestrian_Actions_At_Time_Of_Crash,' + 
		'Pedalcyclist_Actions_At_Time_Of_Crash,' + 
		'Passenger_Actions_At_Time_Of_Crash,' + 
		'Dui_Suspected,' + 
		'Drug_Test_Result,' + 
		'Marijuana_Use_Suspected,' ;
		
	CitationHeader := 'Citation_ID,' +
		'Creation_Date,' +
		'Incident_ID,' +
		'Person_ID,' +
		'Citation_Issued,' +
		'Citation_Number1,' +
		'Citation_Number2,' +
		'Section_Number1,' +
		'Court_Date,' +
		'Court_Time,' +
		'Citation_Detail1,' +
		'Local_Code,' +
		'Violation_Code1,' +
		'Violation_Code2,' +
		'Multiple_Charges_Indicator,' +
		'DUI_Indicator,' +
		'Court_Time_AM,' +
		'Court_Time_PM,' +
		'Violator_Name,' +
		'Type_Hazardous,' +
		'Type_Other,' +
		'Citation_Status,' +
		'Citation_Type,' +
		'Violation_Code3,' +
		'Violation_Code4,';
		
  CommercialHeader := 'Commercial_ID,' +
		'Creation_Date,' +
		'Vehicle_ID,' +
		'Commercial_Info_Source,' +
		'Commercial_Vehicle_Type,' +
		'Motor_Carrier_ID_DOT_Number,' +
		'Motor_Carrier_ID_State_ID,' +
		'Motor_Carrier_ID_Carrier_Name,' +
		'Motor_Carrier_ID_Address,' +
		'Motor_Carrier_ID_City,' +
		'Motor_Carrier_ID_State,' +
		'Motor_Carrier_ID_Zipcode,' +
		'Motor_Carrier_ID_Commercial_Indicator,' +
		'Carrier_ID_Type,' +
		'Carrier_Unit_Number,' +
		'DOT_Permit_Number,' +
		'ICCMC_Number,' +
		'MCS_Vehicle_Inspection,' +
		'MCS_Form_Number,' +
		'MCS_Out_of_Service,' +
		'MCS_Violation_Related,' +
		'Number_of_Axles,' +
		'Number_of_Tires,' +
		'GVW_Over_10K_Pounds,' +
		'Weight_Rating,' +
		'Registered_Gross_Vehicle_Weight,' +
		'Vehicle_Length_Feet,' +
		'Cargo_Body_Type,' +
		'Load_Type,' +
		'Oversize_Load,' +
		'Vehicle_Configuration,' +
		'Trailer1_Type,' +
		'Trailer1_Length_Feet,' +
		'Trailer1_Width_Feet,' +
		'Trailer2_Type,' +
		'Trailer2_Length_Feet,' +
		'Trailer2_Width_Feet,' +
		'Federally_Reportable,' +
		'Vehicle_Inspection_Hazmat,' +
		'Hazmat_Form_Number,' +
		'Hazmt_Out_of_Service,' +
		'Hazmat_Violation_Related,' +
		'Hazardous_Materials_Placard,' +
		'Hazardous_Materials_Class_Number1,' +
		'Hazardous_Materials_Class_Number2,' +
		'Hazmat_Placard_Name,' +
		'Hazardous_Materials_Released1,' +
		'Hazardous_Materials_Released2,' +
		'Hazardous_Materials_Released3,' +
		'Hazardous_Materials_Released4,' +
		'Commercial_Event1,' +
		'Commercial_Event2,' +
		'Commercial_Event3,' +
		'Commercial_Event4,' +
		'Recommended_Driver_Reexam,' +
		'Transporting_HazMat,' +
		'Liquid_HazMat_Volume,' +
		'Oversize_Vehicle,' +
		'Overlength_Vehicle,' +
		'Oversize_Vehicle_Permitted,' +
		'Overlength_Vehicle_Permitted,' +
		'Carrier_Phone_Number,' +
		'Commerce_Type,' +
		'Citation_Issued_to_Vehicle,' +
		'CDL_Class,' +
		'DOT_State,' +
		'Fire_Hazardous_Materials_Involvement,' +
		'Commercial_Event_Description,' +
		'Supplment_Required_Hazmat_Placard,' +
		'Other_State_Number1,' +
		'Other_State_Number2,' +
		'Hazardous_Materials_Hazmat_Placard_Number1,' +
		'Hazardous_Materials_Hazmat_Placard_Number2,' +
		'Unit_Type_And_Axles1,' +
		'Unit_Type_And_Axles2,' +
		'Unit_Type_And_Axles3,' +
		'Unit_Type_And_Axles4,';
		
	PropertydamageHeader := 'Property_Damage_ID,' +
		'Incident_ID,' +
		'damage_description,' +
		'damage_estimate,' +
		'property_owner_name,' +
		'property_owner_phone,' +
		'property_owner_last_name,' +
		'property_owner_first_name,' +
		'property_owner_middle_name,' +
		'property_owner_address,' +
		'property_owner_city,' +
		'property_owner_state,' +
		'property_owner_zip_code,' +
		'property_owner_notified,';
		
	DocumentHeader := 'document_id,' +
    'incident_id,' +
    'document_hash_key,' +
    'date_created,' +
    'is_deleted,' +
    'report_type,' +
    'page_count,' +
    'extension,' +
    'report_source,'; 
						
  SimpleLine := RECORD
		STRING line;
		END;
		
//Despray file to target LZ
  BigLineFormatDespray (DATASET(SequencingRecSummary) inputRecs, STRING attachmentName) := FUNCTION
	thorDs := PROJECT(SORT(inputRecs, recID), SimpleLine);
	FilePath := '/data/super_credit/ecrash/despray/flremoval' + '/' + attachmentName; 
	FlatFiles := OUTPUT (thorDs, ,attachmentName, CSV, OVERWRITE, EXPIRE(30));
	//FlatFiles := OUTPUT (CHOOSEN(thorDs, 100), ,attachmentName, CSV, OVERWRITE, EXPIRE(30));
	DesprayAction := FileServices.DESPRAY(attachmentName, 'bctlpedata12.risk.regn.net', FilePath,,,,TRUE);

  despary := SEQUENTIAL(FlatFiles, DesprayAction);
 
	RETURN SEQUENTIAL(despary);
END;

//Incident input file 
  ds_incident_fl   :=	DATASET('~thor_data400::in::ecrash::incident_raw::flremoval'
									           ,FLAccidents_Ecrash.Layout_Infiles.incident_new
									           ,CSV(TERMINATOR('\n'), SEPARATOR('|'), QUOTE('"'), MAXLENGTH(10000)))(Incident_ID != 'Incident_ID');                    
  dds_incident_fl := DEDUP(SORT(DISTRIBUTE(ds_incident_fl(TRIM(incident_id, LEFT, RIGHT) <> '')), incident_id, LOCAL), incident_id, LOCAL);
 
  ds_incident := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
									     ,FLAccidents_Ecrash.Layout_Infiles.incident_new
									     ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(60000)))(Incident_ID != 'Incident_ID');                  
  dds_incident := DISTRIBUTE(ds_incident,HASH32(incident_id));
	
	FLAccidents_Ecrash.Layout_Infiles.incident_new updateIncidents(dds_incident L, dds_incident_fl R) := TRANSFORM
	  SELF := L;
	END;
  rm_incidents := JOIN(dds_incident, dds_incident_fl,
			                 left.incident_id = right.incident_id,
			                 updateIncidents(left,right), inner, LOCAL);
	
  SequencingRecSummary xformCtr_inc(rm_incidents L, INTEGER CTR) := TRANSFORM
	   SELF.recid            	:= CTR;
		 SELF.LINE             	:= TRIM('"' + TRIM(L.Incident_ID, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Creation_Date, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Work_Type_ID, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Report_ID, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Agency_ID, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Sent_to_HPCC_DateTime, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Corrected_Incident, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.CRU_Order_ID, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.CRU_Sequence_Nbr, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Loss_State_Abbr, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Report_Type_ID, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Hash_Key, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Case_Identifier, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Crash_County, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.County_Cd, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Crash_CityPlace, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Crash_City, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.City_Code, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.First_Harmful_Event, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.First_Harmful_Event_Location, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Manner_Crash_Impact1, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Weather_Condition1, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Weather_Condition2, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Light_Condition1, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Light_Condition2, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Road_Surface_Condition, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Contributing_Circumstances_Environmental1, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Contributing_Circumstances_Environmental2, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Contributing_Circumstances_Environmental3, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Contributing_Circumstances_Environmental4, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Contributing_Circumstances_Road1, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Contributing_Circumstances_Road2, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Contributing_Circumstances_Road3, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Contributing_Circumstances_Road4, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Relation_to_Junction, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Intersection_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.School_Bus_Related, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Work_Zone_Related, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Work_Zone_Location, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Work_Zone_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Work_Zone_Workers_Present, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Work_Zone_Law_Enforcement_Present, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Crash_Severity, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Number_of_Vehicles, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Total_Nonfatal_Injuries, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Total_Fatal_Injuries, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Day_of_Week, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Roadway_Curvature, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Part_of_National_Highway_System, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Roadway_Functional_Class, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Access_Control, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.RR_Crossing_ID, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Roadway_Lighting, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Traffic_Control_Type_at_Intersection1, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Traffic_Control_Type_at_Intersection2, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.NCIC_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.State_Report_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.ORI_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Crash_Date, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Crash_Time, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Lattitude, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Longitude, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Milepost1, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Milepost2, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Address_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Loss_Street, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Loss_Street_Route_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.loss_street_type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Loss_Street_Speed_Limit, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Incident_Location_Indicator, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Loss_Cross_Street, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Loss_Cross_Street_Route_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Loss_Cross_Street_Intersecting_Route_Segment, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Loss_Cross_Street_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Loss_Cross_Street_Speed_Limit, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Loss_Cross_Street_Number_of_Lanes, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Loss_Cross_Street_Orientation, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Loss_Cross_Street_Route_Sign, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.At_Node_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Distance_From_Node_Feet, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Distance_From_Node_Miles, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Next_Node_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Next_Roadway_Node_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Direction_of_Travel, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Next_Street, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Next_Street_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Next_Street_Suffix, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Before_or_After_Next_Street, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Next_Street_Distance_Feet, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Next_Street_Distance_Miles, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Next_Street_Direction, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Next_Street_Route_Segment, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Continuing_Toward_Street, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Continuing_Street_Suffix, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Continuing_Street_Direction, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Continuting_Street_Route_Segment, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.City_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Outside_City_Indicator, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Outside_City_Direction, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Outside_City_Distance_Feet, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Outside_City_Distance_Miles, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Crash_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Motor_Vehicle_Involved_With, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Report_Investigation_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Incident_Hit_and_Run, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Tow_Away, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Date_Notified, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Time_Notified, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Notification_Method, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Officer_Arrival_Time, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Officer_Report_Date, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Officer_Report_Time, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Officer_ID, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Officer_Department, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Officer_Rank, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Officer_Command, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Officer_Tax_ID_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Completed_Report_Date, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Supervisor_Check_Date, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Supervisor_Check_Time, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Supervisor_ID, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Supervisor_Rank, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Reviewers_Name, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Road_Surface, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Roadway_Alignment, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Traffic_Way_Description, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Traffic_Flow, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Property_Damage_Involved, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Property_Damage_Description1, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Property_Damage_Description2, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Property_Damage_Estimate1, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Property_Damage_Estimate2, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Incident_Damage_Over_Limit, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Property_Owner_Notified, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Government_Property, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Accident_Condition, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Unusual_Road_Condition1, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Unusual_Road_Condition2, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Number_of_Lanes, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Divided_Highway, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Most_Harmful_Event, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Second_Harmful_Event, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.EMS_Notified_Date, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.EMS_Arrival_Date, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Hospital_Arrival_Date, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Injured_Taken_By, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Injured_Taken_To, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Incident_Transported_for_Medical_Care, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Photographs_Taken, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Photographed_By, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Photographer_ID, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Photography_Agency_Name, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Agency_Name, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Judicial_District, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Precinct, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Beat, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Location_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Shoulder_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Investigation_Complete, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Investigation_Not_Complete_Why, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Investigating_Officer_Name, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Investigation_Notification_Issued, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Agency_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.No_Injury_Tow_Involved, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Injury_Tow_Involved, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.LARS_Code1, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.LARS_Code2, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Private_Property_Incident, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Accident_Involvement, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Local_Use, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Street_Prefix, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Street_Suffix, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Toll_Road, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Street_Description, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Cross_Street_Address_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Cross_Street_Prefix, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Cross_Street_Suffix, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Report_Complete, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Dispatch_Notified, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Counter_Report, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Road_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Agency_Code, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Public_Property_Employee, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Bridge_Related, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Ramp_Indicator, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.To_or_From_Location, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Complaint_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.School_Zone_Related, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Notify_DOT_Maintenance, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Special_Location, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Route_Segment, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Route_Sign, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Route_Category_Street, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Route_Category_Cross_Street, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Route_Category_Next_Street, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Lane_Closed, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Lane_Closure_Direction, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Lane_Direction, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Traffic_Detoured, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Time_Closed, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Pedestrian_Signals, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Work_Zone_Speed_Limit, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Work_Zone_Shoulder_Median, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Work_Zone_Intermittent_Moving, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Work_Zone_Flagger_Control, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Special_Work_Zone_Characteristics, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Lane_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Offset_Distance_Feet, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Offset_Distance_MIles, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Offset_Direction, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.ASRU_Code, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.MP_Grid, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Number_of_Qualifying_Units, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Number_of_HazMat_Vehicles, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Number_of_Buses_Involved, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Number_Taken_to_Treatment, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Number_Vehicles_Towed, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Vehicle_at_Fault_Unit_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Time_Officer_Cleared_Scene, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Total_Minutes_on_Scene, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Motorists_Report, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Fatality_Involved, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Local_DOT_Index_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.DOR_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Hospital_Code, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Special_Jurisdiction, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Document_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Distance_Was_Measured, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Street_Orientation, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Intersecting_Route_Segment, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Primary_Fault_Indicator, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.First_Harmful_Event_Pedestrian, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Reference_Markers, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Other_Officer_on_Scene, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Other_Officer_Badge_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Supplemental_Report, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Supplemental_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Amended_Report, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Corrected_Report, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.State_Highway_Related, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Roadway_Lighting_Condition, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Vendor_Reference_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Duplicate_Copy_Unit_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Other_City_Agency_Description, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Notifcation_Description, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Primary_Collision_Improper_Driving_Description, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Weather_Other_Description, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Crash_Type_Description, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Motor_Vehicle_Involved_With_Animal_Description, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Motor_Vehicle_Involved_With_Fixed_Object_Description, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Motor_Vehicle_Involved_With_Other_Object_Description, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Other_Investigation_Time, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Milepost_Detail, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Utility_Pole_Number1, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Utility_Pole_Number2, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Utility_Pole_Number3, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Utility_Pole_Number4, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Incident_Special_Use, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Felony_Misdemeanor_Involved, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Duplicate_Copy_Required, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Highway_District_at_Scene, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Distance_Was_Approximated, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Avoidance_Maneuver, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Investigation_at_Scene, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Accident_Investigation_Site, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Narrative, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Narrative_Continuance, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Report_Has_Coversheet, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Crash_Time_AM, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Crash_Time_PM, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Time_Notified_AM, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Time_Notified_PM, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.EMS_Notified_Time, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.EMS_Arrival_Time, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.First_Aid_By , LEFT, RIGHT) + '"' + ',' +  
		'"' + TRIM(L.Person_First_Aid_Party_Type  , LEFT, RIGHT) + '"' + ',' +  
		'"' + TRIM(L.Person_First_Aid_Party_Type_Description , LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Source_ID, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.traffic_control_condition, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.intersection_related, LEFT, RIGHT) + '"' + ',' + 	
		'"' + TRIM(L.special_study_local, LEFT, RIGHT) + '"' + ',' + 	
		'"' + TRIM(L.special_study_state, LEFT, RIGHT) + '"' + ',' + 	
		'"' + TRIM(L.off_road_vehicle_involved, LEFT, RIGHT) + '"' + ',' + 	
		'"' + TRIM(L.location_type2	, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.speed_limit_posted, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.traffic_control_damage_notify_date, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.traffic_control_damage_notify_time	, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.traffic_control_damage_notify_name, LEFT, RIGHT) + '"' + ',' + 	
		'"' + TRIM(L.public_property_damaged, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.replacement_report	, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.deleted_report, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.next_street_prefix	 , LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.incident_damage_amount, LEFT, RIGHT) + '"' + ',' +  
		'"' + TRIM(L.dot_use, LEFT, RIGHT) + '"' + ',' + 	
		'"' + TRIM(L. number_of_persons_involved, LEFT, RIGHT) + '"' + ',' + 	
		'"' + TRIM(L.unusual_road_condition_other_description	, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.number_of_narrative_sections	, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.CAD_number	, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.visibility	, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L. accident_at_intersection, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L. accident_not_at_intersection	, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L. first_harmful_event_within_interchange	, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L. injury_involved, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Vendor_Code, LEFT, RIGHT) + '"' + ',' + 	
		'"' + TRIM(L.Report_Property_Damage, LEFT, RIGHT) + '"' + ',' + 	
		'"' + TRIM(L.Report_Collision_Type, LEFT, RIGHT) + '"' + ',' + 	
		'"' + TRIM(L.Report_First_Harmful_Event, LEFT, RIGHT) + '"' + ',' + 	
		'"' + TRIM(L.Report_Light_Condition, LEFT, RIGHT) + '"' + ',' + 	
		'"' + TRIM(L.Report_Weather_Condition, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Report_Road_Condition, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.cru_agency_id, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.cru_agency_name, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Vendor_Report_Id	, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.is_available_for_public	, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.has_addendum	, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.report_agency_ori	, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.report_status, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.ReportLinkID, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Page_Count, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.is_delete, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.last_update_date, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Contrib_source, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Date_Report_Submitted, LEFT, RIGHT) + '"' + ',' + 
	  '"' + TRIM(L.Releasable, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Platform, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Agency_Report_Number, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Dispatch_Time, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Photograph_Type, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Ready_To_Sell_Data, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Posted_Satutory_Speed_Limit, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Dispatch_Date, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Drug_Involvement, LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Alcohol_Involved, LEFT, RIGHT) + '"', LEFT, RIGHT); 
	END;
	ExtractData_inc          := PROJECT(rm_incidents, xformCtr_inc(LEFT, COUNTER));
	ExtractHeaderRec_inc  		:= DATASET([{0, IncidentHeader}], SequencingRecSummary);
	FORMATTEDFINALA_inc 		  := BigLineFormatDespray(ExtractData_inc & ExtractHeaderRec_inc, 'FL_Ecrash_Fiv_Incident.csv');

	//COUNTS
	OUTPUT(COUNT(dds_incident_fl), named('cnt_dds_incident_fl'));
	OUTPUT(COUNT(rm_incidents), named('cnt_rm_incidents'));
	
  //Vehicle input file
	ds_vehicle_fl := DATASET('~thor_data400::in::ecrash::vehicle_raw::flremoval'
							            ,FLAccidents_Ecrash.Layout_Infiles.vehicl_new
							            ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"')))(Vehicle_ID != 'Vehicle_ID');
	dds_vehicle_fl := DEDUP(SORT(DISTRIBUTE(ds_vehicle_fl(TRIM(vehicle_id, LEFT, RIGHT) <> ''),HASH32(vehicle_id, incident_id)), 
	                             vehicle_id, incident_id, LOCAL), 
													 vehicle_id, incident_id, LOCAL);

  ds_vehicle :=  DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::vehicl_raw'
							          ,FLAccidents_Ecrash.Layout_Infiles.vehicl_new
							          ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(50000)))(Vehicle_ID != 'Vehicle_ID');
  dds_vehicle := DISTRIBUTE(ds_vehicle,HASH32(vehicle_id, incident_id));
	
	FLAccidents_Ecrash.Layout_Infiles.vehicl_new updateVehicles(dds_vehicle L, dds_vehicle_fl R) := TRANSFORM
		SELF := L;
	END;
 rm_vehciles := JOIN(dds_vehicle, dds_vehicle_fl,
			               LEFT.vehicle_id = RIGHT.vehicle_id AND
		                 LEFT.incident_id = RIGHT.incident_id,
			               updateVehicles(LEFT,RIGHT), INNER, LOCAL);

 SequencingRecSummary xformCtr_veh(rm_vehciles L, INTEGER CTR) := TRANSFORM
	   SELF.recid            	:= CTR;
		 SELF.LINE             	:= TRIM('"' + TRIM(L.Vehicle_ID, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Creation_Date, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Incident_ID, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.VIN, LEFT, RIGHT) + '"' + ',' +	
			'"' + TRIM(L.VIN_Status, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Damaged_Areas_Derived1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Damaged_Areas_Derived2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Airbags_Deployed_Derived, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Towed_Derived, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Unit_Type, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Unit_Number, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Registration_State, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Registration_Year, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.License_Plate, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Make, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Model_Yr, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Model, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Body_Type_Category, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Total_Occupants_in_Vehicle, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Special_Function_in_Transport, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Special_Function_in_Transport_Other_Unit, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Emergency_Use, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Posted_Satutory_Speed_Limit, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Direction_of_Travel_Before_Crash, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Trafficway_Description, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Traffic_Control_Device_Type, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Maneuver_Action_Prior1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Maneuver_Action_Prior2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Impact_Area1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Impact_Area2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Event_Sequence1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Event_Sequence2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Event_Sequence3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Event_Sequence4, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Most_Harmful_Event_for_Vehicle, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Bus_Use, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Hit_and_Run, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Towed, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Contributing_Circumstances_v1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Contributing_Circumstances_v2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Contributing_Circumstances_v3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Contributing_Circumstances_v4, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.On_Street, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Color, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Estimated_Speed, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Car_Fire, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Damage_Amount, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Contributing_Factors1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Contributing_Factors2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Contributing_Factors3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Contributing_Factors4, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Contributing_Factors1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Contributing_Factors2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Contributing_Factors3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vision_Obscured1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vision_Obscured2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_on_Road, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Ran_Off_Road, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Skidding_Occurred, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Incident_Location1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Incident_Location2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Incident_Location3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Disabled, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Removed_To, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Removed_By, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Tow_Requested_by_Driver, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Solicitation, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_Vehicle_Damage_Amount, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_Model_Year, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_Make, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_Model, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_VIN, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_VIN_Status, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_Body_Type_Category, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_Registration_State, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_Registration_Year, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_License_Plate, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_Color, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_Type, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Damaged_Areas1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Damaged_Areas2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Parked_Vehicle, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Damage_Rating1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Damage_Rating2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Inventoried, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Defect_Apparent, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Defect_May_Have_Contributed1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Defect_May_Have_Contributed2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Registration_Expiration, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Owner_Driver_Type, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Make_Code, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Number_Trailing_Units, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Position, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Type, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Motorcycle_Engine_Size, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Motorcycle_Driver_Educated, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Motorcycle_Helmet_Type, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Motorcycle_Passenger, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Motorcycle_Helmet_Stayed_On, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Motorcycle_Helmet_DOT_Snell, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Motorcycle_Saddlebag_Trunk, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Motorcycle_Trailer, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Pedacycle_Passenger, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Pedacycle_Headlights, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Pedacycle_Helmet, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Pedacycle_Rear_Reflectors, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.CDL_Required, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Truck_Bus_Supplement_Required, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Unit_Damage_Amount, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Airbag_Switch, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Underride_Override_Damage, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Attachment, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Action_on_Impact, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Speed_Detection_Method, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Non_Motorist_Direction_of_Travel_From, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Non_Motorist_Direction_of_Travel_To, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Use, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Department_Unit_Number, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Equipment_in_Use_at_Time_of_Accident, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Actions_of_Police_Vehicle, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Command_ID, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Traffic_Control_Device_Inoperative, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Direction_of_Impact1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Direction_of_Impact2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Ran_Off_Road_Direction, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.VIN_Other_Unit_Number, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Damaged_Area_Generic, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vision_Obscured_Description, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Inattention_Description, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Contributing_Circumstances_Defect_Description, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Contributing_Circumstances_Other_Descriptioin, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Maneuver_Action_Prior_Other_Description, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Special_Use, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Type_Extended1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Type_Extended2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Fixed_Object_Direction1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Fixed_Object_Direction2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Fixed_Object_Direction3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Fixed_Object_Direction4, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Left_at_Scene, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Impounded, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Vehicle_Driven_From_Scene, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.On_Cross_Street, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Actions_of_Police_Vehicle_Description, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Avoidance_Maneuver, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Insurance_Expiration_Date, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Insurance_Policy_Number, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Insurance_Company, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.avoidance_maneuver2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.avoidance_maneuver3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.avoidance_maneuver4, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.damaged_areas_severity1, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.damaged_areas_severity2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.vehicle_outside_city_indicator, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.vehicle_outside_city_distance_miles, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.vehicle_outside_city_direction, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.vehicle_crash_cityplace, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Insurance_Company_Standardized, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.Insurance_Company_Phone_Number, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.Insurance_Effective_Date, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Proof_of_Insurance, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Insurance_Expired, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Insurance_Exempt, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Insurance_Type, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Insurance_Company_Code, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Insurance_Policy_Holder, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Is_Tag_Converted, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.VIN_Original, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Make_Original, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Model_Original, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Model_Year_Original, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_VIN_Original, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_Make_Original, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_Model_Original, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Other_Unit_Model_Year_Original, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.initial_point_of_contact, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.vehicle_driveable, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.commercial_vehicle, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.number_of_lanes, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.divided_highway, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.not_in_transport, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_number, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_length, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_axles, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_plate_expiration, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_permanent_registration, LEFT, RIGHT) + '"' + ',' +	
			'"' + TRIM(L.other_unit_model_year2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_make2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_vin2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_registration_state2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_registration_year2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_license_plate2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_number2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_length2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_axles2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_plate_expiration2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_permanent_registration2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_type2, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_model_year3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_make3, LEFT, RIGHT) + '"' + ',' + 
			'"' + TRIM(L.other_unit_vin3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_registration_state3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_registration_year3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_license_plate3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_number3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_length3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_axles3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_plate_expiration3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_permanent_registration3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.other_unit_type3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.damaged_areas3, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.speed_limit_posted, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Report_Damage_Extent, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Report_Vehicle_Type, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Report_Traffic_Control_Device_Type, LEFT, RIGHT) + '"' + ',' +	
			'"' + TRIM(L.Report_Contributing_Circumstances_v, LEFT, RIGHT) + '"' + ',' +	
			'"' + TRIM(L.Report_Vehicle_Maneuver_Action_Prior, LEFT, RIGHT) + '"' + ',' +	
			'"' + TRIM(L.Report_Vehicle_Body_Type, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Report_Road_Condition, LEFT, RIGHT) + '"' + ',' +
			'"' + TRIM(L.Event_Sequence, LEFT, RIGHT) + '"', LEFT, RIGHT); 
  END;
	ExtractData_veh           := PROJECT(rm_vehciles, xformCtr_veh(LEFT, COUNTER));
	ExtractHeaderRec_veh  		:= DATASET([{0, VehicleHeader}], SequencingRecSummary);
	FORMATTEDFINALA_veh 		  := BigLineFormatDespray(ExtractData_veh & ExtractHeaderRec_veh, 'FL_Ecrash_Fiv_Vehicle.csv');
	
	//COUNTS
	OUTPUT(COUNT(dds_vehicle_fl), named('cnt_dds_vehicle_fl'));
	OUTPUT(COUNT(rm_vehciles), named('cnt_rm_vehciles'));
	
	//Person input file
  ds_person_fl :=	DATASET('~thor_data400::in::ecrash::person_raw::flremoval'
							           ,FLAccidents_Ecrash.Layout_Infiles.persn_new
							           ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"')))(Person_ID != 'Person_ID');
	dds_person_fl := DEDUP(SORT(DISTRIBUTE(ds_person_fl(TRIM(person_id, LEFT, RIGHT) <> ''),HASH32(person_id, incident_id)), 
	                       person_id, incident_id, LOCAL), person_id, incident_id, LOCAL);
                    
  ds_person := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::persn_raw'
							        ,FLAccidents_Ecrash.Layout_Infiles.persn_new
							        ,csv(terminator('\n'), SEPARATOR(','), QUOTE('"'), ESCAPE('\r'), MAXLENGTH(3000000)))(Person_ID != 'Person_ID');
  dds_person := DISTRIBUTE(ds_person,HASH32(person_id, incident_id));
	
	FLAccidents_Ecrash.Layout_Infiles.persn_new updatePersons(dds_person L, dds_person_fl R) := TRANSFORM
	  SELF := L;
	END;
  rm_persons := JOIN(dds_person, dds_person_fl,
			               LEFT.person_id = RIGHT.person_id AND
		                 LEFT.incident_id = RIGHT.incident_id,
			               updatePersons(LEFT,RIGHT), INNER, LOCAL);
	
  SequencingRecSummary xformCtr_per(rm_persons L, INTEGER CTR) := TRANSFORM
	   SELF.recid            	:= CTR;
		 SELF.LINE             	:= TRIM('"' + TRIM(L.Person_ID , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Creation_Date , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Incident_ID , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Person_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Sex , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Person_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Injury_Status , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Vehicle_Unit_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Seating_Position1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Safety_Equipment_Restraint1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Safety_Equipment_Restraint2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Safety_Equipment_Helmet , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Air_Bag_Deployed , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Ejection , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Drivers_License_Jurisdiction , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.DL_Number_Class , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.DL_Number_CDL , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.DL_Number_endorsements , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Driver_Actions_at_Time_of_Crash1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Driver_Actions_at_Time_of_Crash2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Driver_Actions_at_Time_of_Crash3 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Driver_Actions_at_Time_of_Crash4 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Violation_Codes , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Condition_at_Time_of_Crash1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Condition_at_Time_of_Crash2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Law_Enforcement_Suspects_Alcohol_Use , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Alcohol_Test_Status , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Alcohol_Test_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Alcohol_Test_Result , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Law_Enforcement_Suspects_Drug_Use , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Drug_Test_Given , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Non_Motorist_Actions_Prior_to_Crash1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Non_Motorist_Actions_Prior_to_Crash2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Non_Motorist_Actions_at_Time_of_Crash , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Non_Motorist_Location_at_Time_of_Crash , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Non_Motorist_Safety_Equipment1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Age , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Driver_License_Restrictions1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Drug_Test_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Drug_Test_Result1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Drug_Test_Result2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Drug_Test_Result3 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Drug_Test_Result4 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Injury_Area , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Injury_Description , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Motorcyclist_Head_Injury , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Party_ID , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Same_as_Driver , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Address_Same_as_Driver , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Last_Name , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.First_Name , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Middle_Name , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Name_Suffx , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Date_of_Birth , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Address , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.City , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.State , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Zip_Code , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Home_Phone , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Business_Phone , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Insurance_Company , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Insurance_Company_Phone_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Insurance_Policy_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Insurance_Effective_Date , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.SSN , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Drivers_License_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Drivers_License_Expiration , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Eye_Color , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hair_Color , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Height , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Weight , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Race , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Pedestrian_Cyclist_Visibility , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.First_Aid_By , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Person_First_Aid_Party_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Person_First_Aid_Party_Type_Description , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Deceased_At_Scene , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Death_Date , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Death_TIme , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Extricated , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Alcohol_Drug_Use , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Physical_Defects , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Driver_Residence , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.ID_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Proof_of_Insurance , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Insurance_Expired , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Insurance_Exempt , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Insurance_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Violent_Crime_Victim_Notified , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Insurance_Company_Code , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Refused_Medical_Treatment , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Safety_Equipment_Available_or_Used , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Apartment_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Licensed_Driver , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Physical_Emotional_Status , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Driver_Presence , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Ejection_Path , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.State_Person_ID , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Contributed_to_Collision , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Person_Transported_for_Medical_Care , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Transported_by_Agency_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Transported_To , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Non_Motorist_Driver_License_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Air_Bag_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Cell_Phone_Use , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Driver_License_Restriction_Compliance , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Driver_License_endorsement_Compliance , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Driver_License_Compliance , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Contributing_Circumstances_p1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Contributing_Circumstances_p2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Contributing_Circumstances_p3 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Contributing_Circumstances_p4 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Passenger_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Person_Deleted , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Owner_Lessee , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Driver_Charged , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Motorcycle_Eye_Protection , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Motorcycle_Long_Sleeves , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Motorcycle_Long_Pants , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Motorcycle_Over_Ankle_Boots , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Contributing_Circumstances_Environmental_Non_Incident1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Contributing_Circumstances_Environmental_Non_Incident2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Alcohol_Drug_Test_Given , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Alcohol_Drug_Test_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Alcohol_Drug_Test_Result , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Law_Enforcement_Suspects_Alcohol_Use1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Law_Enforcement_Suspects_Drug_Use1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Solicitation	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.drivers_license_type	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.alcohol_test_type_refused , LEFT, RIGHT) + '"' + ',' +	
		'"' + TRIM(L.alcohol_test_type_not_offered	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.alcohol_test_type_field , LEFT, RIGHT) + '"' + ',' +	
		'"' + TRIM(L.alcohol_test_type_pbt	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.alcohol_test_type_breath	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.alcohol_test_type_blood	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.alcohol_test_type_urine	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.trapped	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.dl_number_cdl_endorsements , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.dl_number_cdl_restrictions	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.dl_number_cdl_exempt	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.dl_number_cdl_medical_card	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.interlock_device_in_use	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.drug_test_type_blood	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.drug_test_type_urine , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.driver_distracted_by , LEFT, RIGHT) + '"' + ',' +	
		'"' + TRIM(L.non_motorist_type , LEFT, RIGHT) + '"' + ',' +	
		'"' + TRIM(L.seating_position_row , LEFT, RIGHT) + '"' + ',' +	
		'"' + TRIM(L.seating_position_seat	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.seating_position_description , LEFT, RIGHT) + '"' + ',' +	
		'"' + TRIM(L.transported_id_number , LEFT, RIGHT) + '"' + ',' +	
		'"' + TRIM(L.witness_number	 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.date_of_birth_derived , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Report_Injury_Status , LEFT, RIGHT) + '"' + ',' + 
		'"' + TRIM(L.Address2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Condition_At_Time_Of_Crash , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Drug_Use_Suspected , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Alcohol_Use_Suspected , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Drug_Test_Status , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Report_Contributing_Circumstances_P , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Driver_Actions_At_Time_Of_Crash , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Prior_Nonmotorist_Action , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Pedestrian_Actions_At_Time_Of_Crash , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Pedalcyclist_Actions_At_Time_Of_Crash , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Passenger_Actions_At_Time_Of_Crash , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Dui_Suspected , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Drug_Test_Result , LEFT, RIGHT) + '"', LEFT, RIGHT); 
	END;
	ExtractData_per           := PROJECT(rm_persons, xformCtr_per(LEFT, COUNTER));
	ExtractHeaderRec_per  		:= DATASET([{0, PersonHeader}], SequencingRecSummary);
	FORMATTEDFINALA_per 		  := BigLineFormatDespray(ExtractData_per & ExtractHeaderRec_per, 'FL_Ecrash_Fiv_Person.csv');

	//COUNTS
	OUTPUT(COUNT(dds_person_fl), named('cnt_dds_person_fl'));
	OUTPUT(COUNT(rm_persons), named('cnt_rm_persons'));

	//Citation input file
  ds_citation_fl := DATASET('~thor_data400::in::ecrash::citation_raw::flremoval'
													 ,FLAccidents_Ecrash.Layout_Infiles.citation
													 ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"')))(Citation_ID != 'Citation_ID');
	dds_citation_fl := DEDUP(SORT(DISTRIBUTE(ds_citation_fl(TRIM(citation_id, LEFT, RIGHT) <> ''),HASH32(citation_id, incident_id)), 
	                              citation_id, incident_id, LOCAL), 
													 citation_id, incident_id, LOCAL);
								
  ds_citation := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::citatn_raw'
							          ,FLAccidents_Ecrash.Layout_Infiles.citation
							          ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')))(Citation_ID != 'Citation_ID'); 
	dds_citation := DISTRIBUTE(ds_citation,HASH32(citation_id, incident_id));
								
	FLAccidents_Ecrash.Layout_Infiles.citation updateCitation(dds_citation L, dds_citation_fl R) := TRANSFORM
		SELF := L;
	END;
  rm_citation := JOIN(dds_citation, dds_citation_fl,
			                LEFT.citation_id = RIGHT.citation_id AND
		                  LEFT.incident_id = RIGHT.incident_id,
			                updateCitation(LEFT,RIGHT), INNER, LOCAL);

  SequencingRecSummary xformCtr_cit(rm_citation L, INTEGER CTR) := TRANSFORM
	   SELF.recid            	:= CTR;
		 SELF.LINE             	:= TRIM('"' + TRIM(L.Citation_ID , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Creation_Date , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Incident_ID , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Person_ID , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Citation_Issued , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Citation_Number1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Citation_Number2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Section_Number1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Court_Date , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Court_Time , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Citation_Detail1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Local_Code , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Violation_Code1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Violation_Code2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Multiple_Charges_Indicator , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.DUI_Indicator , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Court_Time_AM , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Court_Time_PM , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Violator_Name , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Type_Hazardous , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Type_Other , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Citation_Status , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Citation_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Violation_Code3 , LEFT, RIGHT)  + '"' + ',' +
		'"' + TRIM(L.Violation_Code4 , LEFT, RIGHT) + '"' , LEFT, RIGHT); 
	END;
	ExtractData_cit           := PROJECT(rm_citation, xformCtr_cit(LEFT, COUNTER));
	ExtractHeaderRec_cit  		:= DATASET([{0, CitationHeader}], SequencingRecSummary);
	FORMATTEDFINALA_cit 		  := BigLineFormatDespray(ExtractData_cit & ExtractHeaderRec_cit, 'FL_Ecrash_Fiv_Citation.csv');
 
  //COUNTS
	OUTPUT(COUNT(dds_citation_fl), named('cnt_dds_citation_fl'));
	OUTPUT(COUNT(rm_citation), named('cnt_rm_citation'));
	
	//Commercial input file
  ds_commercial_fl := DATASET('~thor_data400::in::ecrash::commercial_raw::flremoval'
													 ,FLAccidents_Ecrash.Layout_Infiles.commercial
													 ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"')))(Commercial_ID != 'Commercial_ID');
	dds_commercial_fl := DEDUP(SORT(DISTRIBUTE(ds_commercial_fl(TRIM(commercial_id, LEFT, RIGHT) <> ''),HASH32(commercial_id, vehicle_id)), 
	                                commercial_id, vehicle_id, LOCAL), 
														  commercial_id, vehicle_id, LOCAL);
								
  ds_commercial := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::commercl_raw'
													,FLAccidents_Ecrash.Layout_Infiles.commercial
													,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')))(Commercial_ID != 'Commercial_ID');
	dds_commercial := DISTRIBUTE(ds_commercial,HASH32(commercial_id, vehicle_id));
								
	FLAccidents_Ecrash.Layout_Infiles.commercial updateCommercial(dds_commercial L, dds_commercial_fl R) := TRANSFORM
		SELF := L;
	END;
  rm_commercial := JOIN(dds_commercial, dds_commercial_fl,
			                LEFT.commercial_id = RIGHT.commercial_id AND
		                  LEFT.vehicle_id = RIGHT.vehicle_id,
			                updateCommercial(LEFT,RIGHT), INNER, LOCAL);

  SequencingRecSummary xformCtr_com(rm_commercial L, INTEGER CTR) := TRANSFORM
	   SELF.recid            	:= CTR;
		 SELF.LINE             	:= TRIM('"' + TRIM(L.Commercial_ID , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Creation_Date , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Vehicle_ID , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Commercial_Info_Source , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Commercial_Vehicle_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Motor_Carrier_ID_DOT_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Motor_Carrier_ID_State_ID , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Motor_Carrier_ID_Carrier_Name , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Motor_Carrier_ID_Address , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Motor_Carrier_ID_City , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Motor_Carrier_ID_State , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Motor_Carrier_ID_Zipcode , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Motor_Carrier_ID_Commercial_Indicator , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Carrier_ID_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Carrier_Unit_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.DOT_Permit_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.ICCMC_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.MCS_Vehicle_Inspection , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.MCS_Form_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.MCS_Out_of_Service , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.MCS_Violation_Related , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Number_of_Axles , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Number_of_Tires , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.GVW_Over_10K_Pounds , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Weight_Rating , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Registered_Gross_Vehicle_Weight , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Vehicle_Length_Feet , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Cargo_Body_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Load_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Oversize_Load , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Vehicle_Configuration , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Trailer1_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Trailer1_Length_Feet , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Trailer1_Width_Feet , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Trailer2_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Trailer2_Length_Feet , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Trailer2_Width_Feet , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Federally_Reportable , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Vehicle_Inspection_Hazmat , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hazmat_Form_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hazmt_Out_of_Service , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hazmat_Violation_Related , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hazardous_Materials_Placard , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hazardous_Materials_Class_Number1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hazardous_Materials_Class_Number2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hazmat_Placard_Name , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hazardous_Materials_Released1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hazardous_Materials_Released2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hazardous_Materials_Released3 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hazardous_Materials_Released4 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Commercial_Event1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Commercial_Event2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Commercial_Event3 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Commercial_Event4 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Recommended_Driver_Reexam , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Transporting_HazMat , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Liquid_HazMat_Volume , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Oversize_Vehicle , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Overlength_Vehicle , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Oversize_Vehicle_Permitted , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Overlength_Vehicle_Permitted , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Carrier_Phone_Number , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Commerce_Type , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Citation_Issued_to_Vehicle , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.CDL_Class , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.DOT_State , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Fire_Hazardous_Materials_Involvement , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Commercial_Event_Description , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Supplment_Required_Hazmat_Placard , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Other_State_Number1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Other_State_Number2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hazardous_Materials_Hazmat_Placard_Number1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Hazardous_Materials_Hazmat_Placard_Number2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Unit_Type_And_Axles1 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Unit_Type_And_Axles2 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Unit_Type_And_Axles3 , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Unit_Type_And_Axles4 , LEFT, RIGHT) + '"' , LEFT, RIGHT);
	END;
	ExtractData_com           := PROJECT(rm_commercial, xformCtr_com(LEFT, COUNTER));
	ExtractHeaderRec_com  		:= DATASET([{0, CommercialHeader}], SequencingRecSummary);
	FORMATTEDFINALA_com 		  := BigLineFormatDespray(ExtractData_com & ExtractHeaderRec_com, 'FL_Ecrash_Fiv_Commercial.csv');
 
  //COUNTS
	OUTPUT(COUNT(dds_commercial_fl), named('dds_commercial_fl'));
	OUTPUT(COUNT(rm_commercial), named('cnt_rm_commercial'));
	
	//Property Damage input file
  ds_property_fl := DATASET('~thor_data400::in::ecrash::propertydamage_raw::flremoval'
													 ,FLAccidents_Ecrash.Layout_Infiles.property_damage
													 ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"')))(Property_Damage_ID != 'Property_Damage_ID');
	dds_property_fl := DEDUP(SORT(DISTRIBUTE(ds_property_fl(TRIM(property_damage_id, LEFT, RIGHT) <> ''),HASH32(property_damage_id, incident_id)), 
	                              property_damage_id, incident_id, LOCAL), 
													 property_damage_id, incident_id, LOCAL);
								
  ds_property := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::propertydamage_raw'
													,FLAccidents_Ecrash.Layout_Infiles.property_damage
													,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(50000)))(Property_Damage_ID != 'Property_Damage_ID');
	dds_property := DISTRIBUTE(ds_property,HASH32(property_damage_id, incident_id));
								
	FLAccidents_Ecrash.Layout_Infiles.property_damage updateProperty(dds_property L, dds_property_fl R) := TRANSFORM
		SELF := L;
	END;
  rm_property := JOIN(dds_property, dds_property_fl,
			                LEFT.property_damage_id = RIGHT.property_damage_id AND
		                  LEFT.incident_id = RIGHT.incident_id,
			                updateProperty(LEFT,RIGHT), INNER, LOCAL);

  SequencingRecSummary xformCtr_pro(rm_property L, INTEGER CTR) := TRANSFORM
	   SELF.recid            	:= CTR;
		 SELF.LINE             	:= TRIM('"' + TRIM(L.Property_Damage_ID , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.Incident_ID , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.damage_description , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.damage_estimate , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.property_owner_name , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.property_owner_phone , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.property_owner_last_name , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.property_owner_first_name , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.property_owner_middle_name , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.property_owner_address , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.property_owner_city , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.property_owner_state , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.property_owner_zip_code , LEFT, RIGHT) + '"' + ',' +
		'"' + TRIM(L.property_owner_notified , LEFT, RIGHT) + '"' , LEFT, RIGHT); 
	END;
	ExtractData_pro           := PROJECT(rm_property, xformCtr_pro(LEFT, COUNTER));
	ExtractHeaderRec_pro  		:= DATASET([{0, PropertydamageHeader}], SequencingRecSummary);
	FORMATTEDFINALA_pro  		  := BigLineFormatDespray(ExtractData_pro & ExtractHeaderRec_pro, 'FL_Ecrash_Fiv_Propertydamage.csv');
 
  //COUNTS
	OUTPUT(COUNT(dds_property_fl), named('cnt_dds_property_fl'));
	OUTPUT(COUNT(rm_property), named('cnt_rm_property'));
	
	//Document input file
  ds_document_fl := DATASET('~thor_data400::in::ecrash::document_raw::flremoval'
													 ,FLAccidents_Ecrash.Layout_Infiles.Document
													 ,CSV(TERMINATOR('\n'), SEPARATOR('|\t|'), QUOTE('"')))(Document_ID != 'Document_ID');
	dds_document_fl := DEDUP(SORT(DISTRIBUTE(ds_document_fl(TRIM(document_id, LEFT, RIGHT) <> ''),HASH32(document_id, incident_id)), 
	                              document_id, incident_id, LOCAL), 
													 document_id, incident_id, LOCAL);
								
  ds_document := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::document_raw'
								        ,FLAccidents_Ecrash.Layout_Infiles.Document, CSV(HEADING(1),TERMINATOR('\n'), SEPARATOR(','),QUOTE('"')),OPT)(Document_ID != 'Document_ID');
	dds_document := DISTRIBUTE(ds_document,HASH32(document_id, incident_id));
								
	FLAccidents_Ecrash.Layout_Infiles.Document updateDocument(dds_document L, dds_document_fl R) := TRANSFORM
		SELF := L;
	END;
  rm_document := JOIN(dds_document, dds_document_fl,
			                LEFT.document_id = RIGHT.document_id AND
		                  LEFT.incident_id = RIGHT.incident_id,
			                updateDocument(LEFT,RIGHT), INNER, LOCAL);

  SequencingRecSummary xformCtr_doc(rm_document L, INTEGER CTR) := TRANSFORM
	   SELF.recid            	:= CTR;
		 SELF.LINE             	:= TRIM('"' + TRIM(L.document_id , LEFT, RIGHT) + '"' + ',' +
    '"' + TRIM(L.incident_id , LEFT, RIGHT) + '"' + ',' +
    '"' + TRIM(L.document_hash_key , LEFT, RIGHT) + '"' + ',' +
    '"' + TRIM(L.date_created , LEFT, RIGHT) + '"' + ',' +
    '"' + TRIM(L.is_deleted , LEFT, RIGHT) + '"' + ',' +
    '"' + TRIM(L.report_type , LEFT, RIGHT) + '"' + ',' +
    '"' + TRIM(L.page_count , LEFT, RIGHT) + '"' + ',' +
    '"' + TRIM(L.extension , LEFT, RIGHT) + '"' + ',' +
    '"' + TRIM(L.report_source , LEFT, RIGHT) + '"' , LEFT, RIGHT);
	END;
	ExtractData_doc           := PROJECT(rm_document, xformCtr_doc(LEFT, COUNTER));
	ExtractHeaderRec_doc  		:= DATASET([{0, DocumentHeader}], SequencingRecSummary);
	FORMATTEDFINALA_doc  		  := BigLineFormatDespray(ExtractData_doc & ExtractHeaderRec_doc, 'FL_Ecrash_Fiv_Document.csv');
 
  //COUNTS
	OUTPUT(COUNT(dds_document_fl), named('cnt_dds_document_fl'));
	OUTPUT(COUNT(rm_document), named('cnt_rm_document'));

	
	Write_Output_Files := SEQUENTIAL(FORMATTEDFINALA_inc, FORMATTEDFINALA_veh, FORMATTEDFINALA_cit, FORMATTEDFINALA_per, FORMATTEDFINALA_com, FORMATTEDFINALA_pro, FORMATTEDFINALA_doc); 
	
 RETURN Write_Output_Files;
END;

