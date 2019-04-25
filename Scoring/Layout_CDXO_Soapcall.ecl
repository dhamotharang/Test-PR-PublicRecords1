﻿import risk_indicators;

export Layout_CDXO_Soapcall := record
string    tribcode;
string	account	;
string	ordertype	;
string	cmpy	;
string	cmpytype	;
string	first	;
string	last	;
string	addr	;
string	city	;
string	state	;
string	zip	;
string	hphone	;
string	wphone	;
string	socs	;
string	formerlast	;
string	email	;
string	drlc	;
string	drlcstate	;
string	ipaddr	;
string	avscode	;
string	channel	;
string	first2	;
string	last2	;
string	cmpy2	;
string	addr2	;
string	city2	;
string	state2	;
string	zip2	;
string	hphone2	;
string	channel2	;
string	orderamt	;
string	numitems	;
string	orderdate	;
string	cidcode	;
string	shipmode	;
string	pymtmethod	;
string	productcode	;
string	score	;
string	score2	;
integer	DPPAPurpose;
integer	GLBPurpose; 
integer	HistoryDateYYYYMM;
boolean	runSeed;  
dataset(risk_indicators.Layout_Gateways_In) gateways;
end;