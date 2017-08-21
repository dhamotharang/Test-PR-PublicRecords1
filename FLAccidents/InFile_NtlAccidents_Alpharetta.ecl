/*2013-11-07T00:41:07Z (Ayeesha Kayttala)
bug# 138281
*/

export InFile_NtlAccidents_Alpharetta := module

import ut;

export client 	 		:= dedup(sort(distribute(dedup(dataset(ut.foreign_prod + 'thor_data400::in::flcrash::alpharetta::client_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.client
										,csv(terminator('\n'), separator(','))),record,all),hash(acct_nbr,client_id)),acct_nbr,client_id,(last_changed[7..10]+
																																																										last_changed[1..2]+
																																																										last_changed[4..5]),local)
																																				                         ,acct_nbr,client_id,right,local)(ACCT_NBR != 'ACCT_NBR'); //remove headings
export incident 		:= dedup(dataset(ut.foreign_prod + 'thor_data400::in::flcrash::alpharetta::vehicle_incident_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.incident
										,csv(terminator('\n'), separator(','))),record,all)(VEHICLE_INCIDENT_ID != 'VEHICLE_INCIDENT_ID'); //remove headings
export int_order 		:= dedup(dataset(ut.foreign_prod +'thor_data400::in::flcrash::alpharetta::int_order_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.int_order
										,csv(terminator('\n'), separator(','),quote('"'))),record,all)(ORDER_ID  != 'ORDER_ID'); //remove headings and bad records
export party 			:= dedup(sort(dataset(ut.foreign_prod + 'thor_data400::in::flcrash::alpharetta::vehicle_party_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.party
										,csv(terminator('\n'), separator(','))),party_id, -(last_changed[7..10]+last_changed[1..2]+last_changed[4..5])),  party_id)(PARTY_ID != 'PARTY_ID');
export order 			:= dedup(sort(distribute(dataset(ut.foreign_prod +'thor_data400::in::flcrash::alpharetta::order_version_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.order_vs
										,csv(terminator('\n'), separator(','),quote('"'))),hash(order_id)),order_id,SEQUENCE_NBR,(checkin_date[7..10]+
																																																										checkin_date[1..2]+
																																																										checkin_date[4..5]),(last_changed[7..10]+
																																																										last_changed[1..2]+
																																																										last_changed[4..5]),local)
																																				                         ,order_id,right,local)(ORDER_ID  != 'ORDER_ID'); //remove headings and bad records
export result 			:= dedup(dataset(ut.foreign_prod + 'thor_data400::in::flcrash::alpharetta::result_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.result
										,csv(terminator('\n'), separator(','))),record,all)(RESULT_ID != 'RESULT_ID'); //remove headings
////////////////////////////////////////////////////////////////////////////////////////////											
vehicles_in := dataset(ut.foreign_prod +'thor_data400::in::flcrash::alpharetta::vehicle_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.payload
										,csv(terminator('\n'), separator(''),quote('')));
										
flaccidents.Layout_NtlAccidents_Alpharetta.vehicles parserecs(vehicles_in L) := transform
string unparsedRec := regexreplace('"',regexreplace(',"',regexreplace('","',L.line+'|','|'),'|'),'');							

self.VEHICLE_ID       		:= unparsedRec[1..stringlib.stringfind(unparsedRec,'|',1)-1];						
self.VEHICLE_INCIDENT_ID	   		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',1)+1..stringlib.stringfind(unparsedRec,'|',2)-1];						
self.VEHICLE_NBR		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',2)+1..stringlib.stringfind(unparsedRec,'|',3)-1];						
self.VEHICLE_STATUS		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',3)+1..stringlib.stringfind(unparsedRec,'|',4)-1];						
self.vehVIN		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',4)+1..stringlib.stringfind(unparsedRec,'|',5)-1];
self.vehYEAR			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',5)+1..stringlib.stringfind(unparsedRec,'|',6)-1];
self.vehMAKE	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',6)+1..stringlib.stringfind(unparsedRec,'|',7)-1];
self.vehMODEL			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',7)+1..stringlib.stringfind(unparsedRec,'|',8)-1];
self.ODOMETER	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',8)+1..stringlib.stringfind(unparsedRec,'|',9)-1];
self.TAG	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',9)+1..stringlib.stringfind(unparsedRec,'|',10)-1];
self.TAG_STATE			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',10)+1..stringlib.stringfind(unparsedRec,'|',11)-1];
self.COLOR		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',11)+1..stringlib.stringfind(unparsedRec,'|',12)-1];
self.IMPACT_LOCATION	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',12)+1..stringlib.stringfind(unparsedRec,'|',13)-1];
self.POLICY_NBR		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',13)+1..stringlib.stringfind(unparsedRec,'|',14)-1];
self.POLICY_EXP_DATE			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',14)+1..stringlib.stringfind(unparsedRec,'|',15)-1];
self.CARRIER_ID		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',15)+1..stringlib.stringfind(unparsedRec,'|',16)-1];
self.OTHER_CARRIER		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',16)+1..stringlib.stringfind(unparsedRec,'|',17)-1];
self.COMMERCIAL_VIN    := unparsedRec[stringlib.stringfind(unparsedRec,'|',17)+1..stringlib.stringfind(unparsedRec,'|',18)-1];					
self.CAR_FIRE	   		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',18)+1..stringlib.stringfind(unparsedRec,'|',19)-1];						
self.AIRBAGS_DEPLOY		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',19)+1..stringlib.stringfind(unparsedRec,'|',20)-1];						
self.CAR_TOWED		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',20)+1..stringlib.stringfind(unparsedRec,'|',21)-1];						
self.CAR_ROLLOVER		:= unparsedRec[stringlib.stringfind(unparsedRec,'|',21)+1..stringlib.stringfind(unparsedRec,'|',22)-1];
self.DECODED_INFO			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',22)+1..stringlib.stringfind(unparsedRec,'|',23)-1];
self.LAST_CHANGED	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',23)+1..stringlib.stringfind(unparsedRec,'|',24)-1];
self.USERID			:= unparsedRec[stringlib.stringfind(unparsedRec,'|',24)+1..stringlib.stringfind(unparsedRec,'|',25)-1];
self.DAMAGE	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',25)+1..stringlib.stringfind(unparsedRec,'|',26)-1];
self.POLK_VALIDATED_VIN	:= unparsedRec[stringlib.stringfind(unparsedRec,'|',26)+1..stringlib.stringfind(unparsedRec,'|',27)-1];
self := L;

