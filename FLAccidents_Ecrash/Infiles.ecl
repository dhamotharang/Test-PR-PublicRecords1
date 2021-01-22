IMPORT Data_Services, STD;

EXPORT Infiles := MODULE

// ###########################################################################
//                        MBS Agency Raw File
// ###########################################################################	
  EXPORT Agency := Files_MBSAgency.DS_BASE_AGENCY;	
	SHARED AgencyInput := PROJECT(Agency, TRANSFORM(Layout_Infiles_Fixed.agency, 
                                SELF.agency_id := IF(TRIM(LEFT.agency_id, LEFT, RIGHT) <> '', LEFT.agency_id, ERROR('agency file bad')),
                                SELF := LEFT));
	
  SHARED uAgency := DEDUP(SORT(DISTRIBUTE(Agency(Agency_ID <> ''), HASH32(Agency_ID)), 
                               Agency_ID, -(Agency_Name <> ''), LOCAL), 
												  Agency_ID, LOCAL);
		
  SHARED FabAgency := PROJECT(AgencyInput, TRANSFORM(Layout_Infiles_Fixed.agency,
                                                     SELF.agency_ori := MAP(LEFT.agency_ori = '' AND TRIM(LEFT.agency_id, ALL) = '1520042' => 'GA0280000',
                                                                            LEFT.agency_ori = '' AND TRIM(LEFT.agency_id, ALL) = '1521562' => 'GA0331200',
											                                                      LEFT.agency_ori);
																			               SELF := LEFT;));

// ###########################################################################
//                        CRU Billing Agency Raw File
// ###########################################################################
  BillingAgencies_Raw := DATASET(Data_Services.foreign_prod + 'thor_data400::in::ecrash::billingagency_raw'
													      ,Layout_Infiles.billing_agencies
													      ,CSV(TERMINATOR(['\n', '\nr', '\r', '\rn']), SEPARATOR(','), QUOTE('"')), OPT)(Cru_Agency_ID <> 'cru_agency_id');
  mac_CleanFields(BillingAgencies_Raw, CleanBillingAgencies);
  ddBillingAgencies := DEDUP(CleanBillingAgencies, ALL);
  SHARED uBillingAgencies := DEDUP(SORT(DISTRIBUTE(ddBillingAgencies, HASH32(Mbsi_Agency_ID)), 
                                      Mbsi_Agency_ID, LOCAL), 
																 Mbsi_Agency_ID, LOCAL);

// ###########################################################################
//                        Commercial Raw File
// ###########################################################################														 
  Commercial_Raw := DATASET(Data_Services.foreign_prod + 'thor_data400::in::ecrash::commercl_raw'
													  ,Layout_Infiles.commercial
													  ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')))(Commercial_ID <> 'Commercial_ID');
	mac_CleanFields(Commercial_Raw, CleanCommercial);
	EXPORT Commercl := DEDUP(CleanCommercial, ALL);	

// ###########################################################################
//                        Citation Raw File
// ###########################################################################
  Citation_Raw := DATASET(Data_Services.foreign_prod + 'thor_data400::in::ecrash::citatn_raw'
											    ,Layout_Infiles.citation
												  ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')))(Citation_ID <> 'Citation_ID');
  mac_CleanFields(Citation_Raw, CleanCitation);
  EXPORT Citation := DEDUP(CleanCitation, ALL);	

// ###########################################################################
//                        Incident Raw File
// ###########################################################################	 												
	Incident_Raw := DATASET(Data_Services.foreign_prod + 'thor_data400::in::ecrash::incidnt_raw_new'
												  ,Layout_Infiles.incident_new
													,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(60000)))(incident_id <> 'Incident_ID');
  mac_CleanFields(Incident_Raw, CleanIncident);
  EXPORT Incident := DEDUP(CleanIncident, ALL);	

// ###########################################################################
//                        Person Raw File
// ###########################################################################
  Person_Raw := DATASET(Data_Services.foreign_prod + 'thor_data400::in::ecrash::persn_raw'
												,Layout_Infiles.persn_new
												,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), ESCAPE('\r'), MAXLENGTH(3000000)))(Person_ID <> 'Person_ID');
  mac_CleanFields(Person_Raw, CleanPerson);
  EXPORT Persn := DEDUP(CleanPerson, ALL);

