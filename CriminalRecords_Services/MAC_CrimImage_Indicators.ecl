EXPORT MAC_CrimImage_Indicators(inrecs,outrecs) := MACRO
  IMPORT SexOffender_Services, ut;

	#uniquename(slim_layout);
	%slim_layout% := record
		string12 did;
		boolean hasCriminalImages := false;
		boolean hasSexualOffenderImages := false;		
	end;

	#uniquename(inrecs_slim);
	%inrecs_slim% := project(inrecs, transform(%slim_layout%, self := left));

	#uniquename(inrecs_slim_dedup);
	%inrecs_slim_dedup% := 	dedup(sort(%inrecs_slim%, did), did);

	// criminal images section.
	#uniquename(hasCriminalImages);
		RECORDOF(%inrecs_slim_dedup%) %hasCriminalImages%(RECORDOF(%inrecs_slim_dedup%) L,RECORDOF(doxie_files.Key_Offenders()) R) := TRANSFORM
			SELF.hasCriminalImages:= R.image_link != ''; 
			SELF:=L;
	END;

	#uniquename(crimRecs);
	%crimRecs% := JOIN(%inrecs_slim_dedup%,doxie_files.Key_Offenders(),
									KEYED((UNSIGNED6)LEFT.did=RIGHT.sdid),
									%hasCriminalImages%(LEFT,RIGHT),
									LIMIT(ut.limits.OFFENDERS_PER_DID,SKIP));

	//only need 1 record atmost
	#uniquename(crimRecs_dedup);	
	%crimRecs_dedup% := dedup(sort(%crimRecs%(hasCriminalImages),did), did);
		
	// sexoffender image section.
	#uniquename(sospks); 
	%sospks% := join(%inrecs_slim_dedup%, SexOffender.Key_SexOffender_DID(),
								KEYED((UNSIGNED6)LEFT.did=RIGHT.did),
								LIMIT(ut.limits.SOFFENDER_MAX,SKIP));

	#uniquename(hasSexualOffenderImages)
		RECORDOF(%sospks%) %hasSexualOffenderImages%(RECORDOF(%sospks%) L,RECORDOF(SexOffender.key_SexOffender_SPK()) R) := TRANSFORM
			SELF.hasSexualOffenderImages:= R.image_link != '';
			SELF:=L;
	END;

	#uniquename(sorec);
	%sorec% := join(%sospks%, SexOffender.key_SexOffender_SPK(),  
							keyed(left.seisint_primary_key=right.sspk),
							%hasSexualOffenderImages%(LEFT,RIGHT),
							LIMIT(SexOffender_Services.Constants.MAX_RECS_PERDID, SKIP));

	//only need 1 record atmost
	#uniquename(soRecs_dedup);		
	%soRecs_dedup% := dedup(sort(%sorec%(hasSexualOffenderImages),did), did);

	#uniquename(combinedRecs);	
	%combinedRecs% := join(inrecs, %crimRecs_dedup%,
											left.did = right.did,
											transform (RECORDOF(inrecs), 
												self.hasCriminalImages := right.hasCriminalImages,
												self := left),
											left outer, limit(0), keep(1));	

	outrecs := join(%combinedRecs%, %soRecs_dedup%,
							left.did = right.did,
							transform (RECORDOF(inrecs),
								self.hasSexualOffenderImages := right.hasSexualOffenderImages,
								self := left),
							left outer, limit(0), keep(1));
ENDMACRO;