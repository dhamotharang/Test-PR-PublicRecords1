import Risk_Indicators;

export Layout_IDPO := RECORD

	STRING account;
	STRING riskwiseid;
	STRING socsverlevel;
	STRING phoneverlevel;
	STRING score;
	dataset(Risk_Indicators.layout_Desc) ri;
	STRING reason1;
	STRING reason2;
	STRING reason3;
	STRING reason4;
	STRING reason5;
	STRING reason6;
	STRING correctdob;
	STRING correcthphone;
	STRING correctsocs;
	STRING correctaddr;
	STRING dirsfirst;
	STRING dirslast;
	STRING dirsaddr;
	STRING dirscity;
	STRING dirsstate;
	STRING dirszip;
	STRING nameaddrphone;
	STRING altlast;
	STRING altlast2;
	STRING correctlast;
	DATASET(risk_indicators.Layout_Billing) Billing;
END;