/*2017-06-01T19:28:00Z (Srilatha Katukuri)
DF-18925 Claims Compass/Police Records
*/
/*2017-04-06T21:49:34Z (Srilatha Katukuri)
DF-18925 - ClaimsCompass?Police Records -Layout change Addition of Address2
*/
/*2016-09-21T17:28:34Z (Srilatha Katukuri)
ECH4454 - Webcruiser Integration changes - For Review
*/
/*2015-09-23T05:56:26Z (Srilatha Katukuri)
#181860 - PRUS
*/
/*2015-08-28T16:39:56Z (Srilatha Katukuri)
#181860 PRUS
*/
/*2015-08-07T23:57:39Z (Srilatha Katukuri)
#181860-PRUS
*/
/*2015-07-23T16:59:32Z (Srilatha Katukuri)
#173256
*/
/*2015-04-15T19:05:36Z (Srilatha Katukuri)
#173256- Check in
*/
/*2015-02-11T00:46:34Z (Ayeesha Kayttala)
bug# 173256 - code review 
*/
export Layout_Infiles := module

export payload := record,maxlength(20000)
string line;
end;

export agency := record

 string Agency_ID;
 string Agency_Name;
 string agency_ori; 
 string source_id; 
 string drivers_exchange_flag;
end;

export citation := record 
string Citation_ID;
string Creation_Date;
string Incident_ID;
string Person_ID;
string Citation_Issued;
string Citation_Number1;
string Citation_Number2;
string Section_Number1;
string Court_Date;
string Court_Time;
string Citation_Detail1;
string Local_Code;
string Violation_Code1;
string Violation_Code2;
string Multiple_Charges_Indicator;
string DUI_Indicator;
string Court_Time_AM;
string Court_Time_PM;
string Violator_Name;
string Type_Hazardous;
string Type_Other;
string Citation_Status;

end;


export commercial := record
string Commercial_ID;
string Creation_Date;
string Vehicle_ID;
string Commercial_Info_Source;
string Commercial_Vehicle_Type;
string Motor_Carrier_ID_DOT_Number;
string Motor_Carrier_ID_State_ID;
string Motor_Carrier_ID_Carrier_Name;
string Motor_Carrier_ID_Address;
string Motor_Carrier_ID_City;
string Motor_Carrier_ID_State;
string Motor_Carrier_ID_Zipcode;
string Motor_Carrier_ID_Commercial_Indicator;
string Carrier_ID_Type;
string Carrier_Unit_Number;
string DOT_Permit_Number;
string ICCMC_Number;
string MCS_Vehicle_Inspection;
string MCS_Form_Number;
string MCS_Out_of_Service;
string MCS_Violation_Related;
string Number_of_Axles;
string Number_of_Tires;
string GVW_Over_10K_Pounds;
string Weight_Rating;
string Registered_Gross_Vehicle_Weight;
string Vehicle_Length_Feet;
string Cargo_Body_Type;
string Load_Type;
string Oversize_Load;
string Vehicle_Configuration;
string Trailer1_Type;
string Trailer1_Length_Feet;
string Trailer1_Width_Feet;
string Trailer2_Type;
string Trailer2_Length_Feet;
string Trailer2_Width_Feet;
string Federally_Reportable;
string Vehicle_Inspection_Hazmat;
string Hazmat_Form_Number;
string Hazmt_Out_of_Service;
string Hazmat_Violation_Related;
string Hazardous_Materials_Placard;
string Hazardous_Materials_Class_Number1;
string Hazardous_Materials_Class_Number2;
string Hazmat_Placard_Name;
string Hazardous_Materials_Released1;
string Hazardous_Materials_Released2;
string Hazardous_Materials_Released3;
string Hazardous_Materials_Released4;
string Commercial_Event1;
string Commercial_Event2;
string Commercial_Event3;
string Commercial_Event4;
string Recommended_Driver_Reexam;
string Transporting_HazMat;
string Liquid_HazMat_Volume;
string Oversize_Vehicle;
string Overlength_Vehicle;
string Oversize_Vehicle_Permitted;
string Overlength_Vehicle_Permitted;
string Carrier_Phone_Number;
string Commerce_Type;
string Citation_Issued_to_Vehicle;
string CDL_Class;
string DOT_State;
string Fire_Hazardous_Materials_Involvement;
string Commercial_Event_Description;
string Supplment_Required_Hazmat_Placard;
string Other_State_Number1;
string Other_State_Number2;
string Hazardous_Materials_Hazmat_Placard_Number1;
string Hazardous_Materials_Hazmat_Placard_Number2;
string Unit_Type_And_Axles1;
string Unit_Type_And_Axles2;
string Unit_Type_And_Axles3;
string Unit_Type_And_Axles4;

