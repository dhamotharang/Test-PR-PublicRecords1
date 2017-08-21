
remove_these := ['NONE REPORTED','0','N/A','OTHER OTHER','NONE REPORTED NONE REPORTED'];

VehRec_temp2 := RECORD

	UNSIGNED1 numRows;
  STRING    full_rec;
  Layout_SOR_Vehicle_out;
	
END;

/*addressTable := DATASET([ {'Other ADDRESS: 3723 VISION BLVD,  ORANGE COUNTY JAIL, ORLANDO, FL 32839-8600, County :ORANGE'},
{'Registration ADDRESS: URB. EL CORTIJO APT.D 0-23, BAYAMON, PR 00956;'},
{'Employer ADDRESS: 6557 COUNTY HIGHWAY 67, HANCOCK, NY 13783;Employer ADDRESS: UNKNOWN, TROUT CREEK, NY 00000'}],origaddrRec);
*/

D_OffenderMain   := File_SOR_Main_with_PKey;


// Normalize addresses in the record.
Layout_SOR_Vehicle_out Extract_Vehicles(D_OffenderMain  L, INTEGER Cnt) := TRANSFORM 
												
  SELF.orig_veh_year_1 := MAP (Cnt = 1 and trim(L.orig_veh_year_1) not in remove_these=> L.orig_veh_year_1,
	                             Cnt = 2 and trim(L.orig_veh_year_2) not in remove_these=> L.orig_veh_year_2,
											         '');
  SELF.orig_veh_color_1:= MAP (Cnt = 1 and trim(L.orig_veh_color_1) not in remove_these=> L.orig_veh_color_1,
	                             Cnt = 2 and trim(L.orig_veh_color_2) not in remove_these=> L.orig_veh_color_2,
											         '');
  SELF.orig_veh_make_model_1 := MAP (Cnt = 1 and trim(L.orig_veh_make_model_1) not in remove_these=> L.orig_veh_make_model_1,
	                                   Cnt = 2 and trim(L.orig_veh_make_model_2) not in remove_these=> L.orig_veh_make_model_2,
											               '');
  SELF.orig_veh_plate_1      := MAP (Cnt = 1 and trim(L.orig_veh_plate_1) not in remove_these=> L.orig_veh_plate_1,
	                                   Cnt = 2 and trim(L.orig_veh_plate_2) not in remove_these=> L.orig_veh_plate_2,
											               '');
  SELF.orig_veh_state_1      := MAP (Cnt = 1 and trim(L.orig_veh_state_1) not in remove_these=> L.orig_veh_state_1,
	                                   Cnt = 2 and trim(L.orig_veh_state_2) not in remove_these=> L.orig_veh_state_2,
											               '');							
  SELF :=L;
 
END;

Normed_SORVehicles_1      := NORMALIZE(d_offendermain(name_type ='0'),2,Extract_Vehicles(LEFT,COUNTER),local);
Fil_Normed_SORVehicles   := Normed_SORVehicles_1(orig_veh_year_1 <> '' or 
                                          orig_veh_color_1 <> '' or 
                                          orig_veh_make_model_1 <> '' or 
																					orig_veh_plate_1  <> '' or 
																					orig_veh_state_1  <> '' );																				
																					
														

// Extract addresses from Addl_comments
VehRec_temp2 Extract_Veh_frm_comm(D_OffenderMain  L) := TRANSFORM

  integer numrows  := stringlib.StringFindCount(L.Addl_comments_1,';');
  string lastchar  := L.Addl_comments_1[length(L.Addl_comments_1)];
  SELF.numRows     := If (lastchar =';',numrows,numrows+1);
  SELF.full_rec    := If (lastchar =';',L.Addl_comments_1,L.Addl_comments_1+';');
  SELF.orig_veh_year_1       := '';
  SELF.orig_veh_color_1      := '';
  SELF.orig_veh_make_model_1 := '';
  SELF.orig_veh_plate_1      := '';
  SELF.orig_veh_state_1      := '';	
  SELF := L;
END;

veh_addl_comments1 := project(d_OffenderMain(name_type ='0' and stringlib.stringfind(Addl_comments_1,'VEHICLE YEAR:',1 )>0),Extract_Veh_frm_comm(LEFT),local);

