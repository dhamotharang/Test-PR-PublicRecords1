import ut ; 

string curtime := ut.gettime() : INDEPENDENT;

client 	 		:=dedup(dataset( '~thor_data400::in::flcrash::alpharetta::client_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.client
										,csv(terminator('\n'), separator(','),quote('"'))),record,all)(ACCT_NBR != 'ACCT_NBR');
										

incident 		:= dedup(dataset( '~thor_data400::in::flcrash::alpharetta::vehicle_incident_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.incident
										,csv(terminator('\n'), separator(','),quote('"'))),record,all)(VEHICLE_INCIDENT_ID != 'VEHICLE_INCIDENT_ID');
										
int_order 		:= dedup(dataset( '~thor_data400::in::flcrash::alpharetta::int_order_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.int_order
										,csv(terminator('\n'), separator(','),quote('"'))),record,all)(ORDER_ID  != 'ORDER_ID'); 
	
		

 party 			:= dedup(dataset( '~thor_data400::in::flcrash::alpharetta::vehicle_party_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.party
										,csv(terminator('\n'), separator(','),quote('"'))),record,all)(PARTY_ID != 'PARTY_ID');
										
		
order 			:=dedup( dataset('~thor_data400::in::flcrash::alpharetta::order_version_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.order_vs
										,csv(terminator('\n'), separator(','),quote('"'))),record,all)(ORDER_ID  != 'ORDER_ID');


	
 result 			:= dedup(dataset( '~thor_data400::in::flcrash::alpharetta::result_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.result
										,csv(terminator('\n'), separator(','),quote('"'))),record,all)(RESULT_ID != 'RESULT_ID'); 
										

 insurance 		:= dedup(dataset( '~thor_data400::in::flcrash::alpharetta::vehicle_insurance_carrier_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.insurance
										,csv(terminator('\n'), separator(','),quote('"'))),record,all)(CARRIER_ID  != 'INS_CARRIER_ID '); 
										
	

vehicles_in := dataset('~thor_data400::in::flcrash::alpharetta::vehicle_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.payload
										,csv(terminator('\n'), separator(''),quote('')));


export ConcatNationalInputfiles := sequential(
                output(client,,'~thor_data400::in::flcrash::alpharetta::client_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
               	count(FLAccidents.InFile_NtlAccidents_Alpharetta.client), 
								output(incident,,'~thor_data400::in::flcrash::alpharetta::vehicle_incident_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
								count(FLAccidents.InFile_NtlAccidents_Alpharetta.incident), 
								output(int_order,,'~thor_data400::in::flcrash::alpharetta::int_order_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
								count(FLAccidents.InFile_NtlAccidents_Alpharetta.int_order), 
								output(party,,'~thor_data400::in::flcrash::alpharetta::vehicle_party_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
								count(FLAccidents.InFile_NtlAccidents_Alpharetta.party),
								output(order,,'~thor_data400::in::flcrash::alpharetta::order_version_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
								count(	FLAccidents.InFile_NtlAccidents_Alpharetta.order	),	
								output(result,,'~thor_data400::in::flcrash::alpharetta::result_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
								count(	FLAccidents.InFile_NtlAccidents_Alpharetta.result	),	
								output(insurance,,'~thor_data400::in::flcrash::alpharetta::vehicle_insurance_carrier_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
								count(	FLAccidents.InFile_NtlAccidents_Alpharetta.insurance),	
								output(vehicles_in,,'~thor_data400::in::flcrash::alpharetta::vehicle_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(''),quote('')),__compressed__,overwrite),
								count(FLAccidents.InFile_NtlAccidents_Alpharetta.vehicles	)
								
								,fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::client_new'), 
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_incident_new'),
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::int_order_new'),
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_party_new'),
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::order_version_new'),
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::result_new'),
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_insurance_carrier_new'),
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_new'),


fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::client_new','~thor_data400::in::flcrash::alpharetta::client_new_'+ut.GetDate+'_'+curtime), 
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_incident_new','~thor_data400::in::flcrash::alpharetta::vehicle_incident_new_'+ut.GetDate+'_'+curtime),
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::int_order_new','~thor_data400::in::flcrash::alpharetta::int_order_new_'+ut.GetDate+'_'+curtime),
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_party_new','~thor_data400::in::flcrash::alpharetta::vehicle_party_new_'+ut.GetDate+'_'+curtime),
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::order_version_new','~thor_data400::in::flcrash::alpharetta::order_version_new_'+ut.GetDate+'_'+curtime),
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::result_new','~thor_data400::in::flcrash::alpharetta::result_new_'+ut.GetDate+'_'+curtime),
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_insurance_carrier_new','~thor_data400::in::flcrash::alpharetta::vehicle_insurance_carrier_new_'+ut.GetDate+'_'+curtime),
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_new','~thor_data400::in::flcrash::alpharetta::vehicle_new_'+ut.GetDate+'_'+curtime)); 

 