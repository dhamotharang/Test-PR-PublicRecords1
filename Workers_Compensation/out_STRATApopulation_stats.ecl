import STRATA, Workers_Compensation;

export out_STRATApopulation_stats(string pversion) := function

Base := Workers_Compensation.Files().Base_full.qa;	

strataLayout	:=	record
		layouts.base;
		string10 nogrouping := 'nogrouping';
end;

strataBase	:=	project(Base, TRANSFORM(strataLayout,SELF := LEFT; SELF := []));

rPopulationStats_Workers_Compensation := record
    strataBase.nogrouping;    // field to group by --  all values are "nogrouping"
    CountGroup                        := count(group);
    Master_UID_CountNonBlank          := sum(group,if(strataBase.Master_UID<>'',1,0));
    unique_id_CountNonBlank           := sum(group,if(strataBase.unique_id<>'',1,0));
    RMID_CountNonBlank                := sum(group,if(strataBase.RMID<>'',1,0));
    Description_CountNonBlank         := sum(group,if(strataBase.Description<>'',1,0));
    ADDRESS_CountNonBlank             := sum(group,if(strataBase.ADDRESS<>'',1,0));
    CITY_CountNonBlank                := sum(group,if(strataBase.CITY<>'',1,0));
    State_CountNonBlank               := sum(group,if(strataBase.State<>'',1,0));
    ZIP_CountNonBlank                 := sum(group,if(strataBase.ZIP<>'',1,0));
    ZipPlus4_CountNonBlank            := sum(group,if(strataBase.ZipPlus4<>'',1,0));
    classCode_CountNonBlank           := sum(group,if(strataBase.classCode<>'',1,0));
    Effective_Month_Day_CountNonBlank := sum(group,if(strataBase.Effective_Month_Day<>'',1,0));
    EffectiveMonth_CountNonBlank      := sum(group,if(strataBase.EffectiveMonth<>'',1,0));
    NAICCarrierName_CountNonBlank     := sum(group,if(strataBase.NAICCarrierName<>'',1,0));
    NAICCarrierNumber_CountNonBlank   := sum(group,if(strataBase.NAICCarrierNumber<>'',1,0));
    NAICGroupName_CountNonBlank       := sum(group,if(strataBase.NAICGroupName<>'',1,0));
    NAICGroupNumber_CountNonBlank     := sum(group,if(strataBase.NAICGroupNumber<>'',1,0));
    FEIN_CountNonBlank                := sum(group,if(strataBase.FEIN<>'',1,0));
    PolicySelf_CountNonBlank          := sum(group,if(strataBase.PolicySelf<>'',1,0));
    Record_Type_CountNonBlank         := sum(group,if(strataBase.Record_Type<>'',1,0));
		Insured_Status_CountNonBlank      := sum(group,if(strataBase.Insured_Status<>'',1,0));
    Append_MailAddress1_CountNonBlank	:= sum(group,if(strataBase.Append_MailAddress1<>'',1,0));
		Append_MailAddressLast_CountNonBlank := sum(group,if(strataBase.Append_MailAddressLast<>'',1,0));
		bdid_CountPopulated               := sum(group,if((string)strataBase.bdid<>'',1,0));
		source_rec_id_CountPopulated 			:= sum(group,if((string)strataBase.source_rec_id<>'',1,0));	
		DotID_CountPopulated							:= sum(group,if((string)strataBase.DotID<>'',1,0));
		DotScore_CountPopulated						:= sum(group,if((string)strataBase.DotScore<>'',1,0));
		DotWeight_CountPopulated					:= sum(group,if((string)strataBase.DotWeight<>'',1,0));
		EmpID_CountPopulated							:= sum(group,if((string)strataBase.EmpID<>'',1,0));
		EmpScore_CountPopulated						:= sum(group,if((string)strataBase.EmpScore<>'',1,0));
		EmpWeight_CountPopulated					:= sum(group,if((string)strataBase.EmpWeight<>'',1,0));
		POWID_CountPopulated							:= sum(group,if((string)strataBase.POWID<>'',1,0));
		POWScore_CountPopulated						:= sum(group,if((string)strataBase.POWScore<>'',1,0));
		POWWeight_CountPopulated					:= sum(group,if((string)strataBase.POWWeight<>'',1,0));
		ProxID_CountPopulated							:= sum(group,if((string)strataBase.ProxID<>'',1,0));
		ProxScore_CountPopulated					:= sum(group,if((string)strataBase.ProxScore<>'',1,0));
		ProxWeight_CountPopulated					:= sum(group,if((string)strataBase.ProxWeight<>'',1,0));
		SELEID_CountPopulated							:= sum(group,if((string)strataBase.SELEID<>'',1,0));
		SELEScore_CountPopulated					:= sum(group,if((string)strataBase.SELEScore<>'',1,0));
		SELEWeight_CountPopulated					:= sum(group,if((string)strataBase.SELEWeight<>'',1,0));	
		OrgID_CountPopulated							:= sum(group,if((string)strataBase.OrgID<>'',1,0));
		OrgScore_CountPopulated						:= sum(group,if((string)strataBase.OrgScore<>'',1,0));
		OrgWeight_CountPopulated					:= sum(group,if((string)strataBase.OrgWeight<>'',1,0));
		UltID_CountPopulated							:= sum(group,if((string)strataBase.UltID<>'',1,0));
		UltScore_CountPopulated						:= sum(group,if((string)strataBase.UltScore<>'',1,0));
		UltWeight_CountPopulated					:= sum(group,if((string)strataBase.UltWeight<>'',1,0));	
	end;

dPopulationStats_Workers_Compensation := table(strataBase,rPopulationStats_Workers_Compensation,few);                                                               

STRATA.createXMLStats(dPopulationStats_Workers_Compensation,
            'Workers_CompensationV3','base',pversion,
						'sudhir.kasavajjala@lexisnexis.com',resultsOut,'view','population');
		 
 return resultsOut;
 
 end;