end;


export incident_NEW := record,maxlength(20000)
string Incident_ID;
string Creation_Date;
string Work_Type_ID;
string Report_ID;
string Agency_ID;
string Sent_to_HPCC_DateTime;
string Corrected_Incident;
string CRU_Order_ID;
string CRU_Sequence_Nbr;
string Loss_State_Abbr;
string Report_Type_ID;
string Hash_Key;
string Case_Identifier;
string Crash_County;
string County_Cd;
string Crash_CityPlace;
string Crash_City;
string City_Code;
string First_Harmful_Event;
string First_Harmful_Event_Location;
string Manner_Crash_Impact1;
string Weather_Condition1;
string Weather_Condition2;
string Light_Condition1;
string Light_Condition2;
string Road_Surface_Condition;
string Contributing_Circumstances_Environmental1;
string Contributing_Circumstances_Environmental2;
string Contributing_Circumstances_Environmental3;
string Contributing_Circumstances_Environmental4;
string Contributing_Circumstances_Road1;
string Contributing_Circumstances_Road2;
string Contributing_Circumstances_Road3;
string Contributing_Circumstances_Road4;
string Relation_to_Junction;
string Intersection_Type;
string School_Bus_Related;
string Work_Zone_Related;
string Work_Zone_Location;
string Work_Zone_Type;
string Work_Zone_Workers_Present;
string Work_Zone_Law_Enforcement_Present;
string Crash_Severity;
string Number_of_Vehicles;
string Total_Nonfatal_Injuries;
string Total_Fatal_Injuries;
string Day_of_Week;
string Roadway_Curvature;
string Part_of_National_Highway_System;
string Roadway_Functional_Class;
string Access_Control;
string RR_Crossing_ID;
string Roadway_Lighting;
string Traffic_Control_Type_at_Intersection1;
string Traffic_Control_Type_at_Intersection2;
string NCIC_Number;
string State_Report_Number;
string ORI_Number;
string Crash_Date;
string Crash_Time;
string Lattitude;
string Longitude;
string Milepost1;
string Milepost2;
string Address_Number;
string Loss_Street;
string Loss_Street_Route_Number;
string loss_street_type;
string Loss_Street_Speed_Limit;
string Incident_Location_Indicator;
string Loss_Cross_Street;
string Loss_Cross_Street_Route_Number;
string Loss_Cross_Street_Intersecting_Route_Segment;
string Loss_Cross_Street_Type;
string Loss_Cross_Street_Speed_Limit;
string Loss_Cross_Street_Number_of_Lanes;
string Loss_Cross_Street_Orientation;
string Loss_Cross_Street_Route_Sign;
string At_Node_Number;
string Distance_From_Node_Feet;
string Distance_From_Node_Miles;
string Next_Node_Number;
string Next_Roadway_Node_Number;
string Direction_of_Travel;
string Next_Street;
string Next_Street_Type;
string Next_Street_Suffix;
string Before_or_After_Next_Street;
string Next_Street_Distance_Feet;
string Next_Street_Distance_Miles;
string Next_Street_Direction;
string Next_Street_Route_Segment;
string Continuing_Toward_Street;
string Continuing_Street_Suffix;
string Continuing_Street_Direction;
string Continuting_Street_Route_Segment;
string City_Type;
string Outside_City_Indicator;
string Outside_City_Direction;
string Outside_City_Distance_Feet;
string Outside_City_Distance_Miles;
string Crash_Type;
string Motor_Vehicle_Involved_With;
string Report_Investigation_Type;
string Incident_Hit_and_Run;
string Tow_Away;
string Date_Notified;
string Time_Notified;
string Notification_Method;
string Officer_Arrival_Time;
string Officer_Report_Date;
string Officer_Report_Time;
string Officer_ID;
string Officer_Department;
string Officer_Rank;
string Officer_Command;
string Officer_Tax_ID_Number;
string Completed_Report_Date;
string Supervisor_Check_Date;
string Supervisor_Check_Time;
string Supervisor_ID;
string Supervisor_Rank;
string Reviewers_Name;
string Road_Surface;
string Roadway_Alignment;
string Traffic_Way_Description;
string Traffic_Flow;
string Property_Damage_Involved;
string Property_Damage_Description1;
string Property_Damage_Description2;
string Property_Damage_Estimate1;
string Property_Damage_Estimate2;
string Incident_Damage_Over_Limit;
string Property_Owner_Notified;
string Government_Property;
string Accident_Condition;
string Unusual_Road_Condition1;
string Unusual_Road_Condition2;
string Number_of_Lanes;
string Divided_Highway;
string Most_Harmful_Event;
string Second_Harmful_Event;
string EMS_Notified_Date;
string EMS_Arrival_Date;
string Hospital_Arrival_Date;
string Injured_Taken_By;
string Injured_Taken_To;
string Incident_Transported_for_Medical_Care;
string Photographs_Taken;
string Photographed_By;
string Photographer_ID;
string Photography_Agency_Name;
string Agency_Name;
string Judicial_District;
string Precinct;
string Beat;
string Location_Type;
string Shoulder_Type;
string Investigation_Complete;
string Investigation_Not_Complete_Why;
string Investigating_Officer_Name;
string Investigation_Notification_Issued;
string Agency_Type;
string No_Injury_Tow_Involved;
string Injury_Tow_Involved;
string LARS_Code1;
string LARS_Code2;
string Private_Property_Incident;
string Accident_Involvement;
string Local_Use;
string Street_Prefix;
string Street_Suffix;
string Toll_Road;
string Street_Description;
string Cross_Street_Address_Number;
string Cross_Street_Prefix;
string Cross_Street_Suffix;
string Report_Complete;
string Dispatch_Notified;
string Counter_Report;
string Road_Type;
string Agency_Code;
string Public_Property_Employee;
string Bridge_Related;
string Ramp_Indicator;
string To_or_From_Location;
string Complaint_Number;
string School_Zone_Related;
string Notify_DOT_Maintenance;
string Special_Location;
string Route_Segment;
string Route_Sign;
string Route_Category_Street;
string Route_Category_Cross_Street;
string Route_Category_Next_Street;
string Lane_Closed;
string Lane_Closure_Direction;
string Lane_Direction;
string Traffic_Detoured;
string Time_Closed;
string Pedestrian_Signals;
string Work_Zone_Speed_Limit;
string Work_Zone_Shoulder_Median;
string Work_Zone_Intermittent_Moving;
string Work_Zone_Flagger_Control;
string Special_Work_Zone_Characteristics;
string Lane_Number;
string Offset_Distance_Feet;
string Offset_Distance_MIles;
string Offset_Direction;
string ASRU_Code;
string MP_Grid;
string Number_of_Qualifying_Units;
string Number_of_HazMat_Vehicles;
string Number_of_Buses_Involved;
string Number_Taken_to_Treatment;
string Number_Vehicles_Towed;
string Vehicle_at_Fault_Unit_Number;
string Time_Officer_Cleared_Scene;
string Total_Minutes_on_Scene;
string Motorists_Report;
string Fatality_Involved;
string Local_DOT_Index_Number;
string DOR_Number;
string Hospital_Code;
string Special_Jurisdiction;
string Document_Type;
string Distance_Was_Measured;
string Street_Orientation;
string Intersecting_Route_Segment;
string Primary_Fault_Indicator;
string First_Harmful_Event_Pedestrian;
string Reference_Markers;
string Other_Officer_on_Scene;
string Other_Officer_Badge_Number;
string Supplemental_Report;
string Supplemental_Type;
string Amended_Report;
string Corrected_Report;
string State_Highway_Related;
string Roadway_Lighting_Condition;
string Vendor_Reference_Number;
string Duplicate_Copy_Unit_Number;
string Other_City_Agency_Description;
string Notifcation_Description;
string Primary_Collision_Improper_Driving_Description;
string Weather_Other_Description;
string Crash_Type_Description;
string Motor_Vehicle_Involved_With_Animal_Description;
string Motor_Vehicle_Involved_With_Fixed_Object_Description;
string Motor_Vehicle_Involved_With_Other_Object_Description;
string Other_Investigation_Time;
string Milepost_Detail;
string Utility_Pole_Number1;
string Utility_Pole_Number2;
string Utility_Pole_Number3;
string Utility_Pole_Number4;
string Incident_Special_Use;
string Felony_Misdemeanor_Involved;
string Duplicate_Copy_Required;
string Highway_District_at_Scene;
string Distance_Was_Approximated;
string Avoidance_Maneuver;
string Investigation_at_Scene;
string Accident_Investigation_Site;
string Narrative;
string Narrative_Continuance;
string Report_Has_Coversheet;
string Crash_Time_AM;
string Crash_Time_PM;
string Time_Notified_AM;
string Time_Notified_PM;
string EMS_Notified_Time;
string EMS_Arrival_Time;
string First_Aid_By ; 
string Person_First_Aid_Party_Type  ; 
string Person_First_Aid_Party_Type_Description ;
string Source_ID;

