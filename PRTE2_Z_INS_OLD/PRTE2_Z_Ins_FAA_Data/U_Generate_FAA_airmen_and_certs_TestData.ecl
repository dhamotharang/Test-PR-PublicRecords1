IMPORT PRTE2_X_DataCleanse, PRTE2_FAA_Data, RoxieKeyBuild, UT;
//------------------------------------------------------------
//EIR_XREF_BASE_DS
//------------------------------------------------------------
EIR_XREF_BASE_DS := PRTE2_X_DataCleanse.Files.EIR_XREF_BASE_DS;
// COUNT(EIR_XREF_BASE_DS);//4684

FAA_airmen_MHDR_DS   := EIR_XREF_BASE_DS(am_cnt <> 0); // Or FAA Certifications
// COUNT(FAA_airmen_MHDR_DS); //245

//------------------------------------------------------------
//Boca PRTE airmen and airment_certs Data
//------------------------------------------------------------
Boca_PRTE_airmen_DS       := PRTE2_FAA_Data.Files.Temp_Boca_PRTE_data_airmen_DS;
Boca_PRTE_airmen_certs_DS := PRTE2_FAA_Data.Files.Temp_Boca_PRTE_data_airmen_certs_DS;

//airmen
// Boca_PRTE_airmen_DS;
// COUNT(Boca_PRTE_airmen_DS); //1174

Boca_PRTE_airmen_dedup_did := DEDUP(SORT(Boca_PRTE_airmen_DS, did),did);
// COUNT(Boca_PRTE_airmen_dedup_did); //254
Boca_PRTE_airmen_dedup_uniqueID := DEDUP(SORT(Boca_PRTE_airmen_DS, unique_ID),unique_ID);
// COUNT(Boca_PRTE_airmen_dedup_uniqueID); //254

//airmen_certs
// Boca_PRTE_airmen_certs_DS;
COUNT(Boca_PRTE_airmen_certs_DS); //452

Boca_PRTE_airmen_certs_DS_dedup := DEDUP(SORT(Boca_PRTE_airmen_certs_DS,unique_ID),unique_ID);
// COUNT(Boca_PRTE_airmen_certs_DS_dedup); //254

/*
//-------------------------------------------------------------------------------
//Check common did between MHDR and BocaPRTE FAA_airmen: 245. 
//-------------------------------------------------------------------------------
outLayouts := RECORD
  PRTE2_FAA_Data.Layouts.AlphaBase_airmen.st; 
  unsigned BocaPRTE_airnen_did; //254
  unsigned MHDR_airmen_did;     //245
	PRTE2_X_DataCleanse.Layouts.Layout_XREF_MHDR.fb_state;
END;

outLayouts xCheckCommon(Boca_PRTE_airmen_dedup_did BocaPRTE, FAA_airmen_MHDR_DS MHDR) := TRANSFORM
  SELF :=  BocaPRTE;
  SELF.BocaPRTE_airnen_did :=  BocaPRTE.did;
  SELF.MHDR_airmen_did     :=  MHDR.eir_source_boca_did;
  SELF :=  MHDR;
END;

FAA_aircraft_did_Check := JOIN(Boca_PRTE_airmen_dedup_did, FAA_airmen_MHDR_DS,
                           LEFT.did = RIGHT.eir_source_boca_did,
													 xCheckCommon(LEFT, RIGHT)
													 );

FAA_aircraft_did_Check;
COUNT(FAA_aircraft_did_Check); //245
*/

//-------------------------------------------------------------------------------
//Generate Test Data for FAA_airmen
//-------------------------------------------------------------------------------
FAA_airmen_outLayouts := RECORD
	PRTE2_X_DataCleanse.Layouts.Layout_XREF_MHDR.s_did;
  PRTE2_FAA_Data.Layouts.AlphaBase_airmen; 
END;


