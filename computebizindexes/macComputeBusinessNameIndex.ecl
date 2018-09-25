EXPORT macComputeBusinessNameIndex(dIn, InRecordId, InLegalName, InDBAName, InUltBusinessName, InSeleBusinessName, InProxBusinessName, InJobId, keyName) := FUNCTIONMACRO
  IMPORT ML, STD;
	InputPrep := PROJECT(dIn,
									TRANSFORM(
											ML.Docs.Types.Raw,
											SELF.ID := LEFT.InRecordId,
											SELF.Txt := LEFT.InLegalName + ' '+LEFT.InDBAName + ' '+LEFT.InUltBusinessName + ' ' + LEFT.InSeleBusinessName + ' ' + LEFT.InProxBusinessName 
							 ));

	InputWords := ML.Docs.CoLocation.Words(InputPrep);
	InputAllNGrams := ML.Docs.CoLocation.AllNGrams(InputWords,,4);
	
	rKey := RECORD
		RECORDOF(dIn);
		STRING200 CompanyName;
	END;
  
	LOCAL InputAllNGramsWithDocuments := JOIN(dIn, InputAllNGrams, 
    LEFT.InRecordId=RIGHT.Id, 
    TRANSFORM(rKey, 
      SELF.CompanyName := RIGHT.NGram, 
      SELF := LEFT), 
    HASH);  
  
	fRemoveCharacters(STRING toClean) := FUNCTION
    RETURN STD.str.ToUpperCase(STD.str.CleanSpaces(REGEXREPLACE('[-~^ *&%#@!_<>?|/,.]+',toClean,' ')));
  END;
  
	LOCAL InputLegal := PROJECT(dIn(InLegalName <> ''), 
		TRANSFORM(rKey,	
      SELF.CompanyName := fRemoveCharacters(LEFT.InLegalName), 
      SELF := LEFT));
	LOCAL InputDBA := PROJECT(dIn(InDBAName <> ''), 
		TRANSFORM(rKey,	
      SELF.CompanyName := fRemoveCharacters(LEFT.InDBAName), 
      SELF := LEFT));
	LOCAL BestSele := PROJECT(dIn(InSeleBusinessName <> ''), 
		TRANSFORM(rKey,	
      SELF.CompanyName := fRemoveCharacters(LEFT.InSeleBusinessName), 
      SELF := LEFT));
	LOCAL BestProx := PROJECT(dIn(InProxBusinessName <> ''), 
		TRANSFORM(rKey,	
      SELF.CompanyName := fRemoveCharacters(LEFT.InProxBusinessName), 
      SELF := LEFT));
		
	LOCAL dKey := InputAllNGramsWithDocuments + InputLegal + InputDBA + BestSele + BestProx;
  
  LOCAL strKeyName      := '~biz::key::'+ (STRING)keyName + 'name::' + (STRING)InJobId;
	LOCAL KeyBusinessName := INDEX(dKey, {CompanyName}, {dKey}, strKeyName);
  RETURN KeyBusinessName;
ENDMACRO;