// ###########################################################################
//                        Vehicle Raw File
// ###########################################################################	
  Vehicle_Raw := DATASET(Data_Services.foreign_prod + 'thor_data400::in::ecrash::vehicl_raw'
												 ,Layout_Infiles.vehicl_new
												 ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(50000)))(Vehicle_ID <> 'Vehicle_ID');
  mac_CleanFields(Vehicle_Raw, CleanVehicle);
  EXPORT Vehicl := DEDUP(CleanVehicle, ALL);
	
// ###########################################################################
//                        Property Damage Raw File
// ###########################################################################	
  PropertyDamage_Raw := DATASET(Data_Services.foreign_prod + 'thor_data400::in::ecrash::propertydamage_raw'
													      ,Layout_Infiles.property_damage
													      ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"'), MAXLENGTH(50000)))(Property_Damage_ID <> 'Property_Damage_ID');
  mac_CleanFields(PropertyDamage_Raw, CleanPropertyDamage);
  EXPORT Property_Damage := DEDUP(CleanPropertyDamage, ALL);

// ###########################################################################
//                        Document Raw File
// ###########################################################################
  Document_Raw := DATASET(Data_Services.foreign_prod + 'thor_data400::in::ecrash::document_raw'
								          ,Layout_Infiles.Document
								          ,CSV(HEADING(1), TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')), OPT)(Document_ID <> 'Document_ID');
  mac_CleanFields(Document_Raw, CleanDocument);
  EXPORT Document := DEDUP(CleanDocument, ALL);	

// ###########################################################################
// Suppress the DE records basing on the drivers_exchange_flag in the agency file. -- #187626
// ###########################################################################
  SHARED Suppress_Agencies := Agency(drivers_exchange_flag ='0');

// ###########################################################################
//                        Suppress Incidents File
// ###########################################################################
  EXPORT Suppress_Incidents := DATASET(Data_Services.foreign_prod + 'thor_data400::in::ecrash::suppress_tf.csv'
                                     ,Layout_Infiles_Fixed.suppress_incidents
																		 ,CSV(HEADING(1), TERMINATOR(['\n','\r\n']), SEPARATOR(','), QUOTE('"')));

// ###########################################################################
//              Get Incidents with is_delete set to 1
// ###########################################################################
  EXPORT Incidents_ToDelete := DISTRIBUTE(Incident(is_delete = '1'), HASH32(incident_id)):INDEPENDENT;
	
// ###########################################################################
//                     Prep Person File
// ###########################################################################																
  dPersn := DISTRIBUTE(Persn, HASH32(incident_id));
  jPersn := JOIN(dPersn, Incidents_ToDelete, 
								 TRIM(LEFT.incident_id, ALL)= TRIM(RIGHT.incident_id, ALL),
								 LEFT ONLY, LOCAL);
  EXPORT tPersn := PROJECT(jPersn, TRANSFORM(Layout_Infiles_Fixed.persn,
                           SELF.person_type := STD.Str.ToUpperCase(LEFT.person_type);
													 SELF := LEFT));												
	SHARED uPerson :=	DEDUP(SORT(tPersn(incident_id <> ''),
													     incident_id, vehicle_unit_number, last_name, first_name, date_of_birth, address, city, state, zip_code, home_phone, 
													     MAP(REGEXFIND('DRIVER|VEHICLE DRIVER|VEHICLEDRIVER', person_type) => 3, 
															     REGEXFIND('OWNER|VEHICLE OWNER|VEHICLEOWNER', person_type) => 2, 
																				 1), creation_date, person_id, LOCAL),
											    incident_id, vehicle_unit_number, last_name, first_name, date_of_birth, address, city, state, zip_code, home_phone, RIGHT, LOCAL);
	
// ###########################################################################
//                     Prep Vehicle File
// ###########################################################################
	dVehicl := DISTRIBUTE(Vehicl, HASH32(incident_id));														
  jVehicl := JOIN(dVehicl, Incidents_ToDelete,
								  TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id, ALL),
								  LEFT ONLY, LOCAL);
  EXPORT tVehicl := PROJECT(jVehicl, TRANSFORM(Layout_Infiles_Fixed.vehicl, SELF:= LEFT));	
	SHARED uVehicl := SORT(DEDUP(SORT(tVehicl(incident_id <> ''),
											              vin, incident_id, unit_number, creation_date, LOCAL),
									             vin, incident_id, unit_number, RIGHT, LOCAL),
								         incident_id, LOCAL);
	
// ###########################################################################
//                     Prep Property Damage File
// ###########################################################################
  dProperty_Damage := DISTRIBUTE(Property_Damage, HASH32(incident_id));
  jProperty_Damage := JOIN(dProperty_Damage, Incidents_ToDelete,
								           TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id, ALL),
								           LEFT ONLY, LOCAL);					
  SHARED tProperty := PROJECT(jProperty_Damage, TRANSFORM(Layout_Infiles_Fixed.Property_damage, SELF := LEFT));		
	
// ###########################################################################
//                     Prep Commercial File
// ###########################################################################													
  SHARED tCommercial := PROJECT(Commercl, TRANSFORM(Layout_Infiles_Fixed.commercl, SELF := LEFT));	
	SHARED uCommercial := DEDUP(SORT(DISTRIBUTE(tcommercial(vehicle_id <> ''), HASH32(vehicle_id)),
	                                 vehicle_id, creation_date, LOCAL),
															vehicle_id, RIGHT, LOCAL);
	
// ###########################################################################
//                     Prep Citation File
//                     Citations With Child Records
// ###########################################################################
  dCitation := DISTRIBUTE(Citation, HASH32(incident_id));
  jCitation := JOIN(dCitation, Incidents_ToDelete,
								    TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id, ALL),
								    LEFT ONLY, LOCAL);											
  tCitation := PROJECT(jCitation, TRANSFORM(Layout_Infiles_Fixed.citation, SELF := LEFT));
	
	gCitations := GROUP(SORT(DISTRIBUTE(tCitation(incident_id <> '' AND person_id <> ''), HASH32(incident_id)), 
											 incident_id,  person_id,  -citation_id,  LOCAL), 
									incident_id,  person_id,  LOCAL);
	Layout_Infiles_Fixed.Citations_WithChildRec doRollupCitations(gcitations L, DATASET(Layout_Infiles_Fixed.Citation) gCitations) := TRANSFORM
		SELF.Citation_Details := PROJECT(gCitations, TRANSFORM(Layout_Infiles_Fixed.Citations_ChildRec, SELF := LEFT));
		SELF := L;
	END;
	SHARED CitaionsWithChildRec := UNGROUP(ROLLUP(gCitations, GROUP, doRollupCitations(LEFT, ROWS(LEFT))));
	
