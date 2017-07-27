import Healthcare_Provider_Services,NCPDP;
EXPORT NCPDP_Layouts := Module

	Export NCPDP_providerid_rec := RECORD
			string20 acctno := '';
			STRING10 NCPDP_providerid;
			boolean isAutokeysResult := false;
			boolean isLicMatch := false;
			boolean isDEAMatch := false;
			boolean isNPIMatch := false;
			boolean isFEINMatch := false;
			boolean isDIDMatch := false;
			boolean isBDIDMatch := false;
			boolean isProviderIDMatch := false;
	END;

	export autokeyInput := record
	    Healthcare_Provider_Services.Layouts.autokeyInput_base-[name_first,name_middle,name_last,name_suffix,ssn,dob,homephone,ncpdpnumber,
																															workphone,dl,dlstate,vin,Plate,PlateState,searchType,max_results,score,MatchCode,
																															date,sic_code,filing_number,apn,fips_code,score_bdid,UPIN,CLIANumber,TAXID,ProviderID,ProviderSrc,CustomerID];
			STRING20 NCPDP_ProviderID;
	end;

	Export AKLayoutOutput := Record
			NCPDP.Layouts.Slim_Autokey_All;
	end;
	Export AKLayoutOutputDBA := Record
			NCPDP.Layouts.Slim_Autokey_Business;
	end;

	Export LayoutOutput := Record
			string20 acctno := '';
			unsigned2 record_penalty := 0;
			unsigned2 compName_penalty := 0;
			unsigned2 dbaName_penalty := 0;
			unsigned2 locAddr_penalty := 0;
			unsigned2 mailAddr_penalty := 0;
			unsigned2 lic_penalty := 0;
			boolean isAutokeysResult := false;
			boolean isLicMatch := false;
			boolean isDEAMatch := false;
			boolean isNPI := false;
			boolean isFEINMatch := false;
			boolean isDIDMatch := false;
			boolean isBDIDMatch := false;
			boolean isProviderIDMatch := false;
			NCPDP.Layouts.Keybuild;

	end;

	Export LayoutOutputBatch := Record
			LayoutOutput;
	end;
End;