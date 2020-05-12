IMPORT _Control, iesp, Prof_LicenseV2;

MAC_read_override_base('Email_Data',EmailRecIDs,flag_file_id,did,email_rec_key);
ds_input := EmailRecIDs;

//output(ds_input, named('ds_input'));

service_name	:= 'ConsumerDisclosure.FCRADataService';
serviceURL		:= _Control.RoxieEnv.prod_batch_fcra ;

nodes			:= 50;
threads			:= 2;
layout_in   := iesp.fcradataservice.t_FcraDataServiceRequest;
layout_out  := iesp.fcradataservice.t_FcraDataServiceReportResponse;

layoutSoap := record
	dataset(layout_in) fcradataservicerequest;
end;

layout_in make_child_ds(ds_input L) := TRANSFORM
	SELF.Options.ReturnSuppressedRecords := true;
	SELF.Options.ReturnOverwrittenRecords := true;
	SELF.Options.DatasetSelection.Includeall:= true;
	SELF.ReportBy.lexid := L.did;
	SELF := L;
	SELF := [];
END;

layoutSoap trans(ds_input L) := TRANSFORM
	request := PROJECT(L, make_child_ds(LEFT));
	SELF.fcradataservicerequest := request;
	self := L;
END;

soap_input := DISTRIBUTE(project(dedup(sort(ds_input, did), did), trans(LEFT)),RANDOM() % nodes);

xlayout := RECORD
	layout_out;
	STRING errorcode;
END;

xlayout myFail(soap_input le) := TRANSFORM
	SELF.errorcode := FAILCODE +'  '+ FAILMESSAGE;
	SELF := [];
END;

soapResponse := soapcall( soap_input,
						serviceURL,
						service_name,
						{soap_input},
						DATASET(xlayout),
						PARALLEL(threads),
						onFail(myFail(LEFT))
						):independent
						;

Mac_Norm(DsIn,DsOut, rec):=Macro
	DsOut	:=	NORMALIZE(soapResponse, left.results.DsIn
					,TRANSFORM(iesp.fcradataservice.rec					
						,self:=right
						,self:=[]
						));
EndMacro;

Mac_Norm(Email,OutEmail,t_FcraDataServiceEmailData);
dNorm := OutEmail;
//output(dNorm, named('dNorm'));

dNorm1:=dNorm(Metadata.ComplianceFlags.IsSuppressed  or Metadata.ComplianceFlags.IsOverride  or Metadata.ComplianceFlags.IsOverwritten);
//output(dNorm1, named('dNorm1'));

dsOut :=table(dNorm1 , {Datagroup := Metadata.Datagroup
					,Did := Metadata.lexid
					,RecID :=trim(Metadata.RecID.RecID1)
						+	trim(Metadata.RecID.RecID2)
						+	trim(Metadata.RecID.RecID3)
						+	trim(Metadata.RecID.RecID4)
					,IsSuppressed:= max(group,Metadata.ComplianceFlags.IsSuppressed)
					,IsOverride := max(group,Metadata.ComplianceFlags.IsOverride)
					,IsOverwritten := max(group,Metadata.ComplianceFlags.IsOverwritten)
					,fname := Rawdata.clean_name.fname
					,lname := Rawdata.clean_name.lname
				  ,prim_range := Rawdata.clean_address.prim_range
				  ,prim_name := Rawdata.clean_address.prim_name
				  ,zip := Rawdata.clean_address.zip
					},Metadata.Datagroup
					,Metadata.lexid
					,trim(Metadata.RecID.RecID1)+trim(Metadata.RecID.RecID2)+trim(Metadata.RecID.RecID3)+trim(Metadata.RecID.RecID4)
					, merge):independent;
					
//OUTPUT(dsOut,NAMED('dsOut'));		

dsOut_candidates:= dedup(dsOut(IsOverride and ~IsOverwritten), all);

orphans_ds := dsOut_candidates;
output(orphans_ds, named('orphans_ds'));

overrides.mac_orphans_evaluate(email_data,'EMAIL_DATA',orphans_ds,dsout_email_data,,did,email_rec_key,,,,clean_name.fname, clean_name.lname, 
																																						clean_address.prim_range, clean_address.prim_name, clean_address.zip);
output(dsout_email_data, named('evaluate'));
//output(sort(dsout_email_data(did='43813639117'),recid), named('evaluate_by_did_43813639117'));

