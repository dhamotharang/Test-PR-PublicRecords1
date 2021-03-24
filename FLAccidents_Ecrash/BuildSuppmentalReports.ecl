/*2017-05-24T18:45:57Z (Srilatha Katukuri)
ECH-4987 - Production bug Fix - to account for Suppressed TF reports

*/
/*2016-11-22T21:12:32Z (Srilatha Katukuri)
Bug DF-17970 - Drop in Supplemental records
*/
/*2016-06-10T06:03:31Z (Srilatha Katukuri)
DFF-16695 Final Check in
*/
/*2016-06-07T19:54:14Z (Srilatha Katukuri)
DFF- 16695 - Coplogic DataIngestion2
*/
/*2016-03-04T02:36:53Z (Srilatha Katukuri)
Ã¢â‚¬â€œ Bug: 201048  -- fixed the page count issue for supplemetal reports
*/
/*2015-10-13T00:45:04Z (Srilatha Katukuri)
#181860 - accesing agency QC file
*/
/*2015-08-28T16:26:54Z (Srilatha Katukuri)
#181860 PRUS
*/
/*2015-08-28T16:24:57Z (Srilatha Katukuri)
#187626 
*/
/*2015-08-14T19:24:32Z (Srilatha Katukuri)
#181860 PRUS
*/
/*2015-08-07T23:48:43Z (Srilatha Katukuri)
#181860 - PRUS
*/
/*2015-05-15T19:55:59Z (Srilatha Katukuri)
Bug# 180852 - PIR 4710 Coplogic Data ingestion
*/
import STD; 
export BuildSuppmentalReports := module 
agency     := FLAccidents_Ecrash.Infiles.dAgency;			

tpersn     := dedup(FLAccidents_Ecrash.Infiles.tpersn	,all,local);										
tvehicl    := dedup(FLAccidents_Ecrash.Infiles.tvehicl	,all,local);	
tIncident := FLAccidents_Ecrash.IncidentsAfterSuppression;

//keep all incidents and flag updated or duplicate version of reports

dincident_EA :=	dedup(sort(distribute(
																		tincident(work_type_id not in ['2','3']),hash32(agency_id, contrib_source))
															,incident_id,Sent_to_HPCC_DateTime,creation_date,report_id,local)
													,incident_id,right,local
											);

						
dincidentCombined := dincident_EA ;
									
//------------------------------------------------------------------------------------------------------------------							
tincident trecs0(tincident L, agency R) := transform
  agency_source_matching := L.agency_id = R.agency_id AND L.Contrib_Source = R.Source_Id;
  self.agency_name := if(agency_source_matching,
	                       R.Agency_Name,
												 L.Agency_Name);
  IsAgencyActive := Functions.IsActiveDate(mod_Utilities.SysDate, R.Source_Start_Date, R.Source_Termination_Date);
  self.is_terminated_agency := if(agency_source_matching, ~IsAgencyActive, true); 
  self := L;
end;

jrecs0 := distribute(join(dincidentCombined,agency,
							left.agency_id = right.agency_id AND 
							left.contrib_source = right.source_id,
							trecs0(left,right),lookup),hash32(incident_id));
							
filtered_jrecs0 := jrecs0(is_terminated_agency = FALSE);

//------------------------------------------------------------------------------------------------------------------								
FLAccidents_Ecrash.Layout_Infiles_Fixed.cmbnd  trecs1(filtered_jrecs0 L, tvehicl R) := transform
     self.incident_id                           := L.incident_id;
     self.creation_date                         := L.creation_date;
     self.Avoidance_Maneuver2                   := R.Avoidance_Maneuver2;
     self.Avoidance_Maneuver3                   := R.Avoidance_Maneuver3;
     self.Avoidance_Maneuver4                   := R.Avoidance_Maneuver4;
     self.Damaged_Areas_Severity1               := R.Damaged_Areas_Severity1 ;
     self.Damaged_Areas_Severity2               := R.Damaged_Areas_Severity2;
     self.Vehicle_Outside_City_Indicator        := R.Vehicle_Outside_City_Indicator ;
     self.Vehicle_Outside_City_Distance_Miles   := R.Vehicle_Outside_City_Distance_Miles;
     self.Vehicle_Outside_City_Direction        := R.Vehicle_Outside_City_Direction;
     self.Vehicle_Crash_Cityplace               := R.Vehicle_Crash_Cityplace;
     self.Insurance_Company_Standardized        := R.Insurance_Company_Standardized;
     self.number_of_lanes                       := if(l.number_of_lanes not in ['','NULL'], l.number_of_lanes, r.number_of_lanes); 
     self.divided_highway                       := if(l.divided_highway not in ['','NULL'], l.divided_highway, r.divided_highway);
     self.speed_limit_posted                    := if(l.speed_limit_posted  not in ['','NULL'], l.speed_limit_posted , r.speed_limit_posted );
     self                                       := R;
     self                                       := L;
     self                                       := [];
		 
