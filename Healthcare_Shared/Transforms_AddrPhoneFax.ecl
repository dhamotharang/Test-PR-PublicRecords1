import Healthcare_Shared,Healthcare_ProviderPoint,Healthcare_Cleaners,std;

export Transforms_AddrPhoneFax := module

	// constants
	export  PV_CV_CONFIDENCE_SCORE          := 97; // Confidence in addresses both phone verfied and claim verified.
  export  PV_CONFIDENCE_SCORE             := 95; // Confidence in addresses that are only phone verified.
  export  HV_CONFIDENCE_SCORE             := 90; // Confidence in addresses that are only high verified.
  export  CV_CONFIDENCE_SCORE             := 90; // Confidence in addresses that are only claim verified.
  export  CAM_CONFIDENCE_SCORE            := 53; // Confidence in addresses that verified by CAM records only
  export  OV_CONFIDENCE_SCORE4            := 81; // Confidence in address that are verified by 4 or more other valid distinct ref sources.
  export  OV_CONFIDENCE_SCORE3            := 78; // Confidenece in addresses that are verified by 3 other valid distinct ref sources.
  export  OV_CONFIDENCE_SCORE2            := 71; // Confidence in addresses that are verified by 2 other valid distinct ref sources.
  export  OV_CONFIDENCE_SCORE1            := 54; // Confidence in addresses that are verified by 1 other valid distinct ref source.
  export  DELIVERABLE_CONFIDENCE_SCORE    := 20; // Confidence in deliverable ref sources.
  export  INACT_CONFIDENCE_SCORE          :=  8; // Confidence in INACT addresses.
  export  UNDELIVERABLE_CONFIDENCE_SCORE  :=  0; // Confidence in undeliverable ref sources.
	
  export  OV_COUNT_LEVEL4                 :=  4;
  export  OV_COUNT_LEVEL3                 :=  3;
  export  OV_COUNT_LEVEL2                 :=  2;
  export  OV_COUNT_LEVEL1                 :=  1;
	

// practice address transform
export Healthcare_Shared.Layouts_AddrPhoneFax.Layout_AddressPhoneFax addPracAddress(Healthcare_Shared.layouts_commonized.std_record_struct l, Healthcare_Shared.Layouts.CombinedHeaderResults inrec) := transform
	inputPracAddress := inrec.userinput.clnAddr;
	inputPracPhone := inrec.userinput.workphone;
	inputPracFax := inrec.userinput.FaxVerification;
	inputBillAddress := inrec.userinput.clnBillAddr;
	inputBillPhone := inrec.userinput.bill_phone;
	inputBillFax := inrec.userinput.bill_fax;
	
	self.acctno := inrec.acctno;
	self.InternalID := inrec.InternalID;
	self.isRoyalty := Healthcare_Shared.Functions.IsRoyaltySource(l.filesource,l.filecode);	
	self.sources := Healthcare_Shared.Functions.loadFileSource(l.filesource,l.filecode);
	self.group_key := inrec.vendorid;
  self.surrogate_key := l.surrogate_key;
	self.msPracAddr := Healthcare_Shared.Fn_set_match_input.MatchCleanAddress(inputPracAddress,l.prac1).ms;
	self.msBillAddr := Healthcare_Shared.Fn_set_match_input.MatchCleanAddress(inputBillAddress,l.prac1).ms;
	self := l.prac1;
	self := l.prac_phone1;
	self := l.prac_fax1;
	self := l.prac_company1;
	last_update_date := STD.Str.Filter(l.last_update_date, '0123456789');
	self.last_update_date := if(length(last_update_date)=8 and last_update_date!='00000000',last_update_date,'');
	self.address_type := Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE;
	self.verifiesInputPracAddress := self.msPracAddr.extendedInfo&Fn_set_match_input.XMI_PRIMARY_ADDR_MATCH=Fn_set_match_input.XMI_PRIMARY_ADDR_MATCH;
	self.verifiesInputPracSuite := self.msPracAddr.extendedInfo&Fn_set_match_input.XMI_SECONDARY_RANGE_MATCH=Fn_set_match_input.XMI_SECONDARY_RANGE_MATCH;
	self.verifiesInputPracPhone := inputPracPhone!='' and l.prac_phone1.phone=inputPracPhone;
	self.verifiesInputPracFax := inputPracFax!='' and l.prac_fax1.fax=inputPracFax;
	self.verifiesInputBillAddress := self.msBillAddr.extendedInfo&Fn_set_match_input.XMI_PRIMARY_ADDR_MATCH=Fn_set_match_input.XMI_PRIMARY_ADDR_MATCH;
	self.verifiesInputBillSuite := self.msBillAddr.extendedInfo&Fn_set_match_input.XMI_SECONDARY_RANGE_MATCH=Fn_set_match_input.XMI_SECONDARY_RANGE_MATCH;
	self.verifiesInputBillPhone := inputBillPhone!='' and l.bill_phone1.phone=inputBillPhone;
	self.verifiesInputBillFax := inputBillFax!='' and l.bill_fax1.fax=inputBillFax;
	self := l;
	self := [];
end;
	
// bill address transform
export Healthcare_Shared.Layouts_AddrPhoneFax.Layout_AddressPhoneFax addBillAddress(Healthcare_Shared.layouts_commonized.std_record_struct l, Healthcare_Shared.Layouts.CombinedHeaderResults inrec) := transform
	inputPracAddress := inrec.userinput.clnAddr;
	inputPracPhone := inrec.userinput.workphone;
	inputPracFax := inrec.userinput.FaxVerification;
	inputBillAddress := inrec.userinput.clnBillAddr;
	inputBillPhone := inrec.userinput.bill_phone;
	inputBillFax := inrec.userinput.bill_fax;
	
	self.acctno := inrec.acctno;
	self.InternalID := inrec.InternalID;
	self.isRoyalty := Healthcare_Shared.Functions.IsRoyaltySource(l.filesource,l.filecode);	
	self.sources := Healthcare_Shared.Functions.loadFileSource(l.filesource,l.filecode);
	self.group_key := inrec.vendorid;
  self.surrogate_key := l.surrogate_key;
	self.msPracAddr := Healthcare_Shared.Fn_set_match_input.MatchCleanAddress(inputPracAddress,l.bill1).ms;
	self.msBillAddr := Healthcare_Shared.Fn_set_match_input.MatchCleanAddress(inputBillAddress,l.bill1).ms;
	self := l.bill1;
	self := l.bill_phone1;
	self := l.bill_fax1;
	self := l.bill_company1;
	last_update_date := STD.Str.Filter(l.last_update_date, '0123456789');
	self.last_update_date := if(length(last_update_date)=8 and last_update_date!='00000000',last_update_date,'');
	self.address_type := Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING;
	self.verifiesInputPracAddress := self.msPracAddr.extendedInfo&Fn_set_match_input.XMI_PRIMARY_ADDR_MATCH=Fn_set_match_input.XMI_PRIMARY_ADDR_MATCH;
	self.verifiesInputPracSuite := self.msPracAddr.extendedInfo&Fn_set_match_input.XMI_SECONDARY_RANGE_MATCH=Fn_set_match_input.XMI_SECONDARY_RANGE_MATCH;
	self.verifiesInputPracPhone := inputPracPhone!='' and l.prac_phone1.phone=inputPracPhone;
	self.verifiesInputPracFax := inputPracFax!='' and l.prac_fax1.fax=inputPracFax;
	self.verifiesInputBillAddress := self.msBillAddr.extendedInfo&Fn_set_match_input.XMI_PRIMARY_ADDR_MATCH=Fn_set_match_input.XMI_PRIMARY_ADDR_MATCH;
	self.verifiesInputBillSuite := self.msBillAddr.extendedInfo&Fn_set_match_input.XMI_SECONDARY_RANGE_MATCH=Fn_set_match_input.XMI_SECONDARY_RANGE_MATCH;
	self.verifiesInputBillPhone := inputBillPhone!='' and l.bill_phone1.phone=inputBillPhone;
	self.verifiesInputBillFax := inputBillFax!='' and l.bill_fax1.fax=inputBillFax;
	self := l;
	self := [];
