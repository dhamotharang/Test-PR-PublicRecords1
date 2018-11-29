export map_basefile(string filedate) := function

import FLAccidents, Address, ut, did_add, header_slimsort, driversv2,lib_StringLib,AID,scrubs,scrubs_ecrash,nid,PromoteSupers;

 d      := FLAccidents_Ecrash.Infiles.cmbnd;
 vina	:= DISTRIBUTE(FLAccidents.File_VINA, HASH32(Vin_Input));
 dvina := DEDUP(SORT(vina, Vin_Input, -((UNSIGNED)Model_Year), RECORD, LOCAL), Vin_Input, LOCAL) :PERSIST('~thor_data400::persist::ecrash_vina');
 acmbnd := FLAccidents_Ecrash.Infiles.agencycmbnd;
 
////////////////////////////////////////////////////////////////////////////
//Clean names and addresses then append vina info
///////////////////////////////////////////////////////////////////////////

temp_layout := record
  d;
  string temp_addr1 := '';
  string temp_addr2 := '';
end;

temp_layout trecs(d L) := transform
  self.temp_addr1 := lib_StringLib.StringLib.StringCleanSpaces(trim(L.Address,left,right));
  self.temp_addr2 := lib_StringLib.StringLib.StringCleanSpaces(trim(L.CITY,left,right)+ if(trim(L.CITY,left,right) <> '',', ',' ')+trim(L.STATE,left,right)+' '+trim(L.ZIP_code,left,right)[1..5]);
  self := L;
end;
 precs := project(d,trecs(left));
 
 PrecsBlankAddr    := precs(temp_addr1='' and temp_addr2 =''); 
 PrecsNBlankAddr   := precs(~(temp_addr1='' and temp_addr2 ='')); 

//Clean address
 Address.MAC_Address_Clean(PrecsNBlankAddr,temp_addr1,temp_addr2,true,appndAddr);	
 cleanAddr := appndAddr +project(PrecsBlankAddr, transform({appndAddr}, self.clean :='', self := left));	

// Add name_type 

  Address.Mac_Is_Business_Parsed(	cleanAddr,fPreclean,FIRST_NAME,MIDDLE_NAME,LAST_NAME,'');

