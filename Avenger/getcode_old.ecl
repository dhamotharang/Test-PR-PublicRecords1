EXPORT  getcode_old := module

export TranGroupCode(string groupname) := case(StringLib.StringToUpperCase(groupname),
'WATCHLISTS' => '20',
'VELOCITY'   => '19',
'SOCIAL SECURITY NUMBER' => '18',
'PHONE NUMBER VERIFICATION' => '17',
'PHONE NUMBER' => '16', 
'PERMIT VERIFICATION' => '15',
'PERMIT VALIDATION' => '14',
'OCCUPANCY/OWNERSHIP VERIFICATION' => '13', 
'IDENTITY VERIFICATION' => '12', 
'HEALTHCARE PROVIDER VERIFICATIONS' => '11',
'GOVERNMENT ID' => '10',
'DOB VERIFICATIONS' => '9',
'DEFAULT_GROUP' => '8',
'CONSUMER REPORTING AGENCIES' => '7', 
'COMPOSITE' => '6',
'BUSINESS VERIFICATIONS' => '5',
'AGE/BIRTH' => '4', 
'AGE VERIFICATION' => '3',
'ADDRESS/RESIDENCE' => '2',
'ADDRESS VERIFICATION' => '1', '-2');
//-2 = Could Not Calculate or Unknown

export TranDayCode(string tranday) := case(StringLib.StringToUpperCase(tranday),
'MONDAY' => '7', 
'TUESDAY' => '6', 
'WEDNESDAY' => '5',
'THURSDAY' => '4',
'FRIDAY' => '3',
'SATURDAY' => '2',
'SUNDAY' => '1', '-2');
//-2 = Could Not Calculate or Unknown

export TranFinalStatus(string statusfield) := case(statusfield,

'2' => '3', //Initiated
'4' => '1', //Passed
'5' => '2', //Failed
'6' => '4', //Questions
'8' => '5', //Error
'10' => '6', //Canceled
'11' => '7', //Abandoned
'-2'); //Could Not Calculate or Unknown

export TranChannelType(string Typefield) := case(Typefield,

'1' => '1', //Online (B2B transaction)
'2' => '3', //Call Center (B2B for call center scenario)
'3' => '4', //Portal (the web App)
'4' => '2', //Batch
'-2'); //Could Not Calculate or Unknown


export TranChannelAPIType(string Typefield) := case(Typefield,

'2' => '1',  //XML_v5
'201' => '2', //Batch
'101' => '3', //wsdl_v5
'102' => '4', //wsdl_v6
'1101' => '5',//Form Purchase_v5
'1201' => '8',//Form Verification_v5
'1301' => '6',//Form Verification_SSN9_v5
'1401' => '7',//Form Verification_SSN4_v5
'1501' => '10',//Form Verification_Patriot Act_v5
'1510' => '11',//Form iMonitor Phone Number
'1901' => '9', //Form Verification_UK
 '-2'); //Could Not Calculate or Unknown


export TranSubProdName(string SubPRODfield) := case(StringLib.StringToUpperCase(SubPRODfield),

'LEGACY VERIFICATION' => '6',
'REDFLAG'   => '5',
'BUSINESS' => '4',
'HEALTHCARE' => '3',
'AGEVERIFY' => '2',
'NG_WORKFLOW' => '1', '-2');

export TranTaskLevelOrig(string taskfield) := case(StringLib.StringToUpperCase(taskfield),

'IAUTH' => '6',
'ICHECK'  => '5',
'IKBA' => '4',
'IAGE' => '3',
'IMONITOR' => '2',
'IAUTO' => '1', '-2');


export TranTaskLevelfinal(string taskfield) := case(StringLib.StringToUpperCase(taskfield),


'ILOCATE' => '7',
'IAUTH' => '6',
'ICHECK'  => '5',
'IKBA' => '4',
'IAGE' => '3',
'IMONITOR' => '2',
'IAUTO' => '1', '-2');


export InputSSNType(string SSNfield) := case(SSNfield,

'0' => '-1', //No SSN Input
'1' => '2',  //SSN 9
'2' => '1',  //SSN 4
'-2'//  Could Not Calculate
);

export DiscoveryIdentitylocated(string locatefield) := case(locatefield,

'0' => '1', //Located
'1' => '0', //Not located
'2' => '2', //Indeterminate
'');

export Authstatus_set := ['PASS','FAIL','NOT STARTED','ERROR','ID NOT LOCATED','OPT OUT','VELOCITY EXCEED','QUIZ EXPIRED','UNABLE TO GEN'];
export Authstatus(string statusfield) := case(StringLib.StringToUpperCase(statusfield),

'PASS' => '1',
'FAIL' => '2',
'ERROR' => '3',
'OPT OUT' => '4',
'VELOCITY EXCEED' => '5',
'QUIZ EXPIRED' => '6', '');