end;

export vehicles := dedup(sort(project(vehicles_in(regexfind('[0-9]',line)), parserecs(left)), vehicle_id ,-(last_changed[7..10]+
																																																										last_changed[1..2]+
																																																										last_changed[4..5])),vehicle_id ); 

////////////////////////////////////////////////////////////////////////////////////////////	

export insurance 		:= dedup(dataset(ut.foreign_prod + 'thor_data400::in::flcrash::alpharetta::vehicle_insurance_carrier_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.insurance
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
flaccidents.Layout_NtlAccidents_Alpharetta.cmbnd trecs1(cmbnd_order L, result R) := transform

//keeping the latest last change date
lLast_changed			:= if ( trim(L.checkin_date,left,right) <>'' , trim(L.checkin_date,left,right)[7..10]+ trim(L.checkin_date,left,right)[1..2]+trim(L.checkin_date,left,right)[4..5], 
                            trim(L.last_changed,left,right)[7..10]+ trim(L.last_changed,left,right)[1..2]+trim(L.last_changed,left,right)[4..5]);
rLast_changed			:= trim(R.last_changed,left,right)[7..10]+ trim(R.last_changed,left,right)[1..2]+trim(R.last_changed,left,right)[4..5];
self.last_changed		:= map(L.order_id = R.order_id 
									and (unsigned)lLast_changed < (unsigned)rLast_changed
							 => rLast_changed
							 ,lLast_changed);
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
			,dedup(sort(distribute(result(order_id<>''),hash(order_id)),order_id,sequence_nbr,(last_changed[7..10]+
																																																										last_changed[1..2]+
																																																										last_changed[4..5]),local),order_id,right,local), //keeping last
			  left.order_id = right.order_id,
			  trecs1(left,right), left outer, local);

/////////////////////////////////////////////////////////////////////////////////////				  
flaccidents.Layout_NtlAccidents_Alpharetta.cmbnd trecs2(jrecs1 L, incident R) := transform
lLast_changed			:= trim(L.last_changed,left,right);
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
									and (unsigned)lLast_changed < (unsigned)rLast_changed
							 => rLast_changed
							 ,lLast_changed);

self 						:= R;
self 						:= L;
self 						:=[];
end;

export jrecs2 := join(jrecs1,dedup(sort(distribute(incident(order_id<>''),hash(order_id)),order_id,sequence_nbr,(last_changed[7..10]+
																																																										last_changed[1..2]+
																																																										last_changed[4..5]),local),order_id,right,local), //keeping last
			  left.order_id = right.order_id,
			  trecs2(left,right), left outer, local);
/////////////////////////////////////////////////////////////////////////////////////				  
flaccidents.Layout_NtlAccidents_Alpharetta.cmbnd trecs3(jrecs2 L, vehicles R) := transform
lLast_changed			:= trim(L.last_changed,left,right);
rLast_changed			:= trim(R.last_changed,left,right)[7..10]+ trim(R.last_changed,left,right)[1..2]+trim(R.last_changed,left,right)[4..5];

self.vehicle_incident_id 	:= L.vehicle_incident_id;

