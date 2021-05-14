import FLAccidents_Ecrash, ut, std, prte2_Ecrash;

export File_KeybuildV2 := module 
#option ('multiplePersistInstances',false);

layouts.keybuild_SSv2 	xpndrecs(file_BuildSS L, files.base_ecrash2v R) := transform
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
		self.report_code					:= 'EA';
		self.report_category			:= 'AUTO REPORT';
		self.report_code_desc			:= 'AUTO ACCIDENT';
		self.vehicle_incident_id	:= '';
		self.vehicle_status				:= map(L.accident_nbr = R.accident_nbr and 
																			L.vin = R. vehicle_id_nbr and 
																			R.vina_series+R.vina_model+R.reference_number+R.vina_make+R.vina_body_style+R.series_description
																			+R.car_series+R.car_body_style+R.car_cid+R.car_cylinders<>''=>'V','');
		self.accident_location		 	:= '';
		self.accident_street				:= '';
		self.accident_cross_street	:= '';
		self.jurisdiction						:= l.jurisdiction;
		self.jurisdiction_state			:= l.jurisdiction_state;   
		self.jurisdiction_nbr				:= '';
		self.IMAGE_HASH							:= '';
		self.AIRBAGS_DEPLOY					:= '';
		self.dob 										:= '';
		self.driver_license_nbr 		:= if(regexfind('[0-9]',L.driver_license_nbr),L.driver_license_nbr,'');
		self.carrier_name 					:= R.ins_company_name;
		self.client_type_id 				:= '';
		self.vehicle_incident_city	:= '';
		self.vehicle_incident_st		:= l.jurisdiction_state;
		self.Policy_num							:= R.ins_policy_nbr;  
		self.Policy_Effective_Date	:= ''; 
		self.Policy_Expiration_Date	:= '';
		self.Report_Has_Coversheet	:= '0';
		self.date_vendor_last_reported := L.accident_date; // need to create date field...
		self.report_type_id					:= 'A';
		self 								:= L;
		self 								:= R;
		self                := []; 
end;

	pflc_ss := join(distribute(file_BuildSS(lname+cname+prim_name<>''),hash(accident_nbr,vin)),
									distribute(files.base_ecrash2v,hash(accident_nbr,vehicle_id_nbr)),
															left.accident_nbr = right.accident_nbr and 
															left.vin = right.vehicle_id_nbr,
															xpndrecs(left,right),left outer, local);
				
// get Carrier_info from driver file 98385
layouts.keybuild_SSv2 xpndrecs1(pflc_ss L, files.base_ecrash4 R) := transform

	self.carrier_name := if(l.carrier_name <> '', l.carrier_name,  R.ins_company_name);
	self.Policy_num   := if(l.Policy_num <>'',l.Policy_num, R.ins_policy_nbr); 
	self 							:= L;
end;

pflc_ss1 := dedup(distribute(join(distribute(pflc_ss,hash(accident_nbr)),
																	distribute(files.base_ecrash4(accident_nbr != ''),hash(accident_nbr)),
																			left.accident_nbr = right.accident_nbr and 
																			trim(left.record_type,left,right) in[ 'VEHICLE DRIVER' ,'DRIVER']and  
																			ut.nneq(trim(left.driver_license_nbr,left,right) ,trim(right.driver_dl_nbr,left,right)) and 
																			left.fname = right.fname and 
																			left.lname = right.lname ,	      
																					xpndrecs1(left,right),left outer,local)),all,local);
				 
/////////////////////////////////////////////////////////////////
FLAccidents_Ecrash.Layout_eCrash.Consolidation_AgencyOri xpndrecs2(pflc_ss1 L, files.base_ecrash0 R) := transform
	self.vehicle_incident_city			:= if(L.accident_nbr= R.accident_nbr,R.city_town_name,'');
	self 														:= L;
	self														:= [];
end;

pflc_ss2 := distribute(join(distribute(pflc_ss1,hash(accident_nbr)),
														distribute(files.base_ecrash0(accident_nbr != ''),hash(accident_nbr)),
														left.accident_nbr = right.accident_nbr,
																xpndrecs2(left,right),left outer,local),random());


/////////////////////////////////////////////////////////////////
//Slim National file 
///////////////////////////////////////////////////////////////// 
ntlFile := project(files.File_eCrashCRU, transform(Layout_insurance_in, self := left));

