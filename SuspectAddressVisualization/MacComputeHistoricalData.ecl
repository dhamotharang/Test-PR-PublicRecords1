EXPORT MacComputeHistoricalData(InDataset ,InLNPID ,InProviderKey = '' ,InSuspectReason = '', InDataset2) := FUNCTIONMACRO
	import STD;
	IMPORT AppendProviderAttributes;
	ProviderAttrExclusion := InDataset (InSuspectReason IN ['B001','B004','C001','C002','C003','C004','C005'] AND (integer)InLNPID > 0);

	HistoricalDataFile := AppendProviderAttributes.Key_Provider_Attributes_Data;

	ExtractHistoricalDataByLNPID := JOIN (ProviderAttrExclusion,HistoricalDataFile,KEYED(LEFT.InLNPID = RIGHT.LNPID), KEEP(1));

	SuspectAddressVisualization.Layouts.HistoricalLayout getCurrentSanction (RECORDOF(ExtractHistoricalDataByLNPID) L, INTEGER C) := TRANSFORM
			SELF.ProviderKey 	:= L.InProviderKey;
			SELF.Reason 			:= L.InSuspectReason;
			SELF.State				:=  MAP (L.InSuspectReason = 'C001' => L.RevokedExclusionStates[C].STATE,
																 L.InSuspectReason = 'C002' => L.PastRevokedStates[C].STATE,
																 L.InSuspectReason = 'C003' => L.ExpiredLicenseStates[C].STATE,
																 L.InSuspectReason = 'C004' => IF(L.InactiveLicenseStates[C].STATE <> '',L.InactiveLicenseStates[C].STATE,L.ExpiredLicenseStates[C].STATE),
																 L.InSuspectReason = 'B001' => L.CurrentExclusionStates[C].STATE,
																 L.InSuspectReason = 'B004' => L.PastExclusionStates[c].STATE,'');
																 
			SELF.SanctionDate := MAP (L.InSuspectReason = 'B001' => L.CurrentExclusionStates[C].SANCTION_DATE, 
																L.InSuspectReason = 'C001' => L.RevokedExclusionStates[C].SANCTION_DATE, 
																L.InSuspectReason = 'C002' => L.PastRevokedStates[C].SANCTION_DATE,
																L.InSuspectReason = 'B004' => L.PastExclusionStates[C].SANCTION_DATE,'');
			
			SELF.ReInstatementDate := MAP (L.InSuspectReason = 'B004' => L.PastExclusionStates[C].REINSTATEMENT_DATE,
																		 L.InSuspectReason = 'C002' => L.PastRevokedStates[C].REINSTATEMENT_DATE,
																			'');
																			
			SELF.LicenseNumber 		 := MAP (L.InSuspectReason = 'B001' => L.CurrentExclusionStates[C].LIC_NBR,
																		 L.InSuspectReason = 'C001' => L.RevokedExclusionStates[C].LIC_NBR,
																		 L.InSuspectReason = 'C002' => L.PastRevokedStates[C].LIC_NBR,
																		 L.InSuspectReason = 'C003' => L.ExpiredLicenseStates[C].LIC_NBR,
																		 L.InSuspectReason = 'C004' => IF(L.InactiveLicenseStates[C].LIC_NBR <> '', L.InactiveLicenseStates[C].LIC_NBR, L.ExpiredLicenseStates[C].LIC_NBR),
																		 '');
																		 
			SELF.ExpirationDate := MAP (L.InSuspectReason = 'C003' => (STRING)L.ExpiredLicenseStates[C].DT_LIC_EXPIRATION,
																	'');
																	
			SELF.DEANumber := MAP (L.InSuspectReason = 'C005' => l.DeaDs[c].DEA_NUMBER,''); 
			SELF.DEAExpirationDate := MAP (L.InSuspectReason = 'C005' => l.DeaDs[c].DT_DEA_EXPIRATION,''); 
			SELF := [];
	END;

	NormalizeHistoricalDs := NORMALIZE (ExtractHistoricalDataByLNPID,	MAX(LEFT.CurrentExclusionCnt, LEFT.RevokedExclusionCnt, LEFT.PastExclusionCnt, LEFT.PastRevokedCnt, LEFT.RevokedLicenseCnt, LEFT.ExpiredLicenseCnt, LEFT.InactiveLicenseCnt, LEFT.DeaCnt), getCurrentSanction(LEFT, COUNTER)) (state <> '' or DEANumber <> '');
	
	CombineHistoricalDs := InDataset2 + NormalizeHistoricalDs;
	
	RemoveBadData := PROJECT (CombineHistoricalDs,TRANSFORM(SuspectAddressVisualization.Layouts.HistoricalLayout, 
			SELF.ProviderKey						:= 	LEFT.ProviderKey; 
			SELF.Reason									:= 	LEFT.Reason;
			SELF.LNPID									:=	'';
			SELF.ProviderFirstName			:= 	MAP (LEFT.REASON IN ['A007'] => LEFT.ProviderFirstName, '');
			SELF.ProviderMiddleName			:= 	MAP (LEFT.REASON IN ['A007'] => LEFT.ProviderMiddleName, '');
			SELF.ProviderLastName				:= 	MAP (LEFT.REASON IN ['A007'] => LEFT.ProviderLastName, '');
			SELF.ProviderAddressLine1		:=	MAP (LEFT.REASON IN ['A007'] => LEFT.ProviderAddressLine1, '');
			SELF.ProviderCity						:=	'';
			SELF.ProviderState					:=	'';
			SELF.ProviderZip						:=	'';
			SELF.PatientFirstName				:=	MAP (LEFT.REASON IN ['G002', 'G003', 'H001','A008'] => LEFT.PatientFirstName, '');
			SELF.PatientMiddleName			:=	MAP (LEFT.REASON IN ['G002', 'G003', 'H001','A008'] => LEFT.PatientMiddleName, '');
			SELF.PatientLastName				:=	MAP (LEFT.REASON IN ['G002', 'G003', 'H001','A008'] => LEFT.PatientLastName, '');
			SELF.PatientDOD							:=	MAP (LEFT.REASON IN ['G002'] => LEFT.PatientDOD, '');
			SELF.Distance								:=	MAP (LEFT.REASON IN ['H001'] => LEFT.Distance, '');
			SELF.NoofVisits							:=	MAP (LEFT.REASON IN ['H001'] => LEFT.NoofVisits, '');
			SELF.PatientAddressLine1		:=	MAP (LEFT.REASON IN ['H001'] => LEFT.PatientAddressLine1, '');
			SELF.PatientCity						:=	MAP (LEFT.REASON IN ['H001'] => LEFT.PatientCity, '');
			SELF.PatientState						:=	MAP (LEFT.REASON IN ['H001'] => LEFT.PatientState, '');
			SELF.PatientZip							:=	MAP (LEFT.REASON IN ['H001'] => LEFT.PatientZip, '');
			SELF.PatientKey							:=	MAP (LEFT.REASON IN ['G002', 'G003', 'H001','A008'] => LEFT.PatientKey, '');
			SELF.State									:=	MAP (LEFT.REASON IN ['B001','B004','C001','C002','C003','C004'] => LEFT.State, '');
			SELF.LicenseNumber					:=	MAP (LEFT.REASON IN ['B001','C001','C002','C003','C004'] => LEFT.LicenseNumber, '');
			SELF.SanctionDate						:=	MAP (LEFT.REASON IN ['B001','B004','C001','C002'] => LEFT.SanctionDate, '');
			SELF.ReInstatementDate			:=	MAP (LEFT.REASON IN ['B004','C002'] => LEFT.ReInstatementDate, '');
			SELF.ExpirationDate					:=	MAP (LEFT.REASON IN ['C003'] => LEFT.ExpirationDate, '');
			SELF.DEANumber							:=	MAP (LEFT.REASON IN ['C005'] => LEFT.DEANumber, '');
			SELF.DEAExpirationDate			:=	MAP (LEFT.REASON IN ['C005'] => LEFT.DEAExpirationDate, '');
			SELF.SpecialtyDesc					:= 	'';
			SELF.PaidAmount							:=	'';
			SELF.PaidAmountPercent			:=	'';
			SELF.NPINumber							:=	'';
			SELF.ProviderScore					:=	'';
			SELF.ImpactDollars					:=	MAP (LEFT.REASON IN ['G002','B001','C001','C003'] => LEFT.ImpactDollars, '');
			SELF.ClaimCount							:=	MAP (LEFT.REASON IN ['G002','B001','C001','C003'] => LEFT.ClaimCount, '');
			AddrKey 										:=  TRIM(STD.Str.CleanSpaces(LEFT.ProviderAddressLine1 + LEFT.ProviderCity + LEFT.ProviderState + LEFT.ProviderZip));
			// AddrKey 										:=  TRIM((STRING)HASH64(HASHMD5 (LEFT.ProviderAddressLine1)));																								
		  SELF.HistKey 								:=  MAP (LEFT.REASON IN ['A007'] => LEFT.Reason + '_' + AddrKey, LEFT.Reason + '_' + TRIM(LEFT.ProviderKey));
 		  SELF := LEFT;
			));
			
	// output (NormalizeHistoricalDs);	
	RETURN RemoveBadData;
ENDMACRO;