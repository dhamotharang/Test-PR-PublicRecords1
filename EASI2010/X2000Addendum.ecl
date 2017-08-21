/*************

The 2010 omits some data from the census file
Other values will be taken from the current year file

*************** */

EASIs := EASI2010.Layout2000;


fn_get_pct(integer8	dividend ,integer8	divisor) := get_pct(dividend, divisor);

string decstr(DECIMAL8_1 x) := (string)x;


export EASIs X2000Addendum(DATASET(EASIs) legacy, 
				DATASET(Layout_Vendor.Layout_Current_yr) current) := FUNCTION
//				DATASET(Layouts.Layout_Current_yr) current) := FUNCTION

	rgeo := RECORD
		string12	GEOLINK	;
		Layout_Vendor.Layout_Current_yr;
	END;
	
	olddata := DISTRIBUTE(legacy, HASH32(geolink));

	newdata := DISTRIBUTE(PROJECT(current(geogkey='b'), TRANSFORM(rgeo,
		self.GEOLINK	:=	LEFT.STAABBRV + LEFT.FIPS[3..5]+
								TRIM(LEFT.CENTRACT,LEFT,RIGHT)+
								TRIM(LEFT.BLOCKGRP,LEFT,RIGHT);
		SELF := LEFT;)),
			HASH32(GEOLINK));	

	EASIs JoinAddendum(EASIs l, rgeo r) := TRANSFORM
		//self.MED_AGE := (string)r.MEDAGE;
		self.RETIRED2	:=	r.RETIRED;
//		self.UNEMP		:=	fn_get_pct((integer)r.UNEMPL,	r.EMP_POTL); //(POP 16+)
		self.UNEMPL		:=	r.UNEMPL;
		
	self.BUSINESS		:=	(string)r.NAIC_T_EST;
	self.EMPLOYEES		:=	(string)r.NAIC_T_EMP;

	self.AGRICULTURE	:=	fn_get_pct(r.NAICS11EMP,	r.NAIC_T_EMP);
	self.MINING			:=	fn_get_pct(r.NAICS21EMP,	r.NAIC_T_EMP);
	self.CONSTRUCTION	:=	fn_get_pct(r.NAICS23EMP,	r.NAIC_T_EMP);
	self.WHOLESALE		:=	fn_get_pct(r.NAICS42EMP,	r.NAIC_T_EMP);
	self.RETAIL			:=	fn_get_pct(r.NAICS44EMP,	r.NAIC_T_EMP);
	self.TRANSPORT		:=	fn_get_pct(r.NAICS48EMP,	r.NAIC_T_EMP);
//////////#############################	NaicsB
	self.MANUFACTURING	:=	fn_get_pct(r.NAICS31EMP,	r.NAIC_T_EMP);
//////////#############################	NaicsC
	self.INFO			:=	fn_get_pct(r.NAICS51EMP,	r.NAIC_T_EMP);
	self.FINANCE		:=	fn_get_pct(r.NAICS52EMP,	r.NAIC_T_EMP);
	self.PROFESSIONAL	:=	fn_get_pct(r.NAICS54EMP,	r.NAIC_T_EMP);
	self.HEALTH			:=	fn_get_pct(r.NAICS62EMP,	r.NAIC_T_EMP);
	self.FOOD			:=	fn_get_pct(r.NAICS72EMP,	r.NAIC_T_EMP);
	self.BARGAINS	:=	(string)r.BARGAINS;
	
	self.MURDERS	:=	(string)r.MURDERS;
	self.RAPE		:=	(string)r.RAPE;
	self.ROBBERY	:=	(string)r.ROBBERY;
	self.ASSAULT	:=	(string)r.ASSAULT;
	self.BURGLARY	:=	(string)r.BURGLARY;
	self.LARCENY	:=	(string)r.LARCENY;
	self.CARTHEFT	:=	(string)r.CARTHEFT;
	self.TOTCRIME	:=	(string)r.TOTCRIME;
	self.EASIQLIFE	:=	(string)r.EASIQLIFE;
	self.CPIALL		:=	(string)r.CPIALL;
	self.HOUSINGCPI	:=	(string)r.HOUSINGCPI;
		
	self.DOMIN_PROF	:=	r.DOMIN_PROF;
	self.CULT_INDX	:=	r.CULT_INDX;
	self.AMUS_INDX	:=	r.AMUS_INDX;
	self.REST_INDX	:=	r.REST_INDX;
	self.MEDI_INDX	:=	r.MEDI_INDX;
	self.RELIG_INDX	:=	r.RELIG_INDX;
	self.EDU_INDX	:=	r.EDU_INDX;

	self.EXP_PROD	:=	(string)r.EXP_PROD;
	self.LUX_PROD	:=	(string)r.LUX_PROD;
	self.MORT_INDX	:=	r.MORT_INDX;
	self.AB_AV_EDU	:=	r.AB_AV_EDU;
	self.APT20		:=	r.APT20;
	self.RENTAL		:=	r.RENTAL;
	self.PRESCHL	:=	r.PRESCHL;
	self.BEL_EDU	:=	r.BEL_EDU;
	self.BLUE_EMPL	:=	r.BLUE_EMPL;
	self.BORN_USA	:=	r.BORN_USA;
	self.EXP_HOMES	:=	r.EXP_HOMES;
	self.NO_TEENS	:=	r.NO_TEENS;
	self.FOR_SALE	:=	r.FOR_SALE;
	self.ARMFORCE	:=	r.ARMFORCE;
	self.LAR_FAM	:=	r.LAR_FAM;
	self.NO_MOVE	:=	r.NO_MOVE;
	self.MANY_CARS	:=	r.MANY_CARS;
	self.MED_INC	:=	r.MED_INC;
	self.NO_CAR		:=	r.NO_CAR;
	self.NO_LABFOR	:=	r.NO_LABFOR;
	self.RICH_OLD	:=	r.RICH_OLD;
	self.OLD_HOMES	:=	r.OLD_HOMES;
	self.NEW_HOMES	:=	r.NEW_HOMES;
	self.RECENT_MOV	:=	r.RECENT_MOV;
	self.SERV_EMPL	:=	r.SERV_EMPL;
	self.SUB_BUS	:=	r.SUB_BUS;
	self.TRAILER	:=	r.TRAILER;
	self.UNATTACH	:=	r.UNATTACH;
	self.ASIAN_LANG	:=	r.ASIAN_LANG;
	self.RICH_ASIAN	:=	r.RICH_ASIAN;
	self.RICH_BLK	:=	r.RICH_BLK;
	self.RICH_FAM	:=	r.RICH_FAM;
	self.RICH_HISP	:=	r.RICH_HISP;
	self.VERY_RICH	:=	r.VERY_RICH;
	self.RICH_NFAM	:=	r.RICH_NFAM;
	self.RICH_WHT	:=	r.RICH_WHT;
	self.SPAN_LANG	:=	r.SPAN_LANG;
	self.WORK_HOME	:=	r.WORK_HOME;
	self.RICH_YOUNG	:=	r.RICH_YOUNG;

		SELF := l;
	END;
	
	ds := JOIN(olddata, newdata, LEFT.geolink = RIGHT.geolink, 
					JoinAddendum(LEFT, RIGHT),
					LOCAL, LEFT OUTER);
	
	OUTPUT(SORT(olddata(geolink[1..5] = 'AL001'),geolink),named('oldsamp'));
	OUTPUT(SORT(newdata(geolink[1..5] = 'AL001'),geolink),named('newsamp'));
	return ds;

END;
