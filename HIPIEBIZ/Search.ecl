IMPORT HIPIEBIZ, doxie;
STRING _JobId := '00000001';
STRING _GcId  := '';
#WORKUNIT('name','HIPIEBIZ.Search_' + _JobId);

dOptions := MODULE(HIPIEBIZ.Options.SearchParams) 
  EXPORT INTEGER ShowNewBusinesses	:= 0 : STORED('ShowNewBusinesses');
  EXPORT STRING JOBID   := _JobId;
  EXPORT STRING GCID    := _GcId;
END;

string BusinessName 		:= '' : STORED('BusinessName');
string BusinessAddress	:= '' : STORED('BusinessAddress');
string BusinessCity			:= '' : STORED('BusinessCity');
string BusinessState		:= '' : STORED('BusinessState');
string BusinessZip			:= '' : STORED('BusinessZip');
string FEIN 						:= '' : STORED('FEIN');
string OfficerName 		  := '' : STORED('OfficerName');
string OfficerAddress	  := '' : STORED('OfficerAddress');
string OfficerCity		  := '' : STORED('OfficerCity');
string OfficerState		  := '' : STORED('OfficerState');
string OfficerZip			  := '' : STORED('OfficerZip');
string SSN              := '' : STORED('SSN');
string CustomerAccount  := '' : STORED('CustomerAccount');

HIPIEBIZ.Layouts.SearchInput tInput() := TRANSFORM
  SELF.BusinessName   := BusinessName;
  SELF.BusinessAddress:= BusinessAddress;
  SELF.BusinessCity   := BusinessCity;
  SELF.BusinessState  := BusinessState;
  SELF.BusinessZip    := BusinessZip;
  SELF.FEIN           := FEIN;
  SELF.OfficerName 		:= OfficerName;
  SELF.OfficerAddress	:= OfficerAddress;
  SELF.OfficerCity		:= OfficerCity;
  SELF.OfficerState		:= OfficerState;
  SELF.OfficerZip			:= OfficerZip;
  SELF.SSN            := SSN;
  SELF.CustomerAccount:= CustomerAccount;
END;
dInput := dataset([tInput()]);

//Insufficient Input Criteria
BOOLEAN BusinessAddressCriteriaSufficient := BusinessAddress <> '' AND ((BusinessCity <> '' AND BusinessState <> '') OR BusinessZip <> '');
BOOLEAN OfficerAddressCriteriaSufficient := OfficerAddress <> '' AND ((OfficerCity <> '' AND OfficerState <> '') OR OfficerZip <> '');
BOOLEAN InsufficientBusinessInputCriteria := BusinessName = '' AND NOT BusinessAddressCriteriaSufficient AND FEIN = '';
BOOLEAN InsufficientOfficerInputCriteria := OfficerName = '' AND NOT OfficerAddressCriteriaSufficient AND SSN = '';
BOOLEAN InsufficientInputCriteria := InsufficientBusinessInputCriteria AND InsufficientOfficerInputCriteria AND CustomerAccount = '';

//If we just want to see all new businesses and not do any search	
BOOLEAN noAddressCriteria := BusinessName = '' and BusinessAddress = '' and BusinessCity = '' and BusinessState = '' and BusinessZip = '' and FEIN = '';
BOOLEAN noOfficerCriteria := OfficerName = '' and OfficerAddress = '' and OfficerCity = '' and OfficerState = '' and OfficerZip = '' and SSN = '';
BOOLEAN noSearchCriteria := noAddressCriteria and noOfficerCriteria and CustomerAccount = '';

dNewBusinesses := PROJECT(HIPIEBIZ.Keys(dOptions).NewBusinessesFile, HIPIEBIZ.Layouts.SearchOutput);

dOutput	:= if(noSearchCriteria and (BOOLEAN)dOptions.showNewBusinesses, 
  dNewBusinesses, 
  HIPIEBIZ.SearchRecords(dInput, dOptions));

if((NoSearchCriteria OR InsufficientInputCriteria) AND NOT (BOOLEAN)dOptions.showNewBusinesses,
   FAIL(301, doxie.ErrorCodes(301)),
   OUTPUT(dOutput, NAMED('Results'))); 
