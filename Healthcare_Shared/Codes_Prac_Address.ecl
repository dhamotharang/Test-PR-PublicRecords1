EXPORT Codes_Prac_Address := Module
	Export get_addr_ustat(boolean addrVerOtherPrac,
												boolean addrVerOtherBill,
												boolean addrVerMultOther,
												boolean addrVerHigh,
												boolean addrVerPhonePrac,
												boolean addrVerPhoneBill,
												boolean addrVerFaxPrac,
												boolean addrVerClmBill,
												boolean addrCorTypo,
												boolean addrCorMoved,
												boolean addrRepMissing,
												boolean addrRepPhoneInactive,
												boolean addrRepHVInactive,
												boolean addrRepHighRisk,
												boolean addrRepPOBox,
												boolean addrRepUndeliverable,
												boolean addrRepInvalid,
												boolean addrAugOther,
												boolean addrAugHigh,
												boolean addrAugPhone,
												boolean addrAugFax,
												boolean addrAugHVInputState,
												boolean addrAugPVInputState) := Function
	addr_ustat := if(addrVerOtherPrac,Healthcare_Shared.Constants.ustat_Addr_Verified_Practice,0) +
							  if(addrVerOtherBill,Healthcare_Shared.Constants.ustat_Addr_Verified_Billing,0) +
							  if(addrVerMultOther,Healthcare_Shared.Constants.ustat_Addr_Multiple_Sources,0) +
							  if(addrVerHigh,Healthcare_Shared.Constants.ustat_Addr_HCVerified,0) +
							  if(addrVerPhonePrac,Healthcare_Shared.Constants.ustat_Addr_PV_Practice,0) +
								if(addrVerPhoneBill,Healthcare_Shared.Constants.ustat_Addr_PV_Billing,0) +
								if(addrVerFaxPrac,Healthcare_Shared.Constants.ustat_Addr_FaxVerified_Practice,0) +
								if(addrVerClmBill,Healthcare_Shared.Constants.ustat_Addr_ClaimVerified_Billing,0) +
								if(addrCorTypo,Healthcare_Shared.Constants.ustat_Addr_Typo_Correction,0) +
								if(addrCorMoved,Healthcare_Shared.Constants.ustat_Addr_CallBased_Update,0) +
								if(addrRepMissing,Healthcare_Shared.Constants.ustat_Addr_Missing,0) +
								if(addrRepPhoneInactive,Healthcare_Shared.Constants.ustat_Addr_PV_Inactive,0) +
								if(addrRepHVInactive,Healthcare_Shared.Constants.ustat_Addr_HCInactive,0) +
								if(addrRepHighRisk,Healthcare_Shared.Constants.ustat_Addr_HighRisk,0) +
								if(addrRepPOBox,Healthcare_Shared.Constants.ustat_Addr_POBox,0) +
								if(addrRepUndeliverable,Healthcare_Shared.Constants.ustat_Addr_Undeliverable,0) +
								if(addrRepInvalid,Healthcare_Shared.Constants.ustat_Addr_Invalid,0) +
								if(addrAugOther,Healthcare_Shared.Constants.ustat_Addr_Aug_Other_Verified,0) +
								if(addrAugHigh,Healthcare_Shared.Constants.ustat_Addr_Aug_HCVerified,0) +
								if(addrAugPhone,Healthcare_Shared.Constants.ustat_Addr_Aug_PV_Verified,0) +
								if(addrAugFax,Healthcare_Shared.Constants.ustat_Addr_Aug_Fax_Verified,0) +
								if(addrAugHVInputState,Healthcare_Shared.Constants.ustat_Addr_Aug_HV_Value,0) +
								if(addrAugPVInputState,Healthcare_Shared.Constants.ustat_Addr_Aug_PV_Value,0);
			return addr_ustat;
	end;
	Export get_phone_ustat(boolean phoneVerOtherPrac,
												 boolean phoneVerOtherBill,
												 boolean phoneVerMultOther,
												 boolean phoneVerHigh,
												 boolean phoneVerPhonePrac,
												 boolean phoneVerPhoneBill,
												 boolean phoneVerFaxPrac,
												 boolean phoneCorCompanion,
												 boolean phoneCorMoved,
												 boolean phoneRepMissing,
												 boolean phoneRepPhoneInactive,
												 boolean phoneRepHCInactive,
												 boolean phoneRepBadFormat,
												 boolean phoneRepInvalid,
												 boolean phoneAugOther,
												 boolean phoneAugHigh,
												 boolean phoneAugPhone,
												 boolean phoneAugFax) := Function
		phone_ustat := if(phoneVerOtherPrac,Healthcare_Shared.Constants.ustat_Phone_Verified_Practice,0) +
		               if(phoneVerOtherBill,Healthcare_Shared.Constants.ustat_Phone_Verified_Billing,0) +
									 if(phoneVerMultOther,Healthcare_Shared.Constants.ustat_Phone_Multiple_Sources,0) +
									 if(phoneVerHigh,Healthcare_Shared.Constants.ustat_Phone_HCVerified,0) +
									 if(phoneVerPhonePrac,Healthcare_Shared.Constants.ustat_Phone_PV_Practice,0) +
									 if(phoneVerPhoneBill,Healthcare_Shared.Constants.ustat_Phone_PV_Billing,0) +
									 if(phoneVerFaxPrac,Healthcare_Shared.Constants.ustat_Phone_FaxVerified_Practice,0) +
									 if(phoneCorCompanion,Healthcare_Shared.Constants.ustat_Phone_CompanionData,0) +
									 if(phoneCorMoved,Healthcare_Shared.Constants.ustat_Phone_CallBased_Update,0) +
									 if(phoneRepMissing,Healthcare_Shared.Constants.ustat_Phone_Missing,0) +
									 if(phoneRepPhoneInactive,Healthcare_Shared.Constants.ustat_Phone_PV_Inactive,0) +
									 if(phoneRepHCInactive,Healthcare_Shared.Constants.ustat_Phone_HCInactive,0) +
									 if(phoneRepBadFormat,Healthcare_Shared.Constants.ustat_Phone_BadFormat,0) +
									 if(phoneRepInvalid,Healthcare_Shared.Constants.ustat_Phone_Invalid,0) +
									 if(phoneAugOther,Healthcare_Shared.Constants.ustat_Phone_Aug_Other_Verified,0) +
									 if(phoneAugHigh,Healthcare_Shared.Constants.ustat_Phone_Aug_HCVerified,0) +
									 if(phoneAugPhone,Healthcare_Shared.Constants.ustat_Phone_Aug_PV_Verified,0) +
									 if(phoneAugFax,Healthcare_Shared.Constants.ustat_Phone_Aug_Fax_Verified,0);
		return phone_ustat;
	end;
	Export get_fax_ustat(boolean faxVerOtherPrac,
											 boolean faxVerOtherBill,
											 boolean faxVerMultOther,
											 boolean faxVerHigh,
											 boolean faxVerPhonePrac,
											 boolean faxVerPhoneBill,
											 boolean faxVerPhonePrac,
											 boolean faxCorCompanion,
											 boolean faxCorMoved,
											 boolean faxRepMissing,
											 boolean faxRepPhoneInactive,
											 boolean faxRepHCInactive,
											 boolean faxRepBadFormat,
											 boolean faxRepInvalid,
											 boolean faxAugOther,
											 boolean faxAugHigh,
											 boolean faxAugPhone,
											 boolean faxAugFax) := Function
		fax_ustat := if(faxVerOtherPrac,Healthcare_Shared.Constants.ustat_Phone_Verified_Practice,0) +
		             if(faxVerOtherBill,Healthcare_Shared.Constants.ustat_Phone_Verified_Billing,0) +
								 if(faxVerMultOther,Healthcare_Shared.Constants.ustat_Phone_Multiple_Sources,0) +
								 if(faxVerHigh,Healthcare_Shared.Constants.ustat_Phone_HCVerified,0) +
								 if(faxVerPhonePrac,Healthcare_Shared.Constants.ustat_Phone_PV_Practice,0) +
								 if(faxVerPhoneBill,Healthcare_Shared.Constants.ustat_Phone_PV_Billing,0) +
								 if(faxVerPhonePrac,Healthcare_Shared.Constants.ustat_Phone_FaxVerified_Practice,0) +
								 if(faxCorCompanion,Healthcare_Shared.Constants.ustat_Phone_CompanionData,0) +
								 if(faxCorMoved,Healthcare_Shared.Constants.ustat_Phone_CallBased_Update,0) +
								 if(faxRepMissing,Healthcare_Shared.Constants.ustat_Phone_Missing,0) +
								 if(faxRepPhoneInactive,Healthcare_Shared.Constants.ustat_Phone_PV_Inactive,0) +
								 if(faxRepHCInactive,Healthcare_Shared.Constants.ustat_Phone_HCInactive,0) +
								 if(faxRepBadFormat,Healthcare_Shared.Constants.ustat_Phone_BadFormat,0) +
								 if(faxRepInvalid,Healthcare_Shared.Constants.ustat_Phone_Invalid,0) +
								 if(faxAugOther,Healthcare_Shared.Constants.ustat_Phone_Aug_Other_Verified,0) +
								 if(faxAugHigh,Healthcare_Shared.Constants.ustat_Phone_Aug_HCVerified,0) +
								 if(faxAugPhone,Healthcare_Shared.Constants.ustat_Phone_Aug_PV_Verified,0) +
								 if(faxAugFax,Healthcare_Shared.Constants.ustat_Phone_Aug_Fax_Verified,0);
		return fax_ustat;
	end;

	Export getAddr_dos_ustat() := Function
			return 0;
	end;
	
 	Export getPrac_Address_HCP_cic(integer prac_addr_ustat, integer prac_phone_ustat, integer prac_corr_conf_score) := Function
			
			boolean isAddrVerOtherPrac 				:= prac_addr_ustat&1 > 0;
			boolean isAddrVerOtherBill 				:= prac_addr_ustat&2 > 0;
			boolean isAddrVerMultOther 				:= prac_addr_ustat&4 > 0;
			boolean isAddrVerHigh 						:= prac_addr_ustat&8 > 0;
			boolean isAddrVerPhonePrac				:= prac_addr_ustat&16 > 0;
			boolean isAddrVerPhoneBill				:= prac_addr_ustat&32 > 0;
			boolean isAddrVerFaxPrac					:= prac_addr_ustat&64 > 0;
			boolean isAddrVerClmBill					:= prac_addr_ustat&128 > 0;
			boolean isAddrCorTypo							:= prac_addr_ustat&256 > 0;
			boolean isAddrCorMoved						:= prac_addr_ustat&1024 > 0;
			boolean isAddrRepMissing 					:= prac_addr_ustat&4096 > 0;
			boolean isAddrRepPhoneInactive		:= prac_addr_ustat&8192 > 0;
			boolean isAddrRepHVInactive				:= prac_addr_ustat&16384 > 0;
			boolean isAddrRepHighRisk					:= prac_addr_ustat&32768 > 0;
			boolean isAddrRepPOBox						:= prac_addr_ustat&65536 > 0;
			boolean isAddrRepUndeliverable		:= prac_addr_ustat&131072 > 0;
			boolean isAddrRepInvalid					:= prac_addr_ustat&262144 > 0;
			boolean isAddrAugOther						:= prac_addr_ustat&16777216 > 0;
			boolean isAddrAugHigh							:= prac_addr_ustat&67108864 > 0;
			boolean isAddrAugPhone						:= prac_addr_ustat&134217728 > 0;
			boolean isAddrAugFax							:= prac_addr_ustat&268435456 > 0;
			boolean isAddrAugHVInputState			:= prac_addr_ustat&536870912 > 0;
			boolean isAddrAugPVInputState			:= prac_addr_ustat&1073741824 > 0;
				
			boolean isPhoneCorCompanion				:= prac_phone_ustat&512 > 0;
			
			string mover_on_input 							:= '0';
			string prac_addr_correction_key			:= ''; // in output
			string prac_addr_verified						:= '0';
			integer prac1_addr_inact_tier_score	:= 91; // in output
			//string hpb_flag										:= '0';
			//string prac1_key									:= 'A'; // in output
			integer prac1_inact_tier_score			:= 91;
			//prac1_ace_stat_code
			//prac_addr_correction_st										// in output
			//prac1_st																	// in output
			//provider_ustat => isInactiveLicPracState, hasExpiredLicPracState, and isSuspendedLicPracState
			boolean isInactiveLicPracState			:= true;
			boolean hasExpiredLicPracState			:= true;
			boolean isSuspendedLicPracState			:= true;
   		
   		return map(isAddrCorMoved and mover_on_input = '0' => Healthcare_Shared.Constants.cic_HPC_Addr_Call_Update, // 'GN' 
 						
					isAddrCorMoved and mover_on_input = '1' => Healthcare_Shared.Constants.cic_HPC_Addr_CallBased_Update, // 'GD'
					
					(isAddrCorTypo or (/*prac1_ace_stat_code not in ace_stats and*/ prac_corr_conf_score >= 90 and prac_addr_correction_key != '' and not isAddrRepPhoneInactive))
						and (not isAddrRepPhoneInactive and not isAddrRepHVInactive and not prac_corr_conf_score < 90)
						and (not isAddrRepPhoneInactive and not isAddrRepHvInactive and not prac_corr_conf_score = 90 /*not prac1_key = prac_addr_correction_key and prac_addr_correction_st, 2097152
							and not prac_addr_correction_st 1677216*/ and not prac_corr_conf_score >= 90) => Healthcare_Shared.Constants.cic_HPC_Addr_Typo_Correction, // 'C'
					
					isAddrRepPhoneInactive and isAddrRepHVInactive and not isAddrVerHigh and not isAddrVerPhonePrac and isInactiveLicPracState and hasExpiredLicPracState and
						isSuspendedLicPracState and (not isAddrAugPVInputState or not isAddrAugHVInputState) => Healthcare_Shared.Constants.cic_HPC_Addr_HCInactive, // 'Z'
						
					(not isAddrVerHigh and not isAddrVerPhonePrac) and (isAddrRepPhoneInactive and isAddrRepHVInactive) and prac_addr_verified = '1'
						and prac1_addr_inact_tier_score = 91  => Healthcare_Shared.Constants.cic_HPC_Addr_PV_Inactive, // 'II'
					
					(not isAddrVerHigh and not isAddrVerPhonePrac) and (isAddrRepPhoneInactive and isAddrRepHVInactive) 
						and prac_addr_verified = '0' and prac1_addr_inact_tier_score = 91 => Healthcare_Shared.Constants.cic_HPC_Addr_Inactive, // 'IR' 
					
					(not isAddrVerHigh and not isAddrVerPhonePrac) and (isAddrRepPhoneInactive and isAddrRepHVInactive) 
						and prac1_addr_inact_tier_score = 82 /*..86)*/  => Healthcare_Shared.Constants.cic_HPC_Addr_PV_Inactive_NoMatch, // 'I2'  
				
					isAddrRepHighRisk /*and hbp_flag = '0' and prac1_st 16384 */ => Healthcare_Shared.Constants.cic_HPC_Addr_HighRisk_Prison, // 'H' 
				
					isAddrRepHighRisk /*and hbp_flag = '0' and prac1_st 4096 */ => Healthcare_Shared.Constants.cic_HPC_Addr_HighRisk_NPSR, // 'N'  
				
					/*prac1_ace_stat_code not in ace_stats and*/ prac_addr_correction_key != '' and prac_corr_conf_score < 90 => Healthcare_Shared.Constants.cic_HPC_Addr_Standardization, // 'S' 
				
					isAddrRepUndeliverable and not isAddrCorTypo and not isAddrCorMoved and prac_corr_conf_score < 54 => Healthcare_Shared.Constants.cic_HPC_Addr_Undeliverable, // 'X'   	
			
					isAddrRepPOBox /*and hbp_flag = '0'*/ => Healthcare_Shared.Constants.cic_HPC_Addr_POBox, // 'P' 
				
					(((isAddrVerOtherPrac and isAddrVerHigh and isAddrVerPhonePrac and isAddrVerFaxPrac) and (not isAddrCorMoved and not isAddrRepMissing and not isAddrRepPhoneInactive and not
						 isAddrRepHVInactive and not isAddrRepPOBox and not isAddrRepUndeliverable and not isAddrRepInvalid) and (not isAddrRepHighRisk /*and hpb_flag = '0'*/)) 
						 or ((isAddrVerHigh and isAddrVerPhonePrac) and (isAddrRepHVInactive) and (isPhoneCorCompanion)) 
						 or ((isAddrRepPhoneInactive and isAddrRepHVInactive) and prac1_inact_tier_score = 58 )) => Healthcare_Shared.Constants.cic_HPC_Addr_Verified, // 'V'  

					isAddrRepUndeliverable and (not isAddrCorTypo and not isAddrCorMoved) and (isAddrVerOtherPrac and isAddrVerHigh and isAddrVerPhonePrac) 
						 and prac_corr_conf_score > 53 => Healthcare_Shared.Constants.cic_HPC_Addr_Verified, // 'V' 
					
					isAddrVerOtherBill and isAddrVerPhoneBill and isAddrVerClmBill and not isAddrVerOtherPrac and not isAddrVerHigh and not isAddrVerPhonePrac and not 
						 isAddrVerFaxPrac and not isAddrCorTypo and not isAddrCorMoved and not isAddrRepMissing and not isAddrRepPhoneInactive and not isAddrRepHVInactive and not
						 isAddrRepHighRisk and not isAddrRepUndeliverable and not isAddrRepInvalid => Healthcare_Shared.Constants.cic_HPC_Addr_Verified_Billing, // '1'  		

					isAddrRepMissing and not isAddrCorTypo and not isAddrCorMoved and isAddrAugHigh 
						 and isAddrAugPhone => Healthcare_Shared.Constants.cic_HPC_Addr_Missing_PV, // 'A'
				
					isAddrRepMissing and not isAddrCorTypo and not isAddrCorMoved and not isAddrAugHigh
						 and not isAddrAugPhone => Healthcare_Shared.Constants.cic_HPC_Addr_Missing_NoPV, // 'M'

					not isAddrVerOtherPrac and not isAddrVerOtherBill and not isAddrVerMultOther and not isAddrVerHigh and not isAddrVerPhonePrac 
						 and not isAddrVerPhoneBill and not isAddrVerFaxPrac and not isAddrVerClmBill and not isAddrCorTypo and not isAddrCorMoved and
						 (isAddrAugHigh and isAddrAugPhone) => Healthcare_Shared.Constants.cic_HPC_Addr_Unverified_PV, // '2'
		
					not isAddrVerOtherPrac and not isAddrVerOtherBill and not isAddrVerMultOther and not isAddrVerHigh and not isAddrVerPhonePrac 
						 and not isAddrVerPhoneBill and not isAddrVerFaxPrac and not isAddrVerClmBill and not isAddrCorTypo and not isAddrCorMoved and 
						 not isAddrAugHigh and not isAddrAugPhone => Healthcare_Shared.Constants.cic_HPC_Addr_Unverified_NoPV, // ' '						
					'');
	end;
	
	Export getPrac_Address_HCO_cic(integer prac_addr_ustat, integer prac_phone_ustat, integer prac_corr_conf_score) := Function
			boolean isAddrVerOtherPrac 				:= prac_addr_ustat&1 > 0;
			boolean isAddrVerOtherBill 				:= prac_addr_ustat&2 > 0;
			boolean isAddrVerMultOther 				:= prac_addr_ustat&4 > 0;
			boolean isAddrVerHigh 						:= prac_addr_ustat&8 > 0;
			boolean isAddrVerPhonePrac				:= prac_addr_ustat&16 > 0;
			boolean isAddrVerPhoneBill				:= prac_addr_ustat&32 > 0;
			boolean isAddrVerFaxPrac					:= prac_addr_ustat&64 > 0;
			boolean isAddrVerClmBill					:= prac_addr_ustat&128 > 0;
			boolean isAddrCorTypo							:= prac_addr_ustat&256 > 0;
			boolean isAddrCorMoved						:= prac_addr_ustat&1024 > 0;
			boolean isAddrRepMissing 					:= prac_addr_ustat&4096 > 0;
			boolean isAddrRepPhoneInactive		:= prac_addr_ustat&8192 > 0;
			boolean isAddrRepHVInactive				:= prac_addr_ustat&16384 > 0;
			boolean isAddrRepHighRisk					:= prac_addr_ustat&32768 > 0;
			boolean isAddrRepPOBox						:= prac_addr_ustat&65536 > 0;
			boolean isAddrRepUndeliverable		:= prac_addr_ustat&131072 > 0;
			boolean isAddrRepInvalid					:= prac_addr_ustat&262144 > 0;
			boolean isAddrAugOther						:= prac_addr_ustat&16777216 > 0;
			boolean isAddrAugHigh							:= prac_addr_ustat&67108864 > 0;
			boolean isAddrAugPhone						:= prac_addr_ustat&134217728 > 0;
			boolean isAddrAugFax							:= prac_addr_ustat&268435456 > 0;
			boolean isAddrAugHVInputState			:= prac_addr_ustat&536870912 > 0;
			boolean isAddrAugPVInputState			:= prac_addr_ustat&1073741824 > 0;

			boolean isPhoneRepPhoneInactive 		:= prac_phone_ustat&8192 > 0;
			
			boolean isInactiveLicPracState			:= true;
			boolean hasExpiredLicPracState			:= true;
			boolean isSuspendedLicPracState			:= true;
			
			string prac_addr_correction_key			:= ''; // in output
			integer prac_addr_conf_score				:= 50;
			
			return map(
					(isAddrCorTypo /*and prac1_secondary_range == prac_addr_correction_secondary_range*/ and prac_corr_conf_score >= 90) 
						or (/*prac1_ace_stat_code not in ace_stats and*/ not isAddrRepPhoneInactive and prac_addr_correction_key != '' 
								/*and prac_secondary_range == prac_addr_correction_secondary_range*/ and prac_corr_conf_score >= 90) => Healthcare_Shared.Constants.cic_HCO_Addr_Typo_Correction, // 'C'
					
					isAddrRepPhoneInactive and isAddrRepHVInactive and isInactiveLicPracState and hasExpiredLicPracState and isSuspendedLicPracState 
						/*and prac_addr_aug_fl == '0'*/ => Healthcare_Shared.Constants.cic_HCO_Addr_HCInactive, // 'Z'
					
					not isAddrVerHigh and not isAddrVerPhonePrac and isAddrRepPhoneInactive and isAddrRepHVInactive and isPhoneRepPhoneInactive => Healthcare_Shared.Constants.cic_HCO_Addr_Inactive, // 'IR'
					
					not isAddrVerHigh and not isAddrVerPhonePrac and isAddrRepPhoneInactive and isAddrRepHVInactive and not isPhoneRepPhoneInactive => Healthcare_Shared.Constants.cic_HCO_Addr_PV_Inactive_NoMatch, // 'I2'
					
					isAddrRepHighRisk /*and prac1_st 16384*/ => Healthcare_Shared.Constants.cic_HCO_Addr_HighRisk_Prison, // 'H'
					
					isAddrRepHighRisk /*and prac1_st 4096*/ => Healthcare_Shared.Constants.cic_HCO_Addr_HighRisk_NPSR, // 'N'
					
					/*prac1_ace_stat_code not in ace_stats and*/ prac_addr_correction_key != '' and prac_corr_conf_score < 90 => Healthcare_Shared.Constants.cic_HCO_Addr_Standardization, // 'S'
					
					isAddrRepUndeliverable and not isAddrCorTypo and isAddrCorMoved and prac_addr_conf_score < 54 => Healthcare_Shared.Constants.cic_HCO_Addr_Undeliverable, // 'X'
					
					isAddrVerOtherPrac and isAddrVerHigh and isAddrVerPhonePrac and not isAddrCorMoved and not isAddrRepMissing and not isAddrRepPhoneInactive and 
						not isAddrRepHVInactive and not isAddrRepHighRisk and not isAddrRepPOBox and not isAddrRepUndeliverable and 
						not isAddrRepInvalid => Healthcare_Shared.Constants.cic_HCO_Addr_Verified, // 'V'
					
					isAddrRepUndeliverable and not isAddrCorTypo and isAddrCorMoved and isAddrVerOtherPrac and isAddrVerHigh and isAddrVerPhonePrac 
						and prac_addr_conf_score > 53 => Healthcare_Shared.Constants.cic_HCO_Addr_Verified, // 'V'
					
					isAddrRepPOBox => Healthcare_Shared.Constants.cic_HCO_Addr_POBox, // 'P'
					
					isAddrVerOtherBill and isAddrVerPhoneBill and isAddrVerClmBill and not isAddrVerOtherPrac and not isAddrVerHigh and not isAddrVerPhonePrac 
						and not isAddrVerFaxPrac and not isAddrCorMoved and not isAddrRepMissing and not isAddrRepPhoneInactive and not isAddrRepHVInactive 
						and not isAddrRepHighRisk and not isAddrRepPOBox and not isAddrRepUndeliverable and not isAddrRepInvalid => Healthcare_Shared.Constants.cic_HCO_Addr_Verified_Billing, // '1'
					
					isAddrRepMissing and not isAddrCorTypo and not isAddrCorMoved and isAddrAugHigh and isAddrAugPhone => Healthcare_Shared.Constants.cic_HCO_Addr_Missing_PV, // 'A'
					
					isAddrRepMissing and not isAddrCorTypo and not isAddrCorMoved and not isAddrAugHigh and not isAddrAugPhone => Healthcare_Shared.Constants.cic_HCO_Addr_Missing_NoPV, // 'M'
					
					not isAddrVerOtherPrac and not isAddrVerOtherBill and not isAddrVerMultOther and not isAddrVerHigh and not isAddrVerPhonePrac and not isAddrVerPhoneBill and not isAddrVerFaxPrac 
						and isAddrVerClmBill and not isAddrCorTypo and not isAddrCorMoved and isAddrAugHigh and isAddrAugPhone => Healthcare_Shared.Constants.cic_HCO_Addr_Unverified_PV, // '2'
					'');
	end;
	
	Export getBill_Address_HCP_cic(integer prac_bill_ustat, integer bill_corr_conf_score) := Function
	
			boolean isAddrVerOtherPrac 				:= prac_bill_ustat&1 > 0;
			boolean isAddrVerOtherBill 				:= prac_bill_ustat&2 > 0;
			boolean isAddrVerMultOther 				:= prac_bill_ustat&4 > 0;
			boolean isAddrVerHigh 						:= prac_bill_ustat&8 > 0;
			boolean isAddrVerPhonePrac				:= prac_bill_ustat&16 > 0;
			boolean isAddrVerPhoneBill				:= prac_bill_ustat&32 > 0;
			boolean isAddrVerFaxPrac					:= prac_bill_ustat&64 > 0;
			boolean isAddrVerClmBill					:= prac_bill_ustat&128 > 0;
			boolean isAddrCorTypo							:= prac_bill_ustat&256 > 0;
			boolean isAddrCorMoved						:= prac_bill_ustat&1024 > 0;
			boolean isAddrRepMissing 					:= prac_bill_ustat&4096 > 0;
			boolean isAddrRepPhoneInactive		:= prac_bill_ustat&8192 > 0;
			boolean isAddrRepHVInactive				:= prac_bill_ustat&16384 > 0;
			boolean isAddrRepHighRisk					:= prac_bill_ustat&32768 > 0;
			boolean isAddrRepPOBox						:= prac_bill_ustat&65536 > 0;
			boolean isAddrRepUndeliverable		:= prac_bill_ustat&131072 > 0;
			boolean isAddrRepInvalid					:= prac_bill_ustat&262144 > 0;
			boolean isAddrAugOther						:= prac_bill_ustat&16777216 > 0;
			boolean isAddrAugHigh							:= prac_bill_ustat&67108864 > 0;
			boolean isAddrAugPhone						:= prac_bill_ustat&134217728 > 0;
			boolean isAddrAugFax							:= prac_bill_ustat&268435456 > 0;
			boolean isAddrAugHVInputState			:= prac_bill_ustat&536870912 > 0;
			boolean isAddrAugPVInputState			:= prac_bill_ustat&1073741824 > 0;
			
			string bill_addr_correction_key			:= '';
			integer prac_bill_conf_score				:= 50;
			string loop_indicator								:= 'BILLING';
			
			return map(
						isAddrRepHighRisk /*and bill1_st 16384*/ => Healthcare_Shared.Constants.cic_HPC_Bill_HighRisk_Prison, // 'H'
						
						isAddrRepHighRisk /*and bill1_st 4096*/ => Healthcare_Shared.Constants.cic_HPC_Bill_HighRisk_NPSR, // 'N'
						
						(isAddrCorTypo or (/*bill1_ace_st_code not in ace_stats and*/ not isAddrRepPhoneInactive and not isAddrRepHVInactive and bill_addr_correction_key != '')) and 
							not isAddrRepPhoneInactive and not isAddrRepHVInactive and bill_corr_conf_score >= 90 => Healthcare_Shared.Constants.cic_HPC_Bill_Typo_Correction, // 'C'
						
						isAddrRepPhoneInactive and isAddrRepHVInactive => Healthcare_Shared.Constants.cic_HPC_Bill_PV_HV_Inactive, // 'I'
						
						/*bill1_ace_stat_code not in ace_stat and */ not bill_addr_correction_key != '' and bill_corr_conf_score < 90 => Healthcare_Shared.Constants.cic_HPC_Bill_Standardization, // 'S'
						
						isAddrRepUndeliverable and not isAddrCorTypo => Healthcare_Shared.Constants.cic_HPC_Bill_Undeliverable, // 'X'
						
						isAddrVerOtherPrac and isAddrVerOtherBill and isAddrVerMultOther and isAddrVerHigh and isAddrVerPhonePrac and isAddrVerPhoneBill and isAddrVerFaxPrac and 
							isAddrVerClmBill and not isAddrCorTypo and not isAddrRepPhoneInactive and not isAddrRepHVInactive and not isAddrRepHighRisk and not isAddrRepUndeliverable 
							and not isAddrRepInvalid => Healthcare_Shared.Constants.cic_HPC_Bill_Verified, // 'V'
							
						isAddrRepPOBox and loop_indicator = 'BILLING' => Healthcare_Shared.Constants.cic_HPC_Bill_POBox, // 'P'
						
						isAddrRepMissing and not isAddrCorTypo and isAddrAugPhone => Healthcare_Shared.Constants.cic_HPC_Bill_Missing_PV, // 'A'
						
						isAddrRepMissing and not isAddrCorTypo and not isAddrAugPhone => Healthcare_Shared.Constants.cic_HPC_Bill_Missing_NoPV, // 'M'
						
						not isAddrVerOtherPrac and not isAddrVerOtherBill and not isAddrVerMultOther and not isAddrVerHigh and not isAddrVerPhonePrac and not isAddrVerPhoneBill and 
							not isAddrVerFaxPrac and not isAddrVerClmBill and not isAddrCorTypo and isAddrAugPhone => Healthcare_Shared.Constants.cic_HPC_Bill_Unverified_PV, // '2'
			'');
	end;
	
	Export getBill_Address_HCO_cic(integer prac_bill_ustat, integer bill_corr_conf_score) := Function
	
			boolean isAddrVerOtherPrac 				:= prac_bill_ustat&1 > 0;
			boolean isAddrVerOtherBill 				:= prac_bill_ustat&2 > 0;
			boolean isAddrVerMultOther 				:= prac_bill_ustat&4 > 0;
			boolean isAddrVerHigh 						:= prac_bill_ustat&8 > 0;
			boolean isAddrVerPhonePrac				:= prac_bill_ustat&16 > 0;
			boolean isAddrVerPhoneBill				:= prac_bill_ustat&32 > 0;
			boolean isAddrVerFaxPrac					:= prac_bill_ustat&64 > 0;
			boolean isAddrVerClmBill					:= prac_bill_ustat&128 > 0;
			boolean isAddrCorTypo							:= prac_bill_ustat&256 > 0;
			boolean isAddrCorMoved						:= prac_bill_ustat&1024 > 0;
			boolean isAddrRepMissing 					:= prac_bill_ustat&4096 > 0;
			boolean isAddrRepPhoneInactive		:= prac_bill_ustat&8192 > 0;
			boolean isAddrRepHVInactive				:= prac_bill_ustat&16384 > 0;
			boolean isAddrRepHighRisk					:= prac_bill_ustat&32768 > 0;
			boolean isAddrRepPOBox						:= prac_bill_ustat&65536 > 0;
			boolean isAddrRepUndeliverable		:= prac_bill_ustat&131072 > 0;
			boolean isAddrRepInvalid					:= prac_bill_ustat&262144 > 0;
			boolean isAddrAugOther						:= prac_bill_ustat&16777216 > 0;
			boolean isAddrAugHigh							:= prac_bill_ustat&67108864 > 0;
			boolean isAddrAugPhone						:= prac_bill_ustat&134217728 > 0;
			boolean isAddrAugFax							:= prac_bill_ustat&268435456 > 0;
			boolean isAddrAugHVInputState			:= prac_bill_ustat&536870912 > 0;
			boolean isAddrAugPVInputState			:= prac_bill_ustat&1073741824 > 0;
			
			string bill_addr_correction_key			:= '';
			integer prac_bill_conf_score				:= 50;
			string loop_indicator								:= 'BILLING';

			
			return map (
				isAddrRepHighRisk /*and bill1_st 16384*/ => Healthcare_Shared.Constants.cic_HCO_Bill_HighRisk_Prison, // 'H'
				
				/*bill1_st 4096 => Healthcare_Shared.Constants.cic_HCO_Bill_HighRisk_NPSR,*/ // 'N'
				
				(((isAddrCorTypo /*and bill1_secondary_range == bill_addr_correction_secondary_range*/ or (/*bill1_ace_stat_code not in ace_stats and*/ not isAddrRepPhoneInactive and 
					not isAddrRepHVInactive and bill_addr_correction_key != '' /*and bill1_secondary_range == bill1_addr_correction_secondary_range*/)) and bill_corr_conf_score >= 90) 
					and not isAddrRepPhoneInactive and not isAddrRepHVInactive) => Healthcare_Shared.Constants.cic_HCO_Bill_Typo_Correction, // 'C'
				
				isAddrRepPhoneInactive and isAddrRepHVInactive => Healthcare_Shared.Constants.cic_HCO_Bill_PV_HV_Inactive, // 'I'
				
				isAddrRepUndeliverable and (not isAddrCorTypo or (isAddrCorTypo /*and bill1_secondary_range != bill_addr_correction_secondary_range*/)) 
					=> Healthcare_Shared.Constants.cic_HCO_Bill_Undeliverable, // 'X'
					
				/*bill1_ace_stat_code not in ace_stats and*/ bill_addr_correction_key != '' and bill_corr_conf_score < 90 => Healthcare_Shared.Constants.cic_HCO_Bill_Standardization, // 'S'
				
				isAddrVerOtherPrac and isAddrVerOtherBill and isAddrVerMultOther and isAddrVerHigh and isAddrVerPhonePrac and isAddrVerPhoneBill and isAddrVerFaxPrac and 
					isAddrVerClmBill and not isAddrCorTypo and not isAddrRepPhoneInactive and not isAddrRepHVInactive and not isAddrRepHighRisk and not isAddrRepUndeliverable and 
					not isAddrRepInvalid => Healthcare_Shared.Constants.cic_HCO_Bill_Verified, // 'V'
					
				isAddrRepPOBox and loop_indicator = 'BILLING' => Healthcare_Shared.Constants.cic_HCO_Bill_POBox, // 'P'
				
				isAddrRepMissing and not isAddrCorTypo and isAddrAugPhone => Healthcare_Shared.Constants.cic_HCO_Bill_Missing_PV, // 'A'
				
				isAddrRepMissing and not isAddrCorTypo and not isAddrAugPhone => Healthcare_Shared.Constants.cic_HCO_Bill_Missing_NoPV, // 'M'
				
				not isAddrVerOtherPrac and not isAddrVerOtherBill and not isAddrVerMultOther and not isAddrVerHigh and not isAddrVerPhonePrac and not isAddrVerPhoneBill and not 
					isAddrVerFaxPrac and not isAddrVerClmBill and (not isAddrCorTypo or (isAddrCorTypo /*and bill1_secondary_range != bill_addr_correction_secondary_range*/)) and 
					isAddrAugPhone => Healthcare_Shared.Constants.cic_HCO_Bill_Unverified_PV, // '2'
			'');
	end;
	
	Export getPrac_Phone_cic() := Function
		return 0;
	end;
	Export getPrac_Fax_cic() := Function
		return 0;
	end;
End;