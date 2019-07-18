IMPORT BatchShare, FCRA, FFD, Gateway, iesp, Suppress, doxie;

EXPORT IParams := MODULE

	EXPORT Params := INTERFACE(BatchShare.IParam.BatchParamsV2, FCRA.iRules)
		EXPORT STRING50 ReferenceCode := '';
		EXPORT STRING50 BillingCode := '';
		EXPORT STRING20 CompanyId := '';
		EXPORT STRING120 EndUserCompanyName := '';
		EXPORT STRING PermissiblePurpose := '';
		EXPORT BOOLEAN FetchLiensJudgments := FALSE;
		EXPORT INTEGER bsVersion := 0;
	END;

	EXPORT getParams() := FUNCTION

		bs_mod := BatchShare.IParam.getBatchParamsV2();

		// to decide whether to include Liens & Judgements
    isRestricted := doxie.compliance.isJuliRestricted(bs_mod.DataRestrictionMask);
    
		IncludeLiensJudgments := FALSE : STORED('IncludeLiensJudgments');

		RETURN MODULE(PROJECT(bs_mod,Params,OPT))
			EXPORT STRING50 ReferenceCode := '' : STORED('ReferenceCode');
			EXPORT STRING50 BillingCode := '' : STORED('BillingCode');
			EXPORT STRING20 CompanyId := '' : STORED('CompanyId');
			EXPORT STRING120 EndUserCompanyName := '' : STORED('EndUserCompanyName');
			EXPORT STRING PermissiblePurpose := '' : STORED('PermissiblePurpose');
			EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get(); 
			EXPORT BOOLEAN FetchLiensJudgments := IncludeLiensJudgments AND NOT isRestricted;
			EXPORT INTEGER bsVersion := 50 : STORED('bsVersion');
			EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
			EXPORT INTEGER FCRAPurpose := FCRA.FCRAPurpose.Get();	
		END;
	END;

	EXPORT SetInputUserOptions(iesp.consumercreditreport_fcra.t_FcraConsumerCreditReportRequest req) := FUNCTION
		USER:=GLOBAL(req.User);
		iesp.ECL2ESP.SetInputUser(USER);
		STRING50 ReferenceCode:=USER.ReferenceCode;
		#STORED('ReferenceCode',ReferenceCode);
		STRING50 BillingCode:=USER.BillingCode;
		#STORED('BillingCode',BillingCode);
		STRING20 CompanyId:=USER.CompanyId;
		#STORED('CompanyId',CompanyId);
		STRING120 EndUserCompanyName:=USER.EndUser.CompanyName;
		#STORED('EndUserCompanyName',EndUserCompanyName);
		
		OPTIONS:=GLOBAL(req.Options);
		STRING PermissiblePurpose:=OPTIONS.PermissiblePurpose;
		#STORED('PermissiblePurpose',PermissiblePurpose);
		STRING FFDOptionsMask:=OPTIONS.FFDOptionsMask;
		#STORED('FFDOptionsMask',FFDOptionsMask);
		STRING FCRAPurpose:=OPTIONS.FCRAPurpose;
		#STORED('FCRAPurpose',FCRAPurpose);
		BOOLEAN IncludeLiensJudgments:=OPTIONS.IncludeLiensJudgments;
		#STORED('IncludeLiensJudgments',IncludeLiensJudgments);
		RETURN OUTPUT(DATASET([],{INTEGER x}),NAMED('__internal__'),EXTEND);
	END;

END;
