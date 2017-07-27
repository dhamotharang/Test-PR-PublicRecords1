import doxie,doxie_raw,MFind;

doxie.MAC_Header_Field_Declare()

export MFindSearchService_ids(MFindV2_Services.InterFaces.VID param) := FUNCTION


	outrec := MFindV2_Services.layout_search_IDs;

	//********* Autokeys
	byak := MFindV2_Services.autokey_ids(TRUE, false,NoDeepDive);

	//********* DIDS
	dids :=if(~NoDeepDive,doxie.get_dids(true,true));

	by_did :=MFindV2_Services.MFind_raw.get_Vids_from_dids(dids);


	//*********Vid
	uVd :=stringlib.stringtouppercase(trim(Param.Vd,all));
	byVID := if(uVd <> '', dataset([{uVd}],MFindV2_Services.layout_VID));



	Vids := 
		dedup(sort( byak + project(byVid,transform(outrec,self.isDeepDive:=FALSE,self :=left))+
					 project(by_did,transform(outrec,self.isDeepDive :=TRUE,self :=left)),
					 Vid,if(isDeepDive,1,0)),Vid);
	
	Return Vids;

END;


