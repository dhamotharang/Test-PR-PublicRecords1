import STRATA, Insurance_Certification;

export out_STRATApopulation_stats_Policy(string pversion) := function

Base := Insurance_Certification.Files().Base_Pol.qa;

strataLayout:=record
layouts_policy.base;
string10 nogrouping := 'nogrouping';
end;

strataBase:=project(Base, TRANSFORM(strataLayout,SELF := LEFT;));

rPopulationStats_Insurance_Certification := record
  strataBase.nogrouping;    // field to group by --  all values are "nogrouping"
  CountGroup                        := count(group);
  unique_id_CountNonBlank						:=sum(group,if((string)strataBase.unique_id<>'',1,0));
	DartID_CountNonBlank							:=sum(group,if(strataBase.DartID<>'',1,0));
	InsuranceProvider_CountNonBlank		:=sum(group,if(strataBase.InsuranceProvider<>'',1,0));
	PolicyNumber_CountNonBlank				:=sum(group,if(strataBase.PolicyNumber<>'',1,0));
	CoverageStartDate_CountNonBlank		:=sum(group,if(strataBase.CoverageStartDate<>'',1,0));
	CoverageExpirationDate_CountNonBlank	:=sum(group,if(strataBase.CoverageExpirationDate<>'',1,0));
	CoverageWrapUP_CountNonBlank			:=sum(group,if(strataBase.CoverageWrapUP<>'',1,0));
	PolicyStatus_CountNonBlank				:=sum(group,if(strataBase.PolicyStatus<>'',1,0));
	InsuranceProviderAddressLine_CountNonBlank	:=sum(group,if(strataBase.InsuranceProviderAddressLine<>'',1,0));
	InsuranceProviderAddressLine2_CountNonBlank	:=sum(group,if(strataBase.InsuranceProviderAddressLine2<>'',1,0));
	InsuranceProviderCity_CountNonBlank	:=sum(group,if(strataBase.InsuranceProviderCity<>'',1,0));
	InsuranceProviderState_CountNonBlank	:=sum(group,if(strataBase.InsuranceProviderState<>'',1,0));
	InsuranceProviderZip_CountNonBlank	:=sum(group,if(strataBase.InsuranceProviderZip<>'',1,0));
	InsuranceProviderZip4_CountNonBlank	:=sum(group,if(strataBase.InsuranceProviderZip4<>'',1,0));
	InsuranceProviderPhone_CountNonBlank	:=sum(group,if(strataBase.InsuranceProviderPhone<>'',1,0));
	InsuranceProviderFax_CountNonBlank	:=sum(group,if(strataBase.InsuranceProviderFax<>'',1,0));
	CoverageReinstateDate_CountNonBlank	:=sum(group,if(strataBase.CoverageReinstateDate<>'',1,0));
	CoverageCancellationDate_CountNonBlank	:=sum(group,if(strataBase.CoverageCancellationDate<>'',1,0));
	CoverageWrapUpDate_CountNonBlank		:=sum(group,if(strataBase.CoverageWrapUpDate<>'',1,0));
	BusinessNameDuringCoverage_CountNonBlank	:=sum(group,if(strataBase.BusinessNameDuringCoverage<>'',1,0));
	AddressLineDuringCoverage_CountNonBlank	:=sum(group,if(strataBase.AddressLineDuringCoverage<>'',1,0));
	AddressLine2DuringCoverage_CountNonBlank	:=sum(group,if(strataBase.AddressLine2DuringCoverage<>'',1,0));
	CityDuringCoverage_CountNonBlank	:=sum(group,if(strataBase.CityDuringCoverage<>'',1,0));
	StateDuringCoverage_CountNonBlank	:=sum(group,if(strataBase.StateDuringCoverage<>'',1,0));
	ZipDuringCoverage_CountNonBlank		:=sum(group,if(strataBase.ZipDuringCoverage<>'',1,0));
	Zip4DuringCoverage_CountNonBlank	:=sum(group,if(strataBase.Zip4DuringCoverage<>'',1,0));
	NumberofEmployeesDuringCoverage_CountNonBlank	:=sum(group,if(strataBase.NumberofEmployeesDuringCoverage<>'',1,0));
	InsuranceProviderContactDept_CountNonBlank	:=sum(group,if(strataBase.InsuranceProviderContactDept<>'',1,0));
	InsuranceType_CountNonBlank				:=sum(group,if(strataBase.InsuranceType<>'',1,0));
	CoveragePostedDate_CountNonBlank	:=sum(group,if(strataBase.CoveragePostedDate<>'',1,0));
	CoverageAmountFrom_CountNonBlank	:=sum(group,if(strataBase.CoverageAmountFrom<>'',1,0));
	CoverageAmountTo_CountNonBlank		:=sum(group,if(strataBase.CoverageAmountTo<>'',1,0));	
	Date_FirstSeen_CountNonBlank			:=sum(group,if((string)strataBase.Date_FirstSeen<>'',1,0));
	Date_LastSeen_CountNonBlank			  :=sum(group,if((string)strataBase.Date_LastSeen<>'',1,0));
	LNInsCertRecordID_CountNonBlank		:=sum(group,if((string)strataBase.LNInsCertRecordID<>'',1,0));
	Append_MailAddress1_CountNonBlank	:=sum(group,if(strataBase. Append_MailAddress1<>'',1,0));
	Append_MailAddressLast_CountNonBlank	:=sum(group,if(strataBase. Append_MailAddressLast<>'',1,0));
	bdid_CountNonBlank								:=sum(group,if((string)strataBase. bdid <>'',1,0));
  UltID_CountNonZero	     			    := sum(group,if(strataBase.UltID<>0,1,0));
	OrgID_CountNonZero 	              := sum(group,if(strataBase.OrgID<>0,1,0));
	SeleID_CountNonZero               := sum(group,if(strataBase.SeleID<>0,1,0));
 	ProxID_CountNonZero 	            := sum(group,if(strataBase.ProxID<>0,1,0));
	POWID_CountNonZero 	              := sum(group,if(strataBase.POWID<>0,1,0));
	EmpID_CountNonZero 	   						:= sum(group,if(strataBase.EmpID<>0,1,0));
	DotID_CountNonZero 	 							:= sum(group,if(strataBase.DotID<>0,1,0));
	UltScore_CountNonZero 	          := sum(group,if(strataBase.UltScore<>0,1,0));
  OrgScore_CountNonZero 	          := sum(group,if(strataBase.OrgScore<>0,1,0));
  SeleScore_CountNonZero 	          := sum(group,if(strataBase.SeleScore<>0,1,0));
	ProxScore_CountNonZero 	          := sum(group,if(strataBase.ProxScore<>0,1,0));
	POWScore_CountNonZero 	          := sum(group,if(strataBase.POWScore<>0,1,0));
 	EmpScore_CountNonZero 	 					:= sum(group,if(strataBase.EmpScore<>0,1,0));
	DotScore_CountNonZero 	  				:= sum(group,if(strataBase.DotScore<>0,1,0));
	UltWeight_CountNonZero 	          := sum(group,if(strataBase.UltWeight<>0,1,0));		
	OrgWeight_CountNonZero 	          := sum(group,if(strataBase.OrgWeight<>0,1,0));
	SeleWeight_CountNonZero 	        := sum(group,if(strataBase.SeleWeight<>0,1,0));
	ProxWeight_CountNonZero 	        := sum(group,if(strataBase.ProxWeight<>0,1,0));
	POWWeight_CountNonZero 	          := sum(group,if(strataBase.POWWeight<>0,1,0));
	EmpWeight_CountNonZero 	 				  := sum(group,if(strataBase.EmpWeight<>0,1,0));
  DotWeight_CountNonZero 	 					:= sum(group,if(strataBase.DotWeight<>0,1,0));	
			
end;

dPopulationStats_Insurance_Certification := table(strataBase,rPopulationStats_Insurance_Certification,few);                                                               

STRATA.createXMLStats(dPopulationStats_Insurance_Certification,
            'Insurance_Certification_Policy','baseV1',pversion,
						'',resultsOut,'view','population');
 
 return resultsOut;
 
 end;
 
