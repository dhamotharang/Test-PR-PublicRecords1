/*
**********************************************************************************
Created by    Comments
Vani 					This attribute denormalizes th records in Vehicle file. The first
              five records are placed in slot 1 to 5 in the OKC layout and the rest 
							are concatinated to be used as additional comments. 
***********************************************************************************
*/	 

DVehicle   		 := DISTRIBUTE(File_soff_vehicle,  HASH32(File_soff_vehicle.id));
DSortedVehicle := SORT(DVehicle,id,LOCAL);
IdTable        := table(DSortedVehicle,Layout_Denorm_Vehicle,id,LOCAL);

//output(count(IdTable));
//output(IdTable);
//output(File_soff_vehicle);

Layout_Denorm_Vehicle DeNormVehicle(Layout_Denorm_Vehicle L, Layout_soff_vehicle R, INTEGER C) := TRANSFORM

string V_make_model_notes := trim(trim(trim(R.make,LEFT,RIGHT)+' '+trim(R.model,LEFT,RIGHT),LEFT,RIGHT)+ If (trim(R.notes,LEFT,RIGHT)<>'Vehicle',' '+trim(R.notes,LEFT,RIGHT),''),LEFT,RIGHT);

			SELF.orig_veh_year_1					 := IF(C=1, trim(R.year,LEFT,RIGHT), L.orig_veh_year_1);
			SELF.orig_veh_color_1					 := IF(C=1, trim(R.color,LEFT,RIGHT), L.orig_veh_color_1);
			SELF.orig_veh_make_model_1		 := IF(C=1, V_make_model_notes, L.orig_veh_make_model_1);
			SELF.orig_veh_plate_1					 := IF(C=1, trim(R.license_plate,LEFT,RIGHT), L.orig_veh_plate_1);
			SELF.orig_registration_number_1:= IF(C=1, trim(R.registration_number,LEFT,RIGHT), L.orig_registration_number_1);
			SELF.orig_veh_state_1					 := IF(C=1, trim(R.state,LEFT,RIGHT), L.orig_veh_state_1);
			SELF.orig_veh_location_1			 := IF(C=1, trim(R.location,LEFT,RIGHT), L.orig_veh_location_1);
			
			SELF.orig_veh_year_2	         := IF(C=2, trim(R.year,LEFT,RIGHT), L.orig_veh_year_2);
			SELF.orig_veh_color_2					 := IF(C=2, trim(R.color,LEFT,RIGHT), L.orig_veh_color_2);
			SELF.orig_veh_make_model_2		 := IF(C=2, V_make_model_notes, L.orig_veh_make_model_2);
			SELF.orig_veh_plate_2					 := IF(C=2, trim(R.license_plate,LEFT,RIGHT), L.orig_veh_plate_2);
			SELF.orig_registration_number_2:= IF(C=2, trim(R.registration_number,LEFT,RIGHT), L.orig_registration_number_2);
			SELF.orig_veh_state_2					 := IF(C=2, trim(R.state,LEFT,RIGHT), L.orig_veh_state_2);
			SELF.orig_veh_location_2			 := IF(C=2, trim(R.location,LEFT,RIGHT), L.orig_veh_location_2);
			
			SELF.orig_veh_year_3	         := IF(C=3, trim(R.year,LEFT,RIGHT), L.orig_veh_year_3);
			SELF.orig_veh_color_3					 := IF(C=3, trim(R.color,LEFT,RIGHT), L.orig_veh_color_3);
			SELF.orig_veh_make_model_3	   := IF(C=3, V_make_model_notes, L.orig_veh_make_model_3);
			SELF.orig_veh_plate_3					 := IF(C=3, trim(R.license_plate,LEFT,RIGHT), L.orig_veh_plate_3);
			SELF.orig_registration_number_3:= IF(C=3, trim(R.registration_number,LEFT,RIGHT), L.orig_registration_number_3);
			SELF.orig_veh_state_3					 := IF(C=3, trim(R.state,LEFT,RIGHT), L.orig_veh_state_3);
			SELF.orig_veh_location_3			 := IF(C=3, trim(R.location,LEFT,RIGHT), L.orig_veh_location_3);
			
			SELF.orig_veh_year_4	         := IF(C=4, trim(R.year,LEFT,RIGHT), L.orig_veh_year_4);
			SELF.orig_veh_color_4					 := IF(C=4, trim(R.color,LEFT,RIGHT), L.orig_veh_color_4);
			SELF.orig_veh_make_model_4		 := IF(C=4, V_make_model_notes, L.orig_veh_make_model_4);
			SELF.orig_veh_plate_4					 := IF(C=4, trim(R.license_plate,LEFT,RIGHT), L.orig_veh_plate_4);
			SELF.orig_registration_number_4:= IF(C=4, trim(R.registration_number,LEFT,RIGHT), L.orig_registration_number_4);
			SELF.orig_veh_state_4					 := IF(C=4, trim(R.state,LEFT,RIGHT), L.orig_veh_state_4);
			SELF.orig_veh_location_4			 := IF(C=4, trim(R.location,LEFT,RIGHT), L.orig_veh_location_4);
			
			SELF.orig_veh_year_5           := IF(C=5, trim(R.year,LEFT,RIGHT), L.orig_veh_year_5);
			SELF.orig_veh_color_5					 := IF(C=5, trim(R.color,LEFT,RIGHT), L.orig_veh_color_5);
			SELF.orig_veh_make_model_5		 := IF(C=5, V_make_model_notes, L.orig_veh_make_model_5);
			SELF.orig_veh_plate_5					 := IF(C=5, trim(R.license_plate,LEFT,RIGHT), L.orig_veh_plate_5);
			SELF.orig_registration_number_5:= IF(C=5, trim(R.registration_number,LEFT,RIGHT), L.orig_registration_number_5);
			SELF.orig_veh_state_5					 := IF(C=5, trim(R.state,LEFT,RIGHT), L.orig_veh_state_5);
			SELF.orig_veh_location_5			 := IF(C=5, trim(R.location,LEFT,RIGHT), L.orig_veh_location_5);
			
			STRING V_addl_veh_info         := trim(IF(R.year <> ''     and trim(R.year) <> 'Not Available','Vehicle Year: '+ trim(R.year,LEFT,RIGHT), '') +
																					   IF(V_make_model_notes <> '' and trim(V_make_model_notes) <> 'Not Available',' Vehicle Make: '+ trim(V_make_model_notes,LEFT,RIGHT), '') +
																						 IF(R.color <> ''    and trim(R.color) <> 'Not Available',' Vehicle Color: '+ trim(R.color,LEFT,RIGHT), '') +
																						 IF(R.license_plate <> ''    and trim(R.license_plate) <> 'Not Available',' Vehicle Tag: '+ trim(R.license_plate,LEFT,RIGHT), '') +
																						 IF(R.state <> ''    and trim(R.state) <> 'Not Available',' Vehicle State: '+ trim(R.state,LEFT,RIGHT), '') +
																						 IF(R.location <> '' and trim(R.location) <> 'Not Available',' Vehicle Location: '+ trim(R.location,LEFT,RIGHT), ''),LEFT,RIGHT);
																								
		  SELF.Addl_veh_information      := IF(C>5, IF(L.Addl_veh_information <> '',
			                                                  IF ( V_addl_veh_info <> '', 
																												           IF (length(L.Addl_veh_information +'; '+ V_addl_veh_info) <= 2000, 
																																	 L.Addl_veh_information +'; '+ V_addl_veh_info,L.Addl_veh_information ),
																																	 L.Addl_veh_information),
																						            V_addl_veh_info	) ,
																					 ''		
																					);		
			
		  SELF := L;
end;


		 
export Mapping_Denorm_Vehicle := DENORMALIZE(IdTable,DSortedVehicle,
                                             LEFT.id = RIGHT.id,
																	           DeNormVehicle(LEFT,RIGHT,COUNTER),LOCAL);
																	
																
																	

