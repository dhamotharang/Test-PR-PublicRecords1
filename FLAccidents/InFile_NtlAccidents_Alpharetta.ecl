IMPORT Data_Services, STD;

EXPORT InFile_NtlAccidents_Alpharetta := MODULE

// ###########################################################################
//                        Client Raw File
// ########################################################################### 
  Client_Raw := DATASET(Data_Services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::client_new'
										   ,Layout_NtlAccidents_Alpharetta.client
										   ,CSV(TERMINATOR('\n'), SEPARATOR(',')))(ACCT_NBR != 'ACCT_NBR');
  mac_CleanFields(Client_Raw, CleanClient);
	dClient := DEDUP(CleanClient, ALL);
	EXPORT Client := DEDUP(SORT(DISTRIBUTE(dClient, HASH32(acct_nbr,client_id))
	                            ,acct_nbr, client_id,(last_changed[7..10] + last_changed[1..2] + last_changed[4..5]), LOCAL)
												 ,acct_nbr, client_id, RIGHT, LOCAL);
											 
// ###########################################################################
//                        Incident Raw File
// ########################################################################### 
  Incident_Raw := DATASET(Data_Services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::vehicle_incident_new'
										     ,Layout_NtlAccidents_Alpharetta.incident
										     ,CSV(TERMINATOR('\n'), SEPARATOR(',')))(VEHICLE_INCIDENT_ID != 'VEHICLE_INCIDENT_ID');
  mac_CleanFields(Incident_Raw, CleanIncident);
	EXPORT Incident := DEDUP(CleanIncident, ALL);

