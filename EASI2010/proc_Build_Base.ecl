import EASI;

census := File_Vendor.census(geogkey='b');
current_yr := File_Vendor.current_yr(geogkey='b');
five_yr_projection := File_Vendor.five_yr_projection(geogkey='b');

EASIs := EASI.Layout_Easi_Census_v3;
			
decimal6_2 fn_pctn(integer8	dividend ,integer8	divisor) := (decimal6_2)get_pct(dividend, divisor);
fn_pcti(integer8	dividend ,integer8	divisor) := get_pct(dividend, divisor);
fn_pctis(integer8	dividend ,string	divisor) := get_pct(dividend, (integer8)divisor);
fn_pct(integer8	dividend ,integer8	divisor) := get_pct((integer8) dividend, divisor);
fn_pcts(string	dividend ,string	divisor) := get_pct((integer8) dividend, (integer8)divisor);
//fn_pctss(string	dividend ,string	divisor) := get_pct((integer8) dividend, (integer8)divisor);

integer8 add(string s1, string s2) := (integer8)s1 + (integer8)s2;
integer8 add3(string s1, string s2, string s3) := (integer8)s1 + (integer8)s2 + (integer8)s3;
integer8 add4(string s1, string s2, string s3, string s4) := 
				(integer8)s1 + (integer8)s2 + (integer8)s3 + (integer8)s4;
			
tostring(integer n) := TRIM((string)n,LEFT,RIGHT);

Layouts.Layout_Census trCensus(census l) := transform
	self.STATE			:=	l.STAABBRV;
	self.COUNTY			:=	l.FIPS[3..5];
	self.TRACT			:=	l.CENTRACT;
	self.BLKGRP			:=	l.BLOCKGRP;
	self.GEO_BLK		:=	l.CENTRACT+TRIM(l.BLOCKGRP,LEFT,RIGHT);
	self.GEOLINK		:=	l.STAABBRV+l.FIPS[3..5]+TRIM(l.CENTRACT,LEFT,RIGHT)+TRIM(l.BLOCKGRP,LEFT,RIGHT);

	self.POP			:=	l.POP10;
	self.FAMILIES		:=	l.FAMILIES;
	self.HH				:=	l.HH10;

	self.HHSIZE			:=	l.AVGHHSIZE;
	self.MED_HVAL		:=	l.MEDVALOCC;
	self.MED_YEARBLT	:=	l.MED_BLT;
	self.MED_RENT		:=	l.MEDRENT;
	
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
									//+(integer)l.VAL20_40
									//+(integer)l.VAL40_60;
	self.LOW_HVAL		:=	fn_pct(LOW_HVAL,		owners);

	HIGH_HVAL			:=	l.VAL500_750
									+ l.VAL750_100
									+ l.VAL1000P;
	self.HIGH_HVAL		:=	fn_pct(HIGH_HVAL,		owners);

	self.TRAILER_P		:=	fn_pct(l.STRAILER,		l.HOUSEUNITS);

	RETIRED				:=	l.POP_65_74
									+ l.POP_75_84
									+ l.POP_85P;
	self.RETIRED		:=	fn_pct(RETIRED,		POP);

	YOUNG				:=	(integer)l.POP_18_24
									+(integer)l.POP_25_34;
	self.YOUNG			:=	fn_pcti(YOUNG,			POP);

	CHILD				:=	(integer)l.POP_0_5
									+(integer)l.POP_6_11
									+(integer)l.POP_12_17;
	self.CHILD			:=	fn_pcti(CHILD,			POP);

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
	self.NEWHOUSE		:=	fn_pct(NEWHOUSE,		owners);

	OLDHOUSE			:=	(integer)l.BLT_L39
									+(integer)l.BLT_40_49
									+(integer)l.BLT_50_59
									+(integer)l.BLT_60_69
									+(integer)l.BLT_70_79;
	self.OLDHOUSE		:=	fn_pct(OLDHOUSE,		owners);
	unemployed := (integer)l.emp_unmal + (integer)l.emp_unfem;
	self.UNEMP		:=	fn_pct(unemployed,	l.EMP_POTL); //(POP 16+)
	self.UNEMPL		:=	(string)unemployed;