export AuthstatusCode(string statusfield) := case(StringLib.StringToUpperCase(statusfield),

'PASS' => '1',
'FAIL' => '2',
'NOT STARTED' => '3',
'ERROR' => '4',
'ID NOT LOCATED' => '5',
'VELOCITY EXCEED' => '6',
'QUIZ EXPIRED' => '7',
'UNABLE TO GEN' => '8',
'OPT OUT' => '9', '');

export Authpass(string authpassfield) := case(authpassfield,
'1' => '1', //Pass
'0' => '2', //Fail
'');

export AUTHFAIL(string authfailfield) := case(authfailfield,
'1' => '1', //Fail
'0' => '2', //Pass
'');

export AUTHFAILstatus(string statusfield) := case(statusfield,
'1' => '1', //Fail
'0' => '2', //Pass
'');
export AUTHOPTOUT(string optoutfield) := case(optoutfield,
'1' => '1', //opt out
'0' => '2', //not opt out
'');

export AUTHunabletogen(string unabletogenfield) := case(unabletogenfield,
'1' => '1', //unable to generate
'0' => '2', //able to generate
'');

export AUTHERROR(string errorfield) := case(errorfield,
'1' => '1', //error
'0' => '2', //no error
'');

export TRANOFACSTATUSTYPE(string styleFIELD) := case(styleFIELD,

'1' => '3', // NA (No OFAC check was ran)
'2' => '2', //OFAC Clear
'3' => '1', // OFAC Match
'');

export CustFraudStatus(string fraudstatus, string CustFraudTypeProv) := map(

fraudstatus = '2' and CustFraudTypeProv in ['1', '2', '3', '4'] => '1', //Identity Found, But Could Not Calculate
fraudstatus = '3' and CustFraudTypeProv = '6' => '2', //Closed (if Cust_Fraud_Type_Prov = 6 (None))
fraudstatus = '5' and CustFraudTypeProv in ['5', ''] => '3', //Not Applicable (if Cust_Fraud_Type_Prov = 5 (Indeterminate or Blank))

'');

export questionsettype(string settype) := case(settype,

'1' => '1', // iauth
'11' => '2', //icheck.disambiguate
'');

export QuestionStyleType(string styletype) := case(styletype,

'1' => '1', // Legacy
'3' => '2', // Disambiguate
'11' => '3', //Sequential
'31' => '4', //Single Set
'41' => '5', //Minimal Pass Sets
'6'); //Unknown/Blank

export QuestionDataSource(string sourcefield) := case(sourcefield,

'10' => '1',// LexisNexis (BPS Search & BPS Report - v1.5)
'70' => '2',// LexisNexis (BPS Search & BPS Report - v1.74)
'20' => '3', //Equifax
'60' => '4', // Acxiom
'50' => '5', //Locate Plus (stopped)
'30' => '6', //People Finder(stopped)
'7'); //other

export QuestionGradeOutcome(string gradeoutcomefield) := case(gradeoutcomefield,

'1' => '1', //Pass
'2' => '2', //Fail
'0' => '3',// Not Graded
'3' => '4', //Error
'4' => '5', //Continue
'5' => '6', //Undecided
'');

export ITEMSTATUS(string statusfield) := case(statusfield,

'1' => '1', //pass
'0' => '2', //fail
'');

export quizoutcome(string statusfield) := case(StringLib.StringToUpperCase(statusfield),

'PASS' => '1',
'FAIL' => '2',
'QUIZ EXPIRED' => '2',
'ERROR' => '3',
'OPT OUT' => '7',
'TIMED OUT' => '7',
'VELOCITY EXCEEDED' => '8',
'UNABLE TO GEN' => '9',
'NOT ENOUGH DATA' => '9',
'');

export quizoutcomecode(string codefield) := case(StringLib.StringToUpperCase(codefield),

'PASS' => '1',
'FAIL' => '2',
'ERROR' => '3',
'OPT OUT' => '7',
'TIMED OUT' => '8',
'QUIZ EXPIRED' => '9',
'UNABLE TO GENERATE' => '10',
'NOT ENOUGH DATA' => '11',
'VELOCITY EXCEEDED' => '12',
'');

export AGENTRISKASSESMENT(string codefield) := case(StringLib.StringToUpperCase(codefield),

'NONE'   => '1',
'AGE OF VOICE DOES NOT MATCH'     => '2',
'ACCENT OF VOICE DOES NOT MATCH'  => '3',
'GENGER OF VOICE DOES NOT MATCH'  => '4',
'GENERAL FRAUD SUSPECTED' => '5', '');

end; 
