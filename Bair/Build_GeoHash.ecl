import Bair,SALT32,ut,std;

EXPORT Build_GeoHash := MODULE
	
	EXPORT isValidCoord(REAL lat, REAL long) := long<>0 and lat<>0 and long>=-180 and long<=180 and lat>=-90 and lat<=90;

	EXPORT BakeEveFile(bfile) := FUNCTIONMACRO
		IMPORT ut;
		
		//These are the fields to be sorted. The position of these fields in the list doesn't contribute to the sorting order.
		//Add any new field to the sorting list at the end. If a field is an integer, convert to string and create a field with "str_*".
		fieldList:=
							 'ir_number'
							+',crime'
							+',location_type'
							+',object_of_attack_1'
							+',object_of_attack_2'
							+',point_of_entry_1'
							+',point_of_entry_2'
							+',suspects_actions_against_person_1'
							+',suspects_actions_against_person_2'
							+',suspects_actions_against_person_3'
							+',suspects_actions_against_person_4'
							+',suspects_actions_against_person_5'
							+',suspects_actions_against_property_1'
							+',suspects_actions_against_property_2'
							+',suspects_actions_against_property_3'
							+',property_taken_1'
							+',property_taken_2'
							+',property_taken_3'
							+',property_value'
							+',method_of_departure'
							+',first_date_time'
							+',last_date_time'
							+',report_date'
							+',address_of_crime'
							+',beat'
							+',rd'
							+',companions'
							+',apt'
							+',agency'
							+',accuracy'
							+',first_date'
							+',last_date'
							+',weapon_type_1'
							+',weapon_type_2'
							+',name_type'
							+',first_name'
							+',middle_name'
							+',last_name'
							+',moniker'
							+',persons_address'
							+',dob'
							+',race'
							+',sex'
							+',hair'
							+',hair_length'
							+',eyes'
							+',hand_use'
							+',speech'
							+',teeth'
							+',physical_condition'
							+',build'
							+',complexion'
							+',facial_hair'
							+',hat'
							+',mask'
							+',glasses'
							+',appearance'
							+',shirt'
							+',pants'
							+',shoes'
							+',jacket'
							+',soundex'
							+',facial_recognition'
							+',plate'
							+',make'
							+',model'
							+',style'
							+',color'
							+',year'
							+',type'
							+',vehicle_status'
							+',vehicle_address'
							+',str_longitude'
							+',str_latitude'
							+',str_weight_1'
							+',str_weight_2'
							+',str_height_1'
							+',str_height_2'
							+',str_age_1'
							+',str_age_2'
							+',str_first_time'
							+',str_last_time'
							+',Method_of_entry_1'
							+',Method_of_entry_2'
							+',First_day'
							+',Last_day'
							+',Address_name'
							+',Plate_state'
							+',persons_sid'
							+',moudf1'
							+',moudf2'
							+',moudf3'
							+',moudf4'
							+',moudf5'
							+',moudf6'
							+',moudf7'
							+',moudf8'
							+',personudf1'
							+',personudf2'
							+',personudf3'
							
							;

		//The position of the fields in the below layout is responsbile for the sorting order.
		//The new sorting fields should be added at the end of this layout.
		L := RECORD
			integer rid:=0;
			Bair.Layouts.GeoHashLayout;						
			real8        X_Coordinate;
			real8        Y_Coordinate;
			UNSIGNED4    UCR_Group;
			unsigned4    MOSTAMP;
			string50     data_provider_ori;
			boolean 		 raidsOnly;
			UNSIGNED2    weight_1;
			UNSIGNED2    weight_2;
			UNSIGNED2    height_1;
			UNSIGNED2    height_2;
			UNSIGNED2    age_1;
			UNSIGNED2    age_2;
			UNSIGNED2    First_Time;
			UNSIGNED2    Last_Time;
			
			string100    IR_Number;
			string		   Crime;
			string     	 Location_Type;
			string       Object_of_Attack_1;
			string       Object_of_Attack_2;
			string       Point_of_Entry_1;
			string       Point_of_Entry_2;
			string		   Suspects_Actions_Against_Person_1;
			string		   Suspects_Actions_Against_Person_2;
			string		   Suspects_Actions_Against_Person_3;
			string		   Suspects_Actions_Against_Person_4;
			string		   Suspects_Actions_Against_Person_5;
			string		   Suspects_Actions_Against_Property_1;
			string		   Suspects_Actions_Against_Property_2;
			string		   Suspects_Actions_Against_Property_3;
			string		   Property_Taken_1;
			string		   Property_Taken_2;
			string		   Property_Taken_3;
			string10     Property_Value;
			string		   Method_of_Departure;
			string25     First_Date_Time;
			string25     Last_Date_Time;
			string25     Report_Date;
			string		   Address_of_Crime;
			string		   Beat;
			string		   RD;
			string10     companions;
			string16     APT;
			string       Agency;
			string20     accuracy;
			string25     First_Date;
			string25     Last_Date;	
			string		   Weapon_Type_1;
			string		   Weapon_Type_2;
			string       name_type;
			string       first_name;
			string       middle_name;
			string       last_name;
			string       moniker;
			string       persons_address;
			string25     dob;
			string     	 race;
			string     	 sex;
			string     	 hair;
			string     	 hair_length;
			string    	 eyes;
			string     	 hand_use;
			string     	 speech;
			string     	 teeth;
			string     	 physical_condition;
			string     	 build;
			string     	 complexion;
			string     	 facial_hair;
			string     	 hat;
			string     	 mask;
			string     	 glasses;
			string     	 appearance;
			string     	 shirt;
			string     	 pants;
			string     	 shoes;
			string     	 jacket;
			string128    soundex;
			string       facial_recognition;
			string16     plate;
			string    	 make;
			string   	 	 model;
			string     	 style;
			string     	 color;
			string100    year;
			string    	 type;
			string     	 vehicle_status;
			string    	 vehicle_address;
			string15 		 Str_longitude;
			string15 		 Str_latitude;
			string5 		 Str_weight_1;
			string5 		 Str_weight_2;
			string5 		 Str_height_1;
			string5 		 Str_height_2;
			string5 		 Str_age_1;
			string5 		 Str_age_2;
			string5 		 Str_First_Time;
			string5 		 Str_Last_Time;
			string		   Method_of_Entry_1;
			string		   Method_of_Entry_2;
			string6      First_Day;
			string6      Last_Day;
			string		   Address_Name;
			string       plate_state;
			string       persons_sid;
			string       moudf1;
			string       moudf2;
			string       moudf3;
			string       moudf4;
			string       moudf5;
			string       moudf6;
			string       moudf7;
			string       moudf8;
			string       personudf1;
			string       personudf2;
			string       personudf3;
		END;

		D := PROJECT(bfile, TRANSFORM(L,
					_longitude := LEFT.x_coordinate;
					_latitude := LEFT.y_coordinate;
					SELF.gh12 :=  IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), SKIP);
 					SELF.date  := (unsigned)REGEXREPLACE('[^0-9]',LEFT.First_Date_Time,''),
					SELF.longitude := (string) _longitude,
					SELF.latitude := (string) _latitude,
					_class := Bair.MapClassCode(1,(string)LEFT.ucr_group);
					SELF.class := IF(_class<>'', _class, SKIP),				
					SELF.ori := (string)LEFT.data_provider_ori,
					self.etype := 1;
					SELf.eid := LEFT.eid,
					self.stamp := LEFT.mostamp,
					self.raids := left.raidsOnly,

					,SELF.Str_longitude 	:= REALFORMAT((real8)left.x_coordinate,15,10)
					,SELF.Str_latitude  	:= REALFORMAT((real8)left.y_coordinate,15,10)
					,SELF.Str_weight_1  	:= INTFORMAT(left.weight_1,5,1)
					,SELF.Str_weight_2  	:= INTFORMAT(left.weight_2,5,1)
					,SELF.Str_height_1  	:= INTFORMAT(left.height_1,5,1)
					,SELF.Str_height_2  	:= INTFORMAT(left.height_2,5,1)
					,SELF.Str_age_1  			:= INTFORMAT(left.age_1,5,1)
					,SELF.Str_age_2  			:= INTFORMAT(left.age_2,5,1)
					,SELF.Str_First_Time  := INTFORMAT(left.First_Time,5,1)
					,SELF.Str_Last_Time  	:= INTFORMAT(left.Last_Time,5,1)

					,SELF := LEFT
					));						

		ut.MAC_Sequence_Records(D, rid, Drid);

		BAIR.ToField(Drid, dOut, rid, fieldList);

		T 	:= BAIR.FieldAggregates(dOut).NTiles(255);

		D2  := BAIR.fRollup(Drid,T,L);

		baked := PROJECT(D2, Bair.Layouts.GeoHashLayout);

		return baked;
	ENDMACRO;	

	EXPORT BakeLprFile(bfile) := FUNCTIONMACRO
		IMPORT ut;
		//These are the fields to be sorted. The position of these fields in the list doesn't contribute to the sorting order.
		//Add any new field to the sorting list at the end. If a field is an integer, convert to string and create a field with "str_*".
		fieldList:=
							 'plate'
							+',Str_dateTime'
							+',str_longitude'
							+',str_latitude'
							;
		//The position of the fields in the below layout is responsbile for the sorting order.
		//The new sorting fields should be added at the end of this layout.
		L := RECORD
			integer rid:=0;
			Bair.Layouts.GeoHashLayout;
			real8     X_Coordinate;
			real8 		Y_Coordinate;
			string50  data_provider_ori;
			string25  CaptureDateTime;
			
			string40  Plate;
			string17 	Str_dateTime;
			string15 	Str_longitude;
			string15 	Str_latitude;
		END;

		D := PROJECT(bfile(x_coordinate<>0, y_coordinate<>0), TRANSFORM(L,
					_longitude := LEFT.x_coordinate;
					_latitude := LEFT.y_coordinate;
					SELF.gh12 :=  IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), SKIP)
					,SELF.longitude := (string) _longitude
					,SELF.latitude := (string) _latitude
					,SELF.class := Bair.MapClassCode(4,'9999')
					,SELF.ori := (string)LEFT.data_provider_ori
					,self.etype := 4
					,SELf.eid := LEFT.eid
					,self.stamp := 0

 					,SELF.Str_dateTime  := REGEXREPLACE('[^0-9]',LEFT.capturedatetime,'')
					,SELF.Str_longitude := REALFORMAT((real8)left.X_Coordinate,15,10)
					,SELF.Str_latitude  := REALFORMAT((real8)left.Y_Coordinate,15,10)

					,SELF.date := (unsigned)SELF.Str_dateTime 

					,SELF := LEFT
					));						

		ut.MAC_Sequence_Records(D, rid, Drid);

		BAIR.ToField(Drid, dOut, rid, fieldList);

		T 	:= BAIR.FieldAggregates(dOut).NTiles(255);

		D2  := BAIR.fRollup(Drid,T,L);

		baked := PROJECT(D2, Bair.Layouts.GeoHashLayout);

		return baked;
	ENDMACRO;

	EXPORT BakeCfsFile(bfile) := FUNCTIONMACRO
		//These are the fields to be sorted. The position of these fields in the list doesn't contribute to the sorting order.
		//Add any new field to the sorting list at the end. If a field is an integer, convert to string and create a field with "str_*".
		fieldList := 
							 'event_number'
							+',caller_address'
							+',place_name'
							+',location_type'
							+',district'
							+',beat'
							+',how_received'
							+',initial_type'
							+',final_type'
							+',incident_code'
							+',incident_progress'
							+',city'
							+',contacting_officer'
							+',complainant'
							+',current_phone'
							+',status'
							+',apartment_number'
							+',geocoded'
							+',accuracy'
							+',unit'
							+',officer_name'
							+',data_provider_name'
							+',str_x_coordinate'
							+',str_y_coordinate'
							+',str_complainant_x_coordinate'
							+',str_complainant_y_coordinate'
							+',str_initial_ucr_group'
							+',str_final_ucr_group'
							+',str_total_minutes_on_call'
							+',str_minutes_on_call'
							+',str_minutes_response'
							+',str_date_time_received'
							+',str_date_time_archived'
							+',str_date_time_dispatched'
							+',str_date_time_cleared'
							+',str_date_time_enroute'
							+',Priority1'
							+',Address'
							+',Primary_Officer'
							+',Call_Taker'
							+',str_date_time_arrived'
							+',complainant_address'
							+',disposition'
							;
		//The position of the fields in the below layout is responsbile for the sorting order.
		//The new sorting fields should be added at the end of this layout.
		L := RECORD
			integer rid:=0;
			Bair.Layouts.GeoHashLayout;
			real8     	 x_coordinate;
			real8     	 y_coordinate;
			UNSIGNED4    initial_ucr_group;
			string50     data_provider_ori;
			string25     date_time_received;
			string25     date_time_archived;
			string25     date_time_dispatched;
			string25     date_time_enroute;
			string25     date_time_cleared;
			real8     	 complainant_x_coordinate;
			real8     	 complainant_y_coordinate;
			real8        total_minutes_on_call;
			real8        minutes_on_call;
			real8        minutes_response;
			UNSIGNED4    final_ucr_group;
			
			string100    event_number;
			string       caller_address;
			string       place_name;
			string       location_type;
			string30     district;
			string30     beat;
			string50     how_received;
			string       initial_type;
			string50     final_type;
			string30     incident_code;
			string255    incident_progress;
			string50     city;
			string50     contacting_officer;
			string50     complainant;
			string30     current_phone;
			string50     status;
			string30     apartment_number;
			string1      geocoded;
			string20     accuracy;
			string30     unit;
			string50     officer_name;
			string200    data_provider_name;
			string15 		 Str_X_COORDINATE;
			string15 		 Str_Y_COORDINATE;
			string15 	   Str_COMPLAINANT_X_COORDINATE;
			string15 		 Str_COMPLAINANT_Y_COORDINATE;
			string10 		 Str_INITIAL_UCR_GROUP;
			string10 		 Str_FINAL_UCR_GROUP;
			string15 		 Str_TOTAL_MINUTES_ON_CALL;
			string15 		 Str_MINUTES_ON_CALL;
			string15 		 Str_MINUTES_RESPONSE;
			string17 		 Str_DATE_TIME_RECEIVED;
			string17 		 Str_DATE_TIME_ARCHIVED;
			string17 		 Str_DATE_TIME_DISPATCHED;
			string17 		 Str_DATE_TIME_CLEARED;
			string17 		 Str_DATE_TIME_ENROUTE;
			string30     priority1;
			string30     Address;
			string1			 Primary_Officer;
			string100    call_taker;
			string17		 Str_DATE_TIME_ARRIVED;
			string		   complainant_address;
			string30     disposition;
		END;
		
		D := PROJECT(bfile(x_coordinate<>0, y_coordinate<>0), TRANSFORM(L,	
										_latitude := LEFT.y_coordinate;
										_longitude := LEFT.x_coordinate;
										SELF.gh12 :=  IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), SKIP);
										,SELF.longitude := (string) _longitude
										,SELF.latitude := (string) _latitude
										,_class := Bair.MapClassCode(2,(string)LEFT.initial_ucr_group);
										SELF.class := IF(_class<>'', _class, SKIP)
										,SELF.ori := (string)LEFT.data_provider_ori
										,self.etype := 2
										,SELf.eid := LEFT.eid
										,self.stamp := 0 
										,SELF.Str_X_COORDINATE 							:= REALFORMAT((real8)left.X_Coordinate,15,10)
										,SELF.Str_Y_COORDINATE  						:= REALFORMAT((real8)left.Y_Coordinate,15,10)
										,SELF.Str_DATE_TIME_RECEIVED 				:= REGEXREPLACE('[^0-9]',(string)LEFT.date_time_received,'')
										,SELF.Str_DATE_TIME_ARCHIVED 				:= REGEXREPLACE('[^0-9]',(string)LEFT.date_time_archived,'')
										,SELF.Str_DATE_TIME_DISPATCHED 			:= REGEXREPLACE('[^0-9]',(string)LEFT.date_time_dispatched,'')
										,SELF.Str_DATE_TIME_ENROUTE 				:= REGEXREPLACE('[^0-9]',(string)LEFT.date_time_enroute,'') 
										,SELF.Str_DATE_TIME_CLEARED 				:= REGEXREPLACE('[^0-9]',(string)LEFT.date_time_cleared,'')
										,SELF.Str_DATE_TIME_ARRIVED  				:= REGEXREPLACE('[^0-9]',(string)LEFT.date_time_arrived,'') 
										,SELF.Str_COMPLAINANT_X_COORDINATE  := REALFORMAT((real8)left.COMPLAINANT_X_COORDINATE,15,10)
										,SELF.Str_COMPLAINANT_Y_COORDINATE 	:= REALFORMAT((real8)left.COMPLAINANT_Y_COORDINATE,15,10)										
										,SELF.Str_TOTAL_MINUTES_ON_CALL  		:= REALFORMAT((real8)left.TOTAL_MINUTES_ON_CALL,15,10)
										,SELF.Str_MINUTES_ON_CALL  					:= REALFORMAT((real8)left.MINUTES_ON_CALL,15,10)
										,SELF.Str_MINUTES_RESPONSE  				:= REALFORMAT((real8)left.MINUTES_RESPONSE,15,10)
										,SELF.Str_INITIAL_UCR_GROUP  				:= INTFORMAT(left.INITIAL_UCR_GROUP,10,1)
										,SELF.Str_FINAL_UCR_GROUP  					:= INTFORMAT(left.FINAL_UCR_GROUP,10,1)
										,SELF.date := (unsigned)SELF.Str_DATE_TIME_RECEIVED;
										,SELF := LEFT));		
		
		ut.MAC_Sequence_Records(D, rid, Drid);

		BAIR.ToField(Drid, dOut, rid, fieldList);

		T 	:= BAIR.FieldAggregates(dOut).NTiles(255);

		D2  := BAIR.fRollup(Drid,T,L);

		baked := PROJECT(D2, Bair.Layouts.GeoHashLayout);
		
		return baked;												
	ENDMACRO;	

	EXPORT BakeOffenderFile(bfile) := FUNCTIONMACRO
	
		IMPORT ut;
		//These are the fields to be sorted. The position of these fields in the list doesn't contribute to the sorting order.
		//Add any new field to the sorting list at the end. If a field is an integer, convert to string and create a field with "str_*".
		fieldList:=
							 'name_type'
							+',last_name'
							+',first_name'
							+',middle_name'
							+',moniker'
							+',address'
							+',race'
							+',sex'
							+',hair'
							+',hair_length'
							+',eyes'
							+',hand_use'
							+',speech'
							+',teeth'
							+',physical_condition'
							+',build'
							+',complexion'
							+',facial_hair'
							+',hat'
							+',mask'
							+',glasses'
							+',appearance'
							+',shirt'
							+',pants'
							+',shoes'
							+',jacket'
							+',Str_weight_1'
							+',Str_weight_2'
							+',Str_height_1'
							+',Str_height_2'
							+',Str_age_1'
							+',Str_age_2'
							+',dl_number'
							+',dl_state'
							+',fbi_number'
							+',edit_date'
							+',quarantined'
							+',admin_state'
							+',agency_name'
							+',agency_category'
							+',agency_level'
							+',case_reference_number'
							+',charge_offense'
							+',probation_type'
							+',probation_officer'
							+',warrant_type'
							+',warrant_number'
							+',gang_name'
							+',gang_role'
							+',Str_longitude'							
							+',Str_latitude'
							+',Str_classification_date'
							+',Str_agency'
							+',Str_sid'
							+',Str_bair_score'
							+',Str_expired'
							;
		//The position of the fields in the below layout is responsbile for the sorting order.
		//The new sorting fields should be added at the end of this layout.					
		L := RECORD
			integer rid:=0;
			Bair.Layouts.GeoHashLayout;
			real8 			x_coordinate;
			real8 			y_coordinate;
			string8  		classification;			
			string50    data_provider_ori;
			string25  	classification_date;
			string64  	agency_offender_id;
			string20    Offenders_sid;
			string10 		agency_score;
			string25  	expiration_date;
			UNSIGNED3   weight_1;
			UNSIGNED3   weight_2;
			UNSIGNED3   height_1;
			UNSIGNED3   height_2;
			INTEGER2    age_1;
			INTEGER2    age_2;
			
			string64    name_type;
			string64    last_name;
			string64    first_name;
			string64    middle_name;
			string104   moniker;
			string   		address;
			string30    race;
			string12    sex;
			string30    hair;
			string20   	hair_length;
			string20    eyes;
			string12    hand_use;
			string30    speech;
			string30    teeth;
			string64    physical_condition;
			string20    build;
			string30    complexion;
			string30    facial_hair;
			string20    hat;
			string20    mask;
			string20    glasses;
			string20    appearance;
			string20    shirt;
			string20    pants;
			string20    shoes;
			string20    jacket;
			string7	   	Str_weight_1;
			string7	   	Str_weight_2;
			string7	   	Str_height_1;
			string7	   	Str_height_2;
			string7	   	Str_age_1;
			string7	   	Str_age_2;
			string24 		dl_number;
			string24 		dl_state;
			string24 		fbi_number;
			string25    edit_date;
			string1   	quarantined;
			string20    admin_State;
			string96   	agency_Name;
			string64 		agency_category;
			string64 		agency_level;
			string75 		case_reference_number;
			string255 	charge_offense;
			string64  	probation_type;
			string50  	probation_officer;
			string64  	warrant_type;
			string64  	warrant_number;
			string64  	gang_name;
			string10  	gang_role;		
			string15 		Str_longitude;
			string15 		Str_latitude;
			string17 		Str_classification_date;
			string64 		Str_agency;
			string20 		Str_sid;
			string10 		Str_bair_score;
			string25 		Str_expired;
		END;

		D := PROJECT(bfile(x_coordinate<>0, y_coordinate<>0), TRANSFORM(L,
					_longitude := LEFT.x_coordinate;
					_latitude := LEFT.y_coordinate;
					SELF.gh12 :=  IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), SKIP);				  
					SELF.longitude := (string) _longitude,
					SELF.latitude := (string) _latitude,
					_class := Bair.MapClassCode(7,LEFT.classification);	
					SELF.class := IF(_class<>'', _class, SKIP),
					SELF.ori := (string)LEFT.data_provider_ori,
					self.etype := 7;
					SELf.eid := LEFT.eid,
					self.stamp := 0,
					self.raids := if(LEFT.classification in ['SEX', 'sex'], true, false),
					
 					 SELF.Str_classification_date  := REGEXREPLACE('[^0-9]',LEFT.classification_date,'')
					,SELF.Str_longitude 	:= REALFORMAT((real8)left.x_coordinate,15,10)
					,SELF.Str_latitude  	:= REALFORMAT((real8)left.y_coordinate,15,10)
					,SELF.date 						:= if(ut.CleanSpacesAndUpper(LEFT.classification) = 'SEX', (unsigned)LEFT.dt_vendor_last_reported*1000000000, (unsigned)SELF.Str_classification_date)
					,SELF.Str_agency 			:= LEFT.agency_offender_id
					,SELF.Str_sid 				:= LEFT.Offenders_sid
					,SELF.Str_bair_score 	:= LEFT.agency_score
					,SELF.Str_expired 		:= LEFT.expiration_date
					,SELF.Str_weight_1  	:= INTFORMAT(left.weight_1,7,1)
					,SELF.Str_weight_2  	:= INTFORMAT(left.weight_2,7,1)
					,SELF.Str_height_1  	:= INTFORMAT(left.height_1,7,1)
					,SELF.Str_height_2  	:= INTFORMAT(left.height_2,7,1)	
					,SELF.Str_age_1  			:= INTFORMAT(left.age_1,7,1)
					,SELF.Str_age_2  			:= INTFORMAT(left.age_2,7,1)					
					,SELF := LEFT
					));						

		ut.MAC_Sequence_Records(D, rid, Drid);

		BAIR.ToField(Drid, dOut, rid, fieldList);

		T 	:= BAIR.FieldAggregates(dOut).NTiles(255);

		D2  := BAIR.fRollup(Drid,T,L);

		baked := PROJECT(D2, Bair.Layouts.GeoHashLayout);

		return baked;		
	ENDMACRO;

	EXPORT BakeIntelFile(bfile) := FUNCTIONMACRO
		IMPORT ut;
		//These are the fields to be sorted. The position of these fields in the list doesn't contribute to the sorting order.
		//Add any new field to the sorting list at the end. If a field is an integer, convert to string and create a field with "str_*".
		fieldList:=
							 'source_reliability'
							+',case_number'
							+',call_case_number'
							+',incident_date'
							+',incident_type'
							+',incident_address'
							+',incident_city'
							+',incident_state'
							+',incident_zip'
							+',location_type'
							+',incident_content_validity'
							+',incident_entry_date'
							+',incident_purge_date'
							+',reporting_officer_first_name'
							+',reporting_officer_last_name'
							+',str_datetime'
							+',str_longitude'
							+',str_latitude'
							+',str_incident_id'
							+',str_incident_time'
							+',str_incident_source_score'
							+',vehicle_color_secondary'
							+',vehicle_vin'
							+',update_date'
							+',purgedate_computed'
							+',duration_since'
							;
		//The position of the fields in the below layout is responsbile for the sorting order.
		//The new sorting fields should be added at the end of this layout.
		L := RECORD
			integer rid:=0;
			Bair.Layouts.GeoHashLayout;
			real8 		x;
			real8 		y;
			string50  data_provider_ori;
			UNSIGNED2 incident_id;
			UNSIGNED2	incident_time;
			INTEGER2 	incident_source_score;
			
			string100 source_reliability;
			string20 	case_number;
			string20 	call_case_number;
			string25 	incident_date;
			string50 	incident_type;
			string100 incident_address;
			string25 	incident_city;
			string25 	incident_state;
			string25 	incident_zip;
			string50 	location_type;
			string50 	incident_content_validity;
			string25 	incident_entry_date;
			string25 	incident_purge_date;
			string50  reporting_officer_first_name;
			string50  reporting_officer_last_name;		
			string17  Str_dateTime;
			string15  Str_longitude;
			string15  Str_latitude;
			string15  Str_incident_id;
			string5   Str_incident_time;
			string6   Str_incident_source_score;
			string50	vehicle_color_secondary;
			string17	vehicle_vin;
			string25	update_date;
			string25	purgedate_computed;
			string		duration_since;	
		END;

		D := PROJECT(bfile(x<>0, y<>0), TRANSFORM(L,
						_longitude := LEFT.x;
						_latitude := LEFT.y;
						SELF.gh12 :=  IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), SKIP);
						SELF.longitude := (string) _longitude,
						SELF.latitude := (string) _latitude,
						_class := Bair.MapClassCode(5,LEFT.incident_type);		
						SELF.class := IF(_class<>'', _class, SKIP),				
						SELF.ori := (string)LEFT.data_provider_ori,
						self.etype := 5;
						SELf.eid := LEFT.eid,
						self.stamp := 0, // ??

 					,SELF.Str_dateTime  := REGEXREPLACE('[^0-9]',LEFT.incident_date,'')
					,SELF.Str_longitude := REALFORMAT((real8)left.x,15,10)
					,SELF.Str_latitude  := REALFORMAT((real8)left.y,15,10)
					,SELF.Str_incident_id  := INTFORMAT(left.incident_id,5,1)
					,SELF.Str_incident_time  := INTFORMAT(left.incident_time,5,1)
					,SELF.Str_incident_source_score  := INTFORMAT(left.incident_source_score,6,1)

					,SELF.date := (unsigned)SELF.Str_dateTime 

					,SELF := LEFT
					));						

		ut.MAC_Sequence_Records(D, rid, Drid);

		BAIR.ToField(Drid, dOut, rid, fieldList);

		T 	:= BAIR.FieldAggregates(dOut).NTiles(255);

		D2  := BAIR.fRollup(Drid,T,L);

		baked := PROJECT(D2, Bair.Layouts.GeoHashLayout);

		return baked;												
	ENDMACRO;
	
	EXPORT BakeCrashFile(bfile) := FUNCTIONMACRO

		IMPORT ut;
		//These are the fields to be sorted. The position of these fields in the list doesn't contribute to the sorting order.
		//Add any new field to the sorting list at the end. If a field is an integer, convert to string and create a field with "str_*".
		fieldList:=
							'case_number'
							+',reportnumber'
							+',report_date'
							+',address'
							+',county'
							+',crash_city'
							+',crash_state'
							+',hitandrun'
							+',intersectionrelated'
							+',officername'
							+',crashtype'
							+',locationtype'
							+',accidentclass'
							+',specialCircumstance1'
							+',specialCircumstance2'
							+',specialCircumstance3'
							+',lightcondition'
							+',weathercondition'
							+',surfacetype'
							+',roadSpecialFeature1'
							+',roadSpecialFeature2'
							+',roadSpecialFeature3'
							+',surfacecondition'
							+',trafficcontrolpresent'
							+',Str_vehicleid'
							+',first_name'
							+',last_name'
							+',licenseNumber'
							+',licenseState'
							+',race'
							+',sex'
							+',per_city'
							+',per_state'
							+',age'
							+',airbag'
							+',seatbelt'
							+',vin'
							+',plate'
							+',platestate'
							+',year'
							+',make'
							+',model'
							+',towed'
							+',vehicle_type'
							+',damage'
							+',sequence'
							+',driverimpairment'
							+',data_provider_name'
							+',Str_dateTime'
							+',Str_longitude'
							+',Str_latitude'							
							+',Str_vehicle_id'
							+',str_x_coordinate'
							+',str_y_coordinate'
							+',action'
							;
		//The position of the fields in the below layout is responsbile for the sorting order.
		//The new sorting fields should be added at the end of this layout.
		L := RECORD
			integer rid:=0;
			Bair.Layouts.GeoHashLayout;
			real8				x;
			real8				y;
			string50  	data_provider_ori;
			unsigned4		veh_id;
			unsigned4		vehicleid;
			
			string100		case_number;
			string100		reportNumber;
			string25		report_date;
			string255  	address;
			string20		county;
			string50		crash_city;
			string20		crash_state;
			string1			hitAndRun;
			string1			intersectionRelated;
			string50		officerName;
			string20		crashType;
			string25		locationType;
			string60		accidentClass;
			string50		specialCircumstance1;
			string50		specialCircumstance2;
			string50		specialCircumstance3;
			string50		lightCondition;
			string50		weatherCondition;
			string50		surfaceType;
			string60		roadSpecialFeature1;
			string60		roadSpecialFeature2;
			string60		roadSpecialFeature3;
			string60		surfaceCondition;
			string150		trafficControlPresent;
			string4  		Str_vehicleid;
			string1    	driver;
			string50   	first_name ;
			string50    last_name;
			string50    licenseNumber;
			string20    licenseState;
			string50   	race;
			string10    sex;
			string50    per_city;
			string25    per_state;
			UNSIGNED2   age;
			string50   	airbag;
			string50   	seatbelt;
			string100   vin;
			string100   plate;
			string100   plateState;
			string10    year;
			string50    make;
			string50    model;
			string1     towed;
			string50    vehicle_type;
			string255   damage;
			string255   sequence;
			string255   driverImpairment;
			string200   data_provider_name;				
			string17 		Str_dateTime;
			string15 		Str_longitude;
			string15 		Str_latitude;
			string4  		Str_vehicle_id;
			string15 		str_x_coordinate;
			string15 		str_y_coordinate;
			string	    action;
		END;

		D := PROJECT(bfile(x<>0, y<>0), TRANSFORM(L,
						_longitude := LEFT.x;
						_latitude := LEFT.y;
						SELF.gh12 :=  IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), SKIP);
						SELF.longitude := (string) _longitude,
						SELF.latitude := (string) _latitude,
						_class := Bair.MapClassCode(3,LEFT.crashType);
						SELF.class := IF(_class<>'', _class, SKIP),				
						SELF.ori := (string)LEFT.data_provider_ori,
						self.etype := 3;
						SELf.eid := LEFT.eid,
						self.stamp := 0, // ??

 					,SELF.Str_dateTime  := REGEXREPLACE('[^0-9]',LEFT.report_date,'')
					,SELF.Str_longitude := REALFORMAT((real8)left.x,15,10)
					,SELF.Str_latitude  := REALFORMAT((real8)left.y,15,10)
					,SELF.Str_vehicle_id  	:= INTFORMAT(left.veh_id,4,1)  //left.veh_id  or left.agency_vehicle_id??	
					,SELF.Str_vehicleid  		:= INTFORMAT(left.vehicleid,4,1)  //left.veh_id  or left.agency_vehicle_id??	
					,SELF.str_x_coordinate 	:= REALFORMAT((real8)left.x,15,10)
					,SELF.str_y_coordinate  := REALFORMAT((real8)left.y,15,10)					
					
					,SELF.date := (unsigned)SELF.Str_dateTime 
					,SELF := LEFT
					));						
					
		ut.MAC_Sequence_Records(D, rid, Drid);

		BAIR.ToField(Drid, dOut, rid, fieldList);

		T 	:= BAIR.FieldAggregates(dOut).NTiles(255);

		D2  := BAIR.fRollup(Drid,T,L);

		baked := PROJECT(D2, Bair.Layouts.GeoHashLayout);

		return baked;		
	ENDMACRO;

	EXPORT BakeShotSpotterFile(bfile) := FUNCTIONMACRO
		IMPORT ut;
		//These are the fields to be sorted. The position of these fields in the list doesn't contribute to the sorting order.
		//Add any new field to the sorting list at the end. If a field is an integer, convert to string and create a field with "str_*".
		fieldList:=
								'SHOT_ID'	
							+',address'												
							+',shots'
							+',beat'
							+',district'
							+',shot_source'
							+',shot_incident_type'
							+',shot_incident_status'
							+',Str_shot_datetime'
							+',Str_longitude'
							+',Str_latitude'							
							+',Str_raids_record_id'	
							;
		//The position of the fields in the below layout is responsbile for the sorting order.
		//The new sorting fields should be added at the end of this layout.					
		L := RECORD
			integer rid:=0;
			Bair.Layouts.GeoHashLayout;
			string25		shot_datetime;
			UNSIGNED2 	raids_record_id;
			UNSIGNED4 	data_provider_id;
			string50  	data_provider_ori;
			real8 			x_coordinate;
			real8 			y_coordinate;
			
			string24	 	shot_id;
			string100 	address;
			UNSIGNED2  	shots;
			string50		beat;
			string50  	district;
			string50  	shot_source;
			UNSIGNED1  	shot_incident_type;
			string24  	shot_incident_status;
			string17 		Str_shot_datetime;
			string15 		Str_longitude;
			string15 		Str_latitude;
			string6 		Str_raids_record_id;
		END;						
										
		D := PROJECT(bfile(x_coordinate<>0, y_coordinate<>0), TRANSFORM(L,
						_longitude := LEFT.x_coordinate;
						_latitude := LEFT.y_coordinate;
						SELF.gh12 :=  IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), SKIP);
						SELF.longitude := (string) _longitude,
						SELF.latitude := (string) _latitude,
						_class := Bair.MapClassCode(6,(string)LEFT.shot_incident_type);	// 01, 02, 19: single, multiple, possible	
						SELF.class := IF(_class<>'', _class, SKIP),				
						SELF.ori := (string)LEFT.data_provider_ori,
						self.etype := 6;
						SELf.eid := LEFT.eid,
						self.stamp := 0, // ??

 					,SELF.Str_shot_datetime  := REGEXREPLACE('[^0-9]',LEFT.shot_datetime,'')
					,SELF.Str_longitude := REALFORMAT((real8)left.x_coordinate,15,10)
					,SELF.Str_latitude  := REALFORMAT((real8)left.y_coordinate,15,10)
					,SELF.Str_raids_record_id  := INTFORMAT(left.raids_record_id,6,1)

					,SELF.date := (unsigned)SELF.Str_shot_datetime 

					,SELF := LEFT
					));

		ut.MAC_Sequence_Records(D, rid, Drid);

		BAIR.ToField(Drid, dOut, rid, fieldList);

		T 	:= BAIR.FieldAggregates(dOut).NTiles(255);

		D2  := BAIR.fRollup(Drid,T,L);

		baked := PROJECT(D2, Bair.Layouts.GeoHashLayout);

		return baked;												
	ENDMACRO;
		

	EXPORT BuildAll(boolean pUseProd = false, DATASET(Layouts.GeoHashLayout) inFile, string ver = '', boolean pDelta = false, boolean EmptyBase = false) := FUNCTION	
		
		suffix := if(pDelta, '::delta', '');
				
		vMod := IF(ver<>'','::'+ver,'');
		GHashBaseFileName 	:= Bair._Dataset(pUseProd).thor_cluster_files + 'base::' + Bair._Dataset(pUseProd).Name + '::geohash'+suffix+vMod;		
		GHashIndexFileName 	:= Bair._Dataset(pUseProd).thor_cluster_files + 'key::' + Bair._Dataset(pUseProd).Name + '::geohash'+suffix+vMod;
		
		baseGA := Bair.files().group_access_base.built;
		
		inFile_j := join(inFile, baseGA(ori <> '' and owner = 1), trim(left.ori, left, right) = trim(right.ori, left, right), transform({inFile}, self.group_id := right.group_id, self := left;), lookup);

		_buildBase := if(EmptyBase, output(dataset([], bair.layouts.GeoHashLayout),,GHashBaseFileName, compressed, overwrite), output(inFile_j,,GHashBaseFileName, compressed, overwrite));
		
		baseDS := DATASET(GHashBaseFileName, {Layouts.GeoHashLayout; UNSIGNED8 __Fpos{virtual(fileposition)}}, THOR);		
		
		key_GeoHashLayout := record
			bair.Layouts.GeoHashLayout - [gh12];			
			STRING4 	gh4;
			STRING8 	gh8;
			unsigned4	YYYYMM;
			UNSIGNED8 __Fpos{virtual(fileposition)};
		end;
		
		baseDS_p := project(baseDS, transform(key_GeoHashLayout, self.gh4 := left.gh12[1..4]; self.gh8 := left.gh12[5..12]; self.YYYYMM := (unsigned4)((string)left.date)[1..6]; self := left;));
						
		GHashKey  := Index(baseDS_p, {etype,class,gh4,YYYYMM,raids,eid}, {gh8,date,latitude,longitude,ori,group_id,raids,stamp,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,s37,s38,s39,s40,s41,s42,s43,s44,s45,s46,s47,s48,s49,s50,s51,s52,s53,s54,s55,s56,s57,s58,s59,s60,s61,s62,s63,s64,s65,s66,s67,s68,s69,s70,s71,s72,s73,s74,s75,s76,s77,s78,s79,s80,s81,s82,s83,s84,s85,s86,s87,s88,s89,s90,s91,s92,s93,s94,s95,s96,s97,s98,s99}, GHashIndexFileName);
		_buildKey := buildindex(GHashKey, overwrite);
		
		_buildall := SEQUENTIAL(
									if(STD.File.FileExists(GHashBaseFileName), output(GHashBaseFileName + ' already exist;'), _buildBase),
									if(STD.File.FileExists(GHashIndexFileName), output(GHashIndexFileName + ' already exist;'), _buildKey),
									if(not pDelta
										,sequential(
											fileservices.AddSuperFile(Bair.Filenames_Intermediary(pUseProd).geohash_base, GHashBaseFileName)
										 ,fileservices.AddSuperFile(Bair.Filenames_Intermediary(pUseProd).geohash_key, GHashIndexFileName)
										 )
										,sequential(
											bair.Promote(ver, pUseProd,pDelta,true).Promote_geohash.buildfiles.New2Built //Promote Base
										 ,bair.Promote(ver, pUseProd,pDelta,false).Promote_geohash.buildfiles.New2Built//Promote Key
										 ))
									);
		return _buildall;		
	END;
	
	EXPORT BuildLPR(boolean pUseProd = false, DATASET(Bair.Layouts.GeoHashLayout) inFile, string ver = '', boolean pDelta = false, boolean EmptyBase = false) := FUNCTION	
		
		suffix := if(pDelta, '::delta', '');
				
		vMod := IF(ver<>'','::'+ver,'');
		GHashLPRBaseFileName 	:= Bair._Dataset(pUseProd).thor_cluster_files + 'base::' + Bair._Dataset(pUseProd).Name + '::geohash::lpr'+suffix+vMod;		
		GHashLPRIndexFileName := Bair._Dataset(pUseProd).thor_cluster_files + 'key::' + Bair._Dataset(pUseProd).Name + '::geohash::lpr'+suffix+vMod;
		
		baseGA := Bair.files().group_access_base.built;
		
		inFile_j := join(inFile, baseGA(ori <> '' and owner = 1), trim(left.ori, left, right) = trim(right.ori, left, right), transform({inFile}, self.group_id := right.group_id, self := left;), lookup);

		_buildBase := if(EmptyBase, output(dataset([], bair.layouts.GeoHashLayout),,GHashLPRBaseFileName, compressed, overwrite), output(inFile_j,,GHashLPRBaseFileName, compressed, overwrite));
		
		baseDS := DATASET(GHashLPRBaseFileName, {Bair.Layouts.GeoHashLayout; UNSIGNED8 __Fpos{virtual(fileposition)}}, THOR);		
		
		key_GeoHashLayout := record
			bair.Layouts.GeoHashLayout_LPR;
			UNSIGNED8 __Fpos{virtual(fileposition)};
		end;
		
		baseDS_p := project(baseDS, transform(key_GeoHashLayout, self.gh8 := left.gh12[1..8]; self.gh4 := left.gh12[9..12]; self.YYYYMM := (unsigned4)((string)left.date)[1..6]; self := left;));
						
		GHashKey  := Index(baseDS_p, {gh8,YYYYMM,eid}, {gh4,date,latitude,longitude,ori,group_id,stamp,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,s37,s38,s39,s40,s41,s42,s43,s44,s45,s46,s47,s48,s49,s50,s51,s52,s53,s54,s55,s56,s57,s58,s59,s60,s61,s62,s63,s64,s65,s66,s67,s68,s69,s70,s71,s72,s73,s74,s75,s76,s77,s78,s79,s80,s81,s82,s83,s84,s85,s86,s87,s88,s89,s90,s91,s92,s93,s94,s95,s96,s97,s98,s99}, GHashLPRIndexFileName);
		_buildKey := buildindex(GHashKey, overwrite);		

		_buildall := SEQUENTIAL(
									if(STD.File.FileExists(GHashLPRBaseFileName), output(GHashLPRBaseFileName + ' already exist;'), _buildBase),
									if(STD.File.FileExists(GHashLPRIndexFileName), output(GHashLPRIndexFileName + ' already exist;'), _buildKey),
									if(not pDelta
											,sequential(
												fileservices.AddSuperFile(Bair.Filenames_Intermediary(pUseProd).geohash_lpr_base, GHashLPRBaseFileName)
											 ,fileservices.AddSuperFile(Bair.Filenames_Intermediary(pUseProd).geohash_lpr_key, GHashLPRIndexFileName)
											 )
											,sequential(
												bair.Promote(ver, pUseProd,pDelta,true).Promote_geohash_lpr.buildfiles.New2Built //Promote Base
											 ,bair.Promote(ver, pUseProd,pDelta,false).Promote_geohash_lpr.buildfiles.New2Built//Promote Key
											 ))
									);
		return _buildall;		
	END;
	
END;