string traffic_control_condition;
string intersection_related;	
string special_study_local;	
string special_study_state;	
string off_road_vehicle_involved;	
string location_type2	;
string speed_limit_posted;
string traffic_control_damage_notify_date;
string traffic_control_damage_notify_time	;
string traffic_control_damage_notify_name;	
string public_property_damaged;
string replacement_report	;
string deleted_report;
string next_street_prefix	 ;
string incident_damage_amount; 
// silverlight 
string dot_use;	
string  number_of_persons_involved;	
string unusual_road_condition_other_description	;
string number_of_narrative_sections	;
string CAD_number	;
string visibility	;
string  accident_at_intersection;
string  accident_not_at_intersection	;
string  first_harmful_event_within_interchange	;
string  injury_involved;
//string Admin_Portal_Visible;
string Vendor_Code;	
string Report_Property_Damage;	
string Report_Collision_Type;	
string Report_First_Harmful_Event;	
string Report_Light_Condition;	
string Report_Weather_Condition;
string Report_Road_Condition;
string cru_agency_id;
string cru_agency_name;
string Vendor_Report_Id	;
string is_available_for_public	;
string has_addendum	;
string report_agency_ori	;
string report_status;
string ReportLinkID;
String Page_Count;
string is_delete;
end;

export persn_NEW := record ,maxlength(20000)
string Person_ID;
string Creation_Date;
string Incident_ID;
string Person_Number;
string Sex;
string Person_Type;
string Injury_Status;
string Vehicle_Unit_Number;
string Seating_Position1;
string Safety_Equipment_Restraint1;
string Safety_Equipment_Restraint2;
string Safety_Equipment_Helmet;
string Air_Bag_Deployed;
string Ejection;
string Drivers_License_Jurisdiction;
string DL_Number_Class;
string DL_Number_CDL;
string DL_Number_Endorsements;
string Driver_Actions_at_Time_of_Crash1;
string Driver_Actions_at_Time_of_Crash2;
string Driver_Actions_at_Time_of_Crash3;
string Driver_Actions_at_Time_of_Crash4;
string Violation_Codes;
string Condition_at_Time_of_Crash1;
string Condition_at_Time_of_Crash2;
string Law_Enforcement_Suspects_Alcohol_Use;
string Alcohol_Test_Status;
string Alcohol_Test_Type;
string Alcohol_Test_Result;
string Law_Enforcement_Suspects_Drug_Use;
string Drug_Test_Given;
string Non_Motorist_Actions_Prior_to_Crash1;
string Non_Motorist_Actions_Prior_to_Crash2;
string Non_Motorist_Actions_at_Time_of_Crash;
string Non_Motorist_Location_at_Time_of_Crash;
string Non_Motorist_Safety_Equipment1;
string Age;
string Driver_License_Restrictions1;
string Drug_Test_Type;
string Drug_Test_Result1;
string Drug_Test_Result2;
string Drug_Test_Result3;
string Drug_Test_Result4;
string Injury_Area;
string Injury_Description;
string Motorcyclist_Head_Injury;
string Party_ID;
string Same_as_Driver;
string Address_Same_as_Driver;
string Last_Name;
string First_Name;
string Middle_Name;
string Name_Suffx;
string Date_of_Birth;
string Address;
string City;
string State;
string Zip_Code;
string Home_Phone;
string Business_Phone;
string Insurance_Company;
string Insurance_Company_Phone_Number;
string Insurance_Policy_Number;
string Insurance_Effective_Date;
string SSN;
string Drivers_License_Number;
string Drivers_License_Expiration;
string Eye_Color;
string Hair_Color;
string Height;
string Weight;
string Race;
string Pedestrian_Cyclist_Visibility;
string First_Aid_By;
string Person_First_Aid_Party_Type;
string Person_First_Aid_Party_Type_Description;
string Deceased_At_Scene;
string Death_Date;
string Death_TIme;
string Extricated;
string Alcohol_Drug_Use;
string Physical_Defects;
string Driver_Residence;
string ID_Type;
string Proof_of_Insurance;
string Insurance_Expired;
string Insurance_Exempt;
string Insurance_Type;
string Violent_Crime_Victim_Notified;
string Insurance_Company_Code;
string Refused_Medical_Treatment;
string Safety_Equipment_Available_or_Used;
string Apartment_Number;
string Licensed_Driver;
string Physical_Emotional_Status;
string Driver_Presence;
string Ejection_Path;
string State_Person_ID;
string Contributed_to_Collision;
string Person_Transported_for_Medical_Care;
string Transported_by_Agency_Type;
string Transported_To;
string Non_Motorist_Driver_License_Number;
string Air_Bag_Type;
string Cell_Phone_Use;
string Driver_License_Restriction_Compliance;
string Driver_License_Endorsement_Compliance;
string Driver_License_Compliance;
string Contributing_Circumstances_p1;
string Contributing_Circumstances_p2;
string Contributing_Circumstances_p3;
string Contributing_Circumstances_p4;
string Passenger_Number;
string Person_Deleted;
string Owner_Lessee;
string Driver_Charged;
string Motorcycle_Eye_Protection;
string Motorcycle_Long_Sleeves;
string Motorcycle_Long_Pants;
string Motorcycle_Over_Ankle_Boots;
string Contributing_Circumstances_Environmental_Non_Incident1;
string Contributing_Circumstances_Environmental_Non_Incident2;
string Alcohol_Drug_Test_Given;
string Alcohol_Drug_Test_Type;
string Alcohol_Drug_Test_Result;
string Law_Enforcement_Suspects_Alcohol_Use1;
string Law_Enforcement_Suspects_Drug_Use1;
//3.0.1
string Solicitation	;
string drivers_license_type	;
string alcohol_test_type_refused;	
string alcohol_test_type_not_offered	;
string alcohol_test_type_field;	
string alcohol_test_type_pbt	;
string alcohol_test_type_breath	;
string alcohol_test_type_blood	;
string alcohol_test_type_urine	;
string trapped	;
string dl_number_cdl_endorsements;
string dl_number_cdl_restrictions	;
string dl_number_cdl_exempt	;
string dl_number_cdl_medical_card	;
string interlock_device_in_use	;
string drug_test_type_blood	;
string drug_test_type_urine;
string driver_distracted_by;	
string non_motorist_type;	
string seating_position_row;	
string seating_position_seat	;
string seating_position_description;	
string transported_id_number;	
string witness_number	;
string date_of_birth_derived;
string Report_Injury_Status; 
string Address2;
end;

