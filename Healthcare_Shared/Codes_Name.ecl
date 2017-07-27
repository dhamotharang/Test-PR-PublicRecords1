EXPORT Codes_Name := Module
	Export getName_USTAT(boolean SingleSource, boolean MultiSource,  boolean Transposed,  boolean Complete,
												boolean MatchNPIFKA, boolean MatchDEAFormer, boolean MatchNPIFormer) := Function
			ustat_single := IF(SingleSource,Healthcare_Shared.Constants.ustat_Name_1_Source,0);
			ustat_multi := IF(MultiSource,Healthcare_Shared.Constants.ustat_Name_Mulitple_Sources,0);
			ustat_Transposed := IF(Transposed,Healthcare_Shared.Constants.ustat_Name_Transposed,0);
			ustat_Complete := IF(Complete,Healthcare_Shared.Constants.ustat_Name_Complete,0);
			ustat_NpiFKA := IF(MatchNPIFKA,Healthcare_Shared.Constants.ustat_Name_Match_NPI_FKA,0);
			ustat_DeaFormer := IF(MatchDEAFormer,Healthcare_Shared.Constants.ustat_Name_Match_Last_DEA_Former,0);
			ustat_NpiFormer := IF(MatchNPIFormer,Healthcare_Shared.Constants.ustat_Name_Match_Last_NPI_Former,0);
			name_ustat := ustat_single + ustat_multi + ustat_Transposed + ustat_Complete + ustat_NpiFKA + ustat_DeaFormer + ustat_NpiFormer;
			return name_ustat;
	end;
	Export getName_CIC(boolean isMissing, boolean isNPIMissing, boolean hasCorrectionOrAug, boolean SingleSource, boolean MultiSource,  boolean Transposed,  boolean Complete,
												boolean MatchNPIFKA, boolean MatchDEAFormer, boolean MatchNPIFormer) := Function
		return map((MatchNPIFKA and MatchDEAFormer and MatchNPIFormer and not isNPIMissing) or 
								MatchDEAFormer  => Healthcare_Shared.Constants.cic_Name_MatchFKA,
								Transposed => Healthcare_Shared.Constants.cic_Name_Transposed,
								Complete and hasCorrectionOrAug => Healthcare_Shared.Constants.cic_Name_Correction,
								Complete and not hasCorrectionOrAug => Healthcare_Shared.Constants.cic_Name_NoAug,
								SingleSource or MultiSource and MatchNPIFKA and isNPIMissing => Healthcare_Shared.Constants.cic_Name_Verified,
								isMissing => Healthcare_Shared.Constants.cic_Name_MissingInput,
								not SingleSource and not MultiSource and not Transposed and not Complete and 
										not MatchNPIFKA and not MatchDEAFormer and not MatchNPIFormer  => Healthcare_Shared.Constants.cic_Name_Unknown,
						 '99');
	end;
End;