//Parse appended 182 byte clean address field and standardize data values

  FLAccidents_Ecrash.Layout_BaseFile trecs2(fPreclean L, dvina R) := transform

  string8     fSlashedMDYtoCYMD(string pDateIn) 
               :=          intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
                     +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
                     +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

  self.date_vendor_first_reported  := if(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10] !='0000-00-00'
																				,stringlib.stringfilterout(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10],'-')
																				,'');
  self.date_vendor_last_reported   := if(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10] !='0000-00-00'
																				,stringlib.stringfilterout(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10],'-')
																				,'');
  self.crash_date							     := if(trim(L.crash_date,left,right) !='0000-00-00'
																	      ,stringlib.stringfilterout(trim(L.crash_date,left,right),'-')
																				,'');
  self.dt_first_seen					     := self.crash_date;
  self.dt_last_seen						     := self.crash_date;
  self.creation_date					     := if(trim(L.creation_date,left,right)[1..10] !='0000-00-00'
																	      ,stringlib.stringfilterout(trim(L.creation_date,left,right)[1..10],'-')
																				,'');
  self.date_of_birth					     := map(regexfind('-',L.date_of_birth) and trim(L.date_of_birth,left,right)[1..10] !='0000-00-00'
																					=> stringlib.stringfilterout(trim(L.date_of_birth,left,right),'-'),
																	     regexfind('/',L.date_of_birth)=> fSlashedMDYtoCYMD(L.date_of_birth),'');
  self.officer_report_date		     := if(trim(L.officer_report_date,left,right)[1..10] !='0000-00-00'
																	      ,stringlib.stringfilterout(trim(L.officer_report_date,left,right)[1..10],'-')
																				,'');																				
  self.ems_notified_date		       := if(trim(L.ems_notified_date,left,right) !='0000-00-00'
																	      ,stringlib.stringfilterout(trim(L.ems_notified_date,left,right)[1..10],'-')
																				,'');																				
  self.ems_arrival_date		         := if(trim(L.ems_arrival_date,left,right) !='0000-00-00'
																	      ,stringlib.stringfilterout(trim(L.ems_arrival_date,left,right)[1..10],'-')
																				,'');
  self.death_date		      			   := if(trim(L.death_date,left,right) !='0000-00-00'
																	      ,stringlib.stringfilterout(trim(L.death_date,left,right)[1..10],'-')
																				,'');
  self.home_phone									 := stringlib.stringfilter(L.home_phone,'0123456789');
  set_ptype                        := ['P1','P2','P3','P4','P5','P6','P7','P8','P9'];
  self.person_type 						     := if(L.person_type in set_ptype,'PASSENGER', L.person_type);
  self.passenger_number						 := if(L.passenger_number != '0', L.passenger_number, '');
  self.total_occupants_in_vehicle	 := if(L.total_occupants_in_vehicle != '0', L.total_occupants_in_vehicle, '');
  self.number_of_vehicles					 := if(L.number_of_vehicles != '0', L.number_of_vehicles, '');
  self.loss_street_speed_limit		 := if(L.loss_street_speed_limit != '0', L.loss_street_speed_limit, '');
  self.vehicle_towed_derived			 := if(L.vehicle_towed_derived != '0', L.vehicle_towed_derived, '');
  self.age												 := if(L.age != '0', L.age, '');
  self.cru_order_id								 := if(L.cru_order_id != '0', L.cru_order_id, '');
  self.cru_sequence_nbr						 := if(L.cru_sequence_nbr != '0', L.cru_sequence_nbr, '');
  self.city_code									 := if(L.city_code != '00', L.city_code, '');
  self.other_unit_vehicle_damage_amount 
																   := L.other_unit_vehicle_damage_amount[1..stringlib.stringfind(L.other_unit_vehicle_damage_amount,'.',1)-1] + '00';
  self.report_code						     := map(L.source_id ='TF'=>'TF', l.source_id ='TM' => 'TM', 'EA');
  self.report_category				     := CASE(L.report_type_id
									                     ,'A'=>'Auto Report'
									                     ,'B'=>'Auto Report'
									                     ,'C'=>'Auto Report'
									                     ,'D'=>'Other Report'
									                     ,'E'=>'Other Report'
									                     ,'F'=>'Other Report'
									                     ,'G'=>'Other Report'
									                     ,'H'=>'Auto Report'
									                     ,'I'=>'Other Report'
									                     ,'J'=>'Auto Report'
									                     ,'K'=>'Other Report'
									                     ,'L'=>'Other Report'
									                     ,'M'=>'Other Report'
									                     ,'N'=>'Other Report'
									                     ,'O'=>'Other Report'
									                     ,'P'=>'Auto Report'
									                     ,'Q'=>'Auto Report'
									                     ,'R'=>'Auto Report'
									                     ,'S'=>'Certificates'
									                     ,'T'=>'Certificates'
									                     ,'U'=>'Other Report'
									                     ,'V'=>'Other Report'
									                     ,'W'=>'Other Report'
									                     ,'X'=>'Auto Report'
									                     ,'Y'=>'Other Report'
									                     ,'Z'=>'Other Report'
									                     ,'FS'=>'Auto Report' 
									                     ,'0'=>'Interactive Report'
									                     ,'1'=>'Interactive Report'
									                     ,'2'=>'Interactive Report'
									                     ,'3'=>'Interactive Report'
									                     ,'4'=>'Interactive Report'
									                     ,'5'=>'Interactive Report'
									                     ,'6'=>'Interactive Report'
									                     ,'7'=>'Interactive Report'
									                     ,'8'=>'Interactive Report','');

  self.report_code_desc				     := CASE(L.report_type_id
									                      ,'A'=>'Auto Accident'
									                      ,'B'=>'Auto Theft'
									                      ,'C'=>'Auto Theft Recovery'
									                      ,'D'=>'Theft Burglary'
									                      ,'E'=>'Fire Building'
									                      ,'F'=>'Fire Car'
									                      ,'G'=>'Vandalism'
									                      ,'H'=>'D.U.I. Report'
									                      ,'I'=>'MVR'
									                      ,'J'=>'Registered Vehicle Owner'
									                      ,'K'=>'Autopsy/Coroner'
									                      ,'L'=>'Homicide Report'
									                      ,'M'=>'Photos'
									                      ,'N'=>'Issue Letter Interest'
									                      ,'O'=>'Other'
									                      ,'P'=>'Insurance Verification'
									                      ,'Q'=>'Title History'
									                      ,'R'=>'All Registered Vehicles at Household'
									                      ,'S'=>'Death Certificate'
									                      ,'T'=>'Birth Certificate'
									                      ,'U'=>'Arrest Report'
									                      ,'V'=>'Citation/Conviction Report'
									                      ,'W'=>'EMS Report'
									                      ,'X'=>'Reconstruction Report'
									                      ,'Y'=>'Supplemental Report'
									                      ,'Z'=>'Toxicology Report'
									                      ,'FS'=>'Face Sheet/Log Sheet'
									                      ,'0'=>'All Registered Vehicles At Household By Last Name And Address'
									                      ,'1'=>'VIN'
									                      ,'2'=>'VIN With Reported Damage - Vehicle Claim History'
									                      ,'3'=>'Plate / Tag'
									                      ,'4'=>'Vehicles By Name, Address, Year, Make And Model'
									                      ,'5'=>'AutoCheck&reg - VIN History Report'
									                      ,'6'=>'Claims MVR (Driving History)'
									                      ,'7'=>'Carrier Discovery'
									                      ,'8'=>'Claims Discovery','');
									
 	self.prim_range 					    := L.clean[1..10]; 
	self.predir 						      := L.clean[11..12];					   
	self.prim_name 						    := L.clean[13..40];
	self.addr_suffix 					    := L.clean[41..44];
	self.postdir 						      := L.clean[45..46];
	self.unit_desig 					    := L.clean[47..56];
	self.sec_range 						    := L.clean[57..64];
	self.p_city_name 					    := L.clean[65..89];
	self.v_city_name 					    := L.clean[90..114];
	self.st 						          := if(L.clean[115..116]='',ziplib.ZipToState2(L.clean[117..121]),L.clean[115..116]);
	self.z5 						          := L.clean[117..121];
	self.z4 						          := L.clean[122..125];
	self.cart 						        := L.clean[126..129];
	self.cr_sort_sz 					    := L.clean[130];
	self.lot 						          := L.clean[131..134];
	self.lot_order 						    := L.clean[135];
	self.dpbc 						        := L.clean[136..137];
	self.chk_digit 						    := L.clean[138];
	self.rec_type 						    := L.clean[139..140];
	self.county_code					    := L.clean[141..145];
	self.geo_lat 						      := L.clean[146..155];
	self.geo_long 						    := L.clean[156..166];
	self.msa 						          := L.clean[167..170];
	self.geo_blk 						      := L.clean[171..177];
	self.geo_match 						    := L.clean[178];
	self.err_stat 						    := L.clean[179..182];
