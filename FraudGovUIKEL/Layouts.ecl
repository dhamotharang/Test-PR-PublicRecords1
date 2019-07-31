EXPORT Layouts := MODULE

		EXPORT EmployerOutput := RECORD
				// Program Info
				STRING ProgramStateEcho;
				// Business IDs
				STRING BusAcctUIDEcho;
				STRING BusAcctUltIDAppend;
				STRING BusAcctOrgIDAppend;
				STRING BusAcctSeleIDAppend;
				STRING BusAcctProxIDAppend;
				STRING BusAcctPowIDAppend;
				// Record Dts
				STRING BusAcctNewestUpdateMasterDt;
				STRING BusAcctNewestRecordDt;
				STRING BusNewestRecordDt;
				// Program Business Input Echo
				STRING BusAcctStateClean;
				STRING BusAcctAddressTypeClean;
				// Program Business Input Pop Flags
				STRING BusAcctOwnerName1Pop;
				STRING BusAcctOwnerSSN1Pop;
				STRING BusAcctOwnerName2Pop;
				STRING BusAcctOwnerSSN2Pop;
				STRING BusAcctOwnerName3Pop;
				STRING BusAcctOwnerSSN3Pop;
				STRING BusAcctFullAddressCleanPop;
				// Program Contributed Data Echo
				STRING BusAcctOpenDtEcho;
				STRING BusOldestAcctOpenDt;
				STRING BusNewestAcctOpenDt;
				STRING BusAcctStatusTypeEcho;
				STRING BusAcctDtEmployerBeganEcho;
				STRING BusOldestEmployerBeganDt;
				STRING BusNewestEmployerBeganDt;
				STRING BusAcctTaxLiabStartDtEcho;
				STRING BusAcctTaxLiabEndDtEcho;
				STRING BusOldestTaxLiabStartDt;
				STRING BusNewestTaxLiabStartDt;
				STRING BusOldestTaxLiabEndDt;
				STRING BusNewestTaxLiabEndDt;
				STRING BusAcctOldestUnemClmDt;
				STRING BusAcctNewestUnemClmDt;
				STRING BusOldestUnemClmDt;
				STRING BusNewestUnemClmDt;
				STRING BusAcctOwnerCntEcho;
				STRING BusAcctLegalActionTypeEcho;
				STRING BusAcctWarrantIssuedCntEcho;
				STRING BusAcctWarrantIssuedDtEcho;
				STRING BusAcctTaxLiabBlceStatusEcho;
				// Business Incorporation
				STRING BusIncorpDt;
				STRING BusIncorpStatusType;
				STRING BusIncorpMSince;
				// Business Program History
				STRING BusAcctOpenDtMsince;
				STRING BusOldestAcctOpenDtMsince;
				STRING BusAcctEmpBeganToOpenDtSpan;
				STRING BusOldestEmpBeganToAcctOpenSpan;
				STRING BusEmpBeganToAcctOpenLT12MCnt;
				STRING BusEmpBeganToAcctOpenLT6MCnt;
				STRING BusEmpBeganToAcctOpenGT12MCnt;
				STRING BusAcctLiabStartToOpenDtSpan;
				STRING BusOldestLiabStartToAcctOpenSpan;
				STRING BusIncorpToOldestAcctOpenSpan;
				// Tax Liability History
				STRING BusAcctTaxLiabStartMsince;
				STRING BusAcctTaxLiabEndMsince;
				STRING BusTaxLiabOngoingFlag;
				STRING BusOldestTaxLiabStartMsince;
				STRING BusNewestTaxLiabEndMsince;
				STRING BusIncorpToLiabSpan;
				// Unemployment Claim Event History
				STRING BusAcctLiabToOldestUnemClmSpan;
				STRING BusAcctLiabToNewestUnemClmSpan;
				STRING BusIncorpToOldestUnemClmSpan;
				STRING BusIncorpToNewestUnemClmSpan;
				STRING BusLiabToOldestUnemClmSpan;
				STRING BusLiabToNewestUnemClmSpan;
				STRING BusAcctUnemClaimCurrActiveCnt;
				STRING BusAcctUnemClaimFiledCntEv;
				STRING BusAcctUnemClaimFiledCnt1Y;
				STRING BusAcctUnemClaimFiledCnt120D;
				STRING BusAcctUnemClaimFiledCnt90D;
				STRING BusAcctUnemClaimFiledCnt30D;
				STRING BusAcctUnemClaimApprvCntEv;
				STRING BusAcctUnemClaimApprvCnt1Y;
				STRING BusAcctUnemClaimApprvCnt120D;
				STRING BusAcctUnemClaimApprvCnt90D;
				STRING BusAcctUnemClaimApprvCnt30D;
				STRING BusUnemClaimCurrActiveCnt;
				STRING BusUnemClaimFiledCntEv;
				STRING BusUnemClaimFiledCnt1Y;
				STRING BusUnemClaimFiledCnt120D;
				STRING BusUnemClaimFiledCnt90D;
				STRING BusUnemClaimFiledCnt30D;
				STRING BusUnemClaimApprvCntEv;
				STRING BusUnemClaimApprvCnt1Y;
				STRING BusUnemClaimApprvCnt120D;
				STRING BusUnemClaimApprvCnt90D;
				STRING BusUnemClaimApprvCnt30D;
				STRING BusAcctUnemClmAfterOpenCnt30D;
				STRING BusAcctUnemClmAfterOpenCnt60D;
				STRING BusAcctUnemClmAfterOpenCnt90D;
				STRING BusAcctUnemClmAfterOpenCnt120D;
				STRING BusUnemClmAfterOldestOpenCnt30D;
				STRING BusUnemClmAfterOldestOpenCnt60D;
				STRING BusUnemClmAfterOldestOpenCnt90D;
				STRING BusUnemClmAfterOldestOpenCnt120D;
				// Unemployment Claim Event History - Claimant Velocity
				STRING BusAcctUnemClmAcctCurrActiveCnt;
				STRING BusAcctUnemClmAcctFiledCntEv;
				STRING BusAcctUnemClmAcctFiledCnt1Y;
				STRING BusAcctUnemClmAcctFiledCnt120D;
				STRING BusAcctUnemClmAcctFiledCnt90D;
				STRING BusAcctUnemClmAcctFiledCnt30D;
				STRING BusAcctUnemClmLexIDFiledCntEv;
				STRING BusAcctUnemClmLexIDFiledCnt1Y;
				STRING BusAcctUnemClmLexIDFiledCnt120D;
				STRING BusAcctUnemClmLexIDFiledCnt90D;
				STRING BusAcctUnemClmLexIDFiledCnt30D;
				STRING BusAcctLexIDMultiUnemClmCntEv;
				STRING BusAcctLexIDMultiUnemClmCnt1Y;
				STRING BusAcctLexIDMultiUnemClmCnt120D;
				STRING BusAcctLexIDMultiUnemClmCnt90D;
				STRING BusAcctLexIDMultiUnemClmCnt30D;
				STRING BusUnemClmAcctCurrActiveCnt;
				STRING BusUnemClmAcctFiledCntEv;
				STRING BusUnemClmAcctFiledCnt1Y;
				STRING BusUnemClmAcctFiledCnt120D;
				STRING BusUnemClmAcctFiledCnt90D;
				STRING BusUnemClmAcctFiledCnt30D;
				STRING BusUnemClmLexIDFiledCntEv;
				STRING BusUnemClmLexIDFiledCnt1Y;
				STRING BusUnemClmLexIDFiledCnt120D;
				STRING BusUnemClmLexIDFiledCnt90D;
				STRING BusUnemClmLexIDFiledCnt30D;
				STRING BusLexIDMultiUnemClmCntEv;
				STRING BusLexIDMultiUnemClmCnt1Y;
				STRING BusLexIDMultiUnemClmCnt120D;
				STRING BusLexIDMultiUnemClmCnt90D;
				STRING BusLexIDMultiUnemClmCnt30D;
				// Business Structure
				STRING BusAcctPerBusLegalEntCnt;
				// Business Address Velocity
				STRING VelBusAcctPerAddrInProgCnt;
				STRING VelBusAcctPerAddrInBusLegEntCnt;
				// High Risk Flags
				STRING BusAcctUnemClmLT60DAfterOpenFlag;
				STRING BusAcctUnemClm60To120DAftOpFlag;
				STRING BusUnemClmLT60DAfterOpenFlag;
				STRING BusUnemClm60To120DAfterOpenFlag;
				STRING BusAcctLiabStartToOpenGT5MFlag;
				STRING BusOldestLiabStartToOpenGT5MFlag;
				STRING BusAcctOwnerNotPopFlag;
				STRING BusAcctPerBusOwnerNotPopCnt;
				STRING BusOwnerNotPopFlag;
				STRING BusAcctStateNotInProgAreaFlag;
				STRING BusAcctPerBusNotInProgAreaCnt;
				STRING BusAcctPerBusNotInProgAreaFlag;
				STRING BusAcctAddressPOBoxFlag;
				STRING BusAcctPerBusAddressPOBoxCnt;
				STRING BusAcctPerBusAddressPOBoxFlag;
				STRING BusAcctLegalActionFlag;
				STRING BusAcctPerBusLegActLienCnt;
				STRING BusAcctPerBusLegalActOtherCnt;
				STRING BusAcctPerBusLegalActPaymCnt;
				STRING BusLegalActionFlag;
				STRING BusAcctWarrantIssuedFlag;
				STRING BusWarrantIssuedSum;
				STRING BusAcctPerBusWithWarrantCnt;
				STRING BusWarrantIssuedFlag;
				STRING BusAcctTaxLiabBlceDebitFlag;
				STRING BusAcctPerBusTaxLiabBlceDebCnt;
				STRING BusAcctPerBusTaxLiabBlceCredCnt;
				STRING BusAcctPerBusTaxLiabBlceOthCnt;
				STRING BusTaxLiabBlceDebitFlag;
		END;

END;