//////////#############################	Pro
/*	self.MED_AGE	:=	'0';

	self.RETIRED2	:=	'0';

	self.DOMIN_PROF	:=	'';
	self.CULT_INDX	:=	'0';
	self.AMUS_INDX	:=	'0';
	self.REST_INDX	:=	'0';
	self.MEDI_INDX	:=	'0';
	self.RELIG_INDX	:=	'0';
	self.EDU_INDX	:=	'0';
*/
//////////#############################	Inc
	self.MED_HHINC	:=	l.MEDHHINC;

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
	self.LOWINC		:=	fn_pcti(LOWINC,				HH);

	HIGHINC			:=	(integer)l.HH125_150
								+(integer)l.HH150_200
								+(integer)l.HH200P;
	self.HIGHINC	:=	fn_pcti(HIGHINC,			HH);
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
/*	self.TRANSPORT		:=	'0';
	
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
*/
	bigapt := (integer)l.s_20_49 + (integer)l.s_50p;
	self.BIGAPT_P	:=	fn_pct(bigapt,	l.HOUSEUNITS);
//////////#############################	Oth
/*	self.MURDERS	:=	'0';
	self.RAPE		:=	'0';
	self.ROBBERY	:=	'0';
	self.ASSAULT	:=	'0';
	self.BURGLARY	:=	'0';
	self.LARCENY	:=	'0';
	self.CARTHEFT	:=	'0';
	self.TOTCRIME	:=	'0';*/
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

