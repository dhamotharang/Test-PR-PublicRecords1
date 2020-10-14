

EXPORT NewCollisions(DATASET(layout_Collisions2.Layout_Collisions) cnew, DATASET(layout_Collisions2.Layout_Collisions) cprev)
				:= FUNCTION
		raw := join(distribute(cnew,
											hash32(SearchGroupId,SearchCaseID))
									,distribute(cprev,
											hash32(SearchGroupId,SearchCaseID))
											, left.SearchGroupId=right.SearchGroupId
 									and left.SearchCaseID=right.SearchCaseID
									and left.SearchClientID=right.SearchClientID
                  and left.BenefitState=right.BenefitState
									and left.SearchBenefitType=right.SearchBenefitType
									and left.caseGroupId=right.caseGroupId
									and left.caseid=right.caseid
									and left.clientid=right.clientid
									and left.casestate=right.casestate
									and left.CaseBenefitType=right.CaseBenefitType
									and left.EndDate <= right.EndDate				// new collision if end date > previous end date
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

		ex := $.NormalizeExceptions();

		j2 := JOIN(j, ex, left.searchgroupid=right.sourcegroupid AND left.searchbenefittype=right.SourceProgramCode
												AND left.searchclientid=right.SourceClientId
								AND left.casegroupid=right.matchedgroupid AND left.casebenefittype=right.matchedprogramcode
								AND left.clientid=right.matchedclientid,
								TRANSFORM(nac_v2.Layout_Collisions2.Layout_Collisions,
											self.ExceptionReasonCode := right.ReasonCode;
											self.ExceptionComments := right.Comments;
											self := left;),
								LEFT OUTER, LOOKUP);
								
		return j2;
END;
