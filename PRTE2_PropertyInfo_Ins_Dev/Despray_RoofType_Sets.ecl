/* ********************************************************************************************************
To get a fresh report:

DS1 := choosen(codes.File_Codes_V3_In(std.str.find(field_name, 'ROOF_TYPE',1) > 0 and 
															std.str.find(file_name, 'PROPERTYINFO', 1) > 0 ),500);
															
OUTPUT(SORT(DS1,field_name2,code,long_desc),all);
OUTPUT(SORT(DS1(field_name2='COMMN'),field_name2,code,long_desc),all);
OUTPUT(SORT(DS1(field_name2='FARES'),field_name2,code,long_desc),all);
OUTPUT(SORT(DS1(field_name2='OKCTY'),field_name2,code,long_desc),all);

******************************************************************************************************** */

EXPORT U_Despray_RoofType_Sets := MODULE

		// -------------------------------------------------------------------------------------------------------------
    SHARED ROOF_TYPE_SET_OKC := 
		['BOT','DOM','FLT','GAB','GOH','GAM','HIP','IRC','MAN','PSC','REC','RRB','SAW','SHD','STF','WOT'];
		SHARED ROOF_TYPE_SET_SIZE_OKC := COUNT(ROOF_TYPE_SET_OKC);
		SHARED ROOF_TYPE_RANDOM_OKC := ROOF_TYPE_SET_OKC[RANDOM() % ROOF_TYPE_SET_SIZE_OKC + 1];
		// -------------------------------------------------------------------------------------------------------------
		// -------------------------------------------------------------------------------------------------------------
		// there were 83 FARES, because the original ECL Terri gave me only reported the first 50 or so we didn't use them all
    SHARED ROOF_TYPE_SET_FARES := 
		['AFR','ALS','ARC','ARC','ARC','BCB','BAJ','BRN','BRN','BRL','BRL','BOW','BOT','BUB','BUB','BUT','BUT','CAN','CAN','CAC',
		'CAC','COM','CMC','CMC','CMC','CMP','CRE','COT','COT','DOR','DOR','FLT','FLT','FLT','FLM','FRM','FRM','GAB','GAB','GAB',
		'GAB','GOH','GOH','GBM','GBR','GBS','GBT','GAM','GAM','GAM','GMN','GMN','GMN','GEO','GEO','HIP','HIP','HIP','IRR','IRW',
		'LNT','MAN','MAN','MAN','MON','MON','NON','OTH','PIT','PIT','PYR','PYR','SAW','SAW','SAW','SHD','SHD','SHW','SWA','SWA',
		'UNK','WOF','WGT'];
		SHARED ROOF_TYPE_SET_SIZE_FARES := COUNT(ROOF_TYPE_SET_FARES);
		SHARED ROOF_TYPE_RANDOM_FARES := ROOF_TYPE_SET_FARES[RANDOM() % ROOF_TYPE_SET_SIZE_FARES + 1];
		// -------------------------------------------------------------------------------------------------------------
		// -------------------------------------------------------------------------------------------------------------
    // SHARED ROOF_TYPE_SET := 
		// ['WOT','AFR','ARC','BRN','BRL','BOT','BUB','BUT','CAN','CAC','CMC','COT','DOR','FLT','FRM','GAB','GOH', 
		// 'GAM', 'GMN', 'GEO','HIP','K00','MAN','PIT','PSC','PYR','REC','RRB','SAW','SHD','SFT','SWA'];
		// SHARED ROOF_TYPE_SET_SIZE := COUNT(ROOF_TYPE_SET);
		// EXPORT ROOF_TYPE_RANDOM := ROOF_TYPE_SET[RANDOM() % ROOF_TYPE_SET_SIZE + 1];
		// -------------------------------------------------------------------------------------------------------------
		EXPORT ROOF_TYPE_RANDOM(STRING type) := IF(type='D',ROOF_TYPE_RANDOM_FARES,ROOF_TYPE_RANDOM_OKC);
		
/*

*/		
END;