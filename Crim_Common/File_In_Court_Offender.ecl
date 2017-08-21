import CRIM, Crim_Expunctions;
// datasets here... no reason for all the attributes at this point...
lNamePrefix := '~thor_data400::in::court_offender_';

//lFile_Vendor_01 := dataset(lNamePrefix + 'tx_crim_clean_20080215',				   Layout_In_Court_Offender,flat); abinitio graph retired
lFile_Vendor_01 := CRIM.map_TX_Offender; 
lFile_Vendor_02 := dataset(lNamePrefix + 'wa_scomis_crim_clean_20120525',			   Layout_In_Court_Offender,flat);
lFile_Vendor_03 := dataset(lNamePrefix + 'wa_ltd_juri_crim_clean_20120525',			   Layout_In_Court_Offender,flat);
lFile_Vendor_04 := dataset(lNamePrefix + 'ct_crim_clean_20120629',					   Layout_In_Court_Offender,flat);
lFile_Vendor_05 := dataset(lNamePrefix + 'mn_crim_clean_20070718',					   Layout_In_Court_Offender,flat);
lFile_Vendor_06 := dataset(lNamePrefix + 'ar_crim_clean_20120525',					   Layout_In_Court_Offender,flat);
lFile_Vendor_07 := dataset(lNamePrefix + 'tn_crim_clean_20100604',					   Layout_In_Court_Offender,flat);
//lFile_Vendor_08 := dataset(lNamePrefix + 'nc_crim_clean_20110318',				   Layout_In_Court_Offender,flat);
lFile_Vendor_09 := dataset(lNamePrefix + 'ak_crim_clean_20120525',					   Layout_In_Court_Offender,flat);
lFile_Vendor_10 := dataset(lNamePrefix + 'wi_crim_clean_20120525',					   Layout_In_Court_Offender,flat);
lFile_Vendor_11 := dataset(lNamePrefix + 'az_crim_clean_20120615',					   Layout_In_Court_Offender,flat);
lFile_Vendor_12 := dataset(lNamePrefix + 'va_crim_clean_20090605b',					   Layout_In_Court_Offender,flat);
//see Crim.Mapping_VA_Statewide_Offender for case_court translations
lFile_Vendor_14 := dataset(lNamePrefix + 'ri_crim_clean_20070604',					   Layout_In_Court_Offender,flat);
lFile_Vendor_15 := dataset(lNamePrefix + 'ri_dmv_clean_20050425',					   Layout_In_Court_Offender,flat);
lFile_Vendor_16 := dataset(lNamePrefix + 'ca_san_bernardino_crim_clean',	           Layout_In_Court_Offender,flat)
				  +dataset(lNamePrefix + 'ca_san_bernardino_crim_clean_20090904',	   Layout_In_Court_Offender,flat);
//lFile_Vendor_16 := dataset(lNamePrefix + 'ca_san_bernardino_crim_clean_20070615',	           Layout_In_Court_Offender,flat);
lFile_Vendor_17 := dataset(lNamePrefix + 'ca_los_angeles_crim_clean_20111007',		   Layout_In_Court_Offender,flat);
lFile_Vendor_18 := dataset(lNamePrefix + 'fl_dade_crim_clean_20120727',				   Layout_In_Court_Offender,flat);
lFile_Vendor_19 := dataset(lNamePrefix + 'fl_palm_beach_crim_clean_20120406',		   Layout_In_Court_Offender,flat);
lFile_Vendor_20 := dataset(lNamePrefix + 'ca_fresno_crim_clean_20120615',			   Layout_In_Court_Offender,flat);
//lFile_Vendor_21 := dataset(lNamePrefix + 'ca_orange_crim_clean_20080104',			   Layout_In_Court_Offender,flat); abinitio graph retired
lFile_Vendor_21 := CRIM.map_CA_Orange_Offender;
lFile_Vendor_22 := dataset(lNamePrefix + 'ca_san_diego_crim_clean_20120706',		   Layout_In_Court_Offender,flat);
lFile_Vendor_23 := dataset(lNamePrefix + 'ca_santa_barbara_crim_clean_20120727',	   Layout_In_Court_Offender,flat);
lFile_Vendor_24 := dataset(lNamePrefix + 'az_pima_crim_clean_20120713',				   Layout_In_Court_Offender,flat);
lFile_Vendor_25 := dataset(lNamePrefix + 'fl_hillsborough_crim_clean_20120727',		   Layout_In_Court_Offender,flat);
//lFile_Vendor_26 := dataset(lNamePrefix + 'fl_hillsborough_dmv_clean_20091106',		   Layout_In_Court_Offender,flat);
lFile_Vendor_26 := CRIM.Map_FL_Hillsborough_Traffic_Offender;
lFile_Vendor_27 := dataset(lNamePrefix + 'fl_broward_crim_clean_20070219',			   Layout_In_Court_Offender,flat);
lFile_Vendor_28 := dataset(lNamePrefix + 'fl_bay_crim_clean_20120713',				   Layout_In_Court_Offender,flat);
lFile_Vendor_29 := dataset(lNamePrefix + 'ca_contra_costa_crim_clean_20100625',		   Layout_In_Court_Offender,flat);
lFile_Vendor_30 := dataset(lNamePrefix + 'fl_charlotte_crim_clean_20120720',		   Layout_In_Court_Offender,flat);

