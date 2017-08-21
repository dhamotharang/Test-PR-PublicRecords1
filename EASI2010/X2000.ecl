//
//	transform 2010 data to 2000 format
//

//EASIs := EASI.Layout_Easi_Census_v3;
EASIs := EASI2010.Layout2000;


fn_pct(integer8	dividend ,integer8	divisor) := get_pct(dividend, divisor);
			
tostring(integer n) := TRIM((string)n,LEFT,RIGHT);

export EASIs X2000(Layout_Vendor.Layout_Census l) := transform
	self.STATE			:=	l.STAABBRV;
	self.COUNTY			:=	l.FIPS[3..5];
	self.TRACT			:=	l.CENTRACT;
	self.BLKGRP			:=	l.BLOCKGRP;
	self.GEO_BLK		:=	l.CENTRACT+TRIM(l.BLOCKGRP,LEFT,RIGHT);
	self.GEOLINK		:=	l.STAABBRV+l.FIPS[3..5]+TRIM(l.CENTRACT,LEFT,RIGHT)+TRIM(l.BLOCKGRP,LEFT,RIGHT);

	self.POP00			:=	tostring(l.POP10);
	self.FAMILIES		:=	tostring(l.FAMILIES);
	self.HH00			:=	tostring(l.HH10);

	self.HHSIZE			:=	TRIM((string)l.AVGHHSIZE,LEFT,RIGHT);
	self.MED_HVAL		:=	tostring(l.MEDVALOCC);
	self.MED_YEARBLT	:=	tostring(l.MED_BLT);
	self.MED_RENT		:=	tostring(l.MEDRENT);
	
	POP := L.POP10;
	self.URBAN_P		:=	fn_pct(l.URBANPOP,		POP);
	self.RURAL_P		:=	fn_pct(l.RURALPOP,		POP);

	self.FAMMAR_P		:=	fn_pct(l.FAMMAR,		l.FAMILIES);
	self.FAMMAR18_P		:=	fn_pct(l.FAMMAR18,		l.FAMILIES);
	self.FAMOTF18_P		:=	fn_pct(l.FAMOTF18,		l.FAMILIES);

	self.POP_0_5_P		:=	fn_pct(l.POP_0_5,		POP);
	self.POP_6_11_P		:=	fn_pct(l.POP_6_11,		POP);
	self.POP_12_17_P	:=	fn_pct(l.POP_12_17,	POP);
	self.POP_18_24_P	:=	fn_pct(l.POP_18_24,	POP);
	self.POP_25_34_P	:=	fn_pct(l.POP_25_34,	POP);
	self.POP_35_44_P	:=	fn_pct(l.POP_35_44,	POP);
	self.POP_45_54_P	:=	fn_pct(l.POP_45_54,	POP);
	self.POP_55_64_P	:=	fn_pct(l.POP_55_64,	POP);
	self.POP_65_74_P	:=	fn_pct(l.POP_65_74,	POP);
	self.POP_75_84_P	:=	fn_pct(l.POP_75_84,	POP);
	self.POP_85P_P		:=	fn_pct(l.POP_85P,	POP);

	HH := L.HH10;
	self.HH1_P			:=	fn_pct(l.HH1,			HH);
	self.HH2_P			:=	fn_pct(l.HH2,			HH);
	self.HH3_P			:=	fn_pct(l.HH3,			HH);
	self.HH4_P			:=	fn_pct(l.HH4,			HH);
	self.HH5_P			:=	fn_pct(l.HH5,			HH);
	self.HH6_P			:=	fn_pct(l.HH6,			HH);
	self.HH7P_P			:=	fn_pct(l.HH7P,			HH);

	self.VACANT_P		:=	fn_pct(l.VACUNIT,		l.HOUSEUNITS);
	self.OCCUNIT_P		:=	fn_pct(l.OCCUNIT,		l.HOUSEUNITS);
	self.OWNOCP			:=	fn_pct(l.OOCCHH,		l.HOUSEUNITS);
	self.RENTOCP		:=	fn_pct(l.ROCCHH,		l.HOUSEUNITS);
	sfdu := (integer)l.s_1d + (integer)l.s_1a;
	self.SFDU_P			:=	fn_pct(sfdu,	l.HOUSEUNITS);

	renters := (integer8)l.ROCCHH;
	self.RNT250_P		:=	fn_pct(l.RNTL250,		renters);
	self.RNT500_P		:=	fn_pct(l.RNT25L50,		renters);
	self.RNT750_P		:=	fn_pct(l.RNT50L75,		renters);
	self.RNT1000_P		:=	fn_pct(l.RNT75L100,		renters);
	self.RNT1250_P		:=	fn_pct(l.RNT100L125,	renters);
	self.RNT1500_P		:=	fn_pct(l.RNT125L150,	renters);
	self.RNT2000_P		:=	fn_pct(l.RNT150L200,	renters);
	self.RNT2001_P		:=	fn_pct(l.RNT2000P,		renters);

	HIGHRENT			:=	(integer)l.RNT125L150
									+(integer)l.RNT150L200
									+(integer)l.RNT2000P;
	self.HIGHRENT		:=	fn_pct(HIGHRENT,		renters);


	LOWRENT				:=	(integer)l.RNTL250
								+(integer)l.RNT25L50;
	self.LOWRENT		:=	fn_pct(LOWRENT,		renters);

	owners := (integer8)L.oocchh;
	LOWVAL				:=  l.VALL10 + l.VAL10_15 + l.VAL15_20; 
	self.HVAL_20K_P		:=	fn_pct(LOWVAL,		owners);
	self.HVAL_40K_P		:=	fn_pct(l.VAL20_25+l.VAL25_30+l.VAL30_35+l.VAL35_40,		owners);
	self.HVAL_60K_P		:=	fn_pct(l.VAL40_50+l.VAL50_60,	owners);
	self.HVAL_80K_P		:=	fn_pct(l.VAL60_70+l.VAL70_80,	owners);
	self.HVAL_100K_P	:=	fn_pct(l.VAL80_90+l.VAL90_100,	owners);
	self.HVAL_125K_P	:=	fn_pct(l.VAL100_125,	owners);
	self.HVAL_150K_P	:=	fn_pct(l.VAL125_150,	owners);
	self.HVAL_175K_P	:=	fn_pct(l.VAL150_175,	owners);
	self.HVAL_200K_P	:=	fn_pct(l.VAL175_200,	owners);
	self.HVAL_250K_P	:=	fn_pct(l.VAL200_250,	owners);
	self.HVAL_300K_P	:=	fn_pct(l.VAL250_300,	owners);
	self.HVAL_400K_P	:=	fn_pct(l.VAL300_400,	owners);
	self.HVAL_500K_P	:=	fn_pct(l.VAL400_500,	owners);
	self.HVAL_750K_P	:=	fn_pct(l.VAL500_750,	owners);
	self.HVAL_1000K_P	:=	fn_pct(l.VAL750_100,	owners);
	self.HVAL_1001K_P	:=	fn_pct(l.VAL1000P,		owners);

	LOW_HVAL			:=	LOWVAL + l.VAL20_25+l.VAL25_30+l.VAL30_35+l.VAL35_40+l.VAL40_50+l.VAL50_60;	
	self.LOW_HVAL		:=	fn_pct(LOW_HVAL,		owners);

	HIGH_HVAL			:=	(integer)l.VAL500_750
									+(integer)l.VAL750_100
									+(integer)l.VAL1000P;
	self.HIGH_HVAL		:=	fn_pct(HIGH_HVAL,		owners);

	self.TRAILER_P		:=	fn_pct(l.STRAILER,		l.HOUSEUNITS);

	RETIRED				:=	(integer)l.POP_65_74
									+(integer)l.POP_75_84
									+(integer)l.POP_85P;
	self.RETIRED		:=	fn_pct(RETIRED,		POP);

	YOUNG				:=	(integer)l.POP_18_24
									+(integer)l.POP_25_34;
	self.YOUNG			:=	fn_pct(YOUNG,			POP);

	CHILD				:=	(integer)l.POP_0_5
									+(integer)l.POP_6_11
									+(integer)l.POP_12_17;
	self.CHILD			:=	fn_pct(CHILD,			POP);

	POPOVER18		:=	(integer)l.POP_18_24
									+(integer)l.POP_25_34
									+(integer)l.POP_35_44
									+(integer)l.POP_45_54
									+(integer)l.POP_55_64
									+(integer)l.POP_65_74
									+(integer)l.POP_75_84
									+(integer)l.POP_85P;

	self.POPOVER18 := tostring(POPOVER18);
	
	POPOVER25			:=	(integer)l.POP_25_34
									+(integer)l.POP_35_44
									+(integer)l.POP_45_54
									+(integer)l.POP_55_64
									+(integer)l.POP_65_74
									+(integer)l.POP_75_84
									+(integer)l.POP_85P;
	self.POPOVER25		:=	tostring(POPOVER25);

	self.FEMDIV_P		:=	fn_pct(l.FEMDIVORCE,	POP);

	LOW_ED				:=	(integer)l.ED_LHS
									+(integer)l.ED_HS;
	self.LOW_ED			:=	fn_pct(LOW_ED,			POPOVER25);

	ED_DEGGRAD			:= l.ED_MAST + l.ED_PROF + l.ED_DOCT;
	HIGH_ED				:= (integer)l.ED_BACH
									+ (integer)ED_DEGGRAD;
	self.HIGH_ED		:=	fn_pct(HIGH_ED,		POPOVER25);

	INCOLLEGE			:=	l.SE_UNDPUB + l.SE_UNDPRI + l.SE_GRADPUB + l.SE_GRADPRI;
	self.INCOLLEGE		:=	fn_pct(INCOLLEGE,		POP);

	self.CIV_EMP		:=	fn_pct(l.EMP_CVTOT,	l.EMP_POTL); //(POP 16+)

	MIL_EMP				:=	(integer)l.EMP_AFFEM
									+(integer)l.EMP_AFMAL;
	self.MIL_EMP		:=	fn_pct(MIL_EMP,		l.EMP_POTL); //(POP 16+)

	self.WHITE_COL		:=	fn_pct(l.WHCOLROCC,	l.EMP_POTL); //(POP 16+)
	self.BLUE_COL		:=	fn_pct(l.BLCOLROCC,	l.EMP_POTL); //(POP 16+)

	NEWHOUSE			:=	l.BLT_00_04 + l.BLT_05P;
	self.NEWHOUSE		:=	get_pct(NEWHOUSE,		owners, true);

	OLDHOUSE			:=	(integer)l.BLT_L39
									+(integer)l.BLT_40_49
									+(integer)l.BLT_50_59
									+(integer)l.BLT_60_69
									+(integer)l.BLT_70_79;
	self.OLDHOUSE		:=	get_pct(OLDHOUSE,		owners, true);