VehRec_temp2 Extract_Veh_frm_comm2(D_OffenderMain  L) := TRANSFORM

  integer numrows := stringlib.StringFindCount(L.Addl_comments_2,';');
  string lastchar := L.Addl_comments_2[length(L.Addl_comments_2)];
  SELF.numRows    := If (lastchar =';',numrows,numrows+1);
  SELF.full_rec    := If (lastchar =';',L.Addl_comments_2,L.Addl_comments_2+';');
  SELF.orig_veh_year_1       := '';
  SELF.orig_veh_color_1      := '';
  SELF.orig_veh_make_model_1 := '';
  SELF.orig_veh_plate_1      := '';
  SELF.orig_veh_state_1      := '';	
  SELF := L;
END;
veh_addl_comments2 := project(d_OffenderMain(name_type ='0' and stringlib.stringfind(Addl_comments_2,'VEHICLE YEAR:',1 )>0),Extract_Veh_frm_comm2(LEFT),local);

Combine_vehicles   := Veh_addl_comments1+Veh_addl_comments2;

//Normalize addresses from Addl_comments
Layout_SOR_Vehicle_out Norm_Parse_vehicle(VehRec_temp2  L, INTEGER Cnt) := TRANSFORM

  integer nth_veh_loc      := stringlib.stringfind(trim(L.full_rec),';',cnt);
  integer nth_minus1_loc   := IF(cnt =1, 0, stringlib.stringfind(L.full_rec,';',cnt-1));

  string  v_the_veh        := L.full_rec[nth_minus1_loc+1..nth_veh_loc-1]; 

  //SELF.full_rec            := v_the_veh;

  v_year  := regexfind('VEHICLE YEAR:[ ][a-zA-z?0-9]*[ ]*[a-zA-z?0-9 ]*[ ]VEHICLE|VEHICLE YEAR:[ ][a-zA-z?0-9]*[ ]*[a-zA-z?0-9 ]*' ,v_the_veh,0);
  v_color := regexfind('VEHICLE COLOR:[ ][a-zA-z?0-9]*[ ]*[a-zA-z?0-9 ]*[ ]VEHICLE|VEHICLE COLOR:[ ][a-zA-z?0-9]*[ ]*[a-zA-z?0-9 ]*' ,v_the_veh,0);
  v_make  := regexfind('VEHICLE MAKE:[ ][a-zA-z?0-9]*[ ]*[a-zA-z?0-9 ]*[ ]VEHICLE|VEHICLE MAKE:[ ][a-zA-z?0-9]*[ ]*[a-zA-z?0-9 ]*' ,v_the_veh,0);
  v_plate := regexfind('VEHICLE TAG:[ ][a-zA-z?0-9]*[ ]*[a-zA-z?0-9 ]*[ ]VEHICLE|VEHICLE TAG:[ ][a-zA-z?0-9]*[ ]*[a-zA-z?0-9 ]*' ,v_the_veh,0);
  v_state := regexfind('VEHICLE STATE:[ ][a-zA-z?0-9]*[ ]*[a-zA-z?0-9 ]*[ ]VEHICLE|VEHICLE STATE:[ ][a-zA-z?0-9]*[ ]*[a-zA-z?0-9 ]*' ,v_the_veh,0);
					
  SELF.orig_veh_year_1       := stringlib.stringfindreplace(stringlib.stringfindreplace(v_year,'VEHICLE YEAR: ',''),' EHICLE','');
  SELF.orig_veh_color_1      := stringlib.stringfindreplace(stringlib.stringfindreplace(v_color,'VEHICLE COLOR: ',''),' VEHICLE','');
  SELF.orig_veh_make_model_1 := stringlib.stringfindreplace(stringlib.stringfindreplace(v_make,'VEHICLE MAKE: ',''),' VEHICLE','');
  SELF.orig_veh_plate_1      := stringlib.stringfindreplace(stringlib.stringfindreplace(v_plate,'VEHICLE TAG: ',''),' VEHICLE','');
  SELF.orig_veh_state_1      := stringlib.stringfindreplace(stringlib.stringfindreplace(v_state,'VEHICLE STATE: ',''),' VEHICLE','');						
  SELF :=L;

END;

Normed_vehicles_2 := NORMALIZE(Combine_vehicles,LEFT.numRows,Norm_Parse_vehicle(LEFT,COUNTER),local);

Fil_Normed_addl_vehicles := Normed_vehicles_2;

All_vehicles   := Fil_Normed_SORVehicles + Fil_Normed_addl_vehicles;

//-------------------------------------------------------------------------------------------------

export Mapping_Extract_SOR_Vehicles := All_vehicles ;//: persist('persist::Imap::SOR_Vehicles');