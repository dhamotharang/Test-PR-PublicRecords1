IMPORT AutoStandardI, BatchShare, Gateway, iesp, Suppress;

EXPORT IParams := MODULE

	EXPORT Params := INTERFACE(BatchShare.IParam.BatchParams)
		EXPORT STRING50 ReferenceCode := '';
		EXPORT STRING50 BillingCode := '';
		EXPORT STRING120 EndUserCompanyName := '';
		EXPORT STRING6 DOBMask := '';
		EXPORT STRING2 FCRAPurpose := '';
		EXPORT BOOLEAN FetchLiensJudgments := FALSE;
		EXPORT UNSIGNED3 ScoreThreshold := 0;
		EXPORT INTEGER bsVersion := 0;
	END;

	EXPORT getParams() := FUNCTION

		drmMod := MODULE(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.DataRestrictionI.params,OPT))END;
		isRestricted := AutoStandardI.DataRestrictionI.val(drmMod).JuLi_data;
		IncludeLiensJudgments := FALSE : STORED('IncludeLiensJudgments');

		RETURN MODULE(PROJECT(BatchShare.IParam.getBatchParams(),Params,OPT))
			EXPORT STRING50 ReferenceCode := '' : STORED('ReferenceCode');
			EXPORT STRING50 BillingCode := '' : STORED('BillingCode');
			EXPORT STRING120 EndUserCompanyName := '' : STORED('EndUserCompanyName');
			EXPORT STRING6 DOBMask := Suppress.Constants.DATE_MASK_TYPE.NONE : STORED('DOBMask');
			EXPORT STRING2 FCRAPurpose := '' : STORED('FCRAPurpose');
			EXPORT BOOLEAN FetchLiensJudgments := IncludeLiensJudgments AND NOT isRestricted;
			EXPORT UNSIGNED3 ScoreThreshold := Constants.SCORE_THRESHOLD : STORED('ScoreThreshold');
			EXPORT INTEGER bsVersion := 50 : STORED('bsVersion');
			EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
		END;
	END;

	EXPORT SetInputUserOptions(iesp.consumercreditreport_fcra.t_FcraConsumerCreditReportRequest req) := FUNCTION
		USER:=GLOBAL(req.User);
		iesp.ECL2ESP.SetInputUser(USER);
		STRING50 ReferenceCode:=USER.ReferenceCode;
		#STORED('ReferenceCode',ReferenceCode);
		STRING50 BillingCode:=USER.BillingCode;
		#STORED('BillingCode',BillingCode);
		STRING120 EndUserCompanyName:=USER.EndUser.CompanyName;
		#STORED('EndUserCompanyName',EndUserCompanyName);
		OPTIONS:=GLOBAL(req.Options);
		STRING2 FCRAPurpose:=OPTIONS.FCRAPurpose;
		#STORED('FCRAPurpose',FCRAPurpose);
		BOOLEAN IncludeLiensJudgments:=OPTIONS.IncludeLiensJudgments;
		#STORED('IncludeLiensJudgments',IncludeLiensJudgments);
		UNSIGNED3 ScoreThreshold:=IF(OPTIONS.ScoreThreshold!=0,OPTIONS.ScoreThreshold,Constants.SCORE_THRESHOLD);
		#STORED('ScoreThreshold',ScoreThreshold);
		RETURN OUTPUT(DATASET([],{INTEGER x}),NAMED('__internal__'),EXTEND);
	END;

END;