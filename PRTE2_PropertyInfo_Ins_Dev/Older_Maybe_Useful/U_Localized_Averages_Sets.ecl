// PRTE2_PropertyInfo.U_Localized_Averages_Sets
// a lot of these, I repeated the most common (based on crosstable summary) to simulate weighing more probability
// Others with "SMALL" options, I made sure the first half of the SET contains values suitable to "Smallish" homes

EXPORT U_Localized_Averages_Sets := MODULE

		SHARED SMALL_SQ_FT_INT := 2000;
		SHARED SMALL_SQ_FT_STR := '2001';
		// -------------------------------------------------------------------------------------------------------------
				SHARED BUILDING_SQ_FT_SET := 
		['1250','1262','1271','1283','1299','1317','1336','1363','1364','1382','1385','1393','1395','1408','1427','1450','1465',
		'1487','1506','1535','1541','1571','1592','1618','1631','1655','1674','1702','1708','1741','1763','1788','1797','1819',
		'1842','1875','1882','1915','1931','1955','1969','1992','2016','2052','2060','2090','2108','2134','2150','2206','2249',
		'2334','2336','2382','2404','2428','2450','2484','2510','2570','2572','2628','2650','2689','2714','2750','2780','2843',
		'2846','2884','2900','2927','2942','2966','2980','3002','3010','3054','3112','3184','3226','3314','3366','3456','3514',
		'3736','3885','4114','4168'];

		SHARED BUILDING_SQ_FT_SET_SIZE := COUNT(BUILDING_SQ_FT_SET);
		EXPORT BUILDING_SQ_FT_RANDOM := BUILDING_SQ_FT_SET[RANDOM() % BUILDING_SQ_FT_SET_SIZE + 1];
		EXPORT BUILDING_SQ_FT_FROM(UNSIGNED RND) := BUILDING_SQ_FT_SET[ (RND % BUILDING_SQ_FT_SET_SIZE + 1) ];
		// -------------------------------------------------------------------------------------------------------------

		SHARED ASSESS_VALUE_SET := 
		['14980','17500','18500','20980','25200','28700','32800','36900','41600','45600','49050','53800','59400','65500','70000','80300',
		'87400','90600','96500','99800','100000','102200','104800','107200','110800','114200','116400','119100','121800','124800','127500',
		'129800','132200','135000','138300','141300','145400','151100','157000','163400','171500','176000','185000','192600','198600',
		'211000','220900','235000','253000','277100','325000'];
		// PRTE2_PropertyInfo.U_Localized_Averages_Sets
		SHARED ASSESS_VALUE_SET_SIZE := COUNT(ASSESS_VALUE_SET);
		EXPORT ASSESS_VALUE_RANDOM := ASSESS_VALUE_SET[RANDOM() % ASSESS_VALUE_SET_SIZE + 1];

		// -------------------------------------------------------------------------------------------------------------
		SHARED NUM_BATHS_SET := 
		['2','1','1.5','1.75','1.25','2','1','1.5','3','2.5','4','3.5','2.25','2.75','3.25','3','4','2.5'];
		SHARED NUM_BATHS_SET_SIZE := COUNT(NUM_BATHS_SET);
		SHARED NUM_BATHS_SET_SMALL := NUM_BATHS_SET_SIZE/2;
		EXPORT NUM_BATHS_RANDOM(STRING sqFeet=SMALL_SQ_FT_STR) := IF((INTEGER)sqFeet < SMALL_SQ_FT_INT,
																								NUM_BATHS_SET[RANDOM() % NUM_BATHS_SET_SIZE + 1],
																								NUM_BATHS_SET[RANDOM() % NUM_BATHS_SET_SMALL + 1]);

		// -------------------------------------------------------------------------------------------------------------
		SHARED NUM_FIREPLACE_SET := 
		['0','1','2','3','0','1','2','3','0','1'];
		SHARED NUM_FIREPLACE_SET_SIZE := COUNT(NUM_FIREPLACE_SET);
		EXPORT NUM_FIREPLACE_RANDOM := NUM_FIREPLACE_SET[RANDOM() % NUM_FIREPLACE_SET_SIZE + 1];

		// -------------------------------------------------------------------------------------------------------------
		SHARED NUM_STORIES_SET := 
		['1','2','1.5','1.25','1','2','1','2','1','2','1','2','1.5','5','4','2.5','3','2.5','1.75','4','2.25','3'];
		SHARED NUM_STORIES_SET_SIZE := COUNT(NUM_STORIES_SET);
		SHARED NUM_STORIES_SET_SMALL := NUM_STORIES_SET_SIZE/2;
		EXPORT NUM_STORIES_RANDOM(STRING sqFeet=SMALL_SQ_FT_STR) := IF((INTEGER)sqFeet < SMALL_SQ_FT_INT,
																								NUM_STORIES_SET[RANDOM() % NUM_STORIES_SET_SIZE + 1],
																								NUM_STORIES_SET[RANDOM() % NUM_STORIES_SET_SMALL + 1]);

		// -------------------------------------------------------------------------------------------------------------
		SHARED NUM_BEDROOMS_SET := 
		['3','2','1','3','2','2','2','3','5','4','4','5','5','4','5','6'];
		SHARED NUM_BEDROOMS_SET_SIZE := COUNT(NUM_BEDROOMS_SET);
		SHARED NUM_BEDROOMS_SET_SMALL := NUM_BEDROOMS_SET_SIZE/2;
		EXPORT NUM_BEDROOMS_RANDOM(STRING sqFeet=SMALL_SQ_FT_STR) := IF((INTEGER)sqFeet < SMALL_SQ_FT_INT,
																										NUM_BEDROOMS_SET[RANDOM() % NUM_BEDROOMS_SET_SIZE + 1],
																										NUM_BEDROOMS_SET[RANDOM() % NUM_BEDROOMS_SET_SMALL + 1]);

		// -------------------------------------------------------------------------------------------------------------
		SHARED GARAGE_SQ_FT_SET := 
		['200','216','220','240','250','252','260','264','280','286','288','300',
		'308','312','320','324','336','352','360','364','378','380','384','396',
		'399','400','418','420','432','440','441','450','456','460','462','480',
		'483','484','500','504','506','520','525','528','529','540','546','550',
		'552','560','572','576','600','616','624','640','660','672','676','720'];
		SHARED GARAGE_SQ_FT_SET_SIZE := COUNT(GARAGE_SQ_FT_SET);
		SHARED GARAGE_SQ_FT_SET_SMALL := GARAGE_SQ_FT_SET_SIZE/2;
		EXPORT GARAGE_SQ_FT_RANDOM (STRING sqFeet=SMALL_SQ_FT_STR) := IF((INTEGER)sqFeet < SMALL_SQ_FT_INT,
																			GARAGE_SQ_FT_SET[RANDOM() % GARAGE_SQ_FT_SET_SIZE + 1],
																			GARAGE_SQ_FT_SET[RANDOM() % GARAGE_SQ_FT_SET_SMALL + 1]);

		// -------------------------------------------------------------------------------------------------------------
		SHARED NUM_OF_ROOMS_SET := 
		['7','8','9','10','11','12','13','14','15','16','17','10','11','12','13','14','10','11','12','13','14'];
		SHARED NUM_OF_ROOMS_SET_SMALL := 5;
		SHARED NUM_OF_ROOMS_SET_SIZE := COUNT(NUM_OF_ROOMS_SET);
		EXPORT NUM_OF_ROOMS_RANDOM(STRING sqFeet=SMALL_SQ_FT_STR) := IF((INTEGER)sqFeet < SMALL_SQ_FT_INT,
																										NUM_OF_ROOMS_SET[RANDOM() % NUM_OF_ROOMS_SET_SIZE + 1],
																										NUM_OF_ROOMS_SET[RANDOM() % NUM_OF_ROOMS_SET_SMALL + 1]);


		// -------------------------------------------------------------------------------------------------------------
		SHARED YEAR_BUILT_SET := 
		['1978','2000','1999','2004','1998','1950','2003','1997','2002','1995','1994','1977',
		'1996','1955','1992','1993','1960','1979','2001','1972','1988','1980','1976','1986',
		'1987','1989','1965','1990','1920','1985','1970','1974','1973','1984','1956','2005',
		'1971','1975','1954','1962','1900','1959','1958','1940','1991','1968','1983','1964',
		'1963','1952','1930','1961','1967','1957','1969','1966','1981','1953','1951','1925',
		'1982','1948','1910','1949','1945','1947','1941','1935','1928','1946','1924','1926',
		'1927','1942','1938','1939','1929','1915','1890','1923','1922','1937','1936','1919',
		'1912','1943','2006','1905','1944','1913','1916','1918','1921','1917','1908','1931',
		'1907','2008','1933','1932','1914','1911','1880','1934','1850','1906','1901','1909',
		'1904','2007','1899','1903','1875','1902','1895','1897','1898','1888','1800','1891',
		'2016','1893','2010','2009'];
		SHARED YEAR_BUILT_SET_SIZE := COUNT(YEAR_BUILT_SET);
		EXPORT YEAR_BUILT_RANDOM := YEAR_BUILT_SET[RANDOM() % YEAR_BUILT_SET_SIZE + 1];


		// -------------------------------------------------------------------------------------------------------------
		SHARED AIR_COND_TYPE_SET := 
		['CEN','YES','NON','REF','OTH','CEN','YES','NON','REF','OTH','EVP','WIU','CEN','YES','NON','REF','OTH','EVP',
			'WIU','WAU','PRT'];
		SHARED AIR_COND_TYPE_SET_SIZE := COUNT(AIR_COND_TYPE_SET);
		EXPORT AIR_COND_TYPE_RANDOM := AIR_COND_TYPE_SET[RANDOM() % AIR_COND_TYPE_SET_SIZE + 1];

		// -------------------------------------------------------------------------------------------------------------
		SHARED CONSTR_TYPE_SET := 
		['FRM','WOO','MAS','BRK','CRE','OTH','CNB','FRM','WOO','MAS','BRK','CRE','OTH','CNB','FRM','WOO','MAS','BRK',
			'CRE','OTH','CNB','SRO','LOG','MET','STE','ADB','MAN'];
		SHARED CONSTR_TYPE_SET_SIZE := COUNT(CONSTR_TYPE_SET);
		EXPORT CONSTR_TYPE_RANDOM := CONSTR_TYPE_SET[RANDOM() % CONSTR_TYPE_SET_SIZE + 1];

		// -------------------------------------------------------------------------------------------------------------
		SHARED EXTERIOR_WALL_SET := 
		['SID','WOO','BRS','WOS','BRV','STU','MSN','XXX','OTH','BLO','ASG','MET','COM','CNB','ROC'
		,'SID','WOO','BRS','WOS','BRV','STU','MSN','XXX','OTH','BLO','ASG','MET','COM','CNB','ROC'
		,'SID','WOO','BRS','WOS','BRV','STU','MSN','XXX','OTH','BLO','ASG','MET','COM','CNB','ROC'
		,'WSS','SNW','CRE','LOG','TIL','EIF','GLA','ADO','TLU'];
		SHARED EXTERIOR_WALL_SET_SIZE := COUNT(EXTERIOR_WALL_SET);
		EXPORT EXTERIOR_WALL_RANDOM := EXTERIOR_WALL_SET[RANDOM() % EXTERIOR_WALL_SET_SIZE + 1];

		// -------------------------------------------------------------------------------------------------------------
		SHARED GARAGE_TYPE_SET := 
		['AT0','GAR','DT0','CR0','BS0','MXD','BN0','NON','AT0','GAR','DT0','CR0','BS0','MXD','BN0','NON','YES','AT0',
		'GAR','DT0','CR0','BS0','MXD','BN0','NON','YES','TUC','PAV','CVC','POL'];
		SHARED GARAGE_TYPE_SET_SIZE := COUNT(GARAGE_TYPE_SET);
		EXPORT GARAGE_TYPE_RANDOM := GARAGE_TYPE_SET[RANDOM() % GARAGE_TYPE_SET_SIZE + 1];

		// -------------------------------------------------------------------------------------------------------------
		SHARED HEAT_TYPE_SET := 
		['FA0','CL0','YES','HW0','HP0','00G','00E','FL0','BB0','NON','OTH','RD0','ST0','ZON','FA0','CL0','YES','HW0','HP0','00G',
		'00E','FL0','BB0','NON','OTH','RD0','ST0','ZON','FA0','CL0','YES','HW0','HP0','00G','00E','FL0','BB0','NON','OTH','RD0',
		'ST0','ZON','GR0','VNT','SP0','00O','PRO','00W','00S','00C'];
		SHARED HEAT_TYPE_SET_SIZE := COUNT(HEAT_TYPE_SET);
		EXPORT HEAT_TYPE_RANDOM := HEAT_TYPE_SET[RANDOM() % HEAT_TYPE_SET_SIZE + 1];

		// -------------------------------------------------------------------------------------------------------------
		SHARED FOUNDATION_SET := 
		['CRE','SLB','RAS','CNB','FOT','PIR','OTH','MSN','STO','CRE','SLB','RAS','CNB','FOT','PIR','OTH','MSN',
		'STO','RTW','CRE','SLB','RAS','CNB','FOT','PIR','OTH','MSN','STO','RTW','CRS','WOO','PIL','DRE'];
		SHARED FOUNDATION_SET_SIZE := COUNT(FOUNDATION_SET);
		EXPORT FOUNDATION_RANDOM := FOUNDATION_SET[RANDOM() % FOUNDATION_SET_SIZE + 1];

		// -------------------------------------------------------------------------------------------------------------
		SHARED FLOOR_TYPE_SET := 
		['CRP','WOO','CRV','CRT','CRX','CRW','COV','CRR','OTH','STO','TIL','CXX','CEX','VIN','CER','WOX','CRP','WOO','CRV',
		'CRT','CRX','CRW','COV','CRR','OTH','STO','TIL','CXX','CEX','VIN','CER','WOX','CRY','CEW','TZZ','TLW','TLX','VYW',
		'CNW','CON','CRL','PRQ','TLV','CRF'];
		SHARED FLOOR_TYPE_SET_SIZE := COUNT(FLOOR_TYPE_SET);
		EXPORT FLOOR_TYPE_RANDOM := FLOOR_TYPE_SET[RANDOM() % FLOOR_TYPE_SET_SIZE + 1];

		// -------------------------------------------------------------------------------------------------------------
		SHARED ROOF_COVER_SET := 
		['ASP','COS','SNW','TIL','WSS','MET','CRE','ASB','BUP','SSH','WOO','RLC','ALU','ASP','COS','SNW',
		'TIL','WSS','MET','CRE','ASB','BUP','SSH','WOO','RLC','ALU','OTH','STE','TRG','GRR'];
		SHARED ROOF_COVER_SET_SIZE := COUNT(ROOF_COVER_SET);
		EXPORT ROOF_COVER_RANDOM := ROOF_COVER_SET[RANDOM() % ROOF_COVER_SET_SIZE + 1];
		// -------------------------------------------------------------------------------------------------------------

		// These were actually added a month later - need to populate 50% of these.
		// -------------------------------------------------------------------------------------------------------------
		SHARED FRAME_SET := 
		['BAR','BGW','BJC','BJG','BJR','BJW','BOW','BWS','CCT','CJS','CSB','CSS','FLT','FLX',
			'FRM','GAM','GHP','MAN','MET','MTL','NON','PCT','RCT','SHD','STL','TRJ','TRU','UNK',
			'WDB','WDJ','WDS','WDT','WFM','WOD'];
		SHARED FRAME_SET_SIZE := COUNT(FRAME_SET);
		EXPORT FRAME_RANDOM := FRAME_SET[RANDOM() % FRAME_SET_SIZE + 1];
		// -------------------------------------------------------------------------------------------------------------
		SHARED FUEL_TYPE_SET := 
		['FBU','FCO','FCV','FCW','FEL','FGA','FGS','FKE','FLP','FOI','FOS','FPR','FSO','FWD','FWO','NON','UNK'];
		SHARED FUEL_TYPE_SET_SIZE := COUNT(FUEL_TYPE_SET);
		EXPORT FUEL_TYPE_RANDOM := FUEL_TYPE_SET[RANDOM() % FUEL_TYPE_SET_SIZE + 1];
		// -------------------------------------------------------------------------------------------------------------
    SHARED ROOF_TYPE_SET := 
		['WOT','AFR','ARC','BRN','BRL','BOT','BUB','BUT','CAN','CAC','CMC','COT','DOR','FLT','FRM','GAB','GOH', 
		'GAM', 'GMN', 'GEO','HIP','K00','MAN','PIT','PSC','PYR','REC','RRB','SAW','SHD','SFT','SWA'];
		SHARED ROOF_TYPE_SET_SIZE := COUNT(ROOF_TYPE_SET);
		EXPORT ROOF_TYPE_RANDOM := ROOF_TYPE_SET[RANDOM() % ROOF_TYPE_SET_SIZE + 1];
		// -------------------------------------------------------------------------------------------------------------

END;
