EXPORT Codes_Gender := Module
	Export getGender_USTAT(boolean IsMissing, boolean IsBadFormat, boolean VerifiedName, boolean VerifiedRef, boolean CorrectedName, boolean CorrectedRef, 
												boolean MisMatch) := Function
			ustat_missing := IF(IsMissing,Healthcare_Shared.Constants.ustat_Gender_Missing,0);
			ustat_badFormat := IF(IsBadFormat,Healthcare_Shared.Constants.ustat_Gender_BadFormat,0);
			ustat_verifiedName := IF(VerifiedName,Healthcare_Shared.Constants.ustat_Gender_Verified_Cleaner,0);
			ustat_verifiedRef := IF(VerifiedRef,Healthcare_Shared.Constants.ustat_Gender_Verified_Self_Rpt,0);
			ustat_correctedName := IF(CorrectedName,Healthcare_Shared.Constants.ustat_Gender_Corrected_Cleaner,0);
			ustat_correctedRef := IF(CorrectedRef,Healthcare_Shared.Constants.ustat_Gender_Corrected_Self_Rpt,0);
			ustat_mismatch := IF(MisMatch,Healthcare_Shared.Constants.ustat_Gender_Discrepancy,0);
			gender_ustat := ustat_missing + ustat_badFormat + ustat_verifiedName + ustat_verifiedRef + ustat_correctedName + ustat_correctedRef;
			return gender_ustat;
	end;
	Export getGender_CIC(boolean IsMissing, boolean IsBadFormat, boolean Verified, boolean CorrectedRef, boolean CorrectedName, string1 bestNameGender, string1 correctionGender) := Function
		nameConflist := (bestNameGender='M' and correctionGender='F') or (bestNameGender='F' and correctionGender='M');
		return map(Verified => Healthcare_Shared.Constants.cic_Gender_Verified,
							 CorrectedRef and not IsMissing and not IsBadFormat and not nameConflist => Healthcare_Shared.Constants.cic_Gender_Correction_Conflict,
							 CorrectedName and not IsMissing and not IsBadFormat => Healthcare_Shared.Constants.cic_Gender_Correction,
							 IsBadFormat and (CorrectedRef or CorrectedName) and not nameConflist => Healthcare_Shared.Constants.cic_Gender_Auth_Found_BadInput,
							 (IsBadFormat and not CorrectedRef and not CorrectedName) or (IsBadFormat and CorrectedRef and nameConflist) => Healthcare_Shared.Constants.cic_Gender_NoAuth_BadInput,
							 (not Verified and not IsMissing and not CorrectedName and not CorrectedRef) or (CorrectedRef and not IsMissing and not IsBadFormat and nameConflist) => '',
							 IsMissing and correctionGender<>'' and (CorrectedName or CorrectedRef) and not nameConflist => Healthcare_Shared.Constants.cic_Gender_Auth_Aug_NoInput,
							 (IsMissing and not CorrectedRef and not CorrectedName) or (IsMissing and CorrectedRef and nameConflist) => Healthcare_Shared.Constants.cic_Gender_NoAuth_MissingInput,
							 '');
	end;
End;