EXPORT fn_NormalizeCollisions(DATASET(Nac_V2.Layout_Collisions2.Layout_Collisions) c) := FUNCTION

				c1 := project(c
					,transform(NAC_V2.Layout_Collisions2.Collisions_slim
						,self.LexID_score:=(unsigned)left.LexIdScore
//						,self.Case_Benefit_Type:=left.SearchBenefitType
						//,self.EligibilityStatus_Indicator:=left.ClientEligibleStatusIndicator
						,self.EligibilityStatus := left.SearchEligibilityStatus
						,self.StartDate := MAX(left.SearchStartDate, left.CaseStartDate);
						,self.EndDate := MIN(left.SearchEndDate, left.CaseEndDate);

						,self.Source.ProgramState:=left.BenefitState
						,self.Source.ProgramCode:=left.SearchBenefitType
						,self.Source.CaseId:=left.SearchCaseID
						,self.Source.PrepRecSeq := left.OrigSearchSequenceNumber
						,self.Source.NCF_FileDate:=left.SearchNCFFileDate
						,self.Source.ClientId:=left.SearchClientID
						,self.Source.Client_Last_Name:=left.SearchLastName
						,self.Source.Client_First_Name:=left.SearchFirstName
						,self.Source.Client_Middle_Name:=left.SearchMiddleName
						,self.Source.Client_Suffix_Name:=left.SearchSuffixName
						,self.Source.SSN:=left.SearchSSN
						,self.Source.DOB:=left.SearchDOB

						,self.Match.ProgramState:=left.CaseState
						,self.Match.ProgramCode:=left.CaseBenefitType
						,self.Match.CaseId:=left.CaseID
						,self.Match.PrepRecSeq := left.OrigClientSequenceNumber
						,self.Match.NCF_FileDate:=left.ClientNCFFileDate
						,self.Match.ClientId:=left.ClientID
						,self.Match.Client_Last_Name:=left.ClientLastName
						,self.Match.Client_First_Name:=left.ClientFirstName
						,self.Match.Client_Middle_Name:=left.ClientMiddleName
						,self.Match.Client_Suffix_Name:=left.ClientSuffixName
						,self.Match.SSN:=left.ClientSSN
						,self.Match.DOB:=left.ClientDOB
						
						,self:=left
						,self := []
						))
						;
						
		c2 := PROJECT(c1, TRANSFORM(NAC_V2.Layout_Collisions2.Collisions_slim,
							self.Source := left.Match;
							self.Match := left.Source;
							self := LEFT;));
							
		return c1 + c2;

END;
