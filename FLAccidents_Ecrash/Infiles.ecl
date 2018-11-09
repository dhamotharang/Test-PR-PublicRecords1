import Data_services, STD, ut;

export Infiles    := module

//Validate whether all files have been sprayed to thor for a given run

vIncident_ea  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::incidnt_raw_new_'+workunit)) = 0 ,
                                 fail('Abort:  EA Incident file spray skipped...'),Output('EA Incident File Spray Success'));
																 
vCitation_ea  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::ecrash::citatn_raw','~thor_data400::in::ecrash::citatn_raw_'+workunit)) = 0 ,
                                 fail('Abort:  EA Citation file spray skipped...'),Output('EA Citation File Spray Success'));
																 
vCommercial_ea  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::ecrash::commercl_raw','~thor_data400::in::ecrash::commercl_raw_'+workunit)) = 0 ,
                                 fail('Abort:  EA Commercial file spray skipped...'),Output('EA Commercial File Spray Success'));
																 
vPerson_ea  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::ecrash::persn_raw','~thor_data400::in::ecrash::persn_raw_'+workunit)) = 0 ,
                                 fail('Abort:  EA Person file spray skipped...'),Output('EA Person File Spray Success'));
																 
vVehicle_ea  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::ecrash::vehicl_raw','~thor_data400::in::ecrash::vehicl_raw_'+workunit)) = 0 ,
                                 fail('Abort:  EA Vehicle file spray skipped...'),Output('EA Vehicle File Spray Success'));
																 
vProperty_Damage_ea  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::ecrash::propertydamage_raw','~thor_data400::in::ecrash::propertydamage_raw_'+workunit)) = 0 ,
                                 fail('Abort:  EA Property Damage file spray skipped...'),Output('EA Property Damage File Spray Success'));
																 
																 
//Sequential( vIncident_ea , vCitation_ea, vCommercial_ea , vPerson_ea, vVehicle_ea , vProperty_Damage_ea );



export agency0     := dataset(Data_Services.foreign_prod+'thor_data400::in::ecrash::agency'
													 ,FLAccidents_Ecrash.Layout_Infiles.agency
															 ,csv(terminator(['\n', '\nr', '\r', '\rn']), separator('~~'),quote('"')))(Agency_ID != 'Agency_ID');
export agency:= project(agency0, transform({agency0}, 
                            self.agency_id := IF(trim(Left.agency_id,left,right) <>'', Left.agency_id,ERROR('agency file bad')),
														agency_name := IF(trim(Left.agency_name,left,right) <>'', Left.agency_name,ERROR('agency file bad'));
														self.agency_name := IF(STD.Str.ToUpperCase(trim(agency_name,left,right)) IN ['\\N', 'NULL'],  '', agency_name);
														self.source_id := IF(STD.Str.ToUpperCase(trim(left.source_id,left,right)) IN ['\\N', 'NULL'],  '', left.source_id);
														self.agency_state_abbr := IF(STD.Str.ToUpperCase(trim(left.agency_state_abbr,left,right)) IN ['\\N', 'NULL'],  '', left.agency_state_abbr);
														self.agency_ori := IF(STD.Str.ToUpperCase(trim(left.agency_ori,left,right)) IN ['\\N', 'NULL'],  '', left.agency_ori);
														self.append_overwrite_flag := IF(STD.Str.ToUpperCase(trim(left.append_overwrite_flag,left,right)) IN ['\\N', 'NULL'],  '', left.append_overwrite_flag);
                            self:= left));
//export dagency				:= dedup(sort(distribute(agency, hash32(agency_id)),agency_id),agency_id);
shared billingagencies := dataset(Data_Services.foreign_prod+'thor_data400::in::ecrash::billingagency_raw'
																			,FLAccidents_Ecrash.Layout_Infiles.billing_agencies
																			,csv(terminator(['\n', '\nr', '\r', '\rn']), separator(','),quote('"')), OPT)(Cru_Agency_ID != 'cru_agency_id');

export commercl   := dataset(Data_Services.foreign_prod+'thor_data400::in::ecrash::commercl_raw'
													,FLAccidents_Ecrash.Layout_Infiles.commercial
													,csv(terminator('\n'), separator(','),quote('"')))(Commercial_ID != 'Commercial_ID') 
													;	

