import  ut, riskwise;

EXPORT IndGetPersonalNetwKRI (  DATASET(Layouts.RelatLayoutV2) RelatsIn ) := FUNCTION



Layouts.RelatLayoutV2  getPersonalNetwKRI(RelatsIn le)  := TRANSFORM
	self.seq    := le.seq ;
	self.historydate := le.historydate;
	self.origdid  := le.origdid;
	self.subjectdid  := le.subjectdid;
	self.relatDID  := le.relatdid;
	self.isrelat  := le.isrelat;
  HDRFirstSeenMnths := round((ut.DaysApart((string)le.HdrFirstSeenDate, (string)le.historydate )) / 30);
	self.IndPersonalKRI  := Map(
															le.CurrIncarcer  																																								=> '9',
															le.potentialSO   							  																																=> '8',
														  le.CurrParole																																										=> '7',
															le.FelonyCount3yr  > 0																																					=> '6',
															le.EverIncarcer																																									=> '5',	
                              HDRFirstSeenMnths <= 12 	and le.HdrFirstSeenDate <> 0														
																 and (~le.validSSN  or 	((integer)le.socllowissue > (integer)le.dob)	
																 or (le.SSNMultiIdentites > 2) or	(le.SSNPerADL > 1) or le.NoSSN)													=> '4',
                              HDRFirstSeenMnths <= 12 		and le.HdrFirstSeenDate <> 0														
																 and (~le.validSSN  or 	((integer)le.socllowissue > (integer)le.dob)	
																 or (le.SSNMultiIdentites > 2) or	(le.SSNPerADL > 1) or le.NoSSN)													=> '3',	  //   should never get a 3,  4 and 3 are the same and they should be
                              HDRFirstSeenMnths > 12 	and le.HdrFirstSeenDate <> 0															
																 and (~le.validSSN  or 	((integer)le.socllowissue > (integer)le.dob)	
																 or (le.SSNMultiIdentites > 2) or	(le.SSNPerADL > 1) or le.NoSSN)													=> '2',
														'1'	);
	self := le;
END;

addPersonalNetwKRI := project(	RelatsIn, getPersonalNetwKRI(left));

RETURN 	addPersonalNetwKRI;																			

END;