// ###########################################################################
//                        Internet Order Raw File
// ########################################################################### 
  IntOrder_Raw := DATASET(Data_Services.foreign_prod +'thor_data400::in::flcrash::alpharetta::int_order_new'
										     ,Layout_NtlAccidents_Alpharetta.int_order
										     ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')))(ORDER_ID  != 'ORDER_ID');
  mac_CleanFields(IntOrder_Raw, CleanIntOrder);
	EXPORT Int_Order := DEDUP(CleanIntOrder, ALL);

// ###########################################################################
//                        Party Raw File
// ########################################################################### 
  Party_Raw := DATASET(Data_Services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::vehicle_party_new'
										  ,Layout_NtlAccidents_Alpharetta.party
										  ,CSV(TERMINATOR('\n'), SEPARATOR(',')))(PARTY_ID != 'PARTY_ID');
  mac_CleanFields(Party_Raw, CleanParty);
	dParty := DEDUP(CleanParty, ALL);
	EXPORT Party := DEDUP(SORT(dParty, party_id, -(last_changed[7..10] + last_changed[1..2] + last_changed[4..5]))
	                      ,party_id);
												
// ###########################################################################
//                        Order Raw File
// ########################################################################### 
  Order_Raw := DATASET(Data_Services.foreign_prod +'thor_data400::in::flcrash::alpharetta::order_version_new'
										  ,Layout_NtlAccidents_Alpharetta.order_vs
										  ,CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')))(ORDER_ID  != 'ORDER_ID'); 
  mac_CleanFields(Order_Raw, CleanOrder);
	dOrder := DEDUP(CleanOrder, ALL);
	EXPORT Order := DEDUP(SORT(DISTRIBUTE(dOrder, HASH32(order_id))
	                           ,order_id, sequence_nbr, (checkin_date[7..10] + checkin_date[1..2] + checkin_date[4..5]), (last_changed[7..10] + last_changed[1..2] + last_changed[4..5]),LOCAL)
												,order_id, RIGHT, LOCAL);											
												
// ###########################################################################
//                        Result Raw File
// ########################################################################### 
  Result_Raw := DATASET(Data_Services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::result_new'
									     ,Layout_NtlAccidents_Alpharetta.result
									     ,CSV(TERMINATOR('\n'), SEPARATOR(',')))(RESULT_ID != 'RESULT_ID');
	mac_CleanFields(Result_Raw, CleanResult);
	EXPORT Result := DEDUP(CleanResult, ALL);
												
// ###########################################################################
//                        Vehicles Raw File
// ########################################################################### 
  Vehicles_In := DATASET(Data_Services.foreign_prod +'thor_data400::in::flcrash::alpharetta::vehicle_new'
										    ,Layout_NtlAccidents_Alpharetta.payload
										    ,CSV(TERMINATOR('\n'), SEPARATOR(''), QUOTE('')));
  Layout_NtlAccidents_Alpharetta.vehicles parserecs(vehicles_in L) := TRANSFORM
		STRING unparsedRec := REGEXREPLACE('"',REGEXREPLACE(',"',REGEXREPLACE('","',L.line+'|','|'),'|'),'');							
		SELF.VEHICLE_ID := unparsedRec[1..Std.Str.Find(unparsedRec,'|',1)-1];						
		SELF.VEHICLE_INCIDENT_ID := unparsedRec[Std.Str.Find(unparsedRec,'|',1)+1..Std.Str.Find(unparsedRec,'|',2)-1];						
		SELF.VEHICLE_NBR := unparsedRec[Std.Str.Find(unparsedRec,'|',2)+1..Std.Str.Find(unparsedRec,'|',3)-1];						
		SELF.VEHICLE_STATUS := unparsedRec[Std.Str.Find(unparsedRec,'|',3)+1..Std.Str.Find(unparsedRec,'|',4)-1];						
		SELF.vehVIN := unparsedRec[Std.Str.Find(unparsedRec,'|',4)+1..Std.Str.Find(unparsedRec,'|',5)-1];
		SELF.vehYEAR := unparsedRec[Std.Str.Find(unparsedRec,'|',5)+1..Std.Str.Find(unparsedRec,'|',6)-1];
		SELF.vehMAKE := unparsedRec[Std.Str.Find(unparsedRec,'|',6)+1..Std.Str.Find(unparsedRec,'|',7)-1];
		SELF.vehMODEL := unparsedRec[Std.Str.Find(unparsedRec,'|',7)+1..Std.Str.Find(unparsedRec,'|',8)-1];
		SELF.ODOMETER	:= unparsedRec[Std.Str.Find(unparsedRec,'|',8)+1..Std.Str.Find(unparsedRec,'|',9)-1];
		SELF.TAG := unparsedRec[Std.Str.Find(unparsedRec,'|',9)+1..Std.Str.Find(unparsedRec,'|',10)-1];
		SELF.TAG_STATE := unparsedRec[Std.Str.Find(unparsedRec,'|',10)+1..Std.Str.Find(unparsedRec,'|',11)-1];
		SELF.COLOR := unparsedRec[Std.Str.Find(unparsedRec,'|',11)+1..Std.Str.Find(unparsedRec,'|',12)-1];
		SELF.IMPACT_LOCATION := unparsedRec[Std.Str.Find(unparsedRec,'|',12)+1..Std.Str.Find(unparsedRec,'|',13)-1];
		SELF.POLICY_NBR := unparsedRec[Std.Str.Find(unparsedRec,'|',13)+1..Std.Str.Find(unparsedRec,'|',14)-1];
		SELF.POLICY_EXP_DATE := unparsedRec[Std.Str.Find(unparsedRec,'|',14)+1..Std.Str.Find(unparsedRec,'|',15)-1];
		SELF.CARRIER_ID := unparsedRec[Std.Str.Find(unparsedRec,'|',15)+1..Std.Str.Find(unparsedRec,'|',16)-1];
		SELF.OTHER_CARRIER := unparsedRec[Std.Str.Find(unparsedRec,'|',16)+1..Std.Str.Find(unparsedRec,'|',17)-1];
		SELF.COMMERCIAL_VIN := unparsedRec[Std.Str.Find(unparsedRec,'|',17)+1..Std.Str.Find(unparsedRec,'|',18)-1];					
		SELF.CAR_FIRE := unparsedRec[Std.Str.Find(unparsedRec,'|',18)+1..Std.Str.Find(unparsedRec,'|',19)-1];						
		SELF.AIRBAGS_DEPLOY := unparsedRec[Std.Str.Find(unparsedRec,'|',19)+1..Std.Str.Find(unparsedRec,'|',20)-1];						
		SELF.CAR_TOWED := unparsedRec[Std.Str.Find(unparsedRec,'|',20)+1..Std.Str.Find(unparsedRec,'|',21)-1];						
		SELF.CAR_ROLLOVER := unparsedRec[Std.Str.Find(unparsedRec,'|',21)+1..Std.Str.Find(unparsedRec,'|',22)-1];
		SELF.DECODED_INFO := unparsedRec[Std.Str.Find(unparsedRec,'|',22)+1..Std.Str.Find(unparsedRec,'|',23)-1];
		SELF.LAST_CHANGED	:= unparsedRec[Std.Str.Find(unparsedRec,'|',23)+1..Std.Str.Find(unparsedRec,'|',24)-1];
		SELF.USERID	:= unparsedRec[Std.Str.Find(unparsedRec,'|',24)+1..Std.Str.Find(unparsedRec,'|',25)-1];
		SELF.DAMAGE	:= unparsedRec[Std.Str.Find(unparsedRec,'|',25)+1..Std.Str.Find(unparsedRec,'|',26)-1];
		SELF.POLK_VALIDATED_VIN	:= unparsedRec[Std.Str.Find(unparsedRec,'|',26)+1..Std.Str.Find(unparsedRec,'|',27)-1];
		SELF := L;
  END;
  pVehicles := PROJECT(vehicles_in(REGEXFIND('[0-9]',line)), parserecs(LEFT));
  mac_CleanFields(pVehicles, CleanVehicles);
  dVehicles := DEDUP(CleanVehicles, ALL);
  EXPORT Vehicles := DEDUP(SORT(dVehicles, vehicle_id , -(last_changed[7..10] + last_changed[1..2] + last_changed[4..5]))
                           ,vehicle_id ); 
												
// ###########################################################################
//                        Vehicles Raw File
// ########################################################################### 
  Insurance_Raw := DATASET(Data_Services.foreign_prod + 'thor_data400::in::flcrash::alpharetta::vehicle_insurance_carrier_new'
										      ,Layout_NtlAccidents_Alpharetta.insurance
										      ,CSV(TERMINATOR('\n'), SEPARATOR(',')))(CARRIER_ID  != 'INS_CARRIER_ID ');
  mac_CleanFields(Insurance_Raw, CleanInsurance);
	EXPORT Insurance := DEDUP(CleanInsurance, ALL);
										
// ###########################################################################
//                        Prep Order Combined File Combine order_version and int_order.  
//                        int_order recs are client requests from the web.
// ########################################################################### 
  Layout_NtlAccidents_Alpharetta.order_combined tOrderCombined(order L) := TRANSFORM
   SELF := L;
   SELF :=[];
  END;
  pOrderCombined := PROJECT(order,tOrderCombined(LEFT));
  
	Layout_NtlAccidents_Alpharetta.order_combined tIntOrderCombined(int_order L) := TRANSFORM
   SELF := L;
   SELF :=[];
  END;
  pIntOrderCombined := PROJECT(int_order,tIntOrderCombined(LEFT));

  cmbnd_order := pIntOrderCombined + pOrderCombined;
  SHARED ucmbnd_order := DEDUP(SORT(DISTRIBUTE(cmbnd_order, HASH32(order_id))
	                                 ,order_id, sequence_nbr, LOCAL)
															 ,order_id, RIGHT, LOCAL);
												
// ###########################################################################
//                        Prep Result File
// ########################################################################### 
  SHARED uresult := DEDUP(SORT(DISTRIBUTE(result(order_id<>''), HASH32(order_id))
	                             ,order_id, sequence_nbr, (last_changed[7..10] + last_changed[1..2] + last_changed[4..5]), LOCAL)
													,order_id, RIGHT, LOCAL); 
 															 
// ###########################################################################
//                        Prep Incident File
// ########################################################################### 
  SHARED uincident := DEDUP(SORT(DISTRIBUTE(incident(order_id<>''), HASH32(order_id))
	                               ,order_id, sequence_nbr, (last_changed[7..10] + last_changed[1..2] + last_changed[4..5]), LOCAL)
														,order_id, RIGHT, LOCAL); 
  
// #############################################################################################
//                  Join Orders Combined with Result
// #############################################################################################
  Layout_NtlAccidents_Alpharetta.cmbnd tOrderCmbndResult(ucmbnd_order L, uresult R) := TRANSFORM
    lLast_changed := IF(TRIM(L.checkin_date, LEFT, RIGHT) <>'', TRIM(L.checkin_date, LEFT, RIGHT)[7..10] + TRIM(L.checkin_date, LEFT, RIGHT)[1..2] + TRIM(L.checkin_date, LEFT, RIGHT)[4..5], 
                        TRIM(L.last_changed, LEFT, RIGHT)[7..10] + TRIM(L.last_changed, LEFT, RIGHT)[1..2] + TRIM(L.last_changed, LEFT, RIGHT)[4..5]);
    rLast_changed := TRIM(R.last_changed, LEFT, RIGHT)[7..10] + TRIM(R.last_changed, LEFT, RIGHT)[1..2] + TRIM(R.last_changed, LEFT, RIGHT)[4..5];
    SELF.last_changed := MAP(L.order_id = R.order_id AND (UNSIGNED)lLast_changed < (UNSIGNED)rLast_changed => rLast_changed, lLast_changed);
    SELF := L;
    SELF := R;
    SELF :=[];
  END;
	/*Excerpt from Requirements:				
	2.1.1.1	Order Sequences
	Order data exists in CRUP1.Order_Version which is a database of order data received from client requests.  
	The volume of data is more difficult to understand because of our workflow process.  
	When an order is received, the data is stored as sequence 1.  
	Any time the order is rerouted (reprocessed and sent out again) a new sequence is assigned to the order. 
	An order may have up to 9 sequences.  For example, if you look at the distinct total orders in the production database,
	there are 7,655,965 orders.  If you add in the sequence numbers it brings the total volume of 13,431,202.  Each sequence is a 
	version of the original data that gets re-ordered with the same basic data.  The reason the description of the data is included in 
	this document is that we need to ensure if the keyed data is used, the definition of the data is fully understood.  
	Sequences of a single order id should NOT be reported as multiple occurrences.  
	*/
	SHARED jOrderCmbndResult := JOIN(ucmbnd_order, uresult,
                                   LEFT.order_id = RIGHT.order_id,
			                             tOrderCmbndResult(LEFT,RIGHT), LEFT OUTER, LOCAL);
			   
// #############################################################################################
//                  Join Orders Combined Result with Incident
// #############################################################################################
  Layout_NtlAccidents_Alpharetta.cmbnd tOrderCmbndResultInc(jOrderCmbndResult L, uincident R) := TRANSFORM
    lLast_changed := TRIM(L.last_changed, LEFT, RIGHT);
    rLast_changed := TRIM(R.last_changed, LEFT, RIGHT)[7..10] + TRIM(R.last_changed, LEFT, RIGHT)[1..2] + TRIM(R.last_changed, LEFT, RIGHT)[4..5];
    SELF.order_id := L.order_id;
		SELF.sequence_nbr := L.sequence_nbr;
		SELF.creation_date := L.creation_date;
		SELF.service_id := MAP(L.order_id = R.order_id  AND L.service_id = '' => R.service_id, L.service_id);
		SELF.loss_date := MAP(L.order_id = R.order_id  AND L.loss_date <> '' => R.loss_date, L.loss_date);
		SELF.loss_time := MAP(L.order_id = R.order_id  AND L.loss_time <> '' => R.loss_time, L.loss_time);
		SELF.report_nbr := MAP(L.order_id = R.order_id  AND L.report_nbr = '' => R.report_nbr, L.report_nbr);
		//keeping the latest last change date
		SELF.last_changed := MAP(L.order_id = R.order_id AND (UNSIGNED)lLast_changed < (UNSIGNED)rLast_changed => rLast_changed, lLast_changed);
    SELF := R;
		SELF := L;
		SELF :=[];
	END;

  SHARED jOrderCmbndResultInc := JOIN(jOrderCmbndResult, uincident,
	                                    LEFT.order_id = RIGHT.order_id,
			                                tOrderCmbndResultInc(LEFT,RIGHT), LEFT OUTER, LOCAL);
			   
// #############################################################################################
//                  Join Orders Combined Result Incident with Vehicles
// #############################################################################################
  dvehicles := DISTRIBUTE(vehicles(vehicle_incident_id<>''), HASH32(vehicle_incident_id));
	dOrderCmbndResultInc := DISTRIBUTE(jOrderCmbndResultInc, HASH32(vehicle_incident_id));
	
  Layout_NtlAccidents_Alpharetta.cmbnd tOrderCmbndResultIncVeh(jOrderCmbndResultInc L, dvehicles R) := TRANSFORM
    lLast_changed := TRIM(L.last_changed, LEFT, RIGHT);
    rLast_changed := TRIM(R.last_changed, LEFT, RIGHT)[7..10] + TRIM(R.last_changed, LEFT, RIGHT)[1..2] + TRIM(R.last_changed, LEFT, RIGHT)[4..5];
		SELF.vehicle_incident_id 	:= L.vehicle_incident_id;
    SELF.last_changed := MAP(L.vehicle_incident_id = R.vehicle_incident_id AND (UNSIGNED)lLast_changed < (unsigned)rLast_changed
							               => rLast_changed,lLast_changed);
    SELF.userid := MAP(L.vehicle_incident_id = R.vehicle_incident_id AND (UNSIGNED)lLast_changed > (UNSIGNED)rLast_changed => L.userid, R.userid);
    SELF.vehvin := MAP(L.vehicle_incident_id = R.vehicle_incident_id => R.vehvin, L.vehvin);
    SELF.vehyear := MAP(L.vehicle_incident_id = R.vehicle_incident_id => R.vehyear, L.vehyear);
    SELF.vehmake := MAP(L.vehicle_incident_id = R.vehicle_incident_id => R.vehmake, L.vehmake);
    SELF.vehmodel := MAP(L.vehicle_incident_id = R.vehicle_incident_id => R.vehmodel, L.vehmodel);
    SELF.vehicle_status := MAP(L.vehicle_incident_id = R.vehicle_incident_id => R.vehicle_status, L.vehicle_status);
    SELF.impact_location := MAP(L.vehicle_incident_id = R.vehicle_incident_id => R.impact_location, L.impact_location);						 
    SELF.tag := MAP(L.vehicle_incident_id = R.vehicle_incident_id => L.tag, '');
    SELF.tag_state := MAP(L.vehicle_incident_id = R.vehicle_incident_id => L.tag_state, '');
   	SELF := R;
		SELF := L;
		SELF :=[];
	END;
  SHARED jOrderCmbndResultIncVeh := JOIN(dOrderCmbndResultInc, dvehicles,
			                                   LEFT.vehicle_incident_id = RIGHT.vehicle_incident_id,
			                                   tOrderCmbndResultIncVeh(LEFT, RIGHT), LEFT OUTER, LOCAL);
																	
// #############################################################################################
//                  Join Orders Combined Result Incident Vehicles with Party
// #############################################################################################
  sparty := SORT(DISTRIBUTE(party(vehicle_incident_id<>''), HASH32(vehicle_incident_id, vehicle_id))
	               ,vehicle_incident_id, vehicle_id, last_name, first_name, LOCAL);
	sOrderCmbndResultIncVeh := SORT(DISTRIBUTE(jOrderCmbndResultIncVeh(vehicle_incident_id<>''),HASH32(vehicle_incident_id, vehicle_id))
	                               ,vehicle_incident_id, vehicle_id, last_name_1, first_name_1, LOCAL);
  
	Layout_NtlAccidents_Alpharetta.cmbnd tOrderCmbndResultIncVehParty(sOrderCmbndResultIncVeh L, sparty R) := TRANSFORM
   lLast_changed := TRIM(L.last_changed, LEFT, RIGHT);
   rLast_changed := TRIM(R.last_changed, LEFT, RIGHT)[7..10] + TRIM(R.last_changed, LEFT, RIGHT)[1..2] + TRIM(R.last_changed, LEFT, RIGHT)[4..5];
   SELF.vehicle_incident_id := L.vehicle_incident_id;
   SELF.last_changed := MAP(L.vehicle_incident_id = R.vehicle_incident_id AND L.vehicle_id = R.vehicle_id 
									          AND (UNSIGNED)lLast_changed < (UNSIGNED)rLast_changed => rLast_changed, lLast_changed);
   SELF.userid := MAP(L.vehicle_incident_id = R.vehicle_incident_id AND L.vehicle_id = R.vehicle_id 
							        AND (UNSIGNED)lLast_changed > (UNSIGNED)rLast_changed => L.userid, R.userid);
   SELF.pty_drivers_license := MAP(L.vehicle_incident_id = R.vehicle_incident_id AND L.vehicle_id = R.vehicle_id => R.pty_drivers_license, '');						
   SELF.pty_drivers_license_st := MAP(L.vehicle_incident_id = R.vehicle_incident_id AND L.vehicle_id = R.vehicle_id => R.pty_drivers_license_st, '');
   dob := MAP(L.vehicle_incident_id = R.vehicle_incident_id AND L.vehicle_id = R.vehicle_id => R.dob, '');
	 SELF.dob := dob[7..10] + dob[1..2] + dob[4..5];
	 // Populate Inquiry fields, these fields contain data pulled from the order version table and must be labeled accordingly
   ssn := IF((UNSIGNED)L.ssn_1 =0, '', L.ssn_1);
   SELF.inquiry_ssn := MAP(L.vehicle_incident_id = R.vehicle_incident_id
												   AND L.vehicle_id = R.vehicle_id
												   AND R.LAST_NAME + R.FIRST_NAME = L.LAST_NAME_1 + L.FIRST_NAME_1
												   => ssn, '');
   SELF.inquiry_dob := IF(R.LAST_NAME + R.FIRST_NAME = L.LAST_NAME_1 + L.FIRST_NAME_1, L.dob_1[7..10] + L.dob_1[1..2] + L.dob_1[4..5], '');
   SELF := R;
   SELF := L;
   SELF := [];
  END;
  SHARED jOrderCmbndResultIncVehParty := JOIN(sOrderCmbndResultIncVeh, sparty,
                                              LEFT.vehicle_incident_id = RIGHT.vehicle_incident_id AND
					                                    LEFT.vehicle_id = RIGHT.vehicle_id, 
			                                        tOrderCmbndResultIncVehParty(LEFT, RIGHT), LEFT OUTER, LOCAL);
																	
// #############################################################################################
//                  Join Orders Combined Result Incident Vehicles Party with Insurance
// #############################################################################################
  Layout_NtlAccidents_Alpharetta.cmbnd tOrderCmbndResultIncVehPartyIns(jOrderCmbndResultIncVehParty L, insurance R) := TRANSFORM
	lLast_changed := TRIM(L.last_changed, LEFT, RIGHT);
	rLast_changed := TRIM(R.last_changed, LEFT, RIGHT)[7..10] + TRIM(R.last_changed, LEFT, RIGHT)[1..2] + TRIM(R.last_changed, LEFT, RIGHT)[4..5];
  self.carrier_id := L.carrier_id;
	self.carrier_name := IF(L.carrier_id = R.carrier_id, R.carrier_name, L.carrier_name);
	self.last_changed := MAP(L.carrier_id = R.carrier_id AND (UNSIGNED)lLast_changed < (UNSIGNED)rLast_changed => rLast_changed, lLast_changed);
	self.userid := MAP(L.carrier_id= R.carrier_id AND (UNSIGNED)lLast_changed > (UNSIGNED)rLast_changed => L.userid, R.userid);
  SELF := R;
	SELF := L;
 END;
 SHARED jOrderCmbndResultIncVehPartyIns:= JOIN(jOrderCmbndResultIncVehParty, insurance,
			                                         LEFT.carrier_id = RIGHT.carrier_id,
			                                         tOrderCmbndResultIncVehPartyIns(LEFT,RIGHT), LEFT OUTER, LOOKUP):PERSIST('~thor_data400::persist::Accidents_Alpharetta.cmbnd');
																	
// ###################################################################################################
//                  Join Orders Combined Result Incident Vehicles Party Insurance with Cient
// ###################################################################################################
  dclient := DISTRIBUTE(client, HASH32(acct_nbr,client_id));
  dOrderCmbndResultIncVehPartyIns := DISTRIBUTE(jOrderCmbndResultIncVehPartyIns, HASH32(acct_nbr,client_id));
	
  Layout_NtlAccidents_Alpharetta.cmbnd tOrderCmbndResultIncVehPartyInsClient(jOrderCmbndResultIncVehPartyIns L, dclient R) := TRANSFORM
   lLast_changed := TRIM(L.last_changed, LEFT, RIGHT);
   rLast_changed := TRIM(R.last_changed, LEFT, RIGHT)[7..10] + TRIM(R.last_changed, LEFT, RIGHT)[1..2] + TRIM(R.last_changed, LEFT, RIGHT)[4..5];
   SELF.last_changed := MAP(L.acct_nbr= R.acct_nbr
								            AND (UNSIGNED)lLast_changed < (UNSIGNED)rLast_changed
							              => rLast_changed,lLast_changed);
   SELF.userid := MAP(L.acct_nbr= R.acct_nbr
							        AND (UNSIGNED)lLast_changed > (UNSIGNED)rLast_changed
							        => L.userid,R.userid);
   SELF.start_date := TRIM(R.start_date, LEFT, RIGHT)[7..10] + TRIM(R.start_date, LEFT, RIGHT)[1..2] + TRIM(R.start_date, LEFT, RIGHT)[4..5];
   SELF := R;
   SELF := L;
  END;
  //Note Carrier/Client information will only pertain to party1
  EXPORT cmbnd_ntl_accidents := JOIN(dOrderCmbndResultIncVehPartyIns, dclient,
			                               LEFT.acct_nbr = RIGHT.acct_nbr AND 
			                               LEFT.client_id = RIGHT.client_id AND
				                             LEFT.last_name = LEFT.last_name_1 AND 
				                             LEFT.first_name = LEFT.first_name_1,
			                               tOrderCmbndResultIncVehPartyInsClient(LEFT,RIGHT), LEFT OUTER, LOCAL):PERSIST('~thor_data400::persist::Accidents_Alpharetta.cmbnd_keyed');
																	
// ###################################################################################################
//                  Join Orders Combined Result Incident with Cient
// ###################################################################################################
  ddclient := DISTRIBUTE(client, HASH32(acct_nbr, client_id));
	dOrderCmbndResultInc := DISTRIBUTE(jOrderCmbndResultInc, HASH32(acct_nbr, client_id));
	
  Layout_NtlAccidents_Alpharetta.cmbnd tOrderCmbndResultIncClient(dOrderCmbndResultInc L, ddclient R) := TRANSFORM
   lLast_changed := TRIM(L.last_changed, LEFT, RIGHT);
   rLast_changed := TRIM(R.last_changed, LEFT, RIGHT)[7..10]+TRIM(R.last_changed, LEFT, RIGHT)[1..2]+TRIM(R.last_changed, LEFT, RIGHT)[4..5];
   SELF.last_changed := MAP(L.acct_nbr= R.acct_nbr
							              AND (UNSIGNED)lLast_changed < (UNSIGNED)rLast_changed 
														=> rLast_changed, lLast_changed);
   SELF.userid := MAP(L.acct_nbr= R.acct_nbr
							        AND (UNSIGNED)lLast_changed > (UNSIGNED)rLast_changed
							        => L.userid, R.userid);
   SELF.start_date := TRIM(R.start_date, LEFT, RIGHT)[7..10] + TRIM(R.start_date, LEFT, RIGHT)[1..2] + TRIM(R.start_date, LEFT, RIGHT)[4..5];
   SELF := R;
   SELF := L;
   SELF := [];
  END;
  EXPORT cmbnd_ntl_inq := JOIN(dOrderCmbndResultInc,ddclient,
			                         LEFT.acct_nbr = RIGHT.acct_nbr AND 
			                         LEFT.client_id = RIGHT.client_id,
			                         tOrderCmbndResultIncClient(LEFT,RIGHT), LEFT OUTER, LOCAL):PERSIST('~thor_data400::persist::Accidents_Alpharetta.cmbnd_inq');
END;
			  