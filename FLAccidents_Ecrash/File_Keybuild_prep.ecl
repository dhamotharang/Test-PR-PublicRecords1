/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
import FLAccidents;

flc_ss 	:= FLAccidents.basefile_flcrash_ss(lname+cname+prim_name<>'');

xpnd_layout := record
    string8 dt_first_seen;
    string8 dt_last_seen;
    string2 report_code;
    string25 report_category;
    string65 report_code_desc;
	string10 vehicle_incident_id;
	string1	vehicle_status;
	string50 accident_location;
	string25 accident_street;
	string25 accident_cross_street;
	string100  jurisdiction;
	string2 jurisdiction_state;
	string11 jurisdiction_nbr;
	string64 IMAGE_HASH;
	string1 AIRBAGS_DEPLOY;
	string12  did,
	string40  accident_nbr,
	string8   accident_date, 
	string5   title,
	string20  fname,
	string20  mname,
	string20  lname,
	string5   name_suffix,
	string12  b_did,
	string25  cname,
	string10  prim_range,
	string2   predir,
	string28  prim_name,
	string4   addr_suffix,
	string2   postdir,
	string10  unit_desig,
	string8   sec_range,
	string25  v_city_name,
	string2   st,
	string5   zip,
	string4   zip4,
  string20  record_type,
	string15  driver_license_nbr,
	string2   dlnbr_st,
	string22  vin,
	string8   tag_nbr,
	string2   tagnbr_st,
	string8 dob,
	
	string25 vehicle_incident_city;
	string2 vehicle_incident_st;
	string41 carrier_name;
	string5	client_type_id;
	string30 Policy_num,	   
  string8 Policy_Effective_Date,   
	string8 Policy_Expiration_Date,
	string4 Report_Has_Coversheet,
	string1 other_vin_indicator;
	string3 vehicle_unit_number;
	string4 towed,
	string80 impact_location,

	string1   vehicle_owner_driver_code,
	string1   vehicle_driver_action,
	string4   vehicle_year,
	string4   vehicle_make,  
	string2   vehicle_type,
	string36  vehicle_travel_on,
	string1   direction_travel,
	string3   est_vehicle_speed,
	string2   posted_speed,
	string7   est_vehicle_damage,
	string1   damage_type,
	string25  vehicle_removed_by,
	string1   how_removed_code,
	
	string15  point_of_impact,
	string2   vehicle_movement,
	string2   vehicle_function,
	string2   vehs_first_defect,
	string2   vehs_second_defect,
	string2   vehicle_modified,
	string2   vehicle_roadway_loc,
	string1   hazard_material_transport,
	string3   total_occu_vehicle,
	string3   total_occu_saf_equip,
	string1   moving_violation,
	string1   vehicle_insur_code,
	string1   vehicle_fault_code,
	string2   vehicle_cap_code,
	string1   vehicle_fr_code,
	string2   vehicle_use,
	string1   placarded,
	string1   dhsmv_vehicle_ind,
	
	string42  vehicle_seg,
	string1   vehicle_seg_type,
	string14  match_code,
	string4   model_year,
	string3   manufacturer_corporation,
	string1   division_code,
	string2   vehicle_group_code,
	string2   vehicle_subgroup_code,
	string2   vehicle_series_code,
	string2   body_style_code,
	string3   vehicle_abbreviation,
	string1   assembly_country,
	string1   headquarter_country,
	string1   number_of_doors,
	string1   seating_capacity,
	string2   number_of_cylinders,
	string4   engine_size,
	string1   fuel_code,
	string1   carburetion_type,
	string1   number_of_barrels,
	string1   price_class_code,
	string2   body_size_code,
	string1   number_of_wheels_on_road,
	string1   number_of_driving_wheels,
	string1   drive_type,
	string1   steering_type,
	string1   gvw_code,
	string1   load_capacity_code,
	string1   cab_type_code,
	string2   bed_length,
	string1   rim_size,
	string5   manufacture_body_style,
	string1   vehicle_type_code,
	string3   car_line_code,
	string1   car_series_code,
	string1   car_body_style_code,
	string1   engine_cylinder_code,
	string3   truck_make_abbreviation,
	string3   truck_body_style_abbreviation,
	string3   motorcycle_make_abbreviation,
	string3   vina_series,
	string3   vina_model,
	string5   reference_number,
	string3   vina_make,
	string2   vina_body_style,
	string20  make_description,
	string20  model_description,
	string20  series_description,
	string3   car_series,
	string2   car_body_style,
	string3   car_cid,
	string2   car_cylinders,
	string1   car_carburetion,
	string1   car_fuel_code,
	string2   truck_chassis_body_style,
	string2   truck_wheels_driving_wheels,
	string4   truck_cid,
	string2   truck_cylinders,
	string1   truck_fuel_code,
	string1   truck_manufacturers_gvw_code,
	string2   truck_ton_rating_code,
	string3   truck_series,
	string3   truck_model,
	string3   motorcycle_model,
	string4   motorcycle_engine_displacement,
	string2   motorcycle_type_of_bike,
	string2   motorcycle_cylinder_coding,
	
  end;
	


	

