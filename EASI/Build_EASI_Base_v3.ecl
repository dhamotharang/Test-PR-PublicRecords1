

//ds_EASI:=EASI.File_EASI;
ds_EASI00 := Files09.File_dems00;
ds_EASI09 := Files09.File_dems09;
ds_EASI10 := Files09.File_dems10;
ds_EASI15 := Files09.File_dems15;

EASIs := EASI.Layout_Census;	//EASI.Layout_Easi_Census_v2;


fn_pct(INTEGER6	dividend ,INTEGER6	divisor)
  :=		(STRING)MAP(
				divisor=0 => -1,
				dividend >= divisor => 100,
				TRUNCATE( (dividend * 1000)/ divisor)/10
			);

EASIs tr00(ds_EASI00 l) := transform
	self.STATE			:=	l.STAABBRV;
	self.COUNTY			:=	l.FIPS[3..5];
	self.TRACT			:=	l.CENTRACT;
	self.BLKGRP			:=	l.BLOCKGRP;
	self.GEO_BLK		:=	l.CENTRACT+TRIM(l.BLOCKGRP,LEFT,RIGHT);
	self.GEOLINK		:=	l.STAABBRV+l.FIPS[3..5]+TRIM(l.CENTRACT,LEFT,RIGHT)+TRIM(l.BLOCKGRP,LEFT,RIGHT);

	self.POP00			:=	(STRING)l.POP00;
	self.FAMILIES		:=	(STRING)l.FAMILIES;
	self.HH00			:=	(STRING)l.HH00;

	self.HHSIZE			:=	(STRING)l.AVGHHSIZE;
	self.MED_HVAL		:=	(STRING)l.MEDVALOCC;
	self.MED_YEARBLT	:=	(STRING)l.MED_BLT;
	self.MED_RENT		:=	(STRING)l.MEDRENT;
	self.URBAN_P		:=	fn_pct(l.URBANPOP,		l.POP00);
	self.RURAL_P		:=	fn_pct(l.RURALPOP,		l.POP00);

	self.FAMMAR_P		:=	fn_pct(l.FAMMAR,		l.FAMILIES);
	self.FAMMAR18_P		:=	fn_pct(l.FAMMAR18,		l.FAMILIES);
	self.FAMOTF18_P		:=	fn_pct(l.FAMOTF18,		l.FAMILIES);

	self.POP_0_5_P		:=	fn_pct(l.POP_0_5,		l.POP00);
	self.POP_6_11_P		:=	fn_pct(l.POP_6_11,		l.POP00);
	self.POP_12_17_P	:=	fn_pct(l.POP_12_17,	l.POP00);
	self.POP_18_24_P	:=	fn_pct(l.POP_18_24,	l.POP00);
	self.POP_25_34_P	:=	fn_pct(l.POP_25_34,	l.POP00);
	self.POP_35_44_P	:=	fn_pct(l.POP_35_44,	l.POP00);
	self.POP_45_54_P	:=	fn_pct(l.POP_45_54,	l.POP00);
	self.POP_55_64_P	:=	fn_pct(l.POP_55_64,	l.POP00);
	self.POP_65_74_P	:=	fn_pct(l.POP_65_74,	l.POP00);
	self.POP_75_84_P	:=	fn_pct(l.POP_75_84,	l.POP00);
	self.POP_85P_P		:=	fn_pct(l.POP_85P,		l.POP00);

	self.HH1_P			:=	fn_pct(l.HH1,			l.HH00);
	self.HH2_P			:=	fn_pct(l.HH2,			l.HH00);
	self.HH3_P			:=	fn_pct(l.HH3,			l.HH00);
	self.HH4_P			:=	fn_pct(l.HH4,			l.HH00);
	self.HH5_P			:=	fn_pct(l.HH5,			l.HH00);
	self.HH6_P			:=	fn_pct(l.HH6,			l.HH00);
	self.HH7P_P			:=	fn_pct(l.HH7P,			l.HH00);

	self.VACANT_P		:=	fn_pct(l.VACUNIT,		l.HUOSNIT);
	self.OCCUNIT_P		:=	fn_pct(l.OCCUNIT,		l.HUOSNIT);
	self.OWNOCP			:=	fn_pct(l.OOCCHH,		l.HUOSNIT);
	self.RENTOCP		:=	fn_pct(l.ROCCHH,		l.HUOSNIT);
	self.SFDU_P			:=	fn_pct(l.S_1D,			l.HUOSNIT);

	self.RNT250_P		:=	fn_pct(l.RNTL250,		l.HUOSNIT);
	self.RNT500_P		:=	fn_pct(l.RNT25_50,		l.HUOSNIT);
	self.RNT750_P		:=	fn_pct(l.RNT50L75,		l.HUOSNIT);
	self.RNT1000_P		:=	fn_pct(l.RNT75L100,	l.HUOSNIT);
	self.RNT1250_P		:=	fn_pct(l.RNT100L125,	l.HUOSNIT);
	self.RNT1500_P		:=	fn_pct(l.RNT125L150,	l.HUOSNIT);
	self.RNT2000_P		:=	fn_pct(l.RNT150L200,	l.HUOSNIT);
	self.RNT2001_P		:=	fn_pct(l.RNT2000P,		l.HUOSNIT);

	HIGHRENT			:=	(integer)l.RNT125L150
									+(integer)l.RNT150L200
									+(integer)l.RNT2000P;
	self.HIGHRENT		:=	fn_pct(HIGHRENT,		l.HUOSNIT);


	LOWRENT				:=	(integer)l.RNTL250
								+(integer)l.RNT25_50;
	self.LOWRENT		:=	fn_pct(LOWRENT,		l.HUOSNIT);

	self.HVAL_20K_P		:=	fn_pct(l.VALL20,		l.HUOSNIT);
	self.HVAL_40K_P		:=	fn_pct(l.VAL20_40,		l.HUOSNIT);
	self.HVAL_60K_P		:=	fn_pct(l.VAL40_60,		l.HUOSNIT);
	self.HVAL_80K_P		:=	fn_pct(l.VAL60_80,		l.HUOSNIT);
	self.HVAL_100K_P	:=	fn_pct(l.VAL80_100,	l.HUOSNIT);
	self.HVAL_125K_P	:=	fn_pct(l.VAL100_125,	l.HUOSNIT);
	self.HVAL_150K_P	:=	fn_pct(l.VAL125_150,	l.HUOSNIT);
	self.HVAL_175K_P	:=	fn_pct(l.VAL150_175,	l.HUOSNIT);
	self.HVAL_200K_P	:=	fn_pct(l.VAL175_200,	l.HUOSNIT);
	self.HVAL_250K_P	:=	fn_pct(l.VAL200_250,	l.HUOSNIT);
	self.HVAL_300K_P	:=	fn_pct(l.VAL250_300,	l.HUOSNIT);
	self.HVAL_400K_P	:=	fn_pct(l.VAL300_400,	l.HUOSNIT);
	self.HVAL_500K_P	:=	fn_pct(l.VAL400_500,	l.HUOSNIT);
	self.HVAL_750K_P	:=	fn_pct(l.VAL500_750,	l.HUOSNIT);
	self.HVAL_1000K_P	:=	fn_pct(l.VAL750_100,	l.HUOSNIT);
	self.HVAL_1001K_P	:=	fn_pct(l.VAL1000P,		l.HUOSNIT);

	LOW_HVAL			:=	(integer)l.VALL20
									+(integer)l.VAL20_40
									+(integer)l.VAL40_60;
	self.LOW_HVAL		:=	fn_pct(LOW_HVAL,		l.HUOSNIT);

	HIGH_HVAL			:=	(integer)l.VAL500_750
									+(integer)l.VAL750_100
									+(integer)l.VAL1000P;
	self.HIGH_HVAL		:=	fn_pct(HIGH_HVAL,		l.HUOSNIT);

	self.TRAILER_P		:=	fn_pct(l.STRAILER,		l.HUOSNIT);

	RETIRED				:=	(integer)l.POP_65_74
									+(integer)l.POP_75_84
									+(integer)l.POP_85P;
	self.RETIRED		:=	fn_pct(RETIRED,		l.POP00);

	YOUNG				:=	(integer)l.POP_18_24
									+(integer)l.POP_25_34;
	self.YOUNG			:=	fn_pct(YOUNG,			l.POP00);

	CHILD				:=	(integer)l.POP_0_5
									+(integer)l.POP_6_11
									+(integer)l.POP_12_17;
	self.CHILD			:=	fn_pct(CHILD,			l.POP00);

	POPOVER18		:=	(integer)l.POP_18_24
									+(integer)l.POP_25_34
									+(integer)l.POP_35_44
									+(integer)l.POP_45_54
									+(integer)l.POP_55_64
									+(integer)l.POP_65_74
									+(integer)l.POP_75_84
									+(integer)l.POP_85P;

	self.POPOVER18 := (string)POPOVER18;
	
	POPOVER25			:=	(integer)l.POP_25_34
									+(integer)l.POP_35_44
									+(integer)l.POP_45_54
									+(integer)l.POP_55_64
									+(integer)l.POP_65_74
									+(integer)l.POP_75_84
									+(integer)l.POP_85P;
	self.POPOVER25		:=	(string)POPOVER25;

	self.FEMDIV_P		:=	fn_pct(l.FEMDIVORCE,	l.POP00);

	LOW_ED				:=	(integer)l.ED_LHS
									+(integer)l.ED_HS
									+(integer)l.ED_SOMCOL;
	self.LOW_ED			:=	fn_pct(LOW_ED,			POPOVER25);

	HIGH_ED				:=	(integer)l.ED_DEGASSC
									+(integer)l.ED_DEGBACH
									+(integer)l.ED_DEGGRAD;
	self.HIGH_ED		:=	fn_pct(HIGH_ED,		POPOVER25);

	INCOLLEGE			:=	(integer)l.SE_COLPRI
								+(integer)l.SE_COLPUB;
	self.INCOLLEGE		:=	fn_pct(INCOLLEGE,		l.POP00);

	self.CIV_EMP		:=	fn_pct(l.EMP_CVTOT,	l.EMP_POTL); //(POP 16+)

	MIL_EMP				:=	(integer)l.EMP_AFFEM
									+(integer)l.EMP_AFMAL;
	self.MIL_EMP		:=	fn_pct(MIL_EMP,		l.EMP_POTL); //(POP 16+)

	self.WHITE_COL		:=	fn_pct(l.WHCOLROCC,	l.EMP_POTL); //(POP 16+)
	self.BLUE_COL		:=	fn_pct(l.BLCOLROCC,	l.EMP_POTL); //(POP 16+)

	NEWHOUSE			:=	(integer)l.BLT_90_94
									+(integer)l.BLT_95_98
									+(integer)l.BLT_99P;
	self.NEWHOUSE		:=	fn_pct(NEWHOUSE,		l.HUOSNIT);

	OLDHOUSE			:=	(integer)l.BLT_L39
									+(integer)l.BLT_40_49
									+(integer)l.BLT_50_59;
	self.OLDHOUSE		:=	fn_pct(OLDHOUSE,		l.HUOSNIT);