export citation := dataset(Data_Services.foreign_prod+'thor_data400::in::ecrash::citatn_raw'
													 ,FLAccidents_Ecrash.Layout_Infiles.citation
													 ,csv(terminator('\n'), separator(','),quote('"')))(Citation_ID != 'Citation_ID'); 												
																
											
export incident   := dataset(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
													,FLAccidents_Ecrash.Layout_Infiles.incident_new
													,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(incident_id != 'Incident_ID');
              
export persn      :=  dataset(Data_Services.foreign_prod+'thor_data400::in::ecrash::persn_raw'
													,FLAccidents_Ecrash.Layout_Infiles.persn_new
													,csv(terminator('\n'), separator(','),quote('"'),escape('\r'),maxlength(3000000)))(Person_ID != 'Person_ID');
                    
export vehicl     :=  dataset(Data_Services.foreign_prod+'thor_data400::in::ecrash::vehicl_raw'
													,FLAccidents_Ecrash.Layout_Infiles.vehicl_new
													,csv(terminator('\n'), separator(','),quote('"'),maxlength(50000)))(Vehicle_ID != 'Vehicle_ID');
export Property_damage     :=  dataset(Data_Services.foreign_prod+'thor_data400::in::ecrash::propertydamage_raw'
													,FLAccidents_Ecrash.Layout_Infiles.property_damage
													,csv(terminator('\n'), separator(','),quote('"'),maxlength(50000)))(Property_Damage_ID != 'Property_Damage_ID'); 
													
export suppress_incidents := dataset(Data_Services.foreign_prod+'thor_data400::in::ecrash::suppress_tf.csv'
																												,FLAccidents_Ecrash.Layout_Infiles_Fixed.suppress_incidents
																												,csv(heading(1),terminator(['\n','\r\n']), separator(','),quote('"')));															
													;
// get the incidents with is_delete set to 1													


export incidents_todelete := distribute(incident(is_delete = '1'), hash(incident_id)):independent;		


shared jcitation := 	join(distribute(citation, hash(incident_id)), incidents_todelete,
								trim(left.incident_id, all)= trim(right.incident_id,all),
								left only, local);	
											
export tcitation  := project(jcitation, transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.citation	
															,self := left));	

incidents := join(distribute(incident, hash(incident_id)), incidents_todelete,
   				trim(left.incident_id, all)= trim(right.incident_id,all),
   				left only, local);
					
//filter out Nassau TF
export tincident  := project(incidents(~(source_id in ['TF','TM'] and agency_id = '1603437')),transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.incident
													,SELF.incident_id := LEFT.incident_id[1..9]; 
													 SELF.case_identifier := STD.Str.ToUpperCase(LEFT.case_identifier);
													 SELF.state_report_number := STD.Str.ToUpperCase(LEFT.state_report_number);
													 SELF.crash_time := IF(left.incident_id IN ['10560507','10405314', '10405522','10403933','10560555','10560530']  , '', LEFT.crash_time);
													 SELF.contrib_source := IF(STD.Str.ToUpperCase(TRIM(LEFT.contrib_source,left,right)) IN ['\\N', 'NULL'],  '', LEFT.contrib_source);
													 SELF:= LEFT;));		

 jpersn := 	join(distribute(persn, hash(incident_id)), incidents_todelete, 
								trim(left.incident_id, all)= trim(right.incident_id,all),
								left only, local);
																	
													
export tpersn     := project(jpersn, transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.persn
                          		,self.person_type := /*stringlib.StringFilter(*/STD.Str.ToUpperCase(left.person_type);//,'ABCDEFGHIJKLMNOPQRSTUVWXYZ |');
															,self:= left));			
															
jvehicl := 	join(distribute(vehicl, hash(incident_id)), incidents_todelete,
								trim(left.incident_id, all)= trim(right.incident_id,all),
								left only, local);
					
					
export tvehicl    := project(jvehicl, transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.vehicl
													,self:= left));		
													
jproperty_damage := join(distribute(property_damage, hash(incident_id)), incidents_todelete,
								trim(left.incident_id, all)= trim(right.incident_id,all),
								left only, local);
					
export tproperty := project(jProperty_damage, transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.Property_damage
													,self:= left));	
													
export tcommercial:= project(commercl, transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.commercl
													,self := left));													
//Keep latest incident

