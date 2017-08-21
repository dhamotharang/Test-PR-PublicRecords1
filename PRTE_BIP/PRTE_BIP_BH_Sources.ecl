IMPORT PRTE_BIP;

export PRTE_BIP_BH_Sources :=	prte_bip.PRTE_BusReg_As_Business_Linking(false).Busreg
                            + prte_bip.PRTE_FAA_Aircraft_Reg_As_Business_Linking;
															
														/* prte_bip.PRTE_Bankruptv2_As_Business_Linking
                              + prte_bip.PRTE_Corp2_As_Business_Linking()
															+ prte_bip.PRTE_DCAv2_as_Business_linking()
															+ prte_bip.PRTE_DEA_As_Business_Linking
															+ prte_bip.PRTE_DNB_DMI_As_Business_Linking()
															+ prte_bip.PRTE_EBR_As_Business_Linking	
	                            + prte_bip.PRTE_Gong_v2_As_Business_Linking()
															+ prte_bip.PRTE_IRS5500_As_Business_Linking
															+ prte_bip.PRTE_LiensV2_As_Business_Linking()
															+ prte_bip.PRTE_LN_PropertyV2_as_Business_Linking()
															+ prte_bip.PRTE_Prof_LicenseV2_As_Business_Linking()
															+ prte_bip.PRTE_UCCV2_As_Business_Linking()
															+ prte_bip.PRTE_VehicleV2_As_Business_Linking
															+ prte_bip.PRTE_Watercraft_as_Business_Linking */
