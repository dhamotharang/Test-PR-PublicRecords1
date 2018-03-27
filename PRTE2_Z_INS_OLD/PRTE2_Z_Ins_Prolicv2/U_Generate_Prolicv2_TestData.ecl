IMPORT PRTE2_X_DataCleanse,PRTE2_Prolicv2, RoxieKeyBuild, UT, Address;

//------------------------------------------------------------
//EIR_XREF_BASE_DS
//------------------------------------------------------------
EIR_XREF_BASE_DS := PRTE2_X_DataCleanse.Files.EIR_XREF_BASE_DS;
Prolicv2_MHDR_DS := EIR_XREF_BASE_DS(PL_cnt <> 0);
// COUNT(Prolicv2_MHDR_DS(eir_source_boca_did<>0));//1737  => 1559
// COUNT(Prolicv2_MHDR_DS);//1737 =>1559 Means there is no duplicates value in 0

//------------------------------------------------------------
//Professional Licenses in Boca PRTE
//------------------------------------------------------------
Prolicv2_BocaPRTE_DS := PRTE2_Prolicv2.Files.Prolicv2_Alpha_SF_DS;
// Prolicv2_BocaPRTE_DS;
// COUNT(Prolicv2_BocaPRTE_DS); //30466
Prolicv2_BocaPRTE_DS_Dedup := DEDUP(SORT(Prolicv2_BocaPRTE_DS,did),did);
// COUNT(Prolicv2_BocaPRTE_DS_Dedup); //5894
// COUNT(Prolicv2_BocaPRTE_DS_Dedup(did<>''));//5894

/*
//-------------------------------------------------------------------------------
//Check common did between MHDR and BocaPRTE: 1443. 
//-------------------------------------------------------------------------------
common_outLayouts := RECORD
  PRTE2_Prolicv2.Layouts.AlphaBaseOUT.st;
  string BocaPRTE_Prolic_did; //5894
  unsigned MHDR_Prolic_did;     //1559
	PRTE2_X_DataCleanse.Layouts.Layout_XREF_MHDR.fb_state;
END;

common_outLayouts xCheckCommon(Prolicv2_BocaPRTE_DS_Dedup BocaPRTE, Prolicv2_MHDR_DS MHDR) := TRANSFORM
  SELF :=  BocaPRTE;
  SELF.BocaPRTE_Prolic_did :=  BocaPRTE.did;
  SELF.MHDR_Prolic_did     :=  MHDR.eir_source_boca_did;
  SELF :=  MHDR;
END;


Prolicv2_did_Check := JOIN(Prolicv2_BocaPRTE_DS_Dedup, Prolicv2_MHDR_DS,
                           LEFT.did = (string)RIGHT.eir_source_boca_did,
													 xCheckCommon(LEFT, RIGHT) // By defult is finding the common DID; i.e. Only those records that exist in both the leftrecset and rightrecset.
													 // , FULL OUTER // At least one record for every record in the leftrecset and rightrecset.
													 // , FULL ONLY // One record for each leftrecset and rightrecset record with no match in the opposite record set.
													 );
													 
Prolicv2_did_Check;
COUNT(Prolicv2_did_Check); //1606 	=>1442
*/


// /*
//-------------------------------------------------------------------------------
//Generate Test Data for Professional Licenses
//-------------------------------------------------------------------------------
outLayouts := RECORD
	PRTE2_X_DataCleanse.Layouts.Layout_XREF_MHDR.s_did;
	// PRTE2_X_DataCleanse.Layouts.Layout_XREF_MHDR.uid;
  PRTE2_Prolicv2.Layouts.AlphaBaseOUT;
END;

