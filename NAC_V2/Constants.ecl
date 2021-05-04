export	Constants	:=
module
	export	string		LandingZoneServer		:=	'bctlpedata11.risk.regn.net';
	export	string		LandingZonePathBase	:=	'/data/hds_180/nac';
	export	string		LandingZonePathBaseEx	:=	'/data/hds_180/nac/';
	EXPORT string   SuperFileName_Internal := '~NAC::internal_email_distribution';
	EXPORT string   SuperFileName_External := '~NAC::external_email_distribution';
	
	// collision matching thresholds
	EXPORT threashold:=enum(unsigned1,Low,Medium,High);
	EXPORT score_threashold:=threashold;
	EXPORT ssn_threashold:=threashold;
	EXPORT dob_threashold:=threashold;	
end;