export vehicl_NEW:= record,maxlength(20000)
string Vehicle_ID;
string Creation_Date;
string Incident_ID;
string VIN;	
string VIN_Status;
string Damaged_Areas_Derived1;
string Damaged_Areas_Derived2;
string Airbags_Deployed_Derived;
string Vehicle_Towed_Derived;
string Unit_Type;
string Unit_Number;
string Registration_State;
string Registration_Year;
string License_Plate;
string Make;
string Model_Yr;
string Model;
string Body_Type_Category;
string Total_Occupants_in_Vehicle;
string Special_Function_in_Transport;
string Special_Function_in_Transport_Other_Unit;
string Emergency_Use;
string Posted_Satutory_Speed_Limit;
string Direction_of_Travel_Before_Crash;
string Trafficway_Description;
string Traffic_Control_Device_Type;
string Vehicle_Maneuver_Action_Prior1;
string Vehicle_Maneuver_Action_Prior2;
string Impact_Area1;
string Impact_Area2;
string Event_Sequence1;
string Event_Sequence2;
string Event_Sequence3;
string Event_Sequence4;
string Most_Harmful_Event_for_Vehicle;
string Bus_Use;
string Vehicle_Hit_and_Run;
string Vehicle_Towed;
string Contributing_Circumstances_v1;
string Contributing_Circumstances_v2;
string Contributing_Circumstances_v3;
string Contributing_Circumstances_v4;
string On_Street;
string Vehicle_Color;
string Estimated_Speed;
string Car_Fire;
string Vehicle_Damage_Amount;
string Contributing_Factors1;
string Contributing_Factors2;
string Contributing_Factors3;
string Contributing_Factors4;
string Other_Contributing_Factors1;
string Other_Contributing_Factors2;
string Other_Contributing_Factors3;
string Vision_Obscured1;
string Vision_Obscured2;
string Vehicle_on_Road;
string Ran_Off_Road;
string Skidding_Occurred;
string Vehicle_Incident_Location1;
string Vehicle_Incident_Location2;
string Vehicle_Incident_Location3;
string Vehicle_Disabled;
string Vehicle_Removed_To;
string Removed_By;
string Tow_Requested_by_Driver;
string Solicitation;
string Other_Unit_Vehicle_Damage_Amount;
string Other_Unit_Model_Year;
string Other_Unit_Make;
string Other_Unit_Model;
string Other_Unit_VIN;
string Other_Unit_VIN_Status;
string Other_Unit_Body_Type_Category;
string Other_Unit_Registration_State;
string Other_Unit_Registration_Year;
string Other_Unit_License_Plate;
string Other_Unit_Color;
string Other_Unit_Type;
string Damaged_Areas1;
string Damaged_Areas2;
string Parked_Vehicle;
string Damage_Rating1;
string Damage_Rating2;
string Vehicle_Inventoried;
string Vehicle_Defect_Apparent;
string Defect_May_Have_Contributed1;
string Defect_May_Have_Contributed2;
string Registration_Expiration;
string Owner_Driver_Type;
string Make_Code;
string Number_Trailing_Units;
string Vehicle_Position;
string Vehicle_Type;
string Motorcycle_Engine_Size;
string Motorcycle_Driver_Educated;
string Motorcycle_Helmet_Type;
string Motorcycle_Passenger;
string Motorcycle_Helmet_Stayed_On;
string Motorcycle_Helmet_DOT_Snell;
string Motorcycle_Saddlebag_Trunk;
string Motorcycle_Trailer;
string Pedacycle_Passenger;
string Pedacycle_Headlights;
string Pedacycle_Helmet;
string Pedacycle_Rear_Reflectors;
string CDL_Required;
string Truck_Bus_Supplement_Required;
string Unit_Damage_Amount;
string Airbag_Switch;
string Underride_Override_Damage;
string Vehicle_Attachment;
string Action_on_Impact;
string Speed_Detection_Method;
string Non_Motorist_Direction_of_Travel_From;
string Non_Motorist_Direction_of_Travel_To;
string Vehicle_Use;
string Department_Unit_Number;
string Equipment_in_Use_at_Time_of_Accident;
string Actions_of_Police_Vehicle;
string Vehicle_Command_ID;
string Traffic_Control_Device_Inoperative;
string Direction_of_Impact1;
string Direction_of_Impact2;
string Ran_Off_Road_Direction;
string VIN_Other_Unit_Number;
string Damaged_Area_Generic;
string Vision_Obscured_Description;
string Inattention_Description;
string Contributing_Circumstances_Defect_Description;
string Contributing_Circumstances_Other_Descriptioin;
string Vehicle_Maneuver_Action_Prior_Other_Description;
string Vehicle_Special_Use;
string Vehicle_Type_Extended1;
string Vehicle_Type_Extended2;
string Fixed_Object_Direction1;
string Fixed_Object_Direction2;
string Fixed_Object_Direction3;
string Fixed_Object_Direction4;
string Vehicle_Left_at_Scene;
string Vehicle_Impounded;
string Vehicle_Driven_From_Scene;
string On_Cross_Street;
string Actions_of_Police_Vehicle_Description;
string Avoidance_Maneuver;
string Insurance_Expiration_Date;
string Insurance_Policy_Number;
string Insurance_Company;
string avoidance_maneuver2;
string  avoidance_maneuver3;
string  avoidance_maneuver4;
string  damaged_areas_severity1 ;
string  damaged_areas_severity2 ;
string  vehicle_outside_city_indicator;
string  vehicle_outside_city_distance_miles ;
string  vehicle_outside_city_direction;
string  vehicle_crash_cityplace;
STRING Insurance_Company_Standardized; 
// moved fields from person
STRING Insurance_Company_Phone_Number :=''; 
STRING Insurance_Effective_Date:=''; 
STRING Proof_of_Insurance:=''; 
STRING Insurance_Expired:=''; 
STRING Insurance_Exempt:=''; 
STRING Insurance_Type:=''; 
STRING Insurance_Company_Code:=''; 
// new fields
STRING Insurance_Policy_Holder:=''; 
STRING Is_Tag_Converted:=''; 
STRING VIN_Original :=''; 
STRING Make_Original :=''; 
STRING Model_Original :=''; 
STRING Model_Year_Original :=''; 
STRING Other_Unit_VIN_Original :=''; 
STRING Other_Unit_Make_Original :=''; 
STRING Other_Unit_Model_Original :=''; 
STRING Other_Unit_Model_Year_Original:=''; 