Layouts.Layout_Projection trProjected(five_yr_projection l) := transform
	self.STATE			:=	l.STAABBRV;
	self.COUNTY			:=	l.FIPS[3..5];
	self.TRACT			:=	l.CENTRACT;
	self.BLKGRP			:=	l.BLOCKGRP;
	self.GEO_BLK		:=	l.CENTRACT+l.BLOCKGRP;
	self.GEOLINK		:=	l.STAABBRV+l.FIPS[3..5]+l.CENTRACT+l.BLOCKGRP;

	POP := L.POP16;
	HH := L.HH16;
	self.POP			:=	POP;
	self.FAMILIES		:=	l.FAMILIES;
	self.HH			:=	HH;

	self.HHSIZE			:=	l.AVGHHSIZE;
	self.MED_HVAL		:=	l.MEDVALOCC;
	self.MED_YEARBLT	:=	l.MED_BLT;
	self.MED_RENT		:=	l.MEDRENT;
	
	self.URBAN_P		:=	fn_pct(l.URBANPOP,	POP);
	self.RURAL_P		:=	fn_pct(l.RURALPOP,	POP);

	self.FAMMAR_P		:=	fn_pct(l.FAMMAR,	l.FAMILIES);
	self.FAMMAR18_P		:=	fn_pct(l.FAMMAR18,	l.FAMILIES);
	self.FAMOTF18_P		:=	fn_pct(l.FAMOTF18,	l.FAMILIES);

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

	self.VACANT_P		:=	fn_pct(l.VACUNIT,		l.HOUSEUNITS);
	self.OCCUNIT_P		:=	fn_pct(l.OCCUNIT,		l.HOUSEUNITS);
	self.OWNOCP			:=	fn_pct(l.OOCCHH,		l.HOUSEUNITS);
	self.RENTOCP		:=	fn_pct(l.ROCCHH,		l.HOUSEUNITS);
	self.SFDU_P			:=	fn_pct(l.S_1D,			l.HOUSEUNITS);

	self.RNT250_P		:=	fn_pct(l.RNTL250,		l.HOUSEUNITS);
	self.RNT500_P		:=	fn_pct(l.RNT25L50,		l.HOUSEUNITS);
	self.RNT750_P		:=	fn_pct(l.RNT50L75,		l.HOUSEUNITS);
	self.RNT1000_P		:=	fn_pct(l.RNT75L100,	l.HOUSEUNITS);
	self.RNT1250_P		:=	fn_pct(l.RNT100L125,	l.HOUSEUNITS);
	self.RNT1500_P		:=	fn_pct(l.RNT125L150,	l.HOUSEUNITS);
	self.RNT2000_P		:=	fn_pct(l.RNT150L200,	l.HOUSEUNITS);
	self.RNT2001_P		:=	fn_pct(l.RNT2000P,		l.HOUSEUNITS);

	HIGHRENT			:=	(integer)l.RNT125L150
									+(integer)l.RNT150L200
									+(integer)l.RNT2000P;
	self.HIGHRENT		:=	fn_pcti(HIGHRENT,		l.HOUSEUNITS);


	LOWRENT				:=	(integer)l.RNTL250
								+(integer)l.RNT25L50;
	
	
	self.LOWRENT		:=	fn_pcti(LOWRENT,		l.HOUSEUNITS);

	LOWVAL				:=  l.VALL10 + l.VAL10_15 + l.VAL15_20; 
	self.HVAL_20K_P		:=	fn_pct(LOWVAL,		l.HOUSEUNITS);
	self.HVAL_40K_P		:=	fn_pct(l.VAL20_25+l.VAL25_30+l.VAL30_35+l.VAL35_40,		l.HOUSEUNITS);
	self.HVAL_60K_P		:=	fn_pct(l.VAL40_50+l.VAL50_60,		l.HOUSEUNITS);
	self.HVAL_80K_P		:=	fn_pct(l.VAL60_70+l.VAL70_80,		l.HOUSEUNITS);
	self.HVAL_100K_P	:=	fn_pct(l.VAL80_90+l.VAL90_100,	l.HOUSEUNITS);
	self.HVAL_125K_P	:=	fn_pct(l.VAL100_125,	l.HOUSEUNITS);
	self.HVAL_150K_P	:=	fn_pct(l.VAL125_150,	l.HOUSEUNITS);
	self.HVAL_175K_P	:=	fn_pct(l.VAL150_175,	l.HOUSEUNITS);
	self.HVAL_200K_P	:=	fn_pct(l.VAL175_200,	l.HOUSEUNITS);
	self.HVAL_250K_P	:=	fn_pct(l.VAL200_250,	l.HOUSEUNITS);
	self.HVAL_300K_P	:=	fn_pct(l.VAL250_300,	l.HOUSEUNITS);
	self.HVAL_400K_P	:=	fn_pct(l.VAL300_400,	l.HOUSEUNITS);
	self.HVAL_500K_P	:=	fn_pct(l.VAL400_500,	l.HOUSEUNITS);
	self.HVAL_750K_P	:=	fn_pct(l.VAL500_750,	l.HOUSEUNITS);
	self.HVAL_1000K_P	:=	fn_pct(l.VAL750_100,	l.HOUSEUNITS);
	self.HVAL_1001K_P	:=	fn_pct(l.VAL1000P,		l.HOUSEUNITS);

	LOW_HVAL			:=	LOWVAL + l.VAL20_25+l.VAL25_30+l.VAL30_35+l.VAL35_40;	
	self.LOW_HVAL		:=	fn_pct(LOW_HVAL,		l.HOUSEUNITS);

	HIGH_HVAL			:=	(integer)l.VAL500_750
									+(integer)l.VAL750_100
									+(integer)l.VAL1000P;
	self.HIGH_HVAL		:=	fn_pct(HIGH_HVAL,		l.HOUSEUNITS);

	self.TRAILER_P		:=	fn_pct(l.STRAILER,		l.HOUSEUNITS);

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
									+(integer)l.ED_HS
									+(integer)l.ED_COL;
	self.LOW_ED			:=	fn_pct(LOW_ED,			POPOVER25);

	ED_DEGGRAD			:= l.ED_MAST + l.ED_PROF + l.ED_DOCT;
	HIGH_ED				:=	(integer)l.ED_ASSC
									+(integer)l.ED_BACH
									+ ED_DEGGRAD;
	self.HIGH_ED		:=	fn_pct(HIGH_ED,		POPOVER25);

	//INCOLLEGE			:=	(integer)l.SE_COLPRI
	//							+(integer)l.SE_COLPUB;
	INCOLLEGE			:=	l.SE_UNDPUB + l.SE_UNDPRI + l.SE_GRADPUB + l.SE_GRADPRI;
	self.INCOLLEGE		:=	fn_pct(INCOLLEGE,	POP);

	self.CIV_EMP		:=	fn_pct(l.EMP_CVTOT,	l.EMP_POTL); //(POP 16+)

	MIL_EMP				:=	(integer)l.EMP_AFFEM
									+(integer)l.EMP_AFMAL;
	self.MIL_EMP		:=	fn_pct(MIL_EMP,		l.EMP_POTL); //(POP 16+)

	self.WHITE_COL		:=	fn_pct(l.WHCOLROCC,	l.EMP_POTL); //(POP 16+)
	self.BLUE_COL		:=	fn_pct(l.BLCOLROCC,	l.EMP_POTL); //(POP 16+)

	NEWHOUSE			:=	l.BLT_00_04 + l.BLT_05P;
	self.NEWHOUSE		:=	fn_pct(NEWHOUSE,	l.HOUSEUNITS);

	OLDHOUSE			:=	(integer)l.BLT_L39
									+(integer)l.BLT_40_49
									+(integer)l.BLT_50_59;
	self.OLDHOUSE		:=	fn_pct(OLDHOUSE,		l.HOUSEUNITS);
