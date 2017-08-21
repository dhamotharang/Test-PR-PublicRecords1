import SANCTN;
file_base_in := dataset( '~thor_data400::base::SANCTN::incident'
                                           ,SANCTN.layout_SANCTN_incident_clean,thor);
file_base_in_father := 		dataset( '~thor_data400::base::SANCTN::incident_father'
                                           ,SANCTN.layout_SANCTN_incident_clean,thor);																			 
dist_file_in := distribute(file_base_in,HASH32(BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,INCIDENT_DATE_CLEAN));
dist_file_in_var := distribute(file_base_in_father,HASH32(BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,INCIDENT_DATE_CLEAN));

SANCTN.layout_SANCTN_incident_clean join_tr(dist_file_in le,dist_file_in_var re) := transform


self := le;
end;

jout := join(dist_file_in,dist_file_in_var,LEFT.BATCH_NUMBER = RIGHT.BATCH_NUMBER AND LEFT.INCIDENT_NUMBER = RIGHT.INCIDENT_NUMBER AND 
LEFT.PARTY_NUMBER = RIGHT.PARTY_NUMBER AND LEFT.INCIDENT_DATE_CLEAN = RIGHT.INCIDENT_DATE_CLEAN,join_tr(LEFT,RIGHT),left only,local);

sort_in := sort(jout,-incident_date_clean);

insamp := output(topn(sort_in,100,-incident_date_clean),,NAMED('INCIDENTQASAMPLES'));
//party qa samples
file_party_in := dataset( '~thor_data400::base::SANCTN::party'
                                           ,SANCTN.layout_SANCTN_party_clean,thor);
file_party_in_father := 		dataset( '~thor_data400::base::SANCTN::party_father'
                                           ,SANCTN.layout_SANCTN_party_clean,thor);																			 
dist_file_party := distribute(file_party_in,HASH32(BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,RECORD_TYPE));
dist_file_in_party := distribute(file_party_in_father,HASH32(BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,RECORD_TYPE));

SANCTN.layout_SANCTN_party_clean join_tr_par(dist_file_party le,dist_file_in_party re) := transform


self := le;
end;

joutpar := join(dist_file_party,dist_file_in_party,LEFT.BATCH_NUMBER = RIGHT.BATCH_NUMBER AND LEFT.INCIDENT_NUMBER = RIGHT.INCIDENT_NUMBER AND 
LEFT.PARTY_NUMBER = RIGHT.PARTY_NUMBER AND LEFT.RECORD_TYPE = RIGHT.RECORD_TYPE,join_tr_par(LEFT,RIGHT),left only,local);

parsamp := output(topn(joutpar,100,-BATCH_NUMBER),,NAMED('PARTYQASAMPLES'));
qasamp := sequential(insamp,parsamp);

export out_qa_sanctn_samples := qasamp;