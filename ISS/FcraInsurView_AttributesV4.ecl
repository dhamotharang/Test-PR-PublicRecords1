import Models, iesp;
EXPORT FcraInsurView_AttributesV4 := module

	EXPORT iesp.fcrainsurviewattributes.t_IdentityManipulationAttributes idManip (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform 
			self.AgeOldestRecord := if(le.ClearFields, '',  le.v4_AgeOldestRecord    );			
			self.AgeNewestRecord := if(le.ClearFields, '',  le.v4_AgeNewestRecord    ); 			
			self.RecentUpdate := if(le.ClearFields, '',  le.v4_RecentUpdate   ); 			
			self.SrcsConfirmIDAddrCount  := if(le.ClearFields, '',  le.v4_SrcsConfirmIDAddrCount    );	
			self.InvalidDL := if(le.ClearFields, '',  le.v4_InvalidDL    ); 				
			self.VerificationFailure := if(le.v4_PrescreenOptOut = '1' OR 
				//le.v4_ConsumerStatement = '1' or - per Insurance - dont' clear out fields if this is set
				 le.v4_SecurityFreeze = '1', '',  le.v4_VerificationFailure   );		
			self.SSNNotFound := if(le.ClearFields, '',  le.v4_SSNNotFound    );			
			self.VerifiedName := if(le.ClearFields, '',  le.v4_VerifiedName    );				
			self.VerifiedSSN := if(le.ClearFields, '',  le.v4_VerifiedSSN   );				
			self.VerifiedPhone  := if(le.ClearFields, '',  le.v4_VerifiedPhone    );	
			self.VerifiedAddress := if(le.ClearFields, '',  le.v4_VerifiedAddress    ); 			
			self.VerifiedDOB  := if(le.ClearFields, '',  le.v4_VerifiedDOB    );				
			self.InferredMinimumAge  := if(le.ClearFields, '',  le.v4_InferredMinimumAge    );		
			self.BestReportedAge := if(le.ClearFields, '',  le.v4_BestReportedAge    );			
			self.SubjectSSNCount  := if(le.ClearFields, '',  le.v4_SubjectSSNCount    );			
			self.SubjectAddrCount  := if(le.ClearFields, '',  le.v4_SubjectAddrCount    );			
			self.SubjectPhoneCount  := if(le.ClearFields, '',  le.v4_SubjectPhoneCount   );			
			self.SubjectSSNRecentCount  := if(le.ClearFields, '',  le.v4_SubjectSSNRecentCount    );		
			self.SubjectAddrRecentCount  := if(le.ClearFields, '',  le.v4_SubjectAddrRecentCount    );	
			self.SubjectPhoneRecentCount := if(le.ClearFields, '',  le.v4_SubjectPhoneRecentCount    ); 	
			self.SSNIdentitiesCount := if(le.ClearFields, '',  le.v4_SSNIdentitiesCount    );		
			self.SSNAddrCount := if(le.ClearFields, '',  le.v4_SSNAddrCount    );		 	
			self.SSNIdentitiesRecentCount  := if(le.ClearFields, '',  le.v4_SSNIdentitiesRecentCount    );	
			self.SSNAddrRecentCount := if(le.ClearFields, '',  le.v4_SSNAddrRecentCount    );	
			self.InputAddrPhoneCount := if(le.ClearFields, '',  le.v4_InputAddrPhoneCount    );		
			self.InputAddrPhoneRecentCount  := if(le.ClearFields, '',  le.v4_InputAddrPhoneRecentCount   );	
			self.PhoneIdentitiesCount := if(le.ClearFields, '',  le.v4_PhoneIdentitiesCount    );	
			self.PhoneIdentitiesRecentCount := if(le.ClearFields, '',  le.v4_PhoneIdentitiesRecentCount   ); 	
	END;	
	
	EXPORT iesp.fcrainsurviewattributes.t_SSNCharacteristicsAttributes ssnChar (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform 
			self.SSNAgeDeceased  := if(le.ClearFields, '',  le.v4_SSNAgeDeceased );
			self.SSNRecent := if(le.ClearFields, '',  le.v4_SSNRecent );
			self.SSNLowIssueAge := if(le.ClearFields, '',  le.v4_SSNLowIssueAge );
			self.SSNHighIssueAge := if(le.ClearFields, '',  le.v4_SSNHighIssueAge);
			self.SSNIssueState := if(le.ClearFields, '',  le.v4_SSNIssueState 	);
			self.SSNNonUS := if(le.ClearFields, '',  le.v4_SSNNonUS 		);
			self.SSN3Years := if(le.ClearFields, '',  le.v4_SSN3Years 		);
			self.SSNAfter5 := if(le.ClearFields, '',  le.v4_SSNAfter5 	)	;
			self.SSNProblems := if(le.ClearFields, '',  le.v4_SSNProblems );
	END;	
	
	EXPORT iesp.fcrainsurviewattributes.t_InputAddressAttributes inputAddr (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform 
		self.InputAddrAgeOldestRecord := if(le.ClearFields, '',  le.v4_InputAddrAgeOldestRecord);
		self.InputAddrAgeNewestRecord := if(le.ClearFields, '',  le.v4_InputAddrAgeNewestRecord);
		self.InputAddrHistoricalMatch := if(le.ClearFields, '',  le.v4_InputAddrHistoricalMatch);
		self.InputAddrLenOfRes := if(le.ClearFields, '',  le.v4_InputAddrLenOfRes);
		self.InputAddrDwellType := if(le.ClearFields, '',  le.v4_InputAddrDwellType);
		self.InputAddrDelivery := if(le.ClearFields, '',  le.v4_InputAddrDelivery);
		self.InputAddrApplicantOwned := if(le.ClearFields, '',  le.v4_InputAddrApplicantOwned);
		self.InputAddrFamilyOwned := if(le.ClearFields, '',  le.v4_InputAddrFamilyOwned);
		self.InputAddrOccupantOwned := if(le.ClearFields, '',  le.v4_InputAddrOccupantOwned);
		self.InputAddrAgeLastSale := if(le.ClearFields, '',  le.v4_InputAddrAgeLastSale);
		self.InputAddrLastSalesPrice := if(le.ClearFields, '',  le.v4_InputAddrLastSalesPrice);
		self.InputAddrMortgageType := if(le.ClearFields, '',  le.v4_InputAddrMortgageType);
		self.InputAddrNotPrimaryRes := if(le.ClearFields, '',  le.v4_InputAddrNotPrimaryRes);
		self.InputAddrActivePhoneList := if(le.ClearFields, '',  le.v4_InputAddrActivePhoneList);
		self.InputAddrTaxValue := if(le.ClearFields, '',  le.v4_InputAddrTaxValue);
		self.InputAddrTaxYr := if(le.ClearFields, '',  le.v4_InputAddrTaxYr);
		self.InputAddrTaxMarketValue := if(le.ClearFields, '',  le.v4_InputAddrTaxMarketValue);
		self.InputAddrAVMValue := if(le.ClearFields, '',  le.v4_InputAddrAVMValue);
		self.InputAddrAVMValue12 := if(le.ClearFields, '',  le.v4_InputAddrAVMValue12);
		self.InputAddrAVMValue60 := if(le.ClearFields, '',  le.v4_InputAddrAVMValue60);
		self.InputAddrCountyIndex := if(le.ClearFields, '',  le.v4_InputAddrCountyIndex);
		self.InputAddrTractIndex := if(le.ClearFields, '',  le.v4_InputAddrTractIndex);
		self.InputAddrBlockIndex := if(le.ClearFields, '',  le.v4_InputAddrBlockIndex);	
	END;
	
	EXPORT iesp.fcrainsurviewattributes.t_CurrentAddressAttributes CurrAddr (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform
		self.CurrAddrAgeOldestRecord := if(le.ClearFields, '',  le.v4_CurrAddrAgeOldestRecord);
		self.CurrAddrAgeNewestRecord := if(le.ClearFields, '',  le.v4_CurrAddrAgeNewestRecord);
		self.CurrAddrLenOfRes := if(le.ClearFields, '',  le.v4_CurrAddrLenOfRes);
		self.CurrAddrDwellType := if(le.ClearFields, '',  le.v4_CurrAddrDwellType);
		self.CurrAddrApplicantOwned := if(le.ClearFields, '',  le.v4_CurrAddrApplicantOwned);
		self.CurrAddrFamilyOwned := if(le.ClearFields, '',  le.v4_CurrAddrFamilyOwned);
		self.CurrAddrOccupantOwned := if(le.ClearFields, '',  le.v4_CurrAddrOccupantOwned);
		self.CurrAddrAgeLastSale := if(le.ClearFields, '',  le.v4_CurrAddrAgeLastSale);
		self.CurrAddrLastSalesPrice := if(le.ClearFields, '',  le.v4_CurrAddrLastSalesPrice);
		self.CurrAddrMortgageType := if(le.ClearFields, '',  le.v4_CurrAddrMortgageType);
		self.CurrAddrActivePhoneList := if(le.ClearFields, '',  le.v4_CurrAddrActivePhoneList);
		self.CurrAddrTaxValue := if(le.ClearFields, '',  le.v4_CurrAddrTaxValue);
		self.CurrAddrTaxYr := if(le.ClearFields, '',  le.v4_CurrAddrTaxYr);
		self.CurrAddrTaxMarketValue := if(le.ClearFields, '',  le.v4_CurrAddrTaxMarketValue);
		self.CurrAddrAVMValue := if(le.ClearFields, '',  le.v4_CurrAddrAVMValue);
		self.CurrAddrAVMValue12 := if(le.ClearFields, '',  le.v4_CurrAddrAVMValue12);
		self.CurrAddrAVMValue60 := if(le.ClearFields, '',  le.v4_CurrAddrAVMValue60);
		self.CurrAddrCountyIndex := if(le.ClearFields, '',  le.v4_CurrAddrCountyIndex);
		self.CurrAddrTractIndex := if(le.ClearFields, '',  le.v4_CurrAddrTractIndex);
		self.CurrAddrBlockIndex := if(le.ClearFields, '',  le.v4_CurrAddrBlockIndex);
	END;

	EXPORT iesp.fcrainsurviewattributes.t_PreviousAddressAttributes PrevAddr (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform
		self.PrevAddrAgeOldestRecord := if(le.ClearFields, '',  le.v4_PrevAddrAgeOldestRecord);
		self.PrevAddrAgeNewestRecord := if(le.ClearFields, '',  le.v4_PrevAddrAgeNewestRecord);
		self.PrevAddrLenOfRes := if(le.ClearFields, '',  le.v4_PrevAddrLenOfRes);
		self.PrevAddrDwellType := if(le.ClearFields, '',  le.v4_PrevAddrDwellType);
		self.PrevAddrApplicantOwned := if(le.ClearFields, '',  le.v4_PrevAddrApplicantOwned);
		self.PrevAddrFamilyOwned := if(le.ClearFields, '',  le.v4_PrevAddrFamilyOwned);
		self.PrevAddrOccupantOwned := if(le.ClearFields, '',  le.v4_PrevAddrOccupantOwned);
		self.PrevAddrAgeLastSale := if(le.ClearFields, '',  le.v4_PrevAddrAgeLastSale);
		self.PrevAddrLastSalesPrice := if(le.ClearFields, '',  le.v4_PrevAddrLastSalesPrice);
		self.PrevAddrTaxValue := if(le.ClearFields, '',  le.v4_PrevAddrTaxValue);
		self.PrevAddrTaxYr := if(le.ClearFields, '',  le.v4_PrevAddrTaxYr);
		self.PrevAddrTaxMarketValue := if(le.ClearFields, '',  le.v4_PrevAddrTaxMarketValue);
		self.PrevAddrAVMValue := if(le.ClearFields, '',  le.v4_PrevAddrAVMValue);
		self.PrevAddrCountyIndex := if(le.ClearFields, '',  le.v4_PrevAddrCountyIndex);
		self.PrevAddrTractIndex := if(le.ClearFields, '',  le.v4_PrevAddrTractIndex);
		self.PrevAddrBlockIndex := if(le.ClearFields, '',  le.v4_PrevAddrBlockIndex);
	END;

	EXPORT iesp.fcrainsurviewattributes.t_MostRecentAddressAttributes RecAddr (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform
		self.AddrMostRecentDistance := if(le.ClearFields, '',  le.v4_AddrMostRecentDistance);
		self.AddrMostRecentStateDiff := if(le.ClearFields, '',  le.v4_AddrMostRecentStateDiff);
		self.AddrMostRecentTaxDiff := if(le.ClearFields, '',  le.v4_AddrMostRecentTaxDiff);
		self.AddrMostRecentMoveAge := if(le.ClearFields, '',  le.v4_AddrMostRecentMoveAge);
		self.AddrRecentEconTrajectory := if(le.ClearFields, '',  le.v4_AddrRecentEconTrajectory);
		self.AddrRecentEconTrajectoryIndex := if(le.ClearFields, '',  le.v4_AddrRecentEconTrajectoryIndex);
	END;

	EXPORT iesp.fcrainsurviewattributes.t_EducationAttributes Educ (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform 
		self.EducationAttendedCollege := if(le.ClearFields, '',  le.v4_EducationAttendedCollege);
		self.EducationProgram2Yr := if(le.ClearFields, '',  le.v4_EducationProgram2Yr);
		self.EducationProgram4Yr := if(le.ClearFields, '',  le.v4_EducationProgram4Yr);
		self.EducationProgramGraduate := if(le.ClearFields, '',  le.v4_EducationProgramGraduate);
		self.EducationInstitutionPrivate := if(le.ClearFields, '',  le.v4_EducationInstitutionPrivate);
		self.EducationFieldofStudyType := if(le.ClearFields, '',  le.v4_EducationFieldofStudyType);
		self.EducationInstitutionRating := if(le.ClearFields, '',  le.v4_EducationInstitutionRating);
	END;

	EXPORT iesp.fcrainsurviewattributes.t_AddressStabilityAttributes AddrStabl (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform 
		self.AddrStability := if(le.ClearFields, '',  le.v4_AddrStability);
		self.StatusMostRecent := if(le.ClearFields, '',  le.v4_StatusMostRecent);
		self.StatusPrevious := if(le.ClearFields, '',  le.v4_StatusPrevious);
		self.StatusNextPrevious := if(le.ClearFields, '',  le.v4_StatusNextPrevious);
		self.AddrChangeCount01 := if(le.ClearFields, '',  le.v4_AddrChangeCount01);
		self.AddrChangeCount03 := if(le.ClearFields, '',  le.v4_AddrChangeCount03);
		self.AddrChangeCount06 := if(le.ClearFields, '',  le.v4_AddrChangeCount06);
		self.AddrChangeCount12 := if(le.ClearFields, '',  le.v4_AddrChangeCount12);
		self.AddrChangeCount24 := if(le.ClearFields, '',  le.v4_AddrChangeCount24);
		self.AddrChangeCount60 := if(le.ClearFields, '',  le.v4_AddrChangeCount60);
	END;

	EXPORT iesp.fcrainsurviewattributes.t_IncomeAssetAttributes  IncomeAsst (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform 
		SELF.EstimatedAnnualIncome := if(le.ClearFields, '',  le.v4_EstimatedAnnualIncome);
		SELF.PropertyOwner := if(le.ClearFields, '',  le.v4_PropertyOwner);
		SELF.PropOwnedCount := if(le.ClearFields, '',  le.v4_PropOwnedCount);
		SELF.PropOwnedTaxTotal := if(le.ClearFields, '',  le.v4_PropOwnedTaxTotal);
		SELF.PropOwnedHistoricalCount := if(le.ClearFields, '',  le.v4_PropOwnedHistoricalCount);
		SELF.PropAgeOldestPurchase := if(le.ClearFields, '',  le.v4_PropAgeOldestPurchase);
		SELF.PropAgeNewestPurchase := if(le.ClearFields, '',  le.v4_PropAgeNewestPurchase);
		SELF.PropAgeNewestSale := if(le.ClearFields, '',  le.v4_PropAgeNewestSale);
		SELF.PropNewestSalePrice := if(le.ClearFields, '',  le.v4_PropNewestSalePrice);
		SELF.PropNewestSalePurchaseIndex := if(le.ClearFields, '',  le.v4_PropNewestSalePurchaseIndex);
		SELF.PropPurchasedCount01 := if(le.ClearFields, '',  le.v4_PropPurchasedCount01);
		SELF.PropPurchasedCount03 := if(le.ClearFields, '',  le.v4_PropPurchasedCount03);
		SELF.PropPurchasedCount06 := if(le.ClearFields, '',  le.v4_PropPurchasedCount06);
		SELF.PropPurchasedCount12 := if(le.ClearFields, '',  le.v4_PropPurchasedCount12);
		SELF.PropPurchasedCount24 := if(le.ClearFields, '',  le.v4_PropPurchasedCount24);
		SELF.PropPurchasedCount60 := if(le.ClearFields, '',  le.v4_PropPurchasedCount60);
		SELF.PropSoldCount01 := if(le.ClearFields, '',  le.v4_PropSoldCount01);
		SELF.PropSoldCount03 := if(le.ClearFields, '',  le.v4_PropSoldCount03);
		SELF.PropSoldCount06 := if(le.ClearFields, '',  le.v4_PropSoldCount06);
		SELF.PropSoldCount12 := if(le.ClearFields, '',  le.v4_PropSoldCount12);
		SELF.PropSoldCount24 := if(le.ClearFields, '',  le.v4_PropSoldCount24);
		SELF.PropSoldCount60 := if(le.ClearFields, '',  le.v4_PropSoldCount60);
		SELF.AssetOwner := if(le.ClearFields, '',  le.v4_AssetOwner);
		SELF.WatercraftOwner := if(le.ClearFields, '',  le.v4_WatercraftOwner);
		SELF.WatercraftCount := if(le.ClearFields, '',  le.v4_WatercraftCount);
		SELF.WatercraftCount01 := if(le.ClearFields, '',  le.v4_WatercraftCount01);
		SELF.WatercraftCount03 := if(le.ClearFields, '',  le.v4_WatercraftCount03);
		SELF.WatercraftCount06 := if(le.ClearFields, '',  le.v4_WatercraftCount06);
		SELF.WatercraftCount12 := if(le.ClearFields, '',  le.v4_WatercraftCount12);
		SELF.WatercraftCount24 := if(le.ClearFields, '',  le.v4_WatercraftCount24);
		SELF.WatercraftCount60 := if(le.ClearFields, '',  le.v4_WatercraftCount60);
		SELF.AircraftOwner := if(le.ClearFields, '',  le.v4_AircraftOwner);
		SELF.AircraftCount := if(le.ClearFields, '',  le.v4_AircraftCount);
		SELF.AircraftCount01 := if(le.ClearFields, '',  le.v4_AircraftCount01);
		SELF.AircraftCount03 := if(le.ClearFields, '',  le.v4_AircraftCount03);
		SELF.AircraftCount06 := if(le.ClearFields, '',  le.v4_AircraftCount06);
		SELF.AircraftCount12 := if(le.ClearFields, '',  le.v4_AircraftCount12);
		SELF.AircraftCount24 := if(le.ClearFields, '',  le.v4_AircraftCount24);
		SELF.AircraftCount60 := if(le.ClearFields, '',  le.v4_AircraftCount60);
		SELF.WealthIndex := if(le.ClearFields, '',  le.v4_WealthIndex);
	END;

	EXPORT iesp.fcrainsurviewattributes.t_BusinessAssociationAttributes busAssoc (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform 
		self.BusinessActiveAssociation := if(le.ClearFields, '',  le.v4_BusinessActiveAssociation);
		self.BusinessInactiveAssociation := if(le.ClearFields, '',  le.v4_BusinessInactiveAssociation);
		self.BusinessAssociationAge := if(le.ClearFields, '',  le.v4_BusinessAssociationAge);
		self.BusinessTitle := if(le.ClearFields, '',  le.v4_BusinessTitle);
	END;

	EXPORT iesp.fcrainsurviewattributes.t_DerogatoryPublicRecordAttributes derogs(ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform 
		SELF.DerogSeverityIndex := if(le.ClearFields, '',  le.v4_DerogSeverityIndex);
		SELF.DerogCount := if(le.ClearFields, '',  le.v4_DerogCount);
		SELF.DerogRecentCount := if(le.ClearFields, '',  le.v4_DerogRecentCount);
		SELF.DerogAge := if(le.ClearFields, '',  le.v4_DerogAge);
		SELF.FelonyCount := if(le.ClearFields, '',  le.v4_FelonyCount);
		SELF.FelonyAge := if(le.ClearFields, '',  le.v4_FelonyAge);
		SELF.FelonyCount01 := if(le.ClearFields, '',  le.v4_FelonyCount01);
		SELF.FelonyCount03 := if(le.ClearFields, '',  le.v4_FelonyCount03);
		SELF.FelonyCount06 := if(le.ClearFields, '',  le.v4_FelonyCount06);
		SELF.FelonyCount12 := if(le.ClearFields, '',  le.v4_FelonyCount12);
		SELF.FelonyCount24 := if(le.ClearFields, '',  le.v4_FelonyCount24);
		SELF.FelonyCount60 := if(le.ClearFields, '',  le.v4_FelonyCount60);
		SELF.LienCount := if(le.ClearFields, '',  le.v4_LienCount);
		SELF.LienFiledCount := if(le.ClearFields, '',  le.v4_LienFiledCount);
		SELF.LienFiledAge := if(le.ClearFields, '',  le.v4_LienFiledAge);
		SELF.LienFiledCount01 := if(le.ClearFields, '',  le.v4_LienFiledCount01);
		SELF.LienFiledCount03 := if(le.ClearFields, '',  le.v4_LienFiledCount03);
		SELF.LienFiledCount06 := if(le.ClearFields, '',  le.v4_LienFiledCount06);
		SELF.LienFiledCount12 := if(le.ClearFields, '',  le.v4_LienFiledCount12);
		SELF.LienFiledCount24 := if(le.ClearFields, '',  le.v4_LienFiledCount24);
		SELF.LienFiledCount60 := if(le.ClearFields, '',  le.v4_LienFiledCount60);
		SELF.LienReleasedCount := if(le.ClearFields, '',  le.v4_LienReleasedCount);
		SELF.LienReleasedAge := if(le.ClearFields, '',  le.v4_LienReleasedAge);
		SELF.LienReleasedCount01 := if(le.ClearFields, '',  le.v4_LienReleasedCount01);
		SELF.LienReleasedCount03 := if(le.ClearFields, '',  le.v4_LienReleasedCount03);
		SELF.LienReleasedCount06 := if(le.ClearFields, '',  le.v4_LienReleasedCount06);
		SELF.LienReleasedCount12 := if(le.ClearFields, '',  le.v4_LienReleasedCount12);
		SELF.LienReleasedCount24 := if(le.ClearFields, '',  le.v4_LienReleasedCount24);
		SELF.LienReleasedCount60 := if(le.ClearFields, '',  le.v4_LienReleasedCount60);
		SELF.LienFiledTotal := if(le.ClearFields, '',  le.v4_LienFiledTotal);
		SELF.LienFederalTaxFiledTotal := if(le.ClearFields, '',  le.v4_LienFederalTaxFiledTotal);
		SELF.LienTaxOtherFiledTotal := if(le.ClearFields, '',  le.v4_LienTaxOtherFiledTotal);
		SELF.LienForeclosureFiledTotal := if(le.ClearFields, '',  le.v4_LienForeclosureFiledTotal);
		SELF.LienLandlordTenantFiledTotal := if(le.ClearFields, '',  le.v4_LienLandlordTenantFiledTotal);
		SELF.LienJudgmentFiledTotal := if(le.ClearFields, '',  le.v4_LienJudgmentFiledTotal);
		SELF.LienSmallClaimsFiledTotal := if(le.ClearFields, '',  le.v4_LienSmallClaimsFiledTotal);
		SELF.LienOtherFiledTotal := if(le.ClearFields, '',  le.v4_LienOtherFiledTotal);
		SELF.LienReleasedTotal := if(le.ClearFields, '',  le.v4_LienReleasedTotal);
		SELF.LienFederalTaxReleasedTotal := if(le.ClearFields, '',  le.v4_LienFederalTaxReleasedTotal);
		SELF.LienTaxOtherReleasedTotal := if(le.ClearFields, '',  le.v4_LienTaxOtherReleasedTotal);
		SELF.LienForeclosureReleasedTotal := if(le.ClearFields, '',  le.v4_LienForeclosureReleasedTotal);
		SELF.LienLandlordTenantReleasedTotal := if(le.ClearFields, '',  le.v4_LienLandlordTenantReleasedTotal);
		SELF.LienJudgmentReleasedTotal := if(le.ClearFields, '',  le.v4_LienJudgmentReleasedTotal);
		SELF.LienSmallClaimsReleasedTotal := if(le.ClearFields, '',  le.v4_LienSmallClaimsReleasedTotal);
		SELF.LienOtherReleasedTotal := if(le.ClearFields, '',  le.v4_LienOtherReleasedTotal);
		SELF.LienFederalTaxFiledCount := if(le.ClearFields, '',  le.v4_LienFederalTaxFiledCount);
		SELF.LienTaxOtherFiledCount := if(le.ClearFields, '',  le.v4_LienTaxOtherFiledCount);
		SELF.LienForeclosureFiledCount := if(le.ClearFields, '',  le.v4_LienForeclosureFiledCount);
		SELF.LienLandlordTenantFiledCount := if(le.ClearFields, '',  le.v4_LienLandlordTenantFiledCount);
		SELF.LienJudgmentFiledCount := if(le.ClearFields, '',  le.v4_LienJudgmentFiledCount);
		SELF.LienSmallClaimsFiledCount := if(le.ClearFields, '',  le.v4_LienSmallClaimsFiledCount);
		SELF.LienOtherFiledCount := if(le.ClearFields, '',  le.v4_LienOtherFiledCount);
		SELF.LienFederalTaxReleasedCount := if(le.ClearFields, '',  le.v4_LienFederalTaxReleasedCount);
		SELF.LienTaxOtherReleasedCount := if(le.ClearFields, '',  le.v4_LienTaxOtherReleasedCount);
		SELF.LienForeclosureReleasedCount := if(le.ClearFields, '',  le.v4_LienForeclosureReleasedCount);
		SELF.LienLandlordTenantReleasedCount := if(le.ClearFields, '',  le.v4_LienLandlordTenantReleasedCount);
		SELF.LienJudgmentReleasedCount := if(le.ClearFields, '',  le.v4_LienJudgmentReleasedCount);
		SELF.LienSmallClaimsReleasedCount := if(le.ClearFields, '',  le.v4_LienSmallClaimsReleasedCount);
		SELF.LienOtherReleasedCount := if(le.ClearFields, '',  le.v4_LienOtherReleasedCount);
		SELF.BankruptcyCount := if(le.ClearFields, '',  le.v4_BankruptcyCount);
		SELF.BankruptcyAge := if(le.ClearFields, '',  le.v4_BankruptcyAge);
		SELF.BankruptcyType := if(le.ClearFields, '',  le.v4_BankruptcyType);
		SELF.BankruptcyStatus := if(le.ClearFields, '',  le.v4_BankruptcyStatus);
		SELF.BankruptcyCount01 := if(le.ClearFields, '',  le.v4_BankruptcyCount01);
		SELF.BankruptcyCount03 := if(le.ClearFields, '',  le.v4_BankruptcyCount03);
		SELF.BankruptcyCount06 := if(le.ClearFields, '',  le.v4_BankruptcyCount06);
		SELF.BankruptcyCount12 := if(le.ClearFields, '',  le.v4_BankruptcyCount12);
		SELF.BankruptcyCount24 := if(le.ClearFields, '',  le.v4_BankruptcyCount24);
		SELF.BankruptcyCount60 := if(le.ClearFields, '',  le.v4_BankruptcyCount60);
		SELF.EvictionCount := if(le.ClearFields, '',  le.v4_EvictionCount);
		SELF.EvictionAge := if(le.ClearFields, '',  le.v4_EvictionAge);
		SELF.EvictionCount01 := if(le.ClearFields, '',  le.v4_EvictionCount01);
		SELF.EvictionCount03 := if(le.ClearFields, '',  le.v4_EvictionCount03);
		SELF.EvictionCount06 := if(le.ClearFields, '',  le.v4_EvictionCount06);
		SELF.EvictionCount12 := if(le.ClearFields, '',  le.v4_EvictionCount12);
		SELF.EvictionCount24 := if(le.ClearFields, '',  le.v4_EvictionCount24);
		SELF.EvictionCount60 := if(le.ClearFields, '',  le.v4_EvictionCount60);
		SELF.RecentActivityIndex := if(le.ClearFields, '',  le.v4_RecentActivityIndex);
	END;

	EXPORT iesp.fcrainsurviewattributes.t_ProfessionalLicenseAttributes ProfLic (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform 
		SELF.NonDerogCount:= if(le.ClearFields, '',  le.v4_NonDerogCount);
		SELF.NonDerogCount01:= if(le.ClearFields, '',  le.v4_NonDerogCount01);
		SELF.NonDerogCount03:= if(le.ClearFields, '',  le.v4_NonDerogCount03);
		SELF.NonDerogCount06:= if(le.ClearFields, '',  le.v4_NonDerogCount06);
		SELF.NonDerogCount12:= if(le.ClearFields, '',  le.v4_NonDerogCount12);
		SELF.NonDerogCount24:= if(le.ClearFields, '',  le.v4_NonDerogCount24);
		SELF.NonDerogCount60:= if(le.ClearFields, '',  le.v4_NonDerogCount60);
		SELF.VoterRegistrationRecord:= if(le.ClearFields, '',  le.v4_VoterRegistrationRecord);
		SELF.ProfLicCount:= if(le.ClearFields, '',  le.v4_ProfLicCount);
		SELF.ProfLicAge:= if(le.ClearFields, '',  le.v4_ProfLicAge);
		SELF.ProfLicType:= if(le.ClearFields, '',  le.v4_ProfLicType);
		SELF.ProfLicTypeCategory:= if(le.ClearFields, '',  le.v4_ProfLicTypeCategory);
		SELF.ProfLicExpired:= if(le.ClearFields, '',  le.v4_ProfLicExpired);
		SELF.ProfLicCount01:= if(le.ClearFields, '',  le.v4_ProfLicCount01);
		SELF.ProfLicCount03:= if(le.ClearFields, '',  le.v4_ProfLicCount03);
		SELF.ProfLicCount06:= if(le.ClearFields, '',  le.v4_ProfLicCount06);
		SELF.ProfLicCount12:= if(le.ClearFields, '',  le.v4_ProfLicCount12);
		SELF.ProfLicCount24:= if(le.ClearFields, '',  le.v4_ProfLicCount24);
		SELF.ProfLicCount60:= if(le.ClearFields, '',  le.v4_ProfLicCount60);
	END;

	EXPORT iesp.fcrainsurviewattributes.t_InquiryEventsAttributes InqEvent (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform 
		self.InquiryCollectionsRecent := if(le.ClearFields, '',  le.v4_InquiryCollectionsRecent);
		self.InquiryPersonalFinanceRecent := if(le.ClearFields, '',  le.v4_InquiryPersonalFinanceRecent);
		self.InquiryOtherRecent := if(le.ClearFields, '',  le.v4_InquiryOtherRecent);
		self.HighRiskCreditActivity := if(le.ClearFields, '',  le.v4_HighRiskCreditActivity);
		self.SubPrimeOfferRequestCount := if(le.ClearFields, '',  le.v4_SubPrimeOfferRequestCount);
		self.SubPrimeOfferRequestCount01 := if(le.ClearFields, '',  le.v4_SubPrimeOfferRequestCount01);
		self.SubPrimeOfferRequestCount03 := if(le.ClearFields, '',  le.v4_SubPrimeOfferRequestCount03);
		self.SubPrimeOfferRequestCount06 := if(le.ClearFields, '',  le.v4_SubPrimeOfferRequestCount06);
		self.SubPrimeOfferRequestCount12 := if(le.ClearFields, '',  le.v4_SubPrimeOfferRequestCount12);
		self.SubPrimeOfferRequestCount24 := if(le.ClearFields, '',  le.v4_SubPrimeOfferRequestCount24);
		self.SubPrimeOfferRequestCount60 := if(le.ClearFields, '',  le.v4_SubPrimeOfferRequestCount60);
END;

	EXPORT iesp.fcrainsurviewattributes.t_PhoneAndAddressRiskAttributes PhnAddrRisk (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform 
		self.InputPhoneMobile := if(le.ClearFields, '',  le.v4_InputPhoneMobile);
		self.PhoneEDAAgeOldestRecord := if(le.ClearFields, '',  le.v4_PhoneEDAAgeOldestRecord);
		self.PhoneEDAAgeNewestRecord := if(le.ClearFields, '',  le.v4_PhoneEDAAgeNewestRecord);
		self.PhoneOtherAgeOldestRecord := if(le.ClearFields, '',  le.v4_PhoneOtherAgeOldestRecord);
		self.PhoneOtherAgeNewestRecord := if(le.ClearFields, '',  le.v4_PhoneOtherAgeNewestRecord);
		self.InputPhoneHighRisk := if(le.ClearFields, '',  le.v4_InputPhoneHighRisk);
		self.InputPhoneProblems := if(le.ClearFields, '',  le.v4_InputPhoneProblems);
		self.EmailAddress := if(le.ClearFields, '',  le.v4_EmailAddress);
		self.InputAddrHighRisk := if(le.ClearFields, '',  le.v4_InputAddrHighRisk);
		self.CurrAddrCorrectional := if(le.ClearFields, '',  le.v4_CurrAddrCorrectional);
		self.PrevAddrCorrectional := if(le.ClearFields, '',  le.v4_PrevAddrCorrectional);
		self.HistoricalAddrCorrectional := if(le.ClearFields, '',  le.v4_HistoricalAddrCorrectional);
		self.InputAddrProblems := if(le.ClearFields, '',  le.v4_InputAddrProblems);
	END;

	EXPORT iesp.fcrainsurviewattributes.t_ConsumerReportedFlags ConsmrRpt (ISS.FCRAInsurView_Layouts.Layout_rvAttrSeqWithAddrAppendWFlags le) := transform 
		self.SecurityAlert := if(le.ClearFields, '',  le.v4_SecurityAlert);
		self.IDTheftFlag := if(le.ClearFields, '',  le.v4_IDTheftFlag);
		self.SecurityFreeze := if(le.v4_PrescreenOptOut = '1' or (le.ExperianTransaction and le.v4_VerificationFailure = '1'), '',  le.v4_SecurityFreeze);
		self.ConsumerStatement := if(le.v4_PrescreenOptOut = '1' or (le.ExperianTransaction and le.v4_VerificationFailure = '1'), '',  le.v4_ConsumerStatement);
		self.PrescreenOptOut := if((le.ExperianTransaction and le.v4_VerificationFailure = '1') or 
				(//le.v4_ConsumerStatement = '1' or //per Insurance - dont' clear out fields if this is set
				le.v4_SecurityFreeze = '1'), '', le.v4_PrescreenOptOut);
	END;


		
END;