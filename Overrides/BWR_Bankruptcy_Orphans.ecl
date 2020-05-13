Import _Control,iesp,ConsumerDisclosure;

//NOTE: did is also recid4 in mac params.
Overrides.MAC_read_override_base('BANKRUPT_SEARCH',BkSearchRecIDs,flag_file_id,did,tmsid,name_type,did);

//NOTE: Whend DID =000000 is an attoreny record.

ds_input := dedup(sort(BkSearchRecIDs, -flag_file_id),except flag_file_id,keep(1));
output(sort(ds_input,did), named('ds_input'));
output(count(ds_input), named('ds_input_cnt'));

service_name	:= 'ConsumerDisclosure.FCRADataService';
serviceURL		:= _Control.RoxieEnv.prod_batch_fcra ;
//serviceURL		:= _Control.RoxieEnv.staging_fcra_roxieIP ;

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


r:=	{
	
		soapResponse.Results.Bankruptcy.search.Metadata.LexID;
		soapResponse.Results.Bankruptcy.search.Metadata.DataGroup;
		soapResponse.Results.Bankruptcy.search.Metadata.RecID;
		soapResponse.Results.Bankruptcy.search.Metadata.StatementID;
		soapResponse.Results.Bankruptcy.search.Metadata.ComplianceFlags;
		soapResponse.Results.Bankruptcy.search[1].Rawdata;	
	
	
	};

Mac_Norm(DsIn,DsOut):=Macro
	DsOut	:=	NORMALIZE(soapResponse, left.results.DsIn
					,TRANSFORM(r
						,self.LexID:=right.Metadata.LexID
						,self.DataGroup:=right.Metadata.DataGroup
						,self.RecID:=right.Metadata.RecID
						,self.StatementID:=right.Metadata.StatementID
						,self.ComplianceFlags:=right.Metadata.ComplianceFlags
						,self:=right
						,self:=[]
						));
EndMacro;


Mac_Norm(Bankruptcy.search,OutBankruptcy);

output(OutBankruptcy, named('OutBankruptcy'));
output(count(OutBankruptcy), named('OutBankruptcy_cnt'));
output(OutBankruptcy((unsigned)lexid = 1058676806),named('OutBankruptcy_1058676806'));


dNorm:=OutBankruptcy(ComplianceFlags.IsSuppressed  or ComplianceFlags.IsOverwritten or ComplianceFlags.IsOverride);
output(dNorm, named('dNorm'));
output(count(dNorm), named('dNorm_cnt'));
//here count is reduced to 12 because of the flags on line 96.
output(dNorm((unsigned)lexid = 1058676806),named('dNorm_1058676806'));

	
bkn_layout:= RECORD
	STRING 		datagroup; 
	STRING12 	did;
	STRING 		tmsid;
	STRING 		name_type;
	STRING    fname;
	STRING    lname;
	STRING    prim_name;
	STRING    prim_range;
	STRING    zip;
	STRING 		RECID;
	boolean 	IsSuppressed; 
	boolean 	IsOverride;
	boolean 	IsOverwritten; 

END;					


bkn_layout bnk_xform(dNorm L) := TRANSFORM

  SELF.datagroup		 := L.Datagroup; 
	SELF.did					 := L.lexid;
	SELF.tmsid 				 := L.Rawdata.tmsid;
	SELF.RECID 				 := trim(L.RecID.RecID1)
												+ trim(L.RecID.RecID2)
												+	trim(L.RecID.RecID3)
						            +	trim(L.RecID.RecID4);
	SELF.IsSuppressed  := L.ComplianceFlags.IsSuppressed; 
	SELF.IsOverride    := L.ComplianceFlags.IsOverride;
	SELF.IsOverwritten := L.ComplianceFlags.IsOverwritten; 

	SELF.name_type 		:= L.Rawdata.name_type;
  SELF.fname 				:= L.Rawdata.fname;
	SELF.lname 				:= L.Rawdata.lname;
	SELF.prim_name 		:= L.Rawdata.prim_name;
	SELF.prim_range 	:= L.Rawdata.prim_range;
	SELF.zip 				  := L.Rawdata.zip;

END;


