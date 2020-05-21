Import _Control,iesp,ConsumerDisclosure;
//IMPORT Overrides,_Control,iesp;

Overrides.MAC_read_override_base('Assessment',PropertyAssessmentRecIDs,flag_file_id,,(string)ln_fares_id,,,,false);//no DID, use flag file

// PropertyDeed
Overrides.MAC_read_override_base('Deed',PropertyDeedRecIDs,flag_file_id,,(string)ln_fares_id,,,,false);//no DID, use flag file

// DeedByResidence
Overrides.MAC_read_override_base('Property_Search',PropertySearchRecIDs,flag_file_id,did,(string)persistent_record_id,,,,false);

GetOverrideBases := PropertyAssessmentRecIDs + PropertyDeedRecIDs + PropertySearchRecIDs;

	
ds_input := GetOverrideBases;
output(SORT(ds_input,datagroup), named('ds_input'));
//output(COUNT(ds_input), named('ds_input_count_total'));
//output(COUNT(ds_input(datagroup='DEED')), named('ds_input_count_deed'));
//output(COUNT(ds_input(datagroup='ASSESSMENT')), named('ds_input_count_assessment'));
//output(COUNT(ds_input(datagroup='PROPERTY_SEARCH')), named('ds_input_count_prop_search'));

	
service_name	:= 'ConsumerDisclosure.FCRADataService';
serviceURL		:= _Control.RoxieEnv.staging_fcra_roxieIP ;

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
	SELF.Options.DatasetSelection.IncludeAll := true;
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
	DsOut	:=	NORMALIZE(soapResponse, 
											left.results.DsIn,
											TRANSFORM(iesp.fcradataservice.rec,self:=right,self:=[])
											);
EndMacro;

//Property Deed Search
Mac_Norm(PropertyDeed,OutPropertyDeedSearch,t_FcraDataServicePropertyDeed);

dNorm :=  OutPropertyDeedSearch;
		 
OUTPUT(dNorm,NAMED('dNorm'));

dNorm1:=dNorm(search[1].metadata.ComplianceFlags.IsSuppressed  or search[1].metadata.ComplianceFlags.IsOverride  or search[1].metadata.ComplianceFlags.IsOverwritten);

OUTPUT(dNorm1,NAMED('dNorm1'));

dsOut :=table(dNorm1 , {Datagroup := search[1].Metadata.Datagroup
					,Did := search[1].Metadata.lexid
					,RecID :=trim(search[1].Metadata.RecID.RecID1)
						+	trim(search[1].Metadata.RecID.RecID2)
						+	trim(search[1].Metadata.RecID.RecID3)
						+	trim(search[1].Metadata.RecID.RecID4)
					,IsSuppressed:= max(group,search[1].Metadata.ComplianceFlags.IsSuppressed)
					,IsOverride := max(group,search[1].Metadata.ComplianceFlags.IsOverride)
					,IsOverwritten := max(group,search[1].Metadata.ComplianceFlags.IsOverwritten)
					,ln_fares_id := search[1].Rawdata.ln_fares_id					
					,fname := search[1].Rawdata.fname
					,lname := search[1].Rawdata.lname
					,prim_name := search[1].Rawdata.prim_name
					,prim_range := search[1].Rawdata.prim_range
					,zip := search[1].Rawdata.zip}
					,search[1].Metadata.Datagroup
					,search[1].Metadata.lexid
					,trim(search[1].Metadata.RecID.RecID1)+trim(search[1].Metadata.RecID.RecID2)+trim(search[1].Metadata.RecID.RecID3)+trim(search[1].Metadata.RecID.RecID4)
					, merge):independent;
				
OUTPUT(dsOut,NAMED('dsOut'));		
dsOut_candidates:= dedup(dsOut(IsOverride and ~IsOverwritten), all);

orphans_ds := dsOut_candidates;

OUTPUT(SORT(orphans_ds,did),NAMED('orphans_List'));

//params:payload keys from prop search only,prop search,outrecord,Property Assessment
overrides.mac_orphans_evaluate(property.property_search,'Property_Search',orphans_ds,dsout_property_search,,did,(string)persistent_record_id,,,,,,,,);
OUTPUT(SORT(dsout_property_search,did),NAMED('dsout_property_search'));
OUTPUT(COUNT(dsout_property_search),NAMED('dsout_property_search_cnt'));

//qc

overrides_did_set := SET(orphans_ds, (unsigned)did);
payload_did_set := SET(dsout_property_search, (unsigned)did_payload);

overrided_by_did := overrides.Keys.property.property_search(did IN overrides_did_set);
//OUTPUT(overrided_by_did(did>0),NAMED('overrided_by_did'));


payload_by_did := overrides.payload_keys.property.property_search(did IN payload_did_set + overrides_did_set);
//OUTPUT(payload_by_did(did>0),NAMED('payload_by_did'));


prop_overrides_keys_ds := Project(overrided_by_did, Transform(ln_propertyv2.layout_search_building or {string version},
																						self.version := 'prop_overrides_keys',
																					 	self := left));
																						
prop_payload_keys_ds := Project(payload_by_did, Transform(ln_propertyv2.layout_search_building or {string version},
																						self.version := 'prop_payload_keys',
																						self := left));

cmbprop := sort(prop_overrides_keys_ds(did>0) + prop_payload_keys_ds(did>0), RECORD);
OUTPUT(cmbprop(did>0),NAMED('cmbprop'));

RecordOf(cmbprop) xform(cmbprop l) := Transform
	self.version := 'both';
	self := l;
End;

//Note:using persistent_record_id
cmbprop_dist := distribute(cmbprop, HASH32(persistent_record_id,did));

combined_sorted := sort(cmbprop_dist,persistent_record_id,did,local);
rolled := Rollup(combined_sorted, xform(left), persistent_record_id,did,local);

Output(rolled(version='both'), named('Both_Overrides_Payload'));

Output(SORT(rolled(version='prop_overrides_keys'),did), named('prop_overrides_Only'));

Output(SORT(rolled(version='prop_payload_keys'),did), named('prop_payload_keys_Only'));	

//sanaty check 550192661
OUTPUT(SORT(orphans_ds(did='550192661'),did),NAMED('orphans_List_did_550192661'));
Output(SORT(rolled(version='prop_overrides_keys',did=550192661),did), named('prop_overrides_did_550192661'));