//////////#############################	Pro
	self.MED_AGE	:=	'0';

	self.RETIRED2	:=	'0';

	self.UNEMP		:=	'0'; //(POP 16+)
	self.UNEMPL		:=	'0';


	self.DOMIN_PROF	:=	'';
	self.CULT_INDX	:=	'0';
	self.AMUS_INDX	:=	'0';
	self.REST_INDX	:=	'0';
	self.MEDI_INDX	:=	'0';
	self.RELIG_INDX	:=	'0';
	self.EDU_INDX	:=	'0';

//////////#############################	Inc
	self.MED_HHINC	:=	(string)l.MEDHHINC;

	self.IN15K_P	:=	fn_pct(l.HHL15,			l.HH00);
	self.IN25K_P	:=	fn_pct(l.HH15_25,			l.HH00);
	self.IN35K_P	:=	fn_pct(l.HH25_35,			l.HH00);
	self.IN50K_P	:=	fn_pct(l.HH35_50,			l.HH00);
	self.IN75K_P	:=	fn_pct(l.HH50_75,			l.HH00);
	self.IN100K_P	:=	fn_pct(l.HH75_100,			l.HH00);
	self.IN125K_P	:=	fn_pct(l.HH100_125,		l.HH00);
	self.IN150K_P	:=	fn_pct(l.HH125_150,		l.HH00);
	self.IN200K_P	:=	fn_pct(l.HH150_200,		l.HH00);
	self.IN201K_P	:=	fn_pct(l.HH200P,			l.HH00);