//Parse 73 byte clean name field
   CleanName							        := if (l.nametype <> 'B', Address.CleanPersonFML73(regexreplace(' +',L.FIRST_NAME+' '+L.MIDDLE_NAME+' '+L.LAST_NAME,' ')),'');
  //CleanName							      := Address.CleanPersonFML73(regexreplace(' +',L.FIRST_NAME+' '+L.MIDDLE_NAME+' '+L.LAST_NAME,' '));
  self.nameType							    := l.nametype;	
  lfname							          := if(l.nametype <> 'B',CleanName[6..25], L.FIRST_NAME);
  lmname							          := if(l.nametype <> 'B',CleanName[26..45],L.MIDDLE_NAME);
  llname							          := if(l.nametype <> 'B',CleanName[46..65],L.LAST_NAME);
	self.title                    := if(l.nametype <> 'B',CleanName[1..5],'');
	self.fname							      := if(lfname ='UNKNOWN','',lfname);
  self.mname							      := if(lmname ='UNKNOWN','',lmname);
  self.lname							      := if(llname ='UNKNOWN','',llname);
  self.suffix 					        := if(l.nametype <> 'B',CleanName[66..70],'');
  self.name_score						    := if(l.nametype <> 'B',CleanName[71..73],'');
  self.cname                    := if(l.nametype = 'B',L.FIRST_NAME+' '+L.MIDDLE_NAME+' '+L.LAST_NAME,'');
  self.orig_fname               := l.FIRST_NAME;
  self.orig_lname               := l.last_name;
  self.orig_mname               := l.middle_name;
