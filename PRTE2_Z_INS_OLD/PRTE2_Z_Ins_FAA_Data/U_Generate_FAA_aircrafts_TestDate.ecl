IMPORT PRTE2_X_DataCleanse, PRTE2_FAA_Data, RoxieKeyBuild, UT, Address;

//------------------------------------------------------------
//EIR_XREF_BASE_DS
//------------------------------------------------------------
EIR_XREF_BASE_DS := PRTE2_X_DataCleanse.Files.EIR_XREF_BASE_DS;

EIR_XREF_BASE_DS;
COUNT(EIR_XREF_BASE_DS);//4684

FAA_aircraft_MHDR_DS := EIR_XREF_BASE_DS(ar_cnt <> 0);
COUNT(FAA_aircraft_MHDR_DS); //49


//------------------------------------------------------------
//Boca PRTE Aircraft Data
//------------------------------------------------------------
Boca_PRTE_aircraft_DS     := PRTE2_FAA_Data.Files.Temp_Boca_PRTE_data_aircraft_reg_DS;
COUNT(Boca_PRTE_aircraft_DS); //249
Boca_PRTE_aircraft_dedup_did := DEDUP(SORT(Boca_PRTE_aircraft_DS(did <> 0), did),did);
COUNT(Boca_PRTE_aircraft_dedup_did); //53

// /*
//-------------------------------------------------------------------------------
//Check common did between MHDR and BocaPRTE: 49. 
//-------------------------------------------------------------------------------
outLayouts := RECORD
  PRTE2_FAA_Data.Layouts.AlphaBase_aircraft_reg.st; 
  unsigned BocaPRTE_aircraft_did; //53
  unsigned MHDR_aircraft_did;     //49
	PRTE2_X_DataCleanse.Layouts.Layout_XREF_MHDR.fb_state;
END;

outLayouts xCheckCommon(Boca_PRTE_aircraft_dedup_did BocaPRTE, EIR_XREF_BASE_DS MHDR) := TRANSFORM
  SELF :=  BocaPRTE;
  SELF.BocaPRTE_aircraft_did :=  BocaPRTE.did;
  SELF.MHDR_aircraft_did     :=  MHDR.eir_source_boca_did;
  SELF :=  MHDR;
END;

FAA_aircraft_did_Check := JOIN(Boca_PRTE_aircraft_dedup_did, FAA_aircraft_MHDR_DS,
                           LEFT.did = RIGHT.eir_source_boca_did,
													 xCheckCommon(LEFT, RIGHT)
													 );

FAA_aircraft_did_Check;
COUNT(FAA_aircraft_did_Check); //49
// */

//-------------------------------------------------------------------------------
//Generate Test Data for FAA aircraft
//-------------------------------------------------------------------------------
FAA_aircraft_outLayouts := RECORD
	PRTE2_X_DataCleanse.Layouts.Layout_XREF_MHDR.s_did;
  PRTE2_FAA_Data.Layouts.AlphaBase_aircraft_reg; 
END;


