EXPORT macComputeFacilityNameIndex(Infile, RecID, FacilityName, JobID, keyName, GCID) := FUNCTIONMACRO
 IMPORT ML, HealthCareFacility;
	
	InputPrep := PROJECT(Infile (FacilityName <> ''), TRANSFORM(ML.Docs.Types.Raw, SELF.ID  := LEFT.RecID,	
				SELF.Txt := HealthCareFacility.clean_facility_name (LEFT.FacilityName)));

	InputWords := ML.Docs.CoLocation.Words(InputPrep);
	
	InputAllNGrams := ML.Docs.CoLocation.AllNGrams(InputWords,,4);
	
	rKey := RECORD
		RECORDOF(Infile);
		STRING120 CompanyName;
	END;
  
  InDs := DISTRIBUTE(Infile, HASH(RecID));
	NGramsDs := DISTRIBUTE(InputAllNGrams, HASH(Id));
	
	LOCAL InputAllNGramsWithDocuments := JOIN(InDs, NGramsDs, LEFT.RecID = RIGHT.Id, 
						    TRANSFORM(rKey, SELF.CompanyName := RIGHT.NGram, SELF := LEFT), MANY LOOKUP, LOCAL);

	LOCAL dKey := InputAllNGramsWithDocuments;
  
  LOCAL strKeyName      := '~sa::key::' + (STRING)keyName + '::' + (STRING)GCID + '::' + (STRING)JobId;
	
	LOCAL KeyFacilityName := INDEX(dKey, {CompanyName}, {dKey}, strKeyName);

  RETURN KeyFacilityName;
ENDMACRO;