// ###########################################################################
//                     Prep Incidents File
// ###########################################################################	
  dIncident := DISTRIBUTE(Incident, HASH32(incident_id));
  jIncident := JOIN(dIncident, Incidents_ToDelete,
   				          TRIM(LEFT.incident_id, ALL) = TRIM(RIGHT.incident_id, ALL),
   				          LEFT ONLY, LOCAL);
  EXPORT tIncident := PROJECT(jIncident, TRANSFORM(Layout_Infiles_Fixed.incident,
													    SELF.incident_id := LEFT.incident_id[1..9]; 
													    SELF.case_identifier := STD.Str.ToUpperCase(LEFT.case_identifier);
													    SELF.state_report_number := STD.Str.ToUpperCase(LEFT.state_report_number);
													    SELF.crash_time := IF(LEFT.incident_id IN ['10560507','10405314', '10405522','10403933','10560555','10560530']  , '', LEFT.crash_time);
													    SELF.contrib_source := LEFT.contrib_source;
													    SELF.releasable := IF(TRIM(LEFT.releasable, LEFT, RIGHT) = '',  '1', LEFT.releasable);
													    SELF.Supplemental_Report := LEFT.Supplemental_Report;
													    SELF := LEFT;));

  dIncident_EA := DISTRIBUTE(tincident(source_id NOT IN ['TF','TM'] AND work_type_id NOT IN ['2','3'] AND TRIM(vendor_code, LEFT, RIGHT) <> 'COPLOGIC'), HASH32(case_identifier));
  sIncident_EA := SORT(dIncident_EA, case_identifier, agency_id, loss_state_abbr, report_type_id, crash_date, Sent_to_HPCC_DateTime, creation_date, report_id, RECORD, LOCAL);
  uIncident_EA :=	DEDUP(sIncident_EA, case_identifier, agency_id, loss_state_abbr, report_type_id, crash_date, RIGHT, LOCAL);
  
	dIncident_EA_Coplogic := DISTRIBUTE(tIncident(source_id NOT IN ['TF','TM'] AND work_type_id NOT IN ['2','3'] AND TRIM(vendor_code, LEFT, RIGHT) = 'COPLOGIC'), HASH32(case_identifier));
	sIncident_EA_Coplogic := SORT(dIncident_EA_Coplogic, case_identifier, agency_id, loss_state_abbr, report_type_id, crash_date, Sent_to_HPCC_DateTime, creation_date, report_id, RECORD, LOCAL);
	uIncident_EA_Coplogic := DEDUP(sIncident_EA_Coplogic, case_identifier, agency_id, loss_state_abbr, report_type_id, crash_date, supplemental_report, RIGHT, LOCAL);
	
  dIncident_EA_CRU := DISTRIBUTE(tIncident(work_type_id IN ['2','3']), HASH32(case_identifier));
  sIncident_EA_CRU := SORT(dIncident_EA_CRU, case_identifier, agency_id, loss_state_abbr, work_type_id, report_type_id, cru_order_id, Sent_to_HPCC_DateTime, creation_date, CRU_Sequence_Nbr, report_id, RECORD, LOCAL);
  uIncident_EA_CRU := DEDUP(sincident_EA_CRU, case_identifier, agency_id, loss_state_abbr, work_type_id, report_type_id, cru_order_id, RIGHT, LOCAL); 

  dincident_TF := DISTRIBUTE(tincident(source_id IN ['TM','TF']), HASH32(state_report_number));
  sIncident_TF := SORT(dIncident_TF, state_report_number, agency_id, ORI_Number, loss_state_abbr, work_type_id, report_type_id, source_id, Sent_to_HPCC_DateTime, creation_date, report_id, RECORD, LOCAL);
  uIncident_TF := DEDUP(sIncident_TF, state_report_number, agency_id, ORI_Number, loss_state_abbr, work_type_id, report_type_id, source_id, RIGHT, LOCAL);

  IncidentCombined := uIncident_EA + uIncident_EA_Coplogic + uIncident_EA_CRU	+ uIncident_TF;

