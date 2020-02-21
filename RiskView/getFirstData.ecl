import Risk_Indicators, Gateway, models, STD, iesp, dx_FirstData;

export getFirstData(dataset(Risk_Indicators.Layout_Input) indata, dataset(Gateway.Layouts.Config) gateways) := function

gateway_cfg	:= gateways(Gateway.Configuration.IsFirstData(servicename))[1];

gateway_params := project(gateways(STD.Str.ToLowerCase(ServiceName)in ['first_data']).properties,
                        transform(Gateway.Layouts.ConfigProperties,
                        self.name  := trim(left.name);
                        self.val := trim(left.val)));
                        
FDKey :=  dx_FirstData.key_DID();

iesp.first_data.t_FDCheckingIndicatorsRequest prep(indata le, FDKey ri) := transform  
DL_Number := if(ri.DL_ID <> '', ri.DL_ID, le.DL_Number);
DL_State := if(ri.dl_state <> '', ri.dl_state, le.dl_state);

	self.searchby.MerchantId := trim(gateway_params(STD.Str.ToLowerCase(Name)in ['subscriberid'])[1].val);
	// self.searchby.TeleCheckProductName   := 'MICRO_INDICATORS'; // Not needing to be passed but left for reference in case it is decided to in the future. Assumed will be passed from the ESP.
	// self.searchby.VersionControl   := 'CLIENTVENDORPROD 20060215 WIN SNNK 022'; // Not needing to be passed but left for reference in case it is decided to in the future. Assumed will be passed from the ESP.
	self.searchby.ManualId := if(trim(DL_State) = '' or trim(DL_Number) = '', '', trim(DL_State) + trim(DL_Number));
  self.searchby.SSN := trim(le.ssn);
	self.searchby.DOB.Year := trim(le.dob[1..4]); 
	self.searchby.DOB.Month := trim(le.dob[5..6]);
	self.searchby.DOB.Day := trim(le.dob[7..8]);
	self.searchby.FullName := trim( trim(le.fname) + if(le.mname<>'', ' ' + trim(le.mname) + ' ', ' ') + trim(le.lname) );
	self.searchby.PhoneNumber := trim(le.phone10);
	self.searchby.Address.AddressLine1  := trim(le.in_streetAddress);
	self.searchby.Address.City := trim(le.p_city_name);
	self.searchby.Address.State := trim(le.st);
	self.searchby.Address.ZipCode := trim(le.z5);
 
	self := [];
end;

firstdata_in := join(indata, FDKey, left.DID = right.Lex_ID, prep(left, right), left outer, atmost(1000));

firstdata_pass := firstdata_in( searchby.ManualId != '' or searchby.ssn != '');
firstdata_fail := firstdata_in( searchby.ManualId = '' and searchby.ssn = '');

makeGatewayCall := gateway_cfg.url!= '' and count(firstdata_pass)>0;
fd_results := if(makeGatewayCall, Gateway.SoapCall_FirstData(firstdata_in, gateway_cfg, makeGatewayCall), dataset([],iesp.first_data.t_FDCheckingIndicatorsResponseEx));


fd_ln_names := RECORD
unsigned4 seq;
string20  ARCHIVE_DATE;
string	  APPRS_AMT_90D; //Indicator 2
string	  DAYS_OLD_NEG; //Indicator 8
string	  FIRST_SEEN_DATE; //Indicator 14
string	  FIRST_SEEN_DATE_TRUE; //Indicator 14
string	  LAST_SEEN_DATE; //Indicator 15
string	  LTD_AMT; //Indicator 16
string	  LTD_AMT_TRUE; //Indicator 17
string	  LTD_DAYS; //Indicator 18
string	  LTD_QTY_TRUE; //Indicator 21
string	  NO_NEG_DECL_DAYS; //Indicator 24
string	  PREV_HOURS; //Indicator 26
string	  RISK_PNC; //Indicator 30
boolean	  FD_Gateway_Pass;
END;