end;

jrecs1 := join(filtered_jrecs0,	
							  sort(dedup(sort(distribute(tvehicl(incident_id!=''),hash32(incident_id))
												,vin,incident_id,unit_number,creation_date,local)
										    ,vin,incident_id,unit_number,right,local)
										    ,incident_id,local),
							          left.incident_id = right.incident_id,
							          trecs1(left,right),left outer,local
							);

											
d_person :=		dedup(
									sort(
										distribute(tpersn(incident_id!=''),hash32(incident_id)),
												incident_id,vehicle_unit_number,last_name,first_name,date_of_birth,address,city,state,zip_code,home_phone,map(regexfind('DRIVER|VEHICLE DRIVER|VEHICLEDRIVER' , person_type) => 3
                                                                                                                                      ,regexfind('OWNER|VEHICLE OWNER|VEHICLEOWNER' , person_type) => 2,1),creation_date,local)
								       ,incident_id,vehicle_unit_number,last_name,first_name,date_of_birth,address,city,state,zip_code,right,local); 
											 
//------------------------------------------------------------------------------------------------------------------
FLAccidents_Ecrash.Layout_Infiles_Fixed.cmbnd  trecs2(jrecs1 L, tpersn R) := transform
     
		 self.incident_id                              := L.incident_id;
     self.creation_date                            := L.creation_date;
     self.law_enforcement_suspects_alcohol_use1    := R.law_enforcement_suspects_alcohol_use1;
     self.law_enforcement_suspects_drug_use1       := R.law_enforcement_suspects_drug_use1 ;
     self.First_Aid_By                             := L.First_Aid_By; 
     self.Person_First_Aid_Party_Type              := l.Person_First_Aid_Party_Type ; 
     self.Person_First_Aid_Party_Type_Description  := l.Person_First_Aid_Party_Type_Description;
     self.Insurance_Expiration_Date                := l.Insurance_Expiration_Date;
     self.Insurance_Policy_Number                  := l.Insurance_Policy_Number;
     self.Insurance_Company                        := l.Insurance_Company;
     self.Insurance_Company_Phone_Number           := l.Insurance_Company_Phone_Number ; 
     self.Insurance_Effective_Date                 := l.Insurance_Effective_Date;
     self.Proof_of_Insurance                       := l.Proof_of_Insurance; 
     self.Insurance_Expired                        := l.Insurance_Expired; 
     self.Insurance_Exempt                         := l.Insurance_Exempt; 
     self.Insurance_Type                           := l.Insurance_Type; 
     self.Insurance_Company_Code                   := l.Insurance_Company_Code; 
     self                                          := R;
     self                                          := L;
     self                                          := [];
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
Jperson := join(filtered_jrecs0,
											
									d_person( vehicle_Unit_Number in ['','0','NUL','NULL']),
														left.incident_id = right.incident_id ,
							            	transform(FLAccidents_Ecrash.Layout_Infiles_Fixed.cmbnd, self := left, self:= right, self:=[]), local);		

allrecs := dedup(sort(distribute(jrecs2 + jrecsOthersPerson + Jperson, hash32(incident_id)), record, local), record, local) ;					

// Suppress DE Reports with Flag value 0 in agency file.
suppressAgencies := distributed(Infiles.agency(drivers_exchange_flag ='0'), hash32(agency_id));
uSuppressAgencies := dedup(sort(suppressAgencies, Agency_id, local), Agency_id, local);

