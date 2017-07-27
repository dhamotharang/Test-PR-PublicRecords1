/*2014-02-21T18:13:25Z (mwalklin_prod)
C:\Users\walkmi01\AppData\Roaming\HPCC Systems\eclide\mwalklin_prod\dataland\AML\AMLGetParentsV2\2014-02-21T18_13_25Z.ecl
*/

import doxie, risk_indicators, doxie_raw, progressive_phone, ut, riskwise;

EXPORT GetIndParents (  DATASET(Layouts.RelatLayoutV2) RelatDIDsin
													 ) := FUNCTION;
//version 2													 
slimParent :=  Record
	unsigned4 seq;
	unsigned3 historydate;
	unsigned6 subjectDID;
	unsigned6 relatDID;
	boolean   isrelat;
	STRING20  relation;	
	boolean     NoSSN;
	boolean     validSSN;
	boolean     EverITIN;
	boolean     hasITIN;
	boolean     EverNon_US_SSN;
	boolean     hasNon_US_SSN;
	boolean     IsVoter;
	boolean     IsVoterSRC;
	unsigned4   SSNLowIssueDt;
	unsigned1  AssocParentCnt;
END;
													 
// Parents2 := 		dedup(sort(RelatDIDsin(relation in ['Mother', 'Father', 'Parent', 'EXECPARENT']), seq, subjectdid, relatdid, relation),
										// seq, subjectdid, relatdid);
										
Parents := 		dedup(sort(RelatDIDsin(relatdegree in [10,56,60] /*or relation in ['Mother', 'Father', 'Parent', 'EXECPARENT']*/ ), seq, subjectdid, relatdid, relatdegree),
										seq, subjectdid, relatdid);										
										
ParentsSlim := project(Parents, 
									transform(slimParent,
														self.seq := left.seq,
														self.historydate := left.historydate,
														self.subjectDID := left.subjectdid,
														self.relatDID := left.relatdid,
														self.isrelat  := left.isrelat,
														self.relation := left.relation,
														self.validSSN := left.validSSN,
														self.NoSSN := left.NoSSN,
														self.EverNon_US_SSN := left.EverNon_US_SSN,
														self.hasNon_US_SSN := left.hasNon_US_SSN,
														self.SSNLowIssueDt := (integer)left.socllowissue,
														self.IsVoter := left.IsVoter,
														self.IsVoterSRC := left.VoterSrc,
														self.EverITIN := left.EverITIN,
														self.hasITIN := left.hasITIN,
														self.AssocParentCnt := if(left.relatdid <> 0, 1, 0)));

slimParent  RollParents(ParentsSlim le, ParentsSlim ri)  := TRANSFORM
   // sameSubject := le.subjectdid = ri.subjectdid;  
  self.seq    :=  le.seq;
	self.historydate  := le.historydate;
	self.subjectDID  := le.subjectDID;
	self.relatDID   := le.relatdid;
	self.isrelat    := le.isrelat;
	self.relation   := le.relation;	
	self.validSSN   := le.validSSN or ri.validSSN;
	self.NoSSN   			:= le.NoSSN or ri.NoSSN;
	self.EverITIN  		:= le.EverITIN or ri.EverITIN or le.hasITIN or ri.hasITIN;
	self.EverNon_US_SSN  := le.EverNon_US_SSN or ri.EverNon_US_SSN or le.hasNon_US_SSN or ri.hasNon_US_SSN;
	self.IsVoter  				:= le.IsVoter or ri.IsVoter;
	self.IsVoterSRC  				:= le.IsVoterSrc or ri.IsVoterSrc;
	self.SSNLowIssueDt  := min(le.SSNLowIssueDt, ri.SSNLowIssueDt);	
	self.AssocParentCnt := le.AssocParentCnt +  ri.AssocParentCnt;
	self.hasITIN := le.hasITIN or ri.hasITIN;
	self.hasNon_US_SSN := le.hasNon_US_SSN or ri.hasNon_US_SSN;
	
END;


RolledParentSlim := rollup(sort(ParentsSlim, seq, subjectdid, relatdid),
                               left.seq = right.seq and
															 left.subjectdid = right.subjectdid,
															 RollParents(left, right));
													 
Layouts.RelatLayoutV2  checkParents(RelatDIDsin le, RolledParentSlim	ri) := TRANSFORM
	self.AssocParentCnt  := ri.AssocParentCnt;
	self.ParentValidSSN := ri.validSSN;
	self.ParentNoSSN := ri.NoSSN;
	self.ParentVoter  := if(ri.isVoter, TRUE, FALSE);
	self.ParentVoterSRC  := if(ri.IsVoterSrc, TRUE, FALSE);
	self.ParentHasITIN  := if(ri.EverITIN, TRUE, FALSE);
	self.ParentNONUSSSN  := if(ri.EverNon_US_SSN, TRUE, FALSE);
	self.ParentLowIssueDt := ri.SSNLowIssueDt;
	self := le;
END;


parentflags := join(RelatDIDsin,RolledParentSlim, 
										left.seq = right.seq and  
										left.relatdid = right.subjectdid,
								    checkParents(left, right), left outer);
										 
													 
													 
// output(	RelatDIDsin, named('RelatDIDsin'));
// output(	Parents2, named('Parents2'));
// output(	Parents, named('Parents'));
// output(	ParentsSlim, named('ParentsSlim'));
// output(	RolledParentSlim, named('RolledParentSlim'));
// output(	parentflags, named('parentflags'));

												 
RETURN 	parentflags;												 
END;