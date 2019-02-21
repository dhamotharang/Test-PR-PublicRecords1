EXPORT macComputePersonGsaDetails(dIn, InName,InClassification,InCTType,InDescription,InActionDate,
  InTermDate,InTermDateIndefinite,InCTCode,InAgencycomponent,InHasGsa, 
  InEntityContextUID,inAppendFields,appendPrefix = '\'\'') := FUNCTIONMACRO
  IMPORT Relavator, ecl;
  
  LOCAL rAppended := ecl.macComputeAppendFieldsRecord(inAppendFields, '');
  LOCAL rDetails := RECORD
    STRING GsaName;
    STRING GsaClassification;
    STRING GsaCTType;
    STRING GsaDescription;
    STRING GsaActionDate;
    STRING GsaTermDate;
    STRING1 GsaTermDateIndefinite;
    STRING GsaCTCode;
    STRING GsaAgencycomponent;
    STRING GraphId;
    INTEGER PersonHasGsa;
    STRING PersonHasGsaDescription;
  END;
  
  LOCAL dDetails := PROJECT(dIn, TRANSFORM({#EXPAND(rAppended)} OR rDetails,
    SELF.PersonHasGsaDescription := IF((BOOLEAN)LEFT.InHasGsa, 'Y', 'N'),
    SELF.PersonHasGsa := IF((BOOLEAN)LEFT.InHasGsa, 1, 0),
    SELF.GsaClassification := LEFT.InClassification,
    SELF.GsaName := LEFT.InName,
    SELF.GsaCTType := LEFT.InCTType,
    SELF.GsaCTCode := LEFT.InCTCode,
    SELF.GsaDescription := LEFT.InDescription,
    SELF.GsaActionDate := LEFT.InActionDate,
    SELF.GsaTermDate := LEFT.InTermDate,
    SELF.GsaTermDateIndefinite := LEFT.InTermDateIndefinite,
    SELF.Gsaagencycomponent := LEFT.InAgencyComponent,
    SELF.GraphId := LEFT.InEntityContextUID,
    SELF := LEFT));
    
  RETURN dDetails;
ENDMACRO;