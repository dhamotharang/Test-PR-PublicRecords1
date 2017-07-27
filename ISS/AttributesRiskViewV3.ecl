import Risk_Indicators, Models, iesp;

EXPORT AttributesRiskViewV3 := MODULE
	iesp.consumerattributesreport.t_NameValuePairLong convert(Models.Layout_RVAttributes.Layout_rvAttrSeq le, integer c) := TRANSFORM

		iesp.consumerattributesreport.t_NameValuePairLong createrec(string name, string value) := TRANSFORM
				self.Name:= name;
				self.Value:= value;
		end;
		
		checkBoolean(boolean x) := if(x, '1', '0');

		self := case(c,
						1 => ROW(createrec('AgeOldestRecord', (STRING)le.version3.AgeOldestRecord )),
						2 => ROW(createrec('AgeNewestRecord', (STRING)le.version3.AgeNewestRecord )),
						3 => ROW(createrec('RecentUpdate', (STRING)checkBoolean(le.version3.isRecentUpdate) )),
						4 => ROW(createrec('SrcsConfirmIDAddrCount', (STRING)(string)le.version3.NumSources )),
						5 => ROW(createrec('VerifiedPhoneFullName', (STRING)le.version3.VerifiedPhoneFullName )),
						6 => ROW(createrec('VerifiedPhoneLastName', (STRING)le.version3.VerifiedPhoneLastName )),
						7 => ROW(createrec('InvalidSSN', (STRING)le.version3.InvalidSSN )),
						8 => ROW(createrec('InvalidPhone', (STRING)le.version3.InvalidPhone )),
						9 => ROW(createrec('InvalidAddr', (STRING)le.version3.InvalidAddr )),
						10 => ROW(createrec('InvalidDL', (STRING)le.version3.InvalidDL )),
						11 => ROW(createrec('VerificationFailure', (STRING)checkBoolean(le.version3.isNoVer) )),
						12 => ROW(createrec('SSNDeceased', (STRING)le.version3.SSNDeceased )),
						13 => ROW(createrec('SSNDateDeceased', (STRING)le.version3.DeceasedDate )),
						14 => ROW(createrec('SSNIssued', (STRING)le.version3.SSNValid )),
						15 => ROW(createrec('SSNRecent', (STRING)le.version3.RecentIssue )),
						16 => ROW(createrec('SSNLowIssueDate', (STRING)le.version3.LowIssueDate )),
						17 => ROW(createrec('SSNHighIssueDate', (STRING)le.version3.HighIssueDate )),
						18 => ROW(createrec('SSNIssueState', (STRING)(string)le.version3.IssueState )),
						19 => ROW(createrec('SSNNonUS', (STRING)le.version3.NonUS )),
						20 => ROW(createrec('SSN3Years', (STRING)le.version3.Issued3 )),
						21 => ROW(createrec('SSNAfter5', (STRING)le.version3.IssuedAge5 )),
						22 => ROW(createrec('InputAddrAgeOldestRecord', (STRING)le.version3.IAAgeOldestRecord )),
						23 => ROW(createrec('InputAddrAgeNewestRecord', (STRING)le.version3.IAAgeNewestRecord )),
						24 => ROW(createrec('InputAddrLenOfRes', (STRING)le.version3.IALenOfRes )),
						25 => ROW(createrec('InputAddrDwellType', (STRING)le.version3.IADwellType )),
						26 => ROW(createrec('InputAddrLandUseCode', (STRING)le.version3.IALandUseCode )),
						27 => ROW(createrec('InputAddrTaxValue', (STRING)le.version3.IAAssessedValue )),
						28 => ROW(createrec('InputAddrApplicantOwned', (STRING)le.version3.IAOwnedBySubject )),
						29 => ROW(createrec('InputAddrFamilyOwned', (STRING)le.version3.IAFamilyOwned )),
						30 => ROW(createrec('InputAddrOccupantOwned', (STRING)le.version3.IAOccupantOwned )),
						31 => ROW(createrec('InputAddrAgeLastSale', (STRING)le.version3.IAAgeLastSale )),
						32 => ROW(createrec('InputAddrLastSalesPrice', (STRING)le.version3.IALastSaleAmount )),
						33 => ROW(createrec('InputAddrNotPrimaryRes', (STRING)le.version3.IANotPrimaryRes )),
						34 => ROW(createrec('InputAddrActivePhoneList', (STRING)le.version3.IAPhoneListed )),
						35 => ROW(createrec('InputAddrActivePhoneNumber', (STRING)le.version3.IAPhoneNumber )),
						36 => ROW(createrec('CurrAddrAgeOldestRecord', (STRING)le.version3.CAAgeOldestRecord )),
						37 => ROW(createrec('CurrAddrAgeNewestRecord', (STRING)le.version3.CAAgeNewestRecord )),
						38 => ROW(createrec('CurrAddrLenOfRes', (STRING)le.version3.CALenOfRes )),
						39 => ROW(createrec('CurrAddrDwellType', (STRING)le.version3.CADwellType )),
						40 => ROW(createrec('CurrAddrLandUseCode', (STRING)le.version3.CALandUseCode )),
						41 => ROW(createrec('CurrAddrTaxValue', (STRING)le.version3.CAAssessedValue )),
						42 => ROW(createrec('CurrAddrApplicantOwned', (STRING)le.version3.CAOwnedBySubject )),
						43 => ROW(createrec('CurrAddrFamilyOwned', (STRING)le.version3.CAFamilyOwned )),
						44 => ROW(createrec('CurrAddrOccupantOwned', (STRING)le.version3.CAOccupantOwned )),
						45 => ROW(createrec('CurrAddrAgeLastSale', (STRING)le.version3.CAAgeLastSale )),
						46 => ROW(createrec('CurrAddrLastSalesPrice', (STRING)le.version3.CALastSaleAmount )),
						47 => ROW(createrec('CurrAddrNotPrimaryRes', (STRING)le.version3.CANotPrimaryRes )),
						48 => ROW(createrec('CurrAddrActivePhoneList', (STRING)le.version3.CAPhoneListed )),
						49 => ROW(createrec('CurrAddrActivePhoneNumber', (STRING)le.version3.CAPhoneNumber )),
						50 => ROW(createrec('PrevAddrAgeOldestRecord', (STRING)le.version3.PAAgeOldestRecord )),
						51 => ROW(createrec('PrevAddrAgeNewestRecord', (STRING)le.version3.PAAgeNewestRecord )),
						52 => ROW(createrec('PrevAddrLenOfRes', (STRING)le.version3.PALenOfRes )),
						53 => ROW(createrec('PrevAddrDwellType', (STRING)le.version3.PADwellType )),
						54 => ROW(createrec('PrevAddrLandUseCode', (STRING)le.version3.PALandUseCode )),
						55 => ROW(createrec('PrevAddrTaxValue', (STRING)le.version3.PAAssessedValue )),
						56 => ROW(createrec('PrevAddrApplicantOwned', (STRING)le.version3.PAOwnedBySubject )),
						57 => ROW(createrec('PrevAddrFamilyOwned', (STRING)le.version3.PAFamilyOwned )),
						58 => ROW(createrec('PrevAddrOccupantOwned', (STRING)le.version3.PAOccupantOwned )),
						59 => ROW(createrec('PrevAddrAgeLastSale', (STRING)le.version3.PAAgeLastSale )),
						60 => ROW(createrec('PrevAddrLastSalesPrice', (STRING)le.version3.PALastSaleAmount )),
						61 => ROW(createrec('PrevAddrActivePhoneList', (STRING)le.version3.PAPhoneListed )),
						62 => ROW(createrec('PrevAddrActivePhoneNumber', (STRING)le.version3.PAPhoneNumber )),
						63 => ROW(createrec('InputCurrAddrMatch', (STRING)le.version3.InputCurrMatch )),
						64 => ROW(createrec('InputCurrAddrDistance', (STRING)le.version3.DistInputCurr )),
						65 => ROW(createrec('InputCurrAddrStateDiff', (STRING)le.version3.DiffState )),
						66 => ROW(createrec('InputCurrAddrTaxDiff', (STRING)le.version3.AssessedDiff )),
						67 => ROW(createrec('InputCurrEconTrajectory', (STRING)le.version3.EcoTrajectory )),
						68 => ROW(createrec('InputPrevAddrMatch', (STRING)le.version3.InputPrevMatch )),
						69 => ROW(createrec('CurrPrevAddrDistance', (STRING)le.version3.DistCurrPrev )),
						70 => ROW(createrec('CurrPrevAddrStateDiff', (STRING)le.version3.DiffState2 )),
						71 => ROW(createrec('CurrPrevAddrTaxDiff', (STRING)le.version3.AssessedDiff2 )),
						72 => ROW(createrec('PrevCurrEconTrajectory', (STRING)le.version3.EcoTrajectory2 )),
						73 => ROW(createrec('AddrStability', (STRING)(string)le.version3.mobility_indicator )),
						74 => ROW(createrec('StatusMostRecent', (STRING)le.version3.statusAddr )),
						75 => ROW(createrec('StatusPrevious', (STRING)le.version3.statusAddr2 )),
						76 => ROW(createrec('StatusNextPrevious', (STRING)le.version3.statusAddr3 )),
						77 => ROW(createrec('AddrChangeCount01', (STRING)(string)le.version3.addrChanges30 )),
						78 => ROW(createrec('AddrChangeCount03', (STRING)(string)le.version3.AddrChanges90 )),
						79 => ROW(createrec('AddrChangeCount06', (STRING)(string)le.version3.AddrChanges180 )),
						80 => ROW(createrec('AddrChangeCount12', (STRING)(string)le.version3.AddrChanges12 )),
						81 => ROW(createrec('AddrChangeCount24', (STRING)(string)le.version3.AddrChanges24 )),
						82 => ROW(createrec('AddrChangeCount36', (STRING)(string)le.version3.AddrChanges36 )),
						83 => ROW(createrec('AddrChangeCount60', (STRING)(string)le.version3.AddrChanges60 )),
						84 => ROW(createrec('PropOwnedCount', (STRING)(string)le.version3.property_owned_total )),
						85 => ROW(createrec('PropOwnedTaxTotal', (STRING)(string)le.version3.property_owned_assessed_total )),
						86 => ROW(createrec('PropOwnedHistoricalCount', (STRING)(string)le.version3.property_historically_owned )),
						87 => ROW(createrec('PropAgeOldestPurchase', (STRING)le.version3.PropAgeOldestPurchase )),
						88 => ROW(createrec('PropAgeNewestPurchase', (STRING)le.version3.PropAgeNewestPurchase )),
						89 => ROW(createrec('PropAgeNewestSale', (STRING)le.version3.PropAgeNewestSale )),
						90 => ROW(createrec('PropPurchasedCount01', (STRING)(string)le.version3.numPurchase30 )),
						91 => ROW(createrec('PropPurchasedCount03', (STRING)(string)le.version3.numPurchase90 )),
						92 => ROW(createrec('PropPurchasedCount06', (STRING)(string)le.version3.numPurchase180 )),
						93 => ROW(createrec('PropPurchasedCount12', (STRING)(string)le.version3.numPurchase12 )),
						94 => ROW(createrec('PropPurchasedCount24', (STRING)(string)le.version3.numPurchase24 )),
						95 => ROW(createrec('PropPurchasedCount36', (STRING)(string)le.version3.numPurchase36 )),
						96 => ROW(createrec('PropPurchasedCount60', (STRING)(string)le.version3.numPurchase60 )),
						97 => ROW(createrec('PropSoldCount01', (STRING)(string)le.version3.numSold30 )),
						98 => ROW(createrec('PropSoldCount03', (STRING)(string)le.version3.numSold90 )),
						99 => ROW(createrec('PropSoldCount06', (STRING)(string)le.version3.numSold180 )),
						100 => ROW(createrec('PropSoldCount12', (STRING)(string)le.version3.numSold12 )),
						101 => ROW(createrec('PropSoldCount24', (STRING)(string)le.version3.numSold24 )),
						102 => ROW(createrec('PropSoldCount36', (STRING)(string)le.version3.numSold36 )),
						103 => ROW(createrec('PropSoldCount60', (STRING)(string)le.version3.numSold60 )),
						104 => ROW(createrec('WatercraftCount', (STRING)(string)le.version3.NumWatercraft )),
						105 => ROW(createrec('WatercraftCount01', (STRING)(string)le.version3.NumWatercraft30 )),
						106 => ROW(createrec('WatercraftCount03', (STRING)(string)le.version3.NumWatercraft90 )),
						107 => ROW(createrec('WatercraftCount06', (STRING)(string)le.version3.NumWatercraft180 )),
						108 => ROW(createrec('WatercraftCount12', (STRING)(string)le.version3.NumWatercraft12 )),
						109 => ROW(createrec('WatercraftCount24', (STRING)(string)le.version3.NumWatercraft24 )),
						110 => ROW(createrec('WatercraftCount36', (STRING)(string)le.version3.NumWatercraft36 )),
						111 => ROW(createrec('WatercraftCount60', (STRING)(string)le.version3.NumWatercraft60 )),
						112 => ROW(createrec('AircraftCount', (STRING)(string)le.version3.NumAircraft )),
						113 => ROW(createrec('AircraftCount01', (STRING)(string)le.version3.NumAircraft30 )),
						114 => ROW(createrec('AircraftCount03', (STRING)(string)le.version3.NumAircraft90 )),
						115 => ROW(createrec('AircraftCount06', (STRING)(string)le.version3.NumAircraft180 )),
						116 => ROW(createrec('AircraftCount12', (STRING)(string)le.version3.NumAircraft12 )),
						117 => ROW(createrec('AircraftCount24', (STRING)(string)le.version3.NumAircraft24 )),
						118 => ROW(createrec('AircraftCount36', (STRING)(string)le.version3.NumAircraft36 )),
						119 => ROW(createrec('AircraftCount60', (STRING)(string)le.version3.NumAircraft60 )),
						120 => ROW(createrec('WealthIndex', (STRING)le.version3.wealth_indicator )),
						121 => ROW(createrec('DerogCount', (STRING)(string)le.version3.total_number_derogs )),
						122 => ROW(createrec('DerogAge', (STRING)le.version3.DerogAge )),
						123 => ROW(createrec('FelonyCount', (STRING)(string)le.version3.felonies )),
						124 => ROW(createrec('FelonyAge', (STRING)le.version3.FelonyAge )),
						125 => ROW(createrec('FelonyCount01', (STRING)(string)le.version3.Felonies30 )),
						126 => ROW(createrec('FelonyCount03', (STRING)(string)le.version3.Felonies90 )),
						127 => ROW(createrec('FelonyCount06', (STRING)(string)le.version3.Felonies180 )),
						128 => ROW(createrec('FelonyCount12', (STRING)(string)le.version3.Felonies12 )),
						129 => ROW(createrec('FelonyCount24', (STRING)(string)le.version3.Felonies24 )),
						130 => ROW(createrec('FelonyCount36', (STRING)(string)le.version3.Felonies36 )),
						131 => ROW(createrec('FelonyCount60', (STRING)(string)le.version3.Felonies60 )),
						132 => ROW(createrec('LienCount', (STRING)(string)le.version3.num_liens )),
						133 => ROW(createrec('LienFiledCount', (STRING)(string)le.version3.num_unreleased_liens )),
						134 => ROW(createrec('LienFiledAge', (STRING)le.version3.LienFiledAge )),
						135 => ROW(createrec('LienFiledCount01', (STRING)(string)le.version3.num_unreleased_liens30 )),
						136 => ROW(createrec('LienFiledCount03', (STRING)(string)le.version3.num_unreleased_liens90 )),
						137 => ROW(createrec('LienFiledCount06', (STRING)(string)le.version3.num_unreleased_liens180 )),
						138 => ROW(createrec('LienFiledCount12', (STRING)(string)le.version3.num_unreleased_liens12 )),
						139 => ROW(createrec('LienFiledCount24', (STRING)(string)le.version3.num_unreleased_liens24 )),
						140 => ROW(createrec('LienFiledCount36', (STRING)(string)le.version3.num_unreleased_liens36 )),
						141 => ROW(createrec('LienFiledCount60', (STRING)(string)le.version3.num_unreleased_liens60 )),
						142 => ROW(createrec('LienReleasedCount', (STRING)(string)le.version3.num_released_liens )),
						143 => ROW(createrec('LienReleasedAge', (STRING)le.version3.LienReleasedAge )),
						144 => ROW(createrec('LienReleasedCount01', (STRING)(string)le.version3.num_released_liens30 )),
						145 => ROW(createrec('LienReleasedCount03', (STRING)(string)le.version3.num_released_liens90 )),
						146 => ROW(createrec('LienReleasedCount06', (STRING)(string)le.version3.num_released_liens180 )),
						147 => ROW(createrec('LienReleasedCount12', (STRING)(string)le.version3.num_released_liens12 )),
						148 => ROW(createrec('LienReleasedCount24', (STRING)(string)le.version3.num_released_liens24 )),
						149 => ROW(createrec('LienReleasedCount36', (STRING)(string)le.version3.num_released_liens36 )),
						150 => ROW(createrec('LienReleasedCount60', (STRING)(string)le.version3.num_released_liens60 )),
						151 => ROW(createrec('BankruptcyCount', (STRING)(string)le.version3.bankruptcy_count )),
						152 => ROW(createrec('BankruptcyAge', (STRING)le.version3.BankruptcyAge )),
						153 => ROW(createrec('BankruptcyType', (STRING)le.version3.filing_type )),
						154 => ROW(createrec('BankruptcyStatus', (STRING)le.version3.disposition )),
						155 => ROW(createrec('BankruptcyCount01', (STRING)(string)le.version3.bankruptcy_count30 )),
						156 => ROW(createrec('BankruptcyCount03', (STRING)(string)le.version3.bankruptcy_count90 )),
						157 => ROW(createrec('BankruptcyCount06', (STRING)(string)le.version3.bankruptcy_count180 )),
						158 => ROW(createrec('BankruptcyCount12', (STRING)(string)le.version3.bankruptcy_count12 )),
						159 => ROW(createrec('BankruptcyCount24', (STRING)(string)le.version3.bankruptcy_count24 )),
						160 => ROW(createrec('BankruptcyCount36', (STRING)(string)le.version3.bankruptcy_count36 )),
						161 => ROW(createrec('BankruptcyCount60', (STRING)(string)le.version3.bankruptcy_count60 )),
						162 => ROW(createrec('EvictionCount', (STRING)(string)le.version3.eviction_count )),
						163 => ROW(createrec('EvictionAge', (STRING)le.version3.EvictionAge )),
						164 => ROW(createrec('EvictionCount01', (STRING)(string)le.version3.eviction_count30 )),
						165 => ROW(createrec('EvictionCount03', (STRING)(string)le.version3.eviction_count90 )),
						166 => ROW(createrec('EvictionCount06', (STRING)(string)le.version3.eviction_count180 )),
						167 => ROW(createrec('EvictionCount12', (STRING)(string)le.version3.eviction_count12 )),
						168 => ROW(createrec('EvictionCount24', (STRING)(string)le.version3.eviction_count24 )),
						169 => ROW(createrec('EvictionCount36', (STRING)(string)le.version3.eviction_count36 )),
						170 => ROW(createrec('EvictionCount60', (STRING)(string)le.version3.eviction_count60 )),
						171 => ROW(createrec('NonDerogCount', (STRING)(string)le.version3.num_nonderogs )),
						172 => ROW(createrec('NonDerogCount01', (STRING)(string)le.version3.num_nonderogs30 )),
						173 => ROW(createrec('NonDerogCount03', (STRING)(string)le.version3.num_nonderogs90 )),
						174 => ROW(createrec('NonDerogCount06', (STRING)(string)le.version3.num_nonderogs180 )),
						175 => ROW(createrec('NonDerogCount12', (STRING)(string)le.version3.num_nonderogs12 )),
						176 => ROW(createrec('NonDerogCount24', (STRING)(string)le.version3.num_nonderogs24 )),
						177 => ROW(createrec('NonDerogCount36', (STRING)(string)le.version3.num_nonderogs36 )),
						178 => ROW(createrec('NonDerogCount60', (STRING)(string)le.version3.num_nonderogs60 )),
						179 => ROW(createrec('ProfLicCount', (STRING)(string)le.version3.num_proflic )),
						180 => ROW(createrec('ProfLicAge', (STRING)le.version3.ProfLicAge )),
						181 => ROW(createrec('ProfLicType', (STRING)le.version3.proflic_type )),
						182 => ROW(createrec('ProfLicExpireDate', (STRING)le.version3.expire_date_last_proflic )),
						183 => ROW(createrec('ProfLicCount01', (STRING)(string)le.version3.num_proflic30 )),
						184 => ROW(createrec('ProfLicCount03', (STRING)(string)le.version3.num_proflic90 )),
						185 => ROW(createrec('ProfLicCount06', (STRING)(string)le.version3.num_proflic180 )),
						186 => ROW(createrec('ProfLicCount12', (STRING)(string)le.version3.num_proflic12 )),
						187 => ROW(createrec('ProfLicCount24', (STRING)(string)le.version3.num_proflic24 )),
						188 => ROW(createrec('ProfLicCount36', (STRING)(string)le.version3.num_proflic36 )),
						189 => ROW(createrec('ProfLicCount60', (STRING)(string)le.version3.num_proflic60 )),
						190 => ROW(createrec('ProfLicExpireCount01', (STRING)(string)le.version3.num_proflic_exp30 )),
						191 => ROW(createrec('ProfLicExpireCount03', (STRING)(string)le.version3.num_proflic_exp90 )),
						192 => ROW(createrec('ProfLicExpireCount06', (STRING)(string)le.version3.num_proflic_exp180 )),
						193 => ROW(createrec('ProfLicExpireCount12', (STRING)(string)le.version3.num_proflic_exp12 )),
						194 => ROW(createrec('ProfLicExpireCount24', (STRING)(string)le.version3.num_proflic_exp24 )),
						195 => ROW(createrec('ProfLicExpireCount36', (STRING)(string)le.version3.num_proflic_exp36 )),
						196 => ROW(createrec('ProfLicExpireCount60', (STRING)(string)le.version3.num_proflic_exp60 )),
						197 => ROW(createrec('InputAddrHighRisk', (STRING)le.version3.AddrHighRisk )),
						198 => ROW(createrec('InputPhoneHighRisk', (STRING)le.version3.PhoneHighRisk )),
						199 => ROW(createrec('InputAddrPrison', (STRING)le.version3.AddrPrison )),
						200 => ROW(createrec('InputZipPOBox', (STRING)le.version3.ZipPOBox )),
						201 => ROW(createrec('InputZipCorpMil', (STRING)le.version3.ZipCorpMil )),
						202 => ROW(createrec('InputPhoneStatus', (STRING)le.version3.phoneStatus )),
						203 => ROW(createrec('InputPhonePager', (STRING)le.version3.PhonePager )),
						204 => ROW(createrec('InputPhoneMobile', (STRING)le.version3.PhoneMobile )),
						205 => ROW(createrec('InvalidPhoneZip', (STRING)le.version3.PhoneZipMismatch )),
						206 => ROW(createrec('InputPhoneAddrDist', (STRING)le.version3.phoneAddrDist )),
						207 => ROW(createrec('SecurityFreeze', (STRING)checkBoolean(le.version3.SecurityFreeze) )),
						208 => ROW(createrec('SecurityAlert', (STRING)checkBoolean(le.version3.SecurityAlert) )),
						209 => ROW(createrec('IDTheftFlag', (STRING)checkBoolean(le.version3.IdTheftFlag) )),
						210 => ROW(createrec('CorrectedFlag', (STRING)checkBoolean(le.version3.CorrectedFlag) )),
						211 => ROW(createrec('SSNNotFound', (STRING)le.version3.SSNNotFound )),
						212 => ROW(createrec('VerifiedName', (STRING)(string)le.version3.VerifiedName )),
						213 => ROW(createrec('VerifiedSSN', (STRING)(string)le.version3.VerifiedSSN )),
						214 => ROW(createrec('VerifiedPhone', (STRING)(string)le.version3.VerifiedPhone )),
						215 => ROW(createrec('VerifiedAddress', (STRING)(string)le.version3.VerifiedAddress )),
						216 => ROW(createrec('VerifiedDOB', (STRING)(string)le.version3.VerifiedDOB )),
						217 => ROW(createrec('InferredMinimumAge', (STRING)le.version3.InferredMinimumAge )),
						218 => ROW(createrec('BestReportedAge', (STRING)le.version3.BestReportedAge )),
						219 => ROW(createrec('SubjectSSNCount', (STRING)(string)le.version3.SubjectSSNCount )),
						220 => ROW(createrec('SubjectAddrCount', (STRING)(string)le.version3.SubjectAddrCount )),
						221 => ROW(createrec('SubjectPhoneCount', (STRING)(string)le.version3.SubjectPhoneCount )),
						222 => ROW(createrec('SubjectSSNRecentCount', (STRING)(string)le.version3.SubjectSSNRecentCount )),
						223 => ROW(createrec('SubjectAddrRecentCount', (STRING)(string)le.version3.SubjectAddrRecentCount )),
						224 => ROW(createrec('SubjectPhoneRecentCount', (STRING)(string)le.version3.SubjectPhoneRecentCount )),
						225 => ROW(createrec('SSNIdentitiesCount', (STRING)(string)le.version3.SSNIdentitiesCount )),
						226 => ROW(createrec('SSNAddrCount', (STRING)(string)le.version3.SSNAddrCount )),
						227 => ROW(createrec('SSNIdentitiesRecentCount', (STRING)(string)le.version3.SSNIdentitiesRecentCount )),
						228 => ROW(createrec('SSNAddrRecentCount', (STRING)(string)le.version3.SSNAddrRecentCount )),
						229 => ROW(createrec('InputAddrIdentitiesCount', (STRING)(string)le.version3.InputAddrIdentitiesCount )),
						230 => ROW(createrec('InputAddrSSNCount', (STRING)(string)le.version3.InputAddrSSNCount )),
						231 => ROW(createrec('InputAddrPhoneCount', (STRING)(string)le.version3.InputAddrPhoneCount )),
						232 => ROW(createrec('InputAddrIdentitiesRecentCount', (STRING)(string)le.version3.InputAddrIdentitiesRecentCount )),
						233 => ROW(createrec('InputAddrSSNRecentCount', (STRING)(string)le.version3.InputAddrSSNRecentCount )),
						234 => ROW(createrec('InputAddrPhoneRecentCount', (STRING)(string)le.version3.InputAddrPhoneRecentCount )),
						235 => ROW(createrec('PhoneIdentitiesCount', (STRING)(string)le.version3.PhoneIdentitiesCount )),
						236 => ROW(createrec('PhoneIdentitiesRecentCount', (STRING)(string)le.version3.PhoneIdentitiesRecentCount )),
						237 => ROW(createrec('SSNIssuedPriorDOB', (STRING)le.version3.SSNIssuedPriorDOB )),
						238 => ROW(createrec('InputAddrTaxYr', (STRING)le.version3.InputAddrTaxYr )),
						239 => ROW(createrec('InputAddrTaxMarketValue', (STRING)(string)le.version3.InputAddrTaxMarketValue )),
						240 => ROW(createrec('InputAddrAVMTax', (STRING)(string)le.version3.InputAddrAVMTax )),
						241 => ROW(createrec('InputAddrAVMSalesPrice', (STRING)(string)le.version3.InputAddrAVMSalesPrice )),
						242 => ROW(createrec('InputAddrAVMHedonic', (STRING)(string)le.version3.InputAddrAVMHedonic )),
						243 => ROW(createrec('InputAddrAVMValue', (STRING)(string)le.version3.InputAddrAVMValue )),
						244 => ROW(createrec('InputAddrAVMConfidence', (STRING)(string)le.version3.InputAddrAVMConfidence )),
						245 => ROW(createrec('InputAddrCountyIndex', (STRING)(string)le.version3.InputAddrCountyIndex )),
						246 => ROW(createrec('InputAddrTractIndex', (STRING)(string)le.version3.InputAddrTractIndex )),
						247 => ROW(createrec('InputAddrBlockIndex', (STRING)(string)le.version3.InputAddrBlockIndex )),
						248 => ROW(createrec('CurrAddrTaxYr', (STRING)le.version3.CurrAddrTaxYr )),
						249 => ROW(createrec('CurrAddrTaxMarketValue', (STRING)(string)le.version3.CurrAddrTaxMarketValue )),
						250 => ROW(createrec('CurrAddrAVMTax', (STRING)(string)le.version3.CurrAddrAVMTax )),
						251 => ROW(createrec('CurrAddrAVMSalesPrice', (STRING)(string)le.version3.CurrAddrAVMSalesPrice )),
						252 => ROW(createrec('CurrAddrAVMHedonic', (STRING)(string)le.version3.CurrAddrAVMHedonic )),
						253 => ROW(createrec('CurrAddrAVMValue', (STRING)(string)le.version3.CurrAddrAVMValue )),
						254 => ROW(createrec('CurrAddrAVMConfidence', (STRING)(string)le.version3.CurrAddrAVMConfidence )),
						255 => ROW(createrec('CurrAddrCountyIndex', (STRING)(string)le.version3.CurrAddrCountyIndex )),
						256 => ROW(createrec('CurrAddrTractIndex', (STRING)(string)le.version3.CurrAddrTractIndex )),
						257 => ROW(createrec('CurrAddrBlockIndex', (STRING)(string)le.version3.CurrAddrBlockIndex )),
						258 => ROW(createrec('PrevAddrTaxYr', (STRING)le.version3.PrevAddrTaxYr )),
						259 => ROW(createrec('PrevAddrTaxMarketValue', (STRING)(string)le.version3.PrevAddrTaxMarketValue )),
						260 => ROW(createrec('PrevAddrAVMTax', (STRING)(string)le.version3.PrevAddrAVMTax )),
						261 => ROW(createrec('PrevAddrAVMSalesPrice', (STRING)(string)le.version3.PrevAddrAVMSalesPrice )),
						262 => ROW(createrec('PrevAddrAVMHedonic', (STRING)(string)le.version3.PrevAddrAVMHedonic )),
						263 => ROW(createrec('PrevAddrAVMValue', (STRING)(string)le.version3.PrevAddrAVMValue )),
						264 => ROW(createrec('PrevAddrAVMConfidence', (STRING)(string)le.version3.PrevAddrAVMConfidence )),
						265 => ROW(createrec('PrevAddrCountyIndex', (STRING)(string)le.version3.PrevAddrCountyIndex )),
						266 => ROW(createrec('PrevAddrTractIndex', (STRING)(string)le.version3.PrevAddrTractIndex )),
						267 => ROW(createrec('PrevAddrBlockIndex', (STRING)(string)le.version3.PrevAddrBlockIndex )),
						268 => ROW(createrec('EducationAttendedCollege', (STRING)le.version3.EducationAttendedCollege )),
						269 => ROW(createrec('EducationProgram2Yr', (STRING)le.version3.EducationProgram2Yr )),
						270 => ROW(createrec('EducationProgram4Yr', (STRING)le.version3.EducationProgram4Yr )),
						271 => ROW(createrec('EducationProgramGraduate', (STRING)le.version3.EducationProgramGraduate )),
						272 => ROW(createrec('EducationInstitutionPrivate', (STRING)le.version3.EducationInstitutionPrivate )),
						273 => ROW(createrec('EducationInstitutionRating', (STRING)le.version3.EducationInstitutionRating )),
						274 => ROW(createrec('PredictedAnnualIncome', (STRING)le.version3.PredictedAnnualIncome )),
						275 => ROW(createrec('PropNewestSalePrice', (STRING)(string)le.version3.PropNewestSalePrice )),
						276 => ROW(createrec('PropNewestSalePurchaseIndex', (STRING)(string)le.version3.PropNewestSalePurchaseIndex )),
						277 => ROW(createrec('SubPrimeSolicitedCount', (STRING)(string)le.version3.SubPrimeSolicitedCount )),
						278 => ROW(createrec('SubPrimeSolicitedCount01', (STRING)(string)le.version3.SubPrimeSolicitedCount01 )),
						279 => ROW(createrec('SubprimeSolicitedCount03', (STRING)(string)le.version3.SubprimeSolicitedCount03 )),
						280 => ROW(createrec('SubprimeSolicitedCount06', (STRING)(string)le.version3.SubprimeSolicitedCount06 )),
						281 => ROW(createrec('SubPrimeSolicitedCount12', (STRING)(string)le.version3.SubPrimeSolicitedCount12 )),
						282 => ROW(createrec('SubPrimeSolicitedCount24', (STRING)(string)le.version3.SubPrimeSolicitedCount24 )),
						283 => ROW(createrec('SubPrimeSolicitedCount36', (STRING)(string)le.version3.SubPrimeSolicitedCount36 )),
						284 => ROW(createrec('SubPrimeSolicitedCount60', (STRING)(string)le.version3.SubPrimeSolicitedCount60 )),
						285 => ROW(createrec('LienFederalTaxFiledTotal', (STRING)(string)le.version3.LienFederalTaxFiledTotal )),
						286 => ROW(createrec('LienTaxOtherFiledTotal', (STRING)(string)le.version3.LienTaxOtherFiledTotal )),
						287 => ROW(createrec('LienForeclosureFiledTotal', (STRING)(string)le.version3.LienForeclosureFiledTotal )),
						288 => ROW(createrec('LienPreforeclosureFiledTotal', (STRING)(string)le.version3.LienPreforeclosureFiledTotal )),
						289 => ROW(createrec('LienLandlordTenantFiledTotal', (STRING)(string)le.version3.LienLandlordTenantFiledTotal )),
						290 => ROW(createrec('LienJudgmentFiledTotal', (STRING)(string)le.version3.LienJudgmentFiledTotal )),
						291 => ROW(createrec('LienSmallClaimsFiledTotal', (STRING)(string)le.version3.LienSmallClaimsFiledTotal )),
						292 => ROW(createrec('LienOtherFiledTotal', (STRING)(string)le.version3.LienOtherFiledTotal )),
						293 => ROW(createrec('LienFederalTaxReleasedTotal', (STRING)(string)le.version3.LienFederalTaxReleasedTotal )),
						294 => ROW(createrec('LienTaxOtherReleasedTotal', (STRING)(string)le.version3.LienTaxOtherReleasedTotal )),
						295 => ROW(createrec('LienForeclosureReleasedTotal', (STRING)(string)le.version3.LienForeclosureReleasedTotal )),
						296 => ROW(createrec('LienPreforeclosureReleasedTotal', (STRING)(string)le.version3.LienPreforeclosureReleasedTotal )),
						297 => ROW(createrec('LienLandlordTenantReleasedTotal', (STRING)(string)le.version3.LienLandlordTenantReleasedTotal )),
						298 => ROW(createrec('LienJudgmentReleasedTotal', (STRING)(string)le.version3.LienJudgmentReleasedTotal )),
						299 => ROW(createrec('LienSmallClaimsReleasedTotal', (STRING)(string)le.version3.LienSmallClaimsReleasedTotal )),
						300 => ROW(createrec('LienOtherReleasedTotal', (STRING)(string)le.version3.LienOtherReleasedTotal )),
						301 => ROW(createrec('LienFederalTaxFiledCount', (STRING)(string)le.version3.LienFederalTaxFiledCount )),
						302 => ROW(createrec('LienTaxOtherFiledCount', (STRING)(string)le.version3.LienTaxOtherFiledCount )),
						303 => ROW(createrec('LienForeclosureFiledCount', (STRING)(string)le.version3.LienForeclosureFiledCount )),
						304 => ROW(createrec('LienPreforeclosureFiledCount', (STRING)(string)le.version3.LienPreforeclosureFiledCount )),
						305 => ROW(createrec('LienLandlordTenantFiledCount', (STRING)(string)le.version3.LienLandlordTenantFiledCount )),
						306 => ROW(createrec('LienJudgmentFiledCount', (STRING)(string)le.version3.LienJudgmentFiledCount )),
						307 => ROW(createrec('LienSmallClaimsFiledCount', (STRING)(string)le.version3.LienSmallClaimsFiledCount )),
						308 => ROW(createrec('LienOtherFiledCount', (STRING)(string)le.version3.LienOtherFiledCount )),
						309 => ROW(createrec('LienFederalTaxReleasedCount', (STRING)(string)le.version3.LienFederalTaxReleasedCount )),
						310 => ROW(createrec('LienTaxOtherReleasedCount', (STRING)(string)le.version3.LienTaxOtherReleasedCount )),
						311 => ROW(createrec('LienForeclosureReleasedCount', (STRING)(string)le.version3.LienForeclosureReleasedCount )),
						312 => ROW(createrec('LienPreforeclosureReleasedCount', (STRING)(string)le.version3.LienPreforeclosureReleasedCount )),
						313 => ROW(createrec('LienLandlordTenantReleasedCount', (STRING)(string)le.version3.LienLandlordTenantReleasedCount )),
						314 => ROW(createrec('LienJudgmentReleasedCount', (STRING)(string)le.version3.LienJudgmentReleasedCount )),
						315 => ROW(createrec('LienSmallClaimsReleasedCount', (STRING)(string)le.version3.LienSmallClaimsReleasedCount )),
						316 => ROW(createrec('LienOtherReleasedCount', (STRING)(string)le.version3.LienOtherReleasedCount )),
						317 => ROW(createrec('ProfLicTypeCategory', (STRING)le.version3.ProfLicTypeCategory )),
						318 => ROW(createrec('PhoneEDAAgeOldestRecord', (STRING)le.version3.PhoneEDAAgeOldestRecord )),
						319 => ROW(createrec('PhoneEDAAgeNewestRecord', (STRING)le.version3.PhoneEDAAgeNewestRecord )),
						320 => ROW(createrec('PhoneOtherAgeOldestRecord', (STRING)le.version3.PhoneOtherAgeOldestRecord )),
						321 => ROW(createrec('PhoneOtherAgeNewestRecord', (STRING)le.version3.PhoneOtherAgeNewestRecord )),
									ROW(createrec('Invalid','Invalid'))   );

	end;

	export GROUPED DATASET(iesp.consumerattributesreport.t_NameValuePairLong) toAttributesRiskViewV3(GROUPED DATASET(Models.Layout_RVAttributes.Layout_rvAttrSeq) indata) := 
												normalize( indata, 321, convert(LEFT,COUNTER));
END;