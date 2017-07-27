import iesp, TopBusiness_Services;

export URLSection_Layouts := module

	export OptionsLayout := record
		boolean lnbranded;
		boolean internal_testing;
	end;
	
	export Input := record
		string25 acctno;
		iesp.share.t_BusinessIdentity;
	end;
	
	export URLRecord := record
		string80 url;		
	end;
	
	export URLRecord_plusLinkids := record
	   iesp.share.t_BusinessIdentity;
	   URLRecord;
		 string80 cleanurl;
		 TopBusiness_Services.Layouts.rec_common.source;
		 TopBusiness_Services.Layouts.rec_common.source_docid;
	end;
	
	export rec_URLRecord_plusdetails := record
	   iesp.share.t_BusinessIdentity;
	   iesp.topbusinessReport.t_topBusinessURLSection;
	end;
	
	
	export rec_Final := record
		string25 acctno;		
		iesp.topbusinessReport.t_topBusinessURLSection;
	end;

end;
