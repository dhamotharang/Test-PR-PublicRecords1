IMPORT iesp, InsuranceContext_iesp;

EXPORT layoutPropertyCharacteristicsRequest := RECORD
	DATASET(iesp.property_info.t_PropertyInformationRequest) PropertyInformationRequest;
	DATASET(InsuranceContext_iesp.insurance_risk_context.t_PropertyInformationContext) InsuranceContext;
	Boolean _Blind := FALSE;
END;