updtdAllrecs:= join(allrecs, uSuppressAgencies,
							      trim(left.agency_id,left,right) = trim(right.agency_id,left,right) and 
										trim(left.report_type_id,left,right) = 'DE',
							      many lookup, left only);
					
// Supress reports
allrecs0 := updtdAllrecs(~(trim(case_identifier,left,right) in  FLAccidents_Ecrash.Suppress_Id and source_id in ['EA', 'TF'])); 
allrecsSupressed1 := allrecs0(trim(report_id,left,right) not in FlAccidents_ecrash.Suppress_report_d);

allrecsSupressed  := join(allrecsSupressed1 (incident_id not in FLAccidents_Ecrash.supress_incident_id), FLAccidents_Ecrash.Files.deletes, 
                         trim(left.case_identifier,left,right)     = trim(right.case_identifier,left,right) and 
												 trim(left.State_Report_Number,left,right) = trim(right.State_Report_Number,left,right) and 
												 trim(left.Source_ID ,left,right)          = trim(right.Source_ID ,left,right)and 
												 trim(left.Loss_State_Abbr,left,right)     = trim(right.Loss_State_Abbr,left,right) and 
												 STD.Str.FilterOut(trim(right.Crash_Date,left,right),'-') = STD.Str.FilterOut(trim(right.Crash_Date,left,right),'-') and 
												 trim(left.Agency_ID,left,right)           = trim(right.Agency_ID,left,right) and 
												 trim(left.Work_Type_ID ,left,right)       = trim(right.Work_Type_ID,left,right) /*and 
												 trim(left.report_Type_ID ,left,right)       = trim(right.report_Type_ID,left,right)*/, many lookup , left only ); 


 tref0 := project(allrecsSupressed ,transform( FLAccidents_Ecrash.Layouts.slim_layout ,
  
  self.loss_street              := STD.Str.CleanSpaces ( if (trim(left.loss_street,left,right) ='NULL', '',trim(left.loss_street,left,right)));
  self.loss_cross_street        := STD.Str.CleanSpaces ( if (trim(left.loss_cross_street,left,right) ='NULL', '',trim(left.loss_cross_street,left,right)));
  self.hash_key                 := STD.Str.CleanSpaces ( if (trim(left.hash_key,left,right) ='NULL', '',trim(left.hash_key,left,right)));
  self.last_name                := STD.Str.CleanSpaces ( if (trim(left.last_name,left,right) ='NULL', '',trim(left.last_name,left,right)));
  self.first_name               := STD.Str.CleanSpaces ( if (trim(left.first_name,left,right) ='NULL', '',trim(left.first_name,left,right)));
  self.middle_name              := STD.Str.CleanSpaces ( if (trim(left.middle_name,left,right) ='NULL', '',trim(left.middle_name,left,right)));
  self.address                  := STD.Str.CleanSpaces ( if (trim(left.address ,left,right) ='NULL', '',trim(left.address,left,right)));
  self.city                     := STD.Str.CleanSpaces ( if (trim(left.city,left,right) ='NULL', '',trim(left.city,left,right)));
  self.state                    := STD.Str.CleanSpaces ( if (trim(left.state,left,right) ='NU', '',trim(left.state,left,right)));
  self.zip_code                 := STD.Str.CleanSpaces ( if (trim(left.zip_code,left,right) ='NULL', '',trim(left.zip_code,left,right)));
  self.Drivers_License_Number   := STD.Str.CleanSpaces ( if (trim(left.Drivers_License_Number,left,right) ='NULL', '',trim(left.Drivers_License_Number,left,right)));
  self.License_Plate            := STD.Str.CleanSpaces ( if (trim(left.License_Plate,left,right) ='NULL', '',trim(left.License_Plate,left,right)));
  self.vin                      := STD.Str.CleanSpaces ( if (trim(left.vin ,left,right) ='NULL', '',trim(left.vin,left,right))); 
  self.Make                     := STD.Str.CleanSpaces ( if (trim(left.Make,left,right) ='NULL', '',trim(left.Make,left,right)));
  self.Model_Yr                 := STD.Str.CleanSpaces ( if (trim(left.Model_Yr,left,right) ='NULL', '',trim(left.Model_Yr,left,right)));
  self.Model                    := STD.Str.CleanSpaces ( if (trim(left.Model,left,right) ='NULL', '',trim(left.Model,left,right)));
  
// Map TF rules in EA and use same logic  overwriting case_id and crash date 

  self.case_identifier 					:= if(left.source_id in ['TF','TM'],Left.state_report_number, Left.case_identifier);
  self.crash_date               := if (left.source_id in ['TF','TM'],'',STD.Str.FilterOut(trim(Left.crash_date,left,right),'-'));
  self.source_id                := if (left.source_id in ['TF','TM'],'TF','EA');
  // should match with payload key 
	self.report_code              := left.source_id;
	self.accident_date            := STD.Str.FilterOut(trim(Left.crash_date,left,right),'-');
	t_accident_nbr 			          := if(left.source_id in ['TF','TM'],Left.state_report_number, Left.case_identifier);
  t_scrub                       := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
  self.accident_nbr             := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+left.incident_id,t_scrub);  
  self.orig_accnbr              := t_accident_nbr; 
  self.addl_report_number			  := if(left.source_id in ['TF','TM'],Left.case_identifier,Left.state_report_number);
  self.orig_case_identifier     := if(trim(left.case_identifier,left,right) = 'NULL', '',  left.case_identifier); 
	self.orig_state_report_number := if(trim(left.state_report_number,left,right) = 'NULL', '',  left.state_report_number);
	self.Page_Count 							:=	left.Page_Count;

	self:=left   )):persist('~thor_data400::ecrash_incident_combined');

