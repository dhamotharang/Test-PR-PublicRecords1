/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
import FLAccidents,ut, STD;

export File_KeybuildV2 := module 

flc_ss 	:= FLAccidents.basefile_flcrash_ss(lname+cname+prim_name<>'');

FLAccidents_Ecrash.Layout_keybuild_SSv2 xpndrecs(flc_ss L, FLAccidents.basefile_flcrash2v R) := transform
		self.ultid                := L.ultid;
		self.orgid                := L.orgid;
		self.seleid               := L.seleid;
		self.proxid               := L.proxid;
		self.powid                := L.powid;
		self.empid                := L.empid;
		self.dotid                := L.dotid;
		self.ultscore             := L.ultscore;
		self.orgscore             := L.orgscore;
		self.selescore            := L.selescore;
		self.proxscore            := L.proxscore;
		self.powscore             := L.powscore;
		self.empscore             := L.empscore;
		self.dotscore             := L.dotscore;
		self.ultweight            := L.ultweight;
		self.orgweight            := L.orgweight;
		self.seleweight           := L.seleweight;
		self.proxweight           := L.proxweight;
		self.powweight            := L.powweight;
		self.empweight            := L.empweight;
		self.dotweight            := L.dotweight;
		self.dt_first_seen				:= L.accident_date;
		self.dt_last_seen					:= L.accident_date;
		self.report_code					:= 'FA';
		self.report_category			:= 'Auto Report';
		self.report_code_desc			:= 'Auto Accident';
		self.vehicle_incident_id	:= '';
		self.vehicle_status				:= map(L.accident_nbr = R.accident_nbr and 
																			L.vin = R. vehicle_id_nbr and 
																			R.vina_series+R.vina_model+R.reference_number+R.vina_make+R.vina_body_style+R.series_description
																			+R.car_series+R.car_body_style+R.car_cid+R.car_cylinders<>''=>'V','');
		self.accident_location		 	:= '';
		self.accident_street				:= '';
		self.accident_cross_street	:= '';
		self.jurisdiction						:= 'FLORIDA HP';
		self.jurisdiction_state			:= 'FL';
		self.jurisdiction_nbr				:= '';
		self.IMAGE_HASH							:= '';
		self.AIRBAGS_DEPLOY					:= '';
		self.dob 										:= '';
		self.driver_license_nbr 		:= if(regexfind('[0-9]',L.driver_license_nbr),L.driver_license_nbr,'');
		self.carrier_name 					:= R.ins_company_name;
		self.client_type_id 				:= '';
		self.vehicle_incident_city	:= '';
		self.vehicle_incident_st		:= 'FL';
		self.Policy_num							:= R.ins_policy_nbr;  
		self.Policy_Effective_Date	:= ''; 
		self.Policy_Expiration_Date	:= '';
		self.Report_Has_Coversheet		:= '0';
		self.date_vendor_last_reported := L.accident_date; // need to create date field...
		//self.IdField 								:=	R.IdField;
		self 								:= L;
		self 								:= R;
		self                := []; 
end;

	pflc_ss := join(distribute(flc_ss,hash(accident_nbr,vin)),
									distribute(FLAccidents.basefile_flcrash2v,hash(accident_nbr,vehicle_id_nbr)),
															left.accident_nbr = right.accident_nbr and 
															left.vin = right.vehicle_id_nbr,
															xpndrecs(left,right),left outer, local);
				
// get Carrier_info from driver file 98385

FLAccidents_Ecrash.Layout_keybuild_SSv2 xpndrecs1(pflc_ss L,FLAccidents.BaseFile_FLCrash4 R) := transform

	self.carrier_name := if(l.carrier_name <> '', l.carrier_name,  R.ins_company_name);
	self.Policy_num   := if(l.Policy_num <>'',l.Policy_num, R.ins_policy_nbr); 
	//self.IdField 			:=	R.IdField;
	self 							:= L;
end;

pflc_ss1 := dedup(distribute(join(distribute(pflc_ss,hash(accident_nbr))
			  ,distribute(FLAccidents.BaseFile_FLCrash4(accident_nbr != ''),hash(accident_nbr))
															,left.accident_nbr = right.accident_nbr and 
															trim(left.record_type,left,right) in[ 'Vehicle Driver' ,'Driver']and  
															ut.nneq(trim(left.driver_license_nbr,left,right) ,trim(right.driver_dl_nbr,left,right)) and 
															left.fname = right.fname and 
															left.lname = right.lname ,	      
															xpndrecs1(left,right),left outer,local)),all,local);
				 