xpnd_layout xpndrecs(flc_ss L, FLAccidents.Key_FLCrash2v R) := transform
self.dt_first_seen					:= L.accident_date;
self.dt_last_seen					:= L.accident_date;
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self.vehicle_incident_id			:= '';
self.vehicle_status					:= map(L.accident_nbr = R.accident_nbr and 
										   L.vin = R. vehicle_id_nbr and 
										   R.vina_series+R.vina_model+R.reference_number+R.vina_make+R.vina_body_style+R.series_description
											+R.car_series+R.car_body_style+R.car_cid+R.car_cylinders<>''=>'V','');
self.accident_location		:= '';
self.accident_street		:= '';
self.accident_cross_street	:= '';
self.jurisdiction			:= 'FLORIDA HP';
self.jurisdiction_state		:= 'FL';
self.jurisdiction_nbr		:= '';
self.IMAGE_HASH				:= '';
self.AIRBAGS_DEPLOY			:= '';
self.dob := '';
self.driver_license_nbr := if(regexfind('[0-9]',L.driver_license_nbr),L.driver_license_nbr,'');

self.carrier_name := R.ins_company_name;
self.client_type_id := '';
	
//These fields pertain to National Accidents and Ecrash data to be used for Experian and Carfax extracts.
self.vehicle_incident_city			:= '';// mapped in the next transform (from the flcrash events key)
self.vehicle_incident_st			:= 'FL';
//self.report_id:= '';
//self.sequence_nbr:= '';
self.towed:= '';
self.impact_location:= '';
self.Policy_num:= '';  
self.Policy_Effective_Date:= ''; 
self.Policy_Expiration_Date:= '';
self.Report_Has_Coversheet:= '0';
//self.userid := '';
//self.polk_validated_vin := '';
self.other_vin_indicator:= '';
self.vehicle_unit_number := '';
self 								:= R;
self 								:= L;

end;

pflc_ss := join(distribute(flc_ss,hash(accident_nbr,vin)),
				distribute(pull(FLAccidents.Key_FLCrash2v),hash(accident_nbr,vehicle_id_nbr)),
				left.accident_nbr = right.accident_nbr and 
				left.vin = right.vehicle_id_nbr,
				xpndrecs(left,right),left outer, local);
 
/////////////////////////////////////////////////////////////////
xpnd_layout xpndrecs2(pflc_ss L,FLAccidents.Key_FlCrash0 R) := transform

self.vehicle_incident_city			:= stringlib.stringtouppercase(if(L.accident_nbr= R.accident_nbr,R.city_town_name,''));

self 								:= L;
end;

pflc_ss2 := distribute(join(distribute(pflc_ss,hash(accident_nbr))
			  ,distribute(pull(FLAccidents.Key_FlCrash0)(accident_nbr != ''),hash(accident_nbr))
			  ,left.accident_nbr = right.accident_nbr,
			   xpndrecs2(left,right),left outer,local),random());
				 

/////////////////////////////////////////////////////////////////
//Slim National file 
///////////////////////////////////////////////////////////////// 
ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;

pflc_ss slimrec(ntlFile L) := transform
string8     fSlashedMDYtoCYMD(string pDateIn) :=
intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.did					:= if(L.did = 0,'000000000000',intformat(L.did,12,1));	
self.accident_nbr 			:= (string40)((unsigned6)L.vehicle_incident_id+10000000000);
self.accident_date			:= fSlashedMDYtoCYMD(L.loss_date[1..10]);
self.b_did					:= if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
self.cname					:= stringlib.stringtouppercase(L.business_name);
self.addr_suffix 			:= L.suffix;
self.zip					:= L.zip5;
self.record_type			:= CASE(L.party_type
									,'OWNER'=>'Property Owner'
									,'DRIVER'=>'Vehicle Driver'
									,'');
self.driver_license_nbr		:= if(regexfind('[0-9]',L.pty_drivers_license),L.pty_drivers_license,'');
self.dlnbr_st				:= L.pty_drivers_license_st;
									
