import  ut, riskwise;

EXPORT GetRelatResidencyKRI (  DATASET(Layouts.RelatLayoutV2) RelatsIn ) := FUNCTION

//version 2
relatsSlimLayout := RECORD
  unsigned4 seq;
	UNSIGNED3 historydate;
	unsigned6 origdid;
	unsigned6 subjectdid;
	unsigned6 relatDID;
	string8  dob := 0;
	boolean   isrelat;
	STRING20  Relatfname;
	STRING20  Relatlname;
	STRING20  relation;  // relation from relatDID to SubjectDID
	integer  	RelatDegree;
	boolean     NoSSN  := false;
	unsigned3   SSNPerADL := 0;
	unsigned2   SSNMultiIdentites;
	boolean     validSSN;
	boolean     EverITIN;
	boolean     EverNon_US_SSN;
	boolean     VoterSrc;
	boolean     IsVoter;
	unsigned4   HdrFirstSeenDate;
	unsigned4   ParentLowIssueDt;
	boolean     AssocParentCnt;
	boolean     ParentValidSSN;
	boolean     ParentNoSSN;
	boolean     ParentHasITIN;
	boolean     ParentNONUSSSN;
	boolean     ParentVoter;
	string2     ResidencyRisk;
	
END;


RelatSlimSort := sort(project(RelatsIn, transform(relatsSlimLayout, 

											self := left)),seq, origdid, subjectdid);





Layouts.RelatLayoutV2  CitizenKRI(RelatsIn le)  := TRANSFORM
	self.seq    := le.seq ;
	self.historydate := le.historydate;
	self.origdid  := le.origdid;
	self.subjectdid  := le.subjectdid;
	self.relatDID  := le.relatdid;
	self.isrelat  := le.isrelat;
	daysDOBHdr1stSeen := ut.DaysApart((string)le.dob, (string)le.HdrFirstSeenDate + '01');
	self.ResidencyRisk := Map(
																			((integer)le.dob <> 0 and le.HdrFirstSeenDate <> 999999) and
																				daysDOBHdr1stSeen >= ut.DaysInNYears(24)  
																				and  (~le.validSSN or  (le.NoSSN and ~le.EverITIN ))														=> '9', 
																				((integer)le.dob <> 0 and	le.HdrFirstSeenDate <> 999999)	and											
																				daysDOBHdr1stSeen < ut.DaysInNYears(24) 
																					and  (~le.validSSN  or  (le.NoSSN and ~le.EverITIN))   							  				=> '8',
																				le.EverITIN  or  	le.EverNon_US_SSN																								=> '7',

																					le.assocparentcnt > 0 and (le.ParentHasITIN or 	le.ParentNONUSSSN )						=> '6',
																			 (le.AssocParentCnt > 0 and le.ParentLowIssueDt <> 0 and
																				(integer)le.dob <> 0 and (unsigned4)le.dob < le.ParentLowIssueDt)		  				=> '5',
																			  le.assocparentcnt = 0 or 
																				((le.assocparentcnt > 0 and le.ParentNoSSN	and ~le.ParentHasITIN ) or 
																					le.ParentHasITIN or le.EverITIN )	 and le.validSSN															=> '4',
																				le.validSSN and (~le.isVoter or(~le.VoterSrc and ~le.isVoter))	 								=> '3',
																				
																				(le.isVoter or(~le.ParentVoterSrc and ~le.ParentVoter))												=> '2',
																				le.ParentVoter and le.isVoter	 																										=> '1',
																				'0');

	self := le;
END;

getCitizenKRI := project(	RelatsIn, CitizenKRI(left));




// output(RelatSlimSort, named('RelatSlimSort'));
// output(getCitizenKRI, named('getCitizenKRI'));


RETURN 	getCitizenKRI;																			

END;