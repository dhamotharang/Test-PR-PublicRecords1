/*
One time BWR to expand Person file layout with new PRtcc fields.
*/
IMPORT Data_Services;
EXPORT Pre_Update_Person_PRtcc_DataElements := FUNCTION

 Lay := RECORD,maxlength(20000)
  string person_id;
  string creation_date;
  string incident_id;
  string person_number;
  string sex;
  string person_type;
  string injury_status;
  string vehicle_unit_number;
  string seating_position1;
  string safety_equipment_restraint1;
  string safety_equipment_restraint2;
  string safety_equipment_helmet;
  string air_bag_deployed;
  string ejection;
  string drivers_license_jurisdiction;
  string dl_number_class;
  string dl_number_cdl;
  string dl_number_endorsements;
  string driver_actions_at_time_of_crash1;
  string driver_actions_at_time_of_crash2;
  string driver_actions_at_time_of_crash3;
  string driver_actions_at_time_of_crash4;
  string violation_codes;
  string condition_at_time_of_crash1;
  string condition_at_time_of_crash2;
  string law_enforcement_suspects_alcohol_use;
  string alcohol_test_status;
  string alcohol_test_type;
  string alcohol_test_result;
  string law_enforcement_suspects_drug_use;
  string drug_test_given;
  string non_motorist_actions_prior_to_crash1;
  string non_motorist_actions_prior_to_crash2;
  string non_motorist_actions_at_time_of_crash;
  string non_motorist_location_at_time_of_crash;
  string non_motorist_safety_equipment1;
  string age;
  string driver_license_restrictions1;
  string drug_test_type;
  string drug_test_result1;
  string drug_test_result2;
  string drug_test_result3;
  string drug_test_result4;
  string injury_area;
  string injury_description;
  string motorcyclist_head_injury;
  string party_id;
  string same_as_driver;
  string address_same_as_driver;
  string last_name;
  string first_name;
  string middle_name;
  string name_suffx;
  string date_of_birth;
  string address;
  string city;
  string state;
  string zip_code;
  string home_phone;
  string business_phone;
  string insurance_company;
  string insurance_company_phone_number;
  string insurance_policy_number;
  string insurance_effective_date;
  string ssn;
  string drivers_license_number;
  string drivers_license_expiration;
  string eye_color;
  string hair_color;
  string height;
  string weight;
  string race;
  string pedestrian_cyclist_visibility;
  string first_aid_by;
  string person_first_aid_party_type;
  string person_first_aid_party_type_description;
  string deceased_at_scene;
  string death_date;
  string death_time;
  string extricated;
  string alcohol_drug_use;
  string physical_defects;
  string driver_residence;
  string id_type;
  string proof_of_insurance;
  string insurance_expired;
  string insurance_exempt;
  string insurance_type;
  string violent_crime_victim_notified;
  string insurance_company_code;
  string refused_medical_treatment;
  string safety_equipment_available_or_used;
  string apartment_number;
  string licensed_driver;
  string physical_emotional_status;
  string driver_presence;
  string ejection_path;
  string state_person_id;
  string contributed_to_collision;
  string person_transported_for_medical_care;
  string transported_by_agency_type;
  string transported_to;
  string non_motorist_driver_license_number;
  string air_bag_type;
  string cell_phone_use;
  string driver_license_restriction_compliance;
  string driver_license_endorsement_compliance;
  string driver_license_compliance;
  string contributing_circumstances_p1;
  string contributing_circumstances_p2;
  string contributing_circumstances_p3;
  string contributing_circumstances_p4;
  string passenger_number;
  string person_deleted;
  string owner_lessee;
  string driver_charged;
  string motorcycle_eye_protection;
  string motorcycle_long_sleeves;
  string motorcycle_long_pants;
  string motorcycle_over_ankle_boots;
  string contributing_circumstances_environmental_non_incident1;
  string contributing_circumstances_environmental_non_incident2;
  string alcohol_drug_test_given;
  string alcohol_drug_test_type;
  string alcohol_drug_test_result;
  string law_enforcement_suspects_alcohol_use1;
  string law_enforcement_suspects_drug_use1;
  string solicitation;
  string drivers_license_type;
  string alcohol_test_type_refused;
  string alcohol_test_type_not_offered;
  string alcohol_test_type_field;
  string alcohol_test_type_pbt;
  string alcohol_test_type_breath;
  string alcohol_test_type_blood;
  string alcohol_test_type_urine;
  string trapped;
  string dl_number_cdl_endorsements;
  string dl_number_cdl_restrictions;
  string dl_number_cdl_exempt;
  string dl_number_cdl_medical_card;
  string interlock_device_in_use;
  string drug_test_type_blood;
  string drug_test_type_urine;
  string driver_distracted_by;
  string non_motorist_type;
  string seating_position_row;
  string seating_position_seat;
  string seating_position_description;
  string transported_id_number;
  string witness_number;
  string date_of_birth_derived;
  string report_injury_status;
  string address2;
 END;
										 
 ds_person := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::persn_raw'
											,Lay
											,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Person_ID');
													 

 FLAccidents_Ecrash.Layout_Infiles.persn_NEW ExpandPersonLayout(ds_person L) := TRANSFORM
																																									SELF.Dui_Suspected := '';
																																									SELF.Report_Contributing_Circumstances_p := '';
																																									SELF := L;
																																								 END;
																									 
 upd_person_layout := PROJECT(ds_person, ExpandPersonLayout(LEFT));
		
 OUTPUT(upd_person_layout,,'~thor_data400::in::ecrash::person_layout_change_prtcc_'+workunit,overwrite,__compressed__,
				csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

 do_all :=  SEQUENTIAL(
												FileServices.StartSuperFileTransaction(),
												FileServices.AddSuperFile('~thor_data400::in::ecrash::persn_raw','~thor_data400::in::ecrash::person_layout_change_prtcc_'+workunit),
												FileServices.FinishSuperFileTransaction()
										  );
					 
 RETURN do_all;
END;