FAA_aircraft_outLayouts xGetFAAaircraft(Boca_PRTE_aircraft_DS BocaPRTE, FAA_aircraft_MHDR_DS MHDR) := TRANSFORM
    // SELF.d_score              := IF(BocaPRTE.did <> '0', '100', '0'); 
    SELF.best_ssn             := MHDR.SSN; //BocaHDR 
    //SELF.did_out              := BocaPRTE.  ; 
    //SELF.bdid_out             := BocaPRTE.  ; 
    //SELF.date_first_seen      := MHDR.  ; 
    //SELF.date_last_seen       := MHDR.  ; 
    //SELF.current_flag         := MHDR.  ; 
    //SELF.n_number             := MHDR.  ; 
    //SELF.serial_number        := MHDR.  ; 
    //SELF.mfr_mdl_code         := MHDR.  ; 
    //SELF.eng_mfr_mdl          := MHDR.  ; 
    //SELF.year_mfr             := MHDR.  ; 
    //SELF.type_registrant      := MHDR.  ; 
    SELF.name                 := TRIM(MHDR.fname)+' '+TRIM(MHDR.mname)+' '+TRIM(MHDR.lname)  ; 
    SELF.street               := TRIM(MHDR.fb_house_num)+' '+TRIM(MHDR.fb_street); 
    //SELF.street2              := MHDR.  ; 
    SELF.city                 := MHDR.city_name  ; 
    //SELF.state                := MHDR.  ; 
    SELF.zip_code             := MHDR.zip; 
    //SELF.region               := MHDR.; 
    SELF.orig_county          := MHDR.county; 
    SELF.country              := 'US'; 
    //SELF.last_action_date     := MHDR.  ; 
    //SELF.cert_issue_date      := MHDR.  ; 
    //SELF.certification        := MHDR.  ; 
    //SELF.type_aircraft        := MHDR.  ; 
    //SELF.type_engine          := MHDR.  ; 
    //SELF.status_code          := MHDR.  ; 
    //SELF.mode_s_code          := MHDR.  ; 
    //SELF.fract_owner          := MHDR.  ; 
    //SELF.aircraft_mfr_name    := MHDR.  ; 
    //SELF.model_name           := MHDR.  ; 
    SELF.prim_range           := MHDR.prim_range; 
    SELF.predir               := MHDR.predir; 
    SELF.prim_name            := MHDR.prim_name; 
    SELF.addr_suffix          := MHDR.addr_suffix; 
    SELF.postdir              := MHDR.postdir; 
    SELF.unit_desig           := MHDR.unit_desig; 
    SELF.sec_range            := MHDR.sec_range; 
    SELF.p_city_name          := MHDR.p_city_name; 
    SELF.v_city_name          := MHDR.v_city_name; 
    SELF.st                   := MHDR.st; 
    SELF.zip                  := MHDR.zip; 
    SELF.z4                   := MHDR.zip4; 
    SELF.cart                 := MHDR.cart; 
    SELF.cr_sort_sz           := MHDR.cr_sort_sz; 
    SELF.lot                  := MHDR.lot; 
    SELF.lot_order            := MHDR.lot_order; 
    SELF.dpbc                 := MHDR.dbpc; // Same?????
    SELF.chk_digit            := MHDR.chk_digit; 
    SELF.rec_type             := MHDR.rec_type; 
    //SELF.ace_fips_st          := MHDR.  ; 
    SELF.county               := MHDR.county; 
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
    SELF.compname             := ''; 
    SELF.lf                   := ''; 
    SELF.source_rec_id        := 1000000 + BocaPRTE.source_rec_id;
    SELF.aircraft_id          := 1000000 + BocaPRTE.aircraft_id; 
		SELF.persistent_record_id   := 1000000 + BocaPRTE.persistent_record_id ;
    // SELF.persistent_record_id := MHDR.persistent_record_id  ; // ??from key file aircraft_id, a sequence # (base file is a hash value of mult fields)
    SELF.__internal_fpos__    := 0; 
    //SELF.did                  := MHDR.  ; 
    //SELF.bd                   := MHDR.  ; 
    SELF := BocaPRTE;
    SELF := MHDR;
END;


FAA_aircraft_DS := JOIN(Boca_PRTE_aircraft_DS, FAA_aircraft_MHDR_DS,
                        LEFT.did = RIGHT.eir_source_boca_did,
											  xGetFAAaircraft(LEFT, RIGHT)
												);

													 
FAA_aircraft_DS;

COUNT(FAA_aircraft_DS(did<>0));//Boca_PRTE_aircraft_DS_dedup 49  
COUNT(FAA_aircraft_DS);//194  


FAA_aircraft_DS_dedup := DEDUP(SORT(FAA_aircraft_DS, did),did);
COUNT(FAA_aircraft_DS_dedup);//49


PRTE2_FAA_Data.Layouts.AlphaBase_aircraft_reg xGetFinalFAAaircraft(FAA_aircraft_DS L) := TRANSFORM
    SELF.did := L.S_did;
    SELF.did_out := (string)L.S_did;
		SELF := L;
END;

FAA_aircraft_TestDS := PROJECT(FAA_aircraft_DS, xGetFinalFAAaircraft(LEFT));
// COUNT(FAA_aircraft_TestDS); //194
FAA_aircraft_TestDS; 


//-------------------------------------------------------------------------------
//Get 3 generation of FAA_aircraft Test Data
//-------------------------------------------------------------------------------
fileVersion := UT.GETDATE+'';

RoxieKeyBuild.Mac_SF_BuildProcess_V2(FAA_aircraft_TestDS,
   																   PRTE2_FAA_DATA.Files.BASE_PREFIX_NAME+'::tmp', 
   																	 'PRCT_Alpha_FAA_aircraft',
   																	 fileVersion, getTestData, 3,
   																	 false,true);
SEQUENTIAL(OUTPUT(FAA_aircraft_TestDS),
           getTestData);
					 
		 