// populated by Vina File
  self.vehicle_seg					    := map(L.vin = R.vin_input => R.variable_segment,'');	
  self.vehicle_seg_type				  := map(L.vin = R.vin_input => R.veh_type,'');	
  self.model_year						    := map(L.vin = R.vin_input => R.model_year,'');	
  self.body_style_code				  := map(L.vin = R.vin_input => R.vina_body_style,'');	
  self.engine_size					    := map(L.vin = R.vin_input => R.engine_size,'');	
  self.fuel_code						    := map(L.vin = R.vin_input => R.fuel_code,'');	
  self.number_of_driving_wheels	:= map(L.vin = R.vin_input => R.vp_tilt_wheel,'');	
  self.steering_type					  := map(L.vin = R.vin_input => R.vp_power_steering,'');		
  self.vina_series					    := map(L.vin = R.vin_input => R.vina_series,'');	
  self.vina_model						    := map(L.vin = R.vin_input => R.vina_model,'');	
  self.vina_make						    := map(L.vin = R.vin_input => R.make_description,'');	
  self.vina_body_style				  := map(L.vin = R.vin_input => R.vina_body_style,'');		
  self.make_description				  := map(L.vin = R.vin_input => R.make_description,trim(L.make,left,right));			
  self.model_description				:= map(L.vin = R.vin_input => R.model_description,L.model);		
  self.series_description				:= map(L.vin = R.vin_input => R.series_description,'');	
  self.car_cylinders					  := map(L.vin = R.vin_input => R.number_of_cylinders,'');	
    prefix                      := MAP(/*le.report_code[1] = 'I' and le.vehicle_incident_id[1..3] = 'OID'    => 1000000000000,
								                         le.report_code[1] = 'I' => 2000000000000,*/
								                         self.report_code = 'EA' => 3000000000000,
								                         self.report_code = 'TM' => 4000000000000,
								                         self.report_code = 'TF' => 5000000000000, 
                                         //le.report_code = 'FA' => 6000000000000,
								                         0);
	SELF.idfield                  := prefix + (unsigned6) L.incident_id;  
	self                          := L;
  self                          := [];
	
end;

  jrecs := join(distribute(fPreclean(vin!=''),hash(vin)), dvina,
				left.vin = right.vin_input,
				trecs2(left,right),left outer,local);
				
// get blank vin records 

