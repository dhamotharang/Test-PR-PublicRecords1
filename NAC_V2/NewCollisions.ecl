
NormalizeExceptions := FUNCTION
	ex := $.Files2.dsExceptionRecords;
	exout := ex(sourcegroupid <> matchedgroupid ); // interstate exceptions
	exin := ex(sourcegroupid = matchedgroupid);			// intrastate exceptions
	mirror := project(exin, TRANSFORM(recordof(ex),	
						self.sourceprogramstate := left.matchedstate;
						self.sourceprogramcode := left.matchedprogramcode;
						self.sourceclientid := left.matchedclientid;
						self.matchedstate := left.sourceprogramstate;
						self.matchedprogramcode := left.sourceprogramcode;
						self.matchedclientid := left.sourceclientid;
						self := left;));
	raw := exout + exin + mirror;
	unique := DEDUP(raw, sourcegroupid, sourceprogramstate, SourceProgramCode, SourceClientId,
                      matchedgroupid, matchedstate, matchedprogramcode, matchedclientid, all);
	return unique;
END;

EXPORT NewCollisions(DATASET(layout_Collisions2.Layout_Collisions) cnew, DATASET(layout_Collisions2.Layout_Collisions) cprev)
				:= FUNCTION
		raw := join(distribute(cnew,
											hash32(BenefitState,SearchBenefitType,SearchCaseID))
									,distribute(cprev,
											hash32(BenefitState,SearchBenefitType,SearchCaseID))
									,   left.BenefitState=right.BenefitState
									and left.SearchBenefitType=right.SearchBenefitType
									and left.SearchCaseID=right.SearchCaseID
									and left.SearchClientID=right.SearchClientID
									and left.SearchEligibilityStatus=right.SearchEligibilityStatus
									and left.casestate=right.casestate
									and left.CaseBenefitType=right.CaseBenefitType
									and left.caseid=right.caseid
									and left.clientid=right.clientid
									and left.ClientEligibilityStatus=right.ClientEligibilityStatus
									and left.StartDate=right.StartDate
									and left.EndDate=right.EndDate
									,left only
									,local);
		
		c := DISTRIBUTE(raw, hash32(benefitstate, searchbenefittype, searchclientid));
		h := DISTRIBUTE($.fn_eligibilityHistory(), hash32(programstate, programcode, clientid));


		j1 := JOIN(c, h, left.benefitstate=right.programstate AND left.searchbenefittype=right.programcode
												AND left.searchclientid=right.clientid,
								TRANSFORM(nac_v2.Layout_Collisions2.Layout_Collisions,
										self.EligibilityPeriodsHistory := right.history;
										self.TotalEligiblePeriodsDays := (string5)right.TotalEligiblePeriodsDays;
										self.TotalEligiblePeriodsMonths	:= (string4)right.TotalEligiblePeriodsMonths;
										self := left;),
								INNER, LOCAL);
								
		j := DISTRIBUTE(j1, hash32(searchgroupid, searchbenefittype, searchclientid));

		ex := DISTRIBUTE(NormalizeExceptions, hash32(sourcegroupid, SourceProgramCode, SourceClientId));

		j2 := JOIN(j, ex, left.searchgroupid=right.sourcegroupid AND left.searchbenefittype=right.SourceProgramCode
												AND left.searchclientid=right.SourceClientId
								AND left.casegroupid=right.matchedgroupid AND left.casebenefittype=right.matchedprogramcode
								AND left.clientid=right.matchedclientid,
								TRANSFORM(nac_v2.Layout_Collisions2.Layout_Collisions,
											self.ExceptionReasonCode := right.ReasonCode;
											self.ExceptionComments := right.Comments;
											self := left;),
								LEFT OUTER, LOCAL);
								
		return j2;
END;
								