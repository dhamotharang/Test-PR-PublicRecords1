EXPORT macComputePrimaryNameIndex(Infile, RecID, PrimaryName, JobID, KeyName, GCID) := FUNCTIONMACRO
  IMPORT ML;
	
	InputPrep       := PROJECT(Infile(PrimaryName <> ''), TRANSFORM(ML.Docs.Types.Raw, SELF.ID := LEFT.RecID, SELF.Txt := LEFT.PrimaryName;));
	InputWords      := ML.Docs.Tokenize.Split(InputPrep); //ML.Docs.CoLocation.Words(InputPrep);
	InputAllNGrams  := ML.Docs.CoLocation.AllNGrams(InputWords,, 4);
	
	KeyRec := RECORD
		RECORDOF(Infile);
		STRING28 StreetName;
	END;
  
  InDs := DISTRIBUTE(Infile, HASH(RecID));
	NGramsDs := DISTRIBUTE(InputAllNGrams, HASH(Id));
	
	LOCAL InputAllNGramsWithDocuments := JOIN(InDs, NGramsDs, LEFT.RecID = RIGHT.Id, TRANSFORM(KeyRec, SELF.StreetName := RIGHT.NGram; SELF := LEFT;), MANY LOOKUP, LOCAL);
  
	LOCAL KeyDs       := InputAllNGramsWithDocuments;
  LOCAL KeyFile     := '~sa::key::' + (STRING)KeyName + '::' + (STRING)GCID + '::' + (STRING)JobId;
	LOCAL KeyPrimaryName  := INDEX(KeyDs, {StreetName}, {KeyDs}, KeyFile);

  RETURN KeyPrimaryName;
ENDMACRO;