Import Data_Services, PRTE2_Liens, liensv2, Doxie, ut;

arecord:= RECORD
	PRTE2_Liens.Layouts.party_base;
END;

EXPORT key_liens_SourceRecID := index(dataset([],arecord),{persistent_record_id},{TMSID,RMSID}, Constants.KEY_PREFIX + doxie.Version_SuperKey + '::party::SourceRecId');