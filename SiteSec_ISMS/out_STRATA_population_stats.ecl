import STRATA, SiteSec_ISMS;

export out_STRATA_population_stats(string pversion) := function

  Base := SiteSec_ISMS.Files().Base.qa;	
	          
  strataLayout	:=	record
		layouts.base;
		string10 nogrouping := 'nogrouping';
  end;

  strataBase	:=	project(Base, TRANSFORM(strataLayout,SELF := LEFT;));
    	
  rPopulationStats_SiteSec_ISMS := record
    strataBase.nogrouping;  // field to group by --  all values are "nogrouping"  
    CountGroup 															:= count(group);		
		Date_FirstSeen_CountNonZero             := sum(group,if(strataBase.Date_FirstSeen<>0,1,0));		
  	Date_LastSeen_CountNonZero              := sum(group,if(strataBase.Date_LastSeen<>0,1,0));
    CertificationBodyDescrip_CountNonBlank  := sum(group,if(strataBase.CertificationBodyDescrip<>'',1,0));
    DartID_CountNonBlank                    := sum(group,if(strataBase.DartID<>'',1,0));
    DateAdded_CountNonZero                  := sum(group,if(strataBase.DateAdded<>0,1,0));
    DateUpdated_CountNonZero                := sum(group,if(strataBase.DateUpdated<>0,1,0));
    Website_CountNonBlank                   := sum(group,if(strataBase.Website<>'',1,0));
    Country_CountNonBlank                   := sum(group,if(strataBase.State<>'',1,0));
    BusinessName_CountNonBlank              := sum(group,if(strataBase.BusinessName<>'',1,0));
    BusinessLocation_CountNonBlank          := sum(group,if(strataBase.BusinessLocation<>'',1,0));
    BusinessDBA_CountNonBlank               := sum(group,if(strataBase.BusinessDBA<>'',1,0));
    CertificateNumber_CountNonBlank         := sum(group,if(strataBase.CertificateNumber<>'',1,0));
    CertificationBody_CountNonBlank         := sum(group,if(strataBase.CertificationBody<>'',1,0));
    CertificationType_CountNonBlank         := sum(group,if(strataBase.CertificationType<>'',1,0));
    ISMSScope_CountNonBlank                 := sum(group,if(strataBase.ISMSScope<>'',1,0));
  end;
	
dPopulationStats_SiteSec_ISMS := table(strataBase,rPopulationStats_SiteSec_ISMS,few);                                                               

STRATA.createXMLStats(dPopulationStats_SiteSec_ISMS,
            'SiteSec_ISMS','base',pversion,
						'',resultsOut,'view','population');
		 
 return resultsOut;
 
 end;