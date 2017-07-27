import ut,lib_fileservices;
export Infiles    := module

//Validate whether all files have been sprayed to thor for a given run

vIncident_ea  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::ecrash::incidnt_new','~thor_data400::in::ecrash::incidnt_new_'+workunit)) = 0 ,
                                 fail('Abort:  EA Incident file spray skipped...'),Output('EA Incident File Spray Success'));
																 
vCitation_ea  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::ecrash::citatn_new','~thor_data400::in::ecrash::citatn_new_'+workunit)) = 0 ,
                                 fail('Abort:  EA Citation file spray skipped...'),Output('EA Citation File Spray Success'));
																 
vCommercial_ea  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::ecrash::commercl_new','~thor_data400::in::ecrash::commercl_new_'+workunit)) = 0 ,
                                 fail('Abort:  EA Commercial file spray skipped...'),Output('EA Commercial File Spray Success'));
																 
vPerson_ea  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::ecrash::persn_new','~thor_data400::in::ecrash::persn_new_'+workunit)) = 0 ,
                                 fail('Abort:  EA Person file spray skipped...'),Output('EA Person File Spray Success'));
																 
vVehicle_ea  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::ecrash::vehicl_new','~thor_data400::in::ecrash::vehicl_new_'+workunit)) = 0 ,
                                 fail('Abort:  EA Vehicle file spray skipped...'),Output('EA Vehicle File Spray Success'));
																 
vProperty_Damage_ea  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::ecrash::propertydamage_new','~thor_data400::in::ecrash::propertydamage_new_'+workunit)) = 0 ,
                                 fail('Abort:  EA Property Damage file spray skipped...'),Output('EA Property Damage File Spray Success'));
																 
																 
Sequential( vIncident_ea , vCitation_ea, vCommercial_ea , vPerson_ea, vVehicle_ea , vProperty_Damage_ea );



export agency0     := dataset(ut.foreign_prod+'~thor_data400::in::ecrash::agency'
													 ,FLAccidents_Ecrash.Layout_Infiles.agency
													 ,csv(terminator('\n'), separator('~'),quote('"')))(Agency_ID != 'Agency_ID');	
													 
export agency:= project(agency0, transform({agency0}, 
                            self.agency_name := IF(trim(Left.agency_name,left,right) <>'', Left.agency_name,ERROR('agency file bad')),
                            self.agency_id := IF(trim(Left.agency_id,left,right) <>'', Left.agency_id,ERROR('agency file bad')),
                            self:= left));
												
export citation := dataset(ut.foreign_prod+'~thor_data400::in::ecrash::citatn_new'
													 ,FLAccidents_Ecrash.Layout_Infiles.citation
													 ,csv(terminator('\n'), separator(','),quote('"')))(Citation_ID != 'Citation_ID')	;
																		
export commercl   := dataset(ut.foreign_prod+'~thor_data400::in::ecrash::commercl_new'
													,FLAccidents_Ecrash.Layout_Infiles.commercial
													,csv(terminator('\n'), separator(','),quote('"')))(Commercial_ID != 'Commercial_ID');	
 											
export incident   := dataset(ut.foreign_prod+'~thor_data400::in::ecrash::incidnt_new'
													,FLAccidents_Ecrash.Layout_Infiles.incident_new
													,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Incident_ID');
                     
              
export persn      :=  dataset(ut.foreign_prod+'~thor_data400::in::ecrash::persn_new'
													,FLAccidents_Ecrash.Layout_Infiles.persn_new
													,csv(terminator('\n'), separator(','),quote('"')))(Person_ID != 'Person_ID');
                    
export vehicl     :=  dataset(ut.foreign_prod+'~thor_data400::in::ecrash::vehicl_new'
													,FLAccidents_Ecrash.Layout_Infiles.vehicl_new
													,csv(terminator('\n'), separator(','),quote('"'),maxlength(50000)))(Vehicle_ID != 'Vehicle_ID');
												
export Property_damage     :=  dataset(ut.foreign_prod+'~thor_data400::in::ecrash::propertydamage_new'
													,FLAccidents_Ecrash.Layout_Infiles.property_damage
													,csv(terminator('\n'), separator(','),quote('"'),maxlength(50000)))(Property_Damage_ID != 'Property_Damage_ID');

											
export tcitation  := project(citation, transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.citation
													,self := left));	
export tcommercial:= project(commercl, transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.commercl
													,self := left));													