//////////#############################	Pro

//////////#############################	Inc
	self.MED_HHINC	:=	l.MEDHHINC;

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
	self.TOTSALES	:=	tostring(l.R_TOTSALES);
//////////#############################	
//	self.MED_AGE	:=	'0';

	self.RETIRED2	:=	'0';

	self.UNEMP		:=	'0'; 
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
//	self.TRANSPORT		:=	'0';
	
	self.MANUFACTURING	:=	'0';
	self.INFO			:=	'0';
	self.FINANCE		:=	'0';
	self.PROFESSIONAL	:=	'0';
//	self.HEALTH			:=	'0';
//	self.FOOD			:=	'0';
//	self.BARGAINS	:=	'0';
//	self.EXP_PROD	:=	'0';
//	self.LUX_PROD	:=	'0';
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
/*	self.MURDERS	:=	'0';
	self.RAPE		:=	'0';
	self.ROBBERY	:=	'0';
	self.ASSAULT	:=	'0';
	self.BURGLARY	:=	'0';
	self.LARCENY	:=	'0';
	self.CARTHEFT	:=	'0';
	self.TOTCRIME	:=	'0';*/
	self.EASIQLIFE	:=	'0';
	self.CPIALL		:=	'0';
	self.HOUSINGCPI	:=	'0';
//////////#############################	Inc//

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

	self	:=	L;
	self	:= [];
end;