self.tag_nbr				:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.tag,'');	
self.tagnbr_st				:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.tag_state,'');
self.vin					:= L.vehvin;
self.accident_location		:= map(L.cross_street!='' and L.cross_street!= 'N/A' => L.street+' & '+L.cross_street,L.street);
self.accident_street		:= L.street;
self.accident_cross_street	:= map(L.cross_street!= 'N/A' => L.cross_street,'');
self.jurisdiction			:= trim(L.edit_agency_name,left,right);
self.jurisdiction_state		:= L.STATE_ABBR;
self.st						:= if(l.st = '',self.jurisdiction_state,l.st);
self.jurisdiction_nbr		:= L.AGENCY_ID;
self.IMAGE_HASH				:= L.PDF_IMAGE_HASH;
self.AIRBAGS_DEPLOY			:= L.AIRBAGS_DEPLOY;
self.DOB								:= L.DOB;
self.Policy_num:= L.POLICY_NBR;  
self.Policy_Effective_Date:= ''; 
self.Policy_Expiration_Date:= '';
self.Report_Has_Coversheet:= if(L.PDF_IMAGE_HASH !='','1','0');
self.other_vin_indicator:= '';

self.vehicle_year					:=L.vehYear;	
self.vehicle_make					:=L.vehMake;
self.make_description				:= if(L.make_description != '',L.make_description,L.vehMake);
self.model_description				:= if(L.model_description != '',L.model_description,L.vehModel);
self.vehicle_incident_city	        := stringlib.stringtouppercase(L.inc_city);
self.vehicle_incident_st			:= stringlib.stringtouppercase(L.state_abbr);
self.point_of_impact				:= L.impact_location;
//------------------------------------


//////////////////////////////////////////////////////////////////
//For Carfax and Experian Extract
self.towed				      := L.Car_Towed;
self.Impact_Location    := L.Impact_Location ;
//self.city_of_loss				:= L.inc_city;
//self.make 				      := if(L.make_description != '',L.make_description,L.make);
//self.year 				      := if(L.model_year != '',L.model_year,L.model);
//self.model				      := if(L.model_description != '',L.model_description,L.model);
//self.report_id					:= L.order_id;
//self.userid							:= L.userid;
//self.polk_validated_vin := L.polk_validated_vin;
self.carrier_name				:= L.legal_name;
self.client_type_id     := L.client_type_id;
self.vehicle_unit_number := '';


self						:= L;
self						:= [];
end;
pntl := project(ntlFile,slimrec(left));

/////////////////////////////////////////////////////////////////
//Slim National inquiry file 
///////////////////////////////////////////////////////////////// 
inqFile := FLAccidents_Ecrash.File_CRU_inquiries;

pflc_ss slimrec2(inqFile L) := transform
string8     fSlashedMDYtoCYMD(string pDateIn) :=
intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
self.report_code					:= 'I'+ L.report_code;
self.report_category				:= L.report_category;
self.report_code_desc				:= L.report_code_desc;
self.did					:= if(L.did = 0,'000000000000',intformat(L.did,12,1));	
self.accident_nbr 			:= if(L.vehicle_incident_id[1..3] = 'OID',
													(string40)((unsigned6)L.vehicle_incident_id[4..11]+100000000000),
													(string40)((unsigned6)L.vehicle_incident_id+10000000000));
self.accident_date			:= fSlashedMDYtoCYMD(L.loss_date[1..10]);
self.b_did					:= if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
self.cname					:= '';
self.addr_suffix 			:= L.suffix;
self.zip					:= L.zip5;
self.record_type			:= 'Vehicle Driver';
self.driver_license_nbr		:= if(regexfind('[0-9]',L.drivers_license),L.drivers_license,'');
self.dlnbr_st				:= L.drivers_license_st;
self.tag_nbr				:= L.otag;	
self.tagnbr_st				:= L.otag_state;
self.vin					:= L.vin;
self.accident_location		:= map(L.cross_street!='' and L.cross_street!= 'N/A' => L.street+' & '+L.cross_street,L.street);
self.accident_street		:= L.street;
self.accident_cross_street	:= map(L.cross_street!= 'N/A' => L.cross_street,'');
self.jurisdiction			:= stringlib.stringtouppercase(trim(L.city,left,right));
self.jurisdiction_state		:= stringlib.stringtouppercase(L.state);
self.st						:= if(l.st = '',self.jurisdiction_state,l.st);
self.jurisdiction_nbr		:= L.AGENCY_ID;
self.IMAGE_HASH				:= '';
self.AIRBAGS_DEPLOY			:= '';
self.DOB								:= if( L.DOB_1 <> '',fSlashedMDYtoCYMD(L.DOB_1[1..10]),'');
self.Policy_num:= '';  
self.Policy_Effective_Date:= ''; 
self.Policy_Expiration_Date:= '';
self.Report_Has_Coversheet:= '0';
self.other_vin_indicator:= '';
self.vehicle_year			:= L.Year;
self.vehicle_make			:= L.make;
self.make_description				:= if(L.make_description != '',L.make_description,L.Make);
self.model_description			:= if(L.model_description != '',L.model_description,L.Model);
self.vehicle_incident_city	        := stringlib.stringtouppercase(L.city);
self.vehicle_incident_st			:= stringlib.stringtouppercase(L.state);
self.point_of_impact				:= '';
self.carrier_name     := L.legal_name;
self.client_type_id 	:= '';
self.vehicle_unit_number := '';


