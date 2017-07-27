export InFile_NtlAccidents_Alpharetta := module

import ut;

export client 	 		:= dedup(sort(distribute(dedup(dataset(ut.foreign_prod + '~thor_data400::in::flcrash::alpharetta::client'
										,Layout_NtlAccidents_Alpharetta.client
										,csv(terminator('\n'), separator(','))),record,all),hash(acct_nbr,client_id)),acct_nbr,client_id,(last_changed[7..10]+
																																																										last_changed[1..2]+
																																																										last_changed[4..5]),local)
																																				                         ,acct_nbr,client_id,local)(ACCT_NBR != 'ACCT_NBR'); //remove headings
export incident 		:= dedup(dataset(ut.foreign_prod + '~thor_data400::in::flcrash::alpharetta::vehicle_incident'
										,Layout_NtlAccidents_Alpharetta.incident
										,csv(terminator('\n'), separator(','))),record,all)(VEHICLE_INCIDENT_ID != 'VEHICLE_INCIDENT_ID'); //remove headings
export int_order 		:= dedup(dataset(ut.foreign_prod + '~thor_data400::in::flcrash::alpharetta::int_order'
										,Layout_NtlAccidents_Alpharetta.int_order
										,csv(terminator('\n'), separator(','))),record,all)(ORDER_ID  != 'ORDER_ID'); //remove headings and bad records
export party 			:= dedup(dataset(ut.foreign_prod + '~thor_data400::in::flcrash::alpharetta::vehicle_party'
										,Layout_NtlAccidents_Alpharetta.party
										,csv(terminator('\n'), separator(','))),record,all)(PARTY_ID != 'PARTY_ID'); //remove headings
export order 			:= dedup(dataset(ut.foreign_prod + '~thor_data400::in::flcrash::alpharetta::order_version'
										,Layout_NtlAccidents_Alpharetta.order_vs
										,csv(terminator('\n'), separator(','))),record,all)(ORDER_ID  != 'ORDER_ID' and length(CLAIM_NBR) <100); //remove headings and bad records
export result 			:= dedup(dataset(ut.foreign_prod + '~thor_data400::in::flcrash::alpharetta::result'
										,Layout_NtlAccidents_Alpharetta.result
										,csv(terminator('\n'), separator(','))),record,all)(RESULT_ID != 'RESULT_ID'); //remove headings
export vehicles 		:= dedup(dataset(ut.foreign_prod + '~thor_data400::in::flcrash::alpharetta::vehicle'
										,Layout_NtlAccidents_Alpharetta.vehicles
										,csv(terminator('\n'), separator(','))),record,all)(VEHICLE_ID != 'VEHICLE_ID'); //remove headings
export insurance 		:= dedup(dataset(ut.foreign_prod + '~thor_data400::in::flcrash::alpharetta::vehicle_insurance_carrier'
										,Layout_NtlAccidents_Alpharetta.insurance
										,csv(terminator('\n'), separator(','))),record,all)(CARRIER_ID  != 'INS_CARRIER_ID '); //remove headings


/////////////////////////////////////////////////////////////////////////////////////
//Combine order_version and int_order.  int_order recs are client requests from the web.

temp_layout := record
order;
string SUFFIX;
string GENDER;
string PREVIOUS_DL_NBR;
string PREVIOUS_DL_STATE;
string FULFILLED_DATE;
string POLICY_CARRIER_AUTO;
string POLICY_NBR_AUTO;
string POLICY_CARRIER_PROPERTY;
string POLICY_NBR_PROPERTY;
string PREVIOUS_POLICY_TYPE;
string MORTGAGE_LOAN_NBR;
string MORTGAGEE;
string ORIG_ORDER_ID;
string INITIAL_ORDER;
string RULES_STATUS_CD;
string VERSION;
string SEARCH_MODE;
string PROCESS_STATE;
string PROCESSOR;
end;

temp_layout trecs(order L) := transform
self := L;
self :=[];
end;

p_order:= project(order,trecs(left));

//---------------------------------------------
temp_layout trecs0(int_order L) := transform
self := L;
self :=[];
end;

p_int_order:= project(int_order,trecs0(left));

cmbnd_order := p_int_order+p_order;

/////////////////////////////////////////////////////////////////////////////////////	
Layout_NtlAccidents_Alpharetta.cmbnd trecs1(cmbnd_order L, result R) := transform

//keeping the latest last change date
lLast_changed			:= trim(L.last_changed,left,right)[7..10]+ trim(L.last_changed,left,right)[1..2]+trim(L.last_changed,left,right)[4..5];
rLast_changed			:= trim(R.last_changed,left,right)[7..10]+ trim(R.last_changed,left,right)[1..2]+trim(R.last_changed,left,right)[4..5];
self.last_changed		:= map(L.order_id = R.order_id 
							and (unsigned)lLast_changed > (unsigned)rLast_changed
							 => lLast_changed
							 ,rLast_changed);
self := L;
self := R;
self :=[];
end;
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
jrecs1 := join(dedup(sort(distribute(cmbnd_order,hash(order_id)),order_id,sequence_nbr,local),order_id,right,local)
			,dedup(sort(distribute(result(order_id<>''),hash(order_id)),order_id,sequence_nbr,local),order_id,right,local), //keeping last
			  left.order_id = right.order_id,
			  trecs1(left,right), left outer, local);

