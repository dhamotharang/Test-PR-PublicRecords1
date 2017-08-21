import doxie,doxie_raw,MFind;

doxie.MAC_Header_Field_Declare()

string84 Vd := '': stored('VID');

outrec := MFind_services.layout_search_IDs;

//********* Autokeys
byak := MFind_services.autokey_ids(false, false,NoDeepDive);

//********* DIDS
dids :=if(~NoDeepDive,doxie.get_dids(true,true));

by_did :=MFind_services.MFind_raw.get_Vids_from_dids(dids);


//*********Vid
uVd :=stringlib.stringtouppercase(trim(Vd,all));
byVID := if(uVd <> '', dataset([{uVd}],MFind_services.layout_VID));



Vids := 
	dedup(sort( byak + project(byVid,transform(outrec,self.isDeepDive:=FALSE,self :=left))+
				 project(by_did,transform(outrec,self.isDeepDive :=TRUE,self :=left)),
				 Vid,if(isDeepDive,1,0)),Vid);



export MFindSearchService_ids := Vids;