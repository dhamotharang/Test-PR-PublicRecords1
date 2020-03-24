IMPORT Overrides,_Control,iesp,paw,fcra;

//qc
EXPORT BWR_PAW_Orphans := MODULE
overridesList:=Evaluate_PAW_orphans.getOverridesOrphans;
//Output(overridesList);
//Output(count(overridesList));
overrides_did_set := SET(overridesList, (unsigned)did);
//Output(overrides_did_set);

payloadList:=Evaluate_PAW_orphans.getPayloadOrphans(overridesList);
//Output(payloadList);
payload_did_set := SET(payloadList, (unsigned)did_payload);
//Output(payload_did_set);

overrided_by_did := overrides.Keys.paw(did IN overrides_did_set);

payload_by_did := overrides.payload_keys.paw(did IN payload_did_set + overrides_did_set);

paw_overrides_keys_ds := Project(overrided_by_did, Transform(fcra.Layout_Override_PAW or {string version},
																						self.version := 'paw_overrides_keys',
																						self := left));
																						
paw_payload_keys_ds := Project(payload_by_did, Transform(fcra.Layout_Override_PAW or {string version},
																						self.version := 'paw_payload_keys',
																						self.flag_file_id := '';
                                            self := left));

cmbpaw := sort(paw_overrides_keys_ds + paw_payload_keys_ds, RECORD);

RecordOf(cmbpaw) xform(cmbpaw l) := Transform
	self.version := 'both';
	self := l;
End;	

cmbpaw_dist := distribute(cmbpaw, HASH32(contact_id,did));

combined_sorted := sort(cmbpaw_dist,contact_id,did,local);

rolled := Rollup(combined_sorted, xform(left), contact_id,did,local);

//Output(SORT(rolled(version='both'),did), named('Both_Overrides_Payload'));

//Output(SORT(rolled(version='paw_overrides_keys'),did), named('paw_overrides_Only'));

//Output(SORT(rolled(version='paw_payload_keys'),did), named('paw_payload_keys_Only'));	
//TODO testing with did = 2205923793
//Output(SORT(rolled(version='paw_payload_keys',did=2205923793),bdid), named('paw_payload_keys_test'));

overrides_paw := rolled(version='paw_overrides_keys');
payload_qc := rolled(version='paw_payload_keys');

sorted_overrides := sort(overrides_paw,contact_id,did, ssn);

deduped_overrides:= DEDUP(sorted_overrides,contact_id,did,ssn);

sorted_payload_qc := sort(payload_qc,contact_id,did, ssn);

deduped_sorted_payload_qc:= DEDUP(sorted_payload_qc,contact_id,did, ssn);

diff_layout := record
	INTEGER payload_did;
	INTEGER overrides_did;
	STRING l_version;
	STRING r_version;
	INTEGER payload_contact_id;
	INTEGER overrides_contact_id;
  STRING  payload_company_status;
	STRING  overrides_company_status;
	//KEY FIELDS
	INTEGER payload_bdid;
	INTEGER overrides_bdid;
	STRING  payload_ssn;
	STRING  overrides_ssn;
  STRING payload_company_name;	
	STRING overrides_company_name;	
	STRING payload_company_prim_range;
	STRING overrides_company_prim_range;
	STRING payload_company_predir;
	STRING overrides_company_predir;
  STRING payload_company_prim_name;
	STRING overrides_company_prim_name;
	STRING payload_company_addr_suffix;
	STRING overrides_company_addr_suffix;
	STRING payload_company_unit_desig;
	STRING overrides_company_unit_desig;
	STRING payload_company_sec_range;
	STRING overrides_company_sec_range;
	STRING payload_company_city;
	STRING overrides_company_city;
	STRING payload_company_state;
	STRING overrides_company_state;
	STRING payload_company_zip;
	STRING overrides_company_zip;
	STRING payload_company_title;
	STRING overrides_company_title;
	STRING payload_company_phone;
	STRING overrides_company_phone;
	STRING payload_company_fein;
	STRING overrides_company_fein;
	STRING payload_fname;
	STRING overrides_fname;
	STRING payload_mname;
  STRING overrides_mname;
	STRING payload_lname;	
  STRING overrides_lname;
	STRING payload_name_suffix;
	STRING overrides_name_suffix;
	STRING payload_prim_range;
	STRING overrides_prim_range;
	STRING payload_predir;
	STRING overrides_predir;
	STRING payload_prim_name;
	STRING overrides_prim_name;
	STRING payload_addr_suffix;
	STRING overrides_addr_suffix;
	STRING payload_unit_desig;
	STRING overrides_unit_desig;
	STRING payload_sec_range;
	STRING overrides_sec_range;
	STRING payload_city;
	STRING overrides_city;
	STRING payload_state;
	STRING overrides_state;
	STRING payload_zip;
	STRING overrides_zip;
	STRING payload_phone;
  STRING overrides_phone;
	STRING payload_email_address;
	STRING overrides_email_address;
	STRING payload_source;
	STRING overrides_source;
		
	STRING diff;
End;