shared tref := tref0 : independent; 

// Filter out TM's if TM came in accidently after TF.. All the TM's after TF are invalid.

export IyetekFull := distribute(tref (report_code = 'TF'),hash32(State_Report_Number));
shared IyetekMeta := distribute(tref (report_code = 'TM') ,hash32(state_report_number));

shared jdropMetadata := join( IyetekMeta,IyetekFull, left.state_report_number = right.State_Report_Number and 
                                        left.ORI_Number = right.ORI_Number and 
																				left.loss_state_abbr = right.loss_state_abbr and 
																				left.report_type_id  = right.report_type_id and 
																				//left.creation_date >= right.creation_date,
																				left.Sent_to_HPCC_DateTime >= right.Sent_to_HPCC_DateTime,
																				transform({IyetekMeta}, self := left),left only  , local) + tref(report_code <>'TM'); 

// Create extract for TM's which are recieved after TF 

export TMafterTF := dedup(join( IyetekMeta(is_available_for_public ='1' and STD.Str.ToUpperCase(report_status) = 'COMPLETED'),IyetekFull, left.state_report_number = right.State_Report_Number and 
                                        left.ORI_Number = right.ORI_Number and 
																				left.loss_state_abbr = right.loss_state_abbr and 
																				left.report_type_id  = right.report_type_id and
																				left.Sent_to_HPCC_DateTime > right.Sent_to_HPCC_DateTime,
																				transform({IyetekMeta}, self := left), local),all,local) ; 

t_sort := sort(jdropMetadata,case_identifier,agency_id,loss_state_abbr,report_type_id,crash_date,source_id,-creation_date,-Sent_to_HPCC_DateTime,incident_id,last_name , first_name, middle_name, address,city,state,zip_code,
               Drivers_License_Number,License_Plate,vin,Make,Model_Yr,Model,hash_key,loss_street,loss_cross_street);

t_sort t(t_sort L, t_sort R) := transform

  self.last_name                := l.last_name  + r.last_name  ; 
  self.first_name               := l.first_name + r.first_name ; 
  self.middle_name              := l.middle_name + r.middle_name ; 
  self.address                  := l.address +r.address; 
  self.city                     := l.city+r.city ;
  self.state                    := l.state+r.state ; 
  self.zip_code                 := l.zip_code +r.zip_code ; 
  self.Drivers_License_Number   := l.Drivers_License_Number + r.Drivers_License_Number ;
  self.License_Plate            := l.License_Plate + r.License_Plate; 
  self.vin                      := l.vin +r.vin ;
  self.Make                     := l.make+r.make; 
  self.Model_Yr                 := l.Model_Yr + r.Model_Yr; 
  self.Model                    := l.Model + r.Model; 
  self                          := l;