string initial_point_of_contact	:='';
string vehicle_driveable:='';
string commercial_vehicle	;
string number_of_lanes	;
string divided_highway	;
string not_in_transport	;
string other_unit_number	;
string other_unit_length	;
string other_unit_axles	;
string other_unit_plate_expiration	;
string other_unit_permanent_registration;	
string other_unit_model_year2	;
string other_unit_make2	;
string other_unit_vin2	;
string other_unit_registration_state2	;
string other_unit_registration_year2	;
string other_unit_license_plate2	;
string other_unit_number2	;
string other_unit_length2	;
string other_unit_axles2	;
string other_unit_plate_expiration2	;
string other_unit_permanent_registration2	;
string other_unit_type2	;
string other_unit_model_year3	;
string other_unit_make3	;
string other_unit_vin3	;
string other_unit_registration_state3	;
string other_unit_registration_year3	;
string other_unit_license_plate3	;
string other_unit_number3	;
string other_unit_length3	;
string other_unit_axles3	;
string other_unit_plate_expiration3	;
string other_unit_permanent_registration3	;
string other_unit_type3	;
string damaged_areas3	;
string speed_limit_posted;
string Report_Damage_Extent	;
string Report_Vehicle_Type	;
string Report_Traffic_Control_Device_Type;	
string Report_Contributing_Circumstances_v;	
string Report_Vehicle_Maneuver_Action_Prior;	
string Report_Vehicle_Body_Type;
end;