end;

// CAM billing address transform
export Healthcare_Shared.Layouts_AddrPhoneFax.Layout_AddressPhoneFax addCAMBillAddress(Healthcare_Shared.layouts_commonized.std_record_struct l, Healthcare_Shared.Layouts.CombinedHeaderResults inrec) := transform
	inputPracAddress := inrec.userinput.clnAddr;
	inputPracPhone := inrec.userinput.workphone;
	inputPracFax := inrec.userinput.FaxVerification;
	inputBillAddress := inrec.userinput.clnBillAddr;
	inputBillPhone := inrec.userinput.bill_phone;
	inputBillFax := inrec.userinput.bill_fax;
	
	self.acctno := inrec.acctno;
	self.InternalID := inrec.InternalID;
	self.isRoyalty := Healthcare_Shared.Functions.IsRoyaltySource(l.filesource,l.filecode);	
	self.sources := Healthcare_Shared.Functions.loadFileSource(l.filesource,l.filecode);
	self.group_key := inrec.vendorid;
  self.surrogate_key := l.surrogate_key;
	self.msPracAddr := Healthcare_Shared.Fn_set_match_input.MatchCleanAddress(inputPracAddress,l.prac1).ms;
	self.msBillAddr := Healthcare_Shared.Fn_set_match_input.MatchCleanAddress(inputBillAddress,l.prac1).ms;
	self := l.prac1;
	self := l.prac_phone1;
	self := l.prac_fax1;
	self := l.prac_company1;
	last_update_date := STD.Str.Filter(l.last_update_date, '0123456789');
	self.last_update_date := if(length(last_update_date)=8 and last_update_date!='00000000',last_update_date,'');
	self.address_type := Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING;
	self.verifiesInputPracAddress := self.msPracAddr.extendedInfo&Fn_set_match_input.XMI_PRIMARY_ADDR_MATCH=Fn_set_match_input.XMI_PRIMARY_ADDR_MATCH;
	self.verifiesInputPracSuite := self.msPracAddr.extendedInfo&Fn_set_match_input.XMI_SECONDARY_RANGE_MATCH=Fn_set_match_input.XMI_SECONDARY_RANGE_MATCH;
	self.verifiesInputPracPhone := inputPracPhone!='' and l.prac_phone1.phone=inputPracPhone;
	self.verifiesInputPracFax := inputPracFax!='' and l.prac_fax1.fax=inputPracFax;
	self.verifiesInputBillAddress := self.msBillAddr.extendedInfo&Fn_set_match_input.XMI_PRIMARY_ADDR_MATCH=Fn_set_match_input.XMI_PRIMARY_ADDR_MATCH;
	self.verifiesInputBillSuite := self.msBillAddr.extendedInfo&Fn_set_match_input.XMI_SECONDARY_RANGE_MATCH=Fn_set_match_input.XMI_SECONDARY_RANGE_MATCH;
	self.verifiesInputBillPhone := inputBillPhone!='' and l.bill_phone1.phone=inputBillPhone;
	self.verifiesInputBillFax := inputBillFax!='' and l.bill_fax1.fax=inputBillFax;
	self := l;
	self := [];
end;
	
