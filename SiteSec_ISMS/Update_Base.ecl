IMPORT SiteSec_ISMS,lib_stringlib;

EXPORT Update_Base(DATASET(Layouts.Input)	pUpdateFile,
									 DATASET(Layouts.Base)	pBaseFile,
									 STRING	pversion) := FUNCTION
	
  /* Lookup File */
	LookupRec := RECORD
		STRING110 CertificationBody;
		STRING110 CertificationBodyDescrip;
	END;
	LookupFile := DATASET('~thor_data400::in::sitesec_isms::lookup::certificationbody',
											   LookupRec,CSV(SEPARATOR(['|'])));
 
	/* File with code value added */
	NewRec := RECORD
		STRING110 CertificationBodyDescrip;
		Layouts.Input;
	END;
	
  NewRec JoinFiles(Layouts.Input L, LookupRec R) := TRANSFORM
		SELF.CertificationBodyDescrip := StringLib.StringToUpperCase(R.CertificationBodyDescrip);
		SELF.CertificationType := IF(L.CertificationType = 'ISOIEC 270012005',
		                                                 	 'ISO IEC 27001 2005',
																										   L.CertificationType);
		SELF := L;
	END;

	JoinedLookup := JOIN(	pUpdateFile, LookupFile,
												StringLib.StringToUpperCase(LEFT.CertificationBody)=StringLib.StringToUpperCase(RIGHT.CertificationBody),
												JoinFiles(LEFT,RIGHT),LOOKUP, LEFT OUTER );
	
	SiteSec_ISMS.Layouts.Base tMapping(NewRec L) := TRANSFORM
			SELF.Date_FirstSeen := L.DateAdded;
			SELF.Date_LastSeen  := L.DateUpdated;
			SELF := L;
	END;
		
	dMapping := PROJECT(JoinedLookup,tMapping(LEFT));
	
	update_combined	:= IF(SiteSec_ISMS._Flags.Update, 
											  dMapping + pBaseFile, 
											  dMapping) : PERSIST('persist::SiteSec_ISMS::Combined'); 
													
	dRollupBase	 := Rollup_Base	(update_combined);
   
	RETURN dRollupBase;
	
END;