//qc
overrides_did_set := SET(orphans_ds, (unsigned)did);
payload_did_set := SET(dsout_email_data(recid != '0'), (unsigned)did);

overrided_by_did := overrides.Keys.email_data(did IN overrides_did_set);
//OUTPUT(overrided_by_did(did>0),NAMED('overrided_by_did'));

payload_by_did := overrides.payload_keys.email_data(did IN payload_did_set + overrides_did_set);
//OUTPUT(payload_by_did(did>0),NAMED('payload_by_did'));

overrides_keys_ds := Project(overrided_by_did, Transform(fcra.Layout_Override_Email_Data or {string version},
																						self.version := 'email_data_overrides_keys',
																						self := left));
																						
payload_keys_ds := Project(payload_by_did, Transform(fcra.Layout_Override_Email_Data or {string version},
																						self.version := 'email_data_payload_keys',
																						self.flag_file_id := '';
																						self := left));
cmb_keys_ds := sort(overrides_keys_ds + payload_keys_ds, RECORD);

//output(cmb_keys_ds, named('cmb_keys_ds'));


RecordOf(cmb_keys_ds) xform(cmb_keys_ds l) := Transform
	self.version := 'both';
	self := l;
End;	

cmb_keys_ds_dist_with := distribute(cmb_keys_ds, hash(did,email_rec_key, email_src, clean_name.fname, clean_name.lname, clean_address.prim_range, clean_address.prim_name, clean_address.zip));
rolled := Rollup(cmb_keys_ds_dist_with, xform(left), did,email_rec_key, email_src, clean_name.fname, clean_name.lname, clean_address.prim_range, clean_address.prim_name, clean_address.zip, local);

//Output(rolled(version='both'), named('Both_Overrides_Payload'));

//Output(SORT(rolled(version='email_data_overrides_keys'),did,email_rec_key), named('email_data_overrides_Only'));


//Output(SORT(rolled(version='email_data_payload_keys'),did,email_rec_key), named('email_data_payload_Only'));	

overrides_rolled_dedup := DEDUP(sort(rolled(version='email_data_overrides_keys'), did, email_rec_key), did, email_rec_key);
//Output(overrides_rolled_dedup, named('overrides_rolled_dedup'));

payloads_rolled_dedup := DEDUP(sort(rolled(version='email_data_payload_keys'), did, email_rec_key), did, email_rec_key);
//Output(sort(payloads_rolled_dedup,did,email_rec_key), named('payloads_rolled_dedup'));

diff_layout := record
	payloads_rolled_dedup.did;
	INTEGER override_did;
	STRING payload_version;
	STRING override_version;
	INTEGER payload_email_rec_key;
	INTEGER override_email_rec_key;
	STRING payload_clean_email;
	STRING override_clean_email;
	//key fields
	STRING payload_orig_pmghousehold_id;
	STRING override_orig_pmghousehold_id;
	STRING payload_orig_pmgindividual_id;
	STRING override_orig_pmgindividual_id;
	STRING payload_orig_first_name;
	STRING override_orig_first_name;
	STRING payload_orig_last_name;
	STRING override_orig_last_name;
	STRING payload_orig_address;
	STRING override_orig_address;
	STRING payload_orig_city;
	STRING override_orig_city;
	STRING payload_orig_state;
	STRING override_orig_state;
	STRING payload_orig_zip;
	STRING override_orig_zip;
	STRING payload_orig_zip4;
	STRING override_orig_zip4;
	STRING payload_orig_email;
	STRING override_orig_email;
	STRING payload_orig_ip;
	STRING override_orig_ip;
	STRING payload_orig_site;
	STRING override_orig_site;
	STRING payload_orig_e360_id;
	STRING override_orig_e360_id;
	STRING payload_orig_teramedia_id;
	STRING override_orig_teramedia_id;
	STRING payload_activecode;
	STRING override_activecode;
	STRING payload_email_src;
	STRING override_email_src;
	STRING diff_fields;
End;