outLayouts xGetProLic(Prolicv2_BocaPRTE_DS_Dedup BocaPRTE, Prolicv2_MHDR_DS MHDR) := TRANSFORM

    SELF.prolic_seq_id             := 1000000000 + BocaPRTE.prolic_seq_id; 
    SELF.orbit_source              := '';  
    SELF.category1                 := '';  
    SELF.category2                 := '';  
		
    SELF.prolic_key                := '10' + BocaPRTE.prolic_key; //Internal unique record number ????
    SELF.date_first_seen           := TRIM(BocaPRTE.date_first_seen[1..6]) + '01'; //=>
    SELF.date_last_seen            := TRIM(BocaPRTE.date_first_seen[1..6]) + '15';//=>
    // SELF.profession_or_board      := ; 
    // SELF.license_type             := ;
    // SELF.status                   := ;
    SELF.orig_license_number       := IF(BocaPRTE.orig_license_number <>'', '10' + BocaPRTE.orig_license_number, '');
    SELF.license_number            := IF(BocaPRTE.license_number <>'', '10' + BocaPRTE.license_number, '');
    SELF.previous_license_number   := IF(BocaPRTE.previous_license_number <>'', '10' + BocaPRTE.previous_license_number, '');  
    // SELF.previous_license_type                := ;
    SELF.company_name              := ''; //Remove company_name
    SELF.orig_name                 := TRIM(MHDR.fname)+' '+TRIM(MHDR.mname)+' '+TRIM(MHDR.lname);
    SELF.name_order                := 'FML';
    SELF.orig_former_name          := SELF.orig_name;
    SELF.former_name_order         := 'FML';
		
    SELF.orig_addr_1               := Address.Addr1FromComponents(MHDR.prim_range, MHDR.predir, MHDR.prim_name,
																													        MHDR.suffix, MHDR.postdir, MHDR.unit_desig, MHDR.sec_range); ; //addressline function																						 
    // SELF.orig_addr_2               := ;
    // SELF.orig_addr_3               := ;
    // SELF.orig_addr_4               := ;
    SELF.orig_city                 := MHDR.p_city_name;
    SELF.orig_st                   := MHDR.st;
    SELF.orig_zip                  := MHDR.zip;
    SELF.county_str                := MHDR.county_name;//Empty
    SELF.country_str               := 'UNITED STATES';
    SELF.business_flag             := 'N';
    SELF.phone                     := MHDR.phone;
    SELF.sex                       := MHDR.fb_gender;
    SELF.dob                       := MHDR.fb_dob;
    // SELF.issue_date                := ; // =>
    // SELF.expiration_date           := ; // =>
    // SELF.last_renewal_date         := MHDR.;// =>
    // SELF.license_obtained_by       := MHDR.;
    // SELF.board_action_indicator    := MHDR.;

    // SELF.action_record_type                := MHDR.;
    // SELF.action_complaint_violation_cds    := MHDR.;
    // SELF.action_complaint_violation_desc   := MHDR.;
    // SELF.action_complaint_violation_dt     := MHDR.;
    // SELF.action_case_number                := MHDR.;
    // SELF.action_effective_dt               := MHDR.;
    // SELF.action_cds                        := MHDR.;
    // SELF.action_desc                       := MHDR.;
    // SELF.action_final_order_no             := MHDR.;
    // SELF.action_status                     := MHDR.;
    // SELF.action_posting_status_dt          := MHDR.;
    // SELF.action_original_filename_or_url   := MHDR.;
    // SELF.                                  := MHDR.;
    // SELF.additional_name_addr_type         := MHDR.;
	 
    SELF.additional_orig_name                 := '';
    SELF.additional_name_order                := 'FML';
    SELF.additional_orig_additional_1         := '';
    SELF.additional_orig_additional_2         := '';
    SELF.additional_orig_additional_3         := '';
    SELF.additional_orig_additional_4         := '';
    SELF.additional_orig_city                 := '';
    SELF.additional_orig_st                   := '';
    SELF.additional_orig_zip                  := '';
    SELF.additional_phone                     := '';

    // SELF.misc_occupation                      := MHDR. ;
    // SELF.misc_practice_hours                  := MHDR. ;
    // SELF.misc_practice_type                   := MHDR. ;
    SELF.misc_email                           := '';
    SELF.misc_fax                             := '';
    SELF.misc_web_site                        := '';
    SELF.misc_other_id                        := '';
    SELF.misc_other_id_type                   := '';
    SELF.education_continuing_education       := '';
		
    // SELF.education_1_school_attended          := MHDR. ;
    // SELF.education_1_dates_attended           := MHDR. ;
    // SELF.education_1_curriculum               := MHDR. ;
    // SELF.education_1_degree                   := MHDR. ;
    // SELF.education_2_school_attended          := MHDR. ;
    // SELF.education_2_dates_attended           := MHDR. ;
    // SELF.education_2_curriculum               := MHDR. ;
    // SELF.education_2_degree                   := MHDR. ;
    // SELF.education_3_school_attended          := MHDR. ;
    // SELF.education_3_dates_attended           := MHDR. ;
    // SELF.education_3_curriculum               := MHDR. ;
    // SELF.education_3_degree                   := MHDR. ;
    // SELF.additional_licensing_specifics       := MHDR. ;
    // SELF.personal_pob_cd                      := MHDR. ;
    // SELF.personal_pob_desc                    := MHDR. ;
    // SELF.personal_race_cd                     := MHDR. ;
    // SELF.personal_race_desc                   := MHDR. ;
    // SELF.status_status_cds                    := MHDR. ;
    // SELF.status_effective_dt                  := MHDR. ;
    // SELF.status_renewal_desc                  := MHDR. ;
    // SELF.status_other_agency                  := MHDR. ;
	
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
    SELF.record_type             := MHDR.rec_type; 
    // SELF.ace_fips_st          := MHDR.  ; 
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
    // SELF.pl_score_in          := MHDR. ;// Clean Name Score. FUNCTION?
	

    SELF.prep_addr_line1        := '';
    SELF.prep_addr_last_line    := '';
    // SELF.RawAid	                := '';
    // SELF.ACEAID	                := '';

    SELF.county_name            := MHDR.county_name ;
    // SELF.did                    := MHDR. ; //Will change to SDID
    SELF.score                  := '100';
    SELF.best_ssn               := MHDR.SSN ;
    SELF.bdid                   := '';
    // SELF.source_rec_id          := '';
	
    // SELF.DotID			            := MHDR. ;
    // SELF.DotScore	            := MHDR. ;
    // SELF.DotWeight	            := MHDR. ;
    // SELF.EmpID			            := MHDR. ;
    // SELF.eEmpScore	            := MHDR. ;
    // SELF.EmpWeight	            := MHDR. ;
    // SELF.POWID			            := MHDR. ;
    // SELF.POWScore	            := MHDR. ;
    // SELF.POWWeight	            := MHDR. ;
    // SELF.ProxID		            := MHDR. ;
    // SELF.ProxScore	            := MHDR. ;
    // SELF.ProxWeight            := MHDR. ;
    // SELF.SELEID		            := MHDR. ;
    // SELF.SELEScore	            := MHDR. ;
    // SELF.SELEWeight            := MHDR. ;
    // SELF.OrgID			            := MHDR. ;
    // SELF.OrgScore	            := MHDR. ;
    // SELF.OrgWeight	            := MHDR. ;
    // SELF.UltID			            := MHDR. ;
    // SELF.UltScore	            := MHDR. ;
    // SELF.UltWeight	            := MHDR. ;
    // SELF.LNPID	                := MHDR. ;
    SELF :=  BocaPRTE;
    SELF :=  MHDR;
