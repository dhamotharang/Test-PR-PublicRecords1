IMPORT Overrides,_Control,iesp;

//search properties by did,persistent_record_id
Overrides.MAC_read_override_base('PROPERTY_SEARCH',PropertySearchRecIDs,flag_file_id,did,ln_fares_id,,,,false);
property_ds := PropertySearchRecIDs;

output(property_ds, named('property_ds'));

//search deeds by ln_fares_id
Overrides.MAC_read_override_base('DEED',PropertyDeedSearchRecIDs,flag_file_id,,ln_fares_id,,,,false);
deed_ds := PropertyDeedSearchRecIDs;

output(SORT(deed_ds,did), named('deed_ds'));
//NOTE: deeds do not have dids hence the join by recid/ln_fares_id

output(count(deed_ds), named('deed_ds_cnt'));	

deeds_properties_layout := RECORD(RECORDOF(deed_ds))
	STRING rec_type;
END;

deeds_properties_layout xform(property_ds L, deed_ds R):= TRANSFORM
	SELF.rec_type := R.datagroup;
	SELF :=L;
END;

combined_prop_deed :=join(property_ds,deed_ds, 
                                   LEFT.recid = RIGHT.recid, 
																	 xform(LEFT,RIGHT),INNER);									 
																	 
																	 
//TODO maybe dedup this rec set 
ds_input:=combined_prop_deed;																 
output(SoRT(ds_input,did), named('override_base_ds'));
output(count(ds_input), named('ds_input_cnt'));

service_name	:= 'ConsumerDisclosure.FCRADataService';
//NOTE: try the prod_batch_fcra service.
//serviceURL		:= _Control.RoxieEnv.staging_fcra_roxieIP;
serviceURL		:= _Control.RoxieEnv.prod_batch_fcra;

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

output(soap_input, named('soap_input'));

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
	DsOut	:=	NORMALIZE(soapResponse, 
											left.results.DsIn,
											TRANSFORM(iesp.fcradataservice.rec,self:=right,self:=[])
											);
EndMacro;


Mac_Norm(PropertyDeed,OutPropertyDeedSearch,t_FcraDataServicePropertyDeed);

dNorm_results := OutPropertyDeedSearch;

//note accesing ln_fares_id works.
output(dNorm_results(GroupBy.ln_fares_id ='DD0015622901'), named('dNorm_results_by_ln_fares_id'));
output(dNorm_results(DEED[1].metadata.lexid !=''), named('dNorm_results_by_ln_fares_id2'));

//**************************************************************************************************************
layout_deed_data := RECORDOF(iesp.fcradataservice.t_FcraDataServicePropertyDeedData);
layout_search_data := RECORDOF(iesp.fcradataservice.t_FcraDataServicePropertySearchData);

layout_prop_deed := RECORD
	STRING groupby_fares_id;
	STRING Deed_LexId;
 	STRING Deed_Fares_Id_RecID1;
	STRING Deed_Datagroup;
	BOOLEAN Deed_IsSuppressed;
	BOOLEAN Deed_IsOverwritten;
	BOOLEAN Deed_IsOverride;
	BOOLEAN Deed_IsDisputed;
	STRING Deed_Raw_Fares_Id;
	////NOTE: the deed.rawdata has state,county among others.
END;

layout_prop_deed prop_deed_xform (layout_deed_data L, STRING fares_id):= TRANSFORM
	 
   SELF.groupby_fares_id := fares_id;	 
	 SELF.Deed_LexId := L.metadata.LexId;
	 SELF.Deed_Fares_Id_RecID1 := L.metadata.RecID.RecId1;
	 SELF.Deed_Datagroup := L.metadata.Datagroup;
	 SELF.Deed_IsSuppressed := L.metadata.ComplianceFlags.IsSuppressed;
	 SELF.Deed_IsOverwritten := L.metadata.ComplianceFlags.IsOverwritten;
	 SELF.Deed_IsOverride := L.metadata.ComplianceFlags.IsOverride;
	 SELF.Deed_IsDisputed := L.metadata.ComplianceFlags.IsDisputed;
	 SELF.Deed_Raw_Fares_Id := L.rawdata.ln_fares_id;
   SELF := L;
	 
END;

layout_prop_deed_search := RECORD
	STRING groupby_fares_id;
	STRING Search_LexId;
 	STRING Search_Sequence_RecID1;
	STRING Search_Datagroup;
	BOOLEAN Search_IsSuppressed;
	BOOLEAN Search_IsOverwritten;
	BOOLEAN Search_IsOverride;
	BOOLEAN Search_IsDisputed;
	STRING  Search_Raw_Fares_Id;
	STRING  Search_Raw_fname;
	STRING  Search_Raw_mname;
	STRING  Search_Raw_lname;
	STRING  Search_Raw_prim_range;
	STRING  Search_Raw_zip;
	STRING  Search_Raw_zip4;
	INTEGER  Search_Raw_did;
	INTEGER  Search_Raw_bdid;
	INTEGER  Search_Raw_persistent_record_id;
END;