end;

shared troll := rollup(t_sort, LEFT.incident_id= RIGHT.incident_id,t(left, right));

grp_coplogic := group(sort(troll(trim(vendor_code, left,right) = 'COPLOGIC'),
                           case_identifier,agency_id,loss_state_abbr,crash_date,Supplemental_report
													 ),
                      case_identifier,agency_id,loss_state_abbr,crash_date
											);

grp_coplogic coplogic(grp_coplogic l, grp_coplogic r) := transform
																			
	Suppmental_flag := map(l.incident_id = '' => '',
                         trim(r.Supplemental_Report, left, right) = '1' => 'U',
												 trim(r.Supplemental_Report, left, right) in ['0',''] => 'D', 
											  'D');																			
	self.U_D_flag := Suppmental_flag;															
  self.changed_hashkey := Suppmental_flag;
	self.changed_data_lev1 := Suppmental_flag;
  self := r;
end;
shared ds_coplogic := iterate(grp_coplogic,coplogic(left,right));

grp := group(sort(troll(trim(vendor_code, left,right) <> 'COPLOGIC'),
                  case_identifier,agency_id,loss_state_abbr,report_type_id,crash_date,source_id
								 ),
						case_identifier,agency_id,loss_state_abbr,report_type_id,crash_date,source_id
					  );

// set a flag if Dupe or update 
grp aflag(grp l, grp r) := transform	
  tchanged_hashkey               := if(l.hash_key                <> r.hash_key ,'Y','N'); 
  tchanged_data_lev1             := if((l.loss_street            <>  r.loss_street       or
                                      l.loss_cross_street        <>  r.loss_cross_street or
                                      l.last_name                <>  r.last_name         or       
                                      l.first_name               <>  r.first_name        or          
                                      l.middle_name              <>  r.middle_name       or         
                                      l.address                  <>  r.address           or      
                                      l.city                     <>  r.city              or      
                                      l.state                    <>  r.state             or        
                                      l.zip_code                 <>  r.zip_code          or          
                                      l.Drivers_License_Number   <> r.Drivers_License_Number or
                                      l.License_Plate            <> r.License_Plate          or
                                      l.vin                      <> r.vin                    or      
                                      l.Make                     <> r.Make                   or       
                                      l.Model_Yr                 <> r.Model_Yr               or         
                                      l.Model                    <> r.Model     )  , 'Y', 'N');  

  self.U_D_flag                := if ( l.incident_id = '' , '', if(tchanged_hashkey= 'Y' and tchanged_data_lev1 ='Y' ,'U' , 'D')); 
  self.changed_hashkey         := tchanged_hashkey;
	self.changed_data_lev1       := tchanged_data_lev1;
  self                         := r;
end;
ds_other := iterate(grp,aflag(left,right));
//compare_add := ds_coplogic + ds_other;
	
	//Coplogic Reports
tincident_c  := sort(distribute(project(ds_coplogic,transform(FLAccidents_Ecrash.Layouts.ReportVersionNested,
												 
													self.hash_				     :=	 dataset([{Left.Creation_Date,Left.Incident_ID,left.Report_ID,Left.Hash_Key,left.U_D_flag,left.Sent_to_HPCC_DateTime,left.report_code,left.page_count,left.Supplemental_report, left.report_type_id}],{FLAccidents_Ecrash.Layouts.l_hash});
													self.super_report_id   := left.Report_ID;
													self:= left))	,hash32(case_identifier))	,case_identifier,agency_id,loss_state_abbr,crash_date,source_id, -Sent_to_HPCC_DateTime,-creation_date, local);											

 tincident_c tmakechildren_c(tincident_c L, tincident_c R) := transform

     self.hash_						                  :=	L.hash_&R.hash_;
     //self.super_report_ID		                :=	if((integer)L.super_Report_ID < (integer)R.super_Report_ID,l.super_Report_ID,r.super_Report_ID);
		 self.super_report_ID		                :=	if(L.U_D_Flag = '',l.super_Report_ID,r.super_Report_ID);
		 self := L;
 end;