//////////////////////////////////////////////////////////////////
//For Carfax and Experian Extract
self.towed				      := '';
self.Impact_Location    := '';
//self.city_of_loss				:= '';
//self.make 				      := if(L.make_description != '',L.make_description,L.make);
//self.year 				      := if(L.model_year != '',L.model_year,L.model);
//self.model				      := if(L.model_description != '',L.model_description,L.model);
//self.report_id					:= L.order_id;
//self.userid							:= L.userid;
//self.polk_validated_vin := '';
self						:= L;
self						:= [];

end;
pinq:= project(inqFile,slimrec2(left));

/////////////////////////////////////////////////////////////////
//Slim Ecrash file 
///////////////////////////////////////////////////////////////// 
eFile := FLAccidents_Ecrash.BaseFile;

pflc_ss slimrec3(eFile L, unsigned1 cnt) := transform
self.accident_nbr 			:= L.case_identifier;
self.accident_date			:= if(L.incident_id[1..9] ='188188188','20100901',L.crash_date);
self.b_did							:= if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
self.cname							:= '';
self.name_suffix 				:= L.suffix;
self.did								:= if(L.did = 0,'000000000000',intformat(L.did,12,1));	
self.zip								:= L.z5;
self.zip4								:= L.z4;
self.record_type				:= L.person_type;
self.driver_license_nbr	:= if(regexfind('[0-9]',L.drivers_license_number),L.drivers_license_number,'');
self.dlnbr_st						:= L.drivers_license_jurisdiction; 
self.tag_nbr						:= if(L.Other_Unit_VIN !='',choose(cnt,L.License_Plate,L.Other_Unit_License_Plate),L.License_Plate);
self.tagnbr_st					:= if(L.Other_Unit_VIN !='',choose(cnt,L.Registration_State,L.Other_Unit_Registration_State),L.Registration_State);
self.vin								:= if(L.Other_Unit_VIN !='',choose(cnt,L.vin,L.Other_Unit_VIN),L.vin);
self.accident_location	:= map(L.loss_cross_street!='' and L.loss_cross_street!= 'N/A' => L.loss_street+' & '+L.loss_cross_street,L.loss_street);
self.accident_street		:= L.loss_street;
self.accident_cross_street	
												:= map(L.loss_cross_street!= 'N/A' => L.loss_cross_street,'');
self.jurisdiction				:= if(L.incident_id[1..9]='188188188','LN Test PD',trim(L.agency_name,left,right));
self.jurisdiction_state	:= if(L.case_identifier = '11030001','GA',L.Loss_state_Abbr);
self.st									:= if(l.st = '',self.jurisdiction_state,l.st);
self.jurisdiction_nbr		:= if(L.incident_id[1..9]='188188188','1536035',L.AGENCY_ID);
self.IMAGE_HASH					:= L.HASH_Key;
self.AIRBAGS_DEPLOY			:= L.Airbags_Deployed_Derived;
self.vehicle_incident_id
												:= L.incident_id;
self.vehicle_status			:= if(L.Other_Unit_VIN !='',choose(cnt,l.vin_status,l.other_unit_vin_status),l.vin_status);
self.DOB								:= map(L.incident_id[1..9] ='188188188' and L.lname = 'DOE' => '19690201'
															,L.incident_id[1..9] ='188188188' and L.lname = 'SMITH' => '19500405'
															,L.Date_of_Birth);
