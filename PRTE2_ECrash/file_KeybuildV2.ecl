import FLAccidents_Ecrash, ut, std, prte2_Ecrash;

export File_KeybuildV2 := module 

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
layouts.keybuild_SSv2 xpndrecs2(pflc_ss1 L, files.base_ecrash0 R) := transform
	self.vehicle_incident_city			:= if(L.accident_nbr= R.accident_nbr,R.city_town_name,'');
	self 														:= L;
end;

pflc_ss2 := distribute(join(distribute(pflc_ss1,hash(accident_nbr)),
														distribute(files.base_ecrash0(accident_nbr != ''),hash(accident_nbr)),
														left.accident_nbr = right.accident_nbr,
																xpndrecs2(left,right),left outer,local),random());
				 

IyetekFull := distribute(files.basefile(source_id ='TF'),hash(State_Report_Number));
IyetekMeta := distribute(files.basefile(source_id ='TM') ,hash(state_report_number));

jdropMetadata := join( IyetekMeta,IyetekFull, left.state_report_number = right.State_Report_Number and 
                                        left.ORI_Number = right.ORI_Number and 
																				left.loss_state_abbr = right.loss_state_abbr and
																				left.report_type_id = right.report_type_id, 
																				transform(layouts.Base, self := left),left only, local);
	
allrecs := pflc_ss2;

 
// get DID from vehcile file by name and vin 
uprecsNodid := allrecs(fname <>'' and lname <>'' and vin <>'' and (unsigned) did = 0); 
uprecsDID 	:= allrecs(~(fname <>'' and lname <>'' and vin <>'' and (unsigned) did = 0));

getMvrDid := Fn_Mvr_DID(uprecsNodid);

total := uprecsDID+ getMvrDid; 

ddrecs := dedup(sort(distribute(total,hash(accident_nbr))
															,accident_date,accident_nbr,jurisdiction_state,vin,tag_nbr,lname,fname,mname,did,record_type,prim_name,dob,report_code,report_type_id,map (work_type_id in ['1','0'] => 2, 1), date_vendor_last_reported,creation_date,carrier_name,driver_license_nbr,local) // give preference to ecrash work type 1's over 2,3
															,accident_date,accident_nbr,jurisdiction_state,vin,tag_nbr,lname,fname,mname,did,record_type,prim_name,dob,report_code,report_type_id,right,local) ;
															


layouts.keybuild_SSv2 	slimrecs(ddrecs L) := transform
  self.accident_nbr 						:= l.accident_nbr;  
  self.orig_accnbr 							:= l.accident_nbr; 
	self.addl_report_number 			:= if(STD.Str.FilterOut(trim(l.addl_report_number ,left,right),'0') <>'',l.addl_report_number,'') ;
	self.scrub_addl_report_number := self.addl_report_number;
	self.policy_effective_date 		:= map ( trim(l.policy_effective_date)[1] = '0' =>  '',
																				 trim(l.policy_effective_date)[8] = '-' =>  trim(l.policy_effective_date)[1..7],
																				 trim(l.policy_effective_date)
																				);
  self.releasable		 					:= '1';
self 								:= L;
end;

shared outrecs0  := project(ddrecs,slimrecs(left));
//ALpha files only need records with below reason ID's for IA

shared InteractiveReports :=  ['I0','I1','I2','I3','I4','I5','I6','I7','I8','I9'];
AlphaIA     := outrecs0 (report_code[1] = 'I' and report_code not in InteractiveReports); 
AlphaOther  := outrecs0 (report_code[1] <>'I');
AlphaCmbnd := AlphaOther +  AlphaIA (reason_id in ['HOLD','AFYI','ASSI','AUTO','CALL','PRAC','SEAR','SECR','WAIT','PRAI']);

AlphaOtherVendors := AlphaCmbnd(trim(vendor_code, left,right) <> 'COPLOGIC');
AlphaCoplogic 		:= AlphaCmbnd(trim(vendor_code, left,right) = 'COPLOGIC' and ((trim(supplemental_report,left,right) ='1' and trim(super_report_id, left, right) <> trim(report_id, left, right))or (trim(supplemental_report,left,right) ='0' and trim(super_report_id, left, right) = trim(report_id, left, right)) or (trim(supplemental_report,left,right) ='' and trim(super_report_id, left, right) = trim(report_id, left, right) )) );
export Alpha  		:= AlphaOtherVendors + AlphaCoplogic;
export out   			:= outrecs0(CRU_inq_name_type not in ['2','3'] and report_code not in InteractiveReports and trim(vendor_code, left,right) <> 'COPLOGIC');

shared searchRecs := out(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3'] and trim(report_type_id,all) in ['A','DE']);
export eCrashSearchRecs := distribute(project(searchRecs, Layouts.key_search_rec), hash64(accident_nbr)):independent;
end; 