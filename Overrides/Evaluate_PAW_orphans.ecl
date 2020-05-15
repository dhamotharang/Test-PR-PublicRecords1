IMPORT Overrides,_Control,iesp,paw;


EXPORT Evaluate_PAW_orphans := MODULE

	SHARED layout:= RECORD
	
		STRING datagroup;
		STRING12 did;
		STRING recID;
		BOOLEAN IsSuppressed;
		BOOLEAN IsOverride;
		BOOLEAN IsOverwritten;
		STRING fname;
		STRING lname;
		STRING prim_name;
		STRING prim_range;
		STRING zip; 

	END;

////////////////////////////////////////
	EXPORT getOverridesOrphans := FUNCTION
			Overrides.MAC_read_override_base('Paw',PeopleAtWorkRecIDs,flag_file_id,did,contact_id,,,,false);

			ds_input := PeopleAtWorkRecIDs;

			//output(ds_input, named('override_base_ds'));
			//output(count(ds_input), named('ds_input_cnt'));

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
	//output(soap_input, named('soap_input'));

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
//output(soapResponse(LexId='1358759713'), named('soapResponse'));
Mac_Norm(DsIn,DsOut, rec):=Macro
	DsOut	:=	NORMALIZE(soapResponse, 
											left.results.DsIn,
											TRANSFORM(iesp.fcradataservice.rec,self:=right,self:=[])
											);
EndMacro;

Mac_Norm(PeopleAtWork,OutPAW,t_FcraDataServicePAWData);

dNorm := OutPAW;

dNorm1:=dNorm(Metadata.ComplianceFlags.IsSuppressed  or Metadata.ComplianceFlags.IsOverride  or Metadata.ComplianceFlags.IsOverwritten);

// dsOut :=table(dNorm1 ,
					// {Datagroup := Metadata.Datagroup
					// ,Did := Metadata.lexid
					// ,RecID :=trim(Metadata.RecID.RecID1)
						// +	trim(Metadata.RecID.RecID2)
						// +	trim(Metadata.RecID.RecID3)
						// +	trim(Metadata.RecID.RecID4)
					// ,IsSuppressed:= max(group,Metadata.ComplianceFlags.IsSuppressed)
					// ,IsOverride := max(group,Metadata.ComplianceFlags.IsOverride)
					// ,IsOverwritten := max(group,Metadata.ComplianceFlags.IsOverwritten)
					// ,fname := Rawdata.fname
					// ,lname := Rawdata.lname
					// ,prim_name := Rawdata.prim_name
					// ,prim_range := Rawdata.prim_range
					// ,zip := Rawdata.zip 
					// }
					// ,Metadata.Datagroup
					// ,Metadata.lexid
					// ,trim(Metadata.RecID.RecID1)+trim(Metadata.RecID.RecID2)+trim(Metadata.RecID.RecID3)+trim(Metadata.RecID.RecID4)
					// , merge):independent;
					
////////////////////////////////////////////////////////////////////////////					
//transform
layout xform(dNorm1 L):=TRANSFORM
	SELF.datagroup		 := L.Metadata.Datagroup; 
	SELF.did					 := L.Metadata.lexid;
	SELF.RECID 				 := trim(L.Metadata.RecID.RecID1)
												+ trim(L.Metadata.RecID.RecID2)
												+	trim(L.Metadata.RecID.RecID3)
						            +	trim(L.Metadata.RecID.RecID4);
												
	//NOTE:without max =124 records returned											
	SELF.IsSuppressed  := L.Metadata.ComplianceFlags.IsSuppressed;
	//SELF.IsSuppressed  := max(group,L.Metadata.ComplianceFlags.IsSuppressed);
	
	SELF.IsOverride    := L.Metadata.ComplianceFlags.IsOverride;
	//SELF.IsOverride    := max(group,L.Metadata.ComplianceFlags.IsOverride);
	
	SELF.IsOverwritten := L.Metadata.ComplianceFlags.IsOverwritten;
	//SELF.IsOverwritten := max(group,L.Metadata.ComplianceFlags.IsOverwritten);
	

	SELF.fname 				:= L.Rawdata.fname;
	SELF.lname 				:= L.Rawdata.lname;
	SELF.prim_name 		:= L.Rawdata.prim_name;
	SELF.prim_range 	:= L.Rawdata.prim_range;
	SELF.zip 				  := L.Rawdata.zip;

END;
				
dsOut := project(dNorm1,xform(LEFT));		

//////////////////////////////////////////////////////////////
dsOut_candidates:= dedup(dsOut(IsOverride and ~IsOverwritten), all);

orphans_ds := dsOut_candidates;

//OUTPUT(SORT(orphans_ds,did),NAMED('orphans_List'));
	
		RETURN orphans_ds;
	END;
	
	EXPORT getPayloadOrphans(DATASET(layout) ds) := FUNCTION
			overrides.mac_orphans_evaluate(Paw,'PAW',ds,dsout_paw,,did,contact_id,,,,fname,lname,prim_range,prim_name, zip);
		RETURN dsout_paw;
	END;
///////////////////////////////////////////////////	
END;