//////////#############################	

	LOWINC			:=	(integer)l.HHL15
								+(integer)l.HH15_25
								+(integer)l.HH25_35;
	self.LOWINC		:=	fn_pct(LOWINC,				l.HH00);

	HIGHINC			:=	(integer)l.HH125_150
								+(integer)l.HH150_200
								+(integer)l.HH200P;
	self.HIGHINC	:=	fn_pct(HIGHINC,			l.HH00);
//////////#############################	Ret
	self.TOTSALES	:=	(string)l.R_TOTSALES;
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

	self.BIGAPT_P	:=	'0';
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

	//self			:=	[];
end;

EASIs trProjected(ds_EASI15 l) := transform
	self.STATE			:=	l.STAABBRV;
	self.COUNTY			:=	l.FIPS[3..5];
	self.TRACT			:=	l.CENTRACT;
	self.BLKGRP			:=	l.BLOCKGRP;
	self.GEO_BLK		:=	l.CENTRACT+l.BLOCKGRP;
	self.GEOLINK		:=	l.STAABBRV+l.FIPS[3..5]+l.CENTRACT+l.BLOCKGRP;

	self.POP00			:=	(STRING)l.POP14;	// ***
	self.FAMILIES		:=	(STRING)l.FAMILIES;
	self.HH00			:=	(STRING)l.HH14;		// ***

	self.HHSIZE			:=	(STRING)l.AVGHHSIZE;
	self.MED_HVAL		:=	(STRING)l.MEDVALOCC;
	self.MED_YEARBLT	:=	(STRING)l.MED_BLT;
	self.MED_RENT		:=	(STRING)l.MEDRENT;
	
	POP := l.POP14;
	self.URBAN_P		:=	fn_pct(l.URBANPOP,	POP);
	self.RURAL_P		:=	fn_pct(l.RURALPOP,	POP);

	self.FAMMAR_P		:=	fn_pct(l.FAMMAR,		l.FAMILIES);
	self.FAMMAR18_P		:=	fn_pct(l.FAMMAR18,		l.FAMILIES);
	self.FAMOTF18_P		:=	fn_pct(l.FAMOTF18,		l.FAMILIES);

	self.POP_0_5_P		:=	fn_pct(l.POP_0_5,	POP);
	self.POP_6_11_P		:=	fn_pct(l.POP_6_11,	POP);
	self.POP_12_17_P	:=	fn_pct(l.POP_12_17,	POP);
	self.POP_18_24_P	:=	fn_pct(l.POP_18_24,	POP);
	self.POP_25_34_P	:=	fn_pct(l.POP_25_34,	POP);
	self.POP_35_44_P	:=	fn_pct(l.POP_35_44,	POP);
	self.POP_45_54_P	:=	fn_pct(l.POP_45_54,	POP);
	self.POP_55_64_P	:=	fn_pct(l.POP_55_64,	POP);
	self.POP_65_74_P	:=	fn_pct(l.POP_65_74,	POP);
	self.POP_75_84_P	:=	fn_pct(l.POP_75_84,	POP);
	self.POP_85P_P		:=	fn_pct(l.POP_85P,	POP);

	HH := l.HH14;
	self.HH1_P			:=	fn_pct(l.HH1,		HH);
	self.HH2_P			:=	fn_pct(l.HH2,		HH);
	self.HH3_P			:=	fn_pct(l.HH3,		HH);
	self.HH4_P			:=	fn_pct(l.HH4,		HH);
	self.HH5_P			:=	fn_pct(l.HH5,		HH);
	self.HH6_P			:=	fn_pct(l.HH6,		HH);
	self.HH7P_P			:=	fn_pct(l.HH7P,		HH);

	self.VACANT_P		:=	fn_pct(l.VACUNIT,		l.HUOSNIT);
	self.OCCUNIT_P		:=	fn_pct(l.OCCUNIT,		l.HUOSNIT);
	self.OWNOCP			:=	fn_pct(l.OOCCHH,		l.HUOSNIT);
	self.RENTOCP		:=	fn_pct(l.ROCCHH,		l.HUOSNIT);
	self.SFDU_P			:=	fn_pct(l.S_1D,			l.HUOSNIT);

	self.RNT250_P		:=	fn_pct(l.RNTL250,		l.HUOSNIT);
	self.RNT500_P		:=	fn_pct(l.RNT25_50,		l.HUOSNIT);
	self.RNT750_P		:=	fn_pct(l.RNT50L75,		l.HUOSNIT);
	self.RNT1000_P		:=	fn_pct(l.RNT75L100,	l.HUOSNIT);
	self.RNT1250_P		:=	fn_pct(l.RNT100L125,	l.HUOSNIT);
	self.RNT1500_P		:=	fn_pct(l.RNT125L150,	l.HUOSNIT);
	self.RNT2000_P		:=	fn_pct(l.RNT150L200,	l.HUOSNIT);
	self.RNT2001_P		:=	fn_pct(l.RNT2000P,		l.HUOSNIT);

	HIGHRENT			:=	(integer)l.RNT125L150
									+(integer)l.RNT150L200
									+(integer)l.RNT2000P;
	self.HIGHRENT		:=	fn_pct(HIGHRENT,		l.HUOSNIT);


	LOWRENT				:=	(integer)l.RNTL250
								+(integer)l.RNT25_50;
	self.LOWRENT		:=	fn_pct(LOWRENT,		l.HUOSNIT);

	self.HVAL_20K_P		:=	fn_pct(l.VALL20,		l.HUOSNIT);
	self.HVAL_40K_P		:=	fn_pct(l.VAL20_40,		l.HUOSNIT);
	self.HVAL_60K_P		:=	fn_pct(l.VAL40_60,		l.HUOSNIT);
	self.HVAL_80K_P		:=	fn_pct(l.VAL60_80,		l.HUOSNIT);
	self.HVAL_100K_P	:=	fn_pct(l.VAL80_100,	l.HUOSNIT);
	self.HVAL_125K_P	:=	fn_pct(l.VAL100_125,	l.HUOSNIT);
	self.HVAL_150K_P	:=	fn_pct(l.VAL125_150,	l.HUOSNIT);
	self.HVAL_175K_P	:=	fn_pct(l.VAL150_175,	l.HUOSNIT);
	self.HVAL_200K_P	:=	fn_pct(l.VAL175_200,	l.HUOSNIT);
	self.HVAL_250K_P	:=	fn_pct(l.VAL200_250,	l.HUOSNIT);
	self.HVAL_300K_P	:=	fn_pct(l.VAL250_300,	l.HUOSNIT);
	self.HVAL_400K_P	:=	fn_pct(l.VAL300_400,	l.HUOSNIT);
	self.HVAL_500K_P	:=	fn_pct(l.VAL400_500,	l.HUOSNIT);
	self.HVAL_750K_P	:=	fn_pct(l.VAL500_750,	l.HUOSNIT);
	self.HVAL_1000K_P	:=	fn_pct(l.VAL750_100,	l.HUOSNIT);
	self.HVAL_1001K_P	:=	fn_pct(l.VAL1000P,		l.HUOSNIT);

	LOW_HVAL			:=	(integer)l.VALL20
									+(integer)l.VAL20_40
									+(integer)l.VAL40_60;
	self.LOW_HVAL		:=	fn_pct(LOW_HVAL,		l.HUOSNIT);

	HIGH_HVAL			:=	(integer)l.VAL500_750
									+(integer)l.VAL750_100
									+(integer)l.VAL1000P;
	self.HIGH_HVAL		:=	fn_pct(HIGH_HVAL,		l.HUOSNIT);

	self.TRAILER_P		:=	fn_pct(l.STRAILER,		l.HUOSNIT);

	RETIRED				:=	(integer)l.POP_65_74
									+(integer)l.POP_75_84
									+(integer)l.POP_85P;
	self.RETIRED		:=	fn_pct(RETIRED,		POP);

	YOUNG				:=	(integer)l.POP_18_24
									+(integer)l.POP_25_34;
	self.YOUNG			:=	fn_pct(YOUNG,		POP);

	CHILD				:=	(integer)l.POP_0_5
									+(integer)l.POP_6_11
									+(integer)l.POP_12_17;
	self.CHILD			:=	fn_pct(CHILD,		POP);

	POPOVER18		:=	(integer)l.POP_18_24
									+(integer)l.POP_25_34
									+(integer)l.POP_35_44
									+(integer)l.POP_45_54
									+(integer)l.POP_55_64
									+(integer)l.POP_65_74
									+(integer)l.POP_75_84
									+(integer)l.POP_85P;

	self.POPOVER18 := (string)POPOVER18;
	
	POPOVER25			:=	(integer)l.POP_25_34
									+(integer)l.POP_35_44
									+(integer)l.POP_45_54
									+(integer)l.POP_55_64
									+(integer)l.POP_65_74
									+(integer)l.POP_75_84
									+(integer)l.POP_85P;
	self.POPOVER25		:=	(string)POPOVER25;

	self.FEMDIV_P		:=	fn_pct(l.FEMDIVORCE,	POP);

	LOW_ED				:=	(integer)l.ED_LHS
									+(integer)l.ED_HS
									+(integer)l.ED_SOMCOL;
	self.LOW_ED			:=	fn_pct(LOW_ED,			POPOVER25);

	HIGH_ED				:=	(integer)l.ED_DEGASSC
									+(integer)l.ED_DEGBACH
									+(integer)l.ED_DEGGRAD;
	self.HIGH_ED		:=	fn_pct(HIGH_ED,		POPOVER25);

	INCOLLEGE			:=	(integer)l.SE_COLPRI
								+(integer)l.SE_COLPUB;
	self.INCOLLEGE		:=	fn_pct(INCOLLEGE,	POP);

	self.CIV_EMP		:=	fn_pct(l.EMP_CVTOT,	l.EMP_POTL); //(POP 16+)

	MIL_EMP				:=	(integer)l.EMP_AFFEM
									+(integer)l.EMP_AFMAL;
	self.MIL_EMP		:=	fn_pct(MIL_EMP,		l.EMP_POTL); //(POP 16+)

	self.WHITE_COL		:=	fn_pct(l.WHCOLROCC,	l.EMP_POTL); //(POP 16+)
	self.BLUE_COL		:=	fn_pct(l.BLCOLROCC,	l.EMP_POTL); //(POP 16+)

	NEWHOUSE			:=	(integer)l.BLT_90_94
									+(integer)l.BLT_95_98
									+(integer)l.BLT_99P;
	self.NEWHOUSE		:=	fn_pct(NEWHOUSE,	l.HUOSNIT);

	OLDHOUSE			:=	(integer)l.BLT_L39
									+(integer)l.BLT_40_49
									+(integer)l.BLT_50_59;
	self.OLDHOUSE		:=	fn_pct(OLDHOUSE,		l.HUOSNIT);