FAA_airmen_outLayouts xCheckCommon(Boca_PRTE_airmen_DS BocaPRTE, FAA_airmen_MHDR_DS MHDR) := TRANSFORM
    // SELF.d_score              := IF(BocaPRTE.did <> '0', '100', '0'); 
    SELF.best_ssn             := MHDR.SSN; //BocaHDR 
    //SELF.did_out              := BocaPRTE.  ;  
    //SELF.date_first_seen      := MHDR.  ; 
    //SELF.date_last_seen       := MHDR.  ; 
    //SELF.current_flag         := MHDR.  ; 
    //SELF.record_type          := MHDR.  ; 
    //SELF.letter_code          := MHDR.  ; 
		
    //SELF.unique_id            := MHDR.uid; // WILL CHANGE AFTER LINKING WITH AIRMEN_CERTS

    //SELF.orig_rec_type          := MHDR.  ; 
		SELF.orig_fname           := MHDR.fname; //BocaHDR 
		SELF.orig_lname           := MHDR.lname; //BocaHDR 
    SELF.street1              := TRIM(MHDR.fb_house_num)+' '+TRIM(MHDR.fb_street); 
    //SELF.street2              := MHDR.  ; 
    SELF.city                 := MHDR.city_name  ; 
    SELF.state                := MHDR.st; //BocaHDR
    SELF.zip_code             := MHDR.zip; 
    SELF.country              := 'USA'; 
    //SELF.region              := MHDR.??????????????????; 

    //SELF.med_class              := MHDR.  ; 
    //SELF.med_date              := MHDR.  ; 
    //SELF.med_exp_date              := MHDR.  ; 

    SELF.prim_range           := MHDR.prim_range; 
    SELF.predir               := MHDR.predir; 
    SELF.prim_name            := MHDR.prim_name; 
    SELF.suffix               := MHDR.addr_suffix; 
    SELF.postdir              := MHDR.postdir; 
    SELF.unit_desig           := MHDR.unit_desig; 
    SELF.sec_range            := MHDR.sec_range; 
    SELF.p_city_name          := MHDR.p_city_name; 
    SELF.v_city_name          := MHDR.v_city_name; 
    SELF.st                   := MHDR.st; 
    SELF.zip                  := MHDR.zip; 
    SELF.zip4                 := MHDR.zip4; 
    SELF.cart                 := MHDR.cart; 
    SELF.cr_sort_sz           := MHDR.cr_sort_sz; 
    SELF.lot                  := MHDR.lot; 
    SELF.lot_order            := MHDR.lot_order; 
    SELF.dpbc                 := MHDR.dbpc; // Same?????
    SELF.chk_digit            := MHDR.chk_digit; 
    SELF.rec_type             := MHDR.rec_type; 
    //SELF.ace_fips_st          := MHDR.  ; 
    SELF.county               := MHDR.county; 
    SELF.county_name          := '';  //??????MHDR?
    SELF.geo_lat              := MHDR.geo_lat; 
    SELF.geo_long             := MHDR.geo_long; 
    SELF.msa                  := MHDR.msa; 
    SELF.geo_blk              := MHDR.geo_blk; 
    SELF.geo_match            := MHDR.geo_match; 
    SELF.err_stat             := MHDR.err_stat; 
    SELF.title                := MHDR.title; 
    SELF.fname                := MHDR.fname; 
    SELF.mname                := MHDR.mname; 
    SELF.lname                := MHDR.lname; 
    SELF.name_suffix          := MHDR.name_suffix; 
    //SELF.oer                  := MHDR. ; 
    SELF.airmen_id            := 10000000 + BocaPRTE.airmen_id ; 
    SELF.__internal_fpos__    := 0; 
		SELF.persistent_record_id   := 1000000 + BocaPRTE.persistent_record_id ;
    // SELF.persistent_record_id := MHDR.persistent_record_id  ; // ??from key file aircraft_id, a sequence # (base file is a hash value of mult fields)
    //SELF.did                  := MHDR.  ; 

    SELF := BocaPRTE;
    SELF := MHDR;
	
  // SELF.BocaPRTE_did := BocaPRTE.did;
  // SELF.MHDR_did     := MHDR.eir_source_boca_did;
END;


