IMPORT PersonContext;

EXPORT Keys := MODULE
	
	EXPORT KEY_LexID := INDEX(DATASET([],PersonContext.Layouts.layout_deltakey_personcontext),
														{LexID},
														{RecID1,RecID2,RecID3,RecID4,CD_id,DataGroup,RecordType,DataTypeVersion,DateAdded,EventType,SourceSystem,StatementSequence,StatementID,Content},
                            '~key::personcontext_deltakey::delta_key::lexid_qa');
																		
	EXPORT KEY_RecID := INDEX(DATASET([],PersonContext.Layouts.layout_deltakey_personcontext),
														{recid1,recid2,recid3,recid4},
														{LexID,CD_id,DataGroup,RecordType,DataTypeVersion,DateAdded,EventType,SourceSystem,StatementSequence,StatementID,Content},
                            '~key::personcontext_deltakey::delta_key::recid_qa');

END;                                  
	