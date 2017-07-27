Import Healthcare_Shared;
//Import Healthcare_ProviderPoint;

export Functions_AddrPhoneFax(dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := module

	// *** UNCOMMENT FOR DEBUGGING
	// export Layout_TestDistinctAddress := record
		// Healthcare_Shared.Layouts.CombinedHeaderResults;
		// dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress)  distinctAddress;
		// dataset(Healthcare_ProviderPoint.Layouts.AddrPhoneFaxBatchOutput)       augAddrPhoneFax;
		// unsigned8 input_prac_addr_st;
		// unsigned4 prac_addr_st;
		// unsigned4 prac_phone_st;
		// unsigned4 prac_fax_st;
		// integer   prac_addr_ustat;
		// integer   prac_phone_ustat;
		// integer   prac_fax_ustat;
		// unsigned4 bill_addr_st;
		// unsigned4 bill_phone_st;
		// unsigned4 bill_fax_st;
		// integer   bill_addr_ustat;
		// integer   bill_phone_ustat;
		// integer   bill_fax_ustat;
		// string8   prac_secondary_range;
		// string8   bill_secondary_range;
		// dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone)  pracAugmentPhones;
		// dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone)  billAugmentPhones;
		// dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone)  pracAugmentFaxes;
		// dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone)  billAugmentFaxes;
		// dataset(Healthcare_Shared.Layouts.layout_addrmeta)           address_meta;
	// end;
	
	export Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress getDistinctAddress(Healthcare_Shared.Layouts.CombinedHeaderResults inrec) := function
		integer1 run_mode := if (inrec.srcIndividualHeader, Healthcare_Shared.Constants.RunMode.IDV, Healthcare_Shared.Constants.RunMode.FAC);
			
		// filecodes we wish to ignore for addrphonefax processing
		badFileCodeEnums := [m_filecode.FilecodeEnum.ABMS,m_filecode.FilecodeEnum.CMS_UPIN,m_filecode.FilecodeEnum.SSA_DMF,m_filecode.FilecodeEnum.LIC,m_filecode.FilecodeEnum.FC_UNKNOWN,m_filecode.FilecodeEnum.CLIENT];
		badFileCode := ['DEA_RET','NPI_RET','NPI_FRET','CLAIM','CLMMDVCP','NP'];
		
		filteredRecs := inrec.RecordsRaw((filecode_enum not in badFileCodeEnums) and (filecode not in badFileCode));
		
		// grab both the prac and bill addresses and add to a single list (PO Box cannot be practice)
		pracAddresses := project(filteredRecs(filecode_enum<>m_filecode.FilecodeEnum.CAM and prac1.addr_key!='' and prac1.addr_st&Healthcare_Shared.Constants.stat_Addr_Pobox=0), Healthcare_Shared.Transforms_AddrPhoneFax.addPracAddress(LEFT, inrec));
		pracCAMAddresses := project(filteredRecs(filecode_enum=m_filecode.FilecodeEnum.CAM and prac1.addr_key!='' and ((>unsigned1<)addr_usage)&Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE>0), Healthcare_Shared.Transforms_AddrPhoneFax.addPracAddress(LEFT, inrec));
		billAddresses := project(filteredRecs(filecode_enum<>m_filecode.FilecodeEnum.CAM and bill1.addr_key!=''), Healthcare_Shared.Transforms_AddrPhoneFax.addBillAddress(LEFT, inrec));
		billCAMAddresses := project(filteredRecs(filecode_enum=m_filecode.FilecodeEnum.CAM and prac1.addr_key!='' and ((>unsigned1<)addr_usage)&Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING>0), Healthcare_Shared.Transforms_AddrPhoneFax.addCAMBillAddress(LEFT, inrec));
			
		// set address verified status
		combinedAddresses := project(pracAddresses+pracCAMAddresses+billAddresses+billCAMAddresses, Healthcare_Shared.Transforms_AddrPhoneFax.setVerifiedStats(LEFT, cfg, run_mode));
						
		// create distinct addresses
		sortedCombinedAddresses := group(sort(combinedAddresses,addr_key,address_type),addr_key,address_type);
		distinctAddress := rollup(sortedCombinedAddresses, group, Healthcare_Shared.Transforms_AddrPhoneFax.processDistinct(LEFT, rows(LEFT), run_mode));
			
		return distinctAddress;
	end;
	
	export boolean IsStandardizedInputAddress(Healthcare_Shared.Layouts.CombinedHeaderResults inrec) := function
		isStandardizedInputAddress := map(cfg[1].ExtractSigStdCorrection&1>0 and inrec.userinput.StatBits.addr_st&Healthcare_Shared.Constants.significantStandardizationOccurred>0 => true,
		                                  cfg[1].ExtractSigStdCorrection&2>0 and inrec.userinput.clnAddr.err_stat[2]='8' => true,
																			false);
		return isStandardizedInputAddress;
	end;
	
	export boolean InputIsAHospital(Healthcare_Shared.Layouts.CombinedHeaderResults inrec) := function
    // Consider input a hospital if
    // matches to AHD or SKA_HOSP or OSC_HPC or MCH_HOSP
		inputIsAHospital := map(exists(inrec.RecordsRaw(filecode='FAC_AHD')) => true,
														exists(inrec.RecordsRaw(filecode='OSC_HPC')) => true,
														exists(inrec.RecordsRaw(filecode='SKA_HOSP')) => true,
														exists(inrec.RecordsRaw(filecode='MCH_HOSP')) => true,
														false);
		return inputIsAHospital;
	end;
	
	export unsigned8 doAddrStat(unsigned4 addr_type, unsigned8 input_addr_st, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress) distinctAddress, string sec_range) := function
		// get the practice verifying address
		verifier := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, distinctAddress(verifiesInputBillAddress)[1], distinctAddress(verifiesInputPracAddress)[1]);
		addr_st := verifier.addr_st;

		phoneVerifiedSecondaryRange_st := if (exists(verifier.records(trim(secondary_range,left,right)=sec_range and addr_st&Healthcare_Shared.Constants.stat_Addr_PhoneVerifiedSecondaryRange>0)), Healthcare_Shared.Constants.stat_Addr_PhoneVerifiedSecondaryRange, 0);
		
		addrStat := input_addr_st | phoneVerifiedSecondaryRange_st | addr_st;
								
		return addrStat;
	end;
	
	export unsigned8 doPhoneStat(unsigned4 addr_type, unsigned8 input_phone_st, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress) distinctAddress) := function
		// get the practice verifying phone
		addrVerifier  := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, distinctAddress(verifiesInputBillAddress), distinctAddress(verifiesInputPracAddress));
		phoneVerifier := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, addrVerifier[1].distinctPhones(verifiesInputBillPhone), addrVerifier[1].distinctPhones(verifiesInputPracPhone));

		phoneStat := if (exists(phoneVerifier), phoneVerifier[1].phone_st, input_phone_st);
								
		return phoneStat;
	end;
	
	export unsigned8 doFaxStat(unsigned4 addr_type, unsigned8 input_fax_st, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress) distinctAddress) := function
		// get the practice verifying fax
		addrVerifier := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, distinctAddress(verifiesInputBillAddress), distinctAddress(verifiesInputPracAddress));
		faxVerifier  := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, addrVerifier[1].distinctFaxes(verifiesInputBillFax), addrVerifier[1].distinctFaxes(verifiesInputPracFax));

		faxStat := if (exists(faxVerifier), faxVerifier[1].phone_st, input_fax_st);
								
		return faxStat;
	end;
	
	export unsigned4 doPracVerification(unsigned8 addr_st, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress) distinctPracAddress, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress) distinctBillAddress) := function
		// get the practice verifying address
		pracVerifier := distinctPracAddress(verifiesInputPracAddress)[1];
		billVerifier := distinctBillAddress(verifiesInputPracAddress)[1];

		// set verification bits
		inactive := pracVerifier.isPhoneInactive or pracVerifier.isFaxInactive;
		addrVerPhonePrac := not inactive and exists(pracVerifier.records(isPhoneVerifiedFresh));
		addrVerPhoneBill := not (billVerifier.isPhoneInactive or billVerifier.isFaxInactive) and exists(billVerifier.records(isPhoneVerifiedFresh));
		addrVerMultOther := count(dedup(sort(pracVerifier.records(filecode_enum<60),filecode_enum),filecode_enum))>1;
		addrVerHigh := not inactive and pracVerifier.highVerification>0;
		addrVerFaxPrac := not inactive and pracVerifier.hasValidVSF;
		isInputBilling := addr_st&Healthcare_Shared.Constants.stat_Addr_RefBillAddr>0;
		addrVerClmBill := false;
		addrVerOtherPrac := not inactive and exists(pracVerifier.records(not isInactive and (addr_st&Healthcare_Shared.Constants.prison=0) and not isPhoneVerifiedFresh and not isHighVerified));
		addrVerOtherBill := not (billVerifier.isPhoneInactive or billVerifier.isFaxInactive) and exists(billVerifier.records(not isInactive and (addr_st&Healthcare_Shared.Constants.prison=0) and not isPhoneVerifiedFresh and not isHighVerified));

		// set report bits
		addrRepMissing:= addr_st&Healthcare_Shared.Constants.stat_Missing>0;
		addrRepPhoneInactive := pracVerifier.isPhoneInactive;
		addrRepHVInactive := pracVerifier.isFaxInactive;
		addrRepHighRisk := pracVerifier.isPrison or pracVerifier.isNpsr;
		addrRepPOBox := addr_st&Healthcare_Shared.Constants.stat_Addr_Pobox>0;
		addrRepUndeliverable := addr_st&Healthcare_Shared.Constants.stat_Addr_NotDeliverable>0;

		addr_ustat := Healthcare_Shared.Codes_Prac_Address.get_addr_ustat(
			addrVerOtherPrac,
			addrVerOtherBill,
			addrVerMultOther,
			addrVerHigh,
			addrVerPhonePrac,
			addrVerPhoneBill,
			addrVerFaxPrac,
			addrVerClmBill,
			false, //addrCorTypo,
			false, //addrCorMoved,
			addrRepMissing,
			addrRepPhoneInactive,
			addrRepHVInactive,
			addrRepHighRisk,
			addrRepPOBox,
			addrRepUndeliverable,
			false, //addrRepInvalid,
			false, //addrAugOther,
			false, //addrAugHigh,
			false, //addrAugPhone,
			false, //addrAugFax,
			false, //addrAugHVInputState,
			false  //addrAugPVInputState
		);
		
		return addr_ustat;
	end;
	
	export unsigned4 doBillVerification(unsigned8 addr_st, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress) distinctPracAddress, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress) distinctBillAddress) := function
		// get the practice verifying address
		pracVerifier := distinctPracAddress(verifiesInputBillAddress)[1];
		billVerifier := distinctBillAddress(verifiesInputBillAddress)[1];

		// set verification bits
		inactive := billVerifier.isPhoneInactive or billVerifier.isFaxInactive;
		addrVerPhonePrac := not (pracVerifier.isPhoneInactive or pracVerifier.isFaxInactive) and exists(pracVerifier.records(isPhoneVerifiedFresh));
		addrVerPhoneBill := not inactive and exists(billVerifier.records(isPhoneVerifiedFresh));
		addrVerMultOther := count(dedup(sort(billVerifier.records(filecode_enum<60),filecode_enum),filecode_enum))>1;
		addrVerHigh := not inactive and billVerifier.highVerification>0;
		addrVerFaxPrac := not inactive and billVerifier.hasValidVSF;
		isInputBilling := addr_st&Healthcare_Shared.Constants.stat_Addr_RefBillAddr>0;
		addrVerClmBill := isInputBilling and not inactive and exists(billVerifier.records(isCamVerifiedFresh));
		addrVerOtherPrac := not (pracVerifier.isPhoneInactive or pracVerifier.isFaxInactive) and exists(pracVerifier.records(not isInactive and (addr_st&Healthcare_Shared.Constants.prison=0) and not isPhoneVerifiedFresh and not isHighVerified));
		addrVerOtherBill := not inactive and exists(billVerifier.records(not isInactive and (addr_st&Healthcare_Shared.Constants.prison=0) and not isPhoneVerifiedFresh and not isHighVerified));

		// set report bits
		addrRepMissing:= addr_st&Healthcare_Shared.Constants.stat_Missing>0;
		addrRepPhoneInactive := billVerifier.isPhoneInactive;
		addrRepHVInactive := billVerifier.isFaxInactive;
		addrRepHighRisk := billVerifier.isPrison or billVerifier.isNpsr;
		addrRepPOBox := addr_st&Healthcare_Shared.Constants.stat_Addr_Pobox>0;
		addrRepUndeliverable := addr_st&Healthcare_Shared.Constants.stat_Addr_NotDeliverable>0;

		addr_ustat := Healthcare_Shared.Codes_Prac_Address.get_addr_ustat(
			addrVerOtherPrac,
			addrVerOtherBill,
			addrVerMultOther,
			addrVerHigh,
			addrVerPhonePrac,
			addrVerPhoneBill,
			addrVerFaxPrac,
			addrVerClmBill,
			false, //addrCorTypo,
			false, //addrCorMoved,
			addrRepMissing,
			addrRepPhoneInactive,
			addrRepHVInactive,
			addrRepHighRisk,
			addrRepPOBox,
			addrRepUndeliverable,
			false, //addrRepInvalid,
			false, //addrAugOther,
			false, //addrAugHigh,
			false, //addrAugPhone,
			false, //addrAugFax,
			false, //addrAugHVInputState,
			false  //addrAugPVInputState
		);
		
		return addr_ustat;
	end;
	
	export unsigned4 doPhoneUstats(unsigned4 addr_type, unsigned8 phone_st, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress) distinctAddress) := function
		// get the practice verifying address
		addrVerifier := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, distinctAddress(verifiesInputBillAddress), distinctAddress(verifiesInputPracAddress));
		phoneVerifier := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, addrVerifier[1].distinctPhones(verifiesInputBillPhone), addrVerifier[1].distinctPhones(verifiesInputPracPhone));
		phoneAugs := map(addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING => normalize(distinctAddress(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING and augment and not isPhoneInactive and not isFaxInactive), left.distinctPhones(not verifiesInputBillPhone and isRefBill), transform(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone, self:=right)),
								     normalize(distinctAddress(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and augment and not isPhoneInactive and not isFaxInactive), left.distinctPhones(not verifiesInputPracPhone and isRefPrac), transform(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone, self:=right)));
		bestPhone := addrVerifier[1].bestPhone;

		// set verification bits
		phoneVerOtherPrac := if (exists(phoneVerifier),phoneVerifier[1].isOtherVerifiedAsPractice,false);
		phoneVerOtherBill := if (exists(phoneVerifier),phoneVerifier[1].isOtherVerifiedAsBilling,false);
		phoneVerPhonePrac := if (exists(phoneVerifier),phoneVerifier[1].isPhoneVerifiedAsPractice,false);
		phoneVerPhoneBill := if (exists(phoneVerifier),phoneVerifier[1].isPhoneVerifiedAsBilling,false);
		phoneVerHigh      := if (exists(phoneVerifier),phoneVerifier[1].isHighVerified,false);
		// only set this for billing
		phoneVerMultOther := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING and exists(phoneVerifier),phoneVerifier[1].otherCount>1,false);
		phoneVerFaxPrac   := if (exists(phoneVerifier),phoneVerifier[1].isVSF and phoneVerifier[1].isFaxVerifiedFresh,false);
		
		// set correction bits
		correctionStat := addrVerifier[1].correction;
		phoneCorCompanion := correctionStat&Healthcare_Shared.Layouts_AddrPhoneFax.CorrectionType.PHONE>0;
		
		// set report bits
		phoneRepMissing       := phone_st&Healthcare_Shared.Constants.stat_Missing>0;
		phoneRepPhoneInactive := if (exists(phoneVerifier),phoneVerifier[1].isInactive and phoneVerifier[1].isPhoneVerified,false);
		phoneRepHCInactive    := if (exists(phoneVerifier),phoneVerifier[1].isInactive and phoneVerifier[1].isFaxVerified,false);
		phoneRepBadFormat     := phone_st&Healthcare_Shared.Constants.stat_BadFormat>0;
		phoneRepInvalid       := phone_st&Healthcare_Shared.Constants.badPhoneFromPhoneVerification>0;
		
		// set augment bits
		augPhone      := phoneAugs.isPhoneVerifiedFresh or phoneAugs.isPhoneInactive;
		phoneAugPhone := exists(phoneAugs(augPhone));
		augFax        := phoneAugs.isFaxVerified or phoneAugs.isFaxInactive;
		phoneAugFax   := exists(phoneAugs(augFax and not augPhone));
		phoneAugHigh  := exists(phoneAugs(augFax and not augPhone and isFaxVerifiedFresh)) or exists(phoneAugs(not augPhone and not augFax and isHighVerified));
		phoneAugOther := exists(phoneAugs(augFax and not isFaxVerifiedFresh and not augPhone)) or exists(phoneAugs(otherCount>0 and not augPhone and not augFax and not isHighVerified));
		
		phone_ustat := Healthcare_Shared.Codes_Prac_Address.get_phone_ustat(
			phoneVerOtherPrac,
			phoneVerOtherBill,
			phoneVerMultOther,
			phoneVerHigh,
			phoneVerPhonePrac,
			phoneVerPhoneBill,
			phoneVerFaxPrac,
			phoneCorCompanion,
			false, // phoneCorMoved,
			phoneRepMissing,
			phoneRepPhoneInactive,
			phoneRepHCInactive,
			phoneRepBadFormat,
			phoneRepInvalid,
			phoneAugOther,
			phoneAugHigh,
			phoneAugPhone,
			phoneAugFax
		);
		
		return phone_ustat;
	end;
	
	export unsigned4 doFaxUstats(unsigned4 addr_type, unsigned8 fax_st, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress) distinctAddress) := function
		// get the practice verifying address
		addrVerifier := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, distinctAddress(verifiesInputBillAddress), distinctAddress(verifiesInputPracAddress));
		faxVerifier := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, addrVerifier[1].distinctFaxes(verifiesInputBillFax), addrVerifier[1].distinctFaxes(verifiesInputPracFax));
		faxAugs := map(addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING => normalize(distinctAddress(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING and augment), left.distinctFaxes(not verifiesInputBillFax and isRefBill), transform(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone, self:=right)),
								   normalize(distinctAddress(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and augment), left.distinctFaxes(not verifiesInputPracFax and isRefPrac), transform(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone, self:=right)));
		bestFax := addrVerifier[1].bestFax;
		
		// set verification bits
		faxVerOtherPrac := if (exists(faxVerifier),faxVerifier[1].isOtherVerifiedAsPractice,false);
		faxVerOtherBill := if (exists(faxVerifier),faxVerifier[1].isOtherVerifiedAsBilling,false);
		faxVerPhonePrac := if (exists(faxVerifier),faxVerifier[1].isPhoneVerifiedAsPractice,false);
		faxVerPhoneBill := if (exists(faxVerifier),faxVerifier[1].isPhoneVerifiedAsBilling,false);
		faxVerHigh      := if (exists(faxVerifier),faxVerifier[1].isHighVerified,false);
		faxVerMultOther := if (exists(faxVerifier),faxVerifier[1].otherCount>1,false);
		faxVerFaxPrac   := if (exists(faxVerifier),faxVerifier[1].isVSF,false);
		
		// set correction bits
		correctionStat := addrVerifier[1].correction;
		faxCorCompanion := correctionStat&Healthcare_Shared.Layouts_AddrPhoneFax.CorrectionType.FAX>0;
		
		// set report bits
		faxRepMissing       := fax_st&Healthcare_Shared.Constants.stat_Missing>0;
		faxRepPhoneInactive := if (exists(faxVerifier),faxVerifier[1].isInactive and faxVerifier[1].isPhoneVerified,false);
		faxRepHCInactive    := if (exists(faxVerifier),faxVerifier[1].isInactive and faxVerifier[1].isFaxVerified,false);
		faxRepBadFormat     := fax_st&Healthcare_Shared.Constants.stat_BadFormat>0;
		
		// set augment bits
		augFax        := faxAugs.isFaxVerified or faxAugs.isFaxInactive;
		faxAugFax     := exists(faxAugs(augFax));
		augPhone      := faxAugs.isPhoneVerifiedFresh or faxAugs.isPhoneInactive;
		faxAugPhone   := exists(faxAugs(augPhone and not augFax));
		faxAugHigh    := exists(faxAugs(augFax and isFaxVerifiedFresh)) or exists(faxAugs(not augFax and not augPhone and isHighVerified));
		faxAugOther   := exists(faxAugs(augFax and not isFaxVerifiedFresh)) or exists(faxAugs(otherCount>0 and not augPhone and not augFax and not isHighVerified));

		fax_ustat := Healthcare_Shared.Codes_Prac_Address.get_phone_ustat(
			faxVerOtherPrac,
			faxVerOtherBill,
			faxVerMultOther,
			faxVerHigh,
			faxVerPhonePrac,
			faxVerPhoneBill,
			faxVerFaxPrac,
			faxCorCompanion,
			false, // faxCorMoved,
			faxRepMissing,
			faxRepPhoneInactive,
			faxRepHCInactive,
			faxRepBadFormat,
			false, // faxRepInvalid,
			faxAugOther,
			faxAugHigh,
			faxAugPhone,
			faxAugFax
		);
		
		return fax_ustat;
	end;
	
	export boolean isOkToCorrect(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress distinctAddress) := function
		okay := map(cfg[1].excludeSourceNCPDP and distinctAddress.isNcpdpOnly => false,
								distinctAddress.isNotDeliverable => false,
								true);
		
		return okay;
	end;
	
	export boolean isCorrectionCandidate(unsigned8 addr_st, Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress distinctAddress) := function
		bCorrectionCandidate := map(cfg[1].CorrectionCandidateLevel='OV' => true,
																cfg[1].CorrectionCandidateLevel='CV' and (distinctAddress.isCAMVerified or distinctAddress.isPhoneVerifiedFresh or distinctAddress.highVerification>0) => true,
																cfg[1].CorrectionCandidateLevel='HV' and (distinctAddress.isPhoneVerifiedFresh or distinctAddress.highVerification>0) => true,
																cfg[1].CorrectionCandidateLevel='PV' and (distinctAddress.isPhoneVerifiedFresh) => true,
																addr_st & Healthcare_Shared.Constants.stat_Addr_NotDeliverable > 0 and cfg[1].CorrectionUndeliverableLevel='O' => true,
																addr_st & Healthcare_Shared.Constants.stat_Addr_NotDeliverable > 0 and cfg[1].CorrectionUndeliverableLevel='C' and (distinctAddress.isCAMVerified or distinctAddress.isPhoneVerifiedFresh or distinctAddress.highVerification>0) => true,
																addr_st & Healthcare_Shared.Constants.stat_Addr_NotDeliverable > 0 and cfg[1].CorrectionUndeliverableLevel='H' and (distinctAddress.isPhoneVerifiedFresh or distinctAddress.highVerification>0) => true,
																addr_st & Healthcare_Shared.Constants.stat_Addr_NotDeliverable > 0 and cfg[1].CorrectionUndeliverableLevel='P' and (distinctAddress.isPhoneVerifiedFresh) => true,
																addr_st & Healthcare_Shared.Constants.stat_Core_BadFormat > 0 and cfg[1].CorrectionBadPhoneLevel='O' => true,
																addr_st & Healthcare_Shared.Constants.stat_Core_BadFormat > 0 and cfg[1].CorrectionBadPhoneLevel='C' and (distinctAddress.isCAMVerified or distinctAddress.isPhoneVerifiedFresh or distinctAddress.highVerification>0) => true,
																addr_st & Healthcare_Shared.Constants.stat_Core_BadFormat > 0 and cfg[1].CorrectionBadPhoneLevel='H' and (distinctAddress.isPhoneVerifiedFresh or distinctAddress.highVerification>0) => true,
																addr_st & Healthcare_Shared.Constants.stat_Core_BadFormat > 0 and cfg[1].CorrectionBadPhoneLevel='P' and (distinctAddress.isPhoneVerifiedFresh) => true,
																false);
																
		return bCorrectionCandidate;
	end;
	
	export boolean isHighCorrectionCandidate(boolean isInputAddressDeliverable, boolean secondariesConflict, Healthcare_Shared.Layouts.MatchStat ms) := function
		xmi := ms.extendedInfo;
		score := ms.score;	
		ret := map (score>=Healthcare_Shared.Constants.HIGH_CORRECTION_CANDIDATE_THRESHOLD and (xmi&Fn_set_match_input.XMI_PRIMARY_NAME_FUZZY>0) and not secondariesConflict => true,     // Standard correction based on score
								score>=Healthcare_Shared.Constants.HIGH_CORRECTION_CANDIDATE_THRESHOLD and (xmi&Fn_set_match_input.XMI_PRIMARY_RANGE_FUZZY>0) and not secondariesConflict => true,    // Correction to fix incorrect primary range
								score>=Healthcare_Shared.Constants.HIGH_CORRECTION_CANDIDATE_THRESHOLD and not isInputAddressDeliverable =>true,                                                      // Correction for undeliverable input address
								false);

		return ret;
	end;

	export boolean isMedCorrectionCandidate(boolean isInputAddressDeliverable, boolean secondariesConflict, Healthcare_Shared.Layouts.MatchStat ms) := function
		xmi := ms.extendedInfo;
		score := ms.score;	
		stateZipMatch := Fn_set_match_input.XMI_STATE_MATCH + Fn_set_match_input.XMI_ZIP_MATCH;
		nameRangeStateMatch := Fn_set_match_input.XMI_PRIMARY_NAME_MATCH + Fn_set_match_input.XMI_PRIMARY_RANGE_MATCH + Fn_set_match_input.XMI_STATE_MATCH;
		ret := map (score>=Healthcare_Shared.Constants.MED_CORRECTION_CANDIDATE_THRESHOLD and (not secondariesConflict and not isInputAddressDeliverable) => true,                       // Standard correction based on score
								(xmi&stateZipMatch)=stateZipMatch and not secondariesConflict and ((xmi&Fn_set_match_input.XMI_PRIMARY_RANGE_MATCH)>0 or (xmi&Fn_set_match_input.XMI_PRIMARY_RANGE_MATCH)>0) => true,    // Correction to fix incorrect primary name or range
								not isInputAddressDeliverable and not ((xmi&Fn_set_match_input.XMI_STATE_MATCH)>0) and (xmi&nameRangeStateMatch)=nameRangeStateMatch =>true,       // Correction to fix incorrect city
								false);

		return ret;
	end;

	export boolean isLowCorrectionCandidate(boolean isInputAddressDeliverable, boolean secondariesConflict, Healthcare_Shared.Layouts.MatchStat ms) := function
		xmi := ms.extendedInfo;
		score := ms.score;	
		cityStateZipMatch := Fn_set_match_input.XMI_CITY_MATCH + Fn_set_match_input.XMI_STATE_MATCH + Fn_set_match_input.XMI_ZIP_MATCH;
		ret := map (score>Healthcare_Shared.Constants.LOW_CORRECTION_CANDIDATE_THRESHOLD and (not secondariesConflict or not isInputAddressDeliverable) => true,                             // Standard correction based on score
								not isInputAddressDeliverable and ((xmi&cityStateZipMatch)=cityStateZipMatch) => true,                   // Hail Mary correction
								false);

		return ret;
	end;
	
	export unsigned1 getCorrectionStats(unsigned4 addr_type, Healthcare_Shared.Layouts.CombinedHeaderResults inRec, Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress distinctAddress) := function
		addr_st := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, inrec.userinput.StatBits.billAddr_st, inrec.userinput.StatBits.addr_st);
		phone_st := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, inrec.userinput.StatBits.billAddr_st, inrec.userinput.StatBits.phone_st);
		fax_st := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, inrec.userinput.StatBits.billAddr_st, inrec.userinput.StatBits.fax_st);
		
		ms := distinctAddress.bestAddress.msBillAddr;
		xmi := ms.extendedInfo;
		score := ms.score;	
		isInputAddressDeliverable := not (addr_st & Healthcare_Shared.Constants.stat_Addr_NotDeliverable >0);
		bSecondaryConflict := xmi&Fn_set_match_input.XMI_SECONDARY_RANGE_CONFLICT>0;
		bestAddress := distinctAddress.bestAddress;
		secondary_range := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, inrec.userinput.clnBillAddr.sec_range, inrec.userinput.clnAddr.sec_range);
		bSecondarySubtraction := secondary_range!='' and bestAddress.secondary_range='';
		bSecondaryAddition := secondary_range='' and bestAddress.secondary_range!='';
		secondariesConflict := bSecondaryConflict or bSecondarySubtraction;
		
		isCandidate := isCorrectionCandidate(addr_st, distinctAddress);
		addressCorrection := map (isCandidate and score=100 and (bSecondaryAddition or not isInputAddressDeliverable) => true,
															isCandidate and cfg[1].CorrectionAssesmentLevel='H' and isHighCorrectionCandidate(isInputAddressDeliverable, secondariesConflict, ms) => true,
															isCandidate and cfg[1].CorrectionAssesmentLevel='B' and isHighCorrectionCandidate(isInputAddressDeliverable, secondariesConflict, ms) => true,
															isCandidate and cfg[1].CorrectionAssesmentLevel='B' and inrec.userinput.IsIndividualSearch and isInputAddressDeliverable and isMedCorrectionCandidate(isInputAddressDeliverable, secondariesConflict, ms) => true,     // HACK - also add unverified
															isCandidate and cfg[1].CorrectionAssesmentLevel='M' and isMedCorrectionCandidate(isInputAddressDeliverable, secondariesConflict, ms) => true,
															isCandidate and cfg[1].CorrectionAssesmentLevel='L' and isLowCorrectionCandidate(isInputAddressDeliverable, secondariesConflict, ms) => true,
															false);

		isQualifiedAddress := addressCorrection or (isCandidate and score=100 and not bSecondaryConflict);
		
		verifiesAddress := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, distinctAddress.verifiesInputBillAddress, distinctAddress.verifiesInputPracAddress);
		verifiesPhone := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, distinctAddress.verifiesInputBillPhone, distinctAddress.verifiesInputPracPhone);
		verifiesFax := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, distinctAddress.verifiesInputBillFax, distinctAddress.verifiesInputPracFax);

		phoneNotMissing := phone_st&Healthcare_Shared.Constants.stat_Missing=0;
		faxNotMissing := fax_st&Healthcare_Shared.Constants.stat_Missing=0;
		
		phoneCorrection := isQualifiedAddress and phoneNotMissing and (not verifiesPhone or (verifiesPhone and not verifiesAddress));
		faxCorrection := isQualifiedAddress and faxNotMissing and (not verifiesFax or (verifiesFax and not verifiesAddress));

		return if(addressCorrection,Healthcare_Shared.Layouts_AddrPhoneFax.CorrectionType.ADDRESS, 0) |
		       if(phoneCorrection,Healthcare_Shared.Layouts_AddrPhoneFax.CorrectionType.PHONE, 0) |
					 if(faxCorrection,Healthcare_Shared.Layouts_AddrPhoneFax.CorrectionType.FAX, 0);
	end;

	export unsigned4 doCorrection(Healthcare_Shared.Layouts.CombinedHeaderResults inrec, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress) distinctAddress) := function
		addrMoveFrom := distinctAddress(verifiesInputPracAddress and address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and isPhoneInactive and inactiveCallReturnId<>0);
		addrMoveTo := distinctAddress(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and not isPhoneInactive and not isNotDeliverable and (isPhoneVerifiedFresh or highVerification>0) and activeCallReturnId=addrMoveFrom[1].inactiveCallReturnId);
		addrCorMoved := exists(addrMoveFrom) and exists(addrMoveTo);
	
		inputVerified := exists(distinctAddress(verifiesInputPracAddress and address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE));
		addrCorTypo1 := not inputVerified and not addrCorMoved and exists(distinctAddress(not isPhoneInactive and not isNotDeliverable and address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and (correction&Healthcare_Shared.Layouts_AddrPhoneFax.CorrectionType.ADDRESS)>0));
		addrCorTypo2 := IsStandardizedInputAddress(inrec);

		addr_ustat := Healthcare_Shared.Codes_Prac_Address.get_addr_ustat(
			false, //addrVerOtherPrac,
			false, //addrVerOtherBill,
			false, //addrVerMultOther,
			false, //addrVerHigh,
			false, //addrVerPhonePrac,
			false, //addrVerPhoneBill,
			false, //addrVerFaxPrac,
			false, //addrVerClmBill,
			addrCorTypo1 or addrCorTypo2,
			addrCorMoved,
			false, //addrRepMissing,
			false, //addrRepPhoneInactive,
			false, //addrRepHVInactive,
			false, //addrRepHighRisk,
			false, //addrRepPOBox,
			false, //addrRepUndeliverable,
			false, //addrRepInvalid,
			false, //addrAugOther,
			false, //addrAugHigh,
			false, //addrAugPhone,
			false, //addrAugFax,
			false, //addrAugHVInputState,
			false, //addrAugPVInputState
		);
	
		return addr_ustat;
	end;
	
	export boolean isOkToAugment(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress distinctAddress) := function
	  okay := map(distinctAddress.isCAMOnly => false,
								cfg[1].excludeSourceNCPDP and distinctAddress.isNcpdpOnly => false,
								distinctAddress.isNotDeliverable => false,
								true);
		
		return okay;
	end;
	
	export unsigned4 doAugmentation(unsigned4 addr_type, string2 instate, dataset(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress) distinctAddress) := function
		augmentAddress := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, 
													distinctAddress(augment and address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING and not verifiesInputBillAddress and not (isPhoneInactive or isFaxInactive)),
													distinctAddress(augment and address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and not verifiesInputPracAddress and not (isPhoneInactive or isFaxInactive)));
													
		addrAugPhone := exists(augmentAddress(isPhoneVerifiedFresh or isPhoneInactive));
		addrAugFax := exists(augmentAddress(hasValidVSF));
		addrAugHigh := exists(augmentAddress(highVerification>0 and not isPhoneVerifiedFresh and not isPhoneInactive));
		addrAugOther := exists(augmentAddress(highVerification=0 and not isPhoneVerifiedFresh and not isPhoneInactive));
		addrAugHVInputState := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, 
															 false, 
															 exists(augmentAddress((highVerification>0 or isFaxInactive) and (instate=state))));
		addrAugPVInputState := if (addr_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, 
															 false, 
															 exists(augmentAddress((isPhoneVerifiedFresh or isPhoneInactive) and (instate=state))));
			
		addr_ustat := Healthcare_Shared.Codes_Prac_Address.get_addr_ustat(
			false, //addrVerOtherPrac,
			false, //addrVerOtherBill,
			false, //addrVerMultOther,
			false, //addrVerHigh,
			false, //addrVerPhonePrac,
			false, //addrVerPhoneBill,
			false, //addrVerFaxPrac,
			false, //addrVerClmBill,
			false, //addrCorTypo,
			false, //addrCorMoved,
			false, //addrRepMissing,
			false, //addrRepPhoneInactive,
			false, //addrRepHVInactive,
			false, //addrRepHighRisk,
			false, //addrRepPOBox,
			false, //addrRepUndeliverable,
			false, //addrRepInvalid,
			addrAugOther,
			addrAugHigh,
			addrAugPhone,
			addrAugFax,
			addrAugHVInputState,
			addrAugPVInputState
		);
	
		return addr_ustat;
	end;

	// *** UNCOMMENT FOR DEBUGGING
	// export fn_processAddr(dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) inRecs) := function
	
		// recs := project(inRecs, transform(Layout_TestDistinctAddress,
			// inrec := left;
			// distinctAddress := getDistinctAddress(inrec);
			
			// pracAddrRepMissing:= inrec.userinput.StatBits.addr_st&Healthcare_Shared.Constants.stat_Missing>0;
			// billAddrRepMissing:= inrec.userinput.StatBits.billAddr_st&Healthcare_Shared.Constants.stat_Missing>0;

			// augmentDistinctPracAddress := project(distinctAddress(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE), transform(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress,
				// self.augment := isOkToAugment(left);
				// self.correction := if (pracAddrRepMissing, 0, getCorrectionStats(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE, inrec, left));
				// self := left;
			// ));
			// augmentDistinctBillAddress := project(distinctAddress(address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING), transform(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress,
				// self.augment := isOkToAugment(left);
				// self.correction := if (billAddrRepMissing, 0, getCorrectionStats(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, inrec, left));
				// self := left;
			// ));

			// pracAddrVerfUstat  := doPracVerification(left.userinput.StatBits.addr_st, augmentDistinctPracAddress, augmentDistinctBillAddress);
			// pracAddrCorrUstat  := doCorrection(left, augmentDistinctPracAddress);
			// pracAddrAugUstat   := doAugmentation(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE, left.userinput.clnAddr.st, augmentDistinctPracAddress);
			// pracPhoneUstat     := doPhoneUstats(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE, left.userinput.StatBits.phone_st, augmentDistinctPracAddress);
			// pracFaxUstat       := doFaxUstats(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE, left.userinput.StatBits.fax_st, augmentDistinctPracAddress);
			// pracAddrStat       := doAddrStat(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE, left.userinput.StatBits.addr_st, augmentDistinctPracAddress, trim(left.userinput.sec_range,left,right));
			// pracPhoneStat      := doPhoneStat(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE, left.userinput.StatBits.phone_st, augmentDistinctPracAddress);
			// pracFaxStat        := doFaxStat(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE, left.userinput.StatBits.fax_st, augmentDistinctPracAddress);
			// self.prac_secondary_range := trim(left.userinput.sec_range,left,right);
			
			// self.pracAugmentPhones := normalize(augmentDistinctPracAddress(augment and address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and not isPhoneInactive and not isFaxInactive), left.distinctPhones(not verifiesInputPracPhone and isRefPrac), transform(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone, self:=right));
			// self.billAugmentPhones := normalize(augmentDistinctBillAddress(augment and address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING and not isPhoneInactive and not isFaxInactive), left.distinctPhones(not verifiesInputBillPhone and isRefBill), transform(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone, self:=right));
 			// self.pracAugmentFaxes  := normalize(augmentDistinctPracAddress(augment and address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.PRACTICE and not isPhoneInactive and not isFaxInactive), left.distinctFaxes(not verifiesInputPracFax and isRefPrac), transform(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone, self:=right));
			// self.billAugmentFaxes  := normalize(augmentDistinctBillAddress(augment and address_type=Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING and not isPhoneInactive and not isFaxInactive), left.distinctFaxes(not verifiesInputBillFax and isRefBill), transform(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctPhone, self:=right));

			// billAddrVerfUstat  := doBillVerification(left.userinput.StatBits.billAddr_st, augmentDistinctPracAddress, augmentDistinctBillAddress);
			// billAddrAugUstat   := doAugmentation(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, inrec.userinput.clnbillAddr.st, augmentDistinctBillAddress);
			// billPhoneUstat     := doPhoneUstats(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, left.userinput.StatBits.billphone_st, augmentDistinctBillAddress);
			// billFaxUstat       := doFaxUstats(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, left.userinput.StatBits.billfax_st, augmentDistinctBillAddress);
			// billAddrStat       := doAddrStat(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, left.userinput.StatBits.billAddr_st, augmentDistinctBillAddress, trim(left.userinput.bill_sec_range,left,right));
			// billPhoneStat      := doPhoneStat(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, left.userinput.StatBits.billphone_st, augmentDistinctBillAddress);
			// billFaxStat        := doFaxStat(Healthcare_Shared.Layouts_AddrPhoneFax.AddressType.BILLING, left.userinput.StatBits.billfax_st, augmentDistinctBillAddress);
			// self.bill_secondary_range := trim(left.userinput.bill_sec_range,left,right);
			
			// self.input_prac_addr_st := left.userinput.StatBits.addr_st;
			// self.distinctAddress  := project(sort(augmentDistinctPracAddress+augmentDistinctBillAddress,-verifiesInputPracAddress,address_type,-confidenceScore,-isPhoneVerifiedFresh), transform(Healthcare_Shared.Layouts_AddrPhoneFax.Layout_DistinctAddress,
				// self.addr_rank := counter;
				// self := left
			// ));
			// self.prac_addr_st     := pracAddrStat;
			// self.prac_phone_st    := pracPhoneStat;
			// self.prac_fax_st      := pracFaxStat;
			// self.prac_addr_ustat  := pracAddrVerfUstat | pracAddrCorrUstat | pracAddrAugUstat;
			// self.prac_phone_ustat := pracPhoneUstat;
			// self.prac_fax_ustat   := pracFaxUstat;
			// self.bill_addr_st     := billAddrStat;
			// self.bill_phone_st    := billPhoneStat;
			// self.bill_fax_st      := billFaxStat;
			// self.bill_addr_ustat  := billAddrVerfUstat | billAddrAugUstat;
			// self.bill_phone_ustat := billPhoneUstat;
			// self.bill_fax_ustat   := billFaxUstat;
			// self.augAddrPhoneFax  := project(self.distinctAddress(augment), Healthcare_Shared.Transforms_AddrPhoneFax.normalizeAddrPhoneFax(left, inrec));

			// addresses := project(self.distinctAddress, transform(Healthcare_Shared.Layouts.layout_addrmeta, self:=left, self:=[]));
			// address_meta1 := project(addresses, Healthcare_Shared.Transforms_AddrMeta.getAddressMeta(left, inrec));
			// address_meta2 := project(sort(address_meta1,-bill_addr_score,-dd_total_bill), transform(Healthcare_Shared.Layouts.layout_addrmeta, self.bill_addr_rank:=counter,self:=left));

			// Healthcare_Shared.Layouts.layout_addrmeta cafAddrRank(Healthcare_Shared.Layouts.layout_addrmeta l, integer c) := transform
				// self.caf_addr_rank := c;
				// self.adjusted_caf_score := power((l.caf_addr_score/120), self.caf_addr_rank) * 120.0;
				// self.adjusted_caf_star := map(self.adjusted_caf_score>= 105.0 => 5,
																			// self.adjusted_caf_score>= 95.0 => 4,
																			// self.adjusted_caf_score>= 85.0 => 3,
																			// self.adjusted_caf_score>= 70.0 => 2,
																			// self.adjusted_caf_score>= 30.0 => 1,
																			// 0);
				// self := l;
			// end;
			// address_meta3 := project(sort(address_meta2,-caf_addr_score,-dd_total_prac), cafAddrRank(left, counter));
			
			// self.address_meta := address_meta3;
			
			// self := left;
		// ));
		
		// return recs;
	// end;
	
end;