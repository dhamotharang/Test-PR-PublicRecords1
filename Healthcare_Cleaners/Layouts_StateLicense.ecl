EXPORT Layouts_StateLicense := MODULE
	export LayoutLicenseBatchCommon := record
		String100 	LicenseNumber := '';
		String2			LicenseState := '';
		String10		LicenseType := '';
	end;
	export LayoutLicenseClean := record
		LayoutLicenseBatchCommon;
			end;
	export LayoutLicenseBatchIn := record
		String20	 	acctno := '';
		LayoutLicenseBatchCommon;
	end;
	export LayoutLicenseBatchOut := record
		String20	 	acctno := '';
		LayoutLicenseBatchCommon Raw;
		LayoutLicenseClean;
	end;
End;