/////////////////////////////////////////////////////////////////////////////////////				  
Layout_NtlAccidents_Alpharetta.cmbnd trecs2(jrecs1 L, incident R) := transform
lLast_changed			:= trim(L.last_changed,left,right)[7..10]+ trim(L.last_changed,left,right)[1..2]+trim(L.last_changed,left,right)[4..5];
rLast_changed			:= trim(R.last_changed,left,right)[7..10]+ trim(R.last_changed,left,right)[1..2]+trim(R.last_changed,left,right)[4..5];

self.order_id				:= L.order_id;
self.sequence_nbr			:= L.sequence_nbr;
self.creation_date			:= L.creation_date;
self.service_id				:= map(L.order_id = R.order_id  and L.service_id = '' => R.service_id, L.service_id);
self.loss_date				:= map(L.order_id = R.order_id  and L.loss_date <> '' => R.loss_date, L.loss_date);
self.loss_time				:= map(L.order_id = R.order_id  and L.loss_time <> '' => R.loss_time, L.loss_time);
self.report_nbr				:= map(L.order_id = R.order_id  and L.report_nbr = '' => R.report_nbr, L.report_nbr);
//keeping the latest last change date
self.last_changed			:= map(L.order_id = R.order_id 
							and (unsigned)lLast_changed > (unsigned)rLast_changed
							 => lLast_changed
							 ,rLast_changed);

self 						:= R;
self 						:= L;
self 						:=[];
end;

jrecs2 := join(jrecs1,dedup(sort(distribute(incident(order_id<>''),hash(order_id)),order_id,sequence_nbr,local),order_id,right,local), //keeping last
			  left.order_id = right.order_id,
			  trecs2(left,right), left outer, local);
/////////////////////////////////////////////////////////////////////////////////////				  
Layout_NtlAccidents_Alpharetta.cmbnd trecs3(jrecs2 L, vehicles R) := transform
lLast_changed			:= trim(L.last_changed,left,right)[7..10]+ trim(L.last_changed,left,right)[1..2]+trim(L.last_changed,left,right)[4..5];
rLast_changed			:= trim(R.last_changed,left,right)[7..10]+ trim(R.last_changed,left,right)[1..2]+trim(R.last_changed,left,right)[4..5];

self.vehicle_incident_id 	:= L.vehicle_incident_id;

//keeping the latest last change date
self.last_changed		:= map(L.vehicle_incident_id = R.vehicle_incident_id							
							and (unsigned)lLast_changed > (unsigned)rLast_changed
							 => lLast_changed
							 ,rLast_changed);
self.userid		    	:= map(L.vehicle_incident_id = R.vehicle_incident_id					
							and (unsigned)lLast_changed > (unsigned)rLast_changed
							 => L.userid,R.userid);
self.vehvin				:= map(L.vehicle_incident_id = R.vehicle_incident_id						
							=> R.vehvin,L.vehvin);
self.vehyear			:= map(L.vehicle_incident_id = R.vehicle_incident_id							
							=> R.vehyear,L.vehyear);
self.vehmake			:= map(L.vehicle_incident_id = R.vehicle_incident_id							
							=> R.vehmake,L.vehmake);
self.vehmodel			:= map(L.vehicle_incident_id = R.vehicle_incident_id						
							=> R.vehmodel,L.vehmodel);
self.vehicle_status		:= map(L.vehicle_incident_id = R.vehicle_incident_id							
							=> R.vehicle_status,L.vehicle_status);
self.impact_location	:= map(L.vehicle_incident_id = R.vehicle_incident_id							
							=> R.impact_location,L.impact_location);						 
self.tag				:= map(L.vehicle_incident_id = R.vehicle_incident_id							
							=> L.tag,'');
self.tag_state			:= map(L.vehicle_incident_id = R.vehicle_incident_id							
							=> L.tag_state,'');
							
self := R;
self := L;
self :=[];
end;

jrecs3 := join(distribute(jrecs2,hash(vehicle_incident_id)),
			   distribute(vehicles(vehicle_incident_id<>''),hash(vehicle_incident_id)),
			  left.vehicle_incident_id = right.vehicle_incident_id,
			  trecs3(left,right), left outer, local);
			  
			  
/////////////////////////////////////////////////////////////////////////////////////	
Layout_NtlAccidents_Alpharetta.cmbnd trecs4(jrecs3 L, party R) := transform
lLast_changed			:= trim(L.last_changed,left,right)[7..10]+ trim(L.last_changed,left,right)[1..2]+trim(L.last_changed,left,right)[4..5];
rLast_changed			:= trim(R.last_changed,left,right)[7..10]+ trim(R.last_changed,left,right)[1..2]+trim(R.last_changed,left,right)[4..5];

self.vehicle_incident_id 	:= L.vehicle_incident_id;
//keeping the latest last change date
self.last_changed		:= map(L.vehicle_incident_id = R.vehicle_incident_id 
							and L.vehicle_id = R.vehicle_id 
							and (unsigned)lLast_changed > (unsigned)rLast_changed
							 => lLast_changed
							 ,rLast_changed);