Layouts.Layout_Current_yr trCurrent(current_yr l) := transform
	self.STATE			:=	l.STAABBRV;
	self.COUNTY			:=	l.FIPS[3..5];
	self.TRACT			:=	l.CENTRACT;
	self.BLKGRP			:=	l.BLOCKGRP;
	self.GEO_BLK		:=	l.CENTRACT+l.BLOCKGRP;
	self.GEOLINK		:=	l.STAABBRV+l.FIPS[3..5]+l.CENTRACT+l.BLOCKGRP;

	POP := L.POP11;		// Change for next update
	HH := l.HH11;
	self.POP			:=	POP;
	self.FAMILIES		:=	l.FAMILIES;
	self.HH				:=	HH;

	self.HHSIZE			:=	l.AVGHHSIZE;
	self.MED_HVAL		:=	l.MEDVALOCC;
	self.MED_YEARBLT	:=	l.MED_BLT;
	self.MED_RENT		:=	l.MEDRENT;
	self.URBAN_P		:=	fn_pct(l.URBANPOP,		POP);
	self.RURAL_P		:=	fn_pct(l.RURALPOP,		POP);

	self.FAMMAR_P		:=	fn_pct(l.FAMMAR,	(integer6)l.FAMILIES);
	self.FAMMAR18_P		:=	fn_pct(l.FAMMAR18,	(integer6)l.FAMILIES);
	self.FAMOTF18_P		:=	fn_pct(l.FAMOTF18,	(integer6)l.FAMILIES);

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
	self.MEDAGE	:=	l.MEDAGE;

	self.HH1_P			:=	fn_pct(l.HH1,		HH);
	self.HH2_P			:=	fn_pct(l.HH2,		HH);
	self.HH3_P			:=	fn_pct(l.HH3,		HH);
	self.HH4_P			:=	fn_pct(l.HH4,		HH);
	self.HH5_P			:=	fn_pct(l.HH5,		HH);
	self.HH6_P			:=	fn_pct(l.HH6,		HH);
	self.HH7P_P			:=	fn_pct(l.HH7P,		HH);

	self.VACANT_P		:=	fn_pct(l.VACUNIT,		l.HOUSEUNITS);
	self.OCCUNIT_P		:=	fn_pct(l.OCCUNIT,		l.HOUSEUNITS);
	self.OWNOCP			:=	fn_pct(l.OOCCHH,		l.HOUSEUNITS);
	self.RENTOCP		:=	fn_pct(l.ROCCHH,		l.HOUSEUNITS);
	self.SFDU_P			:=	fn_pct((integer)l.s_1d + (integer)l.s_1a,	l.HOUSEUNITS);

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
	self.HIGHRENT		:=	fn_pcti(HIGHRENT,		renters);


	LOWRENT				:=	(integer)l.RNTL250
								+(integer)l.RNT25L50;
	self.LOWRENT		:=	fn_pcti(LOWRENT,		renters);

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
									+ ED_DEGGRAD;
	self.HIGH_ED		:=	fn_pct(HIGH_ED,		POPOVER25);

	INCOLLEGE			:=	l.SE_UNDPUB + l.SE_UNDPRI + l.SE_GRADPUB + l.SE_GRADPRI;
	self.INCOLLEGE		:=	fn_pct(INCOLLEGE,	POP);

	self.CIV_EMP		:=	fn_pct(l.EMP_CVTOT,	l.EMP_POTL); //(POP 16+)

	MIL_EMP				:=	(integer)l.EMP_AFFEM
									+(integer)l.EMP_AFMAL;
	self.MIL_EMP		:=	fn_pct(MIL_EMP,		l.EMP_POTL); //(POP 16+)

	self.WHITE_COL		:=	fn_pct(l.WHCOLROCC,	l.EMP_POTL); //(POP 16+)
	self.BLUE_COL		:=	fn_pct(l.BLCOLROCC,	l.EMP_POTL); //(POP 16+)

	NEWHOUSE			:=	l.BLT_00_04 + l.BLT_05P;
	self.NEWHOUSE		:=	fn_pct(NEWHOUSE,		owners);

	OLDHOUSE			:=	(integer)l.BLT_L39
									+(integer)l.BLT_40_49
									+(integer)l.BLT_50_59
									+(integer)l.BLT_60_69
									+(integer)l.BLT_70_79;
	self.OLDHOUSE		:=	fn_pct(OLDHOUSE,		owners);
//////////#############################	Pro
	self.MED_AGE	:=	l.MED_AGE;

	self.RETIRED2	:=	TRIM(l.RETIRED,LEFT,RIGHT);

	unemployed := (integer)l.emp_unmal + (integer)l.emp_unfem;
	self.UNEMP		:=	fn_pct(unemployed,	l.EMP_POTL); //(POP 16+)
	self.UNEMPL		:=	(string)L.UNEMPL;


	self.DOMIN_PROF	:=	l.DOMIN_PROF;
	self.CULT_INDX	:=	(string)(l.CULT_INDX);
	self.AMUS_INDX	:=	(string)(l.AMUS_INDX);
	self.REST_INDX	:=	(string)(l.REST_INDX);
	self.MEDI_INDX	:=	(string)(l.MEDI_INDX);
	self.RELIG_INDX	:=	(string)(l.RELIG_INDX);
	self.EDU_INDX	:=	(string)(l.EDU_INDX);
	