FLAccidents_Ecrash.Layout_BaseFile trecs3(fPreclean L) := transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

  self.date_vendor_first_reported := if(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10] !='0000-00-00'
																				,stringlib.stringfilterout(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10],'-')
																				,'');
  self.date_vendor_last_reported  := if(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10] !='0000-00-00'
																				,stringlib.stringfilterout(trim(L.Sent_to_HPCC_DateTime,left,right)[1..10],'-')
																				,'');
  self.crash_date							    := if(trim(L.crash_date,left,right) !='0000-00-00'
																	      ,stringlib.stringfilterout(trim(L.crash_date,left,right),'-')
																				,'');
  self.dt_first_seen					    := self.crash_date;
  self.dt_last_seen						    := self.crash_date;
  self.creation_date					    := if(trim(L.creation_date,left,right)[1..10] !='0000-00-00'
																	      ,stringlib.stringfilterout(trim(L.creation_date,left,right)[1..10],'-')
																				,'');

  self.date_of_birth					    := map(regexfind('-',L.date_of_birth) and trim(L.date_of_birth,left,right)[1..10] !='0000-00-00'
																					=> stringlib.stringfilterout(trim(L.date_of_birth,left,right),'-'),
																	     regexfind('/',L.date_of_birth)=> fSlashedMDYtoCYMD(L.date_of_birth),'');
  self.officer_report_date		    := if(trim(L.officer_report_date,left,right)[1..10] !='0000-00-00'
																	      ,stringlib.stringfilterout(trim(L.officer_report_date,left,right)[1..10],'-')
																				,'');																				
  self.ems_notified_date		      := if(trim(L.ems_notified_date,left,right) !='0000-00-00'
																	      ,stringlib.stringfilterout(trim(L.ems_notified_date,left,right)[1..10],'-')
																				,'');																				
  self.ems_arrival_date		        := if(trim(L.ems_arrival_date,left,right) !='0000-00-00'
																	      ,stringlib.stringfilterout(trim(L.ems_arrival_date,left,right)[1..10],'-')
																				,'');
  self.death_date		      			  := if(trim(L.death_date,left,right) !='0000-00-00'
																	      ,stringlib.stringfilterout(trim(L.death_date,left,right)[1..10],'-')
																				,'');
  self.home_phone									:= stringlib.stringfilter(L.home_phone,'0123456789');

  set_ptype                       := ['P1','P2','P3','P4','P5','P6','P7','P8','P9'];
  self.person_type 						    := if(L.person_type in set_ptype,'PASSENGER', L.person_type);
  self.passenger_number						:= if(L.passenger_number != '0', L.passenger_number, '');
  self.total_occupants_in_vehicle	:= if(L.total_occupants_in_vehicle != '0', L.total_occupants_in_vehicle, '');
  self.number_of_vehicles					:= if(L.number_of_vehicles != '0', L.number_of_vehicles, '');
  self.loss_street_speed_limit		:= if(L.loss_street_speed_limit != '0', L.loss_street_speed_limit, '');
  self.vehicle_towed_derived			:= if(L.vehicle_towed_derived != '0', L.vehicle_towed_derived, '');
  self.age												:= if(L.age != '0', L.age, '');
  self.cru_order_id								:= if(L.cru_order_id != '0', L.cru_order_id, '');
  self.cru_sequence_nbr						:= if(L.cru_sequence_nbr != '0', L.cru_sequence_nbr, '');
  self.city_code									:= if(L.city_code != '00', L.city_code, '');
  self.other_unit_vehicle_damage_amount 
																  := L.other_unit_vehicle_damage_amount[1..stringlib.stringfind(L.other_unit_vehicle_damage_amount,'.',1)-1] + '00';

  self.report_code						     := map(L.source_id ='TF'=>'TF', l.source_id ='TM' => 'TM', 'EA');
  self.report_category				     := CASE(L.report_type_id
									                       ,'A'=>'Auto Report'
									                       ,'B'=>'Auto Report'
									                       ,'C'=>'Auto Report'
									                       ,'D'=>'Other Report'
									                       ,'E'=>'Other Report'
									                       ,'F'=>'Other Report'
									                       ,'G'=>'Other Report'
									                       ,'H'=>'Auto Report'
									                       ,'I'=>'Other Report'
									                       ,'J'=>'Auto Report'
									                       ,'K'=>'Other Report'
									                       ,'L'=>'Other Report'
									                       ,'M'=>'Other Report'
									                       ,'N'=>'Other Report'
									                       ,'O'=>'Other Report'
									                       ,'P'=>'Auto Report'
									                       ,'Q'=>'Auto Report'
									                       ,'R'=>'Auto Report'
									                       ,'S'=>'Certificates'
									                       ,'T'=>'Certificates'
									                       ,'U'=>'Other Report'
									                       ,'V'=>'Other Report'
									                       ,'W'=>'Other Report'
									                       ,'X'=>'Auto Report'
									                       ,'Y'=>'Other Report'
									                       ,'Z'=>'Other Report'
									                       ,'FS'=>'Auto Report' 
									                       ,'0'=>'Interactive Report'
									                       ,'1'=>'Interactive Report'
									                       ,'2'=>'Interactive Report'
									                       ,'3'=>'Interactive Report'
									                       ,'4'=>'Interactive Report'
									                       ,'5'=>'Interactive Report'
									                       ,'6'=>'Interactive Report'
									                       ,'7'=>'Interactive Report'
									                       ,'8'=>'Interactive Report','');

  self.report_code_desc				       := CASE(L.report_type_id
									                       ,'A'=>'Auto Accident'
									                       ,'B'=>'Auto Theft'
									                       ,'C'=>'Auto Theft Recovery'
									                       ,'D'=>'Theft Burglary'
									                       ,'E'=>'Fire Building'
									                       ,'F'=>'Fire Car'
									                       ,'G'=>'Vandalism'
									                       ,'H'=>'D.U.I. Report'
									                       ,'I'=>'MVR'
									                       ,'J'=>'Registered Vehicle Owner'
									                       ,'K'=>'Autopsy/Coroner'
									                       ,'L'=>'Homicide Report'
									                       ,'M'=>'Photos'
									                       ,'N'=>'Issue Letter Interest'
									                       ,'O'=>'Other'
									                       ,'P'=>'Insurance Verification'
									                       ,'Q'=>'Title History'
									                       ,'R'=>'All Registered Vehicles at Household'
									                       ,'S'=>'Death Certificate'
									                       ,'T'=>'Birth Certificate'
									                       ,'U'=>'Arrest Report'
									                       ,'V'=>'Citation/Conviction Report'
									                       ,'W'=>'EMS Report'
									                       ,'X'=>'Reconstruction Report'
									                       ,'Y'=>'Supplemental Report'
									                       ,'Z'=>'Toxicology Report'
									                       ,'FS'=>'Face Sheet/Log Sheet'
									                       ,'0'=>'All Registered Vehicles At Household By Last Name And Address'
									                       ,'1'=>'VIN'
									                       ,'2'=>'VIN With Reported Damage - Vehicle Claim History'
									                       ,'3'=>'Plate / Tag'
									                       ,'4'=>'Vehicles By Name, Address, Year, Make And Model'
									                       ,'5'=>'AutoCheck&reg - VIN History Report'
									                       ,'6'=>'Claims MVR (Driving History)'
									                       ,'7'=>'Carrier Discovery'
									                       ,'8'=>'Claims Discovery','');
									
	self.prim_range 					    := L.clean[1..10]; 
	self.predir 						      := L.clean[11..12];					   
	self.prim_name 						    := L.clean[13..40];
	self.addr_suffix 					    := L.clean[41..44];
	self.postdir 						      := L.clean[45..46];
	self.unit_desig 					    := L.clean[47..56];
	self.sec_range 						    := L.clean[57..64];
	self.p_city_name 					    := L.clean[65..89];
	self.v_city_name 					    := L.clean[90..114];
	self.st 						          := if(L.clean[115..116]='',ziplib.ZipToState2(L.clean[117..121]),L.clean[115..116]);
	self.z5 						          := L.clean[117..121];
	self.z4 						          := L.clean[122..125];
	self.cart 						        := L.clean[126..129];
	self.cr_sort_sz 					    := L.clean[130];
	self.lot 						          := L.clean[131..134];
	self.lot_order 						    := L.clean[135];
	self.dpbc 						        := L.clean[136..137];
	self.chk_digit 						    := L.clean[138];
	self.rec_type 						    := L.clean[139..140];
	self.county_code					    := L.clean[141..145];
	self.geo_lat 						      := L.clean[146..155];
	self.geo_long 						    := L.clean[156..166];
	self.msa 						          := L.clean[167..170];
	self.geo_blk 						      := L.clean[171..177];
	self.geo_match 						    := L.clean[178];
	self.err_stat 						    := L.clean[179..182];
