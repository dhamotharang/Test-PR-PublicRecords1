EXPORT BusinessLocationConfirmation_BatchService_Constants := MODULE

	EXPORT UNSIGNED1 PENALT_THRESHOLD         := 5      : STORED('PenaltThreshold');
  EXPORT BOOLEAN   INCLUDE_REAL_TIME_PHONES := FALSE  : STORED('IncludeRealTimePhones');
	EXPORT UNSIGNED4 SIC_CODE_KEEP            := 10000;
	EXPORT STRING1   CURRENT                  := 'C';
	EXPORT BOOLEAN   IN_USE_SUPERGROUP        := FALSE;
	EXPORT BOOLEAN   ROUND_UP_PARTIAL_MONTH   := FALSE;
	
/*
  These are Accutrend status codes that are currently considered ACTIVE

AC = Active, Accepted, Current
AD = Amended
AR = Annual Report
CA = Address Change
CH = Change
CN = Name Change
CO = Owner Change
CR = Correction
EN = Entry
GS = Goodstanding
MG = Merged in
MO = Merged Out
NW = New
RF = Refile, Renewal
RG = Registration
RS = Reinstated
TF = Transfer
*/

	EXPORT           ACCUTREND_ACTIVE_STATUS := ['AC', 'AD', 'AR', 'CA', 'CH', 'CN', 'CO', 'CR', 'EN',
	                                             'GS', 'MG', 'MO', 'NW', 'RF', 'RG', 'RS', 'TF'];

END;