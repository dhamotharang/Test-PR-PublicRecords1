/*2015-12-04T15:14:37Z (Sesha Nookala)

*/
import address, AID,bair;
EXPORT Layout_Bair_Conv := module

	export src_and_date	:= RECORD
		STRING2 		src;		
		UNSIGNED4 	dt_vendor_first_reported := 0;
		UNSIGNED4 	dt_vendor_last_reported := 0;
		UNSIGNED4		dt_first_seen	:= 0;
		UNSIGNED4		dt_last_seen	:= 0;
		STRING1   	record_type;
	end;
	
	export did_and_bdid := RECORD
		UNSIGNED8 bdid;
		UNSIGNED1 bdid_score := 0;
		UNSIGNED8 did;
		UNSIGNED1	did_score := 0;
	end;

	export dbo_cfs_Base := RECORD
		string23 eid;
		string20 fname;
		string20 mname;
		string20 lname;
		unsigned dob;
		string9 ssn;
		string10 phone;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		//qstring4 suffix;
		string25 city_name;
		string2 st;
		string5 zip;
END;
	
	export dbo_intel_Base := record
		bair.layouts.dbo_intel_Base - [height, weight];
		
		unsigned2  height;
		unsigned2  weight;
		Integer		class_code;
		string50	wc_address_name;
		string50	wc_location_type;
		string		agency;
 END;
 
 	export dbo_event_mo_final_Base := record
		bair.layouts.dbo_event_mo_final_Base - [Property_Value, companions, etype, first_time, last_time,
																						Sequence, Interval, Commonalities];
		string 		Property_Value;
		string  	companions;
		string		first_time;
		string 		last_time;
		string		Sequence;
		string		Interval;
		string		Commonalities;
		unsigned2 etype;
	end;
	
	export dbo_event_persons_final_Base := record
		bair.layouts.dbo_event_persons_final_Base;
	end;
	
	export dbo_event_vehicle_final_Base := record
		bair.layouts.dbo_event_vehicle_final_Base;
	end;
	
	
	export Events_layout := record
	dbo_event_mo_final_Base;
  dbo_event_persons_final_Base - [eid, gh12, etype, recordID_RAIDS, ir_number, edit_date, ORI, quarantined, group_id, 
																	RAIDS_activityDate, import_instance_id, data_provider_id, data_provider_ori, data_provider_name, 
																	address, latitude, longitude, city, state, zip, boundingBoxSouthWestLat, boundingBoxSouthWestLong, 
																	boundingBoxNorthEastLat, boundingBoxNorthEastLong/*, src_and_date, did_and_bdid,	clean_name , clean_address */, 
																	clean_edit_date, clean_RAIDS_activityDate, age_1, age_2, weight_1, weight_2, height_1, height_2];
  dbo_event_vehicle_final_Base - [eid, gh12, etype, recordID_RAIDS, ir_number, edit_date, ORI, quarantined, group_id, RAIDS_activityDate, import_instance_id, data_provider_id, data_provider_ori, data_provider_name, address, latitude, longitude, city, state, zip, boundingBoxSouthWestLat, boundingBoxSouthWestLong, boundingBoxNorthEastLat, boundingBoxNorthEastLong/*, src_and_date, did_and_bdid,	clean_name , clean_address*/, clean_edit_date, clean_RAIDS_activityDate];
	string age_1;
	string age_2;
	string height_1;
	string height_2;
	string weight_1;
	string weight_2;
	String5 primaryrec;
	Integer		class_code;
	string100	wc_crime;
	string30	wc_location_type;
	string50	wc_property_taken_1;
	string50	wc_property_taken_2;
	string50	wc_property_taken_3;
	string100	wc_address_of_crime;
	string50	wc_address_name;
	string50	wc_beat;
	string100	wc_rd;
	string16	wc_plate;
	string 		moudf1			:='';
	string 		moudf2			:='';
	string 		moudf3			:='';
	string 		moudf4			:='';
	string 		moudf5			:='';
	string 		moudf6			:='';
	string 		moudf7			:='';
	string 		moudf8			:='';
	string 		personudf1	:='';
	string 		personudf2	:='';
	string 		personudf3	:='';
	string 		personudf4	:='';
	end;
	
	export dbo_crash_Base := record
		bair.layouts.dbo_crash_Base;
		
		String5 	primaryrec;
		Integer		class_code;
		string20	wc_crashtype;
		string25	wc_locationtype;
		string100	wc_plate;
		string		agency;
	END;
	
	export dbo_offenders_Base := record
		bair.layouts.dbo_offenders_Base;
		string64    wc_last_name;
		string64    wc_first_name;
		string64    wc_middle_name;
		string64    wc_name_type;
		string104   wc_moniker;
		string20		wc_offenders_sid;
		Integer		  class_code;
		string			agency;
	END;
	
	export lpr_dbo_LicensePlateEvent_Base := RECORD
		bair.layouts.lpr_dbo_LicensePlateEvent_Base;
		Integer		class_code;
		string40	wc_plate;
		string		agency;
	end;
	
	export gunop_dbo_shot_incident_Base := record
		bair.layouts.gunop_dbo_shot_incident_Base;
		Integer		class_code;
		string50	wc_beat;
		string50	wc_district;
		string		agency;
	end;
end;
