/*2014-09-22T23:41:04Z (Rati Naren)
RR: 165319 - Adding BatchInput to the i/p parameters
*/
IMPORT AutoStandardI, Autokey_batch,BatchServices,doxie,Prof_License,doxie_files,Ingenix_NatlProf;

/* Moved almost all the coding from prof_LicenseV2_Services.PL_Batch_Service to this
   new function so this new function could be used by both the existing PL_Batch_Service
   and the new (as of June 1, 2010) Medlic_PL_Combined_Batch_Service.
*/

EXPORT PL_Batch_Service_Records(unsigned1 pt = 20,
                                BOOLEAN useCannedRecs = FALSE,
                                BOOLEAN running_Combined=FALSE,
                                dataset($.Layout_MLPL_Combined_Input) ds_batch_in_raw_param = dataset([],Layout_MLPL_Combined_Input)
                                ) := FUNCTION

  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
  ipl        := TRUE : STORED('IncludeProfessionalLicenses');

  sample_PL_recs := if (running_Combined,
                        BatchServices._Sample_inBatchMaster('MedlicPL'),
                        BatchServices._Sample_inBatchMaster('ProfLic'));

  test_PL_recs := PROJECT(sample_PL_recs,
                          TRANSFORM(
                            prof_licensev2_services.assorted_layouts.plBatchMaster_npi,
                            SELF.npi := LEFT.filing_number;
                            SELF := LEFT));

  //**** INPUT TRANSFORM
  // Store standard "batch_in" input dataset into a dataset in the
  // MLPL "combined" service layout.
  combo_rec := prof_LicenseV2_Services.Layout_MLPL_Combined_Input;
  // ds_batch_in_raw_stored := DATASET([], combo_rec) : STORED('batch_in', FEW);
  // ds_batch_in_raw := if(exists(ds_batch_in_raw_param),
                        // ds_batch_in_raw_param ,
                        // ds_batch_in_raw_stored);
   ds_batch_in_raw := ds_batch_in_raw_param;

  // *** Pre-processing filtering.
  // If not running the MLPL combined batch service, include all input records.,
  // If running the MLPL combined batch service, only include input records
  // that either have a non blank NPI in the search criteria or that have a
  // blank taxid and blank lic#; because those 2 fields are ML batch service
  // only search fields and if we use input records intended for ML searching
  // in this batch service we will still use any other input search criteria
  // that was entered and we might get false hits for the combined service.
  ds_batch_in_filt := ds_batch_in_raw(NOT running_combined or
                                     (npi<>'' or (taxid='' and license_number='')));

  ds_batch_in_NPI := IF( NOT useCannedRecs,
                     BatchServices.Functions.PL.file_inPLBatchMasterNPI(ds_batch_in_filt,forceSeq := FALSE),
                     test_pl_recs
                    );

  ds_batch_in := PROJECT(ds_batch_in_NPI, Autokey_batch.Layouts.rec_inBatchMaster);

  outpl  := prof_LicenseV2_Services.Prof_Lic_Raw.Batch_View.get_ProfIds(ds_batch_in);

  ids_acctno_1 := PROJECT(outpl,TRANSFORM(prof_LicenseV2_Services.Assorted_Layouts.ProvId_dea
                                          ,SELF := LEFT,SELF := []));
  ids_prolic   := PROJECT(outpl,Prof_LicenseV2_Services.layout_search_IDs_Prolic);

  ids_acctno        := prof_LicenseV2_Services.Prof_Lic_Raw.Batch_View.get_dea_by_proFIds(ungroup(ids_acctno_1),ds_batch_in);
  ids_acctno_by_NPI :=  prof_LicenseV2_Services.Prof_Lic_Raw.Batch_View.get_prolic_seq_ID_by_npi(
    project(ds_batch_in_NPI,
      transform(prof_LicenseV2_Services.Assorted_Layouts.ProvId_NPI,
        self.npi := left.npi,
        self.acctno := left.acctno,
        self := [])), mod_access := mod_access);

  ids_acctno_prolic_seqIDs := project(ids_acctno_by_npi,Prof_LicenseV2_Services.layout_search_IDs_Prolic);

  geo_l := record
    Prof_License.Layout_proLic_in.cart;
    Prof_License.Layout_proLic_in.cr_sort_sz;
    Prof_License.Layout_proLic_in.lot;
    Prof_License.Layout_proLic_in.lot_order;
    Prof_License.Layout_proLic_in.dpbc;
    Prof_License.Layout_proLic_in.chk_digit;
    Prof_License.Layout_proLic_in.record_type;
    Prof_License.Layout_proLic_in.ace_fips_st;
    Prof_License.Layout_proLic_in.county;
    Prof_License.Layout_proLic_in.geo_lat;
    Prof_License.Layout_proLic_in.geo_long;
    Prof_License.Layout_proLic_in.msa;
    Prof_License.Layout_proLic_in.geo_blk;
    Prof_License.Layout_proLic_in.geo_match;
    Prof_License.Layout_proLic_in.err_stat;
  end;

  layout_w_penalt := record
    Doxie.layout_inBatchMaster.acctno;
    prof_LicenseV2_Services.Assorted_Layouts.Layout_key.uniqueid;
    prof_LicenseV2_Services.Assorted_Layouts.Layout_key.npi;
    String12 prolic_seq_id;
    String12 ProviderId;
    String12 sanc_id;
    string200	DEANumber;
    prof_LicenseV2_Services.Assorted_Layouts.Layout_Search1- geo_l;
    prof_LicenseV2_Services.Assorted_Layouts.Layout_report1;
    string1 expired_flag;
  END;

  out_noacctno := Prof_LicenseV2_services.get_ProfLic(ungroup(ids_Prolic) + ids_acctno_prolic_seqIDs
                  ,dataset([],prof_LicenseV2_Services.Layout_Search_Ids_Sanc),
                   dataset([],prof_LicenseV2_Services.Layout_Search_Ids_Prov)
                  );

  // Get the date the batch service is being run on for use in checking against expiration_date below
  string8 run_date := StringLib.GetDateYYYYMMDD();

  layout_w_penalt get_prolic1(prof_LicenseV2_Services.Assorted_Layouts.ProvId_dea l,
    prof_LicenseV2_Services.Assorted_Layouts.Layout_report r):=transform
    self.acctno := l.acctno;
    SELf.deanumber := l.dea_r;
    SELF.prolic_seq_id := (string12)r.prolic_seq_id;
    SELF.ProviderId := (string12)r.ProviderId;
    SELF.sanc_id := (string12)r.sanc_id;
    // Set expired_flag based upon contents of expiration_date
    SELF.expired_flag := if(r.expiration_date='','U',
                            if(run_date>r.expiration_date,'Y','N'));
    self := r;
    SELF := [];
  END;

  layout_penalty_included := record
    unsigned2 penalt;
    layout_w_penalt;
  end;

  pro_lic_seq_ids := dedup(sort(ids_acctno + ids_acctno_by_NPI, prolic_seq_id,acctno, record), prolic_seq_id,acctno);

  out_acctno := dedup(sort(join(pro_lic_seq_ids,out_noacctno.report
                                ,left.prolic_seq_id = right.prolic_seq_id
                                ,get_prolic1(left,right)
                                )
                            ,acctno,did,-issue_date,-expiration_date,-orig_license_number)
                      ,acctno,did,issue_date,expiration_date);

  out_acctno_slim_wpenalty := JOIN(ds_batch_in, out_acctno,
                                   LEFT.acctno = RIGHT.acctno,
                                   TRANSFORM(layout_penalty_included,
                                     SELF.penalt        := batchServices.functions.PL.fn_pentalize(LEFT,RIGHT),
                                     SELF.prolic_seq_id := (STRING12)RIGHT.prolic_seq_id;
                                     SELF.ProviderId    := (STRING12)RIGHT.ProviderId;
                                     SELF.sanc_id       := (STRING12)RIGHT.sanc_id;
                                     SELF               := RIGHT;
                                     SELF               := []));

  // The following two joins (ds_AddProvID & ds_AddNPI) were added as LEFT OUTER filtering
  // jions in the event future code changes populate the provider ID and npi in the
  // results set PRIOR to the join with the key.  If the provider id
  // and/or the npi fields are already populated, the key join will not overwrite
  // the existing data.  The reasoning behind this was that if the npi and/or provider ID
  // are provided with a larger dataset, then that data is assumed to be more accurate and hence we
  // will not over write it with the key data provided with these two join statements.

  ds_AddProvID := JOIN(out_acctno_slim_wpenalty, doxie_files.key_provider_did,
                      ((LEFT.providerid = '0' OR LEFT.providerid = '') AND (UNSIGNED)LEFT.did = RIGHT.l_did),
                        TRANSFORM(layout_penalty_included,
                          SELF.providerid := IF((LEFT.providerid  = '0' OR LEFT.providerid = ''),  // populating provider ID
                                                (STRING12)RIGHT.providerid,
                                                           LEFT.providerid),
                          SELF            := LEFT),LEFT OUTER);

  ds_AddNPI := JOIN(ds_AddProvID, Ingenix_NatlProf.key_NPI_providerid,
                   (LEFT.npi = 0 AND (unsigned6)LEFT.providerid = RIGHT.l_providerid),
                    Transform(layout_penalty_included,
                      SELF.npi := IF((LEFT.npi = 0 OR LEFT.npi = (INTEGER)''),  // populating npi
                                     (INTEGER)RIGHT.npi,
                                               LEFT.npi),
                      SELF     := LEFT),LEFT OUTER);

   out_acctno_slim_pentalized := ds_AddNPI(penalt <= pt);

  layout_penalty_included trimSpaces(layout_penalty_included L) := TRANSFORM
    self.acctno := trim(L.acctno);
    self.uniqueid := trim(L.uniqueid);
    self.prolic_seq_id := trim(L.prolic_seq_id);
    self.providerId := trim(L.providerId);
    self.sanc_id := trim(L.sanc_id);
    self.deaNumber := trim(L.deaNumber);
    self.taxId := trim(L.taxId);
    self.orig_license_number := trim(L.orig_license_number);
    self.status := trim(L.status);
    self.orig_name := trim(L.orig_name);
    self.orig_former_name := trim(L.orig_former_name);
    self.company_name := trim(L.company_name);
    self.orig_addr_1 := trim(L.orig_addr_1);
    self.orig_addr_2 := trim(L.orig_addr_2);
    self.orig_city := trim(L.orig_city);
    self.orig_st := trim(L.orig_st);
    self.orig_zip := trim(L.orig_zip);
    self.additional_orig_name := trim(L.orig_name);
    self.additional_orig_additional_1 := trim(L.additional_orig_additional_1);
    self.additional_orig_additional_2 := trim(L.additional_orig_additional_2);
    self.additional_orig_city := trim(L.additional_orig_city);
    self.additional_orig_st := trim(L.additional_orig_st);
    self.additional_orig_zip := trim(L.additional_orig_zip);
    self.did := trim(L.did);
    self.bdid := trim(L.bdid);
    self.phone := trim(L.phone);
    self.phoneType := trim(L.PhoneType);
    self.sex := trim(L.sex);
    self.dob := trim(L.dob);
    self.best_ssn := trim(L.best_ssn);
    self.issue_date := trim(L.issue_date);
    self.expiration_date := trim(L.expiration_date);
    self.status_effective_dt := trim(L.status_effective_dt);
    self.action_status := trim(L.action_status);
    self.date_first_seen := trim(L.date_first_seen);
    self.date_last_seen := trim(L.date_last_seen);
    self.last_renewal_date := trim(L.last_renewal_date);
    self.profession_or_board := trim(L.profession_or_board);
    self.license_type := trim(L.license_type);
    self.license_obtained_by := trim(L.license_obtained_by);
    self.source_st := trim(L.source_st);
    self.source_st_decoded := trim(L.source_st_decoded);
    self.prim_range := trim(L.prim_range);
    self.predir := trim(L.predir);
    self.prim_name := trim(L.prim_name);
    self.suffix := trim(L.suffix);
    self.postdir := trim(L.postdir);
    self.unit_desig := trim(L.unit_desig);
    self.sec_range := trim(L.sec_range);
    self.p_city_name := trim(L.p_city_name);
    self.v_city_name := trim(L.v_city_name);
    self.st := trim(L.st);
    self.zip := trim(L.zip);
    self.zip4 := trim(L.zip4);
    self.title := trim(L.title);
    self.fname := trim(L.fname);
    self.mname := trim(L.mname);
    self.lname := trim(L.lname);
    self.name_suffix := trim(L.name_suffix);
    self.county_name := trim(L.county_name);
    self.license_number := trim(L.license_number);
    self.board_action_indicator := trim(L.board_action_indicator);
    self.action_complaint_violation_dt := trim(L.action_complaint_violation_dt);
    self.action_complaint_violation_desc := trim(L.action_complaint_violation_desc);
    self.action_case_number := trim(L.action_case_number);
    self.action_desc := trim(L.action_desc);
    self.action_posting_status_dt := trim(L.action_posting_status_dt);
    self.action_effective_dt := trim(L.action_effective_dt);
    self.misc_other_id := trim(L.misc_other_id);
    self.education_continuing_education := trim(L.education_continuing_education);
    self.education_1_school_attended := trim(L.education_1_school_attended);
    self.education_1_dates_attended := trim(L.education_1_dates_attended);
    self.education_1_curriculum := trim(L.education_1_curriculum);
    self.education_1_degree := trim(L.education_1_degree);
    self.education_2_school_attended := trim(L.education_2_school_attended);
    self.education_2_dates_attended := trim(L.education_2_dates_attended);
    self.education_2_curriculum := trim(L.education_2_curriculum);
    self.education_2_degree := trim(L.education_2_degree);
    self.education_3_school_attended := trim(L.education_3_school_attended);
    self.education_3_dates_attended := trim(L.education_3_dates_attended);
    self.education_3_curriculum := trim(L.education_3_curriculum);
    self.education_3_degree := trim(L.education_3_degree);
    self.business_flag := trim(L.business_flag);
    self.misc_fax := trim(L.misc_fax);
    self.misc_email := trim(L.misc_email);
    self.additional_phone := trim(L.additional_phone);
    self.personal_race_desc := trim(L.personal_race_desc);
    self.misc_occupation := trim(L.misc_occupation);
    self.action_record_type := trim(L.action_record_type);
    self.personal_pob_desc := trim(L.personal_pob_desc);
    self.other_license_number := trim(L.other_license_number);
    self.other_license_type := trim(L.other_license_type);
    self.misc_practice_hours := trim(L.misc_practice_hours);
    self.misc_practice_type := trim(L.misc_practice_type);
    self.additional_licensing_specifics := trim(L.additional_licensing_specifics);
    self.expired_flag := trim(L.expired_flag);
    self.npi := L.npi;
    self.penalt := L.penalt;
  end;

  // For debugging uncomment lines below as needed
  // OUTPUT( ds_AddProvID,              NAMED('ds_AddProvID') );
  // OUTPUT( ds_AddNPI,                 NAMED('ds_addNPI') );
  // output(ids_acctno,                 named('ids_acctno'));
  // output(ids_acctno_by_NPI,          named('ids_acctno_by_NPI'));
  // output(out_noacctno.report,        named('report'));
  // output(out_acctno_slim_wpenalty,   named('out_acctno_slim_wpenalty'));
  // output(out_acctno_slim_pentalized, named('out_acctno_slim_pentalized'));

  out_results := SORT(project(ds_AddNPI, trimSpaces(left)),acctno, penalt);

  RETURN out_results;

END;
