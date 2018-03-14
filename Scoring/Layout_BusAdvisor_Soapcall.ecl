﻿import  risk_indicators;
export Layout_BusAdvisor_Soapcall := record
string	AccountNumber;
string	BDID;
string	CompanyName;
string	AlternateCompanyName;
string	Addr;
string	City;
string	State;
string	Zip;
string	BusinessPhone;
string	TaxIDNumber;
string	BusinessIPAddress;
string	RepresentativeFirstName;
string	RepresentativeMiddleName;
string	RepresentativeLastName;
string	RepresentativeNameSuffix;
string	RepresentativeAddr;
string	RepresentativeCity;
string	RepresentativeState;
string	RepresentativeZip;
string	RepresentativeSSN;
string	RepresentativeDOB;
string	RepresentativeAge;
string	RepresentativeDLNumber;
string	RepresentativeDLState;
string	RepresentativeHomePhone;
string	RepresentativeEmailAddress;
string	RepresentativeFormerLastName;
unsigned1	DPPAPurpose;
unsigned1	GLBPurpose;
string	IndustryClass;
boolean	LnBranded;
integer	HistoryDateYYYYMM;
boolean	OfacOnly;
boolean	ExcludeWatchLists;
dataset(risk_indicators.Layout_Gateways_In) gateways; 
end;