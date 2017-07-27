import iesp;
EXPORT IRS5500Section_layouts := module

	export rec_OptionsLayout := record
		boolean lnbranded;
		boolean internal_testing;
	end;
	
	export rec_input := record
		string25 acctno;
	  iesp.share.t_BusinessIdentity;
	end;	
	
	export rec_linkids_plus_IRS5500Detail := record
       iesp.share.t_BusinessIdentity;
			 iesp.TopBusinessReport.t_topbusinessIRS5500Record;
	end;
	
	export rec_IRS5500Record := record		
		string25 acctno;
		iesp.share.t_BusinessIdentity;
		iesp.TopBusinessReport.t_topbusinessIRS5500Record;		
	end;		
	
	export rec_linkids_plus_IRS5500Record := record
		string25 acctno;
	  iesp.share.t_BusinessIdentity;	
		iesp.TopbusinessReport.t_TopBusinessIRS5500Section;
		
	end;
	
	export rec_final := record
	  string25 acctno;
		iesp.topbusinessReport.t_TopBusinessIRS5500Section;
	end;
	
end;	