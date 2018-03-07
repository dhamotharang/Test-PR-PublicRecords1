import risk_indicators;
export Layout_OFCO_Soapcall := record
string tribcode;
string account;
string first;
string last;
string addr;
string city;
string state;
string zip;
string hphone;
string cmpy;
string first2;
string last2;
string cmpy2;
string countrycode;
dataset(risk_indicators.Layout_Gateways_In) gateways;
end;