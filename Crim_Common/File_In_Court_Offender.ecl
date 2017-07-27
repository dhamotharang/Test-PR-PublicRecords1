// datasets here... no reason for all the attributes at this point...
lNamePrefix := '~thor_data400::in::court_offender_';

lFile_Vendor_01 := dataset(lNamePrefix + 'tx_crim_clean_20050812',					   Layout_In_Court_Offender,flat);
lFile_Vendor_02 := dataset(lNamePrefix + 'wa_scomis_crim_clean_20050727',			   Layout_In_Court_Offender,flat);
lFile_Vendor_03 := dataset(lNamePrefix + 'wa_ltd_juri_crim_clean_20050727',			   Layout_In_Court_Offender,flat);
lFile_Vendor_04 := dataset(lNamePrefix + 'ct_crim_clean_20050826',					   Layout_In_Court_Offender,flat);
lFile_Vendor_05 := dataset(lNamePrefix + 'mn_crim_clean_20050829',					   Layout_In_Court_Offender,flat);
lFile_Vendor_06 := dataset(lNamePrefix + 'ar_crim_clean_20050826',					   Layout_In_Court_Offender,flat);
lFile_Vendor_07 := dataset(lNamePrefix + 'tn_crim_clean_20050408',					   Layout_In_Court_Offender,flat);
//lFile_Vendor_08 := dataset(lNamePrefix + 'nc_crim_clean_20050527',				   Layout_In_Court_Offender,flat);
lFile_Vendor_09 := dataset(lNamePrefix + 'ak_crim_clean_20050709',					   Layout_In_Court_Offender,flat);
lFile_Vendor_10 := dataset(lNamePrefix + 'wi_crim_clean_20030904',					   Layout_In_Court_Offender,flat);
lFile_Vendor_11 := dataset(lNamePrefix + 'az_crim_clean_20050812',					   Layout_In_Court_Offender,flat);
lFile_Vendor_12 := dataset(lNamePrefix + 'va_crim_clean_20050801',					   Layout_In_Court_Offender,flat);
lFile_Vendor_14 := dataset(lNamePrefix + 'ri_crim_clean_20050801',					   Layout_In_Court_Offender,flat);
lFile_Vendor_15 := dataset(lNamePrefix + 'ri_dmv_clean_20050425',					   Layout_In_Court_Offender,flat);
lFile_Vendor_16 := dataset(lNamePrefix + 'ca_san_bernardino_crim_clean_20050727',	   Layout_In_Court_Offender,flat);
lFile_Vendor_17 := dataset(lNamePrefix + 'ca_los_angeles_crim_clean_20050802',		   Layout_In_Court_Offender,flat);
lFile_Vendor_18 := dataset(lNamePrefix + 'fl_dade_crim_clean_20050822',				   Layout_In_Court_Offender,flat);
lFile_Vendor_19 := dataset(lNamePrefix + 'fl_palm_beach_crim_clean_20050818',		   Layout_In_Court_Offender,flat);
lFile_Vendor_20 := dataset(lNamePrefix + 'ca_fresno_crim_clean_20030923',			   Layout_In_Court_Offender,flat);
lFile_Vendor_21 := dataset(lNamePrefix + 'ca_orange_crim_clean_20050823',			   Layout_In_Court_Offender,flat);
lFile_Vendor_22 := dataset(lNamePrefix + 'ca_san_diego_crim_clean_20030919',		   Layout_In_Court_Offender,flat);
lFile_Vendor_23 := dataset(lNamePrefix + 'ca_santa_barbara_crim_clean_20050815',	   Layout_In_Court_Offender,flat);
lFile_Vendor_24 := dataset(lNamePrefix + 'az_pima_crim_clean_20050822',				   Layout_In_Court_Offender,flat);
lFile_Vendor_25 := dataset(lNamePrefix + 'fl_hillsborough_crim_clean_20050829',		   Layout_In_Court_Offender,flat);
lFile_Vendor_26 := dataset(lNamePrefix + 'fl_hillsborough_dmv_clean_20050829',		   Layout_In_Court_Offender,flat);
lFile_Vendor_27 := dataset(lNamePrefix + 'fl_broward_crim_clean_20050829',			   Layout_In_Court_Offender,flat);
lFile_Vendor_28 := dataset(lNamePrefix + 'fl_bay_crim_clean_20050810',				   Layout_In_Court_Offender,flat);
lFile_Vendor_29 := dataset(lNamePrefix + 'ca_contra_costa_crim_clean_20050817',		   Layout_In_Court_Offender,flat);
lFile_Vendor_30 := dataset(lNamePrefix + 'fl_charlotte_crim_clean_20050815',		   Layout_In_Court_Offender,flat);
lFile_Vendor_31 := dataset(lNamePrefix + 'or_crim_clean_20040307',					   Layout_In_Court_Offender,flat);
lFile_Vendor_32 := dataset(lNamePrefix + 'fl_alachua_crim_and_crimtraffic_crim_clean_20050901',	Layout_In_Court_Offender,flat);
//lFile_Vendor_33 := dataset(lNamePrefix + 'fl_alachua_dmv_clean_',					   Layout_In_Court_Offender,flat);
lFile_Vendor_34 := dataset(lNamePrefix + 'fl_duval_crim_and_crimtraffic_clean_20050815',Layout_In_Court_Offender,flat);
lFile_Vendor_35 := dataset(lNamePrefix + 'ms_hinds_crim_clean_20050830',			   Layout_In_Court_Offender,flat);
lFile_Vendor_36 := dataset(lNamePrefix + 'fl_pinellas_crim_clean_20050729',			   Layout_In_Court_Offender,flat);
//lFile_Vendor_37 := dataset(lNamePrefix + 'nc_impaired_drivers_clean_20031117',	   Layout_In_Court_Offender,flat);
lFile_Vendor_38 := dataset(lNamePrefix + 'tx_bexar_crim_clean_20050628',			   Layout_In_Court_Offender,flat);
//lFile_Vendor_39 := dataset(lNamePrefix + 'fl_duval_traffic_crim_clean_20040305',	   Layout_In_Court_Offender,flat);
lFile_Vendor_40 := dataset(lNamePrefix + 'fl_brevard_crim_clean_20050811',			   Layout_In_Court_Offender,flat);
lFile_Vendor_41 := dataset(lNamePrefix + 'nj_crim_clean_20050801',					   Layout_In_Court_Offender,flat);
lFile_Vendor_42 := dataset(lNamePrefix + 'fl_pasco_crim_clean_20050812',			   Layout_In_Court_Offender,flat);
lFile_Vendor_43 := dataset(lNamePrefix + 'fl_pasco_traffic_crim_clean_20050812',	   Layout_In_Court_Offender,flat);
lFile_Vendor_44 := dataset(lNamePrefix + 'fl_osceola_crim_clean_20050822',			   Layout_In_Court_Offender,flat);
lFile_Vendor_45 := dataset(lNamePrefix + 'il_cook_county_crim_clean_20050830',		   Layout_In_Court_Offender,flat);
lFile_Vendor_46 := dataset(lNamePrefix + 'pa_crim_clean_20050831',					   Layout_In_Court_Offender,flat);
lFile_Vendor_47 := dataset(lNamePrefix + 'tx_travis_crim_clean_20050503',			   Layout_In_Court_Offender,flat);
lFile_Vendor_48 := dataset(lNamePrefix + 'ut_crim_clean_20050826',					   Layout_In_Court_Offender,flat);
lFile_Vendor_49 := dataset(lNamePrefix + 'tx_montgomery_crim_clean_20050801',		   Layout_In_Court_Offender,flat);
lFile_Vendor_50 := dataset(lNamePrefix + 'tx_gregg_crim_clean_20050804',			   Layout_In_Court_Offender,flat);
lFile_Vendor_51 := dataset(lNamePrefix + 'tx_potter_crim_clean_20050801',			   Layout_In_Court_Offender,flat);
lFile_Vendor_52 := dataset(lNamePrefix + 'tx_harris_crim_clean_20050801',			   Layout_In_Court_Offender,flat);
lFile_Vendor_53 := dataset(lNamePrefix + 'ca_riverside_crim_clean_20050602',	       Layout_In_Court_Offender,flat);
lFile_Vendor_54 := dataset(lNamePrefix + 'tx_chambers_crim_clean_20050818',	           Layout_In_Court_Offender,flat);
lFile_Vendor_55 := dataset(lNamePrefix + 'ca_sacramento_crim_clean_20050801',	       Layout_In_Court_Offender,flat);
lFile_Vendor_56 := dataset(lNamePrefix + 'ca_santacruz_crim_clean_20040803',	       Layout_In_Court_Offender,flat);
lFile_Vendor_57 := dataset(lNamePrefix + 'va_fairfax_crim_clean_20050705',	           Layout_In_Court_Offender,flat);
lFile_Vendor_58 := dataset(lNamePrefix + 'tx_victoria_crim_clean_20050809',	           Layout_In_Court_Offender,flat);
lFile_Vendor_59 := dataset(lNamePrefix + 'tx_elpaso_crim_clean_20040603',	           Layout_In_Court_Offender,flat);
lFile_Vendor_60 := dataset(lNamePrefix + 'tx_denton_crim_clean_20050801',	           Layout_In_Court_Offender,flat);
lFile_Vendor_61 := dataset(lNamePrefix + 'ok_crim_clean_20050602',	        		   Layout_In_Court_Offender,flat);
lFile_Vendor_62 := dataset(lNamePrefix + 'ca_marin_crim_clean_20050715',	           Layout_In_Court_Offender,flat);
lFile_Vendor_63 := dataset(lNamePrefix + 'fl_lake_traffic_crim_clean_20050902',		   Layout_In_Court_Offender,flat);
lFile_Vendor_64 := dataset(lNamePrefix + 'ca_mendocino_crim_clean_20050818',	       Layout_In_Court_Offender,flat);
lFile_Vendor_65 := dataset(lNamePrefix + 'az_maricopa_crim_clean_20050901',		       Layout_In_Court_Offender,flat);
lFile_Vendor_66 := dataset(lNamePrefix + 'fl_duval_traffic_civil_crim_clean_20050815', Layout_In_Court_Offender,flat);
lFile_Vendor_67 := dataset(lNamePrefix + 'fl_alachua_civiltraffic_clean_20050901',     Layout_In_Court_Offender,flat);
lFile_Vendor_68 := dataset(lNamePrefix + 'fl_orange_crim_clean_20050808',              Layout_In_Court_Offender,flat);
lFile_Vendor_69 := dataset(lNamePrefix + 'fl_aoc_crim_clean_20031008',                 Layout_In_Court_Offender,flat);
lFile_Vendor_70 := dataset(lNamePrefix + 'tx_ftbend_crim_clean_20050808',              Layout_In_Court_Offender,flat);
lFile_Vendor_71 := dataset(lNamePrefix + 'oh_portage_crim_clean_20050809',             Layout_In_Court_Offender,flat);
lFile_Vendor_72 := dataset(lNamePrefix + 'tx_johnson_crim_clean_20050728',             Layout_In_Court_Offender,flat);
lFile_Vendor_73 := dataset(lNamePrefix + 'ca_stanislaus_crim_clean_20050809',          Layout_In_Court_Offender,flat);
lFile_Vendor_74 := dataset(lNamePrefix + 'oh_greene_crim_clean_20050801',              Layout_In_Court_Offender,flat);
lFile_Vendor_75 := dataset(lNamePrefix + 'fl_indianriver_crim_clean_20050815',         Layout_In_Court_Offender,flat);
lFile_Vendor_76 := dataset(lNamePrefix + 'fl_lee_crim_clean_20040914',                 Layout_In_Court_Offender,flat);
lFile_Vendor_77 := dataset(lNamePrefix + 'tx_comal_crim_clean_20040914',               Layout_In_Court_Offender,flat);
lFile_Vendor_78 := dataset(lNamePrefix + 'tx_lamar_crim_clean_20040915',               Layout_In_Court_Offender,flat);
lFile_Vendor_79 := dataset(lNamePrefix + 'tx_parker_crim_clean_20040915',              Layout_In_Court_Offender,flat);
lFile_Vendor_80 := dataset(lNamePrefix + 'tx_tomgreen_crim_clean_20040915',            Layout_In_Court_Offender,flat);
lFile_Vendor_81 := dataset(lNamePrefix + 'ga_crim_clean_20050404',                     Layout_In_Court_Offender,flat);
lFile_Vendor_82 := dataset(lNamePrefix + 'ok_29counties_crim_clean_20050801',          Layout_In_Court_Offender,flat);
lFile_Vendor_83 := dataset(lNamePrefix + 'mi_wayne_crim_clean_20050805',               Layout_In_Court_Offender,flat);
lFile_Vendor_84 := dataset(lNamePrefix + 'ca_ventura_crim_clean_20050803',             Layout_In_Court_Offender,flat);
lFile_Vendor_85 := dataset(lNamePrefix + 'fl_highlands_crim_clean_20050801',           Layout_In_Court_Offender,flat);
lFile_Vendor_86 := dataset(lNamePrefix + 'tx_collin_crim_clean_20050607',              Layout_In_Court_Offender,flat);
lFile_Vendor_87 := dataset(lNamePrefix + 'tx_midland_crim_clean_20050901',             Layout_In_Court_Offender,flat);

