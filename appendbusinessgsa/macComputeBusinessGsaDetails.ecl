EXPORT macComputeBusinessGsaDetails(dIn,InClassification,InCTType,InDescription,InActionDate,
  InTermDate,InTermDateIndefinite,InExclusionType,InCTCode,InAgencycomponent,
  InExclusionType,InSamNumber,InBipLevel,InHasGsa,
  InBusinessNameFields, InBusinessAddressFields, InGraphIdFields,
  inAppendFields, appendPrefix = '\'\'')  := FUNCTIONMACRO
  IMPORT Relavator, ecl, Normalizer;
  
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
    STRING GsaExclusionType;
    STRING GsaSamNumber;
    STRING GraphId;
    STRING BusinessName;
    STRING BusinessAddress;
    INTEGER BusinessHasGsa;
    STRING BusinessHasGsaDescription;
  END;
  LOCAL FieldMap := Normalizer.macComputeFieldMap('BusinessName', InBusinessNameFields)
        +','+ Normalizer.macComputeFieldMap('BusinessAddress', InBusinessAddressFields)
        +','+ Normalizer.macComputeFieldMap('GraphId', InGraphIdFields);
  LOCAL dBusinessNormalizedOut := Normalizer.FN_NormalizeRecord(dIn, FieldMap, , TRUE);
  
  LOCAL dDetails := PROJECT(dBusinessNormalizedOut, TRANSFORM({#EXPAND(rAppended)} OR rDetails,
    SELF.BusinessHasGsaDescription := IF((BOOLEAN)LEFT.InHasGsa AND ((LEFT.InBipLevel = 'Sele' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 4) OR (LEFT.InBipLevel = 'Prox' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 7)), 'Y', 'N'),
    SELF.BusinessHasGsa := IF((BOOLEAN)LEFT.InHasGsa AND ((LEFT.InBipLevel = 'Sele' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 4) OR (LEFT.InBipLevel = 'Prox' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 7)), 1, 0),
    SELF.GsaClassification := IF((LEFT.InBipLevel = 'Sele' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 4) OR (LEFT.InBipLevel = 'Prox' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 7), LEFT.InClassification, ''),
    SELF.GsaName := IF((LEFT.InBipLevel = 'Sele' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 4) OR (LEFT.InBipLevel = 'Prox' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 7), LEFT.BusinessName, ''),
    SELF.GsaCTType := IF((LEFT.InBipLevel = 'Sele' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 4) OR (LEFT.InBipLevel = 'Prox' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 7), LEFT.InCTType, ''),
    SELF.GsaCTCode := IF((LEFT.InBipLevel = 'Sele' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 4) OR (LEFT.InBipLevel = 'Prox' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 7), LEFT.InCTCode, ''),
    SELF.GsaDescription := IF((LEFT.InBipLevel = 'Sele' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 4) OR (LEFT.InBipLevel = 'Prox' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 7), LEFT.InDescription, ''),
    SELF.GsaActionDate := IF((LEFT.InBipLevel = 'Sele' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 4) OR (LEFT.InBipLevel = 'Prox' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 7), LEFT.InActionDate, ''),
    SELF.GsaTermDate := IF((LEFT.InBipLevel = 'Sele' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 4) OR (LEFT.InBipLevel = 'Prox' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 7), LEFT.InTermDate, ''),
    SELF.GsaTermDateIndefinite := IF((LEFT.InBipLevel = 'Sele' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 4) OR (LEFT.InBipLevel = 'Prox' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 7), LEFT.InTermDateIndefinite, ''),
    SELF.GsaExclusionType := IF((LEFT.InBipLevel = 'Sele' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 4) OR (LEFT.InBipLevel = 'Prox' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 7), LEFT.InExclusionType, ''),
    SELF.Gsaagencycomponent := IF((LEFT.InBipLevel = 'Sele' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 4) OR (LEFT.InBipLevel = 'Prox' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 7), LEFT.InAgencyComponent, ''),
    SELF.GsaSamNumber := IF((LEFT.InBipLevel = 'Sele' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 4) OR (LEFT.InBipLevel = 'Prox' AND Relavator.getGraphContextUIDType(LEFT.GraphId) = 7), LEFT.InSamNumber, ''),
    SELF := LEFT));
    
  RETURN dDetails;
ENDMACRO;