dincident_EA :=	dedup(sort(distribute(
																		tincident(source_id not in ['TF','TM'] and work_type_id not in ['2','3'] and trim(vendor_code,left,right) <> 'COPLOGIC'),hash(case_identifier))
															,case_identifier,agency_id,loss_state_abbr,report_type_id,crash_date,Sent_to_HPCC_DateTime,creation_date,report_id,record,local)
													,case_identifier,agency_id,loss_state_abbr,report_type_id,crash_date,right,local
											);
dincident_EA_Coplogic :=	dedup(sort(distribute(
																		tincident(source_id not in ['TF','TM'] and work_type_id not in ['2','3'] and trim(vendor_code,left,right) = 'COPLOGIC'),hash(case_identifier))
															,case_identifier,agency_id,loss_state_abbr,report_type_id,crash_date,Sent_to_HPCC_DateTime,creation_date,report_id,record,local)
													,case_identifier,agency_id,loss_state_abbr,report_type_id,crash_date,supplemental_report,right,local
											);											
dincident_EA_CRU:= 	dedup(sort(distribute(
																		tincident(work_type_id in ['2','3']),hash(case_identifier))
															,case_identifier,agency_id,loss_state_abbr,work_type_id,report_type_id,cru_order_id,Sent_to_HPCC_DateTime,creation_date,CRU_Sequence_Nbr,report_id,record,local)
													,case_identifier,agency_id,loss_state_abbr,work_type_id,report_type_id,cru_order_id,right,local
										);
											

dincident_TF :=  	dedup(sort(distribute(
																		tincident(source_id in ['TM','TF']),hash(state_report_number))
															,state_report_number,agency_id,ORI_Number,loss_state_abbr,work_type_id,report_type_id,source_id,Sent_to_HPCC_DateTime,creation_date,report_id,record,local)
													,state_report_number,agency_id,ORI_Number,loss_state_abbr,work_type_id,report_type_id,source_id,right,local)
											;	
											
dincidentCombined := dincident_EA + dincident_EA_Coplogic + dincident_EA_CRU	+ dincident_TF ;										
//------------------------------------------------------------------------------------------------------------------							
tincident trecs0(tincident L, agency R) := transform
self.agency_name := if(L.agency_id = R.agency_id,R.Agency_Name,'');// use this for QC ,if(work_type_id not in ['2','3'],l.agency_name,''));
self := L;
end;

jrecs0 := distribute(join(dincidentCombined,agency,
							left.agency_id = right.agency_id,
							trecs0(left,right),left outer,lookup),hash(incident_id)):independent;

//------------------------------------------------------------------------------------------------------------------								
FLAccidents_Ecrash.Layout_Infiles_Fixed.cmbnd  trecs1(jrecs0 L, tvehicl R) := transform
self.incident_id         := L.incident_id;
self.creation_date       := L.creation_date;
self.Avoidance_Maneuver2 := R.Avoidance_Maneuver2;
self.Avoidance_Maneuver3 := R.Avoidance_Maneuver3;
self.Avoidance_Maneuver4 := R.Avoidance_Maneuver4;
self.Damaged_Areas_Severity1:= R.Damaged_Areas_Severity1 ;
self.Damaged_Areas_Severity2 := R.Damaged_Areas_Severity2;
self.Vehicle_Outside_City_Indicator:= R.Vehicle_Outside_City_Indicator ;
self.Vehicle_Outside_City_Distance_Miles := R.Vehicle_Outside_City_Distance_Miles;
self.Vehicle_Outside_City_Direction := R.Vehicle_Outside_City_Direction;
self.Vehicle_Crash_Cityplace := R.Vehicle_Crash_Cityplace;
self.Insurance_Company_Standardized := R.Insurance_Company_Standardized;
self.number_of_lanes               := if(l.number_of_lanes not in ['','NULL'], l.number_of_lanes, r.number_of_lanes); 
self.divided_highway               := if(l.divided_highway not in ['','NULL'], l.divided_highway, r.divided_highway);
self.speed_limit_posted            := if(l.speed_limit_posted  not in ['','NULL'], l.speed_limit_posted , r.speed_limit_posted );
self := R;
self := L;
self := [];
end;

jrecs1 := join(jrecs0,	
	
								sort(dedup(sort(tvehicl(incident_id!='')
												,vin,incident_id,unit_number,creation_date,local)
										,vin,incident_id,unit_number,right,local)
										,incident_id,local),
							left.incident_id = right.incident_id,
							trecs1(left,right),left outer,local);

											
