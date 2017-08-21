import risk_indicators;

export Layout_SC1O_Soapcall := record
string	tribcode;  
string	account;  
string	apptypeflag;  
string	first;  
string	last;  
string	cmpy;  
string	addr;  
string	city;  
string	state;  
string	zip;  
string	socs;  
string	dob;  
string	hphone;  
string	wphone;  
string	drlc;  
string	drlcstate;  
string	email;  
string	apptypeflag2;  
string	first2;  
string	last2;  
string	cmpy2;  
string	addr2;  
string	city2;  
string	state2;  
string	zip2;  
string	socs2;  
string	dob2;  
string	hphone2;  
string	wphone2;  
string	drlc2;  
string	drlcstate2;  
string	email2;  
string	saleamt;  
string	purchdate;  
string	purchtime;  
string	checkaba;  
string	checkacct;  
string	checknum;  
string	bankname;  
string	pymtmethod;  
string	cctype;  
string	avscode;  
string	inquiries;  
string	trades;  
string	balance;  
string	bankbalance;  
string	highcredit;  
string	delinquent90plus;  
string	numrevolvingtrades;  
string	autotrades;  
string	autotradesopen;  
string	income;  
string	income2;  
string	ipaddr;  
string	ccnum;  
string	ccexpdate;  
string	reserved;  
unsigned1	DPPAPurpose;
unsigned1	GLBPurpose;
integer	HistoryDateYYYYMM;
string DataRestrictionMask;
boolean	runSeed;
dataset(risk_indicators.Layout_Gateways_In) gateways; 
end;