export Healthcare_Shared.Layouts_AddrPhoneFax.Layout_AddressPhoneFax setVerifiedStats(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_AddressPhoneFax l, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg, integer1 run_mode) := transform
	// decode bits
	self.isInactive           := l.addr_st & Healthcare_Shared.Constants.stat_Addr_Inactive > 0;
	self.isHospital           := l.addr_st & Healthcare_Shared.Constants.stat_Addr_RefHospAddr > 0;
	self.isResidential        := l.addr_st & Healthcare_Shared.Constants.stat_Addr_Residential > 0;
	self.isPrison             := l.addr_st & Healthcare_Shared.Constants.stat_Addr_Prison > 0;
	self.isPobox              := l.addr_st & Healthcare_Shared.Constants.stat_Addr_Pobox > 0;
	self.isNpsr               := l.addr_st & Healthcare_Shared.Constants.stat_Addr_Npsr > 0;
	self.isPhoneVerified      := l.addr_st & Healthcare_Shared.Constants.stat_Addr_PhoneVerified > 0;
	self.isFaxVerified        := l.addr_st & Healthcare_Shared.Constants.stat_Addr_FaxVerified > 0;
	self.isNotDeliverable     := l.addr_st & Healthcare_Shared.Constants.stat_Addr_NotDeliverable > 0;
	self.isSigStd             := l.addr_st & Healthcare_Shared.Constants.stat_Addr_SigStd > 0;
	
	// look for verification info based on filecode
	self.isVsfVerified        := l.filecode = 'ACT_VSF';
	self.isCamVerified        := l.filecode = 'CAM';
	self.isVSFInact           := l.filecode = 'INACT_VSF';

	// use grace period to set fresh/stale on records
	phone_grace_months        := if (run_mode=Healthcare_Shared.Constants.RunMode.IDV, Healthcare_Shared.Constants.indvPhoneVerifiedStale, Healthcare_Shared.Constants.busPhoneVerifiedStale);
	cam_grace_months          := 6;
	self.isPhoneVerifiedFresh := self.isPhoneVerified and not Healthcare_Shared.Functions.isExpiredWithGraceMonths(l.last_update_date,phone_grace_months);
	self.isPhoneVerifiedStale := self.isPhoneVerified and not self.isPhoneVerifiedFresh;
	self.isFaxVerifiedFresh   := self.isFaxVerified and not Healthcare_Shared.Functions.isExpiredWithGraceMonths(l.last_update_date,Healthcare_Shared.Constants.faxVerifiedStale);
	self.isFaxVerifiedStale   := self.isFaxVerified and not self.isFaxVerifiedFresh;
	self.isVsfVerifiedFresh   := self.isVsfVerified and not Healthcare_Shared.Functions.isExpiredWithGraceMonths(l.last_update_date,Healthcare_Shared.Constants.faxVerifiedStale);
	self.isVsfVerifiedStale   := self.isVsfVerified and not self.isVsfVerifiedFresh;
	self.isCamVerifiedFresh   := self.isCamVerified and not Healthcare_Shared.Functions.isExpiredWithGraceMonths(l.last_update_date,cam_grace_months);
	self.isCamVerifiedStale   := self.isCamVerified and not self.isCamVerifiedFresh;
	
	self.isHighVerified       := if(l.source_confidence_score>=88 or self.isFaxVerifiedFresh, true, false);
				
	// set correction rank
	rankPvs := map(cfg[1].CorrectionCandidateLevel='PV' => 6,
								 cfg[1].CorrectionCandidateLevel='CV' => 6,
								 cfg[1].CorrectionCandidateLevel='OV' => 6,
								 0);
	rankPv  := map(cfg[1].CorrectionCandidateLevel='PV' => 5,
								 cfg[1].CorrectionCandidateLevel='CV' => 4,
								 cfg[1].CorrectionCandidateLevel='OV' => 3,
								 0);
	rankCvs := map(cfg[1].CorrectionCandidateLevel='PV' => 4,
								 cfg[1].CorrectionCandidateLevel='CV' => 5,
								 cfg[1].CorrectionCandidateLevel='OV' => 5,
								 0);
	rankCv  := map(cfg[1].CorrectionCandidateLevel='PV' => 3,
								 cfg[1].CorrectionCandidateLevel='CV' => 3,
								 cfg[1].CorrectionCandidateLevel='OV' => 2,
								 0);
  rankOvs := map(cfg[1].CorrectionCandidateLevel='PV' => 2,
								 cfg[1].CorrectionCandidateLevel='CV' => 2,
								 cfg[1].CorrectionCandidateLevel='OV' => 4,
								 0);
  rankOv  := map(cfg[1].CorrectionCandidateLevel='PV' => 1,
								 cfg[1].CorrectionCandidateLevel='CV' => 1,
								 cfg[1].CorrectionCandidateLevel='OV' => 1,
								 0);
	hasSecondaryRange := l.secondary_range!='';
				
	self.corrRank := map((hasSecondaryRange and self.isPhoneVerified) => rankPvs,
												(hasSecondaryRange and self.isCamVerified) => rankCvs,
												(hasSecondaryRange) => rankOvs,
												(self.isPhoneVerified) => rankPv,
												(self.isCamVerified) => rankCv,
												rankOv);
	self := l;
end;

// set high verification bit to be used later in sorting
Healthcare_Shared.Layouts_AddrPhoneFax.Layout_AddressPhoneFax setHighVerificationBit(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_AddressPhoneFax l, integer4 highVerification) := transform
	dentalNpi   := if(l.filecode[1..3]='NPI' and (highVerification&Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.DENTAL_NPI_DEA)>0, true, false);
	freshVsf    := if(l.filecode='ACT_VSF'   and (highVerification&Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.FRESH_VSF)>0, true, false);
	freshDeaCam := if(l.filecode[1..3]='NPI' and (highVerification&Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_NPI_DEA)>0, true, false);
	staleCall   := if(l.isPhoneVerifiedStale and (highVerification&Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_STALE_PHONE)>0, true, false);
	staleVsf    := if(l.isFaxVerifiedStale   and (highVerification&Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_STALE_VSF)>0, true, false);
	rosterCam   := if(l.filecode_enum=m_filecode.FilecodeEnum.ROSTER and (highVerification&Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_ROSTER)>0, true, false);
	rosterDea   := if(l.filecode_enum=m_filecode.FilecodeEnum.ROSTER and (highVerification&Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.DEA_ROSTER)>0, true, false);
	rosterNpi   := if(l.filecode_enum=m_filecode.FilecodeEnum.ROSTER and (highVerification&Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.NPI_ROSTER)>0, true, false);
	self.isHighVerified := (l.isHighVerified or dentalNpi or freshVSF or freshDeaCam or staleCall or staleVsf or rosterCam or rosterDea or rosterNpi) and l.address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE;
	self := l;
