EXPORT macAnonymizeBusiness(dInput, CompanyName, FEIN='') := FUNCTIONMACRO
	IMPORT Anonymizer;
  LOCAL dOutput := PROJECT(dInput, 
    TRANSFORM(RECORDOF(LEFT),
      SELF.CompanyName := IF(LEFT.CompanyName <> '', Anonymizer.fnBusinessNameReplace(LEFT.CompanyName), ''),	
      #IF(#TEXT(FEIN) != '')
        SELF.FEIN := (TYPEOF(LEFT.FEIN))IF((UNSIGNED)LEFT.FEIN <> 0,((STRING)HASH32(LEFT.FEIN))[1..9],''), 
			#END
      SELF := LEFT));
  RETURN dOutput;
ENDMACRO;