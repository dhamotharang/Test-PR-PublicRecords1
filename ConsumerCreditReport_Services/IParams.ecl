IMPORT AutoStandardI, BatchShare, FCRA, FFD, Gateway, iesp, Suppress;

EXPORT IParams := MODULE

	EXPORT Params := INTERFACE(BatchShare.IParam.BatchParams, FCRA.iRules)
		EXPORT STRING50 ReferenceCode := '';
		EXPORT STRING50 BillingCode := '';
		EXPORT STRING120 EndUserCompanyName := '';
		EXPORT STRING6 DOBMask := '';
		EXPORT STRING PermissiblePurpose := '';
		EXPORT BOOLEAN FetchLiensJudgments := FALSE;
		EXPORT BOOLEAN hasGlbPermissiblePurpose := FALSE;
		EXPORT INTEGER bsVersion := 0;
	END;

	EXPORT getParams() := FUNCTION

		bs_mod := BatchShare.IParam.getBatchParams();

		// for testing GLB-purpose
		perm := AutoStandardI.PermissionI_Tools.val(project(bs_mod,AutoStandardI.PermissionI_Tools.params, OPT));

		// to decide whether to include Liens & Judgements
		isRestricted := AutoStandardI.DataRestrictionI.val(PROJECT(bs_mod,AutoStandardI.DataRestrictionI.params, OPT)).JuLi_data;
		IncludeLiensJudgments := FALSE : STORED('IncludeLiensJudgments');


		RETURN MODULE(PROJECT(bs_mod,Params,OPT))
			EXPORT STRING50 ReferenceCode := '' : STORED('ReferenceCode');
			EXPORT STRING50 BillingCode := '' : STORED('BillingCode');
			EXPORT STRING120 EndUserCompanyName := '' : STORED('EndUserCompanyName');
			EXPORT STRING6 DOBMask := Suppress.Constants.DATE_MASK_TYPE.NONE : STORED('DOBMask');
			EXPORT STRING PermissiblePurpose := '' : STORED('PermissiblePurpose');
			EXPORT INTEGER8 FFDOptionsMask := FFD.FFDMask.Get(); 
			EXPORT BOOLEAN FetchLiensJudgments := IncludeLiensJudgments AND NOT isRestricted;
			EXPORT BOOLEAN hasGlbPermissiblePurpose := perm.glb.ok(bs_mod.GLBPurpose);
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
		STRING PermissiblePurpose:=OPTIONS.PermissiblePurpose;
		#STORED('PermissiblePurpose',PermissiblePurpose);
		STRING FFDOptionsMask:=OPTIONS.FFDOptionsMask;
		#STORED('FFDOptionsMask',FFDOptionsMask);
		BOOLEAN IncludeLiensJudgments:=OPTIONS.IncludeLiensJudgments;
		#STORED('IncludeLiensJudgments',IncludeLiensJudgments);
		RETURN OUTPUT(DATASET([],{INTEGER x}),NAMED('__internal__'),EXTEND);
	END;

END;