/////////////////////////////////////////////////////////////////
FLAccidents_Ecrash.Layout_keybuild_SSv2 xpndrecs2(pflc_ss1 L,FLAccidents.basefile_flcrash0 R) := transform

	self.vehicle_incident_city			:= stringlib.stringtouppercase(if(L.accident_nbr= R.accident_nbr,R.city_town_name,''));
	self 														:= L;
end;

pflc_ss2 := distribute(join(distribute(pflc_ss1,hash(accident_nbr))
						,distribute(FLAccidents.basefile_flcrash0(accident_nbr != ''),hash(accident_nbr))
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

		self.did											:= if(L.did = 0,'000000000000',intformat(L.did,12,1));	
		self.accident_nbr 						:= (string40)((unsigned6)L.vehicle_incident_id+10000000000);
		self.accident_date						:= fSlashedMDYtoCYMD(L.loss_date[1..10]);
		self.b_did										:= if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
		self.cname										:= stringlib.stringtouppercase(L.business_name);
		self.addr_suffix 							:= L.suffix;
		self.zip											:= L.zip5;
		self.record_type							:= CASE(stringlib.stringtouppercase(trim(L.party_type,left,right))
																							,'OWNER'=>'Property Owner'
																							,'DRIVER'=>'Vehicle Driver'
																							,'VEHICLE OWNER'=>'Property Owner' 
																							,'VEHICLE DRIVER'=>'Vehicle Driver'
																					,'');
		self.driver_license_nbr				:= if(regexfind('[0-9]',L.pty_drivers_license),L.pty_drivers_license,'');
		self.dlnbr_st									:= L.pty_drivers_license_st;
		self.tag_nbr									:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.tag,'');	
		self.tagnbr_st								:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.tag_state,'');
		self.vin											:= L.vehvin;
		self.accident_location				:= map(L.cross_street!='' and L.cross_street!= 'N/A' => L.street+' & '+L.cross_street,L.street);
		self.accident_street					:= L.street;
		self.accident_cross_street		:= map(L.cross_street!= 'N/A' => L.cross_street,'');
		self.jurisdiction							:= trim(L.edit_agency_name,left,right);
		self.jurisdiction_state				:= L.STATE_ABBR;
		self.st												:= if(l.st = '',self.jurisdiction_state,l.st);
		self.jurisdiction_nbr					:= L.AGENCY_ID;
		self.IMAGE_HASH								:= L.PDF_IMAGE_HASH;
		self.AIRBAGS_DEPLOY						:= L.AIRBAGS_DEPLOY;
		self.DOB											:= L.DOB;
		self.Policy_num								:= L.POLICY_NBR;  
		self.Policy_Effective_Date		:= ''; 
		self.Policy_Expiration_Date		:= '';
		self.Report_Has_Coversheet		:= if(L.PDF_IMAGE_HASH !='' or L.tif_image_hash !='','1','0');
		self.other_vin_indicator			:= '';
		self.vehicle_year							:=L.vehYear;	
		self.vehicle_make							:=L.vehMake;
		self.make_description					:= if(L.make_description != '',L.make_description,L.vehMake);
		self.model_description				:= if(L.model_description != '',L.model_description,L.vehModel);
		self.vehicle_incident_city	  := stringlib.stringtouppercase(L.inc_city);
		self.vehicle_incident_st			:= stringlib.stringtouppercase(L.state_abbr);
		self.point_of_impact					:= L.impact_location;
		self.towed				      			:= L.Car_Towed;
		self.Impact_Location    			:= L.Impact_Location ;
		self.carrier_name							:= L.legal_name;
		self.client_type_id     			:= L.client_type_id;
		self.vehicle_unit_number 			:= '';
		self.next_street 							:= '';
		self.work_type_id 						:= ''; 
		self.ssn											:=''; 
		self.cru_order_id							:=l.order_id; 
		self.cru_sequence_nbr					:=l.sequence_nbr; 
		self.date_vendor_last_reported := L.last_changed;
		self.creation_date 						:= ''; 
		self.report_type_id 					:= L.service_id ;
		self.tif_image_hash 					:= l.tif_image_hash; 
		self.acct_nbr 								:= l.acct_nbr ; 
		self.addl_report_number 			:= l.REPORT_NBR ; 