end;

Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone rollupPhones(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_AddressPhoneFax l, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_AddressPhoneFax) allrows, boolean Inactive, unsigned4 phone_type) := transform
	sortedallrows := sort(allrows(last_update_date!=''), -last_update_date);
	pracrows := allrows(address_type&Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE>0);
	sortedpracrows := sort(pracrows(last_update_date!=''), -last_update_date);
	billrows := allrows(address_type&Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING>0);
	sortedbillrows := sort(billrows(last_update_date!=''), -last_update_date);

	self.isRoyalty := count(allrows(isRoyalty=false))=0;
	self.sources := dedup(sort(normalize(allrows, left.sources, transform(Healthcare_Shared.Layouts.layout_FileSource,self.filesource:=right.filesource,self.filecode:=right.filecode)),record),record);
	self.number := if (phone_type=Healthcare_Shared.Layouts_AddrPhoneFax.PhoneType.PHONE, l.phone, l.fax);
	self.phone_type := phone_type;
	self.isInactive := sortedallrows[1].isInactive;
	self.isPhoneInactive := self.isInactive and exists(sortedallrows(filecode='SKA_INACT' or filecode='INACT_ENC' or filecode='INACT_LOP'));
	self.isFaxInactive := self.isInactive and exists(sortedallrows(filecode='INACT_VSF'));
	self.inactiveDate := if (self.isInactive, sortedallrows[1].last_update_date, '');
	self.lastPhoneContactDate := sortedallrows(isPhoneVerified or (isInactive and not isVSFInact))[1].last_update_date;
	self.lastFaxContactDate := sortedallrows(isVsfVerified or isVSFInact)[1].last_update_date;
	self.bestPracticeLastDate := sortedpracrows(isPhoneVerified or isPhoneVerified or isInactive)[1].last_update_date;
	self.bestBillingLastDate := sortedbillrows(isPhoneVerified or isInactive)[1].last_update_date;
	self.lastUpdateDate := sortedallrows(last_update_date!='')[1].last_update_date;
	self.isPhoneVerifiedAsPractice := exists(pracrows(isPhoneVerifiedFresh));
	self.isPhoneVerifiedAsBilling  := exists(billrows(isPhoneVerifiedFresh));
	self.isFaxVerifiedAsPractice   := exists(pracrows(isFaxVerifiedFresh));
	self.isFaxVerifiedAsBilling    := exists(billrows(isFaxVerifiedFresh));
	self.isOtherVerifiedAsPractice := exists(pracrows(not isPhoneVerifiedFresh and not isFaxVerifiedFresh and not isHighVerified));
	self.isOtherVerifiedAsBilling  := exists(billrows(not isPhoneVerifiedFresh and not isFaxVerifiedFresh and not isHighVerified));
	self.isVSF                     := exists(allrows(filecode_enum=m_filecode.FilecodeEnum.VSF));
	self.isERXFax                  := exists(allrows(filecode_enum=m_filecode.FilecodeEnum.ERX_FAX));
	self.isRefPrac                 := exists(pracrows);
	self.isRefBill                 := exists(billrows);
	self.isPhoneVerified           := exists(allrows(isPhoneVerified)) and not Inactive;
	self.isPhoneVerifiedFresh      := exists(allrows(isPhoneVerifiedFresh)) and not Inactive;
	self.isPhoneVerifiedStale      := not self.isPhoneVerifiedFresh and self.isPhoneVerified;
	self.isFaxVerified             := exists(allrows(isFaxVerified)) and not Inactive;
	self.isFaxVerifiedFresh        := exists(allrows(isFaxVerifiedFresh)) and not Inactive;
	self.isFaxVerifiedStale        := not self.isFaxVerifiedFresh and self.isFaxVerified;
	self.isHighVerified            := exists(allrows(isHighVerified));
	self.corrRank                  := max(allrows,allrows.corrRank);
	self.verifiesInputPracPhone    := exists(allrows(verifiesInputPracPhone));
	self.verifiesInputPracFax      := exists(allrows(verifiesInputPracFax));
	self.verifiesInputBillPhone    := exists(allrows(verifiesInputBillPhone));
	self.verifiesInputBillFax      := exists(allrows(verifiesInputBillFax));
	self.verifiesInputPracSuite    := exists(allrows(verifiesInputPracSuite));
	self.verifiesInputBillSuite    := exists(allrows(verifiesInputBillSuite));
	self.otherCount                := count(allrows(not isPhoneVerifiedFresh and not isFaxVerifiedFresh and not isHighVerified));
	self.phone_st := if (self.isInactive, Healthcare_Shared.Constants.stat_Phone_Inactive, 0) |
	                 if (self.isRefPrac, Healthcare_Shared.Constants.stat_Phone_RefPracPhone, 0) |
									 if (self.isRefBill, Healthcare_Shared.Constants.stat_Phone_RefBillPhone, 0) |
									 if (self.isPhoneVerifiedFresh, Healthcare_Shared.Constants.stat_Phone_PhoneVerified, 0) |
									 if (self.isHighVerified, Healthcare_Shared.Constants.stat_Phone_HighVerified, 0) |
									 Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured |    // seems to always be set as we never get area codes in separate fields
									 if (self.isFaxVerifiedFresh, Healthcare_Shared.Constants.stat_Phone_FaxVerified, 0);
end;

export Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress processDistinct(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_AddressPhoneFax l, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_AddressPhoneFax) allRows, integer1 run_mode) := transform
	// rollup record info into distinct address
	self.acctno := allRows[1].acctno;
	self.InternalID := allRows[1].InternalID;
	self.group_key := allRows[1].group_key;
	self.isRoyalty := count(allRows(isRoyalty=false))=0;
	self.sources := dedup(allRows.sources,record,all);
	self.haveDea := exists(allRows(filecode_enum=m_filecode.FilecodeEnum.DEA));
	self.address_type := allRows[1].address_type;
	isTypePrac := exists(allRows(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE));
	isTypeBill := exists(allRows(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING));
	self.isNcpdpOnly := not exists(allRows(filecode_enum<>m_filecode.FilecodeEnum.FAC_NCP));
	self.isCAMOnly := exists(allRows(isCamVerified)) and not exists(allRows(not isCamVerified));
	self.hasValidVSF := exists(allRows(isFaxVerifiedFresh));
	self.isPrison := exists(allRows(isPrison));
	self.isHospital := exists(allRows(isHospital));
	self.isNpsr := exists(allRows(isNpsr));
	isResidential := exists(allRows(isResidential));
	self.isPobox := exists(allRows(isPobox));
	self.isSigStd := exists(allRows(isSigStd));
	self.primaryLocation := if (exists(allRows(filecode_enum=m_filecode.FilecodeEnum.ROSTER and primary_location='Y')), 
															'Y',
															if (exists(allRows(filecode_enum=m_filecode.FilecodeEnum.ROSTER and primary_location='N')), 'N', '')
															);
	records := sort(allRows,-(isPhoneVerified|isFaxVerified|isInactive),-last_update_date,-(isPhoneVerifiedFresh|isFaxVerifiedFresh|isCamVerifiedFresh),isInactive,corrRank);
	self.lastUpdateDate := if(exists(records(last_update_date<>'')), records[1].last_update_date, '');
  self.verifiesInputPracAddress := exists(allRows(verifiesInputPracAddress));
	self.verifiesInputPracPhone := self.verifiesInputPracAddress and exists(allRows(verifiesInputPracPhone));
  self.verifiesInputPracFax := self.verifiesInputPracAddress and exists(allRows(verifiesInputPracFax));
  self.verifiesInputBillAddress := exists(allRows(verifiesInputBillAddress));
	self.verifiesInputBillPhone := self.verifiesInputBillAddress and exists(allRows(verifiesInputBillPhone));
  self.verifiesInputBillFax := self.verifiesInputBillAddress and exists(allRows(verifiesInputBillFax));
	
	// set hospmainindicator
	self.hospMainIndicator := map(self.isHospital and exists(allRows(filecode='FAC_AHD')) => 2,
																self.isHospital => 1,
																0);
	
  // company sorted by phone verified, apcfirmstat (parse confidence) and length
	companies := sort(allRows(company_name<>''), -isPhoneVerifiedFresh, -company_apcfirm, -length(company_name));
	sorted_companies := project(companies, transform(Healthcare_Shared.layouts_commonized.layout_std_company, self := left));
	self.company_key := sorted_companies[1].company_key;
	self.company_name := sorted_companies[1].company_name;
	self.company_apcfirm := sorted_companies[1].company_apcfirm;
	self.company_st := sorted_companies[1].company_st;
				
	// setAddressStatus
	// set fax verification
	fax_verified_records := records(isFaxVerified);
	self.isFaxVerifiedFresh := if (exists(fax_verified_records) and fax_verified_records[1].isFaxVerifiedFresh, true, false);

	// get the first address as best address
	filteredRecords := if (self.haveDea, records(filecode_enum!=m_filecode.FilecodeEnum.SKA_INACT), records);
	bestApf := filteredRecords[1];
				
	Active := if (exists(filteredRecords) and (bestApf.isPhoneVerified or bestApf.isFaxVerified), true, false);
	Inactive := if (exists(filteredRecords) and bestApf.isInactive, true, false);
	self.inactDate := if (Inactive, bestApf.last_update_date, '');
	
	self.isPhoneInactive := if (Inactive and exists(filteredRecords(filecode='SKA_INACT' or filecode='INACT_ENC' or filecode='INACT_LOP')), true, false);
	self.isFaxInactive := if (Inactive and exists(filteredRecords(filecode='INACT_VSF')), true, false);
	self.isPhoneVerifiedFresh := if (Active and exists(filteredRecords(isPhoneVerifiedFresh)), true, false);
	self.isCAMVerifiedFresh := if (Active and exists(filteredRecords(isCamVerifiedFresh)), true, false);
	// FIXME: not sure why legacy limits to billing, even for practice addresses
	isClaimVerifiedFresh := if (exists(filteredRecords(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING and isCamVerifiedFresh)), true, false);
	
	// find mover
	self.inactiveCallReturnId := filteredRecords(verifiesInputPracPhone and (filecode='INACT_ENC' or filecode='INACT_LOP') and call_return_id<>0)[1].call_return_id;
	self.activeCallReturnId := filteredRecords((filecode='SKA_ENC' or filecode='SKA_LOPS') and call_return_id<>0)[1].call_return_id;
																		
	// calcualte high verification
	dea_records := sort(records(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and filecode[1..3] = 'DEA'), -last_update_date);
	cam_verified_fresh_records := sort(records(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and isCamVerifiedFresh), -last_update_date);
	fax_verified_fresh_records := sort(records(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and filecode='ACT_VSF' and isFaxVerifiedFresh), -last_update_date);
	fax_verified_stale_records := sort(records(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and filecode='ACT_VSF' and isFaxVerifiedStale), -last_update_date);
	phone_verified_fresh_records := sort(records(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and isPhoneVerifiedFresh), -last_update_date);
	phone_verified_stale_records := sort(records(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and isPhoneVerifiedStale), -last_update_date);
	high_roster_records := sort(records(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and filecode_enum=m_filecode.FilecodeEnum.ROSTER and source_confidence_score>=88), -last_update_date);
	low_roster_records := sort(records(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and filecode_enum=m_filecode.FilecodeEnum.ROSTER and source_confidence_score<88), -last_update_date);
	npi_records := sort(records(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and filecode[1..3] = 'NPI'), -last_update_date);
	npi_dental_records := sort(records(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and filecode[1..3] = 'NPI' and taxonomy[1..4]='1223'), -last_update_date);
			
	phone_records := phone_verified_fresh_records+phone_verified_stale_records;
	self.lastPhoneVerificationDate := phone_records[1].last_update_date;
			
	fax_records := fax_verified_fresh_records+fax_verified_stale_records;
	self.lastFaxVerificationDate := fax_records[1].last_update_date;
			
	// Case 1: Traditional dental NPI & DEA
	npi_dental_high_verification := if (exists(npi_dental_records) and exists(dea_records) and run_mode=Healthcare_Shared.Constants.RunMode.IDV, 
			                                Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.DENTAL_NPI_DEA, 0);
	npi_dental_phones := set(npi_dental_records, phone);
	npi_dental_faxes  := set(npi_dental_records, fax);
			
	// Case 2: High-verified roster
	roster_high_verification := if (exists(high_roster_records), 
			                            Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.ROSTER, 0);
	roster_high_phones := set(high_roster_records, phone);
	roster_high_faxes  := set(high_roster_records, fax);
			
	// Case 3: VSF verified
	vsf_high_verification := if (exists(fax_verified_fresh_records), 
			                         Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.FRESH_VSF, 0);
	vsf_high_phones := set(fax_verified_fresh_records, phone);
	vsf_high_faxes  := set(fax_verified_fresh_records, fax);
			
	// Case 4: NPI, DEA, CAM overlap
	npi_dea_cam_high_verification := if (exists(npi_records) and exists(dea_records) and exists(cam_verified_fresh_records), 
			                                 Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_NPI_DEA, 0);
	npi_dea_cam_phones := set(npi_records, phone);
	npi_dea_cam_faxes  := set(npi_records, fax);
			
	// Case 5: Stale phone, CAM overlap
	stale_phone_cam_high_verification := if (exists(phone_verified_stale_records) and exists(cam_verified_fresh_records), 
			                                     Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_STALE_PHONE, 0);
	stale_phone_phones := set(phone_verified_stale_records, phone);
	stale_phone_faxes  := set(phone_verified_stale_records, fax);
			
	// Case 6: Stale VSF, CAM overlap
	stale_vsf_cam_high_verification := if (exists(fax_verified_stale_records) and exists(cam_verified_fresh_records), 
			                                   Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_STALE_VSF, 0);
	stale_vsf_cam_phones := set(fax_verified_stale_records, phone);
	stale_vsf_cam_faxes  := set(fax_verified_stale_records, fax);
			
	// Case 7: OV Roster, CAM overlap
	roster_cam_high_verification := if (exists(low_roster_records) and exists(cam_verified_fresh_records) and run_mode=Healthcare_Shared.Constants.RunMode.IDV, 
			                                Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_ROSTER, 0);
	roster_cam_phones := set(low_roster_records, phone);
	roster_cam_faxes  := set(low_roster_records, fax);
			
	// Case 8: OV Roster, DEA overlap
	roster_dea_high_verification := if (exists(low_roster_records) and exists(dea_records) and run_mode=Healthcare_Shared.Constants.RunMode.IDV, 
			                                Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.DEA_ROSTER, 0);
	roster_dea_phones := set(low_roster_records, phone);
	roster_dea_faxes  := set(low_roster_records, fax);
			
	// Case 9: OV Roster, NPI overlap
	roster_npi_high_verification := if (exists(low_roster_records) and exists(npi_records) and run_mode=Healthcare_Shared.Constants.RunMode.IDV, 
			                                Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.NPI_ROSTER, 0);
	roster_npi_phones := set(low_roster_records, phone);
	roster_npi_faxes  := set(low_roster_records, fax);
			
	// set high source (prac only)
	self.highVerification := if(isTypePrac, npi_dental_high_verification+roster_high_verification+vsf_high_verification+npi_dea_cam_high_verification+stale_phone_cam_high_verification+
			                     stale_vsf_cam_high_verification+roster_cam_high_verification+roster_dea_high_verification+roster_npi_high_verification,
													 0);
			
	// get latest HV update date
	date_list := dataset([{if(npi_dental_high_verification>0,npi_dental_records[1].last_update_date,'')},                // Case 1
												{if(roster_high_verification>0,high_roster_records[1].last_update_date,'')},                   // Case 2
												{if(vsf_high_verification>0,fax_verified_fresh_records[1].last_update_date,'')},               // Case 3
			                  {if(npi_dea_cam_high_verification>0,npi_records[1].last_update_date,'')},                      // Case 4
			                  {if(npi_dea_cam_high_verification>0,cam_verified_fresh_records[1].last_update_date,'')},
			                  {if(stale_phone_cam_high_verification>0,cam_verified_fresh_records[1].last_update_date,'')},   // Case 5
			                  {if(stale_phone_cam_high_verification>0,phone_verified_stale_records[1].last_update_date,'')},		
			                  {if(stale_vsf_cam_high_verification>0,cam_verified_fresh_records[1].last_update_date,'')},     // Case 6
			                  {if(stale_vsf_cam_high_verification>0,fax_verified_stale_records[1].last_update_date,'')},
			                  {if(roster_cam_high_verification>0,cam_verified_fresh_records[1].last_update_date,'')},        // Case 7
			                  {if(roster_cam_high_verification>0,low_roster_records[1].last_update_date,'')},
			                  {if(roster_cam_high_verification>0,dea_records[1].last_update_date,'')},                       // Case 8
			                  {if(roster_cam_high_verification>0,low_roster_records[1].last_update_date,'')},
			                  {if(roster_npi_high_verification>0,npi_records[1].last_update_date,'')},                       // Case 9
			                  {if(roster_npi_high_verification>0,low_roster_records[1].last_update_date,'')}
												], {string10   date});
	self.lastHighVerificationDate := max(date_list(date<>''),date);
				
	// set high verification bit to be used later in sorting
	records1 := project(records, setHighVerificationBit(LEFT, self.highVerification));
	
	// sort address records to get the best record in index 1
	sortedRecords := map(self.isPhoneInactive or self.isFaxInactive => sort(records1, -isInactive,-isPhoneVerifiedFresh,-isFaxVerifiedFresh,-isHighVerified,-isPhoneVerifiedStale,-isFaxVerifiedStale,-last_update_date,address_type,-corrRank),
											sort(records1, -isPhoneVerifiedFresh,-isFaxVerifiedFresh,-isHighVerified,-isPhoneVerifiedStale,-isFaxVerifiedStale,-last_update_date,address_type,isInactive,-corrRank));
														
	self.bestAddress := sortedRecords[1];

	self.isNotDeliverable := sortedRecords[1].isNotDeliverable;
	
	// rollup phones
	// ignore SKA_INACTS if they have been trumped.
	phones := if (not Inactive, sortedRecords(filecode<>'SKA_INACT' and length(trim(phone))=10), sortedRecords(length(trim(phone))=10));
	gsPhones := group(sort(phones, phone), phone);
	distinctPhones := rollup(gsPhones, group, rollupPhones(left, rows(left), Inactive, Healthcare_Shared.Layouts_AddrPhoneFax.PhoneType.PHONE));
	sortedDistinctPhones := map(Inactive => sort(distinctPhones, -isInactive,-isPhoneVerifiedFresh,-isFaxVerifiedFresh,-isHighVerified,-isPhoneVerifiedStale,-isFaxVerifiedStale,-lastUpdateDate,-corrRank),
				 										              sort(distinctPhones, -isPhoneVerifiedFresh,-isFaxVerifiedFresh,-isHighVerified,-isPhoneVerifiedStale,-isFaxVerifiedStale,-lastUpdateDate,isInactive,-corrRank));

	hvSortedDistinctPhones := project(sortedDistinctPhones, transform(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone,
		self.highVerification := if (left.number in npi_dental_phones and npi_dental_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.DENTAL_NPI_DEA, 0) +
														 if (left.number in roster_high_phones and roster_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.ROSTER, 0) +
														 if (left.number in vsf_high_phones and vsf_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.FRESH_VSF, 0) +
														 if (left.number in npi_dea_cam_phones and npi_dea_cam_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_NPI_DEA, 0) +
														 if (left.number in stale_phone_phones and stale_phone_cam_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_STALE_PHONE, 0) +
														 if (left.number in stale_vsf_cam_phones and stale_vsf_cam_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_STALE_VSF, 0) +
														 if (left.number in roster_cam_phones and roster_cam_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_ROSTER, 0) +
														 if (left.number in roster_dea_phones and roster_dea_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.DEA_ROSTER, 0) +
														 if (left.number in roster_npi_phones and roster_npi_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.NPI_ROSTER, 0);
		self := left;
	));

	self.distinctPhones := hvSortedDistinctPhones;
	self.bestPhone := hvSortedDistinctPhones[1];
	
	// rollup faxes
	// ignore SKA_INACTS if they have been trumped.
	faxes := if (not Inactive, sortedRecords(filecode<>'SKA_INACT' and length(trim(fax))=10), sortedRecords(length(trim(fax))=10));
	gsFaxes := group(sort(faxes, fax), fax);
	distinctFaxes := rollup(gsFaxes, group, rollupPhones(left, rows(left), Inactive, Healthcare_Shared.Layouts_AddrPhoneFax.PhoneType.FAX));
	sortedDistinctFaxes := map(Inactive => sort(distinctFaxes, -isInactive,-isFaxVerifiedFresh,-isPhoneVerifiedFresh,-isHighVerified,-isFaxVerifiedStale,-isPhoneVerifiedStale,-lastUpdateDate,-corrRank),
				 										             sort(distinctFaxes, -isFaxVerifiedFresh,-isPhoneVerifiedFresh,-isHighVerified,-isFaxVerifiedStale,-isPhoneVerifiedStale,-lastUpdateDate,isInactive,-corrRank));

	hvSortedDistinctFaxes := project(sortedDistinctFaxes, transform(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone,
		self.highVerification := if (left.number in npi_dental_faxes and npi_dental_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.DENTAL_NPI_DEA, 0) +
														 if (left.number in roster_high_faxes and roster_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.ROSTER, 0) +
														 if (left.number in vsf_high_faxes and vsf_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.FRESH_VSF, 0) +
														 if (left.number in npi_dea_cam_faxes and npi_dea_cam_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_NPI_DEA, 0) +
														 if (left.number in stale_phone_faxes and stale_phone_cam_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_STALE_PHONE, 0) +
														 if (left.number in stale_vsf_cam_faxes and stale_vsf_cam_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_STALE_VSF, 0) +
														 if (left.number in roster_cam_faxes and roster_cam_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.CAM_ROSTER, 0) +
														 if (left.number in roster_dea_faxes and roster_dea_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.DEA_ROSTER, 0) +
														 if (left.number in roster_npi_faxes and roster_npi_high_verification>0, Healthcare_Shared.Layouts_AddrPhoneFax.AddressPhoneFaxSourceBit.NPI_ROSTER, 0);
		self := left;
	));

	self.distinctFaxes := hvSortedDistinctFaxes;
	self.bestFax := hvSortedDistinctFaxes[1];
	
	// Analyze stats
	phoneVerified := exists(sortedRecords(isPhoneVerifiedFresh)) and not Inactive;
				
	// If any address says this is not a residential, turn the bit off!
  // Sometimes the +4 zip changes and affects the residential indicator
	foundNonresidential := exists(sortedRecords(addr_st&Healthcare_Shared.Constants.stat_Addr_Residential=0));
	self.isResidential := isResidential and not foundNonresidential and not self.isPobox;
	self.rdi := if (self.isResidential, 'Y', 'N');
	
	// phone verifies suite
	phoneVerifiedSuite := phoneVerified and exists(sortedRecords(isPhoneVerifiedFresh and trim(secondary_range,left,right)!=''));

	// set address stat
	addrIsPhoneVerified := phoneVerified and not (self.isPobox and self.isPhoneVerifiedFresh and not isTypeBill and not self.isHospital);
	self.addr_st := if (sortedRecords[1].isSigStd, Healthcare_Shared.Constants.stat_Addr_SigStd, 0) |
									if (self.isPobox, Healthcare_Shared.Constants.stat_Addr_Pobox, 0) |
									if (self.isNpsr, Healthcare_Shared.Constants.stat_Addr_Npsr, 0) |
									if (self.isPrison, Healthcare_Shared.Constants.stat_Addr_Prison, 0) |
									if (Inactive, Healthcare_Shared.Constants.stat_Addr_Inactive, 0) |
									if (isTypePrac and not self.isPobox, Healthcare_Shared.Constants.stat_Addr_RefPracAddr, 0) |
									if (isTypeBill, Healthcare_Shared.Constants.stat_Addr_RefBillAddr, 0) |
									if (addrIsPhoneVerified, Healthcare_Shared.Constants.stat_Addr_PhoneVerified, 0) |
									if (phoneVerifiedSuite, Healthcare_Shared.Constants.stat_Addr_PhoneVerifiedSecondaryRange, 0) |
									if (self.isHospital, Healthcare_Shared.Constants.stat_Addr_RefHospAddr, 0) |
									if (self.isResidential, Healthcare_Shared.Constants.stat_Addr_Residential, 0) |
									if (self.highVerification>0, Healthcare_Shared.Constants.stat_Addr_HighVerified, 0) |
									if (isClaimVerifiedFresh, Healthcare_Shared.Constants.stat_Addr_ClaimVerified, 0) |
									if (self.isFaxVerifiedFresh, Healthcare_Shared.Constants.stat_Addr_FaxVerified, 0);
									//if (self.primaryLocation='Y', Healthcare_Shared.Constants.stat_Addr_PrimaryLocation, 0);
				
	// calculate OV count (Dedupe VSF act/inact, FKA, DEA, and NPI filecodes)
	otherVerifiedCount1 := count(sortedRecords(not isInactive and (addr_st&Healthcare_Shared.Constants.prison=0) and not isPhoneVerifiedFresh and not isHighVerified));
	otherVerifiedCount2 := count(sortedRecords(filecode='ACT_VSF' or filecode='INACT_VSF'));
	otherVerifiedCount3 := count(sortedRecords(filecode[1..4] = 'NPI_' or filecode='FKA_NPI'));
	otherVerifiedCount4 := count(sortedRecords(filecode[1..4] = 'DEA_' or filecode='FKA_DEA'));
	otherVerifiedCount5 := count(sortedRecords(filecode='CAM'));
	self.otherVerifiedSourceCount := otherVerifiedCount1 - if(otherVerifiedCount2>1, otherVerifiedCount2 - 1, 0) - 
				                                                 if(otherVerifiedCount3>1, otherVerifiedCount3 - 1, 0) - 
																												 if(otherVerifiedCount4>1, otherVerifiedCount4 - 1, 0) - 
																												 if(otherVerifiedCount5>1, otherVerifiedCount5 - 1, 0);
	
	// add confidence score
	self.confidenceScore := map(Inactive => INACT_CONFIDENCE_SCORE,
															addrIsPhoneVerified and self.isCAMVerifiedFresh => PV_CV_CONFIDENCE_SCORE,
															addrIsPhoneVerified => PV_CONFIDENCE_SCORE,
															self.highVerification>0 => HV_CONFIDENCE_SCORE,
				                      self.isCAMOnly => CAM_CONFIDENCE_SCORE,
															self.otherVerifiedSourceCount>=OV_COUNT_LEVEL4 => OV_CONFIDENCE_SCORE4,
															self.otherVerifiedSourceCount=OV_COUNT_LEVEL3 => OV_CONFIDENCE_SCORE3,
															self.otherVerifiedSourceCount=OV_COUNT_LEVEL2 => OV_CONFIDENCE_SCORE2,
															self.otherVerifiedSourceCount=OV_COUNT_LEVEL1 => OV_CONFIDENCE_SCORE1,
															(self.bestAddress.addr_st&Healthcare_Shared.Constants.addressUndeliverable)=0 => DELIVERABLE_CONFIDENCE_SCORE,
															UNDELIVERABLE_CONFIDENCE_SCORE);

	self := self.bestAddress;

	self.records := sortedRecords;
	self := l;
	self := [];