//Parse 73 byte clean name field
  CleanName							        := if (l.nametype <> 'B', Address.CleanPersonFML73(regexreplace(' +',L.FIRST_NAME+' '+L.MIDDLE_NAME+' '+L.LAST_NAME,' ')),'');
  self.nameType							    := l.nametype;	
  lfname							          := if(l.nametype <> 'B',CleanName[6..25], L.FIRST_NAME);
  lmname							          := if(l.nametype <> 'B',CleanName[26..45],L.MIDDLE_NAME);
  llname							          := if(l.nametype <> 'B',CleanName[46..65],L.LAST_NAME);
	self.title                    := if(l.nametype <> 'B',CleanName[1..5],'');
	self.fname							      := if(lfname ='UNKNOWN','',lfname);
  self.mname							      := if(lmname ='UNKNOWN','',lmname);
  self.lname							      := if(llname ='UNKNOWN','',llname);
  self.suffix 					        := if(l.nametype <> 'B',CleanName[66..70],'');
  self.name_score						    := if(l.nametype <> 'B',CleanName[71..73],'');
  self.cname                    := if(l.nametype = 'B',L.FIRST_NAME+' '+L.MIDDLE_NAME+' '+L.LAST_NAME,'');
  self.orig_fname               := l.FIRST_NAME;
  self.orig_lname               := l.last_name;
  self.orig_mname               := l.middle_name;
	prefix                        := MAP(/*le.report_code[1] = 'I' and le.vehicle_incident_id[1..3] = 'OID'    => 1000000000000,
								                         le.report_code[1] = 'I' => 2000000000000,*/
								                         self.report_code = 'EA' => 3000000000000,
								                         self.report_code = 'TM' => 4000000000000,
								                         self.report_code = 'TF' => 5000000000000, 
                                         //le.report_code = 'FA' => 6000000000000,
								                         0);
	SELF.idfield                  := prefix + (unsigned6) L.incident_id;  

  self                          := L;
  self                          := [];
