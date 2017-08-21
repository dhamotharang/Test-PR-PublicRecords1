import risk_indicators;
export Layout_Thindex_Soapcall := 	record
string  AccountNumber;
string FirstName;
string MiddleName;
string LastName;
string NameSuffix;
string StreetAddress;
string City;
string State;
string Zip;
string Country;
string ssn;
string DateOfBirth;
unsigned1  Age:=0;
STRING DLNumber;
STRING DLState;
string Email;
STRING IPAddress;
string HomePhone;
STRING WorkPhone;
STRING EmployerName;
STRING FormerName;
unsigned1  DPPAPurpose:=0;
unsigned1 GLBPurpose := 8;
STRING IndustryClass;
boolean LnBranded := false;
integer HistoryDateYYYYMM := 999999;
boolean OfacOnly := true ;
boolean OFACSearching := true;
dataset(risk_indicators.Layout_Gateways_In) gateways;
end;