//////////#############################	Pro

//////////#############################	Inc
	self.MED_HHINC	:=	(string)l.MEDHHINC;

	self.IN15K_P	:=	fn_pct(l.HHL15,		HH);
	self.IN25K_P	:=	fn_pct(l.HH15_25,	HH);
	self.IN35K_P	:=	fn_pct(l.HH25_35,	HH);
	self.IN50K_P	:=	fn_pct(l.HH35_50,	HH);
	self.IN75K_P	:=	fn_pct(l.HH50_75,	HH);
	self.IN100K_P	:=	fn_pct(l.HH75_100,	HH);
	self.IN125K_P	:=	fn_pct(l.HH100_125,	HH);
	self.IN150K_P	:=	fn_pct(l.HH125_150,	HH);
	self.IN200K_P	:=	fn_pct(l.HH150_200,	HH);
	self.IN201K_P	:=	fn_pct(l.HH200P,	HH);

	LOWINC			:=	(integer)l.HHL15
								+(integer)l.HH15_25
								+(integer)l.HH25_35;
	self.LOWINC		:=	fn_pct(LOWINC,		HH);

	HIGHINC			:=	(integer)l.HH125_150
								+(integer)l.HH150_200
								+(integer)l.HH200P;
	self.HIGHINC	:=	fn_pct(HIGHINC,		HH);
