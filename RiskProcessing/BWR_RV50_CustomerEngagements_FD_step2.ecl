IMPORT Models, Std;

eyeball := 100;

recordsToRun := 0; // Set to 0 or -1 to run ALL records in the file
	
inputFile := '~mmarshik::in::rvchecking_exeter_1_july2019_append.csv';
outputFile := '~mmarshik::out::FD_RawAttrsToCIs' + thorlib.wuid();

prii_layout := RECORD
string	LEXIS_SEQ;
string	LEXID;
string	DL_NUM;
string	DL_STATE;
string	SS_NUM;
string	ARCHIVE_DATE;
string	ACTIVE_NEG_LAST_RECEIVE_DATE;
string	APPRS_AMT_90D;
string	CORE_ID_AGE;
string	CORE_ID_AMT_TOT;
string	CORE_ID_QTY_TOT;
string	CORE_ID_RTL_APPR_AMT_30D;
string	DAYS_NEW_NEG;
string	DAYS_OLD_NEG;
string	DL_AGE;
string	DL_AMT_TOT;
string	DL_QTY_30D;
string	DL_QTY_TOT;
string	FIRST_SEEN_DATE;
string	FIRST_SEEN_DATE_TRUE;
string	LAST_SEEN_DATE;
string	LTD_AMT;
string	LTD_AMT_TRUE;
string	LTD_DAYS;
string	LTD_DAYS_TRUE;
string	LTD_PAID_NEGATIVE_AMT;
string	LTD_QTY_TRUE;
string	LTD_UNPAID_NEGATIVE_AMT;
string	NEG_REASON;
string	NO_NEG_DECL_DAYS;
string	NO_RISK_DECL_DAYS;
string	PREV_HOURS;
string	REL_FREQ_AMT;
string	REL_FREQ_QTY;
string	REL_FREQ_QTY_TRUE;
string	RISK_PNC;
END;

inputData := IF(recordsToRun > 0, CHOOSEN(DATASET(inputFile, prii_layout, CSV(HEADING(1))), recordsToRun),
																	DATASET(inputFile, prii_layout, CSV(HEADING(1) )));
                                  
OUTPUT(CHOOSEN(inputData, eyeball), NAMED('Sample_Raw_Input'));
                                  
 CI_Layout := RECORD
 string LEXIS_SEQ;
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
 END;
 
/* ----------[ Start Attribute Logic ]---------- */

CI_Attributes := project(inputData, transform(CI_Layout,

NULL := -999999999;

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
  
  self.LEXIS_SEQ := left.LEXIS_SEQ;

  self.CheckProfileIndex := if((string)left.RISK_PNC = '', '-1', (string)(min(80, max(0,(integer)left.RISK_PNC))));

  self.CheckTimeOldest := if((string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                          or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checktimeoldest_1);

  self.CheckTimeNewest := if((string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                          or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checktimenewest_1);

  self.CheckNegTimeOldest := if((string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                             or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checknegtimeoldest_1);

  self.CheckNegRiskDecTimeNewest := if((string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                                    or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checknegriskdectimenewest_1);

  self.CheckNegPaidTimeNewest := if((string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                             or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checknegpaidtimenewest_1);

  self.CheckCountTotal := if((string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                          or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checkcounttotal_1);

  self.CheckAmountTotal := if((string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1'
                           or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checkamounttotal_1);

  self.CheckAmountTotalSinceNegPaid := if((string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                                   or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checkamounttotalsincenegpaid_1);

  self.CheckAmountTotal03Month := if((string)archive_bf_first_seen_date = '1' or (string)archive_bf_first_seen_date_true = '1' or (string)archive_bf_last_seen_date = '1' or (string)archive_bf_first_seen_date_true = '-1' 
                                  or (string)archive_bf_first_seen_date_true = '-2', '-1', (string)checkamounttotal03month_1);
                            
  self := left;
  self := []));
  
/* ----------[ End Atribute Logic ]---------- */
	
output(choosen(CI_Attributes, eyeball), named('CI_Attributes'));
output(CI_Attributes,,outputFile, CSV(heading(single), quote('"')));