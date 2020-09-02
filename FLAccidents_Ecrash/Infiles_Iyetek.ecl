import ut,lib_fileservices;
export Infiles_Iyetek := module 

vIncident_tf  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::iyetek::incident_raw','~thor_data400::in::iyetek::incident_raw_'+workunit)) = 0 ,
                                 fail('Abort:  Iyetek Incident file spray skipped...'),Output('Iyetek Incident File Spray Success'));
																 
vCitation_tf  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::iyetek::citation_new','~thor_data400::in::iyetek::citation_new_'+workunit)) = 0 ,
                                 fail('Abort:  Iyetek Citation file spray skipped...'),Output('Iyetek Citation File Spray Success'));
																 
vPerson_tf  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::iyetek::person_new','~thor_data400::in::iyetek::person_new_'+workunit)) = 0 ,
                                 fail('Abort:  Iyetek Person file spray skipped...'),Output('Iyetek Person File Spray Success'));

vVehicle_tf  := if ( nothor (fileservices.FindSuperFileSubName('~thor_data400::in::iyetek::vehicle_new','~thor_data400::in::iyetek::vehicle_new_'+workunit)) = 0 ,
                                 fail('Abort:  Iyetek Vehicle file spray skipped...'),Output('Iyetek Vehicle File Spray Success'));

Sequential(vIncident_tf ,vCitation_tf,vPerson_tf ,vVehicle_tf);
																 


export agency0     := dataset(ut.foreign_prod+'~thor_data400::in::ecrash::agency'
													 ,FLAccidents_ecrash.Layout_Infiles.agency
													 ,csv(terminator('\n'), separator('~'),quote('"')))(Agency_ID != 'Agency_ID');	
													 
export agency:= project(agency0, transform({agency0}, 
                            self.agency_name := IF(trim(Left.agency_name,left,right) <>'', Left.agency_name,ERROR('agency file bad')),
                            self.agency_id := IF(trim(Left.agency_id,left,right) <>'', Left.agency_id,ERROR('agency file bad')),
                            self:= left));
														
export citation := dataset(ut.foreign_prod+'~thor_data400::in::iyetek::citation_new'
													 ,FLAccidents_Ecrash.Layout_metadata.citation
													 ,csv(terminator('\n'), separator(','),quote('"')))(date_created != 'date_created');	
													 
export incident   := dataset(ut.foreign_prod+'~thor_data400::in::iyetek::incident_raw'
													,FLAccidents_Ecrash.Layout_metadata.incident
													,csv(terminator('\n'), separator(','),quote('"'),maxlength(50000)))(date_created != 'date_created');
                 
export persn      := dataset(ut.foreign_prod+'~thor_data400::in::iyetek::person_new'
													,FLAccidents_Ecrash.Layout_metadata.person_record
													,csv(terminator('\n'), separator(','),quote('"')))(date_created != 'date_created');

export vehicl     := dataset(ut.foreign_prod+'~thor_data400::in::iyetek::vehicle_new'
													,FLAccidents_Ecrash.Layout_metadata.vehicle_record
													,csv(terminator('\n'), separator(','),quote('"')))(date_created != 'date_created');
													


export tcitation  := project(citation, transform(FLAccidents_Ecrash.Layout_metadata.citation_fixed
													,self := left));	
export tincident  := project(incident,transform(FLAccidents_Ecrash.Layout_metadata.incident_fixed
													,self:= left));														
export tpersn     := project(persn, transform(FLAccidents_Ecrash.Layout_metadata.person_fixed
													,self:= left));												
export tvehicl    := project(vehicl, transform(FLAccidents_Ecrash.Layout_metadata.vehicle_fixed
													,self:= left));													

dincident := 	dedup(sort(distribute(
																		tincident,hash(report_number))
															,report_number,agency_ori,mbs_agency_id,state_abbr,report_type,Sent_to_HPCC_DateTime,date_created,local)
													,report_number,agency_ori,mbs_agency_id,state_abbr,report_type,right,local)
											;			
tincident trecs0(tincident L, agency R) := transform
self.agency_name := if(L.mbs_agency_id = R.agency_id,R.Agency_Name,'');
self := L;
end;

jrecs0 := distribute(join(dincident,agency,
							left.mbs_agency_id = right.agency_id, // change to agency_ori 
							trecs0(left,right),left outer,lookup),hash(iyetek_metadata_id));
							
