IMPORT PRTE2_DEADCO, InfoUSA;

EXPORT Files := MODULE

	EXPORT DEADCO_In					:= 	DATASET(Constants.IN_PREFIX + 'infousa::deadco', Layouts.DEADCO_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT DEADCO_BaseAID_ext	:= 	DATASET(Constants.BASE_PREFIX + 'infousa::deadco', Layouts.DEADCO_base_ext, THOR); //Base with DI fields appended
	EXPORT fDEADCO_BaseAID		:= 	PROJECT(DEADCO_BaseAID_ext, InfoUSA.Layout_deadco_Base_AID);
	
	Layouts.layout_AK tra(fDEADCO_BaseAID l) := TRANSFORM
    self.name       := l;
		self.name       := [];
		self.addr   		:= l;
		self.addr.fips_state 	:=	l.ace_fips_st;
		self.addr.fips_county	:=	l.ace_fips_county;
		self.addr 	:= [];
		self 				:= l;
	END;
	
	b	:=	PROJECT(fDEADCO_BaseAID, tra(left));

	EXPORT fSearchAutokey := b;
	
END;
	
	