FLAccidents_Ecrash.Layout_eCrash.Consolidation_AgencyOri slimrec(ntlFile L) := transform

		string8     fSlashedMDYtoCYMD(string pDateIn) :=
								intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
					+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
					+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

		self.did											:= L.did;	
		self.accident_nbr 						:= L.accident_nbr;
		self.accident_date						:= L.accident_date;
		self.b_did										:= L.b_did; 
		self.cname										:= L.cname;
		self.addr_suffix 							:= L.addr_suffix;
		self.zip											:= L.zip;
		self.record_type							:= L.record_type;
		self.driver_license_nbr				:= L.driver_license_nbr;
		self.dlnbr_st									:= L.dlnbr_st;
		self.tag_nbr									:= L.tag_nbr;	
		self.tagnbr_st								:= L.tagnbr_st;
		self.vin											:= L.vin;
		self.accident_location				:= L.accident_location;
		self.accident_street					:= L.accident_street;
		self.accident_cross_street		:= L.accident_cross_street;
		self.jurisdiction							:= L.jurisdiction;
		self.jurisdiction_state				:= L.jurisdiction_state;
		self.st												:= L.jurisdiction_state;
		self.jurisdiction_nbr					:= L.jurisdiction_nbr;
		self.IMAGE_HASH								:= L.IMAGE_HASH;
		self.AIRBAGS_DEPLOY						:= L.AIRBAGS_DEPLOY;
		self.DOB											:= L.DOB;
		self.Policy_num								:= L.POLICY_num;  
		self.Policy_Effective_Date		:= L.Policy_Effective_Date; 
		self.Policy_Expiration_Date		:= L.Policy_Expiration_Date;
		self.Report_Has_Coversheet		:= if(L.IMAGE_HASH !='' or L.tif_image_hash !='','1','0');
		self.other_vin_indicator			:= L.other_vin_indicator;
		self.vehicle_year							:= L.vehicle_year;	
		self.vehicle_make							:= L.vehicle_make;
		self.make_description					:= L.make_description;
		self.model_description				:= L.model_description;
		self.vehicle_incident_city	  := L.vehicle_incident_city;
		self.vehicle_incident_st			:= L.vehicle_incident_st;
		self.point_of_impact					:= L.point_of_impact;
		self.towed				      			:= L.towed;
		self.Impact_Location    			:= L.Impact_Location;
		self.carrier_name							:= L.carrier_name;
		self.client_type_id     			:= L.client_type_id;
		self.vehicle_unit_number 			:= L.vehicle_unit_number;
		self.next_street 							:= L.next_street;
		self.work_type_id 						:= L.work_type_id;
		self.ssn											:= L.ssn; 
		self.cru_order_id							:= L.cru_order_id; 
		self.cru_sequence_nbr					:= L.cru_sequence_nbr; 
		self.date_vendor_last_reported := L.date_vendor_last_reported;
		self.creation_date 						:= L.creation_date; 
		self.report_type_id 					:= L.report_type_id ;
		self.tif_image_hash 					:= l.tif_image_hash; 
		self.acct_nbr 								:= l.acct_nbr ; 
		self.addl_report_number 			:= l.addl_report_number ; 
/* 		unsigned6 prefix              := MAP(l.report_code[1] = 'I' and l.vehicle_incident_id[1..3] = 'OID'    => 1000000000000,  // inquiry 
   																				l.report_code[1] = 'I' and l.vehicle_incident_id[1..3] <> 'OID' => 2000000000000, // inquiry 
   																	      l.report_code = 'FA' => 6000000000000, // For FL accidents there is no incident id so use accident number 
                                           7000000000000 );  // national accidents 
       SELF.idfield                  := prefix + (unsigned6) if(trim(L.vehicle_incident_id,all) <> '', L.vehicle_incident_id, '0');
*/
		//Appriss Integration
		self.Releasable 					:= L.Releasable; 	
		self.is_terminated_agency := if(l.is_terminated_agency = '0',false,true);
		self						:= L;
		self						:= [];
end;

pntl := project(ntlFile,slimrec(left));				 

// FLAccidents_Ecrash.Layout_Basefile
// IyetekFull := distribute(files.ecrash_basefile(source_id ='TF'),hash(State_Report_Number));
// IyetekMeta := distribute(files.ecrash_basefile(source_id ='TM') ,hash(state_report_number));

// jdropMetadata := join( IyetekMeta,IyetekFull, left.state_report_number = right.State_Report_Number and 
                                        // left.ORI_Number = right.ORI_Number and 
																				// left.loss_state_abbr = right.loss_state_abbr and
																				// left.report_type_id = right.report_type_id, 
																				// transform(FLAccidents_Ecrash.Layout_Basefile, self := left),left only, local);


allrecs := pntl+pflc_ss2;	

 
// get DID from vehcile file by name and vin 
uprecsNodid := allrecs(fname <>'' and lname <>'' and vin <>'' and (unsigned) did = 0); 
uprecsDID 	:= allrecs(~(fname <>'' and lname <>'' and vin <>'' and (unsigned) did = 0));

getMvrDid := FLAccidents_Ecrash.Fn_Mvr_DID(uprecsNodid);

total := uprecsDID+ getMvrDid; 