//keeping the latest last change date
self.last_changed		:= map(L.vehicle_incident_id = R.vehicle_incident_id							
									and (unsigned)lLast_changed < (unsigned)rLast_changed
							 => rLast_changed
							 ,lLast_changed);
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
flaccidents.Layout_NtlAccidents_Alpharetta.cmbnd trecs4(jrecs3 L, party R) := transform
lLast_changed			:= trim(L.last_changed,left,right);
rLast_changed			:= trim(R.last_changed,left,right)[7..10]+ trim(R.last_changed,left,right)[1..2]+trim(R.last_changed,left,right)[4..5];

self.vehicle_incident_id 	:= L.vehicle_incident_id;
//keeping the latest last change date
self.last_changed		:= map(L.vehicle_incident_id = R.vehicle_incident_id 
							and L.vehicle_id = R.vehicle_id 
									and (unsigned)lLast_changed < (unsigned)rLast_changed
							 => rLast_changed
							 ,lLast_changed);
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

flaccidents.Layout_NtlAccidents_Alpharetta.cmbnd trecs5(jrecs4 L, insurance R) := transform
lLast_changed			:= trim(L.last_changed,left,right);
rLast_changed			:= trim(R.last_changed,left,right)[7..10]+ trim(R.last_changed,left,right)[1..2]+trim(R.last_changed,left,right)[4..5];

self.carrier_id 		:= L.carrier_id;
self.carrier_name   := if(L.carrier_id = R.carrier_id, R.carrier_name, L.carrier_name);
//keeping the latest last change date
self.last_changed		:= map(L.carrier_id= R.carrier_id
									and (unsigned)lLast_changed < (unsigned)rLast_changed
							 => rLast_changed
							 ,lLast_changed);
self.userid		    		:= map(L.carrier_id= R.carrier_id
							and (unsigned)lLast_changed > (unsigned)rLast_changed
							 => L.userid,R.userid);
							 
self := R;
self := L;

end;

export jrecs5 := join(jrecs4, insurance,
			  left.carrier_id = right.carrier_id,
			  trecs5(left,right), left outer, lookup): persist('~thor_data400::persist::Accidents_Alpharetta.cmbnd');


/////////////////////////////////////////////////////////////////////////////////////	

flaccidents.Layout_NtlAccidents_Alpharetta.cmbnd trecs6(jrecs5 L, client R) := transform
lLast_changed			:= trim(L.last_changed,left,right);
rLast_changed			:= trim(R.last_changed,left,right)[7..10]+ trim(R.last_changed,left,right)[1..2]+trim(R.last_changed,left,right)[4..5];

//keeping the latest last change date

self.last_changed		:= map(L.acct_nbr= R.acct_nbr
								and (unsigned)lLast_changed < (unsigned)rLast_changed
							 => rLast_changed
							 ,lLast_changed);
self.userid		    		:= map(L.acct_nbr= R.acct_nbr
							and (unsigned)lLast_changed > (unsigned)rLast_changed
							 => L.userid,R.userid);
						 
self.start_date 		:= trim(R.start_date,left,right)[7..10]+ trim(R.start_date,left,right)[1..2]+trim(R.start_date,left,right)[4..5];
self := R;
self := L;

end;

//Note Carrier/Client information will only pertain to party1

export cmbnd_keyed := join(distribute(jrecs5,hash(acct_nbr,client_id)),distribute(client,hash(acct_nbr,client_id)),
			  left.acct_nbr = right.acct_nbr and 
			  left.client_id = right.client_id and
				left.last_name = left.last_name_1 and 
				left.first_name = left.first_name_1,
			  trecs6(left,right), left outer, local): persist('~thor_data400::persist::Accidents_Alpharetta.cmbnd_keyed');



/////////////////////////////////////////////////////////////////////////////////////	

flaccidents.Layout_NtlAccidents_Alpharetta.cmbnd trecs7(jrecs2 L, client R) := transform
lLast_changed			:= trim(L.last_changed,left,right);
rLast_changed			:= trim(R.last_changed,left,right)[7..10]+ trim(R.last_changed,left,right)[1..2]+trim(R.last_changed,left,right)[4..5];

//keeping the latest last change date

self.last_changed		:= map(L.acct_nbr= R.acct_nbr
							and (unsigned)lLast_changed < (unsigned)rLast_changed
							 => rLast_changed
							 ,lLast_changed);
self.userid		    		:= map(L.acct_nbr= R.acct_nbr
							and (unsigned)lLast_changed > (unsigned)rLast_changed
							 => L.userid,R.userid);
						 
self.start_date 		:= trim(R.start_date,left,right)[7..10]+ trim(R.start_date,left,right)[1..2]+trim(R.start_date,left,right)[4..5];
self := R;
self := L;
self := [];

end;


export cmbnd_inq := join(distribute(jrecs2,hash(acct_nbr,client_id)),distribute(client,hash(acct_nbr,client_id)),
			  left.acct_nbr = right.acct_nbr and 
			  left.client_id = right.client_id,
			  trecs7(left,right), left outer, local): persist('~thor_data400::persist::Accidents_Alpharetta.cmbnd_inq');

			 
end;
			  