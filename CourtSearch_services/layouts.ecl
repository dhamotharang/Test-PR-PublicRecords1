import CourtSearch_services, iesp, doxie, header;

export layouts := module

	export rawRecPlusExtraDeathInfo := record(doxie.Layout_presentation)	

			string5   Valid;
			string32  IssuedLocation;
			string6   IssuedStartDate;
			string6   IssuedEndDate;
			
	    integer   Age;
			integer   AgeAtDeath;
			string2   DeathState;
			string18  DeathCounty;
			string1   DeathVerificationCode;			
			boolean   isDeepDive := false;
		  unsigned2 _penalty;
	end;
	
	export ssnInfo := record
	
	    string11  ssn;
			string30  IssuedLocation;
			unsigned4 IssuedStartDate;
			unsigned4 IssuedEndDate;
	end;
    
	export headerLayoutPlusCourtSearch := record(Header.Layout_Header)
	  
		string10 stCode; 
		string70 stDescription;
		string70 stSummaryDescription;
		real stPrice;
		real stSurcharge;
		string20 stCompleteDays;
		string10 stFipsCode;
		
		string7 CoCode; 
		string70 CoDescription; 
		string70 CoSummaryDescription;
		real CoPrice;
		string20 CoCompleteDays; 
		string30 CoName; 
		string7 CoFipsCode;
		real CoSurcharge;
		string2 DiCode; 
		string70 DiName; 
		string7 DiFipsCode; 
		
	end;
	
	export CourtSearchAdvisorRecordWithPenalty := record
	   recordof(iesp.courtSearchAdviser.t_courtSearchAdviserRecord);
		 //unsigned2 _penalt :=0;
		 boolean isDeepDive := false;
  end;		 
	
	export t_stateCountyExtra := record
	  recordof(iesp.courtSearchAdviser.t_StateCounty);
	  string25 st;
		string3  county;
	end;
	
	export t_stateDistrictExtra := record
	   recordof(iesp.CourtSearchAdviser.t_stateDistrict);
		 string25 st;
		 string3  county;
	end;
	
	export t_searchInfoExExtra := record  
	  recordof(iesp.courtsearchadviser.t_CSSearchInfoEx);
		string2  st;
	end;
	
	export t_CourtSearchCountyExtra := record
		string10 Code; 
		string10 _Type; 
		string70 Description;
		string70 SummaryDescription;
		real Price; 
		real Surcharge;
		real CivilSurcharge;
		string10 CompleteDays;
		string5 jurisdiction;
		string2 st;
end;

  export layout_header_extra := record
	  header.Layout_Header;
		string120 Company_name;
		unsigned6  bdid;
		string32 fein :=''; // Federal Tax ID
	end;
	
end;