//////////#############################	
	self.TOTSALES	:=	(string)l.R_TOTSALES;
//////////#############################	
	self.MED_AGE	:=	'0';

	self.RETIRED2	:=	'0';

	self.UNEMP		:=	'0'; //(POP 16+)
	self.UNEMPL		:=	'0';


	self.DOMIN_PROF	:=	'';
	self.CULT_INDX	:=	'0';
	self.AMUS_INDX	:=	'0';
	self.REST_INDX	:=	'0';
	self.MEDI_INDX	:=	'0';
	self.RELIG_INDX	:=	'0';
	self.EDU_INDX	:=	'0';
//////////#############################	

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

	self.BIGAPT_P	:=	'0';
//////////#############################	
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
//////////#############################	Inc//

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

//	self.SPEAKASI		:= (string)l.SPEAKASI;
//	self.SPEAKIEUR		:= (string)l.SPEAKIEUR;
//	self.SPEAKOTH		:= (string)l.SPEAKOTH;
//	self.SPEAKSPA		:= (string)l.SPEAKSPA;
	self.ASIAN_LANG		:= '0';
	self.BORN_USA		:= '0';

	//self			:=	l;
	//self.DOMIN_PROF	:=	'';
	//self			:=	[];
end;


EASIs trCurrent(ds_EASI10 l) := transform
	self.STATE			:=	l.STAABBRV;
	self.COUNTY			:=	l.FIPS[3..5];
	self.TRACT			:=	l.CENTRACT;
	self.BLKGRP			:=	l.BLOCKGRP;
	self.GEO_BLK		:=	l.CENTRACT+l.BLOCKGRP;
	self.GEOLINK		:=	l.STAABBRV+l.FIPS[3..5]+l.CENTRACT+l.BLOCKGRP;

	self.POP00			:=	(STRING)l.POP09;		// **
	self.FAMILIES		:=	(STRING)l.FAMILIES;
	self.HH00			:=	(STRING)l.HH09;
	POP := l.POP14;
	HH := l.HH09;

	self.HHSIZE			:=	(STRING)l.AVGHHSIZE;
	self.MED_HVAL		:=	(STRING)l.MEDVALOCC;
	self.MED_YEARBLT	:=	(STRING)l.MED_BLT;
	self.MED_RENT		:=	(STRING)l.MEDRENT;
	self.URBAN_P		:=	fn_pct(l.URBANPOP,		POP);
	self.RURAL_P		:=	fn_pct(l.RURALPOP,		POP);

	self.FAMMAR_P		:=	fn_pct(l.FAMMAR,		l.FAMILIES);
	self.FAMMAR18_P		:=	fn_pct(l.FAMMAR18,		l.FAMILIES);
	self.FAMOTF18_P		:=	fn_pct(l.FAMOTF18,		l.FAMILIES);

	self.POP_0_5_P		:=	fn_pct(l.POP_0_5,	POP);
	self.POP_6_11_P		:=	fn_pct(l.POP_6_11,	POP);
	self.POP_12_17_P	:=	fn_pct(l.POP_12_17,	POP);
	self.POP_18_24_P	:=	fn_pct(l.POP_18_24,	POP);
	self.POP_25_34_P	:=	fn_pct(l.POP_25_34,	POP);
	self.POP_35_44_P	:=	fn_pct(l.POP_35_44,	POP);
	self.POP_45_54_P	:=	fn_pct(l.POP_45_54,	POP);
	self.POP_55_64_P	:=	fn_pct(l.POP_55_64,	POP);
	self.POP_65_74_P	:=	fn_pct(l.POP_65_74,	POP);
	self.POP_75_84_P	:=	fn_pct(l.POP_75_84,	POP);
	self.POP_85P_P		:=	fn_pct(l.POP_85P,	POP);

	self.HH1_P			:=	fn_pct(l.HH1,		HH);
	self.HH2_P			:=	fn_pct(l.HH2,		HH);
	self.HH3_P			:=	fn_pct(l.HH3,		HH);
	self.HH4_P			:=	fn_pct(l.HH4,		HH);
	self.HH5_P			:=	fn_pct(l.HH5,		HH);
	self.HH6_P			:=	fn_pct(l.HH6,		HH);
	self.HH7P_P			:=	fn_pct(l.HH7P,		HH);

	self.VACANT_P		:=	fn_pct(l.VACUNIT,		l.HUOSNIT);
	self.OCCUNIT_P		:=	fn_pct(l.OCCUNIT,		l.HUOSNIT);
	self.OWNOCP			:=	fn_pct(l.OOCCHH,		l.HUOSNIT);
	self.RENTOCP		:=	fn_pct(l.ROCCHH,		l.HUOSNIT);
	self.SFDU_P			:=	fn_pct(l.S_1D,			l.HUOSNIT);

	self.RNT250_P		:=	fn_pct(l.RNTL250,		l.HUOSNIT);
	self.RNT500_P		:=	fn_pct(l.RNT25_50,		l.HUOSNIT);
	self.RNT750_P		:=	fn_pct(l.RNT50L75,		l.HUOSNIT);
	self.RNT1000_P		:=	fn_pct(l.RNT75L100,	l.HUOSNIT);
	self.RNT1250_P		:=	fn_pct(l.RNT100L125,	l.HUOSNIT);
	self.RNT1500_P		:=	fn_pct(l.RNT125L150,	l.HUOSNIT);
	self.RNT2000_P		:=	fn_pct(l.RNT150L200,	l.HUOSNIT);
	self.RNT2001_P		:=	fn_pct(l.RNT2000P,		l.HUOSNIT);

	HIGHRENT			:=	(integer)l.RNT125L150
									+(integer)l.RNT150L200
									+(integer)l.RNT2000P;
	self.HIGHRENT		:=	fn_pct(HIGHRENT,		l.HUOSNIT);


	LOWRENT				:=	(integer)l.RNTL250
								+(integer)l.RNT25_50;
	self.LOWRENT		:=	fn_pct(LOWRENT,		l.HUOSNIT);

	self.HVAL_20K_P		:=	fn_pct(l.VALL20,		l.HUOSNIT);
	self.HVAL_40K_P		:=	fn_pct(l.VAL20_40,		l.HUOSNIT);
	self.HVAL_60K_P		:=	fn_pct(l.VAL40_60,		l.HUOSNIT);
	self.HVAL_80K_P		:=	fn_pct(l.VAL60_80,		l.HUOSNIT);
	self.HVAL_100K_P	:=	fn_pct(l.VAL80_100,	l.HUOSNIT);
	self.HVAL_125K_P	:=	fn_pct(l.VAL100_125,	l.HUOSNIT);
	self.HVAL_150K_P	:=	fn_pct(l.VAL125_150,	l.HUOSNIT);
	self.HVAL_175K_P	:=	fn_pct(l.VAL150_175,	l.HUOSNIT);
	self.HVAL_200K_P	:=	fn_pct(l.VAL175_200,	l.HUOSNIT);
	self.HVAL_250K_P	:=	fn_pct(l.VAL200_250,	l.HUOSNIT);
	self.HVAL_300K_P	:=	fn_pct(l.VAL250_300,	l.HUOSNIT);
	self.HVAL_400K_P	:=	fn_pct(l.VAL300_400,	l.HUOSNIT);
	self.HVAL_500K_P	:=	fn_pct(l.VAL400_500,	l.HUOSNIT);
	self.HVAL_750K_P	:=	fn_pct(l.VAL500_750,	l.HUOSNIT);
	self.HVAL_1000K_P	:=	fn_pct(l.VAL750_100,	l.HUOSNIT);
	self.HVAL_1001K_P	:=	fn_pct(l.VAL1000P,		l.HUOSNIT);

	LOW_HVAL			:=	(integer)l.VALL20
									+(integer)l.VAL20_40
									+(integer)l.VAL40_60;
	self.LOW_HVAL		:=	fn_pct(LOW_HVAL,		l.HUOSNIT);

	HIGH_HVAL			:=	(integer)l.VAL500_750
									+(integer)l.VAL750_100
									+(integer)l.VAL1000P;
	self.HIGH_HVAL		:=	fn_pct(HIGH_HVAL,		l.HUOSNIT);

	self.TRAILER_P		:=	fn_pct(l.STRAILER,		l.HUOSNIT);

	RETIRED				:=	(integer)l.POP_65_74
									+(integer)l.POP_75_84
									+(integer)l.POP_85P;
	self.RETIRED		:=	fn_pct(RETIRED,		POP);

	YOUNG				:=	(integer)l.POP_18_24
									+(integer)l.POP_25_34;
	self.YOUNG			:=	fn_pct(YOUNG,		POP);

	CHILD				:=	(integer)l.POP_0_5
									+(integer)l.POP_6_11
									+(integer)l.POP_12_17;
	self.CHILD			:=	fn_pct(CHILD,		POP);

	POPOVER18		:=	(integer)l.POP_18_24
									+(integer)l.POP_25_34
									+(integer)l.POP_35_44
									+(integer)l.POP_45_54
									+(integer)l.POP_55_64
									+(integer)l.POP_65_74
									+(integer)l.POP_75_84
									+(integer)l.POP_85P;

	self.POPOVER18 := (string)POPOVER18;
	
	POPOVER25			:=	(integer)l.POP_25_34
									+(integer)l.POP_35_44
									+(integer)l.POP_45_54
									+(integer)l.POP_55_64
									+(integer)l.POP_65_74
									+(integer)l.POP_75_84
									+(integer)l.POP_85P;
	self.POPOVER25		:=	(string)POPOVER25;

	self.FEMDIV_P		:=	fn_pct(l.FEMDIVORCE,	POP);

	LOW_ED				:=	(integer)l.ED_LHS
									+(integer)l.ED_HS
									+(integer)l.ED_SOMCOL;
	self.LOW_ED			:=	fn_pct(LOW_ED,			POPOVER25);

	HIGH_ED				:=	(integer)l.ED_DEGASSC
									+(integer)l.ED_DEGBACH
									+(integer)l.ED_DEGGRAD;
	self.HIGH_ED		:=	fn_pct(HIGH_ED,		POPOVER25);

	INCOLLEGE			:=	(integer)l.SE_COLPRI
								+(integer)l.SE_COLPUB;
	self.INCOLLEGE		:=	fn_pct(INCOLLEGE,	POP);

	self.CIV_EMP		:=	fn_pct(l.EMP_CVTOT,	l.EMP_POTL); //(POP 16+)

	MIL_EMP				:=	(integer)l.EMP_AFFEM
									+(integer)l.EMP_AFMAL;
	self.MIL_EMP		:=	fn_pct(MIL_EMP,		l.EMP_POTL); //(POP 16+)

	self.WHITE_COL		:=	fn_pct(l.WHCOLROCC,	l.EMP_POTL); //(POP 16+)
	self.BLUE_COL		:=	fn_pct(l.BLCOLROCC,	l.EMP_POTL); //(POP 16+)

	NEWHOUSE			:=	(integer)l.BLT_90_94
									+(integer)l.BLT_95_98
									+(integer)l.BLT_99P;
	self.NEWHOUSE		:=	fn_pct(NEWHOUSE,		l.HUOSNIT);

	OLDHOUSE			:=	(integer)l.BLT_L39
									+(integer)l.BLT_40_49
									+(integer)l.BLT_50_59;
	self.OLDHOUSE		:=	fn_pct(OLDHOUSE,		l.HUOSNIT);
