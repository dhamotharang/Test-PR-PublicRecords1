import doxie,data_services;
d1 := project(Files().Collisions2
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
						
d2 := PROJECT(d1, TRANSFORM(NAC_V2.Layout_Collisions2.Collisions_slim,
							self.Source := left.Match;
							self.Match := left.Source;
							self := LEFT;));
							
d := d1 + d2;

export key_Collisions := INDEX(d, {
														SourceProgramState := Source.ProgramState
														,SourceProgramCode := Source.ProgramCode
														,SourceClientId := Source.ClientId
														,MatchedState := Match.ProgramState
														,MatchedProgramCode:= Match.ProgramCode
														,MatchedClientId := Match.ClientId
																		}, {d}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::NAC2::key::Collisions_' + doxie.version_superkey);