Import _Control,iesp,ConsumerDisclosure;
//IMPORT Overrides,_Control,iesp;

Overrides.MAC_read_override_base('Assessment',PropertyAssessmentRecIDs,flag_file_id,,(string)ln_fares_id,,,,false);//no DID, use flag file

// PropertyDeed
Overrides.MAC_read_override_base('Deed',PropertyDeedRecIDs,flag_file_id,,(string)ln_fares_id,,,,false);//no DID, use flag file
// DeedByResidence
Overrides.MAC_read_override_base('Property_Search',PropertySearchRecIDs,flag_file_id,did,(string)persistent_record_id,,,,false);


GetOverrideBases := PropertyAssessmentRecIDs + PropertyDeedRecIDs + PropertySearchRecIDs;
	
ds_input := GetOverrideBases;
	
service_name	:= 'ConsumerDisclosure.FCRADataService';
//serviceURL		:= _Control.RoxieEnv.prod_batch_fcra ;
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

output(soapResponse(LexId='1428483971'), named('soapResponse'));
												
// r:=	{
	// soapResponse.results.headerdata.Metadata.LexID;
	// soapResponse.results.headerdata.Metadata.DataGroup;
	// soapResponse.results.headerdata.Metadata.RecID;
	// soapResponse.results.headerdata.Metadata.StatementID;
	// soapResponse.results.headerdata.Metadata.ComplianceFlags;
	// soapResponse.results.headerdata.Rawdata;
	// };

// layout_prop := RECORD(RECORDOF(iesp.fcradataservice_common.t_FcraDataServiceMetadata)AND RECORDOF(iesp.fcradataservice_raw.t_FcraDataServiceRawPropertyDeed) )
 	// STRING rectType;

// END;

// layout_prop

//TODO create a transform to get both meta and raw data.
Mac_Norm(DsIn,DsOut,rec):=Macro
	DsOut	:=	NORMALIZE(soapResponse, left.results.DsIn
					,TRANSFORM(iesp.fcradataservice_common.t_FcraDataServiceMetadata
						,self.LexID:=right.Metadata.LexID
					  ,self.DataGroup:=right.Metadata.DataGroup
						,self.RecID:=right.Metadata.RecID
						,self.StatementID:=right.Metadata.StatementID
						,self.ComplianceFlags:=right.Metadata.ComplianceFlags
						//,self.rawdata:=right.Rawdata,
						,self:=right
						,self:=[]
						));
EndMacro;


//Mac_Norm(PropertyAssessment.assessment,OutPropertyAssessment,t_FcraDataServicePropertyAssessmentData);
//Mac_Norm(PropertyAssessment.search,OutPropertyAssessmentSearch,t_FcraDataServicePropertyAssessmentData);
Mac_Norm(PropertyDeed.deed,OutPropertyDeed,t_FcraDataServicePropertyDeedData);
Mac_Norm(PropertyDeed.search,OutPropertyDeedSearch,t_FcraDataServicePropertyDeedData);
/*Mac_Norm(DeedByResidence.deed,OutDeedByResidence);
Mac_Norm(DeedByResidence.search,OutDeedByResidenceSearch);
Mac_Norm(AssessmentByResidence.assessment,OutAssessmentByResidence);
Mac_Norm(AssessmentByResidence.search,OutAssessmentByResidenceSearch);*/

dNorm :=		OutPropertyDeed
		+ OutPropertyDeedSearch;
	//	OutPropertyAssessment
	//	+ OutPropertyAssessmentSearch;
	/*	+ OutPropertyDeed
		+ OutPropertyDeedSearch
		+ OutDeedByResidence
		+ OutDeedByResidenceSearch
		+ OutAssessmentByResidence
		+ OutAssessmentByResidenceSearch;*/
		

OUTPUT(dNorm,NAMED('dNorm'));

//dNorm1:=dNorm(~ComplianceFlags.IsPropagatedCorrection, ComplianceFlags.IsSuppressed  or ComplianceFlags.IsOverride  or ComplianceFlags.IsOverwritten);
dNorm1:=dNorm(ComplianceFlags.IsSuppressed  or ComplianceFlags.IsOverride  or ComplianceFlags.IsOverwritten);

OUTPUT(dNorm1,NAMED('dNorm1'));

dsOut :=table(dNorm1 , {Datagroup
					,lexid
					,RecID_:=trim(RecID.RecID1)
						+	trim(RecID.RecID2)
						+	trim(RecID.RecID3)
						+	trim(RecID.RecID4)
					,IsSuppressed_:=max(group,ComplianceFlags.IsSuppressed)
					,IsOverride_:=max(group,ComplianceFlags.IsOverride)
					,IsOverwritten_:=max(group,ComplianceFlags.IsOverwritten)
					// ,fname := Rawdata.fname
					// ,lname := Rawdata.lname
					// ,prim_name := Rawdata.prim_name
					// ,prim_range := Rawdata.prim_range
					// ,zip := Rawdata.zip 
					},Datagroup
					,lexid
					,trim(RecID.RecID1)+trim(RecID.RecID2)+trim(RecID.RecID3)+trim(RecID.RecID4)
					,merge):independent;
					
				
OUTPUT(dsOut,NAMED('dsOut'));		
		dsOut_candidates:= dedup(dsOut(IsOverride_ and ~IsOverwritten_), all);

orphans_ds := dsOut_candidates;

OUTPUT(SORT(orphans_ds,LexId),NAMED('orphans_List'));

//overrides.mac_orphans_evaluate(property.deed,'Deed',orphans_ds,dsout_deed,,,ln_fares_id,,,,,,,,);
//overrides.mac_orphans_evaluate(property,'Deed',orphans_ds,dsout_deed,,,ln_fares_id,,,,,,,,);

// OUTPUT(SORT(dsout_paw,did),NAMED('evaluated_DEED'));