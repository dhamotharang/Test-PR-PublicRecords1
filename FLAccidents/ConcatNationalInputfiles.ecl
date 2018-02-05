import ut ; 

export ConcatNationalInputfiles := function

NtlCrash_client := FLAccidents.InFile_NtlAccidents_Alpharetta.client; 
NtlCrash_incident := FLAccidents.InFile_NtlAccidents_Alpharetta.incident;
NtlCrash_int_order := FLAccidents.InFile_NtlAccidents_Alpharetta.int_order;
NtlCrash_party := FLAccidents.InFile_NtlAccidents_Alpharetta.party;
NtlCrash_order := FLAccidents.InFile_NtlAccidents_Alpharetta.order;
NtlCrash_result := FLAccidents.InFile_NtlAccidents_Alpharetta.result;
NtlCrash_insurance := FLAccidents.InFile_NtlAccidents_Alpharetta.insurance;

NtlCrash_vehicles_in := dataset(ut.foreign_prod +'thor_data400::in::flcrash::alpharetta::vehicle_new'
										,flaccidents.Layout_NtlAccidents_Alpharetta.payload
										,csv(terminator('\n'), separator(''),quote('')));

curtime := ut.gettime() : independent; 
date := ut.GetDate : independent; 



create_logical := sequential(
                output(NtlCrash_client,,'~thor_data400::in::flcrash::alpharetta::client_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
								output(NtlCrash_incident,,'~thor_data400::in::flcrash::alpharetta::vehicle_incident_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
								output(NtlCrash_int_order,,'~thor_data400::in::flcrash::alpharetta::int_order_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
								output(NtlCrash_party,,'~thor_data400::in::flcrash::alpharetta::vehicle_party_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
								output(NtlCrash_order,,'~thor_data400::in::flcrash::alpharetta::order_version_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
								output(NtlCrash_result,,'~thor_data400::in::flcrash::alpharetta::result_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
								output(NtlCrash_insurance,,'~thor_data400::in::flcrash::alpharetta::vehicle_insurance_carrier_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(','),quote('"')),__compressed__,overwrite),
								output(NtlCrash_vehicles_in,,'~thor_data400::in::flcrash::alpharetta::vehicle_new_'+ut.GetDate+'_'+curtime,csv(terminator('\n'), separator(''),quote('')),__compressed__,overwrite));
								
		clear_super_new := Sequential(						fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::client_new'), 
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_incident_new'),
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::int_order_new'),
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_party_new'),
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::order_version_new'),
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::result_new'),
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_insurance_carrier_new'),
fileservices.clearsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_new'));


add_super := Sequential( fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::client_new','~thor_data400::in::flcrash::alpharetta::client_new_'+ut.GetDate+'_'+curtime), 
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_incident_new','~thor_data400::in::flcrash::alpharetta::vehicle_incident_new_'+ut.GetDate+'_'+curtime),
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::int_order_new','~thor_data400::in::flcrash::alpharetta::int_order_new_'+ut.GetDate+'_'+curtime),
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_party_new','~thor_data400::in::flcrash::alpharetta::vehicle_party_new_'+ut.GetDate+'_'+curtime),
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::order_version_new','~thor_data400::in::flcrash::alpharetta::order_version_new_'+ut.GetDate+'_'+curtime),
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::result_new','~thor_data400::in::flcrash::alpharetta::result_new_'+ut.GetDate+'_'+curtime),
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_insurance_carrier_new','~thor_data400::in::flcrash::alpharetta::vehicle_insurance_carrier_new_'+ut.GetDate+'_'+curtime),
fileservices.addsuperfile('~thor_data400::in::flcrash::alpharetta::vehicle_new','~thor_data400::in::flcrash::alpharetta::vehicle_new_'+ut.GetDate+'_'+curtime)); 

 validate_counts := map ( count(FLAccidents.InFile_NtlAccidents_Alpharetta.client) <> count(NtlCrash_client) => FAIL('NtlCrash_client_counts_mismatch'),
                     count(FLAccidents.InFile_NtlAccidents_Alpharetta.incident) <> count(NtlCrash_incident) => FAIL('NtlCrash_incident_counts_mismatch'),
										 count(FLAccidents.InFile_NtlAccidents_Alpharetta.int_order) <> count(NtlCrash_int_order) => FAIL('NtlCrash_int_order_counts_mismatch'),
										 count(FLAccidents.InFile_NtlAccidents_Alpharetta.party) <> count(NtlCrash_party) => FAIL('NtlCrash_party_counts_mismatch'),
										 count(FLAccidents.InFile_NtlAccidents_Alpharetta.order) <> count(NtlCrash_order) => FAIL('NtlCrash_order_counts_mismatch'),
										 count(FLAccidents.InFile_NtlAccidents_Alpharetta.result) <> count(NtlCrash_result) => FAIL('NtlCrash_result_counts_mismatch'),
										 count(FLAccidents.InFile_NtlAccidents_Alpharetta.insurance) <> count(NtlCrash_insurance) => FAIL('NtlCrash_insurance_counts_mismatch'),
									// count(FLAccidents.InFile_NtlAccidents_Alpharetta.vehicles_in) <> count(NtlCrash_vehicles_in) => FAIL('NtlCrash_vehicles_counts_mismatch'),

										 Output('All_NtlCrash_Concat_filecnt_looks_good')
										 );
										 
return sequential(output(count(FLAccidents.InFile_NtlAccidents_Alpharetta.client),named('raw_client')),
            output(count(NtlCrash_client),named('outputraw_client')),
				    output(count(FLAccidents.InFile_NtlAccidents_Alpharetta.incident),named('raw_incident')),
            output(count(NtlCrash_incident),named('outputraw_incident')),
            output(count(FLAccidents.InFile_NtlAccidents_Alpharetta.int_order),named('raw_intorder')), 
            output(count(NtlCrash_int_order),named('outputraw_intorder')),
            output(count(FLAccidents.InFile_NtlAccidents_Alpharetta.party),named('raw_party')),
           output(count(NtlCrash_party),named('outputraw_party')),
           output(count(FLAccidents.InFile_NtlAccidents_Alpharetta.order),named('raw_order')),
           output(count(NtlCrash_order),named('outputraw_order')),
           output(count(FLAccidents.InFile_NtlAccidents_Alpharetta.result),named('raw_result')),
           output(count(NtlCrash_result),named('outputraw_result')),
					            output(count(FLAccidents.InFile_NtlAccidents_Alpharetta.insurance),named('raw_insurance')),
           output(count(NtlCrash_insurance),named('outputraw_insurance')),
					      //      output(count(FLAccidents.InFile_NtlAccidents_Alpharetta.vehicles_in),named('raw_vehicles')),
           output(count(NtlCrash_vehicles_in),named('outputraw_vehicles')),

					 
					     validate_counts,
           create_logical , clear_super_new, add_super
					 ); 
end;