//self.BARGAINS	:=	l.BRG_MRKT;
	self.BARGAINS	:=	l.BARGAINS;


	self.EXP_PROD	:=	l.EXP_PROD;
	self.LUX_PROD	:=	l.LUX_PROD;
	self.MORT_INDX	:=	(string)(l.MORT_INDX);
	self.AB_AV_EDU	:=	(string)(l.AB_AV_EDU);
	self.APT20		:=	(string)(l.APT20);
	self.RENTAL		:=	(string)(l.RENTAL);
	self.PRESCHL	:=	(string)(l.PRESCHL);
	self.BEL_EDU	:=	(string)(l.BEL_EDU);
	self.BLUE_EMPL	:=	(string)(l.BLUE_EMPL);

	self.EXP_HOMES	:=	TRIM(l.EXP_HOMES,LEFT,RIGHT);
	self.NO_TEENS	:=	TRIM(l.NO_TEENS,LEFT,RIGHT);
	self.FOR_SALE	:=	TRIM(l.FOR_SALE,LEFT,RIGHT);
	self.ARMFORCE	:=	TRIM(l.ARMFORCE,LEFT,RIGHT);
	self.LAR_FAM	:=	TRIM(l.LAR_FAM,LEFT,RIGHT);
	self.NO_MOVE	:=	TRIM(l.NO_MOVE,LEFT,RIGHT);
	self.MANY_CARS	:=	TRIM(l.MANY_CARS,LEFT,RIGHT);
	self.MED_INC	:=	TRIM(l.MED_INC,LEFT,RIGHT);
	self.NO_CAR		:=	TRIM(l.NO_CAR,LEFT,RIGHT);
	self.NO_LABFOR	:=	TRIM(l.NO_LABFOR,LEFT,RIGHT);
	self.RICH_OLD	:=	TRIM(l.RICH_OLD,LEFT,RIGHT);
	self.OLD_HOMES	:=	TRIM(l.OLD_HOMES,LEFT,RIGHT);
	self.NEW_HOMES	:=	TRIM(l.NEW_HOMES,LEFT,RIGHT);
	self.RECENT_MOV	:=	TRIM(l.RECENT_MOV,LEFT,RIGHT);
	self.SERV_EMPL	:=	TRIM(l.SERV_EMPL,LEFT,RIGHT);
	self.SUB_BUS	:=	TRIM(l.SUB_BUS,LEFT,RIGHT);
	self.TRAILER	:=	TRIM(l.TRAILER,LEFT,RIGHT);
	self.UNATTACH	:=	TRIM(l.UNATTACH,LEFT,RIGHT);
	// self.ASIAN_LANG	:=	l.ASIAN_LANG;
	self.RICH_ASIAN	:=	TRIM(l.RICH_ASIAN,LEFT,RIGHT);
	self.RICH_BLK	:=	TRIM(l.RICH_BLK,LEFT,RIGHT);
	self.RICH_FAM	:=	TRIM(l.RICH_FAM,LEFT,RIGHT);
	self.RICH_HISP	:=	TRIM(l.RICH_HISP,LEFT,RIGHT);
	self.VERY_RICH	:=	TRIM(l.VERY_RICH,LEFT,RIGHT);
	self.RICH_NFAM	:=	TRIM(l.RICH_NFAM,LEFT,RIGHT);
	self.RICH_WHT	:=	TRIM(l.RICH_WHT,LEFT,RIGHT);
	self.SPAN_LANG	:=	TRIM(l.SPAN_LANG,LEFT,RIGHT);
	self.WORK_HOME	:=	TRIM(l.WORK_HOME,LEFT,RIGHT);
	self.RICH_YOUNG	:=	TRIM(l.RICH_YOUNG,LEFT,RIGHT);

	bigapt := (integer)l.s_20_49 + (integer)l.s_50p;
	self.BIGAPT_P	:=	fn_pct(bigapt,	l.HOUSEUNITS);
//////////#############################	Oth
	self.MURDERS	:=	l.MURDERS;
	self.RAPE		:=	l.RAPE;
	self.ROBBERY	:=	l.ROBBERY;
	self.ASSAULT	:=	l.ASSAULT;
	self.BURGLARY	:=	l.BURGLARY;
	self.LARCENY	:=	l.LARCENY;
	self.CARTHEFT	:=	l.CARTHEFT;
	self.TOTCRIME	:=	l.TOTCRIME;
	self.EASIQLIFE	:=	(string)(l.EASIQLIFE);
	self.CPIALL		:=	(string)(l.CPIALL);
	self.HOUSINGCPI	:=	(string)(l.HOUSINGCPI);
//////////#############################	Inc
	self.MED_HHINC	:=	l.MEDHHINC;

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

	HIGHINC			:=	(integer)l.HH150_200
								+(integer)l.HH200P;
	self.HIGHINC	:=	fn_pct(HIGHINC,		HH);
//////////#############################	Ret
	self.TOTSALES	:=	tostring(l.R_TOTSALES);