export File_In_Court_Offender
 := lFile_Vendor_01		// TX
 +  lFile_Vendor_02		// WA-SCOMIS
 +  lFile_Vendor_03		// WA-Limited Juridcition
 +  lFile_Vendor_04		// CT
 +  lFile_Vendor_05		// MN
 +  lFile_Vendor_06		// AR
 +  lFile_Vendor_07		// TN
// +  lFile_Vendor_08		// NC
 +  lFile_Vendor_09		// AK
 +  lFile_Vendor_10		// WI
 +  lFile_Vendor_11		// AZ
 +  lFile_Vendor_12		// VA (13 skipped in Crim Court)
 +  lFile_Vendor_14		// RI-Criminal
 +  lFile_Vendor_15		// RI-Traffic
 +  lFile_Vendor_16		// CA-San Bernardino County
 +  lFile_Vendor_17		// CA-Los Angeles County
 +  lFile_Vendor_18		// FL-Dade County
 +  lFile_Vendor_19		// FL-Palm Beach County
 +  lFile_Vendor_20		// CA-Fresno County
 +  lFile_Vendor_21		// CA-Orange County
 +  lFile_Vendor_22		// CA-San Diego County
 +  lFile_Vendor_23		// CA-Santa Barbara County
 +  lFile_Vendor_24		// AZ-Pima County
 +  lFile_Vendor_25		// FL-Hillsborough
 +  lFile_Vendor_26		// FL-Hillsborough DMV
 +  lFile_Vendor_27		// FL-Broward
 +  lFile_Vendor_28		// FL-Bay
 +  lFile_Vendor_29		// CA-Contra Costa
 +  lFile_Vendor_30		// FL-Charlotte
 +	lFile_Vendor_31		// OR
 +	lFile_Vendor_32		// FL-Alachua CRIM & CRIM TRAFFIC
 +	lFile_Vendor_34		// FL-Duval County
 +	lFile_Vendor_35		// MS-Hinds County
 +	lFile_Vendor_36		// FL-Pinellas County
 +	lFile_Vendor_38		// TX-Bexar County
 +	lFile_Vendor_40		// FL-Brevard
 +	lFile_Vendor_41		// NJ
 +	lFile_Vendor_42		// FL-Pasco County
 +	lFile_Vendor_43 	// FL-Pasco County DMV
 +	lFile_Vendor_44 	// FL-Osceola County
 +	lFile_Vendor_45 	// IL-Cook County
 +	lFile_Vendor_46 	// PA
 +	lFile_Vendor_47 	// TX-Travis County
 +	lFile_Vendor_48 	// UT
 +	lFile_Vendor_49		// TX-Montgomery County
 +	lFile_Vendor_50		// TX-Gregg
 +	lFile_Vendor_51		// TX-Potter
 +	lFile_Vendor_52		// TX-Harris
 +	lFile_Vendor_53		// CA-Riverside
 +	lFile_Vendor_54		// TX-Chambers
 +	lFile_Vendor_55		// CA-Sacramento
 +	lFile_Vendor_56		// CA-SantaCruz
 +	lFile_Vendor_57		// VA-Fairfax
 +	lFile_Vendor_58		// TX-Victoria
 +	lFile_Vendor_59		// TX-ELPASO
 +	lFile_Vendor_60		// TX-Denton
 +	lFile_Vendor_61		// OK
 +	lFile_Vendor_62		// CA-MARIN
 +	lFile_Vendor_63		// FL-LAKE COUNTY DMV
 +	lFile_Vendor_64		// CA-MENDOCINO
 +	lFile_Vendor_65		// AZ-MARICOPA 
 +	lFile_Vendor_66		// FL-DUVAL CIVIL DMV 
 +	lFile_Vendor_67		// FL-ALACHUA DMV 
 +	lFile_Vendor_68		// FL-ORANGE 
 +	lFile_Vendor_69		// FL-AOC
 +	lFile_Vendor_70		// TX-FT BEND
 +	lFile_Vendor_71		// OH-PORTAGE
 +	lFile_Vendor_72		// TX-JOHNSON
 +	lFile_Vendor_73		// CA-STANISLAUS
 +	lFile_Vendor_74		// OH-GREENE
 +	lFile_Vendor_75		// FL-Indian River
 +	lFile_Vendor_76		// FL-Lee
 +	lFile_Vendor_77		// TX-Comal
 +	lFile_Vendor_78		// TX-Lamar
 +	lFile_Vendor_79		// TX-Parker
 +	lFile_Vendor_80		// TX-Tom Green
 +	lFile_Vendor_81		// GA
 +	lFile_Vendor_82		// OK 29counties
 +	lFile_Vendor_83		// MI Wayne
 +	lFile_Vendor_84		// CA VENTURA
 +	lFile_Vendor_85		// FL HIGHLANDS
 +	lFile_Vendor_86		// TX COLLIN
 +	lFile_Vendor_87		// TX MIDLAND
 
/* Not ready yet...
 +	lFile_Vendor_33		// FL-Alachua DMV
 +	lFile_Vendor_37		// NC-Impaired Drivers
 +	lFile_Vendor_39		// FL-DUVAL CRIMINAL DMV



*/
 ;