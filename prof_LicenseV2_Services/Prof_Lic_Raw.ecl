import Autokey_batch, BatchServices, doxie_cbrs, doxie, Prof_LicenseV2, Data_Services, doxie_files,
       Ingenix_NatlProf, AutokeyB2, prof_licensev2_services, Suppress, AutoStandardI;

export Prof_Lic_raw := Module

  SHARED data_env(boolean isFCRA) := if(isFCRA, Data_Services.data_env.iFCRA, Data_Services.data_env.iNonFCRA);

  SHARED add_compliance_fields(__in_layout__) := FUNCTIONMACRO
    __new_layout__ := RECORD(__in_layout__)
        unsigned4 global_sid;
        unsigned8 record_sid;
        unsigned6 did;
    END;
    RETURN __new_layout__;
  ENDMACRO;

  // Gets RMSIDs from BDIDs
  export get_Prolic_seq_id_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids, unsigned in_limit = 0,
    Doxie.IDataAccess mod_access, boolean isFCRA = false) := function

      layout_w_compliance_fields := add_compliance_fields(prof_LicenseV2_Services.Layout_Search_Ids_Prolic);
      key := Prof_LicenseV2.Key_Proflic_Bdid;

      _res := join(dedup(sort(in_bdids,bdid),bdid),key,
        keyed(left.bdid = right.bd),
        transform(layout_w_compliance_fields, self.did := (unsigned6)right.did, self := right),
        limit(Prof_LicenseV2.Constants.JOIN_LIMIT_LARGE,skip));

      res_suppressed := Suppress.MAC_SuppressSource(_res, mod_access, data_env := data_env(isFCRA));
      doxie.compliance.logSoldToSources(res_suppressed, mod_access);
      res := PROJECT(res_suppressed, prof_LicenseV2_Services.Layout_Search_Ids_Prolic);
      ded := dedup(sort(res,Prolic_Seq_ID),Prolic_Seq_ID);

      return if(in_limit = 0,ded,choosen(ded,in_limit));
  end;

  export get_Prolic_seq_id_from_dids(dataset(doxie.layout_references) in_dids,
   unsigned in_limit = 0, Doxie.IDataAccess mod_access, boolean isFCRA = false) := function

    layout_w_compliance_fields := add_compliance_fields(prof_LicenseV2_Services.Layout_Search_Ids_Prolic);
    key := Prof_LicenseV2.Key_Proflic_Did();
    _res := join(dedup(sort(in_dids, did), did), key,
      keyed(left.did = right.did), transform(layout_w_compliance_fields, self := right),
      limit(Prof_LicenseV2.Constants.JOIN_LIMIT_LARGE, skip));

    res_suppressed := Suppress.MAC_SuppressSource(_res, mod_access, data_env := data_env(isFCRA));
    doxie.compliance.logSoldToSources(res_suppressed, mod_access);
    res := PROJECT(res_suppressed, prof_LicenseV2_Services.Layout_Search_Ids_Prolic);
    ded := dedup(sort(res,Prolic_Seq_ID),Prolic_Seq_ID);

    return if(in_limit = 0,ded,choosen(ded,in_limit));
  end;

  export get_prolic_seq_ids_from_licnum(dataset(prof_LicenseV2_Services.Layout_Licnum) in_licnum,
    unsigned in_limit = 0, Doxie.IDataAccess mod_access, boolean isFCRA = false) := function

    layout_w_compliance_fields := add_compliance_fields(prof_LicenseV2_Services.Layout_Search_Ids_Prolic);
    key := 	Prof_LicenseV2.Key_Proflic_Licensenum;
    _res := join(dedup(sort(in_licnum,license_number),license_number),key,
      keyed(left.license_number = right.s_license_number),
      transform(layout_w_compliance_fields, self.did := (unsigned6)right.did, self := right),
      limit(Prof_LicenseV2.Constants.JOIN_LIMIT_LARGE,skip));

    res_suppressed := Suppress.MAC_SuppressSource(_res, mod_access, data_env := data_env(isFCRA));
    doxie.compliance.logSoldToSources(res_suppressed, mod_access);
    res := PROJECT(res_suppressed, prof_LicenseV2_Services.Layout_Search_Ids_Prolic);
    ded := dedup(sort(res,Prolic_Seq_ID),Prolic_Seq_ID);

    return if(in_limit = 0,ded,choosen(ded,in_limit));
  end;


  export get_sanc_ids_from_dids(dataset(doxie.layout_references) in_dids,
                               unsigned in_limit = 0) := function
    key := doxie_files.key_sanctions_did;
    res := join(dedup(sort(in_dids,did),did),key,
                keyed(left.did = right.l_did),
                transform(prof_LicenseV2_Services.Layout_Search_Ids_Sanc,self.sanc_id := (unsigned6) right.sanc_id),
                limit(Prof_LicenseV2.Constants.JOIN_LIMIT_SMALL,skip));
    ded := dedup(sort(res,sanc_id),sanc_id);

    return if(in_limit = 0,ded,choosen(ded,in_limit));
  end;

  export get_sanc_ids_from_licnum(dataset(prof_LicenseV2_Services.Layout_Licnum) in_licnum,
                               unsigned in_limit = 0) := function
    key := 	doxie_files.key_license_sancid;
    res := join(dedup(sort(in_licnum,license_number),license_number),key,
                keyed(left.st = right.SANC_SANCST or left.st='') AND
                keyed(left.license_number = right.SANC_LICNBR),
                transform(prof_LicenseV2_Services.Layout_Search_Ids_Sanc,self.sanc_id :=(unsigned6) right.sanc_id),
                limit(Prof_LicenseV2.Constants.JOIN_LIMIT_LARGE,skip));
    ded := dedup(sort(res,Sanc_Id),Sanc_Id);

    return if(in_limit = 0,ded,choosen(ded,in_limit));
  end;



  export get_prov_ids_from_dids(dataset(doxie.layout_references) in_did,
                               unsigned in_limit = 0) := function
    key := doxie_files.key_provider_did;
    res := join(dedup(sort(in_did,did),did),key,
                keyed(left.did = right.l_did),
                transform(prof_LicenseV2_Services.Layout_Search_Ids_Prov,self.providerid :=right.providerid),
                limit(Prof_LicenseV2.Constants.JOIN_LIMIT_SMALL,skip));
    ded := dedup(sort(res,providerid),providerid);

    return if(in_limit = 0,ded,choosen(ded,in_limit));
  end;

  export get_prov_ids_from_licnum(dataset(prof_LicenseV2_Services.Layout_Licnum) in_licnum,
                               unsigned in_limit = 0) := function
    key := doxie_files.key_provider_license;
    res := join(dedup(sort(in_licnum,license_number),license_number),key,
                keyed(left.st= right.LicenseState or right.licenseState <> '') AND
                keyed(left.license_number = right.LicenseNumber),
                transform(prof_LicenseV2_Services.Layout_Search_Ids_Prov,self :=right),
                limit(Prof_LicenseV2.Constants.JOIN_LIMIT_LARGE,skip));
    ded := dedup(sort(res,providerid),providerid);

    return if(in_limit = 0,ded,choosen(ded,in_limit));
  end;


  export Search_view := module

    export by_ids(dataset(prof_LicenseV2_Services.Layout_Search_Ids_Prolic) Prolic_Ids,
      dataset(prof_LicenseV2_Services.Layout_Search_Ids_Sanc) Sanc_Ids
      = dataset([],prof_LicenseV2_Services.Layout_Search_Ids_Sanc),
      dataset(prof_LicenseV2_Services.Layout_Search_Ids_Prov) Prov_Ids
      = dataset([],prof_LicenseV2_Services.Layout_Search_Ids_Prov),
      string20 in_licnum = ''):= function

      return prof_LicenseV2_Services.get_ProfLic(Prolic_Ids,Sanc_Ids,Prov_Ids,
      in_licnum).search;
    end;

  END;


  export source_view := module

    export by_ids(dataset(prof_LicenseV2_Services.Layout_Search_Ids_Prolic) Prolic_Ids,
    string20 in_licnum =''):= function
      return prof_LicenseV2_Services.get_ProfLic(Prolic_Ids,,,in_licnum).report;
    end;

    export by_did(dataset(doxie.layout_references) in_dids,
      unsigned in_limit = 0, Doxie.IDataAccess mod_access, boolean isFCRA) := function
        prolic_Ids := get_Prolic_seq_id_from_dids(in_dids,in_limit, mod_access, isFCRA);
        return prof_LicenseV2_Services.get_ProfLic(Prolic_Ids).report;
    end;

    export by_bdid(dataset(doxie_cbrs.layout_references) in_bdids,
      unsigned in_limit = 0, Doxie.IDataAccess mod_access, boolean isFCRA) := function

        prolic_Ids := get_Prolic_seq_id_from_bdids(in_bdids, in_limit, mod_access, isFCRA);
        return prof_LicenseV2_Services.get_ProfLic(Prolic_Ids).report;
    end;

    export by_licnum(dataset(prof_LicenseV2_Services.Layout_Licnum) in_licnum,
      unsigned in_limit = 0, Doxie.IDataAccess mod_access, boolean isFCRA) := function
      prolic_Ids := get_prolic_seq_ids_from_licnum(in_licnum, in_limit, mod_access, isFCRA);
      return prof_LicenseV2_Services.get_ProfLic(Prolic_Ids,,,in_licnum.license_number).report;
    end;
  end;

  export batch_view := module

    export pl_rec := RECORD
      Autokey_batch.Layouts.rec_inBatchMaster;
      string20 license_number := '';
      string2 license_state := '';
      string10	TaxID := '';
      string20 UPIN := '';
      string10 npi :='';
    END;

    EXPORT id_rec := RECORD
      Doxie.layout_inBatchMaster.acctno;
      Prof_LicenseV2_Services.layout_search_IDs_Prov ;
      Prof_LicenseV2.Layouts_ProfLic.Layout_Base.ProLic_Seq_Id ;
      unsigned6 Sanc_Id := 0;
      string20 license_number := '';
      string2 st;
      unsigned6 did;
      string10	TaxID := '';
      string20 UPIN := '';
    END;

    EXPORT id_plus_Rec := RECORD
      pl_rec;
      unsigned6 providerid;
    END;

    EXPORT id_rec_taxonomy := RECORD
        id_rec;
        unsigned6 npi; // added for additions to the med lic batch query.
        string taxonomy_code := ''; // added for additions to the med lic batch query.
    END;

    EXPORT id_rec_addresses := RECORD
        id_rec;
        string	HospitalName;  // next 4 fields added for med lic batch query.
        string	Address;
        string 	City;
        string	State;
        string	Zip;
    END;

    dea_rec1 := RECORD
      id_rec;
      string200 dea_r := '';
    END;

  // Used to figure out which records have met the search criteria.
  EXPORT rec_with_bitflag :=
    RECORD
      id_rec;
      UNSIGNED1 bitflag;
    END;

    EXPORT layout_w_penalt := record(Medlic_layout.layout_w_penalt)
    END;


    EXPORT layout_w_penalt_plus := record(Medlic_layout.layout_w_penalt_plus)
    END;

    EXPORT format_input(DATASET(pl_rec) ak_input):= function
        fm_input :=  PROJECT(ak_input,TRANSFORM(pl_rec
        ,SELF.license_number := TRIM(StringLib.StringToUpperCase(LEFT.License_number))
        ,SELF.st := TRIM(StringLib.StringToUpperCase(LEFT.st))
        ,SELF.TAXID := TRIM(StringLib.StringToUpperCase(LEFT.TAXID))
        ,SELF.UPIN := TRIM(StringLib.StringToUpperCase(LEFT.UPIN))
        ,SELF := LEFT));
        RETURN fm_input;

    END;

    // The following function returns a dataset, one of whose fields contains a Provider_ID. This
    // Provider_ID will be used later to try to find sanctions. One important thing we must not do
    // is return Provider_IDs that don't match the input subject. This can happen in an autokey
    // search, where the system may find matches against the address of the search subject, but not
    // necessarily the name. To avoid this, we'll filter based on did. This filter also has the side
    // effect of not returning any matches for an address-only search. However, this should be acceptable,
    // since before adding the did filter, this function was performing an address-only search many times,
    // and it was returning results that in no way matched the search subject. So it's a good trade-off.
    export get_ProvIds(DATASET(pl_rec) ak_input):= function

      // Get Provider_IDs.

      //**** GET FAKEIDS - FLAPD SEARCH
      ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
          export UseAllLookUps := TRUE;
          export skip_set :=Ingenix_NatlProf.Constants.autokey_skip_set_prov;
      END;

      //**** GET FAKEIDS - FLAPD SEARCH
      ak_key := Ingenix_NatlProf.Constants.Autokey_qa_name_Prov;
      ak_in := PROJECT(ak_input,Autokey_batch.Layouts.rec_inBatchMaster);
      ak_out := Autokey_batch.get_fids(ak_in, ak_key, ak_config_data);
      outpl_rec := dataset([],Prof_LicenseV2_Services.Assorted_Layouts.Layout_Autokeys_Prov);
      typ_str := Ingenix_NatlProf.Constants.autokey_typeStr_prov;
      AutokeyB2.mac_get_payload(ak_out,ak_key,outpl_rec,outpl,did,zero,typ_str);
      RETURN outpl;
    end;

    export get_SancIds(DATASET(pl_rec) ak_input):= function
        //**** GET FAKEIDS - FLAPD SEARCH
        ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
            export UseAllLookUps := TRUE;
            export skip_set :=Ingenix_NatlProf.Constants.autokey_skip_set_sanc;
        END;
        //**** GET FAKEIDS - FLAPD SEARCH
        ak_key := Ingenix_NatlProf.Constants.autokey_qa_name_sanc;
        ak_in := PROJECT(ak_input(license_number='' and UPIN = '' and Taxid=''),Autokey_batch.Layouts.rec_inBatchMaster);
        ak_out := Autokey_batch.get_fids(ak_in, ak_key, ak_config_data);
        outpl_rec := dataset([],Prof_LicenseV2_Services.Assorted_Layouts.Layout_Autokeys_Sanc);
        typ_str := Ingenix_NatlProf.Constants.autokey_typeStr_sanc;
        AutokeyB2.mac_get_payload(ak_out,ak_key,outpl_rec,outpl,did,zero,typ_str);

        RETURN outpl;
    end;

    export get_ProfIds(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ak_input):= function

        //**** GET FAKEIDS - FLAPD SEARCH
        ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
            export UseAllLookUps := TRUE;
            export skip_set :=Prof_LicenseV2.Constants.skip_set;
        END;
        //**** GET FAKEIDS - FLAPD SEARCH
        ak_key := Prof_LicenseV2.Constants.autokey_qa_name;
        ak_out := Autokey_batch.get_fids(ak_input, ak_key, ak_config_data);
        outpl_rec := dataset([],Prof_LicenseV2.Layouts_ProfLic.Layout_Autokeys);
        AutokeyB2.mac_get_payload(ak_out,ak_key,outpl_rec, outpl,did,bdid);
        RETURN outpl;
    end;

    export get_prov_ids_from_dids(dataset(id_rec) in_dids) := function
      key := doxie_files.key_provider_did;
      res := join(dedup(sort(in_dids,did,acctno),did,acctno),key,
                  keyed(left.did = right.l_did),
                  transform(id_rec,
                    SELF.providerid := right.providerid,
                    SELF := left),
                  limit(Prof_LicenseV2.Constants.JOIN_LIMIT_LARGE,skip));
      ded := dedup(sort(res,acctno,providerid),acctno,providerid);

      return ded;
    end;
    export get_prov_ids_from_licnum(dataset(pl_rec) ak_input) := function
      key := doxie_files.key_provider_license;
      in_licnum := DEDUP(SORT(PROJECT(ak_input(license_number<>'')
                   ,TRANSFORM(id_rec,SELF.providerid := 0,SELF := LEFT,SELF := []))
                   ,acctno,license_number),acctno,license_number);
      res := join(in_licnum,key,
                  keyed(left.st= right.LicenseState or right.licenseState <> '') AND
                  keyed(left.license_number = right.LicenseNumber),
                  transform(id_rec,SELF.providerid := (unsigned6)RIGHT.providerid, SELF := LEFT,SELF := [])
                  ,limit(Prof_LicenseV2.Constants.JOIN_LIMIT_LARGE,skip));
      ded := dedup(sort(res,acctno,providerid),acctno,providerid);

      return ded;
   end;
   export get_prov_ids_from_taxid(dataset(pl_rec) ak_input) := function
      key := doxie_files.key_provider_taxid;
      in_taxid := DEDUP(SORT(PROJECT(ak_input(taxid<>'')
                        ,TRANSFORM(id_rec,SELF.providerid := 0
                        , SELF := LEFT,SELF := []))
                   ,acctno,taxid),acctno,taxid);
      res := join(in_taxid,key,
                  keyed(left.taxid=right.l_taxid),
                  transform(id_rec,SELF.providerid := (unsigned6)RIGHT.providerid
                  , SELF := LEFT,SELF := [])
                  ,limit(Prof_LicenseV2.Constants.JOIN_LIMIT_LARGE,skip));
      ded := dedup(sort(res,acctno,providerid),acctno,providerid);

      return ded;
   end;

  export get_sanc_ids_from_dids(dataset(id_rec) in_dids) := function
    key := doxie_files.key_sanctions_did;
    res := join(dedup(sort(in_dids,did,acctno),did,acctno),key,
                keyed(left.did = right.l_did),
                transform(id_rec,self.sanc_id := (unsigned6) right.sanc_id,SELF := Left),
                limit(Prof_LicenseV2.Constants.JOIN_LIMIT_SMALL,skip));
    ded := dedup(sort(res,acctno,sanc_id),acctno,sanc_id);

    return ded;
  end;
  export get_sanc_ids_from_licnum(dataset(pl_rec) ak_input) := function
    key := 	doxie_files.key_license_sancid;
    in_licnum := DEDUP(SORT(PROJECT(ak_input(license_number<>'')
                 ,TRANSFORM(id_rec,SELF.providerid := 0,SELF := LEFT
                 ,SELF := []))
                 ,acctno,license_number),acctno,license_number);
    res := join(in_licnum,key,
                keyed(left.st = right.SANC_SANCST or left.st='') AND
                keyed(left.license_number = right.SANC_LICNBR),
                transform(id_rec,self.sanc_id := (unsigned6)right.sanc_id,SELF := LEFT,SELF := []),
                limit(Prof_LicenseV2.Constants.JOIN_LIMIT_LARGE,skip));
    ded := dedup(sort(res,acctno,Sanc_Id),acctno,Sanc_Id);

    return ded;
  end;
  export get_sanc_ids_from_taxid(dataset(pl_rec) ak_input) := function
      key := doxie_files.key_sanctions_taxid_name;
      in_taxid := DEDUP(SORT(PROJECT(ak_input(taxid<>'')
                        ,TRANSFORM(id_rec,SELF.providerid := 0
                        , SELF := LEFT,SELF := []))
                   ,acctno,taxid),acctno,taxid);
      res := join(in_taxid,key,
                  keyed(left.taxid=right.l_taxid),
                  transform(id_rec,self.sanc_id := (unsigned6)right.sanc_id, SELF := LEFT,SELF := [])
                  ,limit(Prof_LicenseV2.Constants.JOIN_LIMIT_LARGE,skip));
      ded := dedup(sort(res,acctno,Sanc_Id),acctno,Sanc_Id);

      return ded;
  end;
  export get_sanc_ids_from_UPIN(dataset(pl_rec) ak_input) := function
      key := doxie_files.key_upin_sancid;
      in_upin := DEDUP(SORT(PROJECT(ak_input(UPIN<>'')
                        ,TRANSFORM(id_rec,SELF.providerid := 0
                        , SELF := LEFT,SELF := []))
                   ,acctno,upin),acctno,upin);
      res := join(in_upin,key,
                  keyed(left.upin=right.l_upin),
                  transform(id_rec,self.sanc_id := (unsigned6)right.sanc_id, SELF := LEFT,SELF := [])
                  ,limit(Prof_LicenseV2.Constants.JOIN_LIMIT_LARGE,skip));
      ded := dedup(sort(res,acctno,Sanc_Id),acctno,Sanc_Id);

      return ded;
   end;

  export get_deaNum(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ak_input) := FUNCTION
      outpl := get_Provids(PROJECT(ak_input,pl_rec));
      ids_acctno := PROJECT(outpl,TRANSFORM(id_rec,SELF.providerid := (unsigned6)LEFT.providerid
                                                  , SELF := LEFT,SELF :=[] ));

      dea_num := JOIN(ids_acctno,Ingenix_NatlProf.key_DEA_providerid
                       ,LEFT.ProviderId = RIGHT.l_providerid
                       ,TRANSFORM(Assorted_Layouts.ProvId_dea,SELf := RIGHT,SELF := LEFT,SELF := [])
                       );

      RETURN DEDUP(SORT(DEA_num,acctno,deanumber,did),acctno,deanumber,did);

    END;

    export get_dea_by_proFIds(DATASET(Assorted_Layouts.ProvId_dea) ids_acctno_1,DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ak_input ) := FUNCTION
      dea_pl := get_deaNum(ak_input);
      dea_rec1 := Assorted_Layouts.ProvId_dea;
      ids_acctno := DEDUP(SORT(JOIN(ids_acctno_1,dea_pl
                     ,LEFT.did = RIGHT.did and RIGHT.did >0
                     ,TRANSFORM(dea_rec1
                                ,SELF.deanumber := RIGHT.deanumber
                                ,SELF.prolic_seq_id := LEFT.prolic_seq_id
                                ,SELf := LEFT
                                ,SELf := RIGHT
                                ,SELF := [])
                     ,LEFT OUTER),acctno,prolic_seq_id,deanumber,did),acctno,prolic_seq_id,deanumber,did);
        dea_rec1 xfm_dea1(dea_rec1 l, dea_rec1 r) := TRANSFORM
          SELF.dea_r := if(l.ProLic_Seq_Id = r.ProLic_Seq_Id,TRIM(l.dea_r)+';'+TRIM(r.deanumber) ,TRIM(r.deanumber));
          SELF := r;
        END;
        dea_id := DEDUP(SORT(PROJECT(ids_acctno,dea_rec1),ProLic_Seq_Id,deanumber,acctno),ProLic_Seq_Id,deanumber,acctno);
        dea_f := DEDUP(SORT(ITERATE(dea_id,xfm_dea1(LEFT,RIGHT)),ProLic_Seq_Id,acctno,-deanumber),ProLic_Seq_Id,acctno);
        RETURN dea_f;
    END;

    // The specialty fields are already sorted and deduped. Break out the child dataset so the final
    // transform can make a straight assignment without any processing. All other fields just pass through.
    EXPORT doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch process_specialty ( doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch l ) :=
      TRANSFORM
        SELF.Specialty_1  := IF( l.specialty[1].specialtyName != '' and l.specialty[1].specialtyGroupName != '',
                                 TRIM( l.specialty[1].specialtyName ) + '-' + TRIM( l.specialty[1].specialtyGroupName ),
                                 l.specialty[1].specialtyName );
        SELF.Specialty_2  := IF( l.specialty[2].specialtyName != '' and l.specialty[2].specialtyGroupName != '',
                                 TRIM( l.specialty[2].specialtyName) + '-' + TRIM( l.specialty[2].specialtyGroupName ),
                                 l.specialty[2].specialtyName );
        SELF.Specialty_3  := IF( l.specialty[3].specialtyName != '' and l.specialty[3].specialtyGroupName != '',
                                 TRIM( l.specialty[3].specialtyName ) + '-' + TRIM( l.specialty[3].specialtyGroupName ),
                                 l.specialty[3].specialtyName );
        SELF.Specialty_4  := IF( l.specialty[4].specialtyName != '' and l.specialty[4].specialtyGroupName != '',
                                 TRIM( l.specialty[4].specialtyName ) + '-' + TRIM( l.specialty[4].specialtyGroupName ),
                                 l.specialty[4].specialtyName );
        SELF.Specialty_5  := IF( l.specialty[5].specialtyName != '' and l.specialty[5].specialtyGroupName != '',
                                 TRIM( l.specialty[5].specialtyName ) + '-' + TRIM( l.specialty[5].specialtyGroupName ),
                                 l.specialty[5].specialtyName );
        SELF.Specialty_6  := IF( l.specialty[6].specialtyName != '' and l.specialty[6].specialtyGroupName != '',
                                 TRIM( l.specialty[6].specialtyName ) + '-' + TRIM( l.specialty[6].specialtyGroupName ),
                                 l.specialty[6].specialtyName );
        SELF.Specialty_7  := IF( l.specialty[7].specialtyName != '' and l.specialty[7].specialtyGroupName != '',
                                 TRIM( l.specialty[7].specialtyName ) + '-' + TRIM( l.specialty[7].specialtyGroupName ),
                                 l.specialty[7].specialtyName );
        SELF.Specialty_8  := IF( l.specialty[8].specialtyName != '' and l.specialty[8].specialtyGroupName != '',
                                 TRIM( l.specialty[8].specialtyName ) + '-' + TRIM( l.specialty[8].specialtyGroupName ),
                                 l.specialty[8].specialtyName );
        SELF.Specialty_9  := IF( l.specialty[9].specialtyName != '' and l.specialty[9].specialtyGroupName != '',
                                 TRIM( l.specialty[9].specialtyName ) + '-' + TRIM( l.specialty[9].specialtyGroupName ),
                                 l.specialty[9].specialtyName );
        SELF.Specialty_10 := IF( l.specialty[10].specialtyName != '' and l.specialty[10].specialtyGroupName != '',
                                TRIM( l.specialty[10].specialtyName ) + '-' + TRIM( l.specialty[10].specialtyGroupName ),
                                l.specialty[10].specialtyName );
        SELF.Specialty_11 := IF( l.specialty[11].specialtyName != '' and l.specialty[11].specialtyGroupName != '',
                                TRIM( l.specialty[11].specialtyName ) + '-' + TRIM( l.specialty[11].specialtyGroupName ),
                                l.specialty[11].specialtyName );
        SELF.Specialty_12 := IF( l.specialty[12].specialtyName != '' and l.specialty[12].specialtyGroupName != '',
                                TRIM( l.specialty[12].specialtyName) + '-' + TRIM( l.specialty[12].specialtyGroupName ),
                                l.specialty[12].specialtyName );
        SELF.Specialty_13 := IF( l.specialty[13].specialtyName != '' and l.specialty[13].specialtyGroupName != '',
                                TRIM( l.specialty[13].specialtyName) + '-' + TRIM( l.specialty[13].specialtyGroupName ),
                                l.specialty[13].specialtyName );
        SELF.Specialty_14 := IF( l.specialty[14].specialtyName != '' and l.specialty[14].specialtyGroupName != '',
                                TRIM( l.specialty[14].specialtyName ) + '-' + TRIM( l.specialty[14].specialtyGroupName ),
                                l.specialty[14].specialtyName );
        SELF.Specialty_15 := IF( l.specialty[15].specialtyName != '' and l.specialty[15].specialtyGroupName != '',
                                TRIM( l.specialty[15].specialtyName ) + '-' + TRIM( l.specialty[15].specialtyGroupName ),
                                l.specialty[15].specialtyName );
        SELF.Specialty_16 := IF( l.specialty[16].specialtyName != '' and l.specialty[16].specialtyGroupName != '',
                                TRIM( l.specialty[16].specialtyName ) + '-' + TRIM( l.specialty[16].specialtyGroupName ),
                                l.specialty[16].specialtyName );
        SELF.Specialty_17 := IF( l.specialty[17].specialtyName != '' and l.specialty[17].specialtyGroupName != '',
                                TRIM( l.specialty[17].specialtyName ) + '-' + TRIM( l.specialty[17].specialtyGroupName ),
                                l.specialty[17].specialtyName );
        SELF.Specialty_18 := IF( l.specialty[18].specialtyName != '' and l.specialty[18].specialtyGroupName != '',
                                TRIM( l.specialty[18].specialtyName ) + '-' + TRIM( l.specialty[18].specialtyGroupName ),
                                l.specialty[18].specialtyName );
        SELF.Specialty_19 := IF( l.specialty[19].specialtyName != '' and l.specialty[19].specialtyGroupName != '',
                                TRIM( l.specialty[19].specialtyName ) + '-' + TRIM( l.specialty[19].specialtyGroupName ),
                                l.specialty[19].specialtyName );
        SELF.Specialty_20 := IF( l.specialty[20].specialtyName != '' and l.specialty[20].specialtyGroupName != '',
                                TRIM( l.specialty[20].specialtyName ) + '-' + TRIM( l.specialty[20].specialtyGroupName ),
                                l.specialty[20].specialtyName );
        SELF              := l;

     END;

    // The medical school fields are already sorted and deduped. Break out the child dataset so the final
    // transform can make a straight assignment without any processing. All other fields just pass through.
    EXPORT doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch process_medical_school ( doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch l ) :=
      TRANSFORM
        SELF.MedSchoolName_1  := IF( l.medschool[1].medschoolName <> '',
                                     TRIM( l.medschool[1].medschoolName ) + ' ' + TRIM( l.medschool[1].GraduationYear ),
                                     '');
        SELF.MedSchoolName_2  := IF( l.medschool[2].medschoolName <> '',
                                     TRIM( l.medschool[2].medschoolName ) + ' ' + TRIM( l.medschool[2].GraduationYear ),
                                     '');
        SELF.MedSchoolName_3  := IF( l.medschool[3].medschoolName <> '',
                                     TRIM(l.medschool[3].medschoolName ) + ' ' + TRIM( l.medschool[3].GraduationYear ),
                                     '');
        SELF.MedSchoolName_4  := IF( l.medschool[4].medschoolName <> '',
                                     TRIM( l.medschool[4].medschoolName ) + ' ' + TRIM( l.medschool[4].GraduationYear ),
                                     '');
        SELF.MedSchoolName_5  := IF( l.medschool[5].medschoolName <> '',
                                     TRIM( l.medschool[5].medschoolName ) + ' ' + TRIM( l.medschool[5].GraduationYear ),
                                     '');
        SELF.MedSchoolName_6  := IF( l.medschool[6].medschoolName <> '',
                                     TRIM( l.medschool[6].medschoolName ) + ' ' + TRIM( l.medschool[6].GraduationYear ),
                                     '');
        SELF.MedSchoolName_7  := IF( l.medschool[7].medschoolName <> '',
                                     TRIM( l.medschool[7].medschoolName ) + ' ' + TRIM( l.medschool[7].GraduationYear ),
                                     '');
        SELF.MedSchoolName_8  := IF( l.medschool[8].medschoolName <> '',
                                     TRIM( l.medschool[8].medschoolName ) + ' ' + TRIM( l.medschool[8].GraduationYear ),
                                     '');
        SELF.MedSchoolName_9  := IF( l.medschool[9].medschoolName <> '',
                                     TRIM( l.medschool[9].medschoolName ) + ' ' + TRIM( l.medschool[9].GraduationYear ),
                                     '');
        SELF.MedSchoolName_10 := IF( l.medschool[10].medschoolName <> '',
                                     TRIM( l.medschool[10].medschoolName ) + ' ' + TRIM( l.medschool[10].GraduationYear ),
                                     '');
        SELF                  := l;
      END;


    Export get_lang( DATASET( doxie.ingenix_provider_module.ingenix_language_rec ) t ) :=
      FUNCTION
        lang_rec := RECORD
            string210 Language_r := '';
             string40  Language ;
        END;
        lang_rec xfm_lang(lang_rec l, lang_rec r) := TRANSFORM
          SELF.Language_r := TRIM( l.Language_r ) +
                             IF( l.Language_r != '' AND r.language != '' ,'; ' , '' ) +
                             TRIM( r.language );
          SELF := r;
        END;
        lang_id := SORT(PROJECT(t,lang_rec),Language);
        lang_f := ITERATE(lang_id,xfm_lang(LEFT,RIGHT));
        RETURN lang_f[COUNT(lang_f)].Language_r;
    END;


    EXPORT doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch process_language ( doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch l ) :=
      TRANSFORM
        SELF.Language1 := get_lang( l.language );
        SELF           := l;
      END;





    //Ingenix_NatlProf.key_providerID_NPI
    //Ingenix_NatlProf.key_NPI_providerid contains NPI field indexed by providerid.
    export prof_LicenseV2_Services.assorted_layouts.ProvId_dea
       get_prolic_seq_id_by_npi(dataset(prof_licensev2_services.assorted_layouts.ProvId_NPI) npi,
       Doxie.IDataAccess mod_access) := FUNCTION

        npi_rec1 := prof_licensev2_services.assorted_layouts.ProvId_NPI;
        tmp_prov_id_set := join(npi, 	Ingenix_NatlProf.key_providerID_NPI,
          (string10) LEFT.npi  =  right.l_npi,
          transform(npi_rec1,
            self.providerid := (unsigned6) right.providerid,
            self.prolic_seq_id := 0,
            self.npi :=  right.l_npi,
            self := left),
          limit(Prof_LicenseV2.Constants.JOIN_LIMIT_LARGE, skip));

        did_rec_provider := record
          doxie.layout_inBatchMaster.acctno;
          unsigned6 did;
          unsigned6 providerid;
        end;

        prov_id_set := dedup(sort(tmp_prov_id_set, providerid,acctno), providerid,acctno);

        prov_dids := join(prov_id_set, doxie_files.key_provider_id,
          left.providerid =  right.l_providerid,
          transform(did_rec_provider,
            self.did := (unsigned6) right.did,
            self.providerid := left.providerid,
            self.acctno := left.acctno),
          limit(Prof_LicenseV2.Constants.JOIN_LIMIT_LARGE, skip));
           // need to keep the did associated with the pro_lic_seq_id in order to join acctno backin
           // on return rec.
           // also filter out recs with non-zero dids..

          layout_w_compliance_fields := RECORD(prof_LicenseV2_Services.assorted_layouts.ProvId_dea)
              unsigned4 global_sid;
              unsigned8 record_sid;
          END;

          _provID_dea_recs := dedup(sort(join(prov_dids(did <> 0), Prof_LicenseV2.Key_Proflic_Did (),
            left.did = right.did,
            transform(layout_w_compliance_fields,
              self.acctno := left.acctno,
              self.did := left.did,
              self.ProLic_Seq_Id := right.ProLic_Seq_Id,
              self := [];),
            limit(Prof_LicenseV2.Constants.JOIN_LIMIT_SMALL,skip)), prolic_seq_id,acctno), prolic_seq_id,acctno);

          provID_dea_recs_suppressed := Suppress.MAC_SuppressSource(_provID_dea_recs, mod_access);
          Doxie.compliance.logSoldToSources(provID_dea_recs_suppressed, mod_access);
          provID_dea_recs := PROJECT(provID_dea_recs_suppressed, prof_LicenseV2_Services.assorted_layouts.ProvId_dea);

          return provID_dea_recs;
    END;

    export get_taxid(DATASET(doxie.ingenix_provider_module.ingenix_taxid_rec) t) := FUNCTION
        tax_rec := RECORD
            String120  tax_r := '';
             string10   TaxID;
        END;
        tax_rec xfm_tax(tax_rec l, tax_rec r) := TRANSFORM
          SELF.tax_r := TRIM(l.tax_r)+IF(l.tax_r<>'' and r.taxid<>'' ,' ; ','')
                        +TRIM(r.taxid) ;
          SELF := r;
        END;
        tax_id := SORT(PROJECT(t,tax_rec),taxid);
        tax_f  := ITERATE(tax_id,xfm_tax(LEFT,RIGHT));
        RETURN tax_f[COUNT(tax_f)].tax_r;
    END;

    EXPORT doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch process_taxid ( doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch l ) :=
      TRANSFORM
        SELF.taxid1 := get_taxid( l.taxid );
        SELF        := l;
      END;



    EXPORT get_UPIN(DATASET(doxie.ingenix_provider_module.ingenix_upin_rec) t) := FUNCTION
        UPIN_rec := RECORD
            string70 UPIN_r := '';
             string6  UPIN ;
        END;
        UPIN_rec xfm_UPIN(UPIN_rec l, UPIN_rec r) := TRANSFORM
          SELF.UPIN_r := TRIM(l.UPIN_r)+IF(l.UPIN_r<>'' and r.UPIN<>'' ,' ; ','')
                         +TRIM(r.UPIN) ;
          SELF := r;
        END;
        UPIN_id := SORT(PROJECT(t,UPIN_rec),UPIN);
        UPIN_f := ITERATE(UPIN_id,xfm_UPIN(LEFT,RIGHT));
        RETURN UPIN_f[COUNT(UPIN_f)].UPIN_r;
    END;

    EXPORT doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch process_upin ( doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch l ) :=
      TRANSFORM
        SELF.UPIN1 := get_UPIN(l.UPIN);
        SELF       := l;
      END;




    EXPORT get_dea(DATASET(doxie.ingenix_provider_module.ingenix_dea_rec) t) := FUNCTION
        dea_rec := RECORD
            string200 dea_r := '';
             string9  deanumber ;
        END;
        dea_rec xfm_dea(dea_rec l, dea_rec r) := TRANSFORM
          SELF.dea_r := TRIM(l.dea_r)+IF(l.dea_r<>'' and r.deanumber<>'' ,' ; ','')
                        +TRIM(r.deanumber) ;
          SELF := r;
        END;
        dea_id := dedup(SORT(PROJECT(t,dea_rec),deanumber),deanumber);
        dea_f := ITERATE(dea_id,xfm_dea(LEFT,RIGHT));
        RETURN dea_f[COUNT(dea_id)].dea_r;
    END;

    EXPORT doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch process_deaNumber ( doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch l ) :=
      TRANSFORM
        SELF.deaNumber1 := get_dea(l.dea);
        SELF            := l;
      END;


    Export format_date(string8	BirthDate) := FUNCTION
       RETURN IF(LENGTH(BirthDate) % 2 = 0
                ,BirthDate[1..4]+if(BirthDate[5]<>'','/','')
                +BirthDate[5..6]+if(BirthDate[7]<>'','/','')
                +BirthDate[7..8]
                ,BirthDate);
    END;
    export get_Degree(DATASET(doxie.ingenix_provider_module.ingenix_degree_rec) t) := FUNCTION
        degree_rec := RECORD
            string120 degree_r := '';
             string10  degree ;
        END;
        degree_rec xfm_degree(degree_rec l, degree_rec r) := TRANSFORM
          SELF.degree_r := TRIM(l.degree_r)+IF(l.degree_r<>'' and r.degree<>'' ,' ; ','')
                           +TRIM(r.degree) ;
          SELF := r;
        END;
        degree_id := SORT(PROJECT(t,degree_rec),degree);
        degree_f := ITERATE(degree_id,xfm_degree(LEFT,RIGHT));
        RETURN degree_f[COUNT(degree_f)].degree_r;
    END;

    EXPORT doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch process_degree ( doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch l ) :=
      TRANSFORM
        SELF.degree1 := get_Degree(l.degree);
        SELF         := l;
      END;


    export get_Hospital(DATASET(doxie.ingenix_provider_module.ingenix_hospital_rec) t, integer n) := FUNCTION
        hospital_id := DEDUP(SORT(t,hospitalname),hospitalname);
        hospital_f := IF(hospital_id[2*n-1].hospitalname<>''
                         ,TRIM(hospital_id[2*n-1].hospitalname)+' ; '+
                         TRIM(hospital_id[2*n].hospitalname),'');
        RETURN hospital_f;
    END;
    export get_residency(DATASET(doxie.ingenix_provider_module.ingenix_residency_rec) t, integer n) := FUNCTION
        residency_id := DEDUP(SORT(t,residency),residency);
        residency_f := IF(residency_id[2*n-1].residency<>'',TRIM(residency_id[2*n-1].residency)+' ; '+TRIM(residency_id[2*n].residency),'');
        RETURN residency_f;
    END;
    EXPORT get_group(DATASET(doxie.ingenix_provider_module.ingenix_group_rec) t, integer n) := FUNCTION
        group_id := DEDUP(SORT(t,groupname),groupname);
        group_f := IF(group_id[2*n-1].groupname<>'',TRIM(group_id[2*n-1].groupname)+' ; '+TRIM(group_id[2*n].groupname),'');
        RETURN group_f;
    END;
    export get_medschool(DATASET(doxie.ingenix_provider_module.ingenix_medschool_rec) t, integer n) := FUNCTION
        medschool_id := DEDUP(SORT(t,medschoolName,GraduationYear),medschoolName,GraduationYear);
        medschool_f := IF(medschool_id[n].medschoolName<>''
                          ,TRIM(medschool_id[n].medschoolName)+' '+TRIM(medschool_id[n].GraduationYear)
                          ,'');
        RETURN medschool_f;
    END;
    EXPORT get_specialty(DATASET(doxie.ingenix_provider_module.ingenix_specialty_rec) t, integer n) := FUNCTION
        specialty_id := DEDUP(SORT(t,specialtyName,specialtyGroupName),specialtyName,specialtyGroupName);
        specialty_f := IF(specialty_id[n].specialtyName<>''
                       ,TRIM(specialty_id[n].specialtyName)+'-'+TRIM(specialty_id[n].specialtyGroupName)
                       ,'');

        RETURN specialty_f;
    END;

    EXPORT get_license(doxie.ingenix_provider_module.ingenix_license_rpt_rec t) := FUNCTION
       license_f := IF(t.licensenumber<>'',TRIM(t.licensenumber,all) + ' ' +
                                           TRIM(t.licensestate,all)  + ' ' +
                                           TRIM(format_date(t.effective_date),all) + ' - ' +
                                           format_date(t.termination_date)
                                          ,'');

       RETURN license_f;
    END;

    EXPORT doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch process_license ( doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch l ) :=
      TRANSFORM
        SELF.License_1  := get_license( l.license[1] );
        SELF.License_2  := get_license( l.license[2] );
        SELF.License_3  := get_license( l.license[3] );
        SELF.License_4  := get_license( l.license[4] );
        SELF.License_5  := get_license( l.license[5] );
        SELF.License_6  := get_license( l.license[6] );
        SELF.License_7  := get_license( l.license[7] );
        SELF.License_8  := get_license( l.license[8] );
        SELF.License_9  := get_license( l.license[9] );
        SELF.License_10 := get_license( l.license[10] );
        SELF.License_11 := get_license( l.license[11] );
        SELF.License_12 := get_license( l.license[12] );
        SELF.License_13 := get_license( l.license[13] );
        SELF.License_14 := get_license( l.license[14] );
        SELF.License_15 := get_license( l.license[15] );
        SELF.License_16 := get_license( l.license[16] );
        SELF.License_17 := get_license( l.license[17] );
        SELF.License_18 := get_license( l.license[18] );
        SELF.License_19 := get_license( l.license[19] );
        SELF.License_20 := get_license( l.license[20] );
        SELF            := l;
      END;


    EXPORT add_rec := RECORD
        string55 	  Address1;
        string20 	  Address2;
        string55 	  City;
        String2     St;
        String10    Zip;
        string150 	PhoneNumber;
    END;
    EXPORT get_phone(DATASET(doxie.ingenix_provider_module.ingenix_phone_slim_rec) t) := FUNCTION
        ph_rec := RECORD
            string150 ph_r := '';
             string10	PhoneNumber;
            String60  PhoneType;
        END;
        get_PHType(string60	PhoneType) := FUNCTION
          phtype:= IF(PhoneType<>'','(','')
                   +
                   IF(StringLib.StringFind(StringLib.StringToUpperCase(PhoneType),'OFFICE',1)>0,'O','')
                   +
                   IF(StringLib.StringFind(StringLib.StringToUpperCase(PhoneType),'HOME',1)>0,'H','')
                   +
                   IF(StringLib.StringFind(StringLib.StringToUpperCase(PhoneType),'PHONE',1)>0,'P','')
                   +
                   IF(StringLib.StringFind(StringLib.StringToUpperCase(PhoneType),'FAX',1)>0,'F','')
                   +
                   IF(PhoneType<>'',')','');
          RETURN phtype;
        END;
        format_phone(ph_rec r) := FUNCTION
          ph := TRIM(r.phonenumber);
          ph_1 := IF(LENGTH(ph)=10,'('+ph[1..3]+')'+ph[4..6]+'-'+ph[7..],ph);
          RETURN ph_1+get_PHtype(r.phonetype);
        END;
        ph_rec xfm_phone(ph_rec l, ph_rec r) := TRANSFORM
          SELF.ph_r := TRIM(l.ph_r)+IF(TRIM(l.ph_r)<>'' and r.Phonenumber <>'',' ; ','')
                       +format_phone(r) ;
          SELF := r;
        END;
        ph_id := DEDUP(SORT(PROJECT(t,ph_rec),PhoneNumber,-PhoneType),PhoneNumber);
        ph_f := ITERATE(ph_id,xfm_phone(LEFT,RIGHT));
        RETURN ph_f[COUNT(ph_f)].ph_r;
    END;
    EXPORT add_rec get_address(doxie.ingenix_provider_module.ingenix_addr_rpt_rec add_id) := TRANSFORM
        SELF.address1 := 	TRIM(add_id.prov_clean_prim_range)+' '+ TRIM(add_id.prov_clean_predir)
                          +' '+ TRIM(add_id.prov_clean_prim_name)+' '+ TRIM(add_id.prov_clean_addr_suffix)
                          +' '+ TRIM(add_id.prov_clean_postdir);
        SELF.address2 := 	TRIM(add_id.prov_clean_unit_desig)+' '+ TRIM(add_id.prov_clean_sec_range);
        SELF.city := 	TRIM(add_id.prov_clean_p_city_name);
        SELF.st := 	TRIM(add_id.prov_clean_st);
        SELF.zip := 	TRIM(add_id.prov_clean_zip)+' '+ TRIM(add_id.prov_clean_zip4);
        SELF.phonenumber := get_phone(add_id.phone);
    END;

    EXPORT get_taxonomy_code(DATASET(doxie.ingenix_provider_module.ingenix_taxonomy_rec) t)  := FUNCTION
        taxonomy_rec := RECORD
          String300 Taxonomycode_r := '';
          String50 TaxonomyCode;
        END;
        taxonomy_rec  xfm_taxonomycode(taxonomy_rec l, taxonomy_rec r)   := TRANSFORM
          SELF.taxonomycode_r := TRIM(l.taxonomycode_r) +
                                IF(l.taxonomycode_r <> '' AND r.taxonomycode <> '', ' ; ','')
                                    + TRIM(r.taxonomycode);
          SELF := r;
        END;
        taxonomy_recs := DEDUP(SORT(PROJECT(t,taxonomy_rec),taxonomyCode),taxonomyCode);
        taxonomy_code_count := ITERATE(taxonomy_recs,xfm_taxonomycode(LEFT,RIGHT));
        RETURN taxonomy_code_count[COUNT(taxonomy_code_count)].taxonomycode_r;
    END;

    EXPORT doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch process_taxonomy ( doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch l ) :=
      TRANSFORM
        SELF.taxonomy_code1 := get_taxonomy_code(l.taxonomy);
        SELF                := l;
      END;


    // Added account number (acctno) to the second layout.  The acctno was used to join multiple data sources -- since
    // it's not part of the final layout, not putting it though an additional transform to strip it off before being
    // passed to the following transform.
    EXPORT layout_w_penalt_plus get_Medlic_Layout(id_PLus_rec l, doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch r) :=
      TRANSFORM
          SELF.acctno := l.acctno;
          // SELF.penalt := fn_penalt(l,r.name[1],r.business_address,r.taxid,r.license);
          SELF.ProviderId := (string12)r.ProviderId;
          SELF.did        :=  r.providerdid[1].did; // removed the did != 0 filter on the dataset because it's done in the backfill attribute
          SELF.prov_clean_fname := r.name[1].prov_clean_fname;
          SELF.prov_clean_mname := r.name[1].prov_clean_mname;
          SELF.prov_clean_lname := r.name[1].prov_clean_lname;
          SELF.taxid          := r.taxid1;
          self.taxonomy_code  := r.taxonomy_code1;
          self.npi            := r.npi[1].npi;  // The final layout is STRING10, and the first npi is the best as further upstream we are verifying the npi and sortingthe verified one to the top of the list
          SELF.gender_name    := r.gender_name;
          SELF.sanc_flag      := r.sanc_flag;
          SELF.birthdate      := format_date(r.dob[1].birthdate);
          SELf.language       := r.Language1;
          SELF.UPIN           := r.UPIN1;
          SELF.deanumber      := r.deanumber1;
          SELF.degree         := r.degree1;
          SELF.hospitalname_1 := r.hospital_affiliation[1].hospitalname;
          self.hospitalAffiliationAddress_1 := r.hospital_affiliation[1].address;
          self.hospitalAffiliationCity_1 :=  r.hospital_affiliation[1].city;
          self.hospitalAffiliationState_1 := r.hospital_affiliation[1].state;
          self.hospitalAffiliationZip_1 := r.hospital_affiliation[1].zip;
          SELF.hospitalname_2 := r.hospital_affiliation[2].hospitalname;
          self.hospitalAffiliationAddress_2 := r.hospital_affiliation[2].address;
          self.hospitalAffiliationCity_2 :=  r.hospital_affiliation[2].city;
          self.hospitalAffiliationState_2 := r.hospital_affiliation[2].state;
          self.hospitalAffiliationZip_2 := r.hospital_affiliation[2].zip;
          SELF.hospitalname_3 := r.hospital_affiliation[3].hospitalname;
          self.hospitalAffiliationAddress_3 := r.hospital_affiliation[3].address;
          self.hospitalAffiliationCity_3 :=  r.hospital_affiliation[3].city;
          self.hospitalAffiliationState_3 := r.hospital_affiliation[3].state;
          self.hospitalAffiliationZip_3 := r.hospital_affiliation[3].zip;
          SELF.hospitalname_4 := r.hospital_affiliation[4].hospitalname;
          self.hospitalAffiliationAddress_4 := r.hospital_affiliation[4].address;
          self.hospitalAffiliationCity_4 :=  r.hospital_affiliation[4].city;
          self.hospitalAffiliationState_4 := r.hospital_affiliation[4].state;
          self.hospitalAffiliationZip_4 := r.hospital_affiliation[4].zip;
          SELF.hospitalname_5 := r.hospital_affiliation[5].hospitalname;
          self.hospitalAffiliationAddress_5 := r.hospital_affiliation[5].address;
          self.hospitalAffiliationCity_5 :=  r.hospital_affiliation[5].city;
          self.hospitalAffiliationState_5 := r.hospital_affiliation[5].state;
          self.hospitalAffiliationZip_5 := r.hospital_affiliation[5].zip;
          SELF.hospitalname_6 := r.hospital_affiliation[6].hospitalname;
          self.hospitalAffiliationAddress_6:= r.hospital_affiliation[6].address;
          self.hospitalAffiliationCity_6 :=  r.hospital_affiliation[6].city;
          self.hospitalAffiliationState_6 := r.hospital_affiliation[6].state;
          self.hospitalAffiliationZip_6 := r.hospital_affiliation[6].zip;
          SELF.hospitalname_7 := r.hospital_affiliation[7].hospitalname;
          self.hospitalAffiliationAddress_7 := r.hospital_affiliation[7].address;
          self.hospitalAffiliationCity_7 :=  r.hospital_affiliation[7].city;
          self.hospitalAffiliationState_7 := r.hospital_affiliation[7].state;
          self.hospitalAffiliationZip_7 := r.hospital_affiliation[7].zip;
          SELF.hospitalname_8 := r.hospital_affiliation[8].hospitalname;
          self.hospitalAffiliationAddress_8 := r.hospital_affiliation[8].address;
          self.hospitalAffiliationCity_8 :=  r.hospital_affiliation[8].city;
          self.hospitalAffiliationState_8 := r.hospital_affiliation[8].state;
          self.hospitalAffiliationZip_8 := r.hospital_affiliation[8].zip;
          SELF.hospitalname_9 := r.hospital_affiliation[9].hospitalname;
          self.hospitalAffiliationAddress_9 := r.hospital_affiliation[9].address;
          self.hospitalAffiliationCity_9 :=  r.hospital_affiliation[9].city;
          self.hospitalAffiliationState_9 := r.hospital_affiliation[9].state;
          self.hospitalAffiliationZip_9 := r.hospital_affiliation[9].zip;
          SELF.hospitalname_10 := r.hospital_affiliation[10].hospitalname;
          self.hospitalAffiliationAddress_10 := r.hospital_affiliation[10].address;
          self.hospitalAffiliationCity_10 :=  r.hospital_affiliation[10].city;
          self.hospitalAffiliationState_10 := r.hospital_affiliation[10].state;
          self.hospitalAffiliationZip_10 := r.hospital_affiliation[10].zip;

          SELF.residency_1 := r.residency[1].residency;
          SELF.residency_2 := r.residency[2].residency;
          SELF.residency_3 := r.residency[3].residency;
          SELF.residency_4 := r.residency[4].residency;
          SELF.residency_5 := r.residency[5].residency;
          SELF.residency_6 := r.residency[6].residency;
          SELF.residency_7 := r.residency[7].residency;
          SELF.residency_8 := r.residency[8].residency;
          SELF.residency_9 := r.residency[9].residency;
          SELF.residency_10 := r.residency[10].residency;
          SELF.groupname_1 := r.group_affiliation[1].groupname;
          self.groupAffiliationAddress_1 := r.group_affiliation[1].address;
          self.groupAffiliationCity_1 :=  r.group_affiliation[1].city;
          self.groupAffiliationState_1 := r.group_affiliation[1].state;
          self.groupAffiliationZip_1 := r.group_affiliation[1].zip;
          SELF.groupname_2 := r.group_affiliation[2].groupname;
          self.groupAffiliationAddress_2 := r.group_affiliation[2].address;
          self.groupAffiliationCity_2 :=  r.group_affiliation[2].city;
          self.groupAffiliationState_2 := r.group_affiliation[2].state;
          self.groupAffiliationZip_2 := r.group_affiliation[2].zip;
          SELF.groupname_3 := r.group_affiliation[3].groupname;
          self.groupAffiliationAddress_3 := r.group_affiliation[3].address;
          self.groupAffiliationCity_3 :=  r.group_affiliation[3].city;
          self.groupAffiliationState_3 := r.group_affiliation[3].state;
          self.groupAffiliationZip_3 := r.group_affiliation[3].zip;
          SELF.groupname_4 := r.group_affiliation[4].groupname;
          self.groupAffiliationAddress_4 := r.group_affiliation[4].address;
          self.groupAffiliationCity_4 :=  r.group_affiliation[4].city;
          self.groupAffiliationState_4 := r.group_affiliation[4].state;
          self.groupAffiliationZip_4 := r.group_affiliation[4].zip;
          SELF.groupname_5 := r.group_affiliation[5].groupname;
          self.groupAffiliationAddress_5 := r.group_affiliation[5].address;
          self.groupAffiliationCity_5 :=  r.group_affiliation[5].city;
          self.groupAffiliationState_5 := r.group_affiliation[5].state;
          self.groupAffiliationZip_5 := r.group_affiliation[5].zip;
          SELF.groupname_6 := r.group_affiliation[6].groupname;
          self.groupAffiliationAddress_6 := r.group_affiliation[10].address;
          self.groupAffiliationCity_6 :=  r.group_affiliation[6].city;
          self.groupAffiliationState_6 := r.group_affiliation[6].state;
          self.groupAffiliationZip_6 := r.group_affiliation[6].zip;
          SELF.groupname_7 := r.group_affiliation[7].groupname;
          self.groupAffiliationAddress_7 := r.group_affiliation[7].address;
          self.groupAffiliationCity_7 :=  r.group_affiliation[7].city;
          self.groupAffiliationState_7 := r.group_affiliation[7].state;
          self.groupAffiliationZip_7 := r.group_affiliation[7].zip;
          SELF.groupname_8 := r.group_affiliation[8].groupname;
          self.groupAffiliationAddress_8 := r.group_affiliation[8].address;
          self.groupAffiliationCity_8 :=  r.group_affiliation[8].city;
          self.groupAffiliationState_8 := r.group_affiliation[8].state;
          self.groupAffiliationZip_8 := r.group_affiliation[8].zip;
          SELF.groupname_9 := r.group_affiliation[9].groupname;
          self.groupAffiliationAddress_9 := r.group_affiliation[9].address;
          self.groupAffiliationCity_9 :=  r.group_affiliation[9].city;
          self.groupAffiliationState_9 := r.group_affiliation[9].state;
          self.groupAffiliationZip_9 := r.group_affiliation[9].zip;
          SELF.groupname_10 := r.group_affiliation[10].groupname;
          self.groupAffiliationAddress_10 := r.group_affiliation[10].address;
          self.groupAffiliationCity_10 :=  r.group_affiliation[10].city;
          self.groupAffiliationState_10 := r.group_affiliation[10].state;
          self.groupAffiliationZip_10 := r.group_affiliation[10].zip;
          SELF.Lic1_Number     := r.license[1].licensenumber;
          SELF.Lic1_State      := r.license[1].licensestate;
          SELF.Lic1_Eff_date   := format_date(r.license[1].effective_date);
          SELF.Lic1_Exp_Date   := format_date(r.license[1].termination_date);
          SELF.Lic2_Number     := r.license[2].licensenumber;
          SELF.Lic2_State      := r.license[2].licensestate;
          SELF.Lic2_Eff_date   := format_date(r.license[2].effective_date);
          SELF.Lic2_Exp_Date   := format_date(r.license[2].termination_date);
          SELF.Lic3_Number     := r.license[3].licensenumber;
          SELF.Lic3_State      := r.license[3].licensestate;
          SELF.Lic3_Eff_date   := format_date(r.license[3].effective_date);
          SELF.Lic3_Exp_Date   := format_date(r.license[3].termination_date);
          SELF.Lic4_Number     := r.license[4].licensenumber;
          SELF.Lic4_State      := r.license[4].licensestate;
          SELF.Lic4_Eff_date   := format_date(r.license[4].effective_date);
          SELF.Lic4_Exp_Date   := format_date(r.license[4].termination_date);
          SELF.Lic5_Number     := r.license[5].licensenumber;
          SELF.Lic5_State      := r.license[5].licensestate;
          SELF.Lic5_Eff_date   := format_date(r.license[5].effective_date);
          SELF.Lic5_Exp_Date   := format_date(r.license[5].termination_date);
          SELF.Lic6_Number     := r.license[6].licensenumber;
          SELF.Lic6_State      := r.license[6].licensestate;
          SELF.Lic6_Eff_date   := format_date(r.license[6].effective_date);
          SELF.Lic6_Exp_Date   := format_date(r.license[6].termination_date);
          SELF.Lic7_Number     := r.license[7].licensenumber;
          SELF.Lic7_State      := r.license[7].licensestate;
          SELF.Lic7_Eff_date   := format_date(r.license[7].effective_date);
          SELF.Lic7_Exp_Date   := format_date(r.license[7].termination_date);
          SELF.Lic8_Number     := r.license[8].licensenumber;
          SELF.Lic8_State      := r.license[8].licensestate;
          SELF.Lic8_Eff_date   := format_date(r.license[8].effective_date);
          SELF.Lic8_Exp_Date   := format_date(r.license[8].termination_date);
          SELF.Lic9_Number     := r.license[9].licensenumber;
          SELF.Lic9_State      := r.license[9].licensestate;
          SELF.Lic9_Eff_date   := format_date(r.license[9].effective_date);
          SELF.Lic9_Exp_Date   := format_date(r.license[9].termination_date);
          SELF.Lic10_Number    := r.license[10].licensenumber;
          SELF.Lic10_State     := r.license[10].licensestate;
          SELF.Lic10_Eff_date  := format_date(r.license[10].effective_date);
          SELF.Lic10_Exp_Date  := format_date(r.license[10].termination_date);
          SELF.Lic11_Number    := r.license[11].licensenumber;
          SELF.Lic11_State     := r.license[11].licensestate;
          SELF.Lic11_Eff_date  := format_date(r.license[11].effective_date);
          SELF.Lic11_Exp_Date  := format_date(r.license[11].termination_date);
          SELF.Lic12_Number    := r.license[12].licensenumber;
          SELF.Lic12_State     := r.license[12].licensestate;
          SELF.Lic12_Eff_date  := format_date(r.license[12].effective_date);
          SELF.Lic12_Exp_Date  := format_date(r.license[12].termination_date);
          SELF.Lic13_Number    := r.license[13].licensenumber;
          SELF.Lic13_State     := r.license[13].licensestate;
          SELF.Lic13_Eff_date  := format_date(r.license[13].effective_date);
          SELF.Lic13_Exp_Date  := format_date(r.license[13].termination_date);
          SELF.Lic14_Number    := r.license[14].licensenumber;
          SELF.Lic14_State     := r.license[14].licensestate;
          SELF.Lic14_Eff_date  := format_date(r.license[14].effective_date);
          SELF.Lic14_Exp_Date  := format_date(r.license[14].termination_date);
          SELF.Lic15_Number    := r.license[15].licensenumber;
          SELF.Lic15_State     := r.license[15].licensestate;
          SELF.Lic15_Eff_date  := format_date(r.license[15].effective_date);
          SELF.Lic15_Exp_Date  := format_date(r.license[15].termination_date);
          SELF.Lic16_Number    := r.license[16].licensenumber;
          SELF.Lic16_State     := r.license[16].licensestate;
          SELF.Lic16_Eff_date  := format_date(r.license[16].effective_date);
          SELF.Lic16_Exp_Date  := format_date(r.license[16].termination_date);
          SELF.Lic17_Number    := r.license[17].licensenumber;
          SELF.Lic17_State     := r.license[17].licensestate;
          SELF.Lic17_Eff_date  := format_date(r.license[17].effective_date);
          SELF.Lic17_Exp_Date  := format_date(r.license[17].termination_date);
          SELF.Lic18_Number    := r.license[18].licensenumber;
          SELF.Lic18_State     := r.license[18].licensestate;
          SELF.Lic18_Eff_date  := format_date(r.license[18].effective_date);
          SELF.Lic18_Exp_Date  := format_date(r.license[18].termination_date);
          SELF.Lic19_Number    := r.license[19].licensenumber;
          SELF.Lic19_State     := r.license[19].licensestate;
          SELF.Lic19_Eff_date  := format_date(r.license[19].effective_date);
          SELF.Lic19_Exp_Date  := format_date(r.license[19].termination_date);
          SELF.Lic20_Number    := r.license[20].licensenumber;
          SELF.Lic20_State     := r.license[20].licensestate;
          SELF.Lic20_Eff_date  := format_date(r.license[20].effective_date);
          SELF.Lic20_Exp_Date  := format_date(r.license[20].termination_date);

          // b_addr := PROJECT(DEDUP(SORT(r.business_address,-prov_clean_prim_range,-prov_clean_prim_name,-prov_clean_unit_desig,-prov_clean_sec_range,-prov_clean_p_city_name,-prov_clean_st,-prov_clean_zip,-prov_clean_zip4,-COUNT(phone))
                    // ,prov_clean_prim_range,prov_clean_prim_name,prov_clean_unit_desig,prov_clean_sec_range,prov_clean_p_city_name,prov_clean_st,prov_clean_zip,prov_clean_zip4,COUNT(phone))
                    // ,doxie.ingenix_provider_module.ingenix_addr_rec);

          SELF.address1_1           := r.bus_addr2[1].address1;
          SELF.address2_1           := r.bus_addr2[1].address2;
          SELF.city_1               := r.bus_addr2[1].city;
          SELF.st_1                 := r.bus_addr2[1].st;
          SELF.zip_1                := r.bus_addr2[1].zip;
          SELF.PhoneNumber_1        := r.bus_addr2[1].phoneNumber;
          SELF.address1_2           := r.bus_addr2[2].address1;
          SELF.address2_2           := r.bus_addr2[2].address2;
          SELF.city_2               := r.bus_addr2[2].city;
          SELF.st_2                 := r.bus_addr2[2].st;
          SELF.zip_2                := r.bus_addr2[2].zip;
          SELF.PhoneNumber_2        := r.bus_addr2[2].phoneNumber;
          SELF.address1_3           := r.bus_addr2[3].address1;
          SELF.address2_3           := r.bus_addr2[3].address2;
          SELF.city_3               := r.bus_addr2[3].city;
          SELF.st_3                 := r.bus_addr2[3].st;
          SELF.zip_3                := r.bus_addr2[3].zip;
          SELF.PhoneNumber_3        := r.bus_addr2[3].phoneNumber;
          SELF.address1_4           := r.bus_addr2[4].address1;
          SELF.address2_4           := r.bus_addr2[4].address2;
          SELF.city_4               := r.bus_addr2[4].city;
          SELF.st_4                 := r.bus_addr2[4].st;
          SELF.zip_4                := r.bus_addr2[4].zip;
          SELF.PhoneNumber_4        := r.bus_addr2[4].phoneNumber;
          SELF.address1_5           := r.bus_addr2[5].address1;
          SELF.address2_5           := r.bus_addr2[5].address2;
          SELF.city_5               := r.bus_addr2[5].city;
          SELF.st_5                 := r.bus_addr2[5].st;
          SELF.zip_5                := r.bus_addr2[5].zip;
          SELF.PhoneNumber_5        := r.bus_addr2[5].phoneNumber;
          SELF.address1_6           := r.bus_addr2[6].address1;
          SELF.address2_6           := r.bus_addr2[6].address2;
          SELF.city_6               := r.bus_addr2[6].city;
          SELF.st_6                 := r.bus_addr2[6].st;
          SELF.zip_6                := r.bus_addr2[6].zip;
          SELF.PhoneNumber_6        := r.bus_addr2[6].phoneNumber;
          SELF.address1_7           := r.bus_addr2[7].address1;
          SELF.address2_7           := r.bus_addr2[7].address2;
          SELF.city_7               := r.bus_addr2[7].city;
          SELF.st_7                 := r.bus_addr2[7].st;
          SELF.zip_7                := r.bus_addr2[7].zip;
          SELF.PhoneNumber_7        := r.bus_addr2[7].phoneNumber;
          SELF.address1_8           := r.bus_addr2[8].address1;
          SELF.address2_8           := r.bus_addr2[8].address2;
          SELF.city_8               := r.bus_addr2[8].city;
          SELF.st_8                 := r.bus_addr2[8].st;
          SELF.zip_8                := r.bus_addr2[8].zip;
          SELF.PhoneNumber_8        := r.bus_addr2[8].phoneNumber;
          SELF.address1_9           := r.bus_addr2[9].address1;
          SELF.address2_9           := r.bus_addr2[9].address2;
          SELF.city_9               := r.bus_addr2[9].city;
          SELF.st_9                 := r.bus_addr2[9].st;
          SELF.zip_9                := r.bus_addr2[9].zip;
          SELF.PhoneNumber_9        := r.bus_addr2[9].phoneNumber;
          SELF.address1_10          := r.bus_addr2[10].address1;
          SELF.address2_10          := r.bus_addr2[10].address2;
          SELF.city_10              := r.bus_addr2[10].city;
          SELF.st_10                := r.bus_addr2[10].st;
          SELF.zip_10               := r.bus_addr2[10].zip;
          SELF.PhoneNumber_10       := r.bus_addr2[10].phoneNumber;
          SELF.in_license_number    := l.license_number;
          SELF.in_TaxID             := l.taxid;
          SELF.taxid_rec            := r.taxid;
          SELF.license_rec          := r.license;
          SELF.business_address_rec := r.business_address;
          SELF.group_address_rec 		:= r.group_affiliation;
          SELF.hospital_address_rec := r.hospital_affiliation;
          SELF                      := l;
          SELF                      := r;
          SELF                      := [];
    END;

    UNSIGNED1 fn_penalt( layout_w_penalt_plus l ) :=
      FUNCTION
          gm:=AutoStandardI.GlobalModule();
          tempindvmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))
            EXPORT lastname       := l.name_last;       // the 'input' last name
            EXPORT middlename     := l.name_middle;     // the 'input' middle name
            EXPORT firstname      := l.name_first;      // the 'input' first name
            EXPORT allow_wildcard := FALSE;
            EXPORT useGlobalScope := FALSE;
            EXPORT lname_field    := l.prov_clean_lname;			// matching record name information
            EXPORT mname_field    := l.prov_clean_mname;
            EXPORT fname_field    := l.prov_clean_fname;
          END;

          tmp_ind_name := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod);

          rowcnt := count(l.business_Address_rec);
          tempmod1 := prof_LicenseV2_Services.Medlic_Addr_Functions.getModBusiness(l,1);
          tmp_ind_addr1 := if(rowcnt>=1,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod1),100);
          tempmod2 := prof_LicenseV2_Services.Medlic_Addr_Functions.getModBusiness(l,2);
          tmp_ind_addr2 := if(rowcnt>=2,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod2),100);
          tempmod3 := prof_LicenseV2_Services.Medlic_Addr_Functions.getModBusiness(l,3);
          tmp_ind_addr3 := if(rowcnt>=3,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod3),100);
          tempmod4 := prof_LicenseV2_Services.Medlic_Addr_Functions.getModBusiness(l,4);
          tmp_ind_addr4 := if(rowcnt>=4,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod4),100);
          tempmod5 := prof_LicenseV2_Services.Medlic_Addr_Functions.getModBusiness(l,5);
          tmp_ind_addr5 := if(rowcnt>=5,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod5),100);
          tempmod6 := prof_LicenseV2_Services.Medlic_Addr_Functions.getModBusiness(l,6);
          tmp_ind_addr6 := if(rowcnt>=6,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod6),100);
          tempmod7 := prof_LicenseV2_Services.Medlic_Addr_Functions.getModBusiness(l,7);
          tmp_ind_addr7 := if(rowcnt>=7,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod7),100);
          tempmod8 := prof_LicenseV2_Services.Medlic_Addr_Functions.getModBusiness(l,8);
          tmp_ind_addr8 := if(rowcnt>=8,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod8),100);
          tempmod9 := prof_LicenseV2_Services.Medlic_Addr_Functions.getModBusiness(l,9);
          tmp_ind_addr9 := if(rowcnt>=9,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod9),100);
          tempmod10 := prof_LicenseV2_Services.Medlic_Addr_Functions.getModBusiness(l,10);
          tmp_ind_addr10 := if(rowcnt>=10,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod10),100);

          rowcntGrp := count(l.group_address_rec);
          tempmod1Grp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModGroup(l,1);
          tmp_ind_addr1Grp := if(rowcntGrp>=1,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod1Grp),100);
          tempmod2Grp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModGroup(l,2);
          tmp_ind_addr2Grp := if(rowcntGrp>=2,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod2Grp),100);
          tempmod3Grp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModGroup(l,3);
          tmp_ind_addr3Grp := if(rowcntGrp>=3,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod3Grp),100);
          tempmod4Grp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModGroup(l,4);
          tmp_ind_addr4Grp := if(rowcntGrp>=4,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod4Grp),100);
          tempmod5Grp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModGroup(l,5);
          tmp_ind_addr5Grp := if(rowcntGrp>=5,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod5Grp),100);
          tempmod6Grp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModGroup(l,6);
          tmp_ind_addr6Grp := if(rowcntGrp>=6,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod6Grp),100);
          tempmod7Grp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModGroup(l,7);
          tmp_ind_addr7Grp := if(rowcntGrp>=7,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod7Grp),100);
          tempmod8Grp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModGroup(l,8);
          tmp_ind_addr8Grp := if(rowcntGrp>=8,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod8Grp),100);
          tempmod9Grp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModGroup(l,9);
          tmp_ind_addr9Grp := if(rowcntGrp>=9,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod9Grp),100);
          tempmod10Grp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModGroup(l,10);
          tmp_ind_addr10Grp := if(rowcntGrp>=10,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod10Grp),100);

          rowcntHosp := count(l.hospital_address_rec);
          tempmod1Hosp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModHosp(l,1);
          tmp_ind_addr1Hosp := if(rowcntHosp>=1,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod1Hosp),100);
          tempmod2Hosp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModHosp(l,2);
          tmp_ind_addr2Hosp := if(rowcntHosp>=2,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod2Hosp),100);
          tempmod3Hosp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModHosp(l,3);
          tmp_ind_addr3Hosp := if(rowcntHosp>=3,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod3Hosp),100);
          tempmod4Hosp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModHosp(l,4);
          tmp_ind_addr4Hosp := if(rowcntHosp>=4,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod4Hosp),100);
          tempmod5Hosp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModHosp(l,5);
          tmp_ind_addr5Hosp := if(rowcntHosp>=5,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod5Hosp),100);
          tempmod6Hosp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModHosp(l,6);
          tmp_ind_addr6Hosp := if(rowcntHosp>=6,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod6Hosp),100);
          tempmod7Hosp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModHosp(l,7);
          tmp_ind_addr7Hosp := if(rowcntHosp>=7,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod7Hosp),100);
          tempmod8Hosp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModHosp(l,8);
          tmp_ind_addr8Hosp := if(rowcntHosp>=8,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod8Hosp),100);
          tempmod9Hosp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModHosp(l,9);
          tmp_ind_addr9Hosp := if(rowcntHosp>=9,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod9Hosp),100);
          tempmod10Hosp := prof_LicenseV2_Services.Medlic_Addr_Functions.getModHosp(l,10);
          tmp_ind_addr10Hosp := if(rowcntHosp>=10,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmod10Hosp),100);
          tmp_ind_addr := if(rowcnt>0 or rowcntGrp>0 or rowcntHosp>0,MIN(dataset([
                                                      {tmp_ind_addr1},{tmp_ind_addr2},{tmp_ind_addr3},{tmp_ind_addr4},{tmp_ind_addr5},{tmp_ind_addr6},{tmp_ind_addr7},{tmp_ind_addr8},{tmp_ind_addr9},{tmp_ind_addr10},
                                                      {tmp_ind_addr1Grp},{tmp_ind_addr2Grp},{tmp_ind_addr3Grp},{tmp_ind_addr4Grp},{tmp_ind_addr5Grp},{tmp_ind_addr6Grp},{tmp_ind_addr7Grp},{tmp_ind_addr8Grp},{tmp_ind_addr9Grp},{tmp_ind_addr10Grp},
                                                      {tmp_ind_addr1Hosp},{tmp_ind_addr2Hosp},{tmp_ind_addr3Hosp},{tmp_ind_addr4Hosp},{tmp_ind_addr5Hosp},{tmp_ind_addr6Hosp},{tmp_ind_addr7Hosp},{tmp_ind_addr8Hosp},{tmp_ind_addr9Hosp},{tmp_ind_addr10Hosp}
                                                      ],{unsigned pen}),pen),0);
          tmp_taxid   := IF((EXISTS( l.taxid_rec ) AND NOT EXISTS(l.taxid_rec(l.in_taxid = '' OR taxid = l.in_taxid))) OR (l.in_taxid != '' AND NOT EXISTS(l.taxid_rec)),15,0);
          tmp_license := IF((EXISTS( l.license_rec ) AND NOT EXISTS(l.license_rec(l.in_license_number = '' OR licensenumber = l.in_license_Number))) OR (l.in_license_number != '' AND NOT EXISTS(l.license_rec)),15,0);

        RETURN tmp_ind_name + tmp_ind_addr + tmp_taxid + tmp_license;
      END;


    EXPORT layout_w_penalt get_Medlic_Layout_penalt( layout_w_penalt_plus l ) :=
      TRANSFORM
          SELF.penalt := fn_penalt(l);
          SELF        := l;
      END;

  END;	// batch view module:

END;
