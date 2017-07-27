EXPORT Codes_NPI := Module
	Export getNPI_USTAT(boolean IsMissing, boolean IsBad, integer NPIType, boolean isInvalid, boolean isFKA, boolean isDeactivated,
											boolean NPIVerified, Boolean Aug_Avail, boolean Other_Person, boolean CompanionData) := Function
			ustat_missing := IF(IsMissing,Healthcare_Shared.Constants.ustat_NPI_Missing,0);
			ustat_badFormat := IF(IsBad,Healthcare_Shared.Constants.ustat_NPI_BadFormat,0);
			ustat_type1 := IF(NPIType = 1,Healthcare_Shared.Constants.ustat_NPI_Type1,0); // Not in Constants 
			ustat_type2 := IF(NPIType = 2,Healthcare_Shared.Constants.ustat_NPI_Type2,0);
			ustat_invalid := IF(isInvalid AND NOT IsMissing,Healthcare_Shared.Constants.ustat_NPI_Invalid,0);
			ustat_fka := map( NPIType = 1 and isFKA => Healthcare_Shared.Constants.ustat_Name_Match_NPI_FKA ,
												NPIType = 2 and isFKA => Healthcare_Shared.Constants.ustat_Company_Rep_Fka, 0);
			ustat_deactivated := IF(isDeactivated,Healthcare_Shared.Constants.ustat_NPI_DeActivated,0);
			ustat_verified := IF(NPIVerified,Healthcare_Shared.Constants.ustat_NPI_Verified,0);
			ustat_aug_avail := IF(Aug_Avail,Healthcare_Shared.Constants.ustat_NPI_AugAuthSource,0);
			ustat_other_person := IF(Other_Person,Healthcare_Shared.Constants.ustat_NPI_SomeoneElse,0);
			ustat_companion := IF(CompanionData,Healthcare_Shared.Constants.ustat_NPI_CompanionData,0);
			npi_ustat := (ustat_missing + ustat_badFormat + ustat_type1 + ustat_type2 + ustat_invalid + ustat_fka + ustat_deactivated +
										ustat_verified + ustat_aug_avail + ustat_other_person + ustat_companion);
			return npi_ustat;
	end;
	Export getNPI_CIC	(boolean IsMissing, boolean IsBad, integer NPIType, boolean isInvalid, boolean isFKA, boolean isDeactivated,
											boolean NPIVerified, Boolean Aug_Avail, boolean Other_Person) := Function
		return map(	isDeactivated and NOT Aug_Avail => Healthcare_Shared.Constants.cic_NPI_Deactivated_NoAug,
									(isMissing or IsBad or NOT NPIVerified) and (NPIType = 2) and isDeactivated and NOT Aug_Avail => Healthcare_Shared.Constants.cic_NPI_Missing_Deactivated_NoAug, 
									isDeactivated and Aug_Avail => Healthcare_Shared.Constants.cic_NPI_Deactivated_Aug,
									NPIVerified and NOT isDeactivated => Healthcare_Shared.Constants.cic_NPI_Verified,
									isMissing and Aug_Avail => Healthcare_Shared.Constants.cic_NPI_Missing_Aug,
									Other_Person and Aug_Avail => Healthcare_Shared.Constants.cic_NPI_SomeoneElse_Aug,
									isInvalid and Aug_Avail => Healthcare_Shared.Constants.cic_NPI_Not_Found_Aug,
									isInvalid and NOT Aug_Avail => Healthcare_Shared.Constants.cic_NPI_Not_Found_NoAug,
									Aug_Avail and NPIType = 1 and NOT isInvalid and NOT isMissing and NOT IsBad and NOT isDeactivated and
										NOT	Other_Person and NOT isFKA => Healthcare_Shared.Constants.cic_NPI_Type_1_Aug,	
									NPIVerified and NOT Aug_Avail and (NPIType = 2) => Healthcare_Shared.Constants.cic_NPI_Type_2_NoAug,
									Aug_Avail and NPIType <> 2 and NOT isInvalid and NOT isMissing and NOT isBad and NOT isDeactivated and 
										NOT Other_Person and NOT isFKA => Healthcare_Shared.Constants.cic_NPI_Not_Verified_Aug,
									IsBad and Aug_Avail => Healthcare_Shared.Constants.cic_NPI_BadInput_Aug,
									IsBad and NOT Aug_Avail => Healthcare_Shared.Constants.cic_NPI_BadInput_NoAug,
									isMissing and NOT Aug_Avail => Healthcare_Shared.Constants.cic_NPI_Missing_NoAug,
									'');
	end;
	// NPI Verify Stat Values  - NPI Verify Statistics (npi_verify_st) - Calculated at run time
  // for Every NPI (NPIs collection) from search service results.
  // static const unsigned   NotConfigured      =       1;              // was not configured
  // static const unsigned   Missing            =       2;              // was configured but input was blank
  // static const unsigned   BadFormat          =       4;              // value provided was invalid, details may be provided in higher order bits
  // static const unsigned   InvalidDate        =       8;    					 // n/a value did not contain a valid date (deactivation date - cleaned at data load)
  // static const unsigned   Type1              =      16;
  // static const unsigned   Type2              =      32;
  // static const unsigned   SoleProprietor     =      64;
  // static const unsigned   PhysicianMatch     =     128;
  // static const unsigned   PracCompanyMatch   =     256;
  // static const unsigned   BillCompanyMatch   =     512;
  // static const unsigned   PracAddressMatch   =    1024;
  // static const unsigned   BillAddressMatch   =    2048;
  // static const unsigned   Name               =    4096;
  // static const unsigned   OtherName          =    8192;
  // static const unsigned   AuthorityName      =   16384;
  // static const unsigned   OrgName            =   32768;
  // static const unsigned   OtherOrgName       =   65536;
  // static const unsigned   ParentOrgLBName    =  131072;
  // static const unsigned   PracAddress        =  262144;
  // static const unsigned   BillAddress        =  524288;
  // static const unsigned   Deactivated        = 1048576;

	Export getNPI_STATS(Integer npi_type, boolean isMissing, boolean isBadFormat, boolean isInvalid,boolean PhysicianMatch,boolean NameMatch,boolean OtherNameMatch,
														boolean CompanyMatch,boolean BillCompanyMatch,boolean CompanyAddrMatch,
														boolean BillCompanyAddrMatch,boolean NPICompanyAddr,boolean NPIBillCompanyAddr,boolean Sole_Proprietor,
														boolean isDeactivated,boolean AuthorityNameMatch,boolean OtherOrgNameMatch,
														boolean ParentOrgLBNameMatch) := Function
		//NPI Type I and II
		Npi_type_st := if (npi_type = -1, Healthcare_Shared.Constants.stat_NPIVerif_Type1,Healthcare_Shared.Constants.stat_NPIVerif_Type2); 
		Missing_st := IF(isMissing,Healthcare_Shared.Constants.stat_NPIVerif_Missing,0);
		BadFormat_st := IF(isBadFormat,Healthcare_Shared.Constants.stat_NPIVerif_BadFormat,0);
		Invalid_st := IF(isInvalid,Healthcare_Shared.Constants.stat_NPIVerif_Invalid,0);    // what date ?
		PhysicianMatch_st := IF(PhysicianMatch,Healthcare_Shared.Constants.stat_NPIVerif_PhysicianMatch,0);
		NameMatch_st := IF(NameMatch,Healthcare_Shared.Constants.stat_NPIVerif_Name,0);
		OtherNameMatch_st := IF(OtherNameMatch,Healthcare_Shared.Constants.stat_NPIVerif_OtherName,0);
		CompanyMatch_st := IF(CompanyMatch,Healthcare_Shared.Constants.stat_NPIVerif_PracCompanyMatch,0);
		BillCompanyMatch_st := IF(BillCompanyMatch,Healthcare_Shared.Constants.stat_NPIVerif_BillCompanyMatch,0);
		//CompanyAddrMatch 		 => UI CompanyPracAddress matched NPI CompanyPracAddress
		//BillCompanyAddrMatch => UI Bill Company Address matched NPI BillCoAddress
		CompanyAddrMatch_st := IF(CompanyAddrMatch,Healthcare_Shared.Constants.stat_NPIVerif_PracAddressMatch,0);
		BillCompanyAddrMatch_st := IF(BillCompanyAddrMatch,Healthcare_Shared.Constants.stat_NPIVerif_BillAddressMatch,0);
		//PracAddress => NPI CompanyPracAddress matched UI BillCOAddress
		//BillAddress => NPI BillCoAddress matched UI CompanyPracAddress
		NPICompanyAddr_st := IF(NPICompanyAddr,Healthcare_Shared.Constants.stat_NPIVerif_PracAddress,0);
		NPIBillCompanyAddr_st := IF(NPIBillCompanyAddr,Healthcare_Shared.Constants.stat_NPIVerif_BillAddress,0);
		Sole_Proprietor_st := IF(Sole_Proprietor,Healthcare_Shared.Constants.stat_NPIVerif_SoleProprietor,0);
		Deactivated_st := IF(isDeactivated,Healthcare_Shared.Constants.stat_NPIVerif_Deactivated,0);
		//NPI Type II only
		AuthorityNameMatch_st := IF(AuthorityNameMatch,Healthcare_Shared.Constants.stat_NPIVerif_AuthorityName,0);
		OtherOrgNameMatch_st := IF(OtherOrgNameMatch,Healthcare_Shared.Constants.stat_NPIVerif_OtherOrgName,0);
		ParentOrgLBNameMatch_st := IF(ParentOrgLBNameMatch,Healthcare_Shared.Constants.stat_NPIVerif_ParentOrgLBName,0);
									
		npi_verify_st := Npi_type_st + Missing_st + BadFormat_st + Invalid_st + PhysicianMatch_st + NameMatch_st + OtherNameMatch_st +
									CompanyMatch_st + BillCompanyMatch_st + CompanyAddrMatch_st + BillCompanyAddrMatch_st + 
									NPICompanyAddr_st + NPIBillCompanyAddr_st + Sole_Proprietor_st + Deactivated_st + AuthorityNameMatch_st +
									OtherOrgNameMatch_st + ParentOrgLBNameMatch_st;
		return npi_verify_st;
	end;
End;