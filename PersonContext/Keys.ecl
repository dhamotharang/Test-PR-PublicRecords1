IMPORT PersonContext, vault, _control;

EXPORT Keys := MODULE
	
#IF(_Control.Environment.onVault) 
	EXPORT KEY_LexID := vault.PersonContext.Keys.Key_LexID;
#ELSE
	EXPORT KEY_LexID := INDEX(DATASET([],PersonContext.Layouts.layout_deltakey_personcontext),
														{LexID},
														{RecID1,RecID2,RecID3,RecID4,CD_id,DataGroup,RecordType,DataTypeVersion,DateAdded,EventType,SourceSystem,StatementSequence,StatementID,Content},
                            '~key::personcontext_deltakey::delta_key::lexid_qa');
#END;

	
#IF(_Control.Environment.onVault) 
	EXPORT KEY_RecID := vault.PersonContext.Keys.Key_RecID;
#ELSE
	EXPORT KEY_RecID := INDEX(DATASET([],PersonContext.Layouts.layout_deltakey_personcontext),
														{recid1,recid2,recid3,recid4},
														{LexID,CD_id,DataGroup,RecordType,DataTypeVersion,DateAdded,EventType,SourceSystem,StatementSequence,StatementID,Content},
                            '~key::personcontext_deltakey::delta_key::recid_qa');
#END;																		
	
														


END;                                  
	