END;


Prolicv2_DS := JOIN(Prolicv2_BocaPRTE_DS_Dedup, Prolicv2_MHDR_DS,
                           LEFT.did = (string)RIGHT.eir_source_boca_did,
													 xGetProLic(LEFT, RIGHT));
													 
Prolicv2_DS;
COUNT(Prolicv2_DS); //1606 	=>1442

// COUNT(Prolicv2_did_Check(bdid<>'0')); //112
// COUNT(Prolicv2_did_Check(bdid='0')); //1300
// COUNT(Prolicv2_did_Check(bdid<>'0' and company_name <>'')); //112
// COUNT(Prolicv2_did_Check(company_name <>'')); //112
// COUNT(Prolicv2_did_Check(did <>'' and company_name ='')); //1330
// COUNT(Prolicv2_did_Check(did <>'' and company_name <>'')); //112
// COUNT(Prolicv2_did_Check(business_flag ='Y' and company_name <>'')); 
// COUNT(Prolicv2_did_Check(business_flag ='N' and company_name ='')); 

PRTE2_Prolicv2.Layouts.AlphaBaseOUT xGetFinalProcLic(Prolicv2_DS L) := TRANSFORM
    SELF.did := (string)L.S_did;
		SELF := L;
END;

Prolicv2_TestDS := PROJECT(Prolicv2_DS, xGetFinalProcLic(LEFT));
COUNT(Prolicv2_TestDS); //1442
//-------------------------------------------------------------------------------
//Get 3 generation of Professional Licenses Test Data
//-------------------------------------------------------------------------------
fileVersion := UT.GETDATE+'';

RoxieKeyBuild.Mac_SF_BuildProcess_V2(Prolicv2_TestDS,
   																   PRTE2_Prolicv2.Files.BASE_PREFIX_NAME+'::tmp', 
   																	 'PRCT_Alpha_Prolicv2',
   																	 fileVersion, getTestData, 3,
   																	 false,true);
SEQUENTIAL(OUTPUT(Prolicv2_TestDS),
           getTestData);