//////////#############################	NaicsA
	self.BUSINESS		:=	tostring(l.NAIC_T_EST);
	self.EMPLOYEES		:=	tostring(l.NAIC_T_EMP);

	self.AGRICULTURE	:=	fn_pct(l.NAICS11EMP,	l.NAIC_T_EMP);
	self.MINING			:=	fn_pct(l.NAICS21EMP,	l.NAIC_T_EMP);
	self.CONSTRUCTION	:=	fn_pct(l.NAICS23EMP,	l.NAIC_T_EMP);
	self.WHOLESALE		:=	fn_pct(l.NAICS42EMP,	l.NAIC_T_EMP);
	self.RETAIL			:=	fn_pct(l.NAICS44EMP,	l.NAIC_T_EMP);
	self.TRANSPORT		:=	fn_pctn(l.NAICS48EMP,	l.NAIC_T_EMP);
//////////#############################	NaicsB
	self.MANUFACTURING	:=	fn_pct(l.NAICS31EMP,	l.NAIC_T_EMP);
//////////#############################	NaicsC
	self.INFO			:=	fn_pct(l.NAICS51EMP,	l.NAIC_T_EMP);
	self.FINANCE		:=	fn_pct(l.NAICS52EMP,	l.NAIC_T_EMP);
	self.PROFESSIONAL	:=	fn_pct(l.NAICS54EMP,	l.NAIC_T_EMP);
	self.HEALTH			:=	fn_pctn(l.NAICS62EMP,	l.NAIC_T_EMP);
	self.FOOD			:=	fn_pctn(l.NAICS72EMP,	l.NAIC_T_EMP);

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
	self.ASIAN_LANG		:= TRIM(l.ASIAN_LANG,LEFT,RIGHT);
	self.BORN_USA		:= TRIM(l.BORN_USA,LEFT,RIGHT);