fd_results_slim := project(fd_results, transform(fd_ln_names,

self.seq := indata[1].seq;
self.ARCHIVE_DATE := indata[1].historyDateTimeStamp[1..6];
self.APPRS_AMT_90D := left.Response.FDCheckingIndicators.Indicator2;
self.DAYS_OLD_NEG := left.Response.FDCheckingIndicators.Indicator8;
self.FIRST_SEEN_DATE := STD.Str.FilterOut(left.Response.FDCheckingIndicators.Indicator13, '-');
self.FIRST_SEEN_DATE_TRUE := STD.Str.FilterOut(left.Response.FDCheckingIndicators.Indicator14, '-');
self.LAST_SEEN_DATE := STD.Str.FilterOut(left.Response.FDCheckingIndicators.Indicator15, '-');
self.LTD_AMT := left.Response.FDCheckingIndicators.Indicator16;
self.LTD_AMT_TRUE := left.Response.FDCheckingIndicators.Indicator17;
self.LTD_DAYS := left.Response.FDCheckingIndicators.Indicator18;
self.LTD_QTY_TRUE := left.Response.FDCheckingIndicators.Indicator21;
self.NO_NEG_DECL_DAYS := left.Response.FDCheckingIndicators.Indicator24;
self.PREV_HOURS := left.Response.FDCheckingIndicators.Indicator26;
self.RISK_PNC := left.Response.FDCheckingIndicators.Indicator30;
self.FD_Gateway_Pass := left.response._header.message = '';

self := left;));

fd_results_slim_fail := project(firstdata_fail, transform(fd_ln_names,

self.seq := indata[1].seq;
self.ARCHIVE_DATE := '';
self.APPRS_AMT_90D := '';
self.DAYS_OLD_NEG := '';
self.FIRST_SEEN_DATE := '';
self.FIRST_SEEN_DATE_TRUE := '';
self.LAST_SEEN_DATE := '';
self.LTD_AMT := '';
self.LTD_AMT_TRUE := '';
self.LTD_DAYS := '';
self.LTD_QTY_TRUE := '';
self.NO_NEG_DECL_DAYS := '';
self.PREV_HOURS := '';
self.RISK_PNC := '';
self.FD_Gateway_Pass := false;

self := left;));

 CI_Layout := RECORD
 unsigned4 seq;
 string10 CheckProfileIndex;
 string10 CheckTimeOldest;
 string10 CheckTimeNewest;
 string10 CheckNegTimeOldest;
 string10 CheckNegRiskDecTimeNewest;
 string10 CheckNegPaidTimeNewest;
 string10 CheckCountTotal;
 string10 CheckAmountTotal;
 string10 CheckAmountTotalSinceNegPaid;
 string10 CheckAmountTotal03Month;
 boolean  FDGatewayCalled;
 END;
 
 
 
 /* ----------[ Start Checking Indicators Attribute Logic ]---------- */