d_person :=		dedup(
									sort(
										tpersn(incident_id!=''),
												incident_id,vehicle_unit_number,last_name,first_name,date_of_birth,address,city,state,zip_code,home_phone,map(regexfind('DRIVER|VEHICLE DRIVER|VEHICLEDRIVER' , person_type) => 3
                                                                                                                                      ,regexfind('OWNER|VEHICLE OWNER|VEHICLEOWNER' , person_type) => 2,1),creation_date,person_id,local)
								       ,incident_id,vehicle_unit_number,last_name,first_name,date_of_birth,address,city,state,zip_code,home_phone,right,local); 
											 
//------------------------------------------------------------------------------------------------------------------
FLAccidents_Ecrash.Layout_Infiles_Fixed.cmbnd  trecs2(jrecs1 L, tpersn R) := transform
self.incident_id         := L.incident_id;
self.creation_date       := L.creation_date;
self.law_enforcement_suspects_alcohol_use1 := R.law_enforcement_suspects_alcohol_use1;
self.law_enforcement_suspects_drug_use1 := R.law_enforcement_suspects_drug_use1 ;
self.First_Aid_By := L.First_Aid_By; 
self.Person_First_Aid_Party_Type := l.Person_First_Aid_Party_Type ; 
self.Person_First_Aid_Party_Type_Description := l.Person_First_Aid_Party_Type_Description;
self.Insurance_Expiration_Date := l.Insurance_Expiration_Date;
self.Insurance_Policy_Number := l.Insurance_Policy_Number;
self.Insurance_Company := l.Insurance_Company;
self.Insurance_Company_Phone_Number :=l.Insurance_Company_Phone_Number ; 
self.Insurance_Effective_Date:= l. Insurance_Effective_Date;
self.Proof_of_Insurance:=l.Proof_of_Insurance; 
self.Insurance_Expired:=l.Insurance_Expired; 
self.Insurance_Exempt:=l.Insurance_Exempt; 
self.Insurance_Type:=l.Insurance_Type; 
self.Insurance_Company_Code:=l.Insurance_Company_Code; 
self.Address2 := STD.str.CleanSpaces(trim(L.Address2,left,right));
self := R;
self := L;
self := [];
end;


jrecs2 := join(jrecs1(Unit_Number != '0' and Unit_Number != ''),
											
									d_person,
														left.incident_id = right.incident_id and 
							              (unsigned)left.Unit_Number = (unsigned)right.vehicle_Unit_Number ,
														trecs2(left,right),left outer,local);	

											
jrecsOthers := jrecs1(Unit_Number = '0' or Unit_Number = '');		

// get person records by only incident_id when no vehcile records found 
jrecsOthersPerson := join( jrecsOthers , 
								            d_person,
										        left.incident_id = right.incident_id , 
														trecs2(left,right),left outer,local);	

//get person record that have 0 vehicle or if one or more recs in same incident have veh//like witness , property owner etc..
Jperson := join(jrecs0,
								d_person( vehicle_Unit_Number in ['','0','NUL','NULL']),
														left.incident_id = right.incident_id ,
							            	transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.cmbnd, self := left , self:= right , self:=[]),local);		

allrecs := dedup(sort(jrecs2 + jrecsOthersPerson + Jperson,record,local),record,local);						
//------------------------------------------------------------------------------------------------------------------
FLAccidents_Ecrash.Layout_Infiles_Fixed.cmbnd  trecs3(allrecs L, tcommercial R) := transform
self.incident_id := L.incident_id;
self.vehicle_id := L.vehicle_id;
self.creation_date := L.creation_date;
self := R;
self := L;
self := [];
end;

jrecs3 := join(distribute(allrecs,hash(vehicle_id))
							,dedup(sort(distribute(tcommercial(vehicle_id!=''),hash(vehicle_id)),vehicle_id,creation_date,local),vehicle_id,right,local),
							left.vehicle_id = right.vehicle_id,
							trecs3(left,right),left outer,local);


//------------------------------------------------------------------------------------------------------------------								
FLAccidents_Ecrash.Layout_Infiles_Fixed.cmbnd  trecs4(jrecs3 L, tcitation R) := transform
self.incident_id := L.incident_id;
self.creation_date := L.creation_date;
self.person_id := l.person_id ; 
self := R;
self := L;