export property_damage := record

string Property_Damage_ID;
string Incident_ID	;
string damage_description	;
string damage_estimate	;
string property_owner_name	;
string property_owner_phone	;
string property_owner_last_name	;
string property_owner_first_name	;
string property_owner_middle_name	;
string property_owner_address	;
string property_owner_city	;
string property_owner_state	;
string property_owner_zip_code	;
string property_owner_notified;
end; 

export layoutNahdbBatch := record

string EVENT_ID;
string DATE_OF_INCIDENT;
string FIRST_NAME;        
string MIDDLE_INITIAL  ;
string LAST_NAME;         
string ADDRESS1               ;
//string ADDRESS2;             
string CITY           ;
string STATE       ;
string ZIP             ;
string DOB           ;
string SSN;
string ADL; 
string VIN; 

end; 

export layout_temp := record
string title; 
string fname ; 
string mname ; 
string lname ; 
string suffix; 
string clean_dob; 
string clean_DATE_OF_INCIDENT ; 
string acc_dol,
string acc_city,	
string acc_st	,
string acc_county,	
string acc_vin,
string order_id	,
string sequence_nbr,	
string acct_nbr	,
string vehicle_incident_id,	
string carrier_name,	
string source_id,	
string orig_accnbr,	
string report_code,	
string person_type,	
string match_flag,	
string date_vendor_last_reported,
layoutNahdbBatch;
end; 

export layout_out := record
layoutNahdbBatch;
string acc_dol,
string acc_city,	
string acc_st	,
string acc_county,	
string acc_vin,
string order_id	,
string sequence_nbr,	
string acct_nbr	,
string vehicle_incident_id,	
string carrier_name,	
string source_id,	
string orig_accnbr,	
string report_code,	
string person_type,	
string match_flag,	
string date_vendor_last_reported,


end; 

end;