FLAccidents_Ecrash.Layout_metadata.temp_vehicle  trecs1(jrecs0 L, tvehicl R) := transform

		self.iyetek_metadata_vehicle_id := r.iyetek_metadata_vehicle_id;
		self.unit_number:= r.unit_number;
		self.vin := r.vin;
		self.make := r.make;
		self.model := r.model;
		self.model_year := r.model_year;
		self.tag := r.tag;
		self.tag_state_abbr := r.tag_state_abbr;
		self.vehicle_towed := r.vehicle_towed ;
		self.airbag_deployed:= r.airbag_deployed ;
		self.initial_point_of_contact := r.initial_point_of_contact ;
		self.insurance_company_name := r.insurance_company_name ;
		self.insurance_company_standardized := r.insurance_company_standardized ;
		self.insurance_policy_number := r.insurance_policy_number ;
		self.insurance_policy_date := r.insurance_policy_date ;
		self.vin_status := r.vin_status ; 
		self.damaged_areas1 := r.damaged_areas1; 
		self := L;
end;

jVehcile := join(jrecs0,	
	
								dedup(sort(distribute(tvehicl(iyetek_metadata_id!=''),hash(iyetek_metadata_id))
												,vin,iyetek_metadata_id,unit_number,date_created,local)
										,vin,iyetek_metadata_id,unit_number,right,local)
										,
							left.iyetek_metadata_id = right.iyetek_metadata_id,
							trecs1(left,right),left outer,local);

dd_jrecs1 :=	jVehcile;					
d_person := dedup(
									sort(
										distribute(tpersn(iyetek_metadata_id!=''),hash(iyetek_metadata_id)),
												iyetek_metadata_id,vehicle_unit_number,last_name,first_name,date_of_birth,address,city,state,zip,date_created,local)
								       ,iyetek_metadata_id,vehicle_unit_number,last_name,first_name,date_of_birth,address,city,state,zip,right,local)
											;
// get person records 

//------------------------------------------------------------------------------------------------------------------
FLAccidents_Ecrash.Layout_metadata.temp_person  trecs2(dd_jrecs1 L, tpersn R) := transform
		self.iyetek_metadata_person_id := r.iyetek_metadata_person_id ; 	
		self.vehicle_unit_number := r.vehicle_unit_number;
		self.person_type := r.person_type;
		self.first_name := r.first_name;
		self.middle_name := r.middle_name;
		self.last_name := r.last_name;
		self.date_of_birth := r.date_of_birth;
		self.driver_license := r.driver_license;
		self.injury := r.injury;
		self.address := r.address; 
		self.city := r.city; 
		self.state := r.state ; 
		self.zip := r.zip; 
		self.driver_license_jurisdiction := r.driver_license_jurisdiction;
		self := L;
end;

jperson := join(dd_jrecs1(Unit_Number != '0' and Unit_Number != ''),
										
										d_person(vehicle_Unit_Number  != '0' or vehicle_Unit_Number  = ''),
														left.iyetek_metadata_id = right.iyetek_metadata_id and 
							              left.Unit_Number = right.vehicle_Unit_Number ,
														trecs2(left,right),left outer,local);
	// this will get person if 0 veh rec found 													
Jperson2 := 	join(dd_jrecs1(Unit_Number = '0' or Unit_Number = ''),
										
										d_person,
														left.iyetek_metadata_id = right.iyetek_metadata_id ,
							             	trecs2(left,right),left outer,local);						

//get person record that have 0 vehicle or if one or more recs in same incident have veh//like witness , property owner etc..
jrecs2b := join(jrecs0,
											
									d_person(vehicle_Unit_Number in [ '0' , '','NULL','NUL']),
														left.iyetek_metadata_id = right.iyetek_metadata_id ,
							            	transform(FLAccidents_Ecrash.Layout_metadata.temp_person, self := left , self:= right , self:=[]),local);		

allrecs := dedup(jperson + Jperson2+jrecs2b,record,all) ; 

FLAccidents_Ecrash.Layout_metadata.temp_citation trecs4(allrecs L, tcitation R) := transform

self.iyetek_metadata_citation_id := r.iyetek_metadata_citation_id; 
self.citation_number := r.citation_number; 
self := L;

end;

jrecs4 := join(distribute(allrecs,hash(iyetek_metadata_id)),distribute(tcitation(iyetek_metadata_id!=''),hash(iyetek_metadata_id)),
							left.iyetek_metadata_id= right.iyetek_metadata_id,
							trecs4(left,right),left outer,local);				

// map to combined layout 

