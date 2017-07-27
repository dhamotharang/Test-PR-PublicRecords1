EXPORT phone_noreconn_constants := MODULE
	EXPORT UNSIGNED1 PortingMarginOfError := 5;
	EXPORT UNSIGNED1 MaxPortedMatches := 100;
	EXPORT UNSIGNED1 PortingSuppressLimit := 7;
	EXPORT servType   := ENUM(LandLine = 0,Wireless = 1,VOIP = 2,Unknown = 3);
	EXPORT set of string servDesc := ['LandLine','Wireless','VOIP','Unknown'];
END;	