//////////#############################	Pro
	self.MED_AGE	:=	(string)l.MED_AGE;

	self.RETIRED2	:=	(string)l.RETIRED;

	self.UNEMP		:=	fn_pct(l.UNEMPL,			l.EMP_POTL); //(POP 16+)
	self.UNEMPL		:=	(string)l.UNEMPL;


	self.DOMIN_PROF	:=	l.DOMIN_PROF;
	self.CULT_INDX	:=	(string)l.CULT_INDX;
	self.AMUS_INDX	:=	(string)l.AMUS_INDX;
	self.REST_INDX	:=	(string)l.REST_INDX;
	self.MEDI_INDX	:=	(string)l.MEDI_INDX;
	self.RELIG_INDX	:=	(string)l.RELIG_INDX;
	self.EDU_INDX	:=	(string)l.EDU_INDX;
	
//self.BARGAINS	:=	l.BRG_MRKT;
	self.BARGAINS	:=	(string)l.BARGAINS;


	self.EXP_PROD	:=	(string)l.EXP_PROD;
	self.LUX_PROD	:=	(string)l.LUX_PROD;
	self.MORT_INDX	:=	(string)l.MORT_INDX;
	self.AB_AV_EDU	:=	(string)l.AB_AV_EDU;
	self.APT20		:=	(string)l.APT20;
	self.RENTAL		:=	(string)l.RENTAL;
	self.PRESCHL	:=	(string)l.PRESCHL;
	self.BEL_EDU	:=	(string)l.BEL_EDU;
	self.BLUE_EMPL	:=	(string)l.BLUE_EMPL;

	self.EXP_HOMES	:=	(string)l.EXP_HOMES;
	self.NO_TEENS	:=	(string)l.NO_TEENS;
	self.FOR_SALE	:=	(string)l.FOR_SALE;
	self.ARMFORCE	:=	(string)l.ARMFORCE;
	self.LAR_FAM	:=	(string)l.LAR_FAM;
	self.NO_MOVE	:=	(string)l.NO_MOVE;
	self.MANY_CARS	:=	(string)l.MANY_CARS;
	self.MED_INC	:=	(string)l.MED_INC;
	self.NO_CAR		:=	(string)l.NO_CAR;
	self.NO_LABFOR	:=	(string)l.NO_LABFOR;
	self.RICH_OLD	:=	(string)l.RICH_OLD;
	self.OLD_HOMES	:=	(string)l.OLD_HOMES;
	self.NEW_HOMES	:=	(string)l.NEW_HOMES;
	self.RECENT_MOV	:=	(string)l.RECENT_MOV;
	self.SERV_EMPL	:=	(string)l.SERV_EMPL;
	self.SUB_BUS	:=	(string)l.SUB_BUS;
	self.TRAILER	:=	(string)l.TRAILER;
	self.UNATTACH	:=	(string)l.UNATTACH;
	// self.ASIAN_LANG	:=	l.ASIAN_LANG;
	self.RICH_ASIAN	:=	(string)l.RICH_ASIAN;
	self.RICH_BLK	:=	(string)l.RICH_BLK;
	self.RICH_FAM	:=	(string)l.RICH_FAM;
	self.RICH_HISP	:=	(string)l.RICH_HISP;
	self.VERY_RICH	:=	(string)l.VERY_RICH;
	self.RICH_NFAM	:=	(string)l.RICH_NFAM;
	self.RICH_WHT	:=	(string)l.RICH_WHT;
	self.SPAN_LANG	:=	(string)l.SPAN_LANG;
	self.WORK_HOME	:=	(string)l.WORK_HOME;
	self.RICH_YOUNG	:=	(string)l.RICH_YOUNG;

	self.BIGAPT_P	:=	fn_pct(l.APT20,			l.HUOSNIT);