export cmbnd := project(dedup(jrecs4,record,all) , transform({FLAccidents_Ecrash.Layout_metadata.comnd}, 
                 
		self.creation_date := if(stringlib.stringtouppercase(trim(left.date_created,left,right)) = 'NULL', '', left.date_created );
		self.Officer_Report_Date := if(stringlib.stringtouppercase(trim(left.report_date,left,right))= 'NULL', '', trim(left.report_date,left,right)[1..10]); //check 
		self.Officer_Report_Time := if(stringlib.stringtouppercase(trim(left.report_date,left,right))= 'NULL', '',left.report_date[11.. length(left.report_date)] ); //check 
		self.Crash_Date := if(stringlib.stringtouppercase(trim(left.date_of_loss,left,right))= 'NULL', '',trim(left.date_of_loss[1..10],left,right) );
		self.sent_to_hpcc_datetime := if(stringlib.stringtouppercase(trim(left.Sent_to_HPCC_DateTime,left,right))= 'NULL', '',left.Sent_to_HPCC_DateTime);
		self.ORI_Number := if(stringlib.stringtouppercase(trim(left.agency_ori,left,right))= 'NULL', '', left.agency_ori);
		self.Agency_Name := if(stringlib.stringtouppercase(trim(left.agency_name,left,right))= 'NULL', '',left.agency_name );
		self.Loss_State_Abbr := if(stringlib.stringtouppercase(trim(left.state_abbr,left,right))= 'NULL', '',left.state_abbr );
		self.State_Report_Number := if(stringlib.stringtouppercase(trim(left.report_number,left,right))= 'NULL', '', left.report_number);
		self.Report_Type_ID := if(stringlib.stringtouppercase(trim(left.report_type,left,right))= 'NULL', '',left.report_type );
		self.Case_Identifier := if(stringlib.stringtouppercase(trim(left.Case_Identifier,left,right))= 'NULL', '', left.Case_Identifier);
		self.Incident_Hit_and_Run := if(stringlib.stringtouppercase(trim(left.hit_and_run,left,right))= 'NULL', '', left.hit_and_run);
		self.Crash_County := if(stringlib.stringtouppercase(trim(left.county_name,left,right))= 'NULL', '',left.county_name );
		self.Crash_City := if(stringlib.stringtouppercase(trim(left.city_name,left,right))= 'NULL', '', left.city_name);
		self.Loss_Street := if(stringlib.stringtouppercase(trim(left.primary_street,left,right))= 'NULL', '', left.primary_street);
		self.Loss_Cross_Street := if(stringlib.stringtouppercase(trim(left.cross_street,left,right))= 'NULL', '', left.cross_street); 
		self.Investigating_Officer_Name := if(stringlib.stringtouppercase(trim(left.officer_name,left,right))= 'NULL', '', left.officer_name);
		self.Judicial_District := if(stringlib.stringtouppercase(trim(left.district,left,right))= 'NULL', '', left.district);
		self.vehicle_id := if(stringlib.stringtouppercase(trim(left.iyetek_metadata_vehicle_id,left,right))= 'NULL', '', left.iyetek_metadata_vehicle_id );
		self.unit_number := if(stringlib.stringtouppercase(trim(left.unit_number,left,right))= 'NULL', '',left.unit_number);
		self.vin := if(stringlib.stringtouppercase(trim(left.vin,left,right))= 'NULL', '',left.vin );
		self.make := if(stringlib.stringtouppercase(trim(left.make,left,right))= 'NULL', '', left.make);
		self.model := if(stringlib.stringtouppercase(trim(left.model,left,right))= 'NULL', '', left.model );
		self.Model_Yr := if(stringlib.stringtouppercase(trim(left.model_year,left,right))= 'NULL', '', left.model_year );
		self.license_plate := if(stringlib.stringtouppercase(trim(left.tag,left,right)) = 'NULL', '', left.tag);
		self.Registration_State := if(stringlib.stringtouppercase(trim(left.tag_state_abbr,left,right)) = 'NULL', '', left.tag_state_abbr);
		self.Vehicle_Towed := if(stringlib.stringtouppercase(trim(left.Vehicle_Towed,left,right))= 'NULL', '', left.Vehicle_Towed);
		self.Airbags_Deployed_Derived := if(stringlib.stringtouppercase(trim(left.airbag_deployed,left,right))= 'NULL', '', left.airbag_deployed);
		self.Impact_Area1  := if(stringlib.stringtouppercase(trim(left.initial_point_of_contact,left,right))= 'NULL', '',left.initial_point_of_contact[1..25] );//cut 25 chars 
		self.Impact_Area2 := if(stringlib.stringtouppercase(trim(left.initial_point_of_contact,left,right))= 'NULL', '', left.initial_point_of_contact[25..]); //cut 25 chars 
		self.Insurance_Company := if(stringlib.stringtouppercase(trim(left.insurance_company_name,left,right))= 'NULL', '', left.insurance_company_name);
		self.Insurance_Company_Standardized := if(stringlib.stringtouppercase(trim(left.Insurance_Company_Standardized,left,right))= 'NULL', '', left.Insurance_Company_Standardized); 
		self.Insurance_Policy_Number := if(stringlib.stringtouppercase(trim(left.Insurance_Policy_Number,left,right))= 'NULL', '', left.Insurance_Policy_Number);
		self.Insurance_Expiration_Date :=  if(stringlib.stringtouppercase(trim(left.insurance_policy_date,left,right))= 'NULL', '', left.insurance_policy_date); //new
		self.person_id := if(stringlib.stringtouppercase(trim(left.iyetek_metadata_person_id,left,right))= 'NULL', '',left.iyetek_metadata_person_id ); 
		self.Vehicle_Unit_Number := if(stringlib.stringtouppercase(trim(left.Vehicle_Unit_Number,left,right))= 'NULL', '', left.Vehicle_Unit_Number);
		self.Person_Type := if(stringlib.stringtouppercase(trim(left.Person_Type ,left,right))= 'NULL', '',left.Person_Type );
		self.First_Name  :=if(stringlib.stringtouppercase(trim(left.first_name,left,right))= 'NULL', '',left.first_name );
		self.Middle_Name := if(stringlib.stringtouppercase(trim(left.middle_name,left,right))= 'NULL', '', left.middle_name);
		self.Last_Name := if(stringlib.stringtouppercase(trim(left.last_name,left,right))= 'NULL', '',left.last_name );
		self.Date_of_Birth := if(stringlib.stringtouppercase(trim(left.date_of_birth,left,right))= 'NULL', '',left.date_of_birth );
		self.Drivers_License_Number := if(stringlib.stringtouppercase(trim(left.driver_license,left,right))= 'NULL', '', left.driver_license);
		self.Injury_Description := if(stringlib.stringtouppercase(trim(left.injury,left,right))= 'NULL', '',left.injury );
		self.citation_id := if(stringlib.stringtouppercase(trim(left.iyetek_metadata_citation_id,left,right))= 'NULL', '',left.iyetek_metadata_citation_id );
		self.Citation_Number1 := if(stringlib.stringtouppercase(trim(left.citation_number,left,right))= 'NULL', '', left.citation_number);
		self.incident_id :=if(stringlib.stringtouppercase(trim( left.iyetek_metadata_id,left,right))= 'NULL', '', left.iyetek_metadata_id);
		self.is_available_for_public :=if( stringlib.stringtouppercase(trim(left.is_available_for_public,left,right))= 'NULL', '',  left.is_available_for_public); 
		self.has_addendum := if( stringlib.stringtouppercase(trim(left.has_addendum,left,right))= 'NULL', '', left.has_addendum);
		self.last_update_date:= if( stringlib.stringtouppercase(trim(left.last_update_date,left,right))= 'NULL', '', left.last_update_date);
		self.report_status:= if( stringlib.stringtouppercase(trim(left.report_status,left,right))= 'NULL', '',left.report_status );
		self.report_agency_ori:= if( stringlib.stringtouppercase(trim(left.report_agency_ori,left,right))= 'NULL', '', left.report_agency_ori);
		self.address := if( stringlib.stringtouppercase(trim(left.address,left,right))= 'NULL', '', left.address); 
		self.city := if( stringlib.stringtouppercase(trim(left.city,left,right))= 'NULL', '', left.city); 
		self.state := if(stringlib.stringtouppercase(trim( left.state,left,right))= 'NULL', '', left.state) ; 
		self.zip := if(stringlib.stringtouppercase(trim( left.zip,left,right))= 'NULL', '', left.zip); 
		self.work_type_id := if(stringlib.stringtouppercase(trim(left.work_type_id,left,right)) = 'NULL', '', left.work_type_id); 
    self.driver_license_jurisdiction :=if(stringlib.stringtouppercase(trim(left.driver_license_jurisdiction,left,right)) = 'NULL', '', left.driver_license_jurisdiction);
		self.mbs_agency_id := if(stringlib.stringtouppercase(trim(left.mbs_agency_id,left,right)) = 'NULL', '',left.mbs_agency_id);
    self.vin_status := if(stringlib.stringtouppercase(trim(left.vin_status,left,right)) = 'NULL', '',left.vin_status);
		self.damaged_areas1 := if(stringlib.stringtouppercase(trim(left.damaged_areas1,left,right)) = 'NULL', '',left.damaged_areas1);
    self:= left; 
)); 
 
end; 