import Gateway, Risk_Indicators, STD;

/*
	*************************************************************************************
	General usage:

		// To read gateway configuration from store, use:
		dGWCfg  := Gateway.Configuration.Get();

		// To pick a specific gateway configuration, apply filter by service name. E.g.:
		dTargusGWCfg  := dGWCfg(Gateway.Configuration.IsTargus(servicename));

	*************************************************************************************
*/
export Configuration := module

	// Read gateway configuration from #store.
	export Get() := function

		// Reading additional configuration.
		string 	_transactionID 	:= '' : stored('_TransactionId');
		string 	_bJobID 			 	:= '' : stored('_BatchJobId');
		string 	_bSpecID 			 	:= '' : stored('_BatchSpecId');
		/*--------------------------------------------------------------------------------------------------------------------------
			__Blind is for roxie-roxie soapcall, plaform needs to see <_blind>1<_blind> inorder to blind log the soap request.
			The other "Blind" is coming from ESP request required by Gateway ESP's to blind log the gateway logs in database.
		--------------------------------------------------------------------------------------------------------------------------*/
		boolean	__Blind	:= FALSE : stored('_Blind');
		boolean	Blind		:= FALSE : stored('Blind');
		string _Blind 	:= if(Blind or __Blind, '1', '0');

		// Reading query name; removing appended version, if necessary.
		string 	_roxieQName 		:= thorlib.jobname();
		integer _vIdx 					:= STD.Str.Find(_roxieQName,'.',2)-1;
		string 	_roxieQueryName	:= IF(_vIdx>0, _roxieQName[1.._vIdx], _roxieQName);

		// ************************************************************************
		// Storing configuration properties as name value pairs.
		//
		// NOTE: Why name/pairs? Once we migrate the riskwise libraries over to
		// use this attribute, the libraries will take in Layouts.Config instead
		// of Risk_Indicators.Layout_Gateways_In. Having these properties as name/value
		// pairs should minimize dependencies.
		// ************************************************************************
		dGWProperties :=
			dataset([
								{Gateway.Constants.ConfigProperties.TransactionId		, trim(_transactionID,left,right)},
								{Gateway.Constants.ConfigProperties.BatchJobId			,	trim(_bJobID,left,right)			 },
								{Gateway.Constants.ConfigProperties.BatchSpecId			,	trim(_bSpecID,left,right)			 },
								{Gateway.Constants.ConfigProperties.BlindOption			,	_Blind												 },
								{Gateway.Constants.ConfigProperties.RoxieQueryName	,	_roxieQueryName								 }
							 ], Gateway.Layouts.ConfigProperties);

		// ************************************************************************
		// Temporarily reading from store using old layout to avoid conflict.
		// Once we make the change to RiskIndicators, uncomment this line and deprecate the old layout.
		// ************************************************************************
		// dGWIn 			:= Constants.void_gateway : stored ('Gateways', few);
		dGWIn := dataset([], Risk_Indicators.Layout_Gateways_In) : stored ('Gateways', few);

		dGWInProps 	:= project(dGWIn,
													 transform(Gateway.Layouts.Config,
																		 self.TransactionId := _transactionID,
																		 self.properties := dGWProperties,
																		 self := left));
		return dGWInProps;

	end;

	// ************************************************************************
	// Use functions below to filter gateway configuration.
	//
	export IsQSent			(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.QSent;
	export IsQSentV2		(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.QSentV2;
	export IsTargus			(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.Targus;
	export IsMetronet		(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.Metronet;
	export IsAccuDataOCN(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.AccuDataOCN; // accudata_ocn
	export IsPolk				(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.Polk;
	export IsExperian		(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.Experian;
	export IsEquifax		(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.Equifax;
	export IsGDCVerify	(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.GDCVerify;
	export IsGG2Verification	(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.GG2Verification;
	export IsNetAcuity	(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.NetAcuity;
	export IsERC				(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.ERC;
	export IsAttus			(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.Attus;
	export IsNews				(string40 svcName) := FALSE;  // should never be used
	export IsEquifaxSts (string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.EquifaxSts;
	export IsThreatMetrix	(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.ThreatMetrix;
	export IsAttIapQuery(string40 svcName) := STD.Str.ToLowerCase(trim(svcName))=Gateway.Constants.ServiceName.AttIapQuery;
	export IsZumigoIdentity(string40 svcName) := STD.Str.ToLowerCase(trim(svcName))=Gateway.Constants.ServiceName.ZumigoIdentity;
  export IsEquifaxAcctDecisioning(string40 svcName) := STD.Str.ToLowerCase(trim(svcName))=Gateway.Constants.ServiceName.EquifaxAcctDecisioning;
	export IsEquifaxEVS(string40 svcName) := STD.Str.ToLowerCase(trim(svcName))=Gateway.Constants.ServiceName.EquifaxEVS;
	export IsAccuDataCNAM(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.IsAccuDataCNAM;
	export IsEquifaxEmsReport(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.IsEquifaxEmsReport;
	export IsTuFraudAlert(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.IsTuFraudAlert;
	// internal
	export IsNeutralRoxie(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.NeutralRoxie;
	export IsFCRARoxie(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.FCRARoxie;
	export IsInsurancePhoneHeader(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.InsurancePhoneHeader;
	export IsSearchCore(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.SearchCore;
	export IsBridgerXG5(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.BridgerXG5;
	export IsBridgerWLC(string40 svcName) := STD.Str.ToLowerCase(trim(svcName))=Gateway.Constants.ServiceName.BridgerWLC;
	export IsPhoneMetadata(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.PhonesMetaData;
	export IsDeltaPersoncontext(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.delta_personcontext;
	export IsDeltaInquiryHistory(string40 svcName) := STD.Str.ToLowerCase(trim(svcName)) = Gateway.Constants.ServiceName.delta_inquiryhistory;	
	export IsConsumerCreditReport(string40 svcName) := STD.Str.ToLowerCase(trim(svcName))=Gateway.Constants.ServiceName.ConsumerCreditReport;

	// ************************************************************************
	// Use functions below to retrieve gateway configuration properties.
	//
	export string 	GetTransactionIdX(Gateway.Layouts.Config GWCfg) := GWCfg.properties(name=Gateway.Constants.ConfigProperties.TransactionId)[1].val;
	export boolean 	GetBlindOption(Gateway.Layouts.Config GWCfg) 		:= GWCfg.properties(name=Gateway.Constants.ConfigProperties.BlindOption)[1].val = '1';
	export integer 	GetBatchJobId(Gateway.Layouts.Config GWCfg) 		:= (integer)GWCfg.properties(name=Gateway.Constants.ConfigProperties.BatchJobId)[1].val;
	export integer 	GetBatchSpecId(Gateway.Layouts.Config GWCfg) 		:= (integer)GWCfg.properties(name=Gateway.Constants.ConfigProperties.BatchSpecId)[1].val;
	export string 	GetRoxieQueryName(Gateway.Layouts.Config GWCfg) := GWCfg.properties(name=Gateway.Constants.ConfigProperties.RoxieQueryName)[1].val;

end;