// #############################################################################################
//                  Join MBS Agency & Incident
// #############################################################################################						
	Layout_Infiles_Fixed.incident_ori tIncAgency(IncidentCombined L, FabAgency R) := TRANSFORM
		SELF.agency_name := IF(L.agency_id = R.agency_id, R.Agency_Name, '');
		SELF.agency_ori := IF(L.agency_id = R.agency_id, R.Agency_Ori, '');
		SELF := L;
		SELF := [];
	END;
	jInc_Agency := JOIN(IncidentCombined, FabAgency, 
								      LEFT.agency_id = RIGHT.agency_id, 
								      tIncAgency(LEFT, RIGHT), LEFT OUTER, LOOKUP);
  dInc_Agency := DISTRIBUTE(jInc_Agency, HASH32(incident_id)):INDEPENDENT;
	
// #############################################################################################
//                  Join Combined Agency Incident with Vehicle
// #############################################################################################							
	Layout_Infiles_Fixed.cmbnd  tIncAgencyVeh(dInc_Agency L,  tVehicl R) := TRANSFORM
		SELF.incident_id := L.incident_id;
		SELF.agency_id := L.agency_id;
		SELF.agency_name := L.agency_name;
		SELF.agency_ori := L.agency_ori;
		SELF.creation_date := L.creation_date;
		SELF.Avoidance_Maneuver2 := R.Avoidance_Maneuver2;
		SELF.Avoidance_Maneuver3 := R.Avoidance_Maneuver3;
		SELF.Avoidance_Maneuver4 := R.Avoidance_Maneuver4;
		SELF.Damaged_Areas_Severity1 := R.Damaged_Areas_Severity1;
		SELF.Damaged_Areas_Severity2 := R.Damaged_Areas_Severity2;
		SELF.Vehicle_Outside_City_Indicator := R.Vehicle_Outside_City_Indicator;
		SELF.Vehicle_Outside_City_Distance_Miles := R.Vehicle_Outside_City_Distance_Miles;
		SELF.Vehicle_Outside_City_Direction := R.Vehicle_Outside_City_Direction;
		SELF.Vehicle_Crash_Cityplace := R.Vehicle_Crash_Cityplace;
		SELF.Insurance_Company_Standardized := R.Insurance_Company_Standardized;
		SELF.number_of_lanes := IF(L.number_of_lanes <> '', L.number_of_lanes,  R.number_of_lanes); 
		SELF.divided_highway := IF(L.divided_highway <> '', L.divided_highway,  R.divided_highway);
		SELF.speed_limit_posted := IF(L.speed_limit_posted <> '', L.speed_limit_posted,  R.speed_limit_posted);
		SELF.posted_satutory_speed_limit := IF(L.posted_satutory_speed_limit <> '', L.posted_satutory_speed_limit,  R.posted_satutory_speed_limit);
		SELF.report_road_condition := IF(L.report_road_condition <> '', L.report_road_condition,  R.report_road_condition);
		SELF := R;
		SELF := L;
		SELF := [];
	END;
	jIncAgency_Veh := JOIN(dInc_Agency, uVehicl,
								         LEFT.incident_id = RIGHT.incident_id, 
								         tIncAgencyVeh(LEFT, RIGHT), LEFT OUTER, LOCAL);

