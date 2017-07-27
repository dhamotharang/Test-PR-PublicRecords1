EXPORT Runway_Macro_get_stats(ds_c, ds_p) := FUNCTIONMACRO


// ds_join := JOIN(ds_c, ds_p, LEFT.seq = RIGHT.seq and left.did = right.did, transform(left));

		// ds_curr := JOIN(ds_c, ds_join, LEFT.seq = RIGHT.seq and left.did = right.did, transform(left));
		// ds_prev := JOIN(ds_p, ds_join, LEFT.seq = RIGHT.seq and left.did = right.did, transform(left));

ds_curr := ds_c;
ds_prev := ds_p;		
		
	ds_stat_set :=
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'NAP ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'NAS ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CVI_score ') +
		// Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CVI_reason1 ') +
		// Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CVI_reason2 ') +
		// Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CVI_reason3 ') +
		// Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CVI_reason4 ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AID605_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AID606_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AID606_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AID607_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AID607_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AID607_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AIN509_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AIN602_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AIN605_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AIN605_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AIN605_3_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AIN801_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'ANMK909_0_1_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWD605_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWD605_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWD606_10_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWD606_11_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWD606_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWD606_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWD606_3_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWD606_4_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWD606_6_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWD606_7_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWD606_8_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWD606_9_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWD710_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWN510_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'AWN603_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'BD3605_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'BD5605_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'BD5605_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'BD5605_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'BD5605_3_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'BD9605_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'BD9605_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN1109_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN1205_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN1305_1_0_score ') +
		// CDN1404_1_0_score--------------new models added by Frank on Dec 23, 2014
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN1404_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN1410_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN604_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN604_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN604_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN604_3_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN604_4_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN605_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN606_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN706_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN707_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN712_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN806_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CDN908_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CEN509_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'CSN1007_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD3510_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD3606_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD5510_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD5603_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD5603_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD5603_3_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD5607_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD5609_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD5609_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD5709_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD9510_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD9603_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD9603_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD9603_3_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD9603_4_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD9604_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD9606_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FD9607_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP1109_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP1210_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP1303_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP1401_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP1310_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP1307_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP1303_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP1403_1_0_score ') +
	// FP1404_1_0_score--------------new models added by Frank on Dec 23, 2014
	// FP1407_1_0_score--------------new models added by Frank on Dec 23, 2014
	// FP1406_1_0_score--------------new models added by Frank on Dec 23, 2014
	// FP1407_2_0_score--------------new models added by Dustin on July 22, 2015
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP1404_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP1407_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP1407_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP1406_1_0_score ') +		
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP31105_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP31203_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP31310_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP3710_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP3904_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP3905_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'FP5812_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'HCP1206_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'IDN605_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'IE912_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'IE912_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'IED1106_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'IEN1006_0_1_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'MNC21106_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'MPX1211_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'MSD1010_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'MSN1106_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'MSN605_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'MSN610_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'MV361006_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'MV361006_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'MX361006_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'MX361006_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSB801_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN1001_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN1009_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN1010_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN1103_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN1105_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN1105_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN1105_3_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN1108_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN1108_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN1108_3_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN508_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN509_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN509_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN604_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN607_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN607_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN702_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN704_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN704_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN802_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN803_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN803_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN804_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN807_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN810_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RSN912_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1003_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1007_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1007_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1007_3_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1008_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1008_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1104_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1304_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1304_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1305_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1306_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1309_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1310_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1310_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1310_3_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1311_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1311_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA1311_3_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA611_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA707_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA707_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA709_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVA711_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVB1003_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVB1104_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVB609_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVB703_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVB705_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVB711_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVC1110_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVC1110_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVC1112_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVC1208_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVC1210_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVC1301_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVC1307_1_0_score ') +
	// RVC1405_1_0_score--------------new models added by Frank on Dec 23, 2014
	// RVC1405_2_0_score--------------new models added by Frank on Dec 23, 2014
	// RVC1405_3_0_score--------------new models added by Frank on Dec 23, 2014
	// RVC1405_4_0_score--------------new models added by Frank on Dec 23, 2014
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVC1405_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVC1405_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVC1405_3_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVC1405_4_0_score ') +		
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVD1010_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVD1010_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVD1010_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVD1110_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG1003_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG1103_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG1106_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG1201_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG1302_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG1304_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG1304_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG1401_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG1401_2_0_score ') +
// RVG1310_1_0_score--------------new models added by Frank on Dec 23, 2014
// RVG1404_1_0_score--------------new models added by Frank on Dec 23, 2014
	  Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG1310_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG1404_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG812_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG903_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVG904_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVP1003_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVP1012_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVP1104_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVP1208_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVP1401_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVP1401_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVP804_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVR1003_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVR1008_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVR1103_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVR1104_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVR1210_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVR1303_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVR1311_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVR611_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVR704_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVR711_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVR803_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVS811_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT1003_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT1006_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT1104_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT1104_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT1204_1_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT1210_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT1212_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT612_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT1307_3_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT1402_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT711_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT711_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT803_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'RVT809_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'TBD605_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'TBD609_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'TBD609_2_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'TBN509_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'TBN604_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'TRD605_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'TRD609_1_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'WIN704_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'WOMV002_0_0_score ') +
		Scoring_Project_Macros.Runway_Macro_Stats_Calculation(ds_curr, ds_prev, 'WWN604_1_0_score ') ;

	RETURN ds_stat_set;
	
endmacro;