end;

/*jrecs4 := join(distribute(jrecs3,hash(incident_id)),distribute(tcitation(incident_id!='' and person_id not in ['','NULL']),hash(incident_id)),
							left.incident_id = right.incident_id and
							left.person_id =right.person_id, 
							trecs4(left,right),left outer,local);	*/
jrecs4 := join(distribute(jrecs3,hash(incident_id)),tcitation(incident_id!=''),
							left.incident_id = right.incident_id,
							trecs4(left,right),left outer,local);	
//------------------------------------------------------------------------------------------------------------------										

// Property OWNER 

FLAccidents_Ecrash.Layout_Infiles_Fixed.cmbnd  trecs5(jrecs0 L, tproperty R) := transform
    self.incident_id                         := L.incident_id;
    self.person_type                         := 'PROPERTY OWNER'; 
    self.damage_description                  := r.damage_description	;
    self.damage_estimate                     := r.damage_estimate	;
		self.Last_Name                           := if (trim(r.property_owner_name,left,right) in ['','NULL'],r.property_owner_last_name,'')	;
    self.First_Name                          := if (trim(r.property_owner_name,left,right) in ['','NULL'],r.property_owner_first_name,r.property_owner_name); 
    self.Middle_Name                         := if (trim(r.property_owner_name,left,right) in ['','NULL'],r.property_owner_middle_name,''); 
    self.Address                             := r.property_owner_address;
    self.City                                := r.property_owner_city;
    self.State                               := r.property_owner_state;
    self.Zip_Code                            := r.property_owner_zip_code;
    self.Home_Phone                          := r.property_owner_phone;
		self.property_owner_notified             := if(l.property_owner_notified not in ['','NULL'], l.property_owner_notified, r.property_owner_notified); 
   	self.property_damage_id                  :=r.property_damage_id ;
		self:=l ;
    self:=[];
end; 

jrecs5 := join(jrecs0,tproperty(incident_id!=''),
							left.incident_id = right.incident_id,
							trecs5(left,right),local);		

Combined := jrecs4 + jrecs5 ; 

// Suppress the DE records basing on the drivers_exchange_flag in the agency file. -- #187626
suppressAgencies := agency(drivers_exchange_flag ='0');

updtdCombined := join(Combined,suppressAgencies(agency_id!=''),
							trim(left.agency_id,left,right) = trim(right.agency_id,left,right) and trim(left.report_type_id,left,right) ='DE',
							many lookup , left only );		

// end


FLAccidents_Ecrash.macRemoveNulls(updtdCombined,outrecs);
export cmbnd := dedup(sort(outrecs,record,local),record,local)(trim(agency_id,left,right) not in ['5','6','7']):persist('~thor_data400::persist::ecrash_cmbnd');


//Agency cmbnd file for agency key in Buycrash KY Integration
shared uBillingagencies := dedup(sort(distribute(billingagencies, hash32(Mbsi_Agency_ID)), 
                                      Mbsi_Agency_ID, local), 
																 Mbsi_Agency_ID, local);
shared uAgency := dedup(sort(distribute(agency(Agency_ID != ''), hash32(Agency_ID)), 
                             Agency_ID, -(Agency_Name <> ''), local), 
												Agency_ID, local);
												

FLAccidents_Ecrash.Layout_Infiles_Fixed.agency_cmbnd jagency0(uBillingagencies le, uAgency ri) := transform
																																		self.Agency_ori := ri.Agency_ori;
																																		self.Agency_State_abbr := STD.Str.ToUpperCase(trim(ri.Agency_State_abbr,left,right));
																																		self.Agency_Name := STD.Str.ToUpperCase(trim(ri.Agency_Name,left,right));
																																		self.Mbsi_Agency_ID := ri.Agency_ID;
																																		self.Cru_Agency_ID := le.Cru_Agency_ID;
																																		self.Cru_State_Number := (unsigned3)le.Cru_State_Number;
																																		self.Source_ID := ri.Source_ID;
																																		self.Append_Overwrite_Flag := ri.Append_Overwrite_Flag;
																																	 end;
EXPORT agencycmbnd := 	join(uBillingagencies, uAgency, left.Mbsi_Agency_ID = right.Agency_ID,
									           jagency0(left, right), right outer, local);
														 

end;