// #############################################################################################
//                  Join Combined Agency Incident Vehicle with Person
// #############################################################################################
	Layout_Infiles_Fixed.cmbnd  tIncAgencyVehPerson(jIncAgency_Veh L,  tPersn R) := TRANSFORM
		SELF.incident_id := L.incident_id;
		SELF.agency_id := L.agency_id;
		SELF.agency_name := L.agency_name;
		SELF.agency_ori := L.agency_ori;
		SELF.creation_date := L.creation_date;
		SELF.law_enforcement_suspects_alcohol_use1 := R.law_enforcement_suspects_alcohol_use1;
		SELF.law_enforcement_suspects_drug_use1 := R.law_enforcement_suspects_drug_use1;
		SELF.First_Aid_By := L.First_Aid_By; 
		SELF.Person_First_Aid_Party_Type := L.Person_First_Aid_Party_Type; 
		SELF.Person_First_Aid_Party_Type_Description := L.Person_First_Aid_Party_Type_Description;
		SELF.Insurance_Expiration_Date := L.Insurance_Expiration_Date;
		SELF.Insurance_Policy_Number := L.Insurance_Policy_Number;
		SELF.Insurance_Company := L.Insurance_Company;
		SELF.Insurance_Company_Phone_Number := L.Insurance_Company_Phone_Number; 
		SELF.Insurance_Effective_Date := L.Insurance_Effective_Date;
		SELF.Proof_of_Insurance := L.Proof_of_Insurance; 
		SELF.Insurance_Expired := L.Insurance_Expired; 
		SELF.Insurance_Exempt := L.Insurance_Exempt; 
		SELF.Insurance_Type := L.Insurance_Type; 
		SELF.Insurance_Company_Code := L.Insurance_Company_Code; 
		SELF.Address2 := STD.str.CleanSpaces(TRIM(L.Address2, LEFT, RIGHT));
		SELF := R;
		SELF := L;
		SELF := [];
	END;
	jIncAgencyVeh_Person := JOIN(jIncAgency_Veh(Unit_Number <> '0' AND Unit_Number <> ''), uPerson,
															 LEFT.incident_id = RIGHT.incident_id AND 
															 (UNSIGNED)LEFT.Unit_Number = (UNSIGNED)RIGHT.vehicle_Unit_Number,
															 tIncAgencyVehPerson(LEFT, RIGHT), LEFT OUTER, LOCAL);
															 
	// get person records by only incident_id when no vehcile records found 
	jIncAgencyVeh_OtherPerson := JOIN(jIncAgency_Veh(Unit_Number = '0' OR Unit_Number = ''), uPerson,
															      LEFT.incident_id = RIGHT.incident_id , 
															      tIncAgencyVehPerson(LEFT, RIGHT), LEFT OUTER, LOCAL);
																		
	//get person record that have 0 vehicle or IF one or more recs IN same incident have veh//like witness ,  property owner etc..
	jIncAgency_Person := JOIN(dInc_Agency, uPerson( vehicle_Unit_Number IN ['','0','NUL']),
														LEFT.incident_id = RIGHT.incident_id ,
														TRANSFORM(Layout_Infiles_Fixed.cmbnd, SELF := LEFT, SELF:= RIGHT, SELF := []), LOCAL);		

	IncAgencyVehPerson := DEDUP(SORT(jIncAgencyVeh_Person + jIncAgencyVeh_OtherPerson + jIncAgency_Person, RECORD, LOCAL), RECORD, LOCAL);