end;

precs2 := project(fPreclean(vin=''),trecs3(left));
				
  cmbndRecs := jrecs+precs2:persist('~thor_data400::persist::ecrash_clean')	;			
  p_recs:= FLAccidents_Ecrash.fAppendADL(cmbndRecs);

////////////////////////////////////////////////////////////////////////////////////////////////////
//Append DID using lfname and dl match --bug # 48839
////////////////////////////////////////////////////////////////////////////////////////////////////
  eAcc_noDID    := p_recs(did=0 and Drivers_License_Number != '');
  eAcc_allothers:= p_recs(did!=0 or Drivers_License_Number = '');

//splitting streams above to reduce skewing and process run time.

  dlf := driversv2.File_DL(did!=0 and regexfind('[1-9]',dl_number) and length(lname)>1 and dl_number !='1111111');

//create dl/DID table
slim_dl := record
  dlf.lname;
  dlf.fname;
  dlf.mname;
  dlf.dl_number;
  dlf.orig_state;
  dlf.did;
end;

tbl_dls       := table(dlf,slim_dl,lname,fname,mname,dl_number,orig_state,did,few): persist('~thor_200::persist::tbl_dl');

eAcc_noDID getDID(eAcc_noDID L, tbl_dls R) :=transform

     self.did    :=  map(L.Drivers_License_Number = R.dl_number 
                           and ut.NNEQ(L.Drivers_License_jurisdiction,R.orig_state) 
                           and (regexfind(
                                 regexreplace(' +',r.lname,' ')
                                ,regexreplace(' +',l.fname+' '+l.mname+' '+l.lname,' ')) or 
                                 regexfind(
                                 trim(r.lname,all)
                                 ,regexreplace(' +',l.fname+' '+l.mname+' '+l.lname,' ')))
                                 => R.did,L.did);
    
     self := L;
    
end;
    
appndDID := join(eAcc_noDID,dedup(tbl_dls,dl_number,lname,all),
                 left.Drivers_License_Number = right.dl_number and
                 ut.NNEQ(left.Drivers_License_jurisdiction,right.orig_state) and
                 (regexfind(
                    regexreplace(' +',right.lname,' ')
                     ,regexreplace(' +',left.fname+' '+left.mname+' '+left.lname,' ')) or 
                      regexfind(
                               trim(right.lname,all)
                        ,regexreplace(' +',left.fname+' '+left.mname+' '+left.lname,' '))),
                         getDID(left,right),left outer,hash);

appndDID getDID2(appndDID L, tbl_dls R) :=transform

  self.did := map(L.did = 0 
                  and L.Drivers_License_Number = R.dl_number 
                  and ut.NNEQ(L.Drivers_License_jurisdiction,R.orig_state)
                  and ut.NNEQ((string)L.mname[1],(string)R.mname[1])
                  and (regexfind(
                       regexreplace(' +',r.fname,' '),
                       regexreplace(' +',l.fname+' '+l.mname+' '+l.lname,' ')) or 
                       regexfind(
                       trim(r.fname,all)
                       ,regexreplace(' +',l.fname+' '+l.mname+' '+l.lname,' ')))
                   => R.did,L.did);
    
   self := L;
    
end;
    
  appndDID2 := join(appndDID,dedup(tbl_dls,dl_number,fname,all),
                  left.did = 0 and 
                  left.Drivers_License_Number = right.dl_number and
                  ut.NNEQ(left.Drivers_License_jurisdiction,right.orig_state) and
                  ut.NNEQ((string)left.mname[1],(string)right.mname[1])
                  and (regexfind(
                       regexreplace(' +',right.fname,' '),
                       regexreplace(' +',left.fname+' '+left.mname+' '+left.lname,' ')) or 
                       regexfind(
                       trim(right.fname,all),
                       regexreplace(' +',left.fname+' '+left.mname+' '+left.lname,' '))),
                       getDID2(left,right),left outer,hash);