//////////#############################	Pro
	//self.MED_AGE	:=	'0';
	self.MED_AGE := (string)l.MEDAGE;

	self.RETIRED2	:=	'0';

	unemployed := (integer)l.emp_unmal + (integer)l.emp_unfem;
	self.UNEMP		:=	fn_pct(unemployed,	l.EMP_POTL); //(POP 16+)
//	self.UNEMPL		:=	(string)l.UNEMPL;


	self.DOMIN_PROF	:=	'';
	self.CULT_INDX	:=	'0';
	self.AMUS_INDX	:=	'0';
	self.REST_INDX	:=	'0';
	self.MEDI_INDX	:=	'0';
	self.RELIG_INDX	:=	'0';
	self.EDU_INDX	:=	'0';

//////////#############################	Inc
	self.MED_HHINC	:=	tostring(l.MEDHHINC);

	self.IN15K_P	:=	fn_pct(l.HHL15,			HH);
	self.IN25K_P	:=	fn_pct(l.HH15_25,		HH);
	self.IN35K_P	:=	fn_pct(l.HH25_35,		HH);
	self.IN50K_P	:=	fn_pct(l.HH35_50,		HH);
	self.IN75K_P	:=	fn_pct(l.HH50_75,		HH);
	self.IN100K_P	:=	fn_pct(l.HH75_100,		HH);
	self.IN125K_P	:=	fn_pct(l.HH100_125,		HH);
	self.IN150K_P	:=	fn_pct(l.HH125_150,		HH);
	self.IN200K_P	:=	fn_pct(l.HH150_200,		HH);
	self.IN201K_P	:=	fn_pct(l.HH200P,		HH);