/* 		unsigned6 prefix              := MAP(l.report_code[1] = 'I' and l.vehicle_incident_id[1..3] = 'OID'    => 1000000000000,  // inquiry 
   																				l.report_code[1] = 'I' and l.vehicle_incident_id[1..3] <> 'OID' => 2000000000000, // inquiry 
   																	      l.report_code = 'FA' => 6000000000000, // For FL accidents there is no incident id so use accident number 
                                           7000000000000 );  // national accidents 
       SELF.idfield                  := prefix + (unsigned6) if(trim(L.vehicle_incident_id,all) <> '', L.vehicle_incident_id, '0');
*/
		self						:= L;
		self						:= [];
end;

pntl := project(ntlFile,slimrec(left));

/////////////////////////////////////////////////////////////////
//Slim National inquiry file 
///////////////////////////////////////////////////////////////// 
inqFile := FLAccidents_Ecrash.File_CRU_inquiries;

FLAccidents_Ecrash.Layout_keybuild_SSv2 slimrec2(inqFile L ,unsigned1 cnt) := transform

    string8     fSlashedMDYtoCYMD(string pDateIn) :=
								intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
					+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
					+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

	  self.report_code					  := 'I'+ L.report_code;
		self.report_category				:= L.report_category;
		self.report_code_desc				:= L.report_code_desc;
		self.accident_nbr 					:= if(L.vehicle_incident_id[1..3] = 'OID',
																			(string40)((unsigned6)L.vehicle_incident_id[4..11]+100000000000),
																			(string40)((unsigned6)L.vehicle_incident_id+10000000000));
		self.accident_date					:= fSlashedMDYtoCYMD(L.loss_date[1..10]);
		self.accident_location			:= map(L.cross_street!='' and L.cross_street!= 'N/A' => L.street+' & '+L.cross_street,L.street);
		self.accident_street				:= L.street;
		self.accident_cross_street	:= map(L.cross_street!= 'N/A' => L.cross_street,'');
		self.jurisdiction						:= stringlib.stringtouppercase(trim(L.EDIT_AGENCY_NAME,left,right));
		self.jurisdiction_state			:= stringlib.stringtouppercase(L.State);
		self.st											:= if(l.st = '',self.jurisdiction_state,l.st);
		self.jurisdiction_nbr				:= L.AGENCY_ID;
		self.cru_jurisdiction       := stringlib.stringtouppercase(trim(L.EDIT_AGENCY_NAME,left,right));
		self.cru_jurisdiction_nbr   := L.AGENCY_ID + '_'+L.STATE_NBR ; 
		self.vehicle_incident_city	:= stringlib.stringtouppercase(L.city);
		self.vehicle_incident_st		:= stringlib.stringtouppercase(L.state);
		self.did										:= 	choose(cnt ,if(L.did = 0,'000000000000',intformat(L.did,12,1)),'000000000000','000000000000');	
		self.prim_range   					:=  choose(cnt ,L.prim_range,'',''); 
		self.predir       					:=  choose(cnt ,l.predir,'','');
		self.prim_name    					:=  choose(cnt ,l.prim_name,'','');
		self.postdir      					:=  choose(cnt ,l.postdir,'','');
		self.unit_desig   					:=  choose(cnt ,l.unit_desig,'','');
		self.sec_range    					:=  choose(cnt ,l.sec_range,'','');
		self.v_city_name  					:=  choose(cnt ,l.v_city_name,'','');
		self.zip4         					:=  choose(cnt ,l.zip4,'','');
		self.addr_suffix 						:=  choose(cnt ,L.suffix,'','');
		self.zip										:=  choose(cnt ,L.zip5,'','');
		self.record_type						:=	choose(cnt , 'Vehicle Driver','','');
		self.driver_license_nbr			:= 	choose(cnt ,if(regexfind('[0-9]',L.drivers_license),L.drivers_license,''),'','');
		self.dlnbr_st								:= 	choose(cnt ,L.drivers_license_st,'','');
		self.tag_nbr								:= 	choose(cnt ,L.otag,'','');
		self.tagnbr_st							:=  choose(cnt ,L.otag_state,'','');
		self.vin										:=	choose(cnt , L.vin,'','');
		self.title 									:= 	choose(cnt ,l.title,l.title2, l.title3); 
		self.name_suffix 						:= 	choose(cnt ,l.name_suffix,l.name_suffix2, l.name_suffix3); 
		self.fname 									:=	choose(cnt ,l.fname,l.fname2, l.fname3); 
		self.lname 									:= 	choose(cnt ,l.lname,l.lname2, l.lname3); 
		self.mname 									:=	choose(cnt ,l.mname,l.mname2, l.mname3); 
		
		t_orig_fname2 							:= if(trim(l.orig_fname2 , left,right)in ['UNK' , 'UNKNOWN' , 'UNK MALE' ], '',l.orig_fname2);  
		t_orig_lname2 							:= if(trim(l.orig_lname2 , left,right)in ['UNK' , 'UNKNOWN' , 'UNK MALE' ], '',l.orig_lname2);
		f_orig_lname2               := if(REGEXFIND('[0-9]',t_orig_lname2) = true, '', t_orig_lname2); 
		t_orig_fname3 							:= if(trim(l.orig_fname3 , left,right)in ['UNK' , 'UNKNOWN' , 'UNK MALE' ], '',l.orig_fname3);  
		t_orig_lname3 							:= if(trim(l.orig_lname3 , left,right)in ['UNK' , 'UNKNOWN' , 'UNK MALE' ], '',l.orig_lname3);  
    f_orig_lname3               := if(REGEXFIND('[0-9]',t_orig_lname3) = true, '', t_orig_lname3); 
		
	  self.orig_fname 						:=	choose(cnt ,l.orig_fname,if(trim(t_orig_fname2,left,right) ='' and trim(f_orig_lname2,left,right) ='',skip,t_orig_fname2), if(trim(t_orig_fname3,left,right) ='' and trim(f_orig_lname3,left,right) ='',skip,t_orig_fname3)); 
		self.orig_lname 						:=	choose(cnt ,l.orig_lname,f_orig_lname2, f_orig_lname3); 
		self.orig_mname 						:= 	choose(cnt ,l.orig_mname,l.orig_mname2, l.orig_mname3); 
		self.DOB										:=	choose(cnt , L.DOB_1,'','');
		self.vehicle_year						:= 	choose(cnt ,L.Year,'','');
		self.vehicle_make						:=  choose(cnt ,L.make,'','');
		self.make_description				:= 	choose(cnt ,if(L.make_description != '',L.make_description,L.Make),'','');
		self.model_description			:= 	choose(cnt ,if(L.model_description != '',L.model_description,L.Model),'','');
		self.carrier_name     			:=  choose(cnt ,L.legal_name,'','');
		self.ssn										:=	choose(cnt ,l.ssn_1,'','');
		self.vehicle_status					:= 	choose(cnt ,L.vehicle_status,'','');
		self.vehicle_seg						:= 	choose(cnt ,L.vehicle_seg,'','');
		self.vehicle_seg_type				:= 	choose(cnt ,L.vehicle_seg_type,'','');
		self.model_year							:= 	choose(cnt ,L.model_year,'','');
		self.body_style_code				:= choose(cnt ,L.body_style_code,'','');
		self.engine_size						:= choose(cnt ,L.engine_size,'','');
		self.fuel_code							:= choose(cnt ,L.fuel_code,'','');
		self.number_of_driving_wheels:= choose(cnt ,L.number_of_driving_wheels,'','');
		self.steering_type						:= choose(cnt ,L.steering_type,'','');
		self.vina_series							:= choose(cnt ,L.vina_series,'','');
		self.vina_model								:= choose(cnt ,L.vina_model,'','');
		self.vina_make								:= choose(cnt ,L.vina_make,'','');
		self.vina_body_style					:= choose(cnt ,L.vina_body_style,'','');
		self.series_description				:= choose(cnt ,L.series_description,'','');
		self.car_cylinders						:= choose(cnt ,L.car_cylinders,'','');
		self.Report_Has_Coversheet		:= '0';
		self.cru_order_id							:=l.order_id; 
		self.cru_sequence_nbr					:=l.sequence_nbr; 
		self.date_vendor_last_reported := L.last_changed;
		self.creation_date 						:= ''; 
		self.report_type_id 					:= L.service_id ;
		self.addl_report_number 			:= l.REPORT_NBR ;
		self.acct_nbr 								:= l.acct_nbr ; 
		self.CRU_inq_name_type 				:=  choose(cnt ,'1','2','3');
		self.reason_id                := l.reason_id; 
