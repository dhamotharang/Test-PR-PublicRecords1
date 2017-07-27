export BranchReport_Layouts := module

	// export Input := record
		// HeaderSection_Layouts.Input;
	// end;
	
	export BestSection := record
		BestSection_Layouts.Final - [acctno];
	end;

	export ContactSection := record
		ContactSection_Layouts.rec_Final - [acctno];
	end;

	export InCorporationSection := record
	  IncorporationSection_Layouts.rec_Final - [acctno];
  end;	

	export OperationsSitesSection := record
	  OperationsSitesSection_Layouts.rec_Final - [acctno];
  end;	

	export FinanceSection := record
	  FinanceSection_Layouts.rec_Final - [acctno];
  end;		
	
	export ParentSection := record
		ParentSection_Layouts.rec_Final - [acctno];
	end;

	export IndustrySection := record
	  IndustrySection_Layouts.rec_Final - [acctno];
  end;		
	
	export LicenseSection := record
	   LicenseSection_layouts.rec_final - acctno;
  end;

	export URLSection := record
		URLSection_Layouts.rec_Final - [acctno];
	end;

	export BankruptcySection := record
	   BankruptcySection_layouts.rec_final - acctno;
  end;

	export LienSection := record
	  LienSection_Layouts.rec_Final - [acctno];		
	end;

	export uccSection := record
	  UccSection_Layouts.rec_Final - [acctno];		
	end;
	
	export PropertySection := record
	   PropertySection_layouts.rec_final - acctno;
  end;

	export AircraftSection := record
	  AircraftSection_Layouts.rec_Final - [acctno];		
	end;

	export MotorVehicleSection := record
	 MotorVehicleSection_Layouts.rec_Final - [acctno];		
	end;	
	
	export WatercraftSection := record
	  WatercraftSection_Layouts.rec_Final - [acctno];		
	end;
	
	export RegisteredAgentSection := record
	   RegisteredAgentSection_layouts.rec_final - acctno;
  end;

	export ConnectedBusinessSection := record
	   ConnectedBusinessSection_layouts.rec_final - acctno;
	end;

	export AssociateSection := record
		AssociateSection_Layouts.rec_Final - [acctno];
	end;

  export IRS5500Section := record
		IRS5500Section_Layouts.rec_Final - [acctno];
	end;
	
	export BusinessRegistrationSection := record
		BusinessRegistrationSection_Layouts.rec_Final - [acctno];
	end;

 	export CompanyVerificationSection := record
		CompanyVerificationSection_Layouts.rec_Final - [acctno];
	end;
	
	export SanctionSection := record
	  SanctionSection_layouts.rec_final - acctno;
	end;
	
	export DunBradStreetSection := record
	  DNBSection_Layouts.rec_final - acctno;
	end;
	
	 export ExperianBusinessReportSection := record
	   EBRSection_Layouts.rec_final - acctno;
	 end;
	 
	export SourceSection := record
	  SourceSection_layouts.rec_final - acctno;
  end;
	
	export Final := record
		string25 acctno;
		BestSection bestSection;
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