export tincident  := project(incident,transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.incident
													,self.incident_id := left.incident_id[1..9], 
													self.case_identifier := stringlib.stringtouppercase(left.case_identifier),
													self.state_report_number := stringlib.stringtouppercase(left.state_report_number),
													self:= left));														
export tpersn     := project(persn, transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.persn
                          		,self.person_type := /*stringlib.StringFilter(*/stringlib.stringtouppercase(left.person_type);//,'ABCDEFGHIJKLMNOPQRSTUVWXYZ |');
															,self:= left));												
export tvehicl    := project(vehicl, transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.vehicl
													,self:= left));				

export tproperty := project(Property_damage, transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.Property_damage
													,self:= left));	
//Keep latest incident

dincident_EA :=	dedup(sort(distribute(
																		tincident(source_id !='TF' and work_type_id not in ['2','3']),hash(case_identifier))
															,case_identifier,agency_id,loss_state_abbr,work_type_id,report_type_id,Sent_to_HPCC_DateTime,creation_date,report_id,local)
													,case_identifier,agency_id,loss_state_abbr,report_type_id,right,local
											);
											
dincident_EA_CRU:= 	dedup(sort(distribute(
																		tincident(work_type_id in ['2','3']),hash(case_identifier))
															,case_identifier,agency_id,loss_state_abbr,work_type_id,report_type_id,cru_order_id,Sent_to_HPCC_DateTime,creation_date,CRU_Sequence_Nbr,report_id,local)
													,case_identifier,agency_id,loss_state_abbr,work_type_id,report_type_id,cru_order_id,right,local
										);
											

dincident_TF :=  	dedup(sort(distribute(
																		tincident(source_id ='TF'),hash(state_report_number))
															,state_report_number,agency_id,ORI_Number,loss_state_abbr,work_type_id,report_type_id,Sent_to_HPCC_DateTime,creation_date,report_id,local)
													,state_report_number,agency_id,ORI_Number,loss_state_abbr,work_type_id,report_type_id,right,local)
											;	
											
dincidentCombined := dincident_EA + dincident_EA_CRU	+ dincident_TF ;										
//------------------------------------------------------------------------------------------------------------------							
tincident trecs0(tincident L, agency R) := transform
self.agency_name := if(L.agency_id = R.agency_id,R.Agency_Name,'');
self := L;
end;

jrecs0 := distribute(join(dincidentCombined,agency,
							left.agency_id = right.agency_id,
							trecs0(left,right),left outer,lookup),hash(incident_id));

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
	
								sort(dedup(sort(distribute(tvehicl(incident_id!=''),hash(incident_id))
												,vin,incident_id,unit_number,creation_date,local)
										,vin,incident_id,unit_number,right,local)
										,incident_id,local),
							left.incident_id = right.incident_id,
							trecs1(left,right),left outer,local);

											
d_person :=		dedup(
									sort(
										distribute(tpersn(incident_id!=''),hash(incident_id)),
												incident_id,vehicle_unit_number,last_name,first_name,date_of_birth,address,city,state,zip_code,home_phone,map(regexfind('DRIVER|VEHICLE DRIVER|VEHICLEDRIVER' , person_type) => 3
                                                                                                                                      ,regexfind('OWNER|VEHICLE OWNER|VEHICLEOWNER' , person_type) => 2,1),creation_date,local)
								       ,incident_id,vehicle_unit_number,last_name,first_name,date_of_birth,address,city,state,zip_code,right,local); 
											 
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

self := R;
self := L;
self := [];
end;


jrecs2 := join(jrecs1(Unit_Number != '0' and Unit_Number != ''),
											
									d_person,
														left.incident_id = right.incident_id and 
							              left.Unit_Number = right.vehicle_Unit_Number ,
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

allrecs := dedup(sort(distribute(jrecs2 + jrecsOthersPerson+Jperson,hash(incident_id)),record,local),record,local);						
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
jrecs4 := join(distribute(jrecs3,hash(incident_id)),distribute(tcitation(incident_id!=''),hash(incident_id)),
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

jrecs5 := join(jrecs0,distribute(tproperty(incident_id!=''),hash(incident_id)),
							left.incident_id = right.incident_id,
							trecs5(left,right),local);		

Combined := jrecs4 + jrecs5 ; 

FLAccidents_Ecrash.macRemoveNulls(Combined,outrecs);
export cmbnd := dedup(sort(distribute(outrecs,hash(incident_id)),record,local),record,local)(trim(agency_id,left,right) not in ['5','6','7']):persist('~thor_data400::persist::ecrash_cmbnd');
end;