//////////#############################	Oth
	self.MURDERS	:=	(string)l.MURDERS;
	self.RAPE		:=	(string)l.RAPE;
	self.ROBBERY	:=	(string)l.ROBBERY;
	self.ASSAULT	:=	(string)l.ASSAULT;
	self.BURGLARY	:=	(string)l.BURGLARY;
	self.LARCENY	:=	(string)l.LARCENY;
	self.CARTHEFT	:=	(string)l.CARTHEFT;
	self.TOTCRIME	:=	(string)l.TOTCRIME;
	self.EASIQLIFE	:=	(string)l.EASIQLIFE;
	self.CPIALL		:=	(string)l.CPIALL;
	self.HOUSINGCPI	:=	(string)l.HOUSINGCPI;
//////////#############################	Inc
	self.MED_HHINC	:=	(string)l.MEDHHINC;

	self.IN15K_P	:=	fn_pct(l.HHL15,		HH);
	self.IN25K_P	:=	fn_pct(l.HH15_25,	HH);
	self.IN35K_P	:=	fn_pct(l.HH25_35,	HH);
	self.IN50K_P	:=	fn_pct(l.HH35_50,	HH);
	self.IN75K_P	:=	fn_pct(l.HH50_75,	HH);
	self.IN100K_P	:=	fn_pct(l.HH75_100,	HH);
	self.IN125K_P	:=	fn_pct(l.HH100_125,	HH);
	self.IN150K_P	:=	fn_pct(l.HH125_150,	HH);
	self.IN200K_P	:=	fn_pct(l.HH150_200,	HH);
	self.IN201K_P	:=	fn_pct(l.HH200P,	HH);

	LOWINC			:=	(integer)l.HHL15
								+(integer)l.HH15_25
								+(integer)l.HH25_35;
	self.LOWINC		:=	fn_pct(LOWINC,		HH);

	HIGHINC			:=	(integer)l.HH125_150
								+(integer)l.HH150_200
								+(integer)l.HH200P;
	self.HIGHINC	:=	fn_pct(HIGHINC,		HH);
