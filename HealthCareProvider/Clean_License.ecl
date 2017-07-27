EXPORT Clean_License (string25 lic) := function
	isBadLic := LIC IN HealthCareProvider.Constants.Bogus_LIC;
	Lic_without_leading_zeros := REGEXREPLACE ('^[0]*',TRIM(LIC,LEFT,RIGHT),'');
	Clean_Lic := TRIM(((STRING25)((STRING25)(UNSIGNED8)REGEXREPLACE('[^0-9]', Lic_without_leading_zeros, ''))),ALL);	
	RETURN IF (Clean_LIC = '0' or isBadLic,'',Clean_LIC);
end;