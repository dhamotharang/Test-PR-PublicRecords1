import header,doxie,ut,data_services,Relationship;


relative_alpharetta := header.File_Relatives_Insurance(true);
/*
//key is copied from Alpharetta, but these are the filters that are applied to the data (FYI):

													(true) // replace() above. True is required to use suppression logic
													(
															 did1>0
															,did2>0,
															 NOT(			Confidence in ['LOW','NOISE'] 
																		OR (type = '2ND DEGREE' AND confidence = 'MEDIUM')
																	)
													)
*/

relTitled := project(relative_alpharetta, Relationship.layout_output.titled);
relNeutral := Relationship.functions_output.convertTitledToKey(relTitled);

indexed_layout := RECORD
   relNeutral.did1;
  END;
	
payload_layout := record
		Relationship.layout_output.key AND NOT did1;
end;

payload := project(relNeutral,payload_layout);

export Key_Relatives_v3 := INDEX(relNeutral
																,indexed_layout
																,payload_layout
																,data_services.Data_Location.Relatives 
																		+'thor_data400::key::relatives_v3_' + version_superkey);