self.userid		    		:= map(L.vehicle_incident_id = R.vehicle_incident_id
							and L.vehicle_id = R.vehicle_id 
							and (unsigned)lLast_changed > (unsigned)rLast_changed
							 => L.userid,R.userid);

self.pty_drivers_license:= map(L.vehicle_incident_id = R.vehicle_incident_id
							and L.vehicle_id = R.vehicle_id
							=> R.pty_drivers_license,'');						
self.pty_drivers_license_st
						:= map(L.vehicle_incident_id = R.vehicle_incident_id
							and L.vehicle_id = R.vehicle_id
							=> R.pty_drivers_license_st,'');
dob
						:= map(L.vehicle_incident_id = R.vehicle_incident_id
							and L.vehicle_id = R.vehicle_id
							=> R.dob,'');
							
self.dob		:= dob[7..10]+dob[1..2]+dob[4..5];
				
// Populate Inquiry fields, these fields contain data pulled from the order version table and must be labeled accordingly
ssn								:= if((unsigned)L.ssn_1 =0, '',L.ssn_1);
self.inquiry_ssn 	:= map(L.vehicle_incident_id = R.vehicle_incident_id
												and L.vehicle_id = R.vehicle_id
												and R.LAST_NAME+R.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1
												=> ssn,'');
self.inquiry_dob 	:= if(R.LAST_NAME+R.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.dob_1[7..10]+L.dob_1[1..2]+L.dob_1[4..5],'');

self := R;
self := L;
self :=[];
end;

jrecs4 := join(sort(distribute(jrecs3(vehicle_incident_id<>''),hash(vehicle_incident_id,vehicle_id)),vehicle_incident_id,vehicle_id,LAST_NAME_1,FIRST_NAME_1,local),
			   sort(distribute(party(vehicle_incident_id<>''),hash(vehicle_incident_id,vehicle_id)),vehicle_incident_id,vehicle_id,LAST_NAME,FIRST_NAME,local),
			        left.vehicle_incident_id = right.vehicle_incident_id and
					left.vehicle_id = right.vehicle_id, 
			        trecs4(left,right), left outer, local);
/////////////////////////////////////////////////////////////////////////////////////				  
/*
Carrier Id is not populated.  Requirements documentation states that this file is for reference only.
Layout_NtlAccidents_Alpharetta.cmbnd trecs5(jrecs4 L, insurance R) := transform
lLast_changed			:= trim(L.last_changed,left,right)[7..10]+ trim(L.last_changed,left,right)[1..2]+trim(L.last_changed,left,right)[4..5];
rLast_changed			:= trim(R.last_changed,left,right)[7..10]+ trim(R.last_changed,left,right)[1..2]+trim(R.last_changed,left,right)[4..5];

self.carrier_id 		:= L.carrier_id;
//keeping the latest last change date
self.last_changed		:= map(L.carrier_id= R.carrier_id
							and (unsigned)lLast_changed > (unsigned)rLast_changed
							 => lLast_changed
							 ,rLast_changed);
self.userid		    		:= map(L.carrier_id= R.carrier_id
							and (unsigned)lLast_changed > (unsigned)rLast_changed
							 => L.userid,R.userid);
							 
self := R;
self := L;

end;

jrecs5 := join(jrecs4, insurance,
			  left.carrier_id = right.carrier_id,
			  trecs5(left,right), left outer, lookup) : persist('~thor_data400::persist::Accidents_Alpharetta.cmbnd');
*/

/////////////////////////////////////////////////////////////////////////////////////	
Layout_NtlAccidents_Alpharetta.cmbnd trecs6(jrecs4 L, client R) := transform
lLast_changed			:= trim(L.last_changed,left,right)[7..10]+ trim(L.last_changed,left,right)[1..2]+trim(L.last_changed,left,right)[4..5];
rLast_changed			:= trim(R.last_changed,left,right)[7..10]+ trim(R.last_changed,left,right)[1..2]+trim(R.last_changed,left,right)[4..5];

//keeping the latest last change date

self.last_changed		:= map(L.acct_nbr= R.acct_nbr
							and (unsigned)lLast_changed > (unsigned)rLast_changed
							 => lLast_changed
							 ,rLast_changed);
self.userid		    		:= map(L.acct_nbr= R.acct_nbr
							and (unsigned)lLast_changed > (unsigned)rLast_changed
							 => L.userid,R.userid);
						 
self.start_date 		:= trim(R.start_date,left,right)[7..10]+ trim(R.start_date,left,right)[1..2]+trim(R.start_date,left,right)[4..5];

self := R;
self := L;

end;

jrecs6 := join(distribute(jrecs4,hash(acct_nbr,client_id)),distribute(client,hash(acct_nbr,client_id)),
			  left.acct_nbr = right.acct_nbr and 
			  left.client_id = right.client_id,
			  trecs6(left,right), left outer, local) : persist('~thor_data400::persist::Accidents_Alpharetta.cmbnd');

export cmbnd := jrecs6;
end;
			  