//////////#############################	Ret
	self.TOTSALES	:=	(string)l.R_TOTSALES;
//////////#############################	NaicsA
	self.BUSINESS		:=	(string)l.NAIC_T_EST;
	self.EMPLOYEES		:=	(string)l.NAIC_T_EMP;

	self.AGRICULTURE	:=	fn_pct(l.NAICS11EMP,	l.NAIC_T_EMP);
	self.MINING			:=	fn_pct(l.NAICS21EMP,	l.NAIC_T_EMP);
	self.CONSTRUCTION	:=	fn_pct(l.NAICS23EMP,	l.NAIC_T_EMP);
	self.WHOLESALE		:=	fn_pct(l.NAICS42EMP,	l.NAIC_T_EMP);
	self.RETAIL			:=	fn_pct(l.NAICS44EMP,	l.NAIC_T_EMP);
	self.TRANSPORT		:=	fn_pct(l.NAICS48EMP,	l.NAIC_T_EMP);
//////////#############################	NaicsB
	self.MANUFACTURING	:=	fn_pct(l.NAICS31EMP,	l.NAIC_T_EMP);
//////////#############################	NaicsC
	self.INFO			:=	fn_pct(l.NAICS51EMP,	l.NAIC_T_EMP);
	self.FINANCE		:=	fn_pct(l.NAICS52EMP,	l.NAIC_T_EMP);
	self.PROFESSIONAL	:=	fn_pct(l.NAICS54EMP,	l.NAIC_T_EMP);
	self.HEALTH			:=	fn_pct(l.NAICS62EMP,	l.NAIC_T_EMP);
	self.FOOD			:=	fn_pct(l.NAICS72EMP,	l.NAIC_T_EMP);

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

	self.SPEAKASI		:= (string)l.SPEAKASI;
	self.SPEAKIEUR		:= (string)l.SPEAKIEUR;
	self.SPEAKOTH		:= (string)l.SPEAKOTH;
	self.SPEAKSPA		:= (string)l.SPEAKSPA;
*/
	self.ASIAN_LANG		:= (string)l.ASIAN_LANG;
	self.BORN_USA		:= (string)l.BORN_USA;

	//self			:=	l;
	//self			:=	[];
end;

EASI_00 := project(ds_EASI00,tr00(left));
//EASI_09 := project(ds_EASI09,tr09(left));
EASI_10 := project(ds_EASI10,trCurrent(left));
EASI_15 := project(ds_EASI15,trProjected(left));

//export Build_EASI_base_v2	:=	sequential	(
//										output(EASI_00,,'~thor_data400::base::easi::'+filedate+'::census_v2'),
//										FileServices.AddSuperfile('~thor_data400::base::easi'
//																	,'~thor_data400::base::easi::'+filedate+'::census_v2',,true)
//										);

//superfile := '~thor_data50::base::easi';

export Build_EASI_Base_v3 := parallel	(
									output(EASI_00,,Files09.filename00,COMPRESSED,OVERWRITE),
									//output(EASI_09,,Files09.filename09,COMPRESSED,OVERWRITE),
									output(EASI_10,,Files09.filename10,COMPRESSED,OVERWRITE),
									output(EASI_15,,Files09.filename15,COMPRESSED,OVERWRITE)
									/*IF (NOT FileServices.SuperFileExists(superfile),
											FileServices.CreateSuperFile(superfile)),
									FileServices.StartSuperFileTransaction(),
									IF(FileServices.FindSuperFileSubName(superfile, filename) > 0,
										FileServices.RemoveSuperFile(superfile, filename, false)), 
									FileServices.AddSuperfile(superfile, filename),
									FileServices.FinishSuperFileTransaction()*/
								);
			