/* 		unsigned6 prefix              := MAP(l.report_code[1] = 'I' and l.vehicle_incident_id[1..3] = 'OID'    => 1000000000000,  // inquiry 
   																				l.report_code[1] = 'I' and l.vehicle_incident_id[1..3] <> 'OID' => 2000000000000, // inquiry 
   																	      l.report_code = 'FA' => 6000000000000, // For FL accidents there is no incident id so use accident number 
                                           7000000000000 );  // national accidents 
       self.idfield                  := prefix + (unsigned6) if(trim(L.vehicle_incident_id,all) <> '', L.vehicle_incident_id, '0');
*/ 
  		self						:= L;

		self						:= [];

end;

	pinq:=  normalize(inqFile,3,slimrec2(left,counter));
	
//Iyetek 

// Drop metadata if matches with full report

IyetekFull := distribute(FLAccidents_Ecrash.BaseFile(source_id ='TF'),hash(State_Report_Number));
IyetekMeta := distribute(FLAccidents_Ecrash.BaseFile(source_id ='TM') ,hash(state_report_number));

jdropMetadata := join( IyetekMeta,IyetekFull, left.state_report_number = right.State_Report_Number and 
                                        left.ORI_Number = right.ORI_Number and 
																				left.loss_state_abbr = right.loss_state_abbr and
																				left.report_type_id = right.report_type_id, 
																				transform(FLAccidents_Ecrash.Layout_Basefile, self := left),left only  , local);
	