// new fields added 2011
	self.NONFAMHHM := L.NONFAMHHMC + L.NONFAMHHMC;
	self.NONFAMHHF := L.NONFAMHHFC + L.NONFAMHHFC;
	self.OTPOP := L.ORPOPA;
	self.OTHH := L.ORHH;
	self.HH75PYR := L.HH75_84YR + L.HH85PYR;
	self.HUOSNIT := L.HOUSEUNITS;
	self.RNT25_50 := L.RNT25L50;
	
	self.VALL20 := L.VAL10_15 + L.VAL15_20;
	self.VAL20_40 := L.VAL20_25 + L.VAL25_30 + L.VAL30_35 + L.VAL35_40;
	self.VAL40_60 := L.VAL40_50 + L.VAL50_60;
	self.VAL60_80 := L.VAL60_70 + L.VAL70_80;
	self.VAL80_100 := L.VAL80_90 + L.VAL90_100;
	
	//self.BLT_99P := L.BLT_00_04 + L.BLT_05P;
	//self.BLT_95_98 := L.BLT_90_99;		// this field no longer exists
	//self.BLT_90_94 := L.BLT_90_99;		// this field no longer exists
	self.BLT_05P := L.BLT_05P;
	self.BLT_00_04 := L.BLT_00_04;
	self.BLT_90_99 := L.BLT_90_99;
	
	//self.MOVE_99P := L.MOV_00_04 + L.MOV_05P;
	//self.MOVE_95_98 := L.MOV_90_99;		// this field no longer exists
	//self.MOVE_90_94 := L.MOV_90_99;		// this field no longer exists
	self.MOV_05P := L.MOV_05P;
	self.MOV_00_04 := L.MOV_00_04;
	self.MOV_90_99 := L.MOV_90_99;
	self.MOV_80_89 := L.MOV_80_89;
	self.MOV_70_79 := L.MOV_70_79;
	self.MOV_L69 := L.MOV_L69;
	
	self.SE_COLPUB := L.SE_UNDPUB + L.SE_GRADPUB;
	self.SE_COLPRI := L.SE_UNDPRI + L.SE_GRADPRI;
	self.ED_SOMCOL := L.ED_COL;
	self.ED_DEGASSC := L.ED_ASSC;
	self.ED_DEGBACH := L.ED_BACH;
	self.ED_DEGGRAD := L.ED_MAST + L.ED_PROF + L.ED_DOCT;
	
	self.EMP_AGRI := L.EMP_AGRIC;
	self.EMP_TRANS := L.EMP_TRANSP;
	self.EMP_FINETC := L.EMP_FININS;
	self.EMP_PROF := L.EMP_PROFES;
	self.EMP_EDUC := L.EMP_EDUCAT;
	self.EMP_PRIV := L.EMP_PRIVCO + L.EMP_PRIVSE;
	
	self.OTMAMEDAGE := L.ORMAMEDAGE;
	self.OTFEMEDAGE := L.ORFEMEDAGE;
	self.OTMEDAGE := L.ORMEDAGE;
	
	self.OMP_0_5 := L.RMP_0_5;
	self.OMP_6_11 := L.RMP_6_11;
	self.OMP_12_17 := L.RMP_12_17;
	self.OMP_18_24 := l.RMP_18_24;
	self.OMP_25_34 := l.RMP_25_34;
	self.OMP_35_44 := l.RMP_35_44;
	self.OMP_45_54 := l.RMP_45_54;
	self.OMP_55_64 := L.RMP_55_64;
	self.OMP_65_74 := L.RMP_65_74;
	self.OMP_75_84 := L.RMP_75_84;
	self.OMP_85P := L.RMP_85P;
	
	self.OFP_0_5 := L.RFP_0_5;
	self.OFP_6_11 := L.RFP_6_11;
	self.OFP_12_17 := L.RFP_12_17;
	self.OFP_18_24 := l.RFP_18_24;
	self.OFP_25_34 := l.RFP_25_34;
	self.OFP_35_44 := l.RFP_35_44;
	self.OFP_45_54 := l.RFP_45_54;
	self.OFP_55_64 := L.RFP_55_64;
	self.OFP_65_74 := L.RFP_65_74;
	self.OFP_75_84 := L.RFP_75_84;
	self.OFP_85P := L.RFP_85P;
	
	self.OTOTHHINC := L.RTOTHHINC;
	self.OMEDHHINC := L.RMEDHHINC;
	self.OAVGHHINC := L.RAVGHHINC;
	self.OPERCAPINC := L.RPERCAPINC;
	self.OHHHINCAVG := L.RHHHINCAVG;
	self.OHHL15 := L.RHHL15;
	self.OHH15_25 := L.RHH15_25;
	self.OHH25_35 := L.RHH25_35;
	self.OHH35_50 := L.RHH35_50;
	self.OHH50_75 := L.RHH50_75;
	self.OHH75_100 := L.RHH75_100;
	self.OHH100_125 := L.RHH100_125;
	self.OHH125_150 := L.RHH125_150;
	self.OHH150_200 := L.RHH150_200;
	self.OHH200P := L.RHH200P;
	
	self.TRAV_15_29 := L.TRAV15_29;
	self.TRAV_30_59 := L.TRAV30_59;
	self.TRAV_60P := L.TRAV60_89 + L.TRAV90P;
	self.ANC_ACADIA := L.ANC_CAJUN;
	self.AS_TOTAL := L.ANC_ASIAN;
	self.HISP_TOTAL := L.ANC_HISP;
	self.NIGHTWEAR := L.MNIGHTWEAR + L.BNIGHTWEAR + L.INIGHTWEAR;
	//self.GAS_TANK := 0;	// field value no longer supplied

	self			:=	l;
	//self			:=	[];
end;

EASI_census := DISTRIBUTE(project(census,trCensus(left)),HASH32(GEOLINK));
EASI_current := DISTRIBUTE(project(current_yr,trCurrent(left)),HASH32(GEOLINK));
EASI_projection := DISTRIBUTE(project(five_yr_projection,trProjected(left)),HASH32(GEOLINK));
legacy_census := project(census,X2000(left));
EASI_legacy := DISTRIBUTE(X2000Addendum(legacy_census,current_yr),HASH32(GEOLINK));

export proc_Build_Base := SEQUENTIAL
	(
	OUTPUT(legacy_census(geolink[1..5] = 'AL001'),named('legsamp')),
	OUTPUT(EASI_legacy(geolink[1..5] = 'AL001'),named('easisamp')),
	OUTPUT(EASI_current(geogkey='b',fips='01001'),named('currsamp')),
			output(EASI_census,,Common.filenameCensus,COMPRESSED,OVERWRITE),
			output(EASI_current,,Common.filenameCurrent,COMPRESSED,OVERWRITE),
			output(EASI_legacy,,Common.filenameLegacy,COMPRESSED,OVERWRITE),
			output(EASI_projection,,Common.filenameProjected,COMPRESSED,OVERWRITE)
	);
			