/*Oregon erroneous duplicate offender_key records removed in b version input file*/
// lFile_Vendor_31 := dataset(lNamePrefix + 'or_crim_clean_20040307',					   Layout_In_Court_Offender,flat);
lFile_Vendor_31 := dataset(lNamePrefix + 'or_crim_clean_20040307b', crim_common.Layout_In_Court_Offender,flat);

lFile_Vendor_32 := dataset(lNamePrefix + 'fl_alachua_crim_and_crimtraffic_crim_clean_20120727',	Layout_In_Court_Offender,flat);
//lFile_Vendor_33 := dataset(lNamePrefix + 'fl_alachua_dmv_clean_',					   Layout_In_Court_Offender,flat);
lFile_Vendor_34 := dataset(lNamePrefix + 'fl_duval_crim_and_crimtraffic_clean_20071019_exp_20120726',Layout_In_Court_Offender,flat);
lFile_Vendor_35 := dataset(lNamePrefix + 'ms_hinds_crim_clean_20120727',			   Layout_In_Court_Offender,flat);
lFile_Vendor_36 := dataset(lNamePrefix + 'fl_pinellas_crim_clean_20120713',			   Layout_In_Court_Offender,flat);
//lFile_Vendor_37 := dataset(lNamePrefix + 'nc_impaired_drivers_clean_20031117',	   Layout_In_Court_Offender,flat);
lFile_Vendor_38 := dataset(lNamePrefix + 'tx_bexar_crim_clean_20120727',			   Layout_In_Court_Offender,flat);
//lFile_Vendor_39 := dataset(lNamePrefix + 'fl_duval_traffic_crim_clean_20040305',	   Layout_In_Court_Offender,flat);
lFile_Vendor_40 := dataset(lNamePrefix + 'fl_brevard_crim_clean_20120720',			   Layout_In_Court_Offender,flat);
lFile_Vendor_41 := dataset(lNamePrefix + 'nj_crim_clean_20120601',					   Layout_In_Court_Offender,flat);
lFile_Vendor_42 := dataset(lNamePrefix + 'fl_pasco_crim_clean_20120727',			   Layout_In_Court_Offender,flat);
lFile_Vendor_43 := dataset(lNamePrefix + 'fl_pasco_traffic_crim_clean_20120727',	   Layout_In_Court_Offender,flat);
lFile_Vendor_44 := dataset(lNamePrefix + 'fl_osceola_crim_clean_20081219',			   Layout_In_Court_Offender,flat);
lFile_Vendor_45 := dataset(lNamePrefix + 'il_cook_county_crim_clean_20120727',		   Layout_In_Court_Offender,flat);
//lFile_Vendor_46 := dataset(lNamePrefix + 'pa_crim_clean_20070711',					   Layout_In_Court_Offender,flat)
//                                       + Crim.map_PA_Offenders
//									                     + Crim.Map_PA_Historical_Offender;
lFile_Vendor_47 := dataset(lNamePrefix + 'tx_travis_crim_clean_20091016',			   Layout_In_Court_Offender,flat);
lFile_Vendor_48 := dataset(lNamePrefix + 'ut_crim_clean_20120713',					   Layout_In_Court_Offender,flat);
lFile_Vendor_49 := dataset(lNamePrefix + 'tx_montgomery_crim_clean_20120727',		   Layout_In_Court_Offender,flat);
lFile_Vendor_50 := dataset(lNamePrefix + 'tx_gregg_crim_clean_20090327',			   Layout_In_Court_Offender,flat);
lFile_Vendor_51 := dataset(lNamePrefix + 'tx_potter_crim_clean_20120720',			   Layout_In_Court_Offender,flat);
lFile_Vendor_52 := dataset(lNamePrefix + 'tx_harris_crim_clean_20120629',			   Layout_In_Court_Offender,flat);
lFile_Vendor_53 := dataset(lNamePrefix + 'ca_riverside_crim_clean_20120601',	       Layout_In_Court_Offender,flat);
lFile_Vendor_54 := dataset(lNamePrefix + 'tx_chambers_crim_clean_20051205',	           Layout_In_Court_Offender,flat);
lFile_Vendor_55 := dataset(lNamePrefix + 'ca_sacramento_crim_clean_20120720',	       Layout_In_Court_Offender,flat);
lFile_Vendor_56 := dataset(lNamePrefix + 'ca_santacruz_crim_clean_20040803',	       Layout_In_Court_Offender,flat);
lFile_Vendor_57 := dataset(lNamePrefix + 'va_fairfax_crim_clean_20050705',	           Layout_In_Court_Offender,flat);
lFile_Vendor_58 := dataset(lNamePrefix + 'tx_victoria_crim_clean_20120713',	           Layout_In_Court_Offender,flat);
lFile_Vendor_59 := dataset(lNamePrefix + 'tx_elpaso_crim_clean_20040603',	           Layout_In_Court_Offender,flat);
lFile_Vendor_60 := dataset(lNamePrefix + 'tx_denton_crim_clean_20110520',	           Layout_In_Court_Offender,flat);
lFile_Vendor_61 := dataset(lNamePrefix + 'ok_crim_clean_20050902b',	        		   Layout_In_Court_Offender,flat);
lFile_Vendor_62 := dataset(lNamePrefix + 'ca_marin_crim_clean_20120113',	           Layout_In_Court_Offender,flat);
lFile_Vendor_63 := dataset(lNamePrefix + 'fl_lake_traffic_crim_clean_20120727',		   Layout_In_Court_Offender,flat);
lFile_Vendor_64 := dataset(lNamePrefix + 'ca_mendocino_crim_clean_20080718',	       Layout_In_Court_Offender,flat);
lFile_Vendor_65 := dataset(lNamePrefix + 'az_maricopa_crim_clean_20100226',		       Layout_In_Court_Offender,flat);
lFile_Vendor_66 := dataset(lNamePrefix + 'fl_duval_traffic_civil_crim_clean_20070615_exp_20120726', Layout_In_Court_Offender,flat);
lFile_Vendor_67 := dataset(lNamePrefix + 'fl_alachua_civiltraffic_clean_20120727',     Layout_In_Court_Offender,flat);
lFile_Vendor_68 := dataset(lNamePrefix + 'fl_orange_crim_clean_20100903',              Layout_In_Court_Offender,flat);
lFile_Vendor_69 := dataset(lNamePrefix + 'fl_aoc_crim_clean_20031008b',                 Layout_In_Court_Offender,flat);
lFile_Vendor_70 := dataset(lNamePrefix + 'tx_ftbend_crim_clean_20100924',              Layout_In_Court_Offender,flat);
lFile_Vendor_71 := dataset(lNamePrefix + 'oh_portage_crim_clean_20120720',             Layout_In_Court_Offender,flat);
lFile_Vendor_72 := dataset(lNamePrefix + 'tx_johnson_crim_clean_20120309',             Layout_In_Court_Offender,flat);
lFile_Vendor_73 := dataset(lNamePrefix + 'ca_stanislaus_crim_clean_20090508',          Layout_In_Court_Offender,flat);
lFile_Vendor_74 := dataset(lNamePrefix + 'oh_greene_crim_clean_20120713',              Layout_In_Court_Offender,flat);
lFile_Vendor_75 := dataset(lNamePrefix + 'fl_indianriver_crim_clean_20120713',         Layout_In_Court_Offender,flat);
lFile_Vendor_76 := dataset(lNamePrefix + 'fl_lee_crim_clean_20040914',                 Layout_In_Court_Offender,flat);
lFile_Vendor_77 := dataset(lNamePrefix + 'tx_comal_crim_clean_20040914',               Layout_In_Court_Offender,flat);
lFile_Vendor_78 := dataset(lNamePrefix + 'tx_lamar_crim_clean_20040915',               Layout_In_Court_Offender,flat);
lFile_Vendor_79 := dataset(lNamePrefix + 'tx_parker_crim_clean_20040915',              Layout_In_Court_Offender,flat);
lFile_Vendor_80 := dataset(lNamePrefix + 'tx_tomgreen_crim_clean_20040915',            Layout_In_Court_Offender,flat);
lFile_Vendor_81 := dataset(lNamePrefix + 'ga_crim_clean_20080328',                     Layout_In_Court_Offender,flat);
lFile_Vendor_82 := dataset(lNamePrefix + 'ok_counties_crim_clean_20100730',            Layout_In_Court_Offender,flat);
lFile_Vendor_83 := dataset(lNamePrefix + 'mi_wayne_crim_clean_20120706',               Layout_In_Court_Offender,flat);
lFile_Vendor_84 := dataset(lNamePrefix + 'ca_ventura_crim_clean_20120629',             Layout_In_Court_Offender,flat);
lFile_Vendor_85 := dataset(lNamePrefix + 'fl_highlands_crim_clean_20120525',           Layout_In_Court_Offender,flat);
lFile_Vendor_86 := dataset(lNamePrefix + 'tx_collin_crim_clean_20101008',              Layout_In_Court_Offender,flat);
lFile_Vendor_87 := dataset(lNamePrefix + 'tx_midland_crim_clean_20120713',             Layout_In_Court_Offender,flat);
lFile_Vendor_88 := dataset(lNamePrefix + 'ia_crim_clean_20120713',                     Layout_In_Court_Offender,flat);
lFile_Vendor_89 := dataset(lNamePrefix + 'oh_putnam_crim_clean_20120706',              Layout_In_Court_Offender,flat);
lFile_Vendor_90 := dataset(lNamePrefix + 'az_mohave_crim_clean_20090213',              Layout_In_Court_Offender,flat);
lFile_Vendor_91 := dataset(lNamePrefix + 'oh_monroe_crim_clean_20120706',              Layout_In_Court_Offender,flat);
lFile_Vendor_92 := dataset(lNamePrefix + 'oh_warren_crim_clean_20120713',              Layout_In_Court_Offender,flat);
lFile_Vendor_93 := dataset(lNamePrefix + 'ms_harrison_crim_clean_20120720',            Layout_In_Court_Offender,flat);
lFile_Vendor_94 := dataset(lNamePrefix + 'tx_brazoria_crim_clean_20060801',            Layout_In_Court_Offender,flat);
lFile_Vendor_95 := dataset(lNamePrefix + 'oh_montgomery_crim_clean_20120706',          Layout_In_Court_Offender,flat);
//lFile_Vendor_96 := dataset(lNamePrefix + 'md_crim_clean_20080125',                     Layout_In_Court_Offender,flat);
lFile_Vendor_96 := CRIM.map_MD_Offender;
lFile_Vendor_97 := dataset(lNamePrefix + 'tx_williamson_crim_clean_20110415',          Layout_In_Court_Offender,flat);
lFile_Vendor_98 := dataset(lNamePrefix + 'tx_waller_crim_clean_20120727',              Layout_In_Court_Offender,flat);
lFile_Vendor_1A := dataset(lNamePrefix + 'oh_auglaize_crim_clean_20120622',            Layout_In_Court_Offender,flat);
lFile_Vendor_1B := dataset(lNamePrefix + 'fl_manatee_crim_clean_20120727',             Layout_In_Court_Offender,flat);
lFile_Vendor_1C := dataset(lNamePrefix + 'oh_allen_crim_clean_20120727',            Layout_In_Court_Offender,flat);
lFile_Vendor_1D := dataset(lNamePrefix + 'oh_butler_crim_clean_20090626',             Layout_In_Court_Offender,flat);
//lFile_Vendor_1E := dataset(lNamePrefix + 'oh_champaign_crim_clean_20101029',            Layout_In_Court_Offender,flat);
lFile_Vendor_1E := CRIM.Map_OH_Champaign_Offender;
lFile_Vendor_1F := dataset(lNamePrefix + 'oh_clermont_crim_clean_20090731',             Layout_In_Court_Offender,flat);
lFile_Vendor_1G := dataset(lNamePrefix + 'oh_columbiana_crim_clean_20090626',            Layout_In_Court_Offender,flat);
lFile_Vendor_1H := dataset(lNamePrefix + 'oh_delaware_crim_clean_20090626',             Layout_In_Court_Offender,flat);
lFile_Vendor_1I := dataset(lNamePrefix + 'oh_fairfield_crim_clean_20120316',             Layout_In_Court_Offender,flat);
lFile_Vendor_1J := CRIM.Map_CO_Denver_Offender;
lFile_Vendor_1Y := CRIM.Map_MO_StatewideOffender;
lFile_Vendor_1K := CRIM.map_CA_SantaClara_Offender;
lFile_Vendor_1O := CRIM.map_OH_Trumbull_Offender;
lFile_Vendor_1N := CRIM.map_OH_Medina_Offender;
lFile_Vendor_1P := CRIM.map_OH_Tuscarawas_Offender;
lFile_Vendor_1M := CRIM.map_OH_Sandusky_Offender;
lFile_Vendor_1S := CRIM.map_OK_Adair_Offender;
lFile_Vendor_1T := CRIM.map_OK_Canadian_Offender;
lFile_Vendor_1U := CRIM.map_OK_Cleveland_Offender;
lFile_Vendor_1V := CRIM.map_OK_Comanche_Offender;
lFile_Vendor_1W := CRIM.map_OK_Garfield_Offender;
lFile_Vendor_1X := CRIM.map_OK_Ellis_Offender;
lFile_Vendor_1L := CRIM.map_OH_Lake_Offender;
lFile_Vendor_1R := CRIM.Map_OH_Hamilton_Offender;
lFile_Vendor_1Z := CRIM.map_OK_Logan_Offender;
lFile_Vendor_2A := CRIM.map_OK_Oklahoma_Offender;
lFile_Vendor_2B := CRIM.map_OK_Payne_Offender;
lFile_Vendor_2C := CRIM.map_OK_Pushmataha_Offender;
lFile_Vendor_2D := CRIM.map_OK_Rogers_Offender;
lFile_Vendor_2E := CRIM.map_OK_Tulsa_Offender;
lFile_Vendor_2F := CRIM.map_OK_RogerMills_Offender;
lFile_Vendor_2G := CRIM.map_GA_Cobb_Offender;
lFile_Vendor_2H := CRIM.Map_OH_Hancock_Offender;
lFile_Vendor_2I := CRIM.map_OH_Fulton_Offender;
lFile_Vendor_2J := CRIM.map_OH_Licking_Offender;
lFile_Vendor_2K := crim.Map_OH_Richland_Offender;
lFile_Vendor_2L := crim.Map_OH_Wayne_Offender;
lFile_Vendor_2M := crim.Map_FL_Marion_Offender;
lFile_Vendor_2N := crim.Map_LA_St_Tammany_Offender;
lFile_Vendor_2S := CRIM.Map_HI_Offender;
lFile_Vendor_2T := CRIM.Map_FL_Hernando_Offender;
lFile_Vendor_2P := CRIM.Map_OH_Franklin_Offender;
lFile_Vendor_2O := CRIM.Map_OH_Mahoning_Offender;
lFile_Vendor_2Q := CRIM.Map_SC_Greenville_Offender;
lFile_Vendor_2U := CRIM.Map_TN_Hamilton_Offender;
lFile_Vendor_2V := CRIM.Map_OH_Hardin_Offender;
lFile_Vendor_2W := CRIM.Map_OH_Adam_Offender;
lFile_Vendor_2X := CRIM.Map_SC_York_Offender;
lFile_Vendor_2Y := CRIM.Map_TN_Meth_Offender;
lFile_Vendor_2Z := CRIM.Map_OH_Noble_Offender;
lFile_Vendor_3C := CRIM.Map_OH_Allen_LimaMunicipal_Offender;
lFile_Vendor_3D := CRIM.Map_OH_Athens_Offender;
lFile_Vendor_3E_3X := CRIM.Map_OH_Ross_Offender;
lFile_Vendor_3F_4D := CRIM.Map_OH_Brown_Offender;
lFile_Vendor_3G := CRIM.Map_OH_Clinton_Offender;
lFile_Vendor_3H := CRIM.Map_OH_Cuyahoga_Offender;
lFile_Vendor_3I := CRIM.Map_OH_Lawrence_Offender;
lFile_Vendor_3J := CRIM.Map_OH_Pickaway_Offender;
lFile_Vendor_3K := CRIM.Map_TX_Grayson_Offender;
lFile_Vendor_3L := CRIM.Map_TX_Lamar_Offender;
lFile_Vendor_3M := CRIM.Map_FL_Sarasota_Offender;
lFile_Vendor_3N := CRIM.Map_LA_EBatonRouge_Offender;
lFile_Vendor_3O := CRIM.Map_LA_Jefferson_Offender;
lFile_Vendor_3Q := CRIM.Map_SC_Richland_Offender;
lFile_Vendor_3R_3Y := CRIM.Map_TN_RutherFord_CC_Offender;
lFile_Vendor_4B := CRIM.Map_OH_Summit_Offender;
lFile_Vendor_4C := CRIM.Map_OH_Summit_Cty_CuyahogaFalls_City_Offender;
lFile_Vendor_4F := CRIM.Map_OH_Summit_Barberton_Offender;
lFile_Vendor_4G := CRIM.Map_OH_Summit_Akron_Offender;





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
 //+	lFile_Vendor_46 	// PA
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
 +	lFile_Vendor_82		// OK counties
 +	lFile_Vendor_83		// MI Wayne
 +	lFile_Vendor_84		// CA VENTURA
 +	lFile_Vendor_85		// FL HIGHLANDS
 +	lFile_Vendor_86		// TX COLLIN
 +	lFile_Vendor_87		// TX MIDLAND
 +	lFile_Vendor_88		// IA 
 +	lFile_Vendor_89		// OH-PUTNAM
 +	lFile_Vendor_90		// AZ-MOHAVE
 +	lFile_Vendor_91		// OH-MONROE
 +	lFile_Vendor_92		// OH-WARREN
 +	lFile_Vendor_93		// MS-HARRISON
 +	lFile_Vendor_94		// TX-BRAZORIA
 +	lFile_Vendor_95		// OH-MONTGOMERY
 +	lFile_Vendor_96		// MD
 +	lFile_Vendor_97		// TX WILLIAMSON
 +	lFile_Vendor_98		// TX WALLER
 +	lFile_Vendor_1A		// OH AUGLAIZE
 +	lFile_Vendor_1B		// FL MANATEE
 +	lFile_Vendor_1C		// OH ALLEN
 +	lFile_Vendor_1D		// OH BUTLER
 +	lFile_Vendor_1E		// OH CHAMPAIGN
 +	lFile_Vendor_1F		// OH CLERMONT
 +	lFile_Vendor_1G		// OH COLUMBIANA
 +	lFile_Vendor_1H		// OH DELAWARE
 +	lFile_Vendor_1I		// OH FAIRFIELD
 +	lFile_Vendor_1J		// CO Denver
 +	lFile_Vendor_1Y		// MO
 +  lFile_Vendor_1K		// CA SANTA CLARA
 +  lFile_Vendor_1O		// OH TRUMBULL
 +  lFile_Vendor_1N		// OH MEDINA
 +  lFile_Vendor_1P		// OH TUSCARAWAS
 +  lFile_Vendor_1M		// OH SANDUSKY
 + 	lFile_Vendor_1S 	// OK_Adair
 + 	lFile_Vendor_1T 	// OK_Canadian
 + 	lFile_Vendor_1U 	// OK_Cleveland
 + 	lFile_Vendor_1V 	// OK_Comanche
 + 	lFile_Vendor_1W 	// OK_Garfield
 + 	lFile_Vendor_1X 	// OK_Ellis
 + 	lFile_Vendor_1L 	// OK_Lake
 + 	lFile_Vendor_1R 	// OK_Hamilton
 + 	lFile_Vendor_1Z 	// OK_Logan_Offender;
 + 	lFile_Vendor_2A 	// OK_Oklahoma_Offender;
 + 	lFile_Vendor_2B 	// OK_Payne_Offender;
 + 	lFile_Vendor_2C 	// OK_Pushmataha_Offender;
 + 	lFile_Vendor_2D 	// OK_Rogers_Offender;
 + 	lFile_Vendor_2E 	// OK_Tulsa_Offender;
 + 	lFile_Vendor_2F 	// OK_RogerMills_Offender;
 + 	lFile_Vendor_2G 	// GA_Cobb_Offender;
 + 	lFile_Vendor_2H 	// OH Hancock
 + 	lFile_Vendor_2I 	// OH Fulton
 +  lFile_Vendor_2J		// OH LICKING
 + 	lFile_Vendor_2K 	// OH_Richland_Offender;
 + 	lFile_Vendor_2L 	// OH_Wayne_Offender;
 + 	lFile_Vendor_2M 	// FL_Marion_Offender;
 + 	lFile_Vendor_2N 	// LA_St_Tammany_offender;
 + 	lFile_Vendor_2S		// HI_Offender;
 + 	lFile_Vendor_2T 	// FL_Hernando_offender;
 + 	lFile_Vendor_2P		// OH_Franklin_Offender;
 + 	lFile_Vendor_2O		// OH_Mahoning_Offender;
 + 	lFile_Vendor_2Q		// SC_Greenville_Offender;
 +  lFile_Vendor_2U		// TN_Hamilton_Offender;
 +  lFile_Vendor_2V		// OH_Hardin_Offender;
 +  lFile_Vendor_2W 	// OH_Adam_Offender;
 +  lFile_Vendor_2X 	// SC_York_Offender;
 +  lFile_Vendor_2Y 	// TN_Meth_Offender;
 +  lFile_Vendor_2Z 	// OH_Noble_Offender;
 +  lFile_Vendor_3C 	// OH_Allem_Lima_Offender;
 +  lFile_Vendor_3D   // OH ATHENS Offender;
 +  lFile_Vendor_3E_3X 	// OH_Ross_Offender;
 +  lFile_Vendor_3F_4D 	// OH_Brown_Offender;
 +  lFile_Vendor_3G 	// OH_Clinton_Offender;
 +  lFile_Vendor_3H 	// OH_Cuyahoga_Offender;
 +  lFile_Vendor_3I 	// OH Lawrence Offender; 
 +  lFile_Vendor_3J 	// OH Pickaway Offender; 
 +  lFile_Vendor_3K 	// TX Grayson Offender; 
 +  lFile_Vendor_3L 	// TX Lamar Offender; 
 +  lFile_Vendor_3M 	// FL Sarasota Offender;
 +  lFile_Vendor_3N 	// LA E Baton Rouge Offender;
 +  lFile_Vendor_3O 	// LA Jefferson Offender;
 +  lFile_Vendor_3Q 	// SC Richland Offender;
 +  lFile_Vendor_3R_3Y 	// TN_Rutherford_Offender;
 +  lFile_Vendor_4B 	// OH Summit Offender;
 +  lFile_Vendor_4C 	// OH Summit Cuyahoga Falls Offender;
 +  lFile_Vendor_4F 	// OH Summit Barberton Offender;
 +  lFile_Vendor_4G 	// OH Summit Akron Offender;
;
 /* Not ready yet...
 +	lFile_Vendor_33		// FL-Alachua DMV
 +	lFile_Vendor_37		// NC-Impaired Drivers
 +	lFile_Vendor_39		// FL-DUVAL CRIMINAL DMV
*/
