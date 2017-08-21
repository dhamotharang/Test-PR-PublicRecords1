EXPORT NewCollisions(DATASET(layout_Collisions2.Layout_Collisions) cnew, DATASET(layout_Collisions2.Layout_Collisions) cprev)
				:= join(distribute(cnew,
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