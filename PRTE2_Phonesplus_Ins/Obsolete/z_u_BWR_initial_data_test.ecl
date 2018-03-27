IMPORT PRTE2_Phonesplus_Ins, PRTE_CSV;

// Test initial 38K of data to detrmine if data in field are required (exist in all records)
rec := RECORD
	string Field_name;
	string filter;
	string Count_value;
	string Compare_to_Total;
END;

PPL := PRTE_CSV.PhonesPlus.rthor_data400__key__phonesplus__did;
PP := PRTE_CSV.PhonesPlus.dthor_data400__key__phonesplus__did;
TRC := COUNT(PP);


out_rec := DATASET(
			[{'Total Records',						'',				TRC, TRC/TRC*100}
			,{'datevendorfirstreported', 	'=0', 		COUNT(PP(datevendorfirstreported=0)),	COUNT(PP(datevendorfirstreported=0))/TRC*100}
			,{'datevendorlastreported', 	'=0', 		COUNT(PP(datevendorlastreported=0)),	COUNT(PP(datevendorlastreported=0))/TRC*100}
			,{'dt_nonglb_last_seen', 			'=0', 		COUNT(PP(dt_nonglb_last_seen=0)),			COUNT(PP(dt_nonglb_last_seen=0))/TRC*100}
			,{'glb_dppa_flag', 						'=\'\'', 	COUNT(PP(glb_dppa_flag='')),					COUNT(PP(glb_dppa_flag=''))/TRC*100}
			,{'activeflag', 							'=\'\'', 	COUNT(PP(activeflag='')),							COUNT(PP(activeflag=''))/TRC*100}
			,{'confidencescore',					'=0', 		COUNT(PP(confidencescore=0)),					COUNT(PP(confidencescore=0))/TRC*100}
			,{'vendor', 									'=\'\'', 	COUNT(PP(vendor='')),									COUNT(PP(vendor=''))/TRC*100}
			,{'listingtype', 							'=\'\'', 	COUNT(PP(listingtype='')),						COUNT(PP(listingtype=''))/TRC*100}
			,{'ace_fips_st', 							'=\'\'', 	COUNT(PP(ace_fips_st='')),						COUNT(PP(ace_fips_st=''))/TRC*100}
			,{'ace_fips_county', 					'=\'\'', 	COUNT(PP(ace_fips_county='')),				COUNT(PP(ace_fips_county=''))/TRC*100}
			,{'name_score', 							'=\'\'', 	COUNT(PP(name_score='')),							COUNT(PP(name_score=''))/TRC*100}
			,{'did_score', 								'=\'\'', 	COUNT(PP(did_score='')),							COUNT(PP(did_score=''))/TRC*100}
			,{'address1', '=\'orig_not scrambled\'',	COUNT(PP(address1='orig_not scrambled')),		COUNT(PP(address1='orig_not scrambled'))/TRC*100}
			], rec);
	
OUTPUT(out_rec, NAMED('PhonePlus_data_info'));

vendor_rec := RECORD
	PP.vendor;
	GrpCount := COUNT(GROUP);
	dist := COUNT(GROUP)/TRC*100;
END;
vendor_table := TABLE(PP,vendor_rec,vendor,FEW);
OUTPUT(sort(vendor_table,-GrpCount), NAMED('vendor'));

confidencescore_rec := RECORD
	PP.confidencescore;
	GrpCount := COUNT(GROUP);
	dist := COUNT(GROUP)/TRC*100;
END;
confidencescore_table := TABLE(PP,confidencescore_rec,confidencescore,FEW);
OUTPUT(sort(confidencescore_table,-GrpCount), NAMED('confidencescore'));

ace_fips_county_rec := RECORD
	PP.ace_fips_county;
	GrpCount := COUNT(GROUP);
	dist := COUNT(GROUP)/TRC*100;
END;
ace_fips_county_table := TABLE(PP,ace_fips_county_rec,ace_fips_county,FEW);
OUTPUT(sort(ace_fips_county_table,-GrpCount), NAMED('ace_fips_county'));

OUTPUT(PP,NAMED('PP_Boca_data'));