end;

export Healthcare_ProviderPoint.Layouts.AddrPhoneFaxBatchOutput rollupDistinct(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress l, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress) allRows, Healthcare_Shared.Layouts.CombinedHeaderResults inrec) := transform
	self.acctno := inrec.acctno;
	self.LNPID := (string20)inrec.LNPID;
	self.group_key := inrec.VendorID;
	self.match_confidence_flag := (string1)l.verifiesInputPracAddress;
	self.prac1_key := l.addr_key;
	self.prac1_primary_address := l.primary_address;
	self.prac1_secondary_address := l.secondary_address;
	self.prac1_city:= l.city;
	self.prac1_state := l.state;
	self.prac1_zip := l.zip;
	self.prac1_zip4 := l.zip4;
	self.prac1_country_code := Healthcare_Shared.Functions.getCountryCode(l.state);
	self.prac1_rectype := l.rectype;
	self.prac1_primary_range := l.primary_range;
	self.prac1_pre_directional := l.pre_directional;
	self.prac1_primary_name := l.primary_name;
	self.prac1_suffix := l.suffix;
	self.prac1_post_directional := l.post_directional;
	self.prac1_unit_designator := l.unit_designator;
	self.prac1_secondary_range := l.secondary_range;
	self.prac1_pobox := l.pobox;
	self.prac1_rrnumber := l.rrnumber;
	self.prac1_npsr := l.npsr;
	self.prac1_ace_stat_code := l.ace_stat_code;
	self.prac1_error_code := l.error_code;
	self.prac1_fipscode := l.fipscode;
	self.prac1_rdi := l.rdi;
	self.prac1_st := (string11)l.addr_st;
	self.prac1_hospital_name:=l.hospital_name;
	self.prac1_hospital_group_key:=l.hospital_group_key;
	self.prac_phone1 := l.distinctPhones[1].number;
	self.prac_phone1_st := if (l.distinctPhones[1].number!='',(string11)l.distinctPhones[1].phone_st,(string11)(Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured | Healthcare_Shared.Constants.stat_Core_Missing));
	self.prac_phone1_last_contact_date := l.distinctPhones[1].lastPhoneContactDate;
	self.prac_phone2 := l.distinctPhones[2].number;
	self.prac_phone2_st := if (l.distinctPhones[2].number!='',(string11)l.distinctPhones[2].phone_st,(string11)(Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured | Healthcare_Shared.Constants.stat_Core_Missing));
	self.prac_phone2_last_contact_date := l.distinctPhones[2].lastPhoneContactDate;
	self.prac_phone3 := l.distinctPhones[3].number;
	self.prac_phone3_st := if (l.distinctPhones[3].number!='',(string11)l.distinctPhones[3].phone_st,(string11)(Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured | Healthcare_Shared.Constants.stat_Core_Missing));
	self.prac_phone3_last_contact_date := l.distinctPhones[3].lastPhoneContactDate;
	self.prac_fax1 := l.distinctFaxes[1].number;
	self.prac_fax1_st := if (l.distinctFaxes[1].number!='',(string11)l.distinctFaxes[1].phone_st,(string11)(Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured | Healthcare_Shared.Constants.stat_Core_Missing));
	self.prac_fax1_last_contact_date := l.distinctFaxes[1].lastFaxContactDate;
	self.prac_fax2 := l.distinctFaxes[2].number;
	self.prac_fax2_st := if (l.distinctFaxes[2].number!='',(string11)l.distinctFaxes[2].phone_st,(string11)(Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured | Healthcare_Shared.Constants.stat_Core_Missing));
	self.prac_fax2_last_contact_date := l.distinctFaxes[2].lastFaxContactDate;
	self.prac_fax3 := l.distinctFaxes[3].number;
	self.prac_fax3_st := if (l.distinctFaxes[3].number!='',(string11)l.distinctFaxes[3].phone_st,(string11)(Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured | Healthcare_Shared.Constants.stat_Core_Missing));
	self.prac_fax3_last_contact_date := l.distinctFaxes[3].lastFaxContactDate;
	self.prac_company1_name := l.company_name;
	self.prac_company1_apcfirm1 := l.company_apcfirm;
	self.prac_company1_st := (string11)l.company_st;
	self.last_update_date := l.lastUpdateDate;
	self.primary_location := l.primaryLocation;
	self.primary_location_st := if(l.primaryLocation='', '2', '0');
	self.confidence_correct_score := (string3)l.confidenceScore;
	self.hosp_main:='';