//------------------------------------------------------------													
year					              := trim(if(L.Other_Unit_VIN !='',choose(cnt,if(L.model_year != '',L.model_year,L.model_yr),
																														L.other_model_year),
																														if(L.model_year != '',L.model_year,L.model_yr)),left,right);																														
self.vehicle_year						:= map(length(year) = 2 and year>'50' => '19'+ year,
																	 length(year) = 2 and year<='50' => '20'+ year,year);
self.model_year 						:= map(length(year) = 2 and year>'50' => '19'+ year,
																	 length(year) = 2 and year<='50' => '20'+ year,year);
//------------------------------------------------------------	
self.vehicle_make					  := if(L.Other_Unit_VIN !='',choose(cnt,if(L.make_description != '',L.make_description,L.make),
																														if(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														if(L.make_description != '',L.make_description,L.make));
self.make_description				:= if(L.Other_Unit_VIN !='',choose(cnt,if(L.make_description != '',L.make_description,L.make),
																														if(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														if(L.make_description != '',L.make_description,L.make));
self.model_description			:= if(L.Other_Unit_VIN !='',choose(cnt,if(L.model_description != '',L.model_description,L.model),
																														if(L.other_model_description != '',L.other_model_description,L.other_unit_model)),
																														if(L.model_description != '',L.model_description,L.model));
self.vehicle_incident_city	:= stringlib.stringtouppercase(L.Crash_City);
self.vehicle_incident_st		:= stringlib.stringtouppercase(L.Loss_State_Abbr);
//self.point_of_impact				:= L.impact_location;
//------------------------------------

//////////////////////////////////////////////////////////////////
//For Carfax and Experian Extract
//self.city_of_loss    := L.crash_city;
//self.report_id			 := 'E' + L.report_id;
//self.sequence_nbr	   := '0';
self.towed				   := L.Vehicle_Towed_Derived;
self.impact_location := if(L.Damaged_Areas_Derived1 !='','Damaged_Area_1: ' + L.Damaged_Areas_Derived1,'')
												+ if(L.Damaged_Areas_Derived2 !='','Damaged_Area_2: ' + L.Damaged_Areas_Derived2,'');

//self.make 				   := choose(cnt,if(L.make_description != '',L.make_description,L.make),if(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make));

//self.year 				   := choose(cnt,if(L.model_year != '',L.model_year,L.model),if(L.other_model_year != '',L.other_model_year,L.Other_Unit_model));
//self.model				   := choose(cnt,if(L.model_description != '',L.model_description,L.model),if(L.other_model_description != '',L.other_model_description,L.other_unit_model));
self.Policy_num			 := L.Insurance_Policy_Number;  
self.Policy_Effective_Date:= L.Insurance_Effective_Date; 
self.Policy_Expiration_Date:= '';//L.Insurance_Expiration_Date;
self.carrier_name     := L.Insurance_Company;
self.client_type_id 	:= '';
self.Report_Has_Coversheet:= if(L.Report_Has_Coversheet = '1', '1','0');
self.other_vin_indicator:= if(L.Other_Unit_VIN !='',choose(cnt,'1','2'),'');
self.vehicle_unit_number := L.unit_number;

//self.userid          := '';
//self.polk_validated_vin := '';
self								 := L;
self := [];

end;
pec := normalize(eFile,2,slimrec3(left,counter));

allrecs := pntl+pflc_ss2+pinq+pec;


///////////////////////////////////////////////
//UPcase all field values, string count must be modified as fields are added to this layout
///////////////////////////////////////////////
recordof(allrecs) upcase(allrecs pInput)     
													:=  transform
  string64	image_hash		:= pInput.image_hash;
  string1326 lString       :=  StringLib.StringToUpperCase(transfer(pinput, string1326));
  recordof(allrecs) ltemp :=  TRANSFER(lString, recordof(allrecs));
	self.image_hash					:= image_hash;
  self     								:=  ltemp;


end;

uprecs := project(allrecs,upcase(left));
 

ddrecs := dedup(sort(distribute(uprecs,hash(accident_nbr))
															,accident_date,accident_nbr,vin,tag_nbr,lname,fname,mname,did,record_type,prim_name,dob,map(report_code = 'FA' => 1,
																																																											    report_code[1] = 'I' => 2,
																																																													report_code = 'A' => 2,3),local) // no longer choosing Ecrash record, all reports are returned
															,accident_date,accident_nbr,vin,tag_nbr,lname,fname,mname,did,record_type,prim_name,dob,report_code,right,local) : persist('~thor_data400::persist::ecrash_ss');
															
											
export File_Keybuild_prep := ddrecs;

