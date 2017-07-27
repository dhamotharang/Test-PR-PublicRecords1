import iesp;

EXPORT CompanyVerificationSection_Layouts := module
	export rec_input := record
		string25 acctno;
	  iesp.share.t_BusinessIdentity;
	end;	
	
	export rec_OptionsLayout := record
		boolean lnbranded;
		boolean internal_testing;
	end;
	
	export rec_CompanyVerification_recordWLinkids := record
    iesp.share.t_businessIdentity;
	  iesp.topbusinessREport.t_TopBusinessCompanyVerificationSection;
	end;	

	export rec_linkids_plus_CompanyVerificationRecord := record
	  string30 acctno;
    iesp.share.t_businessIdentity;
    iesp.TopbusinessReport.t_TopBusinessCompanyVerificationSection;
	end;

	export rec_final := record
    string25 acctno;
    iesp.topbusinessREport.t_TopBusinessCompanyVerificationSection;
	end;
end; // module