layout_prop_deed_search prop_deed_search_xform (layout_search_data L, STRING fares_id):= TRANSFORM
	 
   SELF.groupby_fares_id := fares_id;	 
	 SELF.Search_LexId := L.metadata.LexId;
	 SELF.Search_Sequence_RecID1 := L.metadata.RecID.RecId1;
	 SELF.Search_Datagroup := L.metadata.Datagroup;
	 SELF.Search_IsSuppressed := L.metadata.ComplianceFlags.IsSuppressed;
	 SELF.Search_IsOverwritten := L.metadata.ComplianceFlags.IsOverwritten;
	 SELF.Search_IsOverride := L.metadata.ComplianceFlags.IsOverride;
	 SELF.Search_IsDisputed := L.metadata.ComplianceFlags.IsDisputed;
	 SELF.Search_Raw_Fares_Id := L.rawdata.ln_fares_id;
	 SELF.Search_Raw_fname := L.rawdata.fname;
	 SELF.Search_Raw_mname := L.rawdata.mname;
	 SELF.Search_Raw_lname := L.rawdata.lname;
	 SELF.Search_Raw_prim_range := L.rawdata.prim_range;
	 SELF.Search_Raw_zip := L.rawdata.zip;
	 SELF.Search_Raw_zip4 := L.rawdata.zip4;
	 SELF.Search_Raw_did := L.rawdata.did;
	 SELF.Search_Raw_bdid := L.rawdata.bdid;
	 SELF.Search_Raw_persistent_record_id := L.rawdata.persistent_record_id;
   SELF := L;
	 
END;
deeds_normed := normalize(dNorm_results,LEFT.deed,prop_deed_xform(RIGHT, LEFT.GroupBy.ln_fares_id));
output(deeds_normed, named('deeds_normed'));

deed_search_normed := normalize(dNorm_results,LEFT.search,prop_deed_search_xform(RIGHT, LEFT.GroupBy.ln_fares_id));
output(deed_search_normed, named('deed_search_normed'));

Combined_rec := join(deeds_normed,deed_search_normed,LEFT.groupby_fares_id = RIGHT.groupby_fares_id, inner);
output(Combined_rec, named('Combined_rec'));
//*****************************************************************************************************************

////filter by flags.
deed_filter := Combined_rec(Deed_IsSuppressed  or Deed_IsOverride  or Deed_IsOverwritten);
output(deed_filter, named('deed_filter'));
output(COUNT(deed_filter), named('cnt_deed_filter'));

search_filter := Combined_rec(Search_IsSuppressed  or Search_IsOverride  or Search_IsOverwritten);
output(search_filter, named('search_filter'));
output(COUNT(search_filter), named('cnt_search_filter'));

// flat ds					
					dsOut_deed :=table(Combined_rec , {Datagroup := Deed_Datagroup
					,Did := Deed_lexid
					,RecID :=trim(Deed_Fares_Id_RecID1)
					,IsSuppressed:= max(group,Deed_IsSuppressed)
					,IsOverride := max(group,Deed_IsOverride)
					,IsOverwritten := max(group,Deed_IsOverwritten)
					,ln_fares_id := Search_Raw_Fares_Id
					,fname := Search_Raw_fname
					,lname := Search_Raw_lname
					,prim_range := Search_Raw_prim_range
					,zip := Search_Raw_zip
					
					}
					,Deed_Datagroup
					,Deed_lexid
					,trim(Deed_Fares_Id_RecID1)
					, merge):independent;

////DEED
OUTPUT(dsOut_deed,NAMED('dsOut_deed'));

dsOut_candidates_deed:= dedup(dsOut_deed(IsOverride and ~IsOverwritten), all);

orphans_ds_deed := dsOut_candidates_deed;

OUTPUT(SORT(orphans_ds_deed,did),NAMED('orphans_deed_list'));


orphans := orphans_ds_deed(datagroup ='DEED');

////payload keys 
payload_key := pull(overrides.payload_Keys.property.deed);

OUTPUT(payload_key,NAMED('payload_key'));

// deed_mortgage_layout := ln_propertyv2.layout_deed_mortgage_common_model_base;

// rec_layout := RECORD(recordof(deed_mortgage_layout))
	// STRING override_did;
	// STRING override_recid;
	// STRING payload_recid;

// END;

rec_layout := RECORD(recordof(payload_key))
	STRING override_did;
	STRING override_recid;
	
END;


// rec_layout xfrom(deed_mortgage_layout L, orphans R) := TRANSFORM
	// self.override_did := R.did;
	// self.override_recid := R.recid;
	// self.payload_recid := L.ln_fares_id;
	// self := L;
// END;

// rec_layout xfrom(deed_mortgage_layout L, orphans R) := TRANSFORM
	// self.override_did := R.did;
	// self.override_recid := R.recid;
	// self.payload_recid := L.ln_fares_id;
	// self := L;
// END;


// payload_key tjoin_search_payload(payload_key le, orphans ri) := transform

// self := le;

// end;

rec_layout tjoin_search_payload(payload_key le, orphans ri) := transform
	self.override_did := ri.did;
	self.override_recid := ri.recid;
	self := le;
end;


// dsout := join(payload_key, orphans,left.ln_fares_id = right.recid,xform(LEFT,RIGHT));
dsout := join(payload_key, orphans,/*(unsigned)left.lexid = (unsigned)right.did and*/ left.ln_fares_id = right.ln_fares_id,
										tjoin_search_payload(left,right));

OUTPUT(dsout,NAMED('dsout'));





