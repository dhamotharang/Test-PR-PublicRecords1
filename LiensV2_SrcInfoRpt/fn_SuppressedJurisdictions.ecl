IMPORT	LiensV2_SrcInfoRpt,	ut,	STD;
EXPORT	fn_SuppressedJurisdictions(STRING	filename)	:=	FUNCTION

	//	Get Sprayed Source Information Report
	dSourceInformationReport	:=	LiensV2_SrcInfoRpt.Files(filename).SourceInformationReport;

	//	Clean Sprayed Information Report
	Layouts.rSuppressedJurisdictions	CleanSourceInformationReport(Layouts.rSourceInformationReport pInput)	:=	TRANSFORM
		SELF.StateOfService			:=	ut.CleanSpacesAndUpper(pInput.StateOfService);
		SELF.AreaOfService			:=	ut.CleanSpacesAndUpper(pInput.AreaOfService);
		SELF.LNCourtID					:=	ut.CleanSpacesAndUpper(pInput.LNCourtID);
		SELF.CustCourt					:=	ut.CleanSpacesAndUpper(pInput.CustCourt);
		SELF.CourtName					:=	ut.CleanSpacesAndUpper(pInput.CourtName);
		SELF.Address1						:=	ut.CleanSpacesAndUpper(pInput.Address1);
		SELF.Address2						:=	ut.CleanSpacesAndUpper(pInput.Address2);
		SELF.Address3						:=	ut.CleanSpacesAndUpper(pInput.Address3);
		SELF.Phone							:=	ut.CleanPhone(pInput.Phone);
		SELF.SourceAccessStatus	:=	ut.CleanSpacesAndUpper(pInput.SourceAccessStatus);
		SELF.ActionGroup				:=	ut.CleanSpacesAndUpper(pInput.ActionGroup);
		SELF.MatchKey						:=	ut.CleanSpacesAndUpper(pInput.MatchKey);
		SELF.CollectionCoverage	:=	ut.CleanSpacesAndUpper(pInput.CollectionCoverage);
		SELF.VisitInterval			:=	ut.CleanSpacesAndUpper(pInput.VisitInterval);
		SELF.CourtLatency				:=	ut.CleanSpacesAndUpper(pInput.CourtLatency);
		SELF.DispositionScore		:=	ut.CleanSpacesAndUpper(pInput.DispositionScore);
		SELF.SevenYrVolume			:=	ut.CleanSpacesAndUpper(pInput.SevenYrVolume);
		fmtsin := [
			'%m/%d/%Y',
			'%m/%d/%y'
		];
		fmtout:='%Y%m%d';
		SELF.MaxCollectDate			:=	IF(
																	ut.CleanSpacesAndUpper(pInput.MaxCollectDate)	=	'NULL',
																	ut.CleanSpacesAndUpper(pInput.MaxCollectDate),
																	Std.date.ConvertDateFormatMultiple(pInput.MaxCollectDate,fmtsin,fmtout)
																);
		SELF.VisitWithin90			:=	ut.CleanSpacesAndUpper(pInput.VisitWithin90);
		SELF.IsActive						:=	pInput.IsActive;
		SELF.FileTypeID					:=	pInput.MatchKey[8..9];
	END;

	dSourceInformationReportClean	:=	PROJECT(dSourceInformationReport,CleanSourceInformationReport(LEFT));
	//	DEDUP on FileTypeID because we have multiple entries to account for spelling differences in filing_type_desc
	dFCRAActionGroupFilter				:=	DEDUP(SORT(LiensV2_SrcInfoRpt.FCRAActionGroupFilter,FileTypeID),FileTypeID);

	//	Remove Jurisdictions based on FileTypeID
	dActionGroupFilter	:=	JOIN(
														dSourceInformationReportClean,
														dFCRAActionGroupFilter,
															LEFT.FileTypeID	=	RIGHT.FileTypeID,
														TRANSFORM(LEFT)
													);


	//	Remove Juristdictions based on information within the record
	dSuppressedJurisdictions	:=	dActionGroupFilter(
																	VisitInterval	IN	['OVER 90','OVER 120','OVER 180', '> 90','> 120','> 180']	AND
																	VisitWithin90	IN	['NO']
																);
																
	RETURN dSuppressedJurisdictions;
	
END;
