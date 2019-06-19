EXPORT MacComputeImpactData (InDataset ,InProviderKey = '' , InState = '', InSanctionDate, InExpirationDate, InSuspectReason = '', InDataset2, In2ProviderKey = '', In2DateofService, In2PaidAmount) := FUNCTIONMACRO
	
	IMPORT AppendProviderAttributes;
	FilterImpactAttrDs := InDataset ((InSuspectReason IN ['B001','C001'] AND (INTEGER) InSanctionDate > 0) OR (InSuspectReason IN ['C003'] AND (INTEGER)InExpirationDate > 0));

	ProviderLayout := RECORD
			STRING50  ProviderKey;
			STRING2		State;
			INTEGER4	SanctionDate;
			INTEGER4	ExpirationDate;
			STRING4	  Reason;
			INTEGER8	PaidAmount;
			INTEGER4 	DateofService;
	END;
	
	ExtractImpactData := JOIN (FilterImpactAttrDs,InDataset2,LEFT.InProviderKey = RIGHT.In2ProviderKey, TRANSFORM(ProviderLayout, 
			SELF.ProviderKey 			:= 	LEFT.InProviderKey;
			SELF.Reason						:=	LEFT.InSuspectReason;
			SELF.State						:=	LEFT.InState;
			SELF.SanctionDate			:=	IF (LEFT.InSuspectReason IN ['B001','C001'], (INTEGER)LEFT.InSanctionDate,0);
			SELF.ExpirationDate		:=	IF (LEFT.InSuspectReason IN ['C003'], (INTEGER)LEFT.InExpirationDate,0);
			SELF.PaidAmount				:=	ROUND((REAL)RIGHT.In2PaidAmount);
			SELF.DateofService		:=	IF((INTEGER)RIGHT.In2DateofService > 0, (INTEGER)RIGHT.In2DateofService,0);
			), HASH);

	StateExclusionAmount := TABLE (ExtractImpactData (Reason = 'B001' AND SanctionDate > 0 AND DateofService > 0 AND DateofService > SanctionDate), {ProviderKey, Reason, State, ImpactAmount := SUM(GROUP, PaidAmount); ImpactCount := COUNT(GROUP)}, ProviderKey, Reason, State, MERGE);
	RevokedLicenseAmount := TABLE (ExtractImpactData (Reason = 'C001' AND SanctionDate > 0 AND DateofService > 0 AND DateofService > SanctionDate), {ProviderKey, Reason, State, ImpactAmount := SUM(GROUP, PaidAmount); ImpactCount := COUNT(GROUP)}, ProviderKey, Reason, State, MERGE);
	ExpiredLicenseAmount := TABLE (ExtractImpactData (Reason = 'C003' AND ExpirationDate > 0 AND DateofService > 0 AND DateofService > ExpirationDate), {ProviderKey, Reason, State, ImpactAmount := SUM(GROUP, PaidAmount); ImpactCount := COUNT(GROUP)}, ProviderKey, Reason, State, MERGE);
	
	ImpactStats := StateExclusionAmount + RevokedLicenseAmount + ExpiredLicenseAmount;
	
	HistoricalResults := JOIN (InDataset, ImpactStats, LEFT.InProviderKey = RIGHT.ProviderKey AND LEFT.InState = RIGHT.State AND LEFT.InSuspectReason = RIGHT.Reason AND LEFT.InSuspectReason IN ['B001', 'C001','C003'],  TRANSFORM(SuspectAddressVisualization.Layouts.HistoricalLayout, 
			SELF.ProviderKey						:= 	MAP (LEFT.REASON IN ['A007'] => LEFT.ProviderKey, '');
			SELF.Reason									:= 	'';
			SELF.ImpactDollars := (STRING)RIGHT.ImpactAmount; SELF.ClaimCount := (STRING)RIGHT.ImpactCount; SELF := LEFT;), LEFT OUTER, HASH);
	
	RETURN HistoricalResults;
ENDMACRO;