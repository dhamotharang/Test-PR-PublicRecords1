EXPORT macro_run_rva_2_0_prescreen(archive_date) :=  macro
#workunit('name','Riskview Attributes 2.0');
IMPORT riskwise, ut, risk_indicators;

//Note:  This uses RiskView Batch Service instead or our customary RV 2.0 code
//       This matches what Cap One uses

today         := ut.GetDate[3..];
infile_name   := '~nmontpetit::in::rva_prescreen_tracking_pii';
outfile_name  := '~nmontpetit::out::rva_20_pre_tracking_' + today + '_' + (string)archive_date;

unsigned record_limit       :=  0;    //number of records to read from input file; 0 means ALL
unsigned1 parallel_calls    := 30;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball           := 50;
string DataRestrictionMask  := '10000100010001 '; // to restrict fares, experian, transunion and experian FCRA

//==================  input file layout  ========================
layout_input := RECORD
    STRING Account;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HomePhone;
    STRING SSN;
    STRING DateOfBirth;
    STRING WorkPhone;
    STRING income;  
    string DLNumber;
    string DLState;													
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    integer historydateyyyymm;
  END;
 
 
//====================================================
//=============  Service settings ====================
//====================================================
// Neutral service ip
neutral_roxie_IP := RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch


// FCRA service settings
roxieIP := RiskWise.Shortcuts.prod_batch_fcra; 		// FCRAbatch Roxie


//====================================================
//=====================  R U N  ======================
//====================================================
// load sample data

ds_in := dataset (infile_name, layout_input, csv(quote('"')));
// ds_in1 := dataset (infile_name, layout_input, csv(quote('"')));
// ds_in := ds_in1(Account in ['67769','67775','67776','67778','67786','67790','67792','67801','67803','67805','67808']);

//=================

ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(ds_input, eyeball), NAMED ('input'));


layout_soap_input := RECORD
	DATASET(Risk_Indicators.Layout_Batch_In) batch_in;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	STRING DataRestrictionMask;
	boolean IncludeVersion2;
	BOOLEAN IsPreScreen;	
END;

Risk_Indicators.Layout_Batch_In make_batch_in(ds_input le, integer c) := TRANSFORM
	self.seq := c;
	SELF.acctno := le.account;
	SELF.Name_First := le.FirstName;
	SELF.Name_Middle := le.MiddleName;
	SELF.Name_Last := le.LastName;
	SELF.street_addr := le.StreetAddress;
	SELF.p_City_name := le.CITY;
	SELF.St := le.STATE;
	SELF.z5 := le.ZIP;
	SELF.Home_Phone := le.HomePhone;
	SELF.SSN := le.SSN;
	SELF.DOB := le.DateOfBirth;
	SELF.Work_Phone := le.WorkPhone;
	self.historydateyyyymm := archive_date;
	SELF := le;
	SELF := [];
END;

layout_soap_input make_rv_in(ds_input le, integer c) := TRANSFORM
	batch := PROJECT(le, make_batch_in(LEFT, c));
	SELF.batch_in := batch;
	SELF.gateways := DATASET([{'FCRA', neutral_roxie_IP}], risk_indicators.layout_gateways_in);
	SELF.IsPreScreen := true;		
	self.IncludeVersion2 := true;
	SELF.DataRestrictionMask := DataRestrictionMask;
END;
	
soap_in := PROJECT(ds_input, make_rv_in(LEFT, counter));
OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('soap_in'));

roxie_out_layout := RECORD
	models.Layout_RiskView_Batch_Out;
	string200 errorcode;
END;
       