diff_layout xform_diff(payloads_rolled_dedup l, overrides_rolled_dedup r) := Transform
	self.did := l.did;
	self.override_did := r.did;
	self.payload_version := l.version;
	self.payload_email_rec_key := l.email_rec_key;
	self.payload_email_src := l.email_src;
	self.payload_clean_email := l.clean_email;
	self.payload_orig_pmghousehold_id := l.orig_pmghousehold_id;
	self.payload_orig_first_name := l.orig_first_name;	
	self.payload_orig_last_name := l.orig_last_name;
	self.payload_orig_pmgindividual_id := l.orig_pmgindividual_id;
	self.payload_orig_address:=l.orig_address;
	self.payload_orig_city:=l.orig_city;
	self.payload_orig_state:=l.orig_state;
	self.payload_orig_zip:=l.orig_zip;
	self.payload_orig_zip4:=l.orig_zip4;
	self.payload_orig_email:=l.orig_email;
	self.payload_orig_ip:=l.orig_ip;
	self.payload_orig_site:=l.orig_site;
	self.payload_orig_e360_id:=l.orig_e360_id;
	self.payload_orig_teramedia_id:=l.orig_teramedia_id;
	self.payload_activecode:=l.activecode;
	
	
	self.override_version := r.version;	
	self.override_email_rec_key := r.email_rec_key;
	self.override_email_src := r.email_src;
	self.override_clean_email := r.clean_email;
	self.override_orig_pmghousehold_id := r.orig_pmghousehold_id;
	self.override_orig_pmgindividual_id := r.orig_pmgindividual_id;
	self.override_orig_first_name := r.orig_first_name;	
	self.override_orig_last_name := r.orig_last_name;
	self.override_orig_address := r.orig_address;
	self.override_orig_city:=r.orig_city;
	self.override_orig_state:=r.orig_state;
	self.override_orig_zip:=r.orig_zip;
	self.override_orig_zip4:=r.orig_zip4;
	self.override_orig_email:=r.orig_email;
	self.override_orig_ip:=r.orig_ip;
	self.override_orig_site:=r.orig_site;
  self.override_orig_e360_id:=r.orig_e360_id;	
	self.override_orig_teramedia_id:=r.orig_teramedia_id;
	self.override_activecode:=r.activecode;
	
	
	self.diff_fields := ROWDIFF(L,R);
End;


//check for PII with original email, keep override rec.
results := join(payloads_rolled_dedup(did>0), overrides_rolled_dedup, 
						left.orig_first_name = right.orig_first_name 
						and left.orig_last_name = right.orig_last_name
						and left.orig_email = right.orig_email,
						xform_diff(left,right),right only);
								
output(sort(results,override_did,override_email_rec_key), named('recs_only_in_overrides_by_name_last'));

//sanity check... all recs not in pay load by did
//did=43813639117
Output(sort(overrides_rolled_dedup(did=43813639117),did,email_rec_key), named('overrides_did_43813639117'));
output(sort(results(override_did=43813639117),override_did,override_email_rec_key), named('recs_only_in_overrides_did_43813639117'));

//by key=12129612305674016920 
Output(sort(overrides_rolled_dedup(email_rec_key=12129612305674016920),did,email_rec_key), named('overrides_key_6920'));
Output(sort(results(override_email_rec_key=12129612305674016920),override_did,override_email_rec_key), named('overrides_key_12129612305674016920'));


//did=1273443934	
Output(sort(overrides_rolled_dedup(did=1273443934),did,email_rec_key), named('overrides_did_1273443934'));
output(sort(results(override_did=1273443934),override_did,override_email_rec_key), named('recs_only_in_overrides_did_1273443934'));


//check for PII 2 in both files
results_matched := join(payloads_rolled_dedup(did>0), overrides_rolled_dedup, 
						left.orig_first_name = right.orig_first_name 
						and left.orig_last_name = right.orig_last_name,
						xform_diff(left,right),INNER);

output(sort(results_matched,did,override_email_rec_key), named('recs_in_both_by_pii'));

//sanity check 2
//did=43813639117
output(sort(results_matched(did=43813639117),did,override_email_rec_key), named('mathced_by_did_43813639117'));

//by key=12129612305674016920														
output(sort(results_matched(override_email_rec_key=12129612305674016920),did,override_email_rec_key), named('mathced_by_key_12129612305674016920'));

//by key=13524545324965377037
output(sort(results_matched(override_email_rec_key=13524545324965377037),did,override_email_rec_key), named('mathced_by_key_13524545324965377037'));

//did=1273443934
output(sort(results_matched(did=1273443934),did,override_email_rec_key), named('matached_by_did_1273443934'));

//by key=12332306654128455740
output(sort(results_matched(override_email_rec_key=12332306654128455740),did,override_email_rec_key), named('mathced_by_key_12332306654128455740'));
//by key=3734188155848909273
output(sort(results_matched(override_email_rec_key=3734188155848909273),did,override_email_rec_key), named('mathced_by_key_3734188155848909273'));