diff_layout xform_diff(payload_qc payload,overrides_paw  override) := Transform
	
	SELF.payload_did              := payload.did;
	SELF.overrides_did            := override.did;
	SELF.l_version                := payload.version;
	SELF.r_version                := override.version;
	SELF.payload_contact_id       := payload.contact_id;
	SELF.overrides_contact_id     := override.contact_id;
  SELF.payload_company_status   := payload.company_status;
	SELF.overrides_company_status := override.company_status;
	//KEY FIELDS
	SELF.payload_bdid             := payload.bdid;
	SELF.overrides_bdid           := override.bdid;
	SELF.payload_ssn              := payload.ssn;
	SELF.overrides_ssn            := override.ssn;
  SELF.payload_company_name     := payload.company_name;
	SELF.overrides_company_name   := override.company_name;
	SELF.payload_company_prim_range := payload.company_prim_range;
  SELF.overrides_company_prim_range := override.company_prim_range;
	SELF.payload_company_predir       := payload.company_predir;
	SELF.overrides_company_predir     := override.company_predir;
  SELF.payload_company_prim_name    := payload.company_prim_name;
	SELF.overrides_company_prim_name  := override.company_prim_name;
	SELF.payload_company_addr_suffix  := payload.company_addr_suffix;
	SELF.overrides_company_addr_suffix := override.company_addr_suffix;
	SELF.payload_company_unit_desig    := payload.company_unit_desig;
	SELF.overrides_company_unit_desig  := override.company_unit_desig;
	SELF.payload_company_sec_range     := payload.company_sec_range;
	SELF.overrides_company_sec_range   := override.company_sec_range;
	SELF.payload_company_city          := payload.company_city;
	SELF.overrides_company_city        := override.company_city;
	SELF.payload_company_state         := payload.company_state;
	SELF.overrides_company_state       := override.company_state;
	SELF.payload_company_zip           := payload.company_zip;
	SELF.overrides_company_zip         := override.company_zip;
	SELF.payload_company_title         := payload.company_title;
	SELF.overrides_company_title       := override.company_title;;
	SELF.payload_company_phone         := payload.company_phone;
	SELF.overrides_company_phone       := override.company_phone;
	SELF.payload_company_fein          := payload.company_fein;
	SELF.overrides_company_fein        := override.company_fein;;
	SELF.payload_fname                 := payload.fname;
	SELF.overrides_fname               := override.fname;;
	SELF.payload_mname                 := payload.mname;
  SELF.overrides_mname							 := override.mname;;
	SELF.payload_lname                 := payload.lname;
  SELF.overrides_lname               := override.lname;;
	SELF.payload_name_suffix           := payload.name_suffix;
	SELF.overrides_name_suffix         := override.name_suffix;;
	SELF.payload_prim_range            := payload.prim_range;
	SELF.overrides_prim_range          := override.prim_range;;
	SELF.payload_predir                := payload.predir;
	SELF.overrides_predir              := override.predir;
	SELF.payload_prim_name             := payload.prim_name;
	SELF.overrides_prim_name           := override.prim_name;
	SELF.payload_addr_suffix           := payload.addr_suffix;
	SELF.overrides_addr_suffix         := override.addr_suffix;
	SELF.payload_unit_desig            := payload.unit_desig;
	SELF.overrides_unit_desig          := override.unit_desig;
	SELF.payload_sec_range             := payload.sec_range;
	SELF.overrides_sec_range           := override.sec_range;
	SELF.payload_city                  := payload.city;
	SELF.overrides_city                := override.city;
	SELF.payload_state                 := payload.state;
	SELF.overrides_state               := override.state;
	SELF.payload_zip                   := payload.zip;
	SELF.overrides_zip                 := override.zip;
	SELF.payload_phone                 := payload.phone;
  SELF.overrides_phone               := override.phone;
	SELF.payload_email_address         := payload.email_address;
	SELF.overrides_email_address       := override.email_address;
	SELF.payload_source                := payload.source;
	SELF.overrides_source              := override.source;;
	
	SELF.diff := ROWDIFF(payload,override);
End;

matched_dids := join(deduped_sorted_payload_qc,deduped_overrides, left.did = right.did and left.contact_id != right.contact_id,xform_diff(left,right));	

//matched_keys := join(deduped_sorted_payload_qc,deduped_overrides, left.did != right.did and left.contact_id = right.contact_id,xform_diff(left,right));	
matched_keys := join(deduped_sorted_payload_qc,deduped_overrides, left.contact_id = right.contact_id,xform_diff(left,right));
matched_PII_data := join(deduped_sorted_payload_qc,deduped_overrides, left.did = right.did 
																																			 and  left.bdid = right.bdid 
                                                                     //and left.fname = right.fname 
																																			//and left.mname = right.mname
																																			//and left.lname = right.lname
																																			//and left.city  = right.city
																																			//and left.state = right.state
																																			,xform_diff(left,right));	

combined_output := matched_dids + matched_keys;

orphan_layout := record
	deduped_overrides;
	string diff;
End;


orphan_layout orphan_xform(combined_output  l, deduped_overrides r) := Transform
	self.diff := l.diff;
	self :=r;
End;

true_orphans := join(combined_output,deduped_overrides, left.payload_did = right.did,orphan_xform(left,right),RIGHT ONLY);

Layout_Orphans_common final_xform(true_orphans L) := TRANSFORM
		
		//TOOD maybe use constant for dataset name
    SELF.DatasetName := 'PAW';
		SELF.Did := L.did;
		SELF.RecId := L.contact_id;

END;


EXPORT result := project(true_orphans,final_xform(LEFT));
END;														 