roxie_out_layout myfail(soap_in L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self.acctno := l.batch_in[1].acctno;
	self := [];
end;

soap_results := soapcall(soap_in, roxieIP ,
										'models.RiskView_Batch_Service', 
										{soap_in},
                    dataset(roxie_out_layout), 
										parallel(parallel_calls) ,
										onfail(myfail(LEFT)));

output(choosen(soap_results, eyeball), named('soap_results'));
errors := soap_results(errorcode<>'');
output(choosen(errors, eyeball), named('errors'));
output(count(errors), named('error_count'));

just_rv_attributes_v2 := RECORD
	string12 DID;
	string30 AccountNumber;

	string8 SSNFirstSeen;
	string8 DateLastSeen;
	string1 isRecentUpdate;
	string2 NumSources;
	string1 isPhoneFullNameMatch;
	string1 isPhoneLastNameMatch;
	string1 isSSNInvalid;
	string1 isPhoneInvalid;
	string1 isAddrInvalid;
	string1 isDLInvalid;
	string1 isNoVer;
	
	string1 isDeceased;
	string8 DeceasedDate;
	string1 isSSNValid;
	string1 isRecentIssue;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 IssueState;
	string1 isNonUS;
	string1 isIssued3;
	string1 isIssuedAge5;

	string6 IADateFirstReported;
	string6 IADateLastReported;
	string4 IALenOfRes;
	string1 IADwellType;
	string1 IALandUseCode;
	string10 IAAssessedValue;
	string1 IAisOwnedBySubject;
	string1 IAisFamilyOwned;
	string1 IAisOccupantOwned;
	string8 IALastSaleDate;
	string10 IALastSaleAmount;
	string1 IAisNotPrimaryRes;
	string1 IAPhoneListed;
	string10 IAPhoneNumber;

	string6 CADateFirstReported;
	string6 CADateLastReported;
	string4 CALenOfRes;
	string1 CADwellType;
	string1 CALandUseCode;
	string10 CAAssessedValue;
	string1 CAisOwnedBySubject;
	string1 CAisFamilyOwned;
	string1 CAisOccupantOwned;
	string8 CALastSaleDate;
	string10 CALastSaleAmount;
	string1 CAisNotPrimaryRes;
	string1 CAPhoneListed;
	string10 CAPhoneNumber;
	
	string6 PADateFirstReported;
	string6 PADateLastReported;
	string4 PALenOfRes;
	string1 PADwellType;
	string1 PALandUseCode;
	string10 PAAssessedValue;
	string1 PAisOwnedBySubject;
	string1 PAisFamilyOwned;
	string1 PAisOccupantOwned;
	string8 PALastSaleDate;
	string10 PALastSaleAmount;
	string1 PAisNotPrimaryRes;
	string1 PAPhoneListed;
	string10 PAPhoneNumber;
	
	string1 isInputCurrMatch;
	string4 DistInputCurr;
	string1 isDiffState;
	string10 AssessedDiff;
	string2 EcoTrajectory;
	
	string1 isInputPrevMatch;
	string4 DistCurrPrev;
	string1 isDiffState2;
	string10 AssessedDiff2;
	string2 EcoTrajectory2;
	
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	string6 PADateFirstReported2;
	string6 NPADateFirstReported;
	string3 addrChanges30;
	string3 addrChanges90;
	string3 addrChanges180;
	string3 addrChanges12;
	string3 addrChanges24;
	string3 addrChanges36;
	string3 addrChanges60;
	
	string3 property_owned_total;
	string13 property_owned_assessed_total;
	string3 property_historically_owned;
	string8 date_first_purchase;
	string8 date_most_recent_purchase;
	string8 date_most_recent_sale;
	
	string3 numPurchase30;
	string3 numPurchase90;
	string3 numPurchase180;
	string3 numPurchase12;
	string3 numPurchase24;
	string3 numPurchase36;
	string3 numPurchase60;
	
	string3 numSold30;
	string3 numSold90;
	string3 numSold180;
	string3 numSold12;
	string3 numSold24;
	string3 numSold36;
	string3 numSold60;
	
	string3 numWatercraft;
	string3 numWatercraft30;
	string3 numWatercraft90;
	string3 numWatercraft180;
	string3 numWatercraft12;
	string3 numWatercraft24;
	string3 numWatercraft36;
	string3 numWatercraft60;
	
	string3 numAircraft;
	string3 numAircraft30;
	string3 numAircraft90;
	string3 numAircraft180;
	string3 numAircraft12;
	string3 numAircraft24;
	string3 numAircraft36;
	string3 numAircraft60;
	
	string1 wealth_indicator;

	string3 total_number_derogs;
	string8 date_last_derog;
	
	string3 felonies;
	string8 date_last_conviction;
	string3 felonies30;
	string3 felonies90;
	string3 felonies180;
	string3 felonies12;
	string3 felonies24;
	string3 felonies36;
	string3 felonies60;
	
	string3 num_liens;
	string3 num_unreleased_liens;
	string8 date_last_unreleased;
	string3 num_unreleased_liens30;
	string3 num_unreleased_liens90;
	string3 num_unreleased_liens180;
	string3 num_unreleased_liens12;
	string3 num_unreleased_liens24;
	string3 num_unreleased_liens36;
	string3 num_unreleased_liens60;
	
	string3 num_released_liens;
	string8 date_last_released;
	string3 num_released_liens30;
	string3 num_released_liens90;
	string3 num_released_liens180;
	string3 num_released_liens12;
	string3 num_released_liens24;
	string3 num_released_liens36;
	string3 num_released_liens60;
	
	string3 bankruptcy_count;
	string8 date_last_bankruptcy;
	STRING1 filing_type;
	STRING35 disposition;
	string3 bankruptcy_count30;
	string3 bankruptcy_count90;
	string3 bankruptcy_count180;
	string3 bankruptcy_count12;
	string3 bankruptcy_count24;
	string3 bankruptcy_count36;
	string3 bankruptcy_count60;
	
	string3 eviction_count;
	string8 date_last_eviction;
	string3 eviction_count30;
	string3 eviction_count90;
	string3 eviction_count180;
	string3 eviction_count12;
	string3 eviction_count24;
	string3 eviction_count36;
	string3 eviction_count60;

	string3 num_nonderogs;
	string3 num_nonderogs30;
	string3 num_nonderogs90;
	string3 num_nonderogs180;
	string3 num_nonderogs12;
	string3 num_nonderogs24;
	string3 num_nonderogs36;
	string3 num_nonderogs60;
	
	string3 num_proflic;
	string8 date_last_proflic;
	string60 proflic_type;
	string8 expire_date_last_proflic;
	
	string3 num_proflic30;
	string3 num_proflic90;
	string3 num_proflic180;
	string3 num_proflic12;
	string3 num_proflic24;
	string3 num_proflic36;
	string3 num_proflic60;
	
	string3 num_proflic_exp30;
	string3 num_proflic_exp90;
	string3 num_proflic_exp180;
	string3 num_proflic_exp12;
	string3 num_proflic_exp24;
	string3 num_proflic_exp36;
	string3 num_proflic_exp60;
	
	string1 isAddrHighRisk;
	string1 isPhoneHighRisk;
	string1 isAddrPrison;
	string1 isZipPOBox;
	string1 isZipCorpMil;
	string1 phoneStatus;
	string1 isPhonePager;
	string1 isPhoneMobile;
	string1 isPhoneZipMismatch;
	string4 phoneAddrDist;
	
	string1 correctedFlag;
	string1 disputeFlag;
	string1 securityFreeze;
	string1 securityAlert;
	string1 negativeAlert;
	string1 idTheftFlag;
		
	string6 history_date;
	
	string200 errorcode;
END;


rv_attributes_v2 := project(soap_results, 
	transform(just_rv_attributes_v2, 
		self.accountnumber := left.acctno;
		self.history_date := (string6)archive_date;
		self := left;
		));	
		
output(choosen(rv_attributes_v2, eyeball), named('rv_attributes_v2'));
output(rv_attributes_v2,,outfile_name, csv(heading(single), quote('"')));
endmacro;