ddrecs := dedup(sort(distribute(total,hash(accident_nbr))
															,accident_date,accident_nbr,jurisdiction_state,vin,tag_nbr,lname,fname,mname,did,record_type,prim_name,dob,report_code,report_type_id,map (work_type_id in ['1','0'] => 2, 1), date_vendor_last_reported,creation_date,carrier_name,driver_license_nbr,local) // give preference to ecrash work type 1's over 2,3
															,accident_date,accident_nbr,jurisdiction_state,vin,tag_nbr,lname,fname,mname,did,record_type,prim_name,dob,report_code,report_type_id,right,local) ;
															


layouts.keybuild_SSv2 	slimrecs(ddrecs L) := transform
  self.accident_nbr 						:= l.accident_nbr;  
  self.orig_accnbr 							:= l.orig_accnbr; 
	self.addl_report_number 			:= if(STD.Str.FilterOut(trim(l.addl_report_number ,left,right),'0') <>'',l.addl_report_number,'') ;
	self.scrub_addl_report_number := self.addl_report_number;
	self.policy_effective_date 		:= map ( trim(l.policy_effective_date)[1] = '0' =>  '',
																				 trim(l.policy_effective_date)[8] = '-' =>  trim(l.policy_effective_date)[1..7],
																				 trim(l.policy_effective_date)
																				);
  self.releasable		 					:= '1';
self 								:= L;
end;

shared outrecs0  := project(ddrecs,slimrecs(left)): persist('~prte::persist::ecrash_ssV2');

//ALpha files only need records with below reason ID's for IA
shared InteractiveReports :=  ['I0','I1','I2','I3','I4','I5','I6','I7','I8','I9'];
AlphaIA     := outrecs0 (report_code[1] = 'I' and report_code not in InteractiveReports); 
AlphaOther  := outrecs0 (report_code[1] <>'I');
AlphaCmbnd := AlphaOther +  AlphaIA (reason_id in ['HOLD','AFYI','ASSI','AUTO','CALL','PRAC','SEAR','SECR','WAIT','PRAI']);

AlphaOtherVendors := AlphaCmbnd(trim(vendor_code, left,right) <> 'COPLOGIC');
AlphaCoplogic 		:= AlphaCmbnd(trim(vendor_code, left,right) = 'COPLOGIC' and ((trim(supplemental_report,left,right) ='1' and trim(super_report_id, left, right) <> trim(report_id, left, right))or (trim(supplemental_report,left,right) ='0' and trim(super_report_id, left, right) = trim(report_id, left, right)) or (trim(supplemental_report,left,right) ='' and trim(super_report_id, left, right) = trim(report_id, left, right) )) );
// export Alpha  		:=  project(AlphaOtherVendors + AlphaCoplogic, 
															// transform(FLAccidents_Ecrash.Layout_eCrash.Accidents_Alpha,
																				// self.is_terminated_agency := false;
																				// self := left;
																				// self := []);
															// );
export out   			:= outrecs0(CRU_inq_name_type not in ['2','3'] and report_code not in InteractiveReports /*and trim(vendor_code, left,right) <> 'COPLOGIC'*/): persist('~prte::persist::ecrash_out');

shared foutrecs0 := outrecs0(CRU_inq_name_type not in ['2','3'] and report_code not in InteractiveReports and trim(vendor_code, left,right) <> 'COPLOGIC');
// export out    := project(foutrecs0, transform(FLAccidents_Ecrash.Layout_eCrash.Consolidation, self := left));

//Restrictive Agency filtering
shared EcrashAgencyExclusionAgencyOri := foutrecs0(STD.Str.ToUpperCase(TRIM(agency_ori, ALL)) NOT IN constants.Agency_ori_list AND
                                                   STD.Str.ToUpperCase(TRIM(agency_ori, ALL))[1..2] NOT IN constants.Agency_ori_jurisdiction_list
																					         );
																																					
shared EcrashAgencyExclusion := EcrashAgencyExclusionAgencyOri(STD.Str.ToUpperCase(TRIM(agency_ori, ALL)) NOT IN constants.Agency_ori_list AND
                                                               STD.Str.ToUpperCase(TRIM(agency_ori, ALL))[1..2] NOT IN constants.Agency_ori_jurisdiction_list
																				                       );
export prout := project(EcrashAgencyExclusion, transform(FLAccidents_Ecrash.Layout_eCrash.Consolidation, self := left, self := []));


//Excluding WORK_TYPE_ID filter required by CARRIER ID SERVICE
shared searchRecs := out(report_code in ['EA','TM','TF', 'FA'] /*and work_type_id not in ['2','3']*/ and (trim(report_type_id,all) in ['A','DE'] or STD.str.ToUpperCase(trim(vendor_code,left,right)) = 'CMPD'));
export eCrashSearchRecs := distribute(project(searchRecs, Layouts.key_search_rec), hash64(accident_nbr)):independent;
end; 



