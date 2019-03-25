import CRIM, Crim_Expunctions, crim_common,data_services;
// datasets here... no reason for all the attributes at this point...

	lNamePrefix := data_services.foreign_prod+'thor_data400::in::court_offenses_';

	//Abinitio Files
lFile_Vendor_02 := dataset(lNamePrefix + 'wa_scomis_crim_20120525',			Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_03 := dataset(lNamePrefix + 'wa_ltd_juri_crim_20120525',		Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_42 := dataset(lNamePrefix + 'fl_pasco_crim_20140213',			Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_42a := dataset(lNamePrefix + 'fl_pasco_crim_20150923',			Crim_Common.Layout_In_Court_Offenses,flat);

lFile_Vendor_43 := dataset(lNamePrefix + 'fl_pasco_traffic_crim_20140228',	Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_43a := dataset(lNamePrefix + 'fl_pasco_traffic_crim_20150923',	Crim_Common.Layout_In_Court_Offenses,flat);

lFile_Vendor_44 := dataset(lNamePrefix + 'fl_osceola_crim_20081219',		Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_47 := dataset(lNamePrefix + 'tx_travis_crim_20091016',			Crim_Common.Layout_In_Court_Offenses,flat);
//lFile_Vendor_55 does not exist (CA_Sacramento_County)
//lFile_Vendor_62 := does not exist (CA_Marin_County)
lFile_Vendor_63 := dataset(lNamePrefix + 'fl_lake_traffic_crim_20140228',	          Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_63a := dataset(lNamePrefix + 'fl_lake_traffic_crim_20150923',	          Crim_Common.Layout_In_Court_Offenses,flat);

//lFile_Vendor_64 does not exist, right, Tammy? (CA_Mendocino)				:= dataset(lNamePrefix + 'ca_mendocino_crim_20040618',	    Crim_Common.Layout_In_Court_Offenses,flat);
//lFile_Vendor_65 does not exist, right, Tammy? (AZ_Maricopa)				:= dataset(lNamePrefix + 'az_maricopa_crim_20040711',	    Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_66 := dataset(lNamePrefix + 'fl_duval_traffic_civil_crim_20070615_exp_20120726',	  Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_67 := dataset(lNamePrefix + 'fl_alachua_civiltraffic_20120727',	      Crim_Common.Layout_In_Court_Offenses,flat);
//lFile_Vendor_68 does not exist (FL_Orange_County)
lFile_Vendor_69 := dataset(lNamePrefix + 'fl_aoc_crim_20031008',	                  Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_70 := dataset(lNamePrefix + 'tx_ftbend_crim_20100924',	                Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_71 := dataset(lNamePrefix + 'oh_portage_crim_20120720',	              Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_72 := dataset(lNamePrefix + 'tx_johnson_crim_20120309',	              Crim_Common.Layout_In_Court_Offenses,flat);
//lFile_Vendor_73 does not exist (CA_STANISLAUS)
lFile_Vendor_75 := dataset(lNamePrefix + 'fl_indianriver_crim_20140507',	          Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_77 := dataset(lNamePrefix + 'tx_comal_crim_20040914',	                Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_78 := dataset(lNamePrefix + 'tx_lamar_crim_20040915',	                Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_79 := dataset(lNamePrefix + 'tx_parker_crim_20040915',	                Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_80 := dataset(lNamePrefix + 'tx_tomgreen_crim_20040915',	              Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_89 := dataset(lNamePrefix + 'oh_putnam_crim_20140213',                 Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_89a := dataset(lNamePrefix + 'oh_putnam_crim_20140408',                 Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_90 := dataset(lNamePrefix + 'az_mohave_crim_20090213',                 Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_91 := dataset(lNamePrefix + 'oh_monroe_crim_20140213',                 Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_91a := dataset(lNamePrefix + 'oh_monroe_crim_20150923',                 Crim_Common.Layout_In_Court_Offenses,flat);

lFile_Vendor_93 := dataset(lNamePrefix + 'ms_harrison_crim_20140507',               Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_97 := dataset(lNamePrefix + 'tx_williamson_crim_20110415',             Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_98 := dataset(lNamePrefix + 'tx_waller_crim_20130114',                 Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_1A := dataset(lNamePrefix + 'oh_auglaize_crim_20140228',               Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_1Aa := dataset(lNamePrefix + 'oh_auglaize_crim_20140521',               Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_1B := dataset(lNamePrefix + 'fl_manatee_crim_20120727',                Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_1I := dataset(lNamePrefix + 'oh_fairfield_crim_20140228',                Crim_Common.Layout_In_Court_Offenses,flat);
lFile_Vendor_1Ia := dataset(lNamePrefix + 'oh_fairfield_crim_20150821',                Crim_Common.Layout_In_Court_Offenses,flat);

	//HPCC Files
	lFile_Vendor_1E := CRIM.Map_OH_Champaign_Offenses;
	lFile_Vendor_1J := CRIM.Map_CO_Denver_Offenses;
	lFile_Vendor_1L := CRIM.Map_OH_Lake_Offenses;
	lFile_Vendor_1M := CRIM.Map_OH_Sandusky_Offenses;
	lFile_Vendor_1N := CRIM.Map_OH_Medina_Offenses;
	lFile_Vendor_1R := CRIM.Map_OH_Hamilton_Offenses;
	lFile_Vendor_1S := CRIM.Map_OK_Adair_Offenses;
	lFile_Vendor_1T := CRIM.Map_OK_Canadian_Offenses;
	lFile_Vendor_1U := CRIM.Map_OK_Cleveland_Offenses;
	lFile_Vendor_1V := CRIM.map_OK_Comanche_Offenses;
	lFile_Vendor_1W := CRIM.Map_OK_Garfield_Offenses;
	lFile_Vendor_1X := CRIM.Map_OK_Ellis_Offenses;
	lFile_Vendor_1Z := CRIM.Map_OK_Logan_Offenses;
	lFile_Vendor_2A := CRIM.Map_OK_Oklahoma_Offenses;
	lFile_Vendor_2B := CRIM.Map_OK_Payne_Offenses;
	lFile_Vendor_2C := CRIM.Map_OK_Pushmataha_Offenses;
	lFile_Vendor_2D := CRIM.Map_OK_Rogers_Offenses;
	lFile_Vendor_2E := CRIM.Map_OK_Tulsa_Offenses;
	lFile_Vendor_2F := CRIM.Map_OK_RogerMills_Offenses;
	lFile_Vendor_2H := CRIM.Map_OH_Hancock_Offenses;
	lFile_Vendor_2K := CRIM.Map_OH_Richland_Offenses;
	lFile_Vendor_2L := CRIM.Map_OH_Wayne_Offenses;
	lFile_Vendor_2O := CRIM.Map_OH_Mahoning_Offenses;
	lFile_Vendor_2Q := CRIM.Map_SC_Greenville_Offenses;
	lFile_Vendor_2U := CRIM.Map_TN_Hamilton_Offenses;
	lFile_Vendor_2V := CRIM.Map_OH_Hardin_Offenses;
	lFile_Vendor_2W := CRIM.Map_OH_Adam_Offenses;
	lFile_Vendor_2X := CRIM.Map_SC_York_Offenses;
	lFile_Vendor_2Y := CRIM.Map_TN_Meth_Offenses;
	lFile_Vendor_2Z := CRIM.Map_OH_Noble_Offenses_;
	lFile_Vendor_3F_4D := CRIM.Map_OH_Brown_Offenses;
	lFile_Vendor_3J := CRIM.Map_OH_Pickaway_Offenses;
	lFile_Vendor_3K := CRIM.Map_TX_Grayson_Offenses;
	lFile_Vendor_3L := CRIM.Map_TX_Lamar_Offenses;
	lFile_Vendor_3N := CRIM.Map_LA_EBatonRouge_Offenses;
	lFile_Vendor_3O := CRIM.Map_LA_Jefferson_Offenses;
	lFile_Vendor_3R_3Y := CRIM.Map_TN_RutherFord_CC_Offense;

//New ECL mappings - formerly built using AbInitio - Bug# 178960
	lFile_Vendor_42_new := CRIM.Map_FL_Pasco_Offenses;
	lFile_Vendor_43_new	:= CRIM.Map_FL_Pasco_Traffic_Offenses;
	lFile_Vendor_63_new	:= CRIM.Map_FL_Lake_Traffic_Offenses;
	lFile_Vendor_91_new	:= CRIM.Map_OH_Monroe_Offenses;
	lFile_Vendor_1I_new	:= CRIM.Map_OH_Fairfield_Offenses;
	
export File_In_Court_Offenses
		 := 
		 //lFile_Vendor_02		// WA-SCOMIS
		 //+  lFile_Vendor_03		// WA-Limited Juridcition
	
	  	// lFile_Vendor_42		// FL-Pasco County
	 // +	lFile_Vendor_42a 	// FL-Pasco County New File
	 	  lFile_Vendor_43 	// FL-Pasco County DMV Old FIle
	  //+	lFile_Vendor_43a 	// FL-Pasco County DMV New File// Chuck has sprayed all the files that went into this persist for ECL code below
	 
	 //+	lFile_Vendor_47 	// TX-Travis County
	 //+	lFile_Vendor_55		// CA-Sacramento
	 //+	lFile_Vendor_62		// CA-MARIN
	 +  lFile_Vendor_63		// FL-LAKE COUNTY DMV
	 //+	lFile_Vendor_63a		// FL-LAKE COUNTY DMV New File// Chuck has sprayed all the files that went into this persist for ECL code below
	// +	lFile_Vendor_64		// CA-MENDOCINO
	 //+	lFile_Vendor_73		// CA-STANISLAUS
	 //+	lFile_Vendor_75		// FL-Indian River
	 +	lFile_Vendor_77		// TX-Comal
	 +	lFile_Vendor_78		// TX-Lamar
	 +	lFile_Vendor_79		// TX-Parker
	 +	lFile_Vendor_80		// TX-Tom Green
	 //+	lFile_Vendor_89		// OH-PUTNAM
	 //+	lFile_Vendor_89a	// OH-PUTNAM New File
	 +	lFile_Vendor_90		// AZ-MOHAVE
	 +	lFile_Vendor_91		// OH-MONROE
	  //+	lFile_Vendor_91a		// OH-MONROE New File// Chuck has sprayed all the files that went into this persist for ECL code below
	 //+	lFile_Vendor_93		// MS-HARRISON
	// +	lFile_Vendor_97		// TX WILLIAMSON
	// +	lFile_Vendor_98		// TX WALLER
 	 //+  lFile_Vendor_1A		// OH AUGLAIZE
	 //+  lFile_Vendor_1Aa	// OH AUGLAIZE New File
	 +	lFile_Vendor_1B		// FL MANATEE
	 // +	lFile_Vendor_1I		// OH FAIRFIELD	
	 // +	lFile_Vendor_1Ia	// OH FAIRFIELD New File
	 //+  lFile_Vendor_1E   // OH CHAMPAIGN
	 //+	lFile_Vendor_1J		// CO Denver
	 //+ 	lFile_Vendor_1L 	// OK_Lake
	// +  lFile_Vendor_1M		// OH SANDUSKY
	 //+  lFile_Vendor_1N		// OH MEDINA
	 //+ 	lFile_Vendor_1R 	// OH_Hamilton
	 + 	lFile_Vendor_1S 	// OK_Adair
	 + 	lFile_Vendor_1T 	// OK_Canadian
	 + 	lFile_Vendor_1U 	// OK_Cleveland
	 + 	lFile_Vendor_1V 	// OK_Comanche
	 + 	lFile_Vendor_1W 	// OK_Garfield
	 + 	lFile_Vendor_1X 	// OK_Ellis	 
	 + 	lFile_Vendor_1Z 	// OK_Logan_Offenses;
   + 	lFile_Vendor_2A 	// OK_Oklahoma_Offenses;
	 + 	lFile_Vendor_2B 	// OK_Payne_Offenses;
	 + 	lFile_Vendor_2C 	// OK_Pushmataha_Offenses;
	 + 	lFile_Vendor_2D 	// OK_Rogers_Offenses;
	 + 	lFile_Vendor_2E 	// OK_Tulsa_Offenses;
	 + 	lFile_Vendor_2F 	// OK_RogerMills_Offenses;
	 //+ 	lFile_Vendor_2H 	// OH Hancock
	 //+ 	lFile_Vendor_2K 	// OH_Richland_Offenses;
	 //+ 	lFile_Vendor_2L 	// OH_Wayne_Offenses;
	 //+ 	lFile_Vendor_2O		// OH_Mahoning_Offenses;
	 //+ 	lFile_Vendor_2Q		// SC_Greenville_Offenses;
	 //+  lFile_Vendor_2U		// TN_Hamilton_Offenses;
	 //+  lFile_Vendor_2V		// OH_Hardin_Offenses;
	 //+  lFile_Vendor_2W 	// OH_Adam_Offenses;
	// +  lFile_Vendor_2X 	// SC_York_Offenses;
	 //+  lFile_Vendor_2Y 	// TN_Meth_Offenses;
	 +  lFile_Vendor_2Z 	// OH_Noble_Offenses;
	 +  lFile_Vendor_3F_4D 	// OH_Brown_Offenses;
	 //+  lFile_Vendor_3J 	// OH Pickaway Offenses;
	 +  lFile_Vendor_3K 	// TX Grayson Offenses;
	 +  lFile_Vendor_3L 	// TX Lamar Offenses;
	 +  lFile_Vendor_3N 	// LA E Baton Rouge Offenses;
	 +  lFile_Vendor_3O 	// LA Jefferson OOffenses;
	 //+  lFile_Vendor_3R_3Y 	// TN_Rutherford_Offenses; 
		 
		 
	//New ECL Mappings - previously built in AbInitio
	 //+	lFile_Vendor_42_new		// FL_Pasco_Offenses; 
	 //+	lFile_Vendor_43_new		// FL_Pasco_Traffic_Offenses; 
	 +	lFile_Vendor_63_new		// FL_Lake_Traffic_Offenses;
	 +	lFile_Vendor_91_new		// OH_Monroe_Offenses;
	 +	lFile_Vendor_1I_new		// OH_Fairfield_Offenses;
		 ;		 
