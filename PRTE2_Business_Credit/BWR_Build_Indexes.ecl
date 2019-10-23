import STD,PRTE2, _control, PRTE, BIPV2, prte2_business_credit, dops;  

shared skipDOPS:=FALSE;
shared string emailTo:='';
shared dops_name := 'SBFECVKeys';

version :=(string8)STD.Date.CurrentDate(True);
shared pIndexVersion := version;



Key_BusinessClassification  := INDEX(prte2_business_credit.files.dsBusinessClassification, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {prte2_business_credit.files.dsBusinessClassification},prte2_business_credit.constants.key_prefix + pIndexVersion + '::businessindustryclassification'); 
Key_BusinessInfo    				:= INDEX(prte2_business_credit.files.dsBusinessInfo, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {prte2_business_credit.files.dsBusinessInfo},prte2_business_credit.constants.key_prefix + pIndexVersion + '::businessinformation'); 
Key_BusinessOwner	      	  := INDEX(prte2_business_credit.files.dsBusinessOwner, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {prte2_business_credit.files.dsBusinessOwner},prte2_business_credit.constants.key_prefix + pIndexVersion + '::businessowner'); 
Key_Collateral	    			  := INDEX(prte2_business_credit.files.dsCollateral , {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {prte2_business_credit.files.dsCollateral},prte2_business_credit.constants.key_prefix + pIndexVersion + '::collateral'); 
Key_History	     					  := INDEX(prte2_business_credit.files.dsHistory, {Sbfe_Contributor_Number,Original_Contract_Account_Number}, {prte2_business_credit.files.dsHistory},prte2_business_credit.constants.key_prefix + pIndexVersion + '::history'); 
Key_IndvOwner     					:= INDEX(prte2_business_credit.files.dsIndvOwner	, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {prte2_business_credit.files.dsIndvOwner	},prte2_business_credit.constants.key_prefix + pIndexVersion + '::individualowner'); 
Key_IOInformation 	 				:= INDEX(prte2_business_credit.files.dsIOInformation, {did}, {prte2_business_credit.files.dsIOInformation}, prte2_business_credit.constants.key_prefix + pIndexVersion + '::individualownerinformation'); 
Key_MasterAccount     			:= INDEX(prte2_business_credit.files.dsMasterAccount, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {prte2_business_credit.files.dsMasterAccount}, prte2_business_credit.constants.key_prefix + pIndexVersion + '::masteraccount'); 
Key_MemberSpecific  				:= INDEX(prte2_business_credit.files.dsMemberSpecific, {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, {prte2_business_credit.files.dsMemberSpecific}, prte2_business_credit.constants.key_prefix + pIndexVersion + '::memberspecific'); 
Key_ReleaseDates     			  := INDEX(prte2_business_credit.files.dsReleaseDates, {version}, {prte2_business_credit.files.dsReleaseDates}, prte2_business_credit.constants.key_prefix + pIndexVersion + '::releasedate'); 
Key_Tradeline							  := INDEX(prte2_business_credit.files.dsTradeline,{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date},{prte2_business_credit.files.dsTradeline}, prte2_business_credit.constants.key_prefix + pIndexVersion + '::tradeline'); 

Key_BusinessOwnerInfo  	   := INDEX(prte2_business_credit.files.dsBusinessOwnerInfo, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {prte2_business_credit.files.dsBusinessOwnerInfo}, prte2_business_credit.constants.key_prefix + pIndexVersion + '::businessownerinformation'); 
Key_TradelineGuarantor     := INDEX(prte2_business_credit.files.dsTradelineGuarantor, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {prte2_business_credit.files.dsTradelineGuarantor}, prte2_business_credit.constants.key_prefix + pIndexVersion + '::tradelineguarantor'); 
Key_Linkids							   := INDEX(prte2_business_credit.files.dslinkids,{ultid,orgid,seleid,proxid,powid,empid,dotid},{prte2_business_credit.files.dslinkids}, prte2_business_credit.constants.key_prefix + pIndexVersion + '::linkids'); 
Key_Best  							   := INDEX(prte2_business_credit.files.dsKey_Best, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {prte2_business_credit.files.dsKey_Best}, prte2_business_credit.constants.key_prefix + pIndexVersion + '::bipv2_best::linkids'); 

Key_Scoring   					   := INDEX(prte2_business_credit.files.dsScoring, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {prte2_business_credit.files.dsScoring}, prte2_business_credit.constants.key_prefix + pIndexVersion + '::scoringindex'); 


//---------- making DOPS optional -------------------------------
notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
updatedops					:= PRTE.UpdateVersion(dops_name, pIndexVersion, notifyEmail,'B','N','N');
PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);
//--------------------------------------------------------------------------

//-- Key Validation --
key_validation := dops.ValidatePRCTFileLayout(version, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra, 'SBFECVKeys', 'N');

build_keys := sequential(
                         parallel(build(Key_BusinessClassification, update),
																	build(Key_BusinessInfo, update),
																	build(Key_BusinessOwner, update),
																	build(Key_Collateral, update),
																	build(Key_History, update),
																	build(Key_IndvOwner, update),
																	build(Key_IOInformation, update),
																	build(Key_MasterAccount, update),
																	build(Key_MemberSpecific, update),
																	build(Key_ReleaseDates, update),
																	build(Key_Tradeline, update),
																	build(Key_BusinessOwnerInfo, update), 
																	build(Key_TradelineGuarantor, update),
																	build(Key_Linkids, update),
																	build(Key_Best, update), 
																	build(Key_Scoring, update)
																	));
														


build_keys;      
key_validation;
PerformUpdateOrNot;                 
output ('successful');