end;

// *** UNCOMMENT FOR DEBUGGING
// export Healthcare_ProviderPoint.Layouts.AddrPhoneFaxBatchOutput normalizeAddrPhoneFax(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress l, Healthcare_Shared.Layouts.CombinedHeaderResults inrec) := transform
		// self.acctno := inrec.acctno;
		// self.LNPID := (string20)inrec.LNPID;
		// self.group_key := inrec.VendorID;
		// self.match_confidence_flag := (string1)l.verifiesInputPracAddress;
		// self.prac1_key := l.addr_key;
		// self.prac1_primary_address := l.primary_address;
		// self.prac1_secondary_address := l.secondary_address;
		// self.prac1_city:= l.city;
		// self.prac1_state := l.state;
		// self.prac1_zip := l.zip;
		// self.prac1_zip4 := l.zip4;
		// self.prac1_country_code := Healthcare_Shared.Functions.getCountryCode(l.state);
		// self.prac1_rectype := l.rectype;
		// self.prac1_primary_range := l.primary_range;
		// self.prac1_pre_directional := l.pre_directional;
		// self.prac1_primary_name := l.primary_name;
		// self.prac1_suffix := l.suffix;
		// self.prac1_post_directional := l.post_directional;
		// self.prac1_unit_designator := l.unit_designator;
		// self.prac1_secondary_range := l.secondary_range;
		// self.prac1_pobox := l.pobox;
		// self.prac1_rrnumber := l.rrnumber;
		// self.prac1_npsr := l.npsr;
		// self.prac1_ace_stat_code := l.ace_stat_code;
		// self.prac1_error_code := l.error_code;
		// self.prac1_fipscode := l.fipscode;
		// self.prac1_rdi := l.rdi;
		// self.prac1_st := (string11)l.addr_st;
		// self.prac1_hospital_name:=l.hospital_name;
		// self.prac1_hospital_group_key:=l.hospital_group_key;
		// self.prac_phone1 := l.distinctPhones[1].number;
		// self.prac_phone1_st := if (l.distinctPhones[1].number!='',(string11)l.distinctPhones[1].phone_st,(string11)(Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured | Healthcare_Shared.Constants.stat_Core_Missing));
		// self.prac_phone1_last_contact_date := l.distinctPhones[1].lastPhoneContactDate;
		// self.prac_phone2 := l.distinctPhones[2].number;
		// self.prac_phone2_st := if (l.distinctPhones[2].number!='',(string11)l.distinctPhones[2].phone_st,(string11)(Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured | Healthcare_Shared.Constants.stat_Core_Missing));
		// self.prac_phone2_last_contact_date := l.distinctPhones[2].lastPhoneContactDate;
		// self.prac_phone3 := l.distinctPhones[3].number;
		// self.prac_phone3_st := if (l.distinctPhones[3].number!='',(string11)l.distinctPhones[3].phone_st,(string11)(Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured | Healthcare_Shared.Constants.stat_Core_Missing));
		// self.prac_phone3_last_contact_date := l.distinctPhones[3].lastPhoneContactDate;
		// self.prac_fax1 := l.distinctFaxes[1].number;
		// self.prac_fax1_st := if (l.distinctFaxes[1].number!='',(string11)l.distinctFaxes[1].phone_st,(string11)(Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured | Healthcare_Shared.Constants.stat_Core_Missing));
		// self.prac_fax1_last_contact_date := l.distinctFaxes[1].lastFaxContactDate;
		// self.prac_fax2 := l.distinctFaxes[2].number;
		// self.prac_fax2_st := if (l.distinctFaxes[2].number!='',(string11)l.distinctFaxes[2].phone_st,(string11)(Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured | Healthcare_Shared.Constants.stat_Core_Missing));
		// self.prac_fax2_last_contact_date := l.distinctFaxes[2].lastFaxContactDate;
		// self.prac_fax3 := l.distinctFaxes[3].number;
		// self.prac_fax3_st := if (l.distinctFaxes[3].number!='',(string11)l.distinctFaxes[3].phone_st,(string11)(Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured | Healthcare_Shared.Constants.stat_Core_Missing));
		// self.prac_fax3_last_contact_date := l.distinctFaxes[3].lastFaxContactDate;
		// self.prac_company1_name := l.company_name;
		// self.prac_company1_apcfirm1 := l.company_apcfirm;
		// self.prac_company1_st := (string11)l.company_st;
		// self.last_update_date := l.lastUpdateDate;
		// self.primary_location := l.primaryLocation;
		// self.primary_location_st := if(l.primaryLocation='', '2', '0');
		// self.confidence_correct_score := (string3)l.confidenceScore;
		// self.hosp_main:='';
// end;

end;