dsOut:= project(dNorm,bnk_xform(LEFT));					
	
output(dsOut, named('dsOut'));
OUTPUT(COUNT(dsOut),NAMED('dsOut_cnt'));
output(dsOut((unsigned)did = 1058676806), named('dsOut_by_id_1058676806'));

dsOut_candidates:= dedup(dsOut(IsOverride and ~IsOverwritten), all);
orphans_ds := dsOut_candidates;

OUTPUT(SORT(orphans_ds,did),NAMED('orphans_List'));
OUTPUT(COUNT(orphans_ds),NAMED('orphans_ds_cnt'));
output(orphans_ds((unsigned)did = 1058676806), named('orphans_ds_by_id_1058676806'));

overrides.mac_orphans_evaluate(bankrupt_search,'BANKRUPTCY_SEARCH',orphans_ds,dsout_bk_search,,did,tmsid,name_type,did,,,,,,);

OUTPUT(SORT(dsout_bk_search,did),NAMED('evaluate_bk_search'));
OUTPUT(COUNT(dsout_bk_search),NAMED('evaluate_bk_search_cnt'));
OUTPUT(dsout_bk_search((unsigned)did = 1058676806),NAMED('evaluate_bk_search_1058676806'));


//qc
overrides_did_set := SET(orphans_ds, did);
payload_did_set := SET(dsout_bk_search, did_payload);

overrided_by_did := overrides.Keys.bankrupt_search(did IN overrides_did_set);
//output(overrided_by_did);
//output(overrided_by_did(tmsid='BKCT0021351678'));


//payload_by_did := overrides.payload_keys.bankrupt_search(did IN payload_did_set + overrides_did_set);
payload_by_did := overrides.payload_keys.bankrupt_search(did IN payload_did_set);
//output(payload_by_did);
//output(payload_by_did(tmsid='BKCT0021351678'));

																																								
bnk_search_overrides_keys_ds := Project(overrided_by_did, Transform(FCRA.layout_search_ffid_v3 or {string version},
																						self.version := 'bnk_search_overrides_keys',
																						self := left));																						
																						
bnk_search_payload_keys_ds := Project(payload_by_did, Transform(FCRA.layout_search_ffid_v3 or {string version},
																						self.version := 'bnk_search_payload_keys',
																					  self.flag_file_id := '';
                                            self := left));

cmb_bnk_search := sort(bnk_search_overrides_keys_ds + bnk_search_payload_keys_ds, RECORD);
//output(cmb_bnk_search(flag_file_id='964381'));

RecordOf(cmb_bnk_search) xform(cmb_bnk_search l) := Transform
	self.version := 'both';
	self := l;
End;	

cmb_bnk_search_dist := distribute(cmb_bnk_search, HASH32(tmsid,name_type,(unsigned6)did));
//cmb_bnk_search_dist := distribute(cmb_bnk_search, HASH32(tmsid,did));


combined_sorted := sort(cmb_bnk_search_dist,tmsid,name_type,(unsigned6)did,local);
//combined_sorted := sort(cmb_bnk_search_dist,tmsid,did,local);
//output(combined_sorted(flag_file_id='964381'));
//rolled := Rollup(combined_sorted, xform(left), tmsid,name_type,did,local);

rolled := Rollup(combined_sorted, xform(left),tmsid,name_type,(unsigned6)did,local);

both_bnk := rolled(version='both');
Output(SORT(both_bnk,(unsigned6)did), named('Both_Overrides_Payload'));	

overrides_bnk := rolled(version='bnk_search_overrides_keys');
Output(SORT(overrides_bnk,(unsigned6)did), named('bnk_search_overrides_Only'));

payload_bnk := rolled(version='bnk_search_payload_keys');
Output(SORT(payload_bnk,(unsigned6)did), named('bnk_search_payload_keys_Only'));		


sorted_overrides := sort(overrides_bnk,tmsid,name_type,(unsigned6)did);
//sorted_overrides := sort(overrides_bnk,tmsid,did);


deduped_overrides:= DEDUP(sorted_overrides,tmsid,name_type,(unsigned6)did);
//deduped_overrides:= DEDUP(sorted_overrides,tmsid,did);

