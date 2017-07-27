import iesp;
export ConnectedBusinessSection_Layouts := module

	export rec_OptionsLayout := record
		boolean lnbranded;
		boolean internal_testing;
		string1 businessReportFetchLevel;
		boolean restrictexperian := false;
	end;
	
	export rec_Input := record
		string25 acctno;
		iesp.share.t_BusinessIdentity;
	end;

  export rec_linkids_plus_ConnectedBusinessRecord	:= record
	  unsigned6 in_ultid; // need to join back to original acctno
	  unsigned6 in_orgid; // need to join back to original acctno
	  unsigned6 in_seleid;// need to join back to original acctno
		unsigned6 in_proxid;// need to join back to original acctno
		iesp.share.t_businessIdentity;
		iesp.TopBusinessReport.t_TopBusinessConnectedBusiness;
  end;		
	
	export rec_linkidsIntermediate := record
	  unsigned6 in_ultid; 
	  unsigned6 in_orgid; 
	  unsigned6 in_seleid;
		unsigned6 in_proxid;
		
		string25  acctno;
		iesp.topBusinessReport.t_TopBusinessConnectedBusinessSection;
	end;

  export rec_final := record
	     string25 acctno;			 
		   iesp.topBusinessReport.t_TopBusinessConnectedBusinessSection;
	end;
	
end;