import iesp;

EXPORT SanctionSection_Layouts := module
	export rec_input := record
		string25 acctno;
	  iesp.share.t_BusinessIdentity;
	end;	
	
	export rec_OptionsLayout := record
		boolean lnbranded;
		boolean internal_testing;
	end;
	
	export rec_Sanction_recordWLinkids := record
    iesp.share.t_businessIdentity;
	  iesp.topbusinessReport.t_TopBusinessSanctionRecord; // new structure
	end;	

	export rec_linkids_plus_SanctionRecord := record
	  string30 acctno;
    iesp.share.t_businessIdentity;
    iesp.TopbusinessReport.t_TopBusinessSanctionSection; // now contains a datatset of 
                                               // this: iesp.topbusinessReport.t_TopBusinessSanctionRecord
	end;

	export rec_final := record
    string25 acctno;
    iesp.topbusinessReport.t_TopBusinessSanctionSection;
	end;
end; // module