sorted_payload_bnk := sort(payload_bnk,tmsid,name_type,(unsigned6)did);
//sorted_payload_bnk := sort(payload_bnk,tmsid,did);

deduped_sorted_payload_bnk:= DEDUP(sorted_payload_bnk,tmsid,name_type,(unsigned6)did);	
//deduped_sorted_payload_bnk:= DEDUP(sorted_payload_bnk,tmsid,did);	

//NOTE: this dataset has a recid field not the same as recid from evaluate rec=tmsid+name_type+did
diff_layout := record

  STRING payload_tmsid;              
	STRING overrides_tmsid;
	STRING payload_name_type;              
	STRING overrides_name_type;
	STRING payload_did;               
	STRING overrides_did; 
	STRING payload_rec_id;       
	STRING overrides_rec_id;
  STRING l_version;                
	STRING r_version;               
	 
	//FIELDS
	STRING payload_bdid;             
	STRING overrides_bdid;           
	STRING payload_ssn;              
	STRING overrides_ssn;           
	
	STRING diff;
End;

diff_layout xform_diff(payload_bnk payload,overrides_bnk  override) := Transform
	
	
	SELF.l_version                := payload.version;
	SELF.r_version                := override.version;
	SELF.payload_rec_id           := payload.recid;
	SELF.overrides_rec_id         := override.recid;
  
	//KEY FIELDS
  SELF.payload_tmsid              := payload.tmsid;
	SELF.overrides_tmsid            := override.tmsid;	
	SELF.payload_name_type          := payload.name_type;
	SELF.overrides_name_type        := override.name_type;
	SELF.payload_did                := payload.did;
	SELF.overrides_did              := override.did;
	
	SELF.payload_bdid             := payload.bdid;
	SELF.overrides_bdid           := override.bdid;
	SELF.payload_ssn              := payload.ssn;
	SELF.overrides_ssn            := override.ssn;
  		
	SELF.diff := ROWDIFF(payload,override);
End;

matched_dids := join(deduped_sorted_payload_bnk,deduped_overrides, (unsigned6)left.did = (unsigned6)right.did 
																																	    // and  left.tmsid != right.tmsid 
                                                                      // and left.name_type != right.name_type
																																			 ,xform_diff(left,right),lookup);		


matched_recId_data := join(deduped_sorted_payload_bnk,deduped_overrides, (unsigned6)left.did = (unsigned6)right.did 
																																			 and  left.tmsid = right.tmsid 
                                                                       and left.name_type = right.name_type
																																			 ,xform_diff(left,right),lookup);

matched_PII_data := join(deduped_sorted_payload_bnk,deduped_overrides, left.orig_name = right.orig_name 
																																			 and  left.orig_lname = right.orig_lname 
                                                                       and left.app_ssn = right.app_ssn
																																			 ,xform_diff(left,right),lookup);																																			 
																																			 
combined_output := matched_dids + matched_recId_data+ matched_PII_data;


orphan_layout := record
	deduped_overrides;
	string diff;
End;


orphan_layout orphan_xform(combined_output  l, deduped_overrides r) := Transform
	self.diff := l.diff;
	self :=r;
End;

true_orphans := join(combined_output,deduped_overrides, (unsigned6)left.payload_did = (unsigned6)right.did,orphan_xform(left,right),RIGHT ONLY);
															 
output(SORT(matched_dids,overrides_did), named('matched_dids'));
output(SORT(matched_recId_data,overrides_did), named('matched_recId_data'));
output(SORT(matched_PII_data,overrides_did), named('matched_PII_data'));
output(SORT(true_orphans,did), named('true_orphans'));	

//sanity check orphan id=345534539   
output(payload_bnk(caseid='19331374'), named('payload_caseid_19331374'));
output(payload_bnk(ssn='624804665'), named('payload_ssn'));
output(payload_bnk(tmsid='BKCA0130714653'), named('payload_tmsid_BKCA0130714653'));
output(payload_bnk(tmsid='BKCA0131215183'), named('payload_tmsid_BKCA0131215183'));
//output(both_bnk(did='002577553480'), named('both_lexid_1058676806'));		