/////////////////////////////////////////////////////////////////
//Slim Ecrash file 
///////////////////////////////////////////////////////////////// 
eFile := FLAccidents_Ecrash.BaseFile(source_id <>'TM') + jdropMetadata ; //contains EA , TF, TM

pflc_ss slimrec3(eFile L, unsigned1 cnt) := transform
		self.accident_nbr 					        := if(l.source_id in ['TM','TF'],L.state_report_number, L.case_identifier);
		self.accident_date					        := if(L.incident_id[1..9] ='188188188','20100901',L.crash_date);
		self.b_did									        := if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
		self.cname									        := l.cname;
		self.name_suffix 						        := L.suffix;
		self.did										        := if(L.did = 0,'000000000000',intformat(L.did,12,1));	
		self.zip										        := L.z5;
		self.zip4										        := L.z4;
		self.record_type						        := L.person_type;
		self.driver_license_nbr			        := if(regexfind('[0-9]',L.drivers_license_number),L.drivers_license_number,'');
		self.dlnbr_st								        := L.drivers_license_jurisdiction; 
		self.tag_nbr								        := if(L.Other_Unit_VIN !='',choose(cnt,L.License_Plate,L.Other_Unit_License_Plate),L.License_Plate);
		self.tagnbr_st							        := if(L.Other_Unit_VIN !='',choose(cnt,L.Registration_State,L.Other_Unit_Registration_State),L.Registration_State);
		self.vin										        := if(L.Other_Unit_VIN !='',choose(cnt,L.vin,L.Other_Unit_VIN),L.vin);
		self.accident_location			        := map(trim(L.loss_cross_street,left,right)!='' and trim(L.loss_cross_street,left,right)!= 'N/A' => trim(L.loss_street,left,right)+' & '+trim(L.loss_cross_street,left,right),L.loss_street);
		self.accident_street				        := L.loss_street;
		self.accident_cross_street	        := map(L.loss_cross_street!= 'N/A' => L.loss_cross_street,'');
		self.jurisdiction						        := if(L.incident_id[1..9]='188188188' ,'LN Test PD',trim(L.agency_name,left,right));
		self.jurisdiction_state			        := if(L.case_identifier = '11030001','GA',L.Loss_state_Abbr);
		self.st											        := if(l.st = '',self.jurisdiction_state,l.st);
		self.jurisdiction_nbr				        := if(L.incident_id[1..9]='188188188','1536035',L.AGENCY_ID);
		self.IMAGE_HASH							        := L.HASH_Key;
		self.AIRBAGS_DEPLOY					        := L.Airbags_Deployed_Derived;
		self.vehicle_incident_id		        := L.incident_id;
		self.vehicle_status					        := if(L.Other_Unit_VIN !='',choose(cnt,l.vin_status,l.other_unit_vin_status),l.vin_status);
		self.DOB														:= map(L.incident_id[1..9] ='188188188' and L.lname = 'DOE' => '19690201'
																								,L.incident_id[1..9] ='188188188' and L.lname = 'SMITH' => '19500405'
																								,L.Date_of_Birth);
