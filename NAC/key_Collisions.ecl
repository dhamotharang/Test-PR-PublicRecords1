import doxie,data_services;
d := project(Files().Collisions
					,transform(NAC.Layouts.Collisions_slim
						,self.LexID_score:=(unsigned)left.LexIdScore
						,self.Case_Benefit_Type:=left.SearchBenefitType
						,self.Client_Eligible_Status_Indicator:=left.ClientEligibleStatusIndicator
						,self.Case_Benefit_Month:=left.SearchBenefitMonth

						,self.left_rec.Case_State_Abbreviation:=left.BenefitState
						,self.left_rec.Case_Identifier:=left.SearchCaseID
						,self.left_rec.PrepRecSeq:=(unsigned)left.SearchSequenceNumber
						,self.left_rec.NCF_FileDate:=left.SearchNCFFileDate
						,self.left_rec.Client_Identifier:=left.SearchClientID
						,self.left_rec.Client_Last_Name:=left.SearchLastName
						,self.left_rec.Client_First_Name:=left.SearchFirstName
						,self.left_rec.Client_Middle_Name:=left.SearchMiddleName
						,self.left_rec.Client_SSN:=left.SearchSSN
						,self.left_rec.Client_DOB:=left.SearchDOB

						,self.right_rec.Case_State_Abbreviation:=left.CaseState
						,self.right_rec.Case_Identifier:=left.CaseID
						,self.right_rec.PrepRecSeq:=(unsigned)left.ClientSequenceNumber
						,self.right_rec.NCF_FileDate:=left.ClientNCFFileDate
						,self.right_rec.Client_Identifier:=left.ClientID
						,self.right_rec.Client_Last_Name:=left.ClientLastName
						,self.right_rec.Client_First_Name:=left.ClientFirstName
						,self.right_rec.Client_Middle_Name:=left.ClientMiddleName
						,self.right_rec.Client_SSN:=left.ClientSSN
						,self.right_rec.Client_DOB:=left.ClientDOB
						,self:=left
						))
						;

export key_Collisions := INDEX(d, {unsigned1 Priority:=Pri
																		,string6 Benefit_month:=Case_Benefit_Month
																		,string2 State1:=left_rec.Case_State_Abbreviation
																		,string2 State2:=right_rec.Case_State_Abbreviation
																		}, {d}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::NAC::key::Collisions_' + doxie.version_superkey);