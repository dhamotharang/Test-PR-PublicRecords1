IMPORT FraudGovUIKEL;

EXPORT BWR_RunDistributionDiff := MODULE
	
	shared data_layout := FraudGovUIKEL.Layouts.EmployerOutput;
	shared filePath := FraudGovUIKEL.Scripts.Utils.FilePaths.LogicalPath;

	shared r_diff := RECORD
			data_layout;
			integer isPrevRecord; // To diff records from past to current, need a flag
	END;
	
	shared r_diff_report := RECORD
			STRING attribute;
			integer diff_cnt;
			real diff_pct;
			integer num_to_special;
			integer num_from_special;
			integer num_value_down;
			integer num_value_up;
	END;
	
	// The previous dataset to compare to the new dataset
	shared dsPrev1 := DATASET(filePath + 'EmployerOutput', data_layout, CSV(HEADING(0),SEPARATOR(','),QUOTE('"')))(BusAcctUIDEcho!='-99999');
	shared dsCurr1 := DATASET(filePath + 'EmployerOutput', data_layout, CSV(HEADING(0),SEPARATOR(','),QUOTE('"')))(BusAcctUIDEcho!='-99999');
	
	shared dsPrev := PROJECT(dsPrev1, TRANSFORM(r_diff, 
													 self.isPrevRecord := 1;
													 self := left;));
													 
	shared dsCurr := PROJECT(dsCurr1, TRANSFORM(r_diff,
													 self.isPrevRecord := 0;
													 self := left;));
	
	shared ds1 := SORT(dsPrev + dsCurr, busAcctUIDEcho, -isPrevRecord);
	
	// Strategy
	// Add flag indicating which is old and which is new
	// Add together, sort and rollup on business id
	// Calc diff between attribute fields and assign a special indicator to the record indicating +/-/same/out of special value/into special value etc
	// // -1 - Previous record was in the special values, new record is not
	// // -2 - Previous record was not in the special values, new record is
	// // -3 - Previous record had a count lower than new record. The count went up
	// // -4 - Previous record had a count higher than new record. The count went down
	// // -5 - Previous record value not same as new record value
	// // -6 - No change
	// Consolidated into one dataset now. 
	// Rollup to an attribute report level.
	// Calc stats based on rollup
	// Case when new employer shows up/old one drops??
	
	shared special_values := ['-99999', '-99998', '-99997', '-99996', '-99995'];
	
	calcVariableDiff(STRING L, STRING R) := FUNCTION
			RETURN MAP(L IN special_values AND R NOT IN special_values => '-1',
								 L NOT IN special_values AND R IN special_values => '-2',
								 L < R => '-3',
								 L > R => '-4',
								 L != R => '-5',
								 '-6');
	END;
	shared ds2 := ROLLUP(ds1, left.BusAcctUIDEcho=right.BusAcctUIDEcho, TRANSFORM(r_diff,

				// Business IDs
				self.BusAcctUltIDAppend := calcVariableDiff(LEFT.BusAcctUltIDAppend, RIGHT.BusAcctUltIDAppend);
				self.BusAcctOrgIDAppend := calcVariableDiff(LEFT.BusAcctOrgIDAppend, RIGHT.BusAcctOrgIDAppend);
				self.BusAcctSeleIDAppend := calcVariableDiff(LEFT.BusAcctSeleIDAppend, RIGHT.BusAcctSeleIDAppend);
				self.BusAcctProxIDAppend := calcVariableDiff(LEFT.BusAcctProxIDAppend, RIGHT.BusAcctProxIDAppend);
				self.BusAcctPowIDAppend := calcVariableDiff(LEFT.BusAcctPowIDAppend, RIGHT.BusAcctPowIDAppend);
				// Record Dts
				self.BusAcctNewestUpdateMasterDt := calcVariableDiff(LEFT.BusAcctNewestUpdateMasterDt, RIGHT.BusAcctNewestUpdateMasterDt);
				self.BusAcctNewestRecordDt := calcVariableDiff(LEFT.BusAcctNewestRecordDt, RIGHT.BusAcctNewestRecordDt);
				self.BusNewestRecordDt := calcVariableDiff(LEFT.BusNewestRecordDt, RIGHT.BusNewestRecordDt);
				// Program Business Input Echo
				self.BusAcctStateClean := calcVariableDiff(LEFT.BusAcctStateClean, RIGHT.BusAcctStateClean);
				self.BusAcctAddressTypeClean := calcVariableDiff(LEFT.BusAcctAddressTypeClean, RIGHT.BusAcctAddressTypeClean);
				// Program Business Input Pop Flags
				self.BusAcctOwnerName1Pop := calcVariableDiff(LEFT.BusAcctOwnerName1Pop, RIGHT.BusAcctOwnerName1Pop);
				self.BusAcctOwnerSSN1Pop := calcVariableDiff(LEFT.BusAcctOwnerSSN1Pop, RIGHT.BusAcctOwnerSSN1Pop);
				self.BusAcctOwnerName2Pop := calcVariableDiff(LEFT.BusAcctOwnerName2Pop, RIGHT.BusAcctOwnerName2Pop);
				self.BusAcctOwnerSSN2Pop := calcVariableDiff(LEFT.BusAcctOwnerSSN2Pop, RIGHT.BusAcctOwnerSSN2Pop);
				self.BusAcctOwnerName3Pop := calcVariableDiff(LEFT.BusAcctOwnerName3Pop, RIGHT.BusAcctOwnerName3Pop);
				self.BusAcctOwnerSSN3Pop := calcVariableDiff(LEFT.BusAcctOwnerSSN3Pop, RIGHT.BusAcctOwnerSSN3Pop);
				self.BusAcctFullAddressCleanPop := calcVariableDiff(LEFT.BusAcctFullAddressCleanPop, RIGHT.BusAcctFullAddressCleanPop);
				// Program Contributed Data Echo
				self.BusAcctOpenDtEcho := calcVariableDiff(LEFT.BusAcctOpenDtEcho, RIGHT.BusAcctOpenDtEcho);
				self.BusOldestAcctOpenDt := calcVariableDiff(LEFT.BusOldestAcctOpenDt, RIGHT.BusOldestAcctOpenDt);
				self.BusNewestAcctOpenDt := calcVariableDiff(LEFT.BusNewestAcctOpenDt, RIGHT.BusNewestAcctOpenDt);
				self.BusAcctStatusTypeEcho := calcVariableDiff(LEFT.BusAcctStatusTypeEcho, RIGHT.BusAcctStatusTypeEcho);
				self.BusAcctDtEmployerBeganEcho := calcVariableDiff(LEFT.BusAcctDtEmployerBeganEcho, RIGHT.BusAcctDtEmployerBeganEcho);
				self.BusOldestEmployerBeganDt := calcVariableDiff(LEFT.BusOldestEmployerBeganDt, RIGHT.BusOldestEmployerBeganDt);
				self.BusNewestEmployerBeganDt := calcVariableDiff(LEFT.BusNewestEmployerBeganDt, RIGHT.BusNewestEmployerBeganDt);
				self.BusAcctTaxLiabStartDtEcho := calcVariableDiff(LEFT.BusAcctTaxLiabStartDtEcho, RIGHT.BusAcctTaxLiabStartDtEcho);
				self.BusAcctTaxLiabEndDtEcho := calcVariableDiff(LEFT.BusAcctTaxLiabEndDtEcho, RIGHT.BusAcctTaxLiabEndDtEcho);
				self.BusOldestTaxLiabStartDt := calcVariableDiff(LEFT.BusOldestTaxLiabStartDt, RIGHT.BusOldestTaxLiabStartDt);
				self.BusNewestTaxLiabStartDt := calcVariableDiff(LEFT.BusNewestTaxLiabStartDt, RIGHT.BusNewestTaxLiabStartDt);
				self.BusOldestTaxLiabEndDt := calcVariableDiff(LEFT.BusOldestTaxLiabEndDt, RIGHT.BusOldestTaxLiabEndDt);
				self.BusNewestTaxLiabEndDt := calcVariableDiff(LEFT.BusNewestTaxLiabEndDt, RIGHT.BusNewestTaxLiabEndDt);
				self.BusAcctOldestUnemClmDt := calcVariableDiff(LEFT.BusAcctOldestUnemClmDt, RIGHT.BusAcctOldestUnemClmDt);
				self.BusAcctNewestUnemClmDt := calcVariableDiff(LEFT.BusAcctNewestUnemClmDt, RIGHT.BusAcctNewestUnemClmDt);
				self.BusOldestUnemClmDt := calcVariableDiff(LEFT.BusOldestUnemClmDt, RIGHT.BusOldestUnemClmDt);
				self.BusNewestUnemClmDt := calcVariableDiff(LEFT.BusNewestUnemClmDt, RIGHT.BusNewestUnemClmDt);
				self.BusAcctOwnerCntEcho := calcVariableDiff(LEFT.BusAcctOwnerCntEcho, RIGHT.BusAcctOwnerCntEcho);
				self.BusAcctLegalActionTypeEcho := calcVariableDiff(LEFT.BusAcctLegalActionTypeEcho, RIGHT.BusAcctLegalActionTypeEcho);
				self.BusAcctWarrantIssuedCntEcho := calcVariableDiff(LEFT.BusAcctWarrantIssuedCntEcho, RIGHT.BusAcctWarrantIssuedCntEcho);
				self.BusAcctWarrantIssuedDtEcho := calcVariableDiff(LEFT.BusAcctWarrantIssuedDtEcho, RIGHT.BusAcctWarrantIssuedDtEcho);
				self.BusAcctTaxLiabBlceStatusEcho := calcVariableDiff(LEFT.BusAcctTaxLiabBlceStatusEcho, RIGHT.BusAcctTaxLiabBlceStatusEcho);
				// Business Incorporation
				self.BusIncorpDt := calcVariableDiff(LEFT.BusIncorpDt, RIGHT.BusIncorpDt);
				self.BusIncorpStatusType := calcVariableDiff(LEFT.BusIncorpStatusType, RIGHT.BusIncorpStatusType);
				self.BusIncorpMSince := calcVariableDiff(LEFT.BusIncorpMSince, RIGHT.BusIncorpMSince);
				// Business Program History
				self.BusAcctOpenDtMsince := calcVariableDiff(LEFT.BusAcctOpenDtMsince, RIGHT.BusAcctOpenDtMsince);
				self.BusOldestAcctOpenDtMsince := calcVariableDiff(LEFT.BusOldestAcctOpenDtMsince, RIGHT.BusOldestAcctOpenDtMsince);
				self.BusAcctEmpBeganToOpenDtSpan := calcVariableDiff(LEFT.BusAcctEmpBeganToOpenDtSpan, RIGHT.BusAcctEmpBeganToOpenDtSpan);
				self.BusOldestEmpBeganToAcctOpenSpan := calcVariableDiff(LEFT.BusOldestEmpBeganToAcctOpenSpan, RIGHT.BusOldestEmpBeganToAcctOpenSpan);
				self.BusEmpBeganToAcctOpenLT12MCnt := calcVariableDiff(LEFT.BusEmpBeganToAcctOpenLT12MCnt, RIGHT.BusEmpBeganToAcctOpenLT12MCnt);
				self.BusEmpBeganToAcctOpenLT6MCnt := calcVariableDiff(LEFT.BusEmpBeganToAcctOpenLT6MCnt, RIGHT.BusEmpBeganToAcctOpenLT6MCnt);
				self.BusEmpBeganToAcctOpenGT12MCnt := calcVariableDiff(LEFT.BusEmpBeganToAcctOpenGT12MCnt, RIGHT.BusEmpBeganToAcctOpenGT12MCnt);
				self.BusAcctLiabStartToOpenDtSpan := calcVariableDiff(LEFT.BusAcctLiabStartToOpenDtSpan, RIGHT.BusAcctLiabStartToOpenDtSpan);
				self.BusOldestLiabStartToAcctOpenSpan := calcVariableDiff(LEFT.BusOldestLiabStartToAcctOpenSpan, RIGHT.BusOldestLiabStartToAcctOpenSpan);
				self.BusIncorpToOldestAcctOpenSpan := calcVariableDiff(LEFT.BusIncorpToOldestAcctOpenSpan, RIGHT.BusIncorpToOldestAcctOpenSpan);
				// Tax Liability History
				self.BusAcctTaxLiabStartMsince := calcVariableDiff(LEFT.BusAcctTaxLiabStartMsince, RIGHT.BusAcctTaxLiabStartMsince);
				self.BusAcctTaxLiabEndMsince := calcVariableDiff(LEFT.BusAcctTaxLiabEndMsince, RIGHT.BusAcctTaxLiabEndMsince);
				self.BusTaxLiabOngoingFlag := calcVariableDiff(LEFT.BusTaxLiabOngoingFlag, RIGHT.BusTaxLiabOngoingFlag);
				self.BusOldestTaxLiabStartMsince := calcVariableDiff(LEFT.BusOldestTaxLiabStartMsince, RIGHT.BusOldestTaxLiabStartMsince);
				self.BusNewestTaxLiabEndMsince := calcVariableDiff(LEFT.BusNewestTaxLiabEndMsince, RIGHT.BusNewestTaxLiabEndMsince);
				self.BusIncorpToLiabSpan := calcVariableDiff(LEFT.BusIncorpToLiabSpan, RIGHT.BusIncorpToLiabSpan);
				// Unemployment Claim Event History
				self.BusAcctLiabToOldestUnemClmSpan := calcVariableDiff(LEFT.BusAcctLiabToOldestUnemClmSpan, RIGHT.BusAcctLiabToOldestUnemClmSpan);
				self.BusAcctLiabToNewestUnemClmSpan := calcVariableDiff(LEFT.BusAcctLiabToNewestUnemClmSpan, RIGHT.BusAcctLiabToNewestUnemClmSpan);
				self.BusIncorpToOldestUnemClmSpan := calcVariableDiff(LEFT.BusIncorpToOldestUnemClmSpan, RIGHT.BusIncorpToOldestUnemClmSpan);
				self.BusIncorpToNewestUnemClmSpan := calcVariableDiff(LEFT.BusIncorpToNewestUnemClmSpan, RIGHT.BusIncorpToNewestUnemClmSpan);
				self.BusLiabToOldestUnemClmSpan := calcVariableDiff(LEFT.BusLiabToOldestUnemClmSpan, RIGHT.BusLiabToOldestUnemClmSpan);
				self.BusLiabToNewestUnemClmSpan := calcVariableDiff(LEFT.BusLiabToNewestUnemClmSpan, RIGHT.BusLiabToNewestUnemClmSpan);
				self.BusAcctUnemClaimCurrActiveCnt := calcVariableDiff(LEFT.BusAcctUnemClaimCurrActiveCnt, RIGHT.BusAcctUnemClaimCurrActiveCnt);
				self.BusAcctUnemClaimFiledCntEv := calcVariableDiff(LEFT.BusAcctUnemClaimFiledCntEv, RIGHT.BusAcctUnemClaimFiledCntEv);
				self.BusAcctUnemClaimFiledCnt1Y := calcVariableDiff(LEFT.BusAcctUnemClaimFiledCnt1Y, RIGHT.BusAcctUnemClaimFiledCnt1Y);
				self.BusAcctUnemClaimFiledCnt120D := calcVariableDiff(LEFT.BusAcctUnemClaimFiledCnt120D, RIGHT.BusAcctUnemClaimFiledCnt120D);
				self.BusAcctUnemClaimFiledCnt90D := calcVariableDiff(LEFT.BusAcctUnemClaimFiledCnt90D, RIGHT.BusAcctUnemClaimFiledCnt90D);
				self.BusAcctUnemClaimFiledCnt30D := calcVariableDiff(LEFT.BusAcctUnemClaimFiledCnt30D, RIGHT.BusAcctUnemClaimFiledCnt30D);
				self.BusAcctUnemClaimApprvCntEv := calcVariableDiff(LEFT.BusAcctUnemClaimApprvCntEv, RIGHT.BusAcctUnemClaimApprvCntEv);
				self.BusAcctUnemClaimApprvCnt1Y := calcVariableDiff(LEFT.BusAcctUnemClaimApprvCnt1Y, RIGHT.BusAcctUnemClaimApprvCnt1Y);
				self.BusAcctUnemClaimApprvCnt120D := calcVariableDiff(LEFT.BusAcctUnemClaimApprvCnt120D, RIGHT.BusAcctUnemClaimApprvCnt120D);
				self.BusAcctUnemClaimApprvCnt90D := calcVariableDiff(LEFT.BusAcctUnemClaimApprvCnt90D, RIGHT.BusAcctUnemClaimApprvCnt90D);
				self.BusAcctUnemClaimApprvCnt30D := calcVariableDiff(LEFT.BusAcctUnemClaimApprvCnt30D, RIGHT.BusAcctUnemClaimApprvCnt30D);
				self.BusUnemClaimCurrActiveCnt := calcVariableDiff(LEFT.BusUnemClaimCurrActiveCnt, RIGHT.BusUnemClaimCurrActiveCnt);
				self.BusUnemClaimFiledCntEv := calcVariableDiff(LEFT.BusUnemClaimFiledCntEv, RIGHT.BusUnemClaimFiledCntEv);
				self.BusUnemClaimFiledCnt1Y := calcVariableDiff(LEFT.BusUnemClaimFiledCnt1Y, RIGHT.BusUnemClaimFiledCnt1Y);
				self.BusUnemClaimFiledCnt120D := calcVariableDiff(LEFT.BusUnemClaimFiledCnt120D, RIGHT.BusUnemClaimFiledCnt120D);
				self.BusUnemClaimFiledCnt90D := calcVariableDiff(LEFT.BusUnemClaimFiledCnt90D, RIGHT.BusUnemClaimFiledCnt90D);
				self.BusUnemClaimFiledCnt30D := calcVariableDiff(LEFT.BusUnemClaimFiledCnt30D, RIGHT.BusUnemClaimFiledCnt30D);
				self.BusUnemClaimApprvCntEv := calcVariableDiff(LEFT.BusUnemClaimApprvCntEv, RIGHT.BusUnemClaimApprvCntEv);
				self.BusUnemClaimApprvCnt1Y := calcVariableDiff(LEFT.BusUnemClaimApprvCnt1Y, RIGHT.BusUnemClaimApprvCnt1Y);
				self.BusUnemClaimApprvCnt120D := calcVariableDiff(LEFT.BusUnemClaimApprvCnt120D, RIGHT.BusUnemClaimApprvCnt120D);
				self.BusUnemClaimApprvCnt90D := calcVariableDiff(LEFT.BusUnemClaimApprvCnt90D, RIGHT.BusUnemClaimApprvCnt90D);
				self.BusUnemClaimApprvCnt30D := calcVariableDiff(LEFT.BusUnemClaimApprvCnt30D, RIGHT.BusUnemClaimApprvCnt30D);
				self.BusAcctUnemClmAfterOpenCnt30D := calcVariableDiff(LEFT.BusAcctUnemClmAfterOpenCnt30D, RIGHT.BusAcctUnemClmAfterOpenCnt30D);
				self.BusAcctUnemClmAfterOpenCnt60D := calcVariableDiff(LEFT.BusAcctUnemClmAfterOpenCnt60D, RIGHT.BusAcctUnemClmAfterOpenCnt60D);
				self.BusAcctUnemClmAfterOpenCnt90D := calcVariableDiff(LEFT.BusAcctUnemClmAfterOpenCnt90D, RIGHT.BusAcctUnemClmAfterOpenCnt90D);
				self.BusAcctUnemClmAfterOpenCnt120D := calcVariableDiff(LEFT.BusAcctUnemClmAfterOpenCnt120D, RIGHT.BusAcctUnemClmAfterOpenCnt120D);
				self.BusUnemClmAfterOldestOpenCnt30D := calcVariableDiff(LEFT.BusUnemClmAfterOldestOpenCnt30D, RIGHT.BusUnemClmAfterOldestOpenCnt30D);
				self.BusUnemClmAfterOldestOpenCnt60D := calcVariableDiff(LEFT.BusUnemClmAfterOldestOpenCnt60D, RIGHT.BusUnemClmAfterOldestOpenCnt60D);
				self.BusUnemClmAfterOldestOpenCnt90D := calcVariableDiff(LEFT.BusUnemClmAfterOldestOpenCnt90D, RIGHT.BusUnemClmAfterOldestOpenCnt90D);
				self.BusUnemClmAfterOldestOpenCnt120D := calcVariableDiff(LEFT.BusUnemClmAfterOldestOpenCnt120D, RIGHT.BusUnemClmAfterOldestOpenCnt120D);
				// Unemployment Claim Event History - Claimant Velocity
				self.BusAcctUnemClmAcctCurrActiveCnt := calcVariableDiff(LEFT.BusAcctUnemClmAcctCurrActiveCnt, RIGHT.BusAcctUnemClmAcctCurrActiveCnt);
				self.BusAcctUnemClmAcctFiledCntEv := calcVariableDiff(LEFT.BusAcctUnemClmAcctFiledCntEv, RIGHT.BusAcctUnemClmAcctFiledCntEv);
				self.BusAcctUnemClmAcctFiledCnt1Y := calcVariableDiff(LEFT.BusAcctUnemClmAcctFiledCnt1Y, RIGHT.BusAcctUnemClmAcctFiledCnt1Y);
				self.BusAcctUnemClmAcctFiledCnt120D := calcVariableDiff(LEFT.BusAcctUnemClmAcctFiledCnt120D, RIGHT.BusAcctUnemClmAcctFiledCnt120D);
				self.BusAcctUnemClmAcctFiledCnt90D := calcVariableDiff(LEFT.BusAcctUnemClmAcctFiledCnt90D, RIGHT.BusAcctUnemClmAcctFiledCnt90D);
				self.BusAcctUnemClmAcctFiledCnt30D := calcVariableDiff(LEFT.BusAcctUnemClmAcctFiledCnt30D, RIGHT.BusAcctUnemClmAcctFiledCnt30D);
				self.BusAcctUnemClmLexIDFiledCntEv := calcVariableDiff(LEFT.BusAcctUnemClmLexIDFiledCntEv, RIGHT.BusAcctUnemClmLexIDFiledCntEv);
				self.BusAcctUnemClmLexIDFiledCnt1Y := calcVariableDiff(LEFT.BusAcctUnemClmLexIDFiledCnt1Y, RIGHT.BusAcctUnemClmLexIDFiledCnt1Y);
				self.BusAcctUnemClmLexIDFiledCnt120D := calcVariableDiff(LEFT.BusAcctUnemClmLexIDFiledCnt120D, RIGHT.BusAcctUnemClmLexIDFiledCnt120D);
				self.BusAcctUnemClmLexIDFiledCnt90D := calcVariableDiff(LEFT.BusAcctUnemClmLexIDFiledCnt90D, RIGHT.BusAcctUnemClmLexIDFiledCnt90D);
				self.BusAcctUnemClmLexIDFiledCnt30D := calcVariableDiff(LEFT.BusAcctUnemClmLexIDFiledCnt30D, RIGHT.BusAcctUnemClmLexIDFiledCnt30D);
				self.BusAcctLexIDMultiUnemClmCntEv := calcVariableDiff(LEFT.BusAcctLexIDMultiUnemClmCntEv, RIGHT.BusAcctLexIDMultiUnemClmCntEv);
				self.BusAcctLexIDMultiUnemClmCnt1Y := calcVariableDiff(LEFT.BusAcctLexIDMultiUnemClmCnt1Y, RIGHT.BusAcctLexIDMultiUnemClmCnt1Y);
				self.BusAcctLexIDMultiUnemClmCnt120D := calcVariableDiff(LEFT.BusAcctLexIDMultiUnemClmCnt120D, RIGHT.BusAcctLexIDMultiUnemClmCnt120D);
				self.BusAcctLexIDMultiUnemClmCnt90D := calcVariableDiff(LEFT.BusAcctLexIDMultiUnemClmCnt90D, RIGHT.BusAcctLexIDMultiUnemClmCnt90D);
				self.BusAcctLexIDMultiUnemClmCnt30D := calcVariableDiff(LEFT.BusAcctLexIDMultiUnemClmCnt30D, RIGHT.BusAcctLexIDMultiUnemClmCnt30D);
				self.BusUnemClmAcctCurrActiveCnt := calcVariableDiff(LEFT.BusUnemClmAcctCurrActiveCnt, RIGHT.BusUnemClmAcctCurrActiveCnt);
				self.BusUnemClmAcctFiledCntEv := calcVariableDiff(LEFT.BusUnemClmAcctFiledCntEv, RIGHT.BusUnemClmAcctFiledCntEv);
				self.BusUnemClmAcctFiledCnt1Y := calcVariableDiff(LEFT.BusUnemClmAcctFiledCnt1Y, RIGHT.BusUnemClmAcctFiledCnt1Y);
				self.BusUnemClmAcctFiledCnt120D := calcVariableDiff(LEFT.BusUnemClmAcctFiledCnt120D, RIGHT.BusUnemClmAcctFiledCnt120D);
				self.BusUnemClmAcctFiledCnt90D := calcVariableDiff(LEFT.BusUnemClmAcctFiledCnt90D, RIGHT.BusUnemClmAcctFiledCnt90D);
				self.BusUnemClmAcctFiledCnt30D := calcVariableDiff(LEFT.BusUnemClmAcctFiledCnt30D, RIGHT.BusUnemClmAcctFiledCnt30D);
				self.BusUnemClmLexIDFiledCntEv := calcVariableDiff(LEFT.BusUnemClmLexIDFiledCntEv, RIGHT.BusUnemClmLexIDFiledCntEv);
				self.BusUnemClmLexIDFiledCnt1Y := calcVariableDiff(LEFT.BusUnemClmLexIDFiledCnt1Y, RIGHT.BusUnemClmLexIDFiledCnt1Y);
				self.BusUnemClmLexIDFiledCnt120D := calcVariableDiff(LEFT.BusUnemClmLexIDFiledCnt120D, RIGHT.BusUnemClmLexIDFiledCnt120D);
				self.BusUnemClmLexIDFiledCnt90D := calcVariableDiff(LEFT.BusUnemClmLexIDFiledCnt90D, RIGHT.BusUnemClmLexIDFiledCnt90D);
				self.BusUnemClmLexIDFiledCnt30D := calcVariableDiff(LEFT.BusUnemClmLexIDFiledCnt30D, RIGHT.BusUnemClmLexIDFiledCnt30D);
				self.BusLexIDMultiUnemClmCntEv := calcVariableDiff(LEFT.BusLexIDMultiUnemClmCntEv, RIGHT.BusLexIDMultiUnemClmCntEv);
				self.BusLexIDMultiUnemClmCnt1Y := calcVariableDiff(LEFT.BusLexIDMultiUnemClmCnt1Y, RIGHT.BusLexIDMultiUnemClmCnt1Y);
				self.BusLexIDMultiUnemClmCnt120D := calcVariableDiff(LEFT.BusLexIDMultiUnemClmCnt120D, RIGHT.BusLexIDMultiUnemClmCnt120D);
				self.BusLexIDMultiUnemClmCnt90D := calcVariableDiff(LEFT.BusLexIDMultiUnemClmCnt90D, RIGHT.BusLexIDMultiUnemClmCnt90D);
				self.BusLexIDMultiUnemClmCnt30D := calcVariableDiff(LEFT.BusLexIDMultiUnemClmCnt30D, RIGHT.BusLexIDMultiUnemClmCnt30D);
				// Business Structure
				self.BusAcctPerBusLegalEntCnt := calcVariableDiff(LEFT.BusAcctPerBusLegalEntCnt, RIGHT.BusAcctPerBusLegalEntCnt);
				// Business Address Velocity
				self.VelBusAcctPerAddrInProgCnt := calcVariableDiff(LEFT.VelBusAcctPerAddrInProgCnt, RIGHT.VelBusAcctPerAddrInProgCnt);
				self.VelBusAcctPerAddrInBusLegEntCnt := calcVariableDiff(LEFT.VelBusAcctPerAddrInBusLegEntCnt, RIGHT.VelBusAcctPerAddrInBusLegEntCnt);
				// High Risk Flags
				self.BusAcctUnemClmLT60DAfterOpenFlag := calcVariableDiff(LEFT.BusAcctUnemClmLT60DAfterOpenFlag, RIGHT.BusAcctUnemClmLT60DAfterOpenFlag);
				self.BusAcctUnemClm60To120DAftOpFlag := calcVariableDiff(LEFT.BusAcctUnemClm60To120DAftOpFlag, RIGHT.BusAcctUnemClm60To120DAftOpFlag);
				self.BusUnemClmLT60DAfterOpenFlag := calcVariableDiff(LEFT.BusUnemClmLT60DAfterOpenFlag, RIGHT.BusUnemClmLT60DAfterOpenFlag);
				self.BusUnemClm60To120DAfterOpenFlag := calcVariableDiff(LEFT.BusUnemClm60To120DAfterOpenFlag, RIGHT.BusUnemClm60To120DAfterOpenFlag);
				self.BusAcctLiabStartToOpenGT5MFlag := calcVariableDiff(LEFT.BusAcctLiabStartToOpenGT5MFlag, RIGHT.BusAcctLiabStartToOpenGT5MFlag);
				self.BusOldestLiabStartToOpenGT5MFlag := calcVariableDiff(LEFT.BusOldestLiabStartToOpenGT5MFlag, RIGHT.BusOldestLiabStartToOpenGT5MFlag);
				self.BusAcctOwnerNotPopFlag := calcVariableDiff(LEFT.BusAcctOwnerNotPopFlag, RIGHT.BusAcctOwnerNotPopFlag);
				self.BusAcctPerBusOwnerNotPopCnt := calcVariableDiff(LEFT.BusAcctPerBusOwnerNotPopCnt, RIGHT.BusAcctPerBusOwnerNotPopCnt);
				self.BusOwnerNotPopFlag := calcVariableDiff(LEFT.BusOwnerNotPopFlag, RIGHT.BusOwnerNotPopFlag);
				self.BusAcctStateNotInProgAreaFlag := calcVariableDiff(LEFT.BusAcctStateNotInProgAreaFlag, RIGHT.BusAcctStateNotInProgAreaFlag);
				self.BusAcctPerBusNotInProgAreaCnt := calcVariableDiff(LEFT.BusAcctPerBusNotInProgAreaCnt, RIGHT.BusAcctPerBusNotInProgAreaCnt);
				self.BusAcctPerBusNotInProgAreaFlag := calcVariableDiff(LEFT.BusAcctPerBusNotInProgAreaFlag, RIGHT.BusAcctPerBusNotInProgAreaFlag);
				self.BusAcctAddressPOBoxFlag := calcVariableDiff(LEFT.BusAcctAddressPOBoxFlag, RIGHT.BusAcctAddressPOBoxFlag);
				self.BusAcctPerBusAddressPOBoxCnt := calcVariableDiff(LEFT.BusAcctPerBusAddressPOBoxCnt, RIGHT.BusAcctPerBusAddressPOBoxCnt);
				self.BusAcctPerBusAddressPOBoxFlag := calcVariableDiff(LEFT.BusAcctPerBusAddressPOBoxFlag, RIGHT.BusAcctPerBusAddressPOBoxFlag);
				self.BusAcctLegalActionFlag := calcVariableDiff(LEFT.BusAcctLegalActionFlag, RIGHT.BusAcctLegalActionFlag);
				self.BusAcctPerBusLegActLienCnt := calcVariableDiff(LEFT.BusAcctPerBusLegActLienCnt, RIGHT.BusAcctPerBusLegActLienCnt);
				self.BusAcctPerBusLegalActOtherCnt := calcVariableDiff(LEFT.BusAcctPerBusLegalActOtherCnt, RIGHT.BusAcctPerBusLegalActOtherCnt);
				self.BusAcctPerBusLegalActPaymCnt := calcVariableDiff(LEFT.BusAcctPerBusLegalActPaymCnt, RIGHT.BusAcctPerBusLegalActPaymCnt);
				self.BusLegalActionFlag := calcVariableDiff(LEFT.BusLegalActionFlag, RIGHT.BusLegalActionFlag);
				self.BusAcctWarrantIssuedFlag := calcVariableDiff(LEFT.BusAcctWarrantIssuedFlag, RIGHT.BusAcctWarrantIssuedFlag);
				self.BusWarrantIssuedSum := calcVariableDiff(LEFT.BusWarrantIssuedSum, RIGHT.BusWarrantIssuedSum);
				self.BusAcctPerBusWithWarrantCnt := calcVariableDiff(LEFT.BusAcctPerBusWithWarrantCnt, RIGHT.BusAcctPerBusWithWarrantCnt);
				self.BusWarrantIssuedFlag := calcVariableDiff(LEFT.BusWarrantIssuedFlag, RIGHT.BusWarrantIssuedFlag);
				self.BusAcctTaxLiabBlceDebitFlag := calcVariableDiff(LEFT.BusAcctTaxLiabBlceDebitFlag, RIGHT.BusAcctTaxLiabBlceDebitFlag);
				self.BusAcctPerBusTaxLiabBlceDebCnt := calcVariableDiff(LEFT.BusAcctPerBusTaxLiabBlceDebCnt, RIGHT.BusAcctPerBusTaxLiabBlceDebCnt);
				self.BusAcctPerBusTaxLiabBlceCredCnt := calcVariableDiff(LEFT.BusAcctPerBusTaxLiabBlceCredCnt, RIGHT.BusAcctPerBusTaxLiabBlceCredCnt);
				self.BusAcctPerBusTaxLiabBlceOthCnt := calcVariableDiff(LEFT.BusAcctPerBusTaxLiabBlceOthCnt, RIGHT.BusAcctPerBusTaxLiabBlceOthCnt);
				self.BusTaxLiabBlceDebitFlag := calcVariableDiff(LEFT.BusTaxLiabBlceDebitFlag, RIGHT.BusTaxLiabBlceDebitFlag);
			
				self := left;
	));
	
	fnCountSpecialValues(ds, field) := FUNCTIONMACRO
			// // -1 - Previous record was in the special values, new record is not
			// // -2 - Previous record was not in the special values, new record is
			// // -3 - Previous record had a count lower than new record. The count went up
			// // -4 - Previous record had a count higher than new record. The count went down
			// // -5 - Previous record value not same as new record value
			// // -6 - No change
			
			diff_cnt := COUNT(ds(field in ['-1', '-2', '-3', '-4', '-5']));
			RETURN ROW({#TEXT(field), 
									diff_cnt,
									diff_cnt / COUNT(ds),
									COUNT(ds(field='-2')), //num_to_special
									COUNT(ds(field='-1')), //num_from_special
									COUNT(ds(field='-4')), //num_value_down
									COUNT(ds(field='-3')) //num_value_up
			}, r_diff_report);
	ENDMACRO;
 
	shared ds3 := fnCountSpecialValues(ds2, BusAcctUltIDAppend) +
				fnCountSpecialValues(ds2, BusAcctOrgIDAppend) +
				fnCountSpecialValues(ds2, BusAcctSeleIDAppend) +
				fnCountSpecialValues(ds2, BusAcctProxIDAppend) +
				fnCountSpecialValues(ds2, BusAcctPowIDAppend) +
				// Record Dts
				fnCountSpecialValues(ds2, BusAcctNewestUpdateMasterDt) +
				fnCountSpecialValues(ds2, BusAcctNewestRecordDt) +
				fnCountSpecialValues(ds2, BusNewestRecordDt) +
				// Program Business Input Echo
				fnCountSpecialValues(ds2, BusAcctStateClean) +
				fnCountSpecialValues(ds2, BusAcctAddressTypeClean) +
				// Program Business Input Pop Flags
				fnCountSpecialValues(ds2, BusAcctOwnerName1Pop) +
				fnCountSpecialValues(ds2, BusAcctOwnerSSN1Pop) +
				fnCountSpecialValues(ds2, BusAcctOwnerName2Pop) +
				fnCountSpecialValues(ds2, BusAcctOwnerSSN2Pop) +
				fnCountSpecialValues(ds2, BusAcctOwnerName3Pop) +
				fnCountSpecialValues(ds2, BusAcctOwnerSSN3Pop) +
				fnCountSpecialValues(ds2, BusAcctFullAddressCleanPop) +
				// Program Contributed Data Echo
				fnCountSpecialValues(ds2, BusAcctOpenDtEcho) +
				fnCountSpecialValues(ds2, BusOldestAcctOpenDt) +
				fnCountSpecialValues(ds2, BusNewestAcctOpenDt) +
				fnCountSpecialValues(ds2, BusAcctStatusTypeEcho) +
				fnCountSpecialValues(ds2, BusAcctDtEmployerBeganEcho) +
				fnCountSpecialValues(ds2, BusOldestEmployerBeganDt) +
				fnCountSpecialValues(ds2, BusNewestEmployerBeganDt) +
				fnCountSpecialValues(ds2, BusAcctTaxLiabStartDtEcho) +
				fnCountSpecialValues(ds2, BusAcctTaxLiabEndDtEcho) +
				fnCountSpecialValues(ds2, BusOldestTaxLiabStartDt) +
				fnCountSpecialValues(ds2, BusNewestTaxLiabStartDt) +
				fnCountSpecialValues(ds2, BusOldestTaxLiabEndDt) +
				fnCountSpecialValues(ds2, BusNewestTaxLiabEndDt) +
				fnCountSpecialValues(ds2, BusAcctOldestUnemClmDt) +
				fnCountSpecialValues(ds2, BusAcctNewestUnemClmDt) +
				fnCountSpecialValues(ds2, BusOldestUnemClmDt) +
				fnCountSpecialValues(ds2, BusNewestUnemClmDt) +
				fnCountSpecialValues(ds2, BusAcctOwnerCntEcho) +
				fnCountSpecialValues(ds2, BusAcctLegalActionTypeEcho) +
				fnCountSpecialValues(ds2, BusAcctWarrantIssuedCntEcho) +
				fnCountSpecialValues(ds2, BusAcctWarrantIssuedDtEcho) +
				fnCountSpecialValues(ds2, BusAcctTaxLiabBlceStatusEcho) +
				// Business Incorporation
				fnCountSpecialValues(ds2, BusIncorpDt) +
				fnCountSpecialValues(ds2, BusIncorpStatusType) +
				fnCountSpecialValues(ds2, BusIncorpMSince) +
				// Business Program History
				fnCountSpecialValues(ds2, BusAcctOpenDtMsince) +
				fnCountSpecialValues(ds2, BusOldestAcctOpenDtMsince) +
				fnCountSpecialValues(ds2, BusAcctEmpBeganToOpenDtSpan) +
				fnCountSpecialValues(ds2, BusOldestEmpBeganToAcctOpenSpan) +
				fnCountSpecialValues(ds2, BusEmpBeganToAcctOpenLT12MCnt) +
				fnCountSpecialValues(ds2, BusEmpBeganToAcctOpenLT6MCnt) +
				fnCountSpecialValues(ds2, BusEmpBeganToAcctOpenGT12MCnt) +
				fnCountSpecialValues(ds2, BusAcctLiabStartToOpenDtSpan) +
				fnCountSpecialValues(ds2, BusOldestLiabStartToAcctOpenSpan) +
				fnCountSpecialValues(ds2, BusIncorpToOldestAcctOpenSpan) +
				// Tax Liability History
				fnCountSpecialValues(ds2, BusAcctTaxLiabStartMsince) +
				fnCountSpecialValues(ds2, BusAcctTaxLiabEndMsince) +
				fnCountSpecialValues(ds2, BusTaxLiabOngoingFlag) +
				fnCountSpecialValues(ds2, BusOldestTaxLiabStartMsince) +
				fnCountSpecialValues(ds2, BusNewestTaxLiabEndMsince) +
				fnCountSpecialValues(ds2, BusIncorpToLiabSpan) +
				// Unemployment Claim Event History
				fnCountSpecialValues(ds2, BusAcctLiabToOldestUnemClmSpan) +
				fnCountSpecialValues(ds2, BusAcctLiabToNewestUnemClmSpan) +
				fnCountSpecialValues(ds2, BusIncorpToOldestUnemClmSpan) +
				fnCountSpecialValues(ds2, BusIncorpToNewestUnemClmSpan) +
				fnCountSpecialValues(ds2, BusLiabToOldestUnemClmSpan) +
				fnCountSpecialValues(ds2, BusLiabToNewestUnemClmSpan) +
				fnCountSpecialValues(ds2, BusAcctUnemClaimCurrActiveCnt) +
				fnCountSpecialValues(ds2, BusAcctUnemClaimFiledCntEv) +
				fnCountSpecialValues(ds2, BusAcctUnemClaimFiledCnt1Y) +
				fnCountSpecialValues(ds2, BusAcctUnemClaimFiledCnt120D) +
				fnCountSpecialValues(ds2, BusAcctUnemClaimFiledCnt90D) +
				fnCountSpecialValues(ds2, BusAcctUnemClaimFiledCnt30D) +
				fnCountSpecialValues(ds2, BusAcctUnemClaimApprvCntEv) +
				fnCountSpecialValues(ds2, BusAcctUnemClaimApprvCnt1Y) +
				fnCountSpecialValues(ds2, BusAcctUnemClaimApprvCnt120D) +
				fnCountSpecialValues(ds2, BusAcctUnemClaimApprvCnt90D) +
				fnCountSpecialValues(ds2, BusAcctUnemClaimApprvCnt30D) +
				fnCountSpecialValues(ds2, BusUnemClaimCurrActiveCnt) +
				fnCountSpecialValues(ds2, BusUnemClaimFiledCntEv) +
				fnCountSpecialValues(ds2, BusUnemClaimFiledCnt1Y) +
				fnCountSpecialValues(ds2, BusUnemClaimFiledCnt120D) +
				fnCountSpecialValues(ds2, BusUnemClaimFiledCnt90D) +
				fnCountSpecialValues(ds2, BusUnemClaimFiledCnt30D) +
				fnCountSpecialValues(ds2, BusUnemClaimApprvCntEv) +
				fnCountSpecialValues(ds2, BusUnemClaimApprvCnt1Y) +
				fnCountSpecialValues(ds2, BusUnemClaimApprvCnt120D) +
				fnCountSpecialValues(ds2, BusUnemClaimApprvCnt90D) +
				fnCountSpecialValues(ds2, BusUnemClaimApprvCnt30D) +
				fnCountSpecialValues(ds2, BusAcctUnemClmAfterOpenCnt30D) +
				fnCountSpecialValues(ds2, BusAcctUnemClmAfterOpenCnt60D) +
				fnCountSpecialValues(ds2, BusAcctUnemClmAfterOpenCnt90D) +
				fnCountSpecialValues(ds2, BusAcctUnemClmAfterOpenCnt120D) +
				fnCountSpecialValues(ds2, BusUnemClmAfterOldestOpenCnt30D) +
				fnCountSpecialValues(ds2, BusUnemClmAfterOldestOpenCnt60D) +
				fnCountSpecialValues(ds2, BusUnemClmAfterOldestOpenCnt90D) +
				fnCountSpecialValues(ds2, BusUnemClmAfterOldestOpenCnt120D) +
				// Unemployment Claim Event History - Claimant Velocity
				fnCountSpecialValues(ds2, BusAcctUnemClmAcctCurrActiveCnt) +
				fnCountSpecialValues(ds2, BusAcctUnemClmAcctFiledCntEv) +
				fnCountSpecialValues(ds2, BusAcctUnemClmAcctFiledCnt1Y) +
				fnCountSpecialValues(ds2, BusAcctUnemClmAcctFiledCnt120D) +
				fnCountSpecialValues(ds2, BusAcctUnemClmAcctFiledCnt90D) +
				fnCountSpecialValues(ds2, BusAcctUnemClmAcctFiledCnt30D) +
				fnCountSpecialValues(ds2, BusAcctUnemClmLexIDFiledCntEv) +
				fnCountSpecialValues(ds2, BusAcctUnemClmLexIDFiledCnt1Y) +
				fnCountSpecialValues(ds2, BusAcctUnemClmLexIDFiledCnt120D) +
				fnCountSpecialValues(ds2, BusAcctUnemClmLexIDFiledCnt90D) +
				fnCountSpecialValues(ds2, BusAcctUnemClmLexIDFiledCnt30D) +
				fnCountSpecialValues(ds2, BusAcctLexIDMultiUnemClmCntEv) +
				fnCountSpecialValues(ds2, BusAcctLexIDMultiUnemClmCnt1Y) +
				fnCountSpecialValues(ds2, BusAcctLexIDMultiUnemClmCnt120D) +
				fnCountSpecialValues(ds2, BusAcctLexIDMultiUnemClmCnt90D) +
				fnCountSpecialValues(ds2, BusAcctLexIDMultiUnemClmCnt30D) +
				fnCountSpecialValues(ds2, BusUnemClmAcctCurrActiveCnt) +
				fnCountSpecialValues(ds2, BusUnemClmAcctFiledCntEv) +
				fnCountSpecialValues(ds2, BusUnemClmAcctFiledCnt1Y) +
				fnCountSpecialValues(ds2, BusUnemClmAcctFiledCnt120D) +
				fnCountSpecialValues(ds2, BusUnemClmAcctFiledCnt90D) +
				fnCountSpecialValues(ds2, BusUnemClmAcctFiledCnt30D) +
				fnCountSpecialValues(ds2, BusUnemClmLexIDFiledCntEv) +
				fnCountSpecialValues(ds2, BusUnemClmLexIDFiledCnt1Y) +
				fnCountSpecialValues(ds2, BusUnemClmLexIDFiledCnt120D) +
				fnCountSpecialValues(ds2, BusUnemClmLexIDFiledCnt90D) +
				fnCountSpecialValues(ds2, BusUnemClmLexIDFiledCnt30D) +
				fnCountSpecialValues(ds2, BusLexIDMultiUnemClmCntEv) +
				fnCountSpecialValues(ds2, BusLexIDMultiUnemClmCnt1Y) +
				fnCountSpecialValues(ds2, BusLexIDMultiUnemClmCnt120D) +
				fnCountSpecialValues(ds2, BusLexIDMultiUnemClmCnt90D) +
				fnCountSpecialValues(ds2, BusLexIDMultiUnemClmCnt30D) +
				// Business Structure
				fnCountSpecialValues(ds2, BusAcctPerBusLegalEntCnt) +
				// Business Address Velocity
				fnCountSpecialValues(ds2, VelBusAcctPerAddrInProgCnt) +
				fnCountSpecialValues(ds2, VelBusAcctPerAddrInBusLegEntCnt) +
				// High Risk Flags
				fnCountSpecialValues(ds2, BusAcctUnemClmLT60DAfterOpenFlag) +
				fnCountSpecialValues(ds2, BusAcctUnemClm60To120DAftOpFlag) +
				fnCountSpecialValues(ds2, BusUnemClmLT60DAfterOpenFlag) +
				fnCountSpecialValues(ds2, BusUnemClm60To120DAfterOpenFlag) +
				fnCountSpecialValues(ds2, BusAcctLiabStartToOpenGT5MFlag) +
				fnCountSpecialValues(ds2, BusOldestLiabStartToOpenGT5MFlag) +
				fnCountSpecialValues(ds2, BusAcctOwnerNotPopFlag) +
				fnCountSpecialValues(ds2, BusAcctPerBusOwnerNotPopCnt) +
				fnCountSpecialValues(ds2, BusOwnerNotPopFlag) +
				fnCountSpecialValues(ds2, BusAcctStateNotInProgAreaFlag) +
				fnCountSpecialValues(ds2, BusAcctPerBusNotInProgAreaCnt) +
				fnCountSpecialValues(ds2, BusAcctPerBusNotInProgAreaFlag) +
				fnCountSpecialValues(ds2, BusAcctAddressPOBoxFlag) +
				fnCountSpecialValues(ds2, BusAcctPerBusAddressPOBoxCnt) +
				fnCountSpecialValues(ds2, BusAcctPerBusAddressPOBoxFlag) +
				fnCountSpecialValues(ds2, BusAcctLegalActionFlag) +
				fnCountSpecialValues(ds2, BusAcctPerBusLegActLienCnt) +
				fnCountSpecialValues(ds2, BusAcctPerBusLegalActOtherCnt) +
				fnCountSpecialValues(ds2, BusAcctPerBusLegalActPaymCnt) +
				fnCountSpecialValues(ds2, BusLegalActionFlag) +
				fnCountSpecialValues(ds2, BusAcctWarrantIssuedFlag) +
				fnCountSpecialValues(ds2, BusWarrantIssuedSum) +
				fnCountSpecialValues(ds2, BusAcctPerBusWithWarrantCnt) +
				fnCountSpecialValues(ds2, BusWarrantIssuedFlag) +
				fnCountSpecialValues(ds2, BusAcctTaxLiabBlceDebitFlag) +
				fnCountSpecialValues(ds2, BusAcctPerBusTaxLiabBlceDebCnt) +
				fnCountSpecialValues(ds2, BusAcctPerBusTaxLiabBlceCredCnt) +
				fnCountSpecialValues(ds2, BusAcctPerBusTaxLiabBlceOthCnt) +
				fnCountSpecialValues(ds2, BusTaxLiabBlceDebitFlag);
				
	shared ds4 := SORT(ds3, attribute);
	export main := OUTPUT(ds4);

END;