//------------------------------------------------------------													
		year					              				:= trim(if(L.Other_Unit_VIN !='',choose(cnt,if(L.model_year != '',L.model_year,L.model_yr),
																														L.other_model_year),
																														if(L.model_year != '',L.model_year,L.model_yr)),left,right);																														
		self.vehicle_year										:= map(length(year) = 2 and year>'50' => '19'+ year,
																							length(year) = 2 and year<='50' => '20'+ year,year);
		self.model_year 										:= map(length(year) = 2 and year>'50' => '19'+ year,
																								length(year) = 2 and year<='50' => '20'+ year,year);
//------------------------------------------------------------	
		self.vehicle_make					  				:= if(L.Other_Unit_VIN !='',choose(cnt,if(L.make_description != '',L.make_description,L.make),
																														if(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														if(L.make_description != '',L.make_description,L.make));
		self.make_description								:= if(L.Other_Unit_VIN !='',choose(cnt,if(L.make_description != '',L.make_description,L.make),
																														if(L.other_make_description != '',L.other_make_description,L.Other_Unit_Make)),
																														if(L.make_description != '',L.make_description,L.make));
		self.model_description							:= if(L.Other_Unit_VIN !='',choose(cnt,if(L.model_description != '',L.model_description,L.model),
																														if(L.other_model_description != '',L.other_model_description,L.other_unit_model)),
																														if(L.model_description != '',L.model_description,L.model));
		self.vehicle_incident_city					:= stringlib.stringtouppercase(L.Crash_City);
		self.vehicle_incident_st						:= stringlib.stringtouppercase(L.Loss_State_Abbr);
		self.towed				   								:= L.Vehicle_Towed_Derived;
		
		self.impact_location 								:= if (l.report_code ='TM' ,
		
                                           if(L.initial_point_of_contact[1..25] !='','Damaged_Area_1: ' + L.initial_point_of_contact[1..25],'')
																		        + if(L.initial_point_of_contact[25..] !='','Damaged_Area_2: ' + L.initial_point_of_contact[25..],''),
																						
																						if(L.Damaged_Areas_Derived1 !='','Damaged_Area_1: ' + L.Damaged_Areas_Derived1,'')
																						+ if(L.Damaged_Areas_Derived2 !='','Damaged_Area_2: ' + L.Damaged_Areas_Derived2,''));
																						
		self.Policy_num			 								:= L.Insurance_Policy_Number;  
		self.Policy_Effective_Date					:= trim(L.Insurance_Effective_Date,left,right); 
		self.Policy_Expiration_Date					:= L.Insurance_Expiration_Date; //''; check
		self.carrier_name     							:= L.Insurance_Company;
		self.client_type_id 								:= '';
		self.Report_Has_Coversheet					:= if(L.Report_Has_Coversheet = '1', '1','0');
		self.other_vin_indicator						:= if(L.Other_Unit_VIN !='',choose(cnt,'1','2'),'');
		self.vehicle_unit_number 						:= L.unit_number;
		self.next_street 										:= l.next_street;
		self.addl_report_number							:= if(l.source_id in ['TF','TM'],L.case_identifier,L.state_report_number);
		self.agency_ori											:= l.ori_number;
		self.Insurance_Company_Standardized := l.Insurance_Company_Standardized;
		self.is_available_for_public				:= if(l.report_code in ['TF','EA'],'1',l.is_available_for_public);
		self.report_status 									:= l.report_status;
		self.date_vendor_last_reported 			:= L.date_vendor_last_reported;
		self.creation_date 									:= l.creation_date; 
		self.report_type_id 								:= L.report_type_id ;
		self.ssn 													  := l.ssn; 
		self.cru_jurisdiction 							:= l.cru_agency_name; 
		self.cru_jurisdiction_nbr 				  := l.cru_agency_id;
		//Policy records Addition
		self.fatality_involved							:= L.fatality_involved;
		self.latitude												:= L.lattitude;
		self.longitude											:= L.Longitude;
		self.address1												:= L.address;
		self.address2												:= L.address2;
		self.state													:= L.State;
		self.home_phone										  := L.home_phone;
	//End of Police Record/Claims Process
	  
		// BuyCrash
		self.officer_id                     := L.officer_id;
		//Appriss Integration
		self.Releasable                     := '1'; 		
		self								                := L;
		self                                := [];
   
end;

pec := normalize(eFile,2,slimrec3(left,counter));

allrecs := pntl+pflc_ss2+pinq+pec;

///////////////////////////////////////////////
//UPcase all field values
///////////////////////////////////////////////

uprecs := FLAccidents_Ecrash.Fn_Upcase(allrecs);
 
// get DID from vehcile file by name and vin 
uprecsNodid :=uprecs(fname <>'' and lname <>'' and vin <>'' and (unsigned) did = 0); 
uprecsDID := uprecs(~(fname <>'' and lname <>'' and vin <>'' and (unsigned) did = 0));

getMvrDid := FLAccidents_Ecrash.Fn_Mvr_DID(uprecsNodid);

total := uprecsDID+ getMvrDid; 

ddrecs := dedup(sort(distribute(total,hash(accident_nbr))
															,accident_date,accident_nbr,jurisdiction_state,vin,tag_nbr,lname,fname,mname,did,record_type,prim_name,dob,report_code,report_type_id,map (work_type_id in ['1','0'] => 2, 1), date_vendor_last_reported,creation_date,length(trim(carrier_name,left,right))!=0,length(trim(driver_license_nbr,left,right)) !=0,vehicle_incident_id,local) // give preference to ecrash work type 1's over 2,3
															,accident_date,accident_nbr,jurisdiction_state,vin,tag_nbr,lname,fname,mname,did,record_type,prim_name,dob,report_code,report_type_id,right,local) ;
															

//scrub the accident number and UNK issue   

FLAccidents_Ecrash.Layout_keybuild_SSv2 slimrecs(ddrecs L) := transform

     t_scrub := stringlib.StringFilter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
     self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.vehicle_incident_id,t_scrub);  
     self.orig_accnbr := l.accident_nbr; 
		 self.addl_report_number :=  if(stringlib.stringfilterout(trim(l.addl_report_number ,left,right),'0') <>'',l.addl_report_number,'') ;
		 self.scrub_addl_report_number := stringlib.StringFilter(self.addl_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
		 self.policy_effective_date := map ( trim(l.policy_effective_date)[1] = '0' =>  '',
		                                     trim(l.policy_effective_date)[8] = '-' =>  trim(l.policy_effective_date)[1..7],
																					                                            trim(l.policy_effective_date)
																				);
		 
self 								:= L;
end;

shared outrecs0  := project(ddrecs,slimrecs(left)): persist('~thor_data400::persist::ecrash_ssV2');
//ALpha files only need records with below reason ID's for IA

shared InteractiveReports :=  ['I0','I1','I2','I3','I4','I5','I6','I7','I8','I9'];
AlphaIA     := outrecs0 (report_code[1] = 'I' and report_code not in InteractiveReports); 
AlphaOther  := outrecs0 (report_code[1] <>'I');
shared AlphaCmbnd := AlphaOther +  AlphaIA (reason_id in ['HOLD','AFYI','ASSI','AUTO','CALL','PRAC','SEAR','SECR','WAIT','PRAI']);

shared AlphaOtherVendors := AlphaCmbnd(trim(vendor_code, left,right) <> 'COPLOGIC');
//export Coplogic :=  AlphaCmbnd(trim(vendor_code, left,right) = 'COPLOGIC');
AlphaCoplogic := AlphaCmbnd(trim(vendor_code, left,right) = 'COPLOGIC' and ((trim(supplemental_report,left,right) ='1' and trim(super_report_id, left, right) <> trim(report_id, left, right))or (trim(supplemental_report,left,right) ='0' and trim(super_report_id, left, right) = trim(report_id, left, right)) or (trim(supplemental_report,left,right) ='' and trim(super_report_id, left, right) = trim(report_id, left, right) )) );
export Alpha  :=  AlphaOtherVendors + AlphaCoplogic;
export out    := outrecs0(CRU_inq_name_type not in ['2','3'] and report_code not in InteractiveReports and trim(vendor_code, left,right) <> 'COPLOGIC');

shared searchRecs := out(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3'] and (trim(report_type_id,all) in ['A','DE'] or STD.str.ToUpperCase(trim(vendor_code,left,right)) = 'CMPD'));
export eCrashSearchRecs := distribute(project(searchRecs, Layouts.key_search_layout), hash64(accident_nbr)):independent;

end; 