IMPORT  doxie,mdr,BIPV2, Data_Services; 

EXPORT keys := MODULE

  EXPORT key_Lexid := INDEX(FILES.DS_out_LexID_sort, {LexID},  
	                    {RecID1,RecID2,RecID3,RecID4,CD_id,DataGroup,RecordType,DataTypeVersion,DateAdded,EventType,SourceSystem,StatementSequence,StatementID,Content},
	                    constants.Lexid_Key + doxie.Version_SuperKey);
	
	EXPORT KEY_RecID := INDEX(Files.DS_out_RecID,{recid1,recid2,recid3,recid4},
														{LexID,CD_id,DataGroup,RecordType,DataTypeVersion,DateAdded,EventType,SourceSystem,StatementSequence,StatementID,Content},
                            constants.Recid_Key + doxie.Version_SuperKey);


	

End;