// #############################################################################################
//                  Join Combined Agency Incident Vehicle Person with Commercial
// #############################################################################################
	dIncAgencyVehPerson := DISTRIBUTE(IncAgencyVehPerson, HASH32(vehicle_id));
	
	Layout_Infiles_Fixed.cmbnd  tIncAgencyVehPersnComm(IncAgencyVehPerson L, tcommercial R) := TRANSFORM
		SELF.incident_id := L.incident_id;
		SELF.agency_id := L.agency_id;
		SELF.agency_name := L.agency_name;
		SELF.agency_ori := L.agency_ori;
		SELF.vehicle_id := L.vehicle_id;
		SELF.creation_date := L.creation_date;
		SELF := R;
		SELF := L;
		SELF := [];
	END;
	jIncAgencyVehPersn_Comm := JOIN(dIncAgencyVehPerson, uCommercial,
								                  LEFT.vehicle_id = RIGHT.vehicle_id,
								                  tIncAgencyVehPersnComm(LEFT, RIGHT), LEFT OUTER, LOCAL);

// #############################################################################################
//               Join Combined Agency Incident Vehicle Person Commercial with Citations
// #############################################################################################
	dIncAgencyVehPersnComm := DISTRIBUTE(jIncAgencyVehPersn_Comm, HASH32(incident_id));
	
	Layout_Infiles_Fixed.cmbnd  tIncAgencyVehPersnCommCitn(jIncAgencyVehPersn_Comm L, CitaionsWithChildRec R) := TRANSFORM
		SELF.incident_id := L.incident_id;
		SELF.agency_id := L.agency_id;
		SELF.agency_name := L.agency_name;
		SELF.agency_ori := L.agency_ori;
		SELF.creation_date := L.creation_date;
		SELF.person_id := L.person_id; 
		SELF := R;
		SELF := L;
	END;
	jIncAgencyVehPersnComm_Citn := JOIN(dIncAgencyVehPersnComm, CitaionsWithChildRec,
								                      LEFT.incident_id = RIGHT.incident_id AND
								                      LEFT.person_id = RIGHT.person_id, 
								                      tIncAgencyVehPersnCommCitn(LEFT, RIGHT), LEFT OUTER, LOCAL);

