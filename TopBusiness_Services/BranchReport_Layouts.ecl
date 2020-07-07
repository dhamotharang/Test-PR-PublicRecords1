import TopBusiness_services, iesp, bipv2;
export BranchReport_Layouts := module

	// export Input := record
		// HeaderSection_Layouts.Input;
	// end;
	
	export BestSection := record
		TopBusiness_services.BestSection_Layouts.Final - [acctno];
	end;
  
  export BusinessInsightSection := record
           BIPV2.IDlayouts.l_key_ids_bare - [proxid, powid, empid, dotid];
           iesp.TopBusinessReport.t_TopBusinessBusinessInsightSection;
	end;

	export ContactSection := record
		TopBusiness_services.ContactSection_Layouts.rec_Final - [acctno];
	end;

	export InCorporationSection := record
	  TopBusiness_services.IncorporationSection_Layouts.rec_Final - [acctno];
  end;	

	export OperationsSitesSection := record
	  TopBusiness_services.OperationsSitesSection_Layouts.rec_Final - [acctno];
  end;	

	export FinanceSection := record
	  TopBusiness_services.FinanceSection_Layouts.rec_Final - [acctno];
  end;		
	
	export ParentSection := record
		TopBusiness_services.ParentSection_Layouts.rec_Final - [acctno];
	end;

	export IndustrySection := record
	  TopBusiness_services.IndustrySection_Layouts.rec_Final - [acctno];
  end;		
	
	export LicenseSection := record
	   TopBusiness_services.LicenseSection_layouts.rec_final - acctno;
  end;

	export URLSection := record
		TopBusiness_services.URLSection_Layouts.rec_Final - [acctno];
	end;

	export BankruptcySection := record
	   TopBusiness_services.BankruptcySection_layouts.rec_final - acctno;
  end;

	export LienSection := record
	  TopBusiness_services.LienSection_Layouts.rec_Final - [acctno];		
	end;

	export uccSection := record
	  TopBusiness_services.UccSection_Layouts.rec_Final - [acctno];		
	end;
	
	export PropertySection := record
	   TopBusiness_services.PropertySection_layouts.rec_final - acctno;
  end;

	export AircraftSection := record
	  TopBusiness_services.AircraftSection_Layouts.rec_Final - [acctno];		
	end;

	export MotorVehicleSection := record
	    TopBusiness_services.MotorVehicleSection_Layouts.rec_Final - [acctno];		
	end;	
	
	export WatercraftSection := record
	    TopBusiness_services.WatercraftSection_Layouts.rec_Final - [acctno];		
	end;
	
	export RegisteredAgentSection := record
	   TopBusiness_services.RegisteredAgentSection_layouts.rec_final - acctno;
     end;

	export ConnectedBusinessSection := record
	    TopBusiness_services.ConnectedBusinessSection_layouts.rec_final - acctno;
	end;

	export AssociateSection := record
		TopBusiness_services.AssociateSection_Layouts.rec_Final - [acctno];
	end;

  export IRS5500Section := record
		TopBusiness_services.IRS5500Section_Layouts.rec_Final - [acctno];
	end;
	
	export BusinessRegistrationSection := record
		TopBusiness_services.BusinessRegistrationSection_Layouts.rec_Final - [acctno];
	end;

 	export CompanyVerificationSection := record
		TopBusiness_services.CompanyVerificationSection_Layouts.rec_Final - [acctno];
	end;
	
	export SanctionSection := record
	    TopBusiness_services.SanctionSection_layouts.rec_final - acctno;
	end;
	
	export DunBradStreetSection := record
	    TopBusiness_services.DNBSection_Layouts.rec_final - acctno;
	end;
	
	 export ExperianBusinessReportSection := record
	     TopBusiness_services.EBRSection_Layouts.rec_final - acctno;
	 end;
	 
	export SourceSection := record
	     TopBusiness_services.SourceSection_layouts.rec_final - acctno;
      end;
	
	export Final := record
		string25 acctno;
		BestSection bestSection;
           BusinessInsightSection businessInsightSection;
		ContactSection contactSection;
		InCorporationSection incorporationSection;
		OperationsSitesSection operationsSitesSection;
		FinanceSection financeSection;
		ParentSection parentSection;	
		IndustrySection industrySection;
		LicenseSection licenseSection;
		URLSection urlSection;
	  BankruptcySection bankruptcySection;	  
		LienSection lienSection;	
	  UCCSection uccSection;
		PropertySection propertySection;
		AircraftSection aircraftSection;		
		MotorVehicleSection motorvehicleSection;
	  WaterCraftSection watercraftSection;
		RegisteredAgentSection registeredAgentSection;
		ConnectedBusinessSection connectedBusinessSection;
		AssociateSection associateSection;
		IRS5500Section irs5500Section;
		BusinessRegistrationSection businessRegistrationSection;
		CompanyVerificationSection CompanyVerificationSection;		
		DunBradStreetSection dunBradStreetSection;		
		ExperianBusinessReportSection   experianBusinessReportSection;
		SanctionSection sanctionSection;
		SourceSection sourceSection;           
	end;
	
end;