// join super report id 
  eAcc_all     := dedup(sort(distribute(appndDID2 + eAcc_allothers ,hash(incident_id)),record,local),record,local)	:  persist('~thor_data400::persist::ecrash_did');	
	
  Supplemental := distribute(FLAccidents_Ecrash.Files.base.Supplemental,hash(incident_id)); 
	
	JoinSuperID  := join (eAcc_all, 
	                      Supplemental, 
												left.incident_id = right.incident_id, 
												transform(FLAccidents_Ecrash.Layout_Basefile, self.super_report_id := right.super_report_id ,
												self :=left) ,left outer, local
												); 
	
	//Transform to the layout that scrubs is expecting	
	file_to_scrub_t := project( JoinSuperID , FLAccidents_Ecrash.Layouts.scrubs);
	
//Apply Scrubs
	scrub_file_step1 := scrubs_ecrash.Scrubs.FromNone(file_to_scrub_t);
 // Find latest date 
  maxprocessdate   := max(scrub_file_step1.ExpandedInFile(date_vendor_last_reported [1..2]= '20'), date_vendor_last_reported) ;
	
	scrub_file_step2 := scrubs_ecrash.Scrubs.FromExpanded(scrub_file_step1.ExpandedInFile(date_vendor_last_reported = maxprocessdate));
	
//Generate Scrub reports, send it to Orbit and output report with invalid examples in WU 
	Orbit_st := scrub_file_step2.OrbitStats() :persist('~persist::ecrash_scrubs_rpt');
//Submits stats to Orbit
	submit_stats := Scrubs.OrbitProfileStats('Scrubs_eCrash',, Orbit_st, filedate).SubmitStats;
//Output Scrubs report with examples in WU
	Scrubs_report_with_examples := Scrubs.OrbitProfileStats('Scrubs_eCrash',, Orbit_st, filedate).CompareToProfile_with_examples;
//Send Alerts and Scrubs reports via email 
	Scrubs_alert := Scrubs_report_with_examples(RejectWarning = 'Y');
	attachment := Scrubs.fn_email_attachment(Scrubs_alert);
	
  mailfile := FileServices.SendEmailAttachData('Ayeesha.kayttala@lexisnexis.com;sudhir.kasavajjala@lexisnexis.com'
																						,'Scrubs ecrash Report ' //subject
																						,'Scrubs ecrash Report ' //body
																						,(data)attachment
																						,'text/csv'
																						,'ScrubsReport.csv'
																						,
																						,
																						,'sudhir.kasavajjala@lexisnexis.com');	
  //append bitmap to base
  dbuildbase := project (scrub_file_step1.BitmapInfile,FLAccidents_Ecrash.Layout_Basefile);

 	PromoteSupers.Mac_SF_BuildProcess(dbuildbase,'~thor_data400::base::ecrash',buildBase,,,true);
  PromoteSupers.Mac_SF_BuildProcess(FLAccidents_Ecrash.BuildSuppmentalReports.compare_add_new,'~thor_data400::base::ecrash_supplemental',buildsuppBase,,,true);
	PromoteSupers.Mac_SF_BuildProcess(FLAccidents_Ecrash.BuildSuppmentalReports.TMafterTF,'~thor_data400::base::ecrash_TMafterTF',buildBaseTMafterTF,,,true);
	PromoteSupers.Mac_SF_BuildProcess(FLAccidents_Ecrash.BuildPhotoFile.CmbndPhotos,'~thor_data400::base::ecrash_documents',buildDocumentBase,,,true);
	PromoteSupers.Mac_SF_BuildProcess(acmbnd,'~thor_data400::base::agency_cmbnd',buildAgencyCmbndBase,,,true);

//sequential( buildphotoBaseFile);


return sequential(  buildsuppBase
                    ,submit_stats
		                //output Scrubs Report
		                ,output(Scrubs_report_with_examples, all, named('ScrubsReportWithExamples'))
		                //Send Alerts if Scrubs exceeds threholds
		                ,if(count(Scrubs_alert) > 1, mailfile, output('No_Scrubs_Alerts'))	 
                    ,buildBase  
										,buildDocumentBase
										,buildBaseTMafterTF
										,buildAgencyCmbndBase
									);

end;



