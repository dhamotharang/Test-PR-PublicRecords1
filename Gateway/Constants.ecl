import Gateway;
export Constants := module

	export void_gateway := dataset([], Gateway.layouts.config);

	export Defaults := module
		export integer WAIT_TIMEOUT 					:= 300; // 0 is wait forever, default if ommitted is 300 (s)
		export integer RETRIES 								:= 0;			// 0 is no retry, default if ommitted is (3)
		export integer WAIT_TIMEOUT_POLK 			:= 20;
		export integer WAIT_TIMEOUT_EXPERIAN 	:= 20;
		export integer STATUS_SUCCESS 	      := 0;
	end;

	export ServiceName := module

		// NOTE: These are the names we use when reading the gateway config from the incoming SOAP request.
		// Not to be confused with the actual service name used when making the SOAP calls in SOAPCall_* attributes.
		// For example, in Gateway.SoapCall_Polk, service name 'VehicleCheck' is used for 'polk'.

		// Phones
		export String40 QSent			:= 'qsent';								// active, as of 07/24/2012
		export String40 QSentV2		:= 'qsentv2';							// active, as of 07/24/2012
		export String40 Targus		:= 'targus';							// active, as of 07/24/2012
		export String40 Metronet	:= 'metronet';						// active, as of 07/24/2012
		export String40 AccuDataOCN		:= 'accudata_ocn';						// active as of 5/2017

		// Vehicles
		export String40 Polk			:= 'polk';								// active, as of 07/24/2012
		export String40	Experian 	:= 'experian';						// active, as of 07/24/2012

		export String40 Equifax		:= 'inviewreport';				// active, as of 07/24/2012
		export String40 GDCVerify	:= 'gdcverify';						// active, as of 07/24/2012
		export String40 GG2Verification:='gg2verification';	// active, as of
		export String40 Clarity		:= 'skiptracesearch';			// inactive, as of 08/07/2012 (#108465)
		export String40 NetAcuity	:= 'netacuity';						// active, as of 07/24/2012
		export String40 ERC 			:= 'property_value';			// inactive, as of 02/12/2013 (#118838)
		export String40 Attus			:= 'attus';								// active, as of 07/24/2012
		export String40 EquifaxSts := 'equifaxsts';					// active, as of 03/22/2016
		export String40 ThreatMetrix := 'threatmetrix';      // added for threatmetrix


		export String40 News			:= 'news';								// WSK news gateway (currently for AML Attributes)

		export String40 ERI				:= 'erisalary';
		export String40 NeutralRoxie  := 'neutralroxie';    // internal
		export String40 InsurancePhoneHeader  := 'insurancephoneheader';		// internal call to insurance/alpharetta roxie
		export String40 FCRARoxie  		:= 'fcra'; 						// from RiskWiseFCRA.Neutral_Service_Name
		export String40 SearchCore  := 'searchcore';				// Bridger SearchCore service
		export String40 bridgerxg5  := 'bridgerxg5';				// Bridger Stand alone SearchCore (no wsgateway call) Full World compliance file
		export String40 bridgerwlc  := 'bridgerwlc';				// Bridger Stand alone SearchCore (no wsgateway call) Subset of Watchlist files
		export String40 DeltaInquiry := 'delta_inquiry';
		export String40 SearchAlertID := 'SP_SEARCHALERTID'; // referenced in Inquiry_Services
		export String40 SearchIdentityVelocityId := 'SP_SEARCHIDENTITYVELOCITYID'; // referenced in Inquiry_Services
		export String40 FDNDeltabase		:= 'delta_fdn';				//FDN Search
		export String40 FraudGovDeltabase := 'delta_esp';
		export String40 PhonesMetaData		:= 'delta_phonefinder';				//Phone Finder service metadata - porting/spoof/otp
		// FCRA Full File Disclosure person context deltabase
		export String40 delta_personcontext	:= 'delta_personcontext';				//FCRA Full File Disclosure
		export String40 delta_inquiryhistory	:= 'delta_inquiryhistory';				// FCRA Inquiry History
		export String40 AttIapQuery	:= 'att_iap';				// ATT DQ_IRS - Information Retrieval Service
		export String40 ConsumerCreditReport := 'consumercreditreport';			//FCRA Consumer Credit Report
		export String40 DeltabaseSql := 'DeltaBaseSql';
		export String40 EcrashImageRetrieval := 'AccidentImage';
		export String40 ZumigoIdentity := 'zumigoidentity';			//Zumigo Line Identity
    // Equifax Account Decisioning gateway
    export String40 EquifaxAcctDecisioning := 'equifaxattributes';   // FCRA only as of 10/2017
		export String40 EquifaxEVS := 'equifaxevs';			// Equifax Employment Verification Service
		export String40 IsAccuDataCNAM := 'accudata_cnam';			//CallerID - Retrieve Calling Name for phone number
		export String40 IsEquifaxEmsReport := 'equifax_ems';			//Equifax Tri-Merge report.
		export String40 IsTuFraudAlert := 'tu_fraud_alert';			//Transunion Fraud Alert
		export String40 BriteVerifyEmail := 'BriteVerifyEmail';			//Brite Verify Email validation
	end;

	export ConfigProperties := module
		export string20 TransactionId 	:= 'TransactionId';
		export string20 BlindOption		 	:= '_Blind';
		export string20 BatchJobId 			:= 'BatchJobId';
		export string20 BatchSpecId 		:= 'BatchSpecId';
		export string20 RoxieQueryName	:= 'RoxieQueryName';
	end;

end;