CI_Attributes := project(fd_results_slim + fd_results_slim_fail, transform(CI_Layout,

NULL := Models.Common.Null;

sysdate := models.common.sas_date(if(left.ARCHIVE_DATE = '', (string8)Std.Date.Today(), (string6)left.ARCHIVE_DATE +'01'));

_first_seen_date_true := models.common.sas_date((string)(left.FIRST_SEEN_DATE_TRUE));

checktimeoldest_1 := if(_first_seen_date_true = NULL, -1 , min(660,max(1, round((sysdate - _first_seen_date_true) / (365.25 / 12)))));

checktimenewest_1 := map(
    left.PREV_HOURS = ''             => -1,
    (integer)left.PREV_HOURS > 482130 => -1,
    (integer)left.PREV_HOURS <= 0               => -1,
                                     min(660, max(1, round((integer)left.PREV_HOURS / (24 * 365.25 / 12)))));

checknegtimeoldest_1 := map(
    left.DAYS_OLD_NEG = ''       => -1,
    (integer)left.DAYS_OLD_NEG > 2556.75 => -1,
    (integer)left.DAYS_OLD_NEG <= 0         => -1,
                                 min(84, max(1, round((integer)left.DAYS_OLD_NEG / (365.25 / 12)))));

checknegriskdectimenewest_1 := map(
    left.NO_NEG_DECL_DAYS = '' or (Integer)left.NO_NEG_DECL_DAYS <= 0 => -1,
    (Integer)left.NO_NEG_DECL_DAYS > 2556.75                    => -1,
                                                        min(84, max(1, round((Integer)left.NO_NEG_DECL_DAYS / (365.25 / 12)))));

checknegpaidtimenewest_1 := map(
    left.LTD_DAYS = ''       => -1,
    (Integer)left.LTD_DAYS > 2556.75 => -1,
    (Integer)left.LTD_DAYS <= 0         => -1,
                             min(84, max(1, round((Integer)left.LTD_DAYS / (365.25 / 12)))));

checkcounttotal_1 := map(
    left.LTD_QTY_TRUE = '' or left.LTD_AMT_TRUE = '' => -1,
    (Real)left.LTD_AMT_TRUE <= 0                          => 0,
                                                  (min(9999, max(0, (integer)left.LTD_QTY_TRUE))));

checkamounttotal_1 := map(
    left.LTD_QTY_TRUE = '' or left.LTD_AMT_TRUE = '' => -1,
    (Integer)left.LTD_QTY_TRUE <= 0                          => 0,
                                                  (min(9999999, max(1, round((real)left.LTD_AMT_TRUE)))));

_first_seen_date := models.common.sas_date((string)(left.FIRST_SEEN_DATE));

mos_snc_first_seen_date := if(not(_first_seen_date = NULL), (string)round((sysdate - (integer)_first_seen_date) / (365.25 / 12)), '');

checkamounttotalsincenegpaid_1 := map(
    left.LTD_AMT = '' or left.LTD_QTY_TRUE = '' or left.LTD_AMT_TRUE = '' => -1,
    (Real)left.LTD_AMT <= 0 or (Integer)left.LTD_QTY_TRUE <= 0 or (Real)left.LTD_AMT_TRUE <= 0       => -1,
    (integer)mos_snc_first_seen_date >= 84                           => checkamounttotal_1,
                                                                    (min(9999999, checkamounttotal_1, max(1, round((real)left.LTD_AMT)))));

checkamounttotal03month_1 := if(left.APPRS_AMT_90D = '', -1, (min(9999999, max(0, round((integer)left.APPRS_AMT_90D)))));

_archive_date := left.archive_date;

archive_bf_first_seen_date := map(
    (Integer)left.FIRST_SEEN_DATE <= 19010000 => -2,
    (Integer)left.FIRST_SEEN_DATE >= 20990000 => -1,
    _archive_date < left.FIRST_SEEN_DATE => 1,
                                                0);

archive_bf_first_seen_date_true := map(
    left.FIRST_SEEN_DATE_TRUE = ''      => -3,
    (Integer)left.FIRST_SEEN_DATE_TRUE <= 19010000 => -2,
    (Integer)left.FIRST_SEEN_DATE_TRUE >= 20990000 => -1,
    _archive_date < left.FIRST_SEEN_DATE_TRUE => 1,
                                                0);

archive_bf_last_seen_date := map(
    left.LAST_SEEN_DATE = ''      => -3,
    (Integer)left.LAST_SEEN_DATE <= 19010000 => -2,
    (Integer)left.LAST_SEEN_DATE >= 20990000 => -1,
    _archive_date < left.LAST_SEEN_DATE => 1,
                                                0);

  self.CheckProfileIndex := if(makeGatewayCall = false or (string)left.RISK_PNC = '', '-1', (string)(min(80, max(0,(integer)left.RISK_PNC))));

  self.CheckTimeOldest := if(makeGatewayCall = false or (string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                          or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checktimeoldest_1);

  self.CheckTimeNewest := if(makeGatewayCall = false or (string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                          or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checktimenewest_1);

  self.CheckNegTimeOldest := if(makeGatewayCall = false or (string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                             or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checknegtimeoldest_1);

  self.CheckNegRiskDecTimeNewest := if(makeGatewayCall = false or (string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                                    or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checknegriskdectimenewest_1);

  self.CheckNegPaidTimeNewest := if(makeGatewayCall = false or (string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                             or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checknegpaidtimenewest_1);

  self.CheckCountTotal := if(makeGatewayCall = false or (string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                          or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checkcounttotal_1);

  self.CheckAmountTotal := if(makeGatewayCall = false or (string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1'
                           or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checkamounttotal_1);

  self.CheckAmountTotalSinceNegPaid := if(makeGatewayCall = false or (string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                                   or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checkamounttotalsincenegpaid_1);

  self.CheckAmountTotal03Month := if(makeGatewayCall = false or (string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                                  or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checkamounttotal03month_1);
                                  
  self.FDGatewayCalled := makeGatewayCall and left.FD_Gateway_Pass;
                            
  self := left;));
  
// /* ----------[ End Atribute Logic ]---------- */

return CI_Attributes;

END;