//////////#############################	

	LOWINC			:=	(integer)l.HHL15
								+(integer)l.HH15_25
								+(integer)l.HH25_35;
	self.LOWINC		:=	fn_pct(LOWINC,			HH);

	HIGHINC			:=	(integer)l.HH125_150
								+(integer)l.HH150_200
								+(integer)l.HH200P;
	self.HIGHINC	:=	fn_pct(HIGHINC,			HH);
//////////#############################	Ret
	self.TOTSALES	:=	tostring(l.R_TOTSALES);
//////////#############################	NaicsA
	self.BUSINESS		:=	'0';
	self.EMPLOYEES		:=	'0';

	self.AGRICULTURE	:=	'0';
	self.MINING			:=	'0';
	self.CONSTRUCTION	:=	'0';
	self.WHOLESALE		:=	'0';
	self.RETAIL			:=	'0';
	self.TRANSPORT		:=	'0';
	
	self.MANUFACTURING	:=	'0';
	self.INFO			:=	'0';
	self.FINANCE		:=	'0';
	self.PROFESSIONAL	:=	'0';
	self.HEALTH			:=	'0';
	self.FOOD			:=	'0';
	self.BARGAINS	:=	'0';


	self.EXP_PROD	:=	'0';
	self.LUX_PROD	:=	'0';
	self.MORT_INDX	:=	'0';
	self.AB_AV_EDU	:=	'0';
	self.APT20		:=	'0';
	self.RENTAL		:=	'0';
	self.PRESCHL	:=	'0';
	self.BEL_EDU	:=	'0';
	self.BLUE_EMPL	:=	'0';

	self.EXP_HOMES	:=	'0';
	self.NO_TEENS	:=	'0';
	self.FOR_SALE	:=	'0';
	self.ARMFORCE	:=	'0';
	self.LAR_FAM	:=	'0';
	self.NO_MOVE	:=	'0';
	self.MANY_CARS	:=	'0';
	self.MED_INC	:=	'0';
	self.NO_CAR		:=	'0';
	self.NO_LABFOR	:=	'0';
	self.RICH_OLD	:=	'0';
	self.OLD_HOMES	:=	'0';
	self.NEW_HOMES	:=	'0';
	self.RECENT_MOV	:=	'0';
	self.SERV_EMPL	:=	'0';
	self.SUB_BUS	:=	'0';
	self.TRAILER	:=	'0';
	self.UNATTACH	:=	'0';

	bigapt := (integer)l.s_20_49 + (integer)l.s_50p;
	self.BIGAPT_P	:=	fn_pct(bigapt,	l.HOUSEUNITS);