// #############################################################################################
//     Join Combined Agency Incident with Property
// #############################################################################################
	Layout_Infiles_Fixed.cmbnd  jIncAgencyProp(dInc_Agency L, tProperty R) := TRANSFORM
		SELF.incident_id := L.incident_id;
		SELF.person_type := 'PROPERTY OWNER'; 
		SELF.damage_description := R.damage_description;
		SELF.damage_estimate := R.damage_estimate;
		SELF.Last_Name := IF(TRIM(R.property_owner_name, LEFT, RIGHT) = '', R.property_owner_last_name, '');
		SELF.First_Name := IF(TRIM(R.property_owner_name, LEFT, RIGHT) = '', R.property_owner_first_name, R.property_owner_name); 
		SELF.Middle_Name := IF(TRIM(R.property_owner_name, LEFT, RIGHT) = '', R.property_owner_middle_name, ''); 
		SELF.Address := R.property_owner_address;
		SELF.City := R.property_owner_city;
		SELF.State := R.property_owner_state;
		SELF.Zip_Code := R.property_owner_zip_code;
		SELF.Home_Phone := R.property_owner_phone;
		SELF.property_owner_notified := IF(L.property_owner_notified <> '', L.property_owner_notified, R.property_owner_notified); 
		SELF.property_damage_id := R.property_damage_id;
		SELF := L;
		SELF := [];
	END;
	jIncAgency_Prop := JOIN(dInc_Agency, tProperty(incident_id <> ''),
								          LEFT.incident_id = RIGHT.incident_id,
								          jIncAgencyProp(LEFT, RIGHT), LOCAL);

// #############################################################################################
//     Combine all : Agency Incident Vehicle Person Commercial Citation & Property
// #############################################################################################
	Combined := jIncAgencyVehPersnComm_Citn + jIncAgency_Prop; 
	Combined_DropSuppress := JOIN(Combined, Suppress_Agencies(agency_id <> ''),
												        TRIM(LEFT.agency_id, LEFT, RIGHT) = TRIM(RIGHT.agency_id, LEFT, RIGHT) AND 
																TRIM(LEFT.report_type_id, LEFT, RIGHT) = 'DE',
												        MANY LOOKUP, LEFT ONLY );

	macRemoveNulls(Combined_DropSuppress, CleanCombinedAll);
	EXPORT eCrashCmbnd := DEDUP(SORT(CleanCombinedAll, RECORD, LOCAL), RECORD, LOCAL)(TRIM(agency_id, LEFT, RIGHT) NOT IN ['5','6','7']):PERSIST('~thor_data400::persist::ecrash_cmbnd');

// #############################################################################################
//  Combine MBS Agency & MBSI Billing Agency 
//  Agency cmbnd file for Agency key in Buycrash KY Integration
// #############################################################################################
	Layouts.agency_cmbnd tAgencyCombined(uAgency L, uBillingAgencies R) := TRANSFORM
    SELF.Agency_ori := L.Agency_ori;
    SELF.Agency_State_abbr := STD.Str.ToUpperCase(TRIM(L.Agency_State_abbr, LEFT, RIGHT));
    SELF.Agency_Name := STD.Str.ToUpperCase(TRIM(L.Agency_Name, LEFT, RIGHT));
    SELF.Mbsi_Agency_ID := L.Agency_ID;
    SELF.Cru_Agency_ID := R.Cru_Agency_ID;
    SELF.Cru_State_Number := (UNSIGNED3)R.Cru_State_Number;
    SELF.Source_ID := L.Source_ID;
    SELF.Append_Overwrite_Flag := L.Append_Overwrite_Flag;
    SELF := [];
  END;
	EXPORT AgencyCmbnd := JOIN(uAgency, uBillingAgencies,
	                           LEFT.Agency_ID = RIGHT.Mbsi_Agency_ID,
														 tAgencyCombined(LEFT, RIGHT), LEFT OUTER, LOCAL);
															 
END;