FAA_airmen_DS := JOIN(Boca_PRTE_airmen_DS, FAA_airmen_MHDR_DS,
                      LEFT.did = RIGHT.eir_source_boca_did,
										  xCheckCommon(LEFT, RIGHT)
											);

													 
FAA_airmen_DS;
// COUNT(FAA_airmen_DS);//1150
FAA_airmen_DS_dedup := DEDUP(SORT(FAA_airmen_DS, did),did);
// COUNT(FAA_airmen_DS_dedup);//245

PRTE2_FAA_Data.Layouts.AlphaBase_airmen xGetFinalFAAairmen(FAA_airmen_DS L):= TRANSFORM
    SELF.did         := L.S_did;
    // SELF.did_out     := (string)L.S_did;
    SELF.unique_id   := 's' + L.unique_id ;
		SELF := L; 
END;

FAA_airmen_TestDS := PROJECT(FAA_airmen_DS, xGetFinalFAAairmen(LEFT));
// COUNT(FAA_airmen_TestDS); //1150
FAA_airmen_TestDS; 


//-------------------------------------------------------------------------------
//Generate Test Data for FAA_airmen_certs
//-------------------------------------------------------------------------------
FAA_airmen_certs_select := SET(FAA_airmen_DS_dedup, unique_id);
FAA_airmen_certs_DS := Boca_PRTE_airmen_certs_DS(unique_id IN FAA_airmen_certs_select);
// COUNT(FAA_airmen_certs_DS);//442

FAA_airmen_certs_DS_uid_Check_dedup := DEDUP(SORT(FAA_airmen_certs_DS, unique_id),unique_id);
// FAA_airmen_certs_DS_uid_Check_dedup;
// COUNT(FAA_airmen_certs_DS_uid_Check_dedup);//245

PRTE2_FAA_Data.Layouts.AlphaBase_airmen_certs xGetFinalFAAairmencerts(FAA_airmen_certs_DS L):= TRANSFORM
    SELF.uid           := 's' + L.uid;
    SELF.unique_id     := 's' + L.unique_id;
		SELF.persistent_record_id   := 1000000 + L.persistent_record_id ;
		SELF := L; 
END;

FAA_airmen_certs_TestDS := PROJECT(FAA_airmen_certs_DS, xGetFinalFAAairmencerts(LEFT));
// COUNT(FAA_airmen_certs_TestDS); //442
// FAA_airmen_certs_TestDS; 

/*
//Test Duplicate unique_id
FAA_airmen_TestDS_dedup := DEDUP(SORT(FAA_airmen_TestDS, unique_id),unique_id);
COUNT(FAA_airmen_TestDS_dedup);

FAA_airmen_certs_TestDS_dedup := DEDUP(SORT(FAA_airmen_certs_TestDS, unique_id),unique_id);
COUNT(FAA_airmen_certs_TestDS_dedup);
*/



//-------------------------------------------------------------------------------
//Get 3 generation of FAA_airmen andd FAA_airmen_craft Test Data
//-------------------------------------------------------------------------------
fileVersion := UT.GETDATE+'';

RoxieKeyBuild.Mac_SF_BuildProcess_V2(FAA_airmen_TestDS,
   																   PRTE2_FAA_DATA.Files.BASE_PREFIX_NAME+'::tmp', 
   																	 'PRCT_Alpha_FAA_airmen',
   																	 fileVersion, getTestDataFaa_airmen, 3,
   																	 false,true);

RoxieKeyBuild.Mac_SF_BuildProcess_V2(FAA_airmen_certs_TestDS,
   																   PRTE2_FAA_DATA.Files.BASE_PREFIX_NAME+'::tmp', 
   																	 'PRCT_Alpha_FAA_airmen_certs',
   																	 fileVersion, getTestDataFaa_airmen_certs, 3,
   																	 false,true);
																		 
																		 
																		 
																		 
SEQUENTIAL(OUTPUT(FAA_airmen_TestDS),
           OUTPUT(FAA_airmen_certs_TestDS),
           getTestDataFaa_airmen,
					 getTestDataFaa_airmen_certs,
					 );