//////////#############################	Oth
	self.MURDERS	:=	'0';
	self.RAPE		:=	'0';
	self.ROBBERY	:=	'0';
	self.ASSAULT	:=	'0';
	self.BURGLARY	:=	'0';
	self.LARCENY	:=	'0';
	self.CARTHEFT	:=	'0';
	self.TOTCRIME	:=	'0';
	self.EASIQLIFE	:=	'0';
	self.CPIALL		:=	'0';
	self.HOUSINGCPI	:=	'0';
//////////#############################	Inc
	self.RICH_ASIAN	:=	'0';
	self.RICH_BLK	:=	'0';
	self.RICH_FAM	:=	'0';
	self.RICH_HISP	:=	'0';
	self.VERY_RICH	:=	'0';
	self.RICH_NFAM	:=	'0';
	self.RICH_WHT	:=	'0';
	self.SPAN_LANG	:=	'0';
	self.WORK_HOME	:=	'0';
	self.RICH_YOUNG	:=	'0';
	self.ASIAN_LANG		:= '0';
	self.BORN_USA		:= '0';
/*	self.SPEAKASI		:= (string)l.SPEAKASI;
	self.SPEAKIEUR		:= (string)l.SPEAKIEUR;
	self.SPEAKOTH		:= (string)l.SPEAKOTH;
	self.SPEAKSPA		:= (string)l.SPEAKSPA;
//////////#############################	Inc
/*	self.AS_CHINESE		:=	fn_pct(l.AS_CHINESE,	l.AS_TOTAL);
	self.AS_FILIPIN		:=	fn_pct(l.AS_FILIPIN,	l.AS_TOTAL);
	self.AS_INDIAN		:=	fn_pct(l.AS_INDIAN,	l.AS_TOTAL);
	self.AS_JAPANES		:=	fn_pct(l.AS_JAPANES,	l.AS_TOTAL);
	self.AS_KOREAN		:=	fn_pct(l.AS_KOREAN,	l.AS_TOTAL);
	self.AS_OTHER		:=	fn_pct(l.AS_OTHER,		l.AS_TOTAL);
	self.AS_VIETNAM		:=	fn_pct(l.AS_VIETNAM,	l.AS_TOTAL);
	self.AS_TOTAL		:= (string)l.AS_TOTAL;

	self.HISP_CUBAN		:=	fn_pct(l.HISP_CUBAN,	l.HISP_TOTAL);
	self.HISP_MEXIC		:=	fn_pct(l.HISP_MEXIC,	l.HISP_TOTAL);
	self.HISP_OTHER		:=	fn_pct(l.HISP_OTHER,	l.HISP_TOTAL);
	self.HISP_PRICA		:=	fn_pct(l.HISP_PRICA,	l.HISP_TOTAL);
	self.HISP_TOTAL		:= (string)l.HISP_TOTAL;
*/

	self	:=	L;
	self	:= [];
end;