//Non Coplogic reports
tincident_other  := sort(distribute(project(ds_other,transform(FLAccidents_Ecrash.Layouts.ReportVersionNested,
												 
													self.hash_				     :=	 dataset([{Left.Creation_Date,Left.Incident_ID,left.Report_ID,Left.Hash_Key,left.U_D_flag,left.Sent_to_HPCC_DateTime,left.report_code,left.page_count,left.Supplemental_report, left.report_type_id}],{FLAccidents_Ecrash.Layouts.l_hash});
													self.super_report_id   := left.Report_ID;
													self:= left))	,hash32(case_identifier))	,case_identifier,agency_id,loss_state_abbr,report_type_id,crash_date,source_id, -Sent_to_HPCC_DateTime,-creation_date, local);											

 tincident_other tmakechildren_other(tincident_other L, tincident_other R) := transform

     self.hash_						                  :=	L.hash_&R.hash_;
     self.super_report_ID		                :=	if((integer)L.super_Report_ID < (integer)R.super_Report_ID,l.super_Report_ID,r.super_Report_ID);
		 self := L;
 end;


drollup_report_versionkey_c := rollup(tincident_c,case_identifier+agency_id+loss_state_abbr+crash_date+source_id, tmakechildren_c(left, right), local):persist('~thor_data400::EA_report_version_Coplogic');			
 
drollup_report_versionkey_other := rollup(tincident_other,case_identifier+agency_id+loss_state_abbr+report_type_id+crash_date+source_id, tmakechildren_other(left, right), local):persist('~thor_data400::EA_report_version');
			
// Add Coplogic and other reports

cmbnd_drollup_report_versionkey := drollup_report_versionkey_c + drollup_report_versionkey_other;

//Normalize hashes
	hashTable := table(cmbnd_drollup_report_versionkey, 
								{integer hashCount := count(hash_), 
								cmbnd_drollup_report_versionkey});

	FLAccidents_Ecrash.Layouts.ReportVersion gethash(hashTable l, integer c):= transform
		
		self 								          := l.hash_[c];
		self.super_report_id	        := l.super_report_id;
		self.jurisdiction             := if(STD.Str.ToUpperCase(trim(L.agency_name,left,right))='NULL','',STD.Str.ToUpperCase(L.agency_name));
		self.orig_accnbr              := if(STD.Str.ToUpperCase(trim(L.orig_accnbr,left,right))='NULL','',STD.Str.ToUpperCase(L.orig_accnbr));
		self.addl_report_number       := if(STD.Str.ToUpperCase(trim(L.addl_report_number,left,right))='NULL','',STD.Str.ToUpperCase(L.addl_report_number));
		self.jurisdiction_state       := if(STD.Str.ToUpperCase(trim(L.loss_state_abbr,left,right))='NULL','',STD.Str.ToUpperCase(L.loss_state_abbr));
		self.work_type_id             := if(STD.Str.ToUpperCase(trim(L.work_type_id,left,right))='NULL','',STD.Str.ToUpperCase(L.work_type_id));
		self.agency_ori               := if(STD.Str.ToUpperCase(trim(L.ori_number,left,right))='NULL','',STD.Str.ToUpperCase(L.ori_number));
		self.super_report_id_orig     := l.super_report_id;
		self:=l;
		self:=[];
	end;

	hash_key :=  normalize(hashTable, 
						                           left.hashCount, 
						                         gethash(left, counter)) ;
	
	// assign new super id accross the sources 
	
	get_new := group(sort(hash_key,orig_case_identifier,orig_state_report_number,jurisdiction,jurisdiction_state,report_type_id,accident_date,super_report_id,-Sent_to_HPCC_DateTime,-creation_date  ),orig_case_identifier,orig_state_report_number,jurisdiction,jurisdiction_state,report_type_id,accident_date);
  get_new tflag(get_new l, get_new r) := transform	
    
		self.super_report_id		                :=	if((integer)l.super_report_id  <> 0 and (integer)l.super_report_id < (integer)r.super_report_id,l.super_report_id,r.super_report_id);
    self                                    := r;
  end;
	
	export compare_add_new := iterate(get_new,tflag(left,right));
		
	end; 