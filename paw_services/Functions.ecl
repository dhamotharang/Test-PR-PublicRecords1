IMPORT Autokey_Batch, AutoStandardI, ut, doxie, paw_services, suppress;

EXPORT Functions := MODULE
  SHARED fnDate(DATASET(paw_services.Layouts.raw) in_recs) := FUNCTION
    temp_filter := in_recs(dt_last_seen != '' OR dt_first_seen != '');
    temp_rollup := ROLLUP(temp_filter,
      TRUE,
      TRANSFORM(paw_services.Layouts.raw,
        SELF.dt_last_seen := MAP(
          RIGHT.dt_last_seen = '' => LEFT.dt_last_seen,
          LEFT.dt_last_seen = '' => RIGHT.dt_last_seen,
          LEFT.dt_last_seen > RIGHT.dt_last_seen => LEFT.dt_last_seen,
          RIGHT.dt_last_seen),
        SELF.dt_first_seen := MAP(
          RIGHT.dt_first_seen = '' => LEFT.dt_first_seen,
          LEFT.dt_first_seen = '' => RIGHT.dt_first_seen,
          LEFT.dt_first_seen < RIGHT.dt_first_seen => LEFT.dt_first_seen,
          RIGHT.dt_first_seen),
        SELF := LEFT));
    temp_project := PROJECT(temp_rollup,paw_services.Layouts.rptDtSeen);
    RETURN temp_project;
  END;
  SHARED fnSsn(DATASET(paw_services.Layouts.raw) in_recs, STRING ssnmask) := FUNCTION
    temp_filter := in_recs(ssn != '');
    temp_sort := SORT(temp_filter,ssn,-dt_last_seen,-dt_first_seen,-score,RECORD);
    temp_dedup := DEDUP(temp_sort,ssn);
    temp_resort := SORT(temp_dedup,-dt_last_seen,-dt_first_seen,-score,ssn,RECORD);
    temp_project := PROJECT(temp_resort,paw_services.Layouts.rptSsn);
    suppress.MAC_Mask (temp_project, temp_masked, SSN, null, TRUE, FALSE, , , , ssnmask);
    RETURN temp_masked;
  END;
  SHARED fnFein(DATASET(paw_services.Layouts.raw) in_recs) := FUNCTION
    temp_filter := in_recs(company_fein != '');
    temp_sort := SORT(temp_filter,company_fein,-dt_last_seen,-dt_first_seen,-score,RECORD);
    temp_dedup := DEDUP(temp_sort,company_fein);
    temp_resort := SORT(temp_dedup,-dt_last_seen,-dt_first_seen,-score,company_fein,RECORD);
    temp_project := PROJECT(temp_resort,TRANSFORM(paw_services.Layouts.rptFein,
      SELF.fein := LEFT.company_fein));
    RETURN temp_project;
  END;
  SHARED fnIndvName(DATASET(paw_services.Layouts.raw) in_recs) := FUNCTION
    temp_filter := in_recs(title != '' OR fname != '' OR mname != '' OR lname != '' OR name_suffix != '');
    temp_sort := SORT(temp_filter,lname,fname,mname,name_suffix,title,-dt_last_seen,-dt_first_seen,-score,RECORD);
    temp_dedup := DEDUP(temp_sort,lname,fname,mname,name_suffix,title);
    temp_resort := SORT(temp_dedup,-dt_last_seen,-dt_first_seen,-score,lname,fname,mname,name_suffix,title,RECORD);
    temp_project := PROJECT(temp_resort,paw_services.Layouts.rptIndvName);
    RETURN temp_project;
  END;
  SHARED fnBizName(DATASET(paw_services.Layouts.raw) in_recs) := FUNCTION
    temp_filter := in_recs(company_name != '');
    temp_sort := SORT(temp_filter,company_name,-dt_last_seen,-dt_first_seen,-score,RECORD);
    temp_dedup := DEDUP(temp_sort,company_name);
    temp_resort := SORT(temp_dedup,-dt_last_seen,-dt_first_seen,-score,company_name,RECORD);
    temp_project := PROJECT(temp_resort,paw_services.Layouts.rptBizName);
    RETURN temp_project;
  END;
  SHARED fnPhone(DATASET(paw_services.Layouts.raw) in_recs) := FUNCTION
    temp_filter := in_recs((INTEGER)company_phone != 0);
    temp_sort := SORT(temp_filter,company_phone,-dt_last_seen,-dt_first_seen,-score,RECORD);
    temp_dedup := DEDUP(temp_sort,company_phone);
    temp_resort := SORT(temp_dedup,-dt_last_seen,-dt_first_seen,-score,company_phone,RECORD);
    temp_project := PROJECT(temp_resort,TRANSFORM(paw_services.Layouts.rptPhone,SELF.phone10 := LEFT.company_phone,SELF.verified := FALSE,SELF:=LEFT) );
    RETURN temp_project;
  END;
  SHARED fnAddr := MODULE
    EXPORT params := INTERFACE
      EXPORT UNSIGNED2 REQ_PHONES_PER_ADDR;
    END;
    EXPORT val(DATASET(paw_services.Layouts.raw) in_recs,params in_mod) := FUNCTION
      temp_filter := in_recs(prim_range != '' OR predir != '' OR prim_name != '' OR addr_suffix != '' OR postdir != '' OR unit_desig != '' OR sec_range != '' OR city != '' OR state != '' OR zip != '' OR zip4 != '');
      temp_sort := SORT(in_recs,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,city,state,zip,zip4,-dt_last_seen,-dt_first_seen,-score,RECORD);
      temp_rollup := ROLLUP(GROUP(temp_sort,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,city,state,zip,zip4),GROUP,
        TRANSFORM(paw_services.Layouts.rptAddr,
          SELF.phones := CHOOSEN(fnPhone(ROWS(LEFT)),ut.min2(in_mod.REQ_PHONES_PER_ADDR,Constants.MAX_PHONES_PER_ADDR)),
          SELF := LEFT));
      RETURN temp_rollup;
    END;
  END;
  SHARED fnPosition := MODULE
    EXPORT params := INTERFACE
      EXPORT UNSIGNED2 REQ_DATES_PER_POSITION;
    END;
    EXPORT val(DATASET(paw_services.Layouts.raw) in_recs,params in_mod) := FUNCTION
      temp_filter := in_recs(company_title != '' OR company_department != '');
      temp_sort := SORT(temp_filter,company_title,company_department);
      temp_rollup := ROLLUP(GROUP(temp_sort,company_title,company_department),GROUP,
        TRANSFORM(paw_services.Layouts.rptPosition,
          SELF.dates := CHOOSEN(fnDate(ROWS(LEFT)),ut.min2(in_mod.REQ_DATES_PER_POSITION,Constants.MAX_DATES_PER_POSITION)),
          SELF.company_title := LEFT.company_title,
          SELF.company_department := LEFT.company_department));
      RETURN temp_rollup;
    END;
  END;
  SHARED fnEmployer := MODULE
    EXPORT params := INTERFACE(fnPosition.params,fnAddr.params)
      EXPORT STRING ssn_mask;

      EXPORT UNSIGNED2 REQ_DATES_PER_EMPLOYER;
      EXPORT UNSIGNED2 REQ_FEINS_PER_EMPLOYER;
      EXPORT UNSIGNED2 REQ_COMPANY_NAMES_PER_EMPLOYER;
      EXPORT UNSIGNED2 REQ_ADDRS_PER_EMPLOYER;
      EXPORT UNSIGNED2 REQ_POSITIONS_PER_EMPLOYER;
    END;
    EXPORT val(DATASET(paw_services.Layouts.raw) in_recs,params in_mod) := FUNCTION
      temp_sort := SORT(in_recs,bdid,IF(bdid = 0,contact_id,0));
      temp_rollup := ROLLUP(GROUP(temp_sort,bdid,IF(bdid = 0,contact_id,0)),GROUP,
        TRANSFORM(paw_services.Layouts.rptEmployer,
          SELF.bdid := LEFT.bdid,
          SELF.proxid := LEFT.proxid,
          SELF.ultid := LEFT.ultid,
          SELF.orgid := LEFT.orgid,
          SELF.seleid := LEFT.seleid,
          SELF.dotid := LEFT.dotid,
          SELF.empid := LEFT.empid,
          SELF.powid := LEFT.powid,
          SELF.dates := CHOOSEN(fnDate(ROWS(LEFT)),ut.min2(in_mod.REQ_DATES_PER_EMPLOYER,Constants.MAX_DATES_PER_EMPLOYER)),
          SELF.feins := CHOOSEN(fnFein(ROWS(LEFT)),ut.min2(in_mod.REQ_FEINS_PER_EMPLOYER,Constants.MAX_FEINS_PER_EMPLOYER)),
          SELF.company_names := CHOOSEN(fnBizName(ROWS(LEFT)),ut.min2(in_mod.REQ_COMPANY_NAMES_PER_EMPLOYER,Constants.MAX_COMPANY_NAMES_PER_EMPLOYER)),
          SELF.addrs := CHOOSEN(fnAddr.val(PROJECT(ROWS(LEFT),TRANSFORM(paw_services.Layouts.raw,
            SELF.prim_range := LEFT.company_prim_range,
            SELF.predir := LEFT.company_predir,
            SELF.prim_name := LEFT.company_prim_name,
            SELF.addr_suffix := LEFT.company_addr_suffix,
            SELF.postdir := LEFT.company_postdir,
            SELF.unit_desig := LEFT.company_unit_desig,
            SELF.sec_range := LEFT.company_sec_range,
            SELF.city := LEFT.company_city,
            SELF.state := LEFT.company_state,
            SELF.zip := LEFT.company_zip,
            SELF.zip4 := LEFT.company_zip4,
            SELF := LEFT)),in_mod),ut.min2(in_mod.REQ_ADDRS_PER_EMPLOYER,Constants.MAX_ADDRS_PER_EMPLOYER)),
          SELF.positions := CHOOSEN(SORT(fnPosition.val(ROWS(LEFT),in_mod),-dates[1].dt_last_seen,-dates[1].dt_first_seen,RECORD),ut.min2(in_mod.REQ_POSITIONS_PER_EMPLOYER,Constants.MAX_POSITIONS_PER_EMPLOYER))));
      RETURN temp_rollup;
    END;
  END;
  EXPORT fnPerson := MODULE
    EXPORT params := INTERFACE(fnEmployer.params)
      EXPORT UNSIGNED2 REQ_SSNS_PER_PERSON;
      EXPORT UNSIGNED2 REQ_NAMES_PER_PERSON;
      EXPORT UNSIGNED2 REQ_EMPLOYERS_PER_PERSON;
    END;
    EXPORT val(DATASET(paw_services.Layouts.raw) in_recs,params in_mod) := FUNCTION
      RETURN ROLLUP(GROUP(SORT(in_recs,did,IF(did = 0,contact_id,0)),did,IF(did = 0,contact_id,0)),GROUP,TRANSFORM(paw_services.Layouts.rptPerson,
        SELF.did := LEFT.did,
        SELF.isDeepDive := IF(EXISTS(ROWS(LEFT)(NOT isDeepDive)),FALSE,TRUE),
        SELF.penalt := MIN(ROWS(LEFT),penalt),
        SELF.ssns := CHOOSEN(fnSsn(ROWS(LEFT), in_mod.ssn_mask),ut.min2(in_mod.REQ_SSNS_PER_PERSON,Constants.MAX_SSNS_PER_PERSON)),
        SELF.names := CHOOSEN(fnIndvName(ROWS(LEFT)),ut.min2(in_mod.REQ_NAMES_PER_PERSON,Constants.MAX_NAMES_PER_PERSON)),
        SELF.employers := CHOOSEN(SORT(fnEmployer.val(ROWS(LEFT),in_mod),-dates[1].dt_last_seen,-dates[1].dt_first_seen,RECORD),ut.min2(in_mod.REQ_EMPLOYERS_PER_PERSON,Constants.MAX_EMPLOYERS_PER_PERSON)),
        SELF.hasCriminalConviction := LEFT.hasCriminalConviction,
        SELF.isSexualOffender := LEFT.isSexualOffender));
    END;
  END;
  
  EXPORT BATCH_VIEW := MODULE
    SHARED format_addr(paw_services.Layouts.batch_in L) := FUNCTION
      RETURN TRIM(L.company_prim_range) +' ' +TRIM(L.company_predir) +' ' +TRIM(L.company_prim_name)
              +' ' +TRIM(L.company_addr_suffix) +' ' +TRIM(L.company_postdir)+' '+
              TRIM(L.company_unit_desig) +' ' +TRIM(L.company_sec_range);
    END;
    
    SHARED check_ph_verified(paw_services.Layouts.batch_in L ) := FUNCTION
      in_ds := DEDUP(SORT(L+L,company_phone),company_phone);
      // ph_ds := DATASET([{1,L.phone,cname_ds}]
                      // ,doxie.Layout_Append_Gong_Biz.Layout_In);
      doxie.Layout_Append_Gong_Biz.Layout_In xfm_gong_ph(paw_services.Layouts.batch_in in_paw) := TRANSFORM
        SELF.__seq :=1;
        SELF.phone := in_paw.company_phone;
        SELF.company_names := DATASET([{in_paw.company_name}],{STRING120 company_name});
      END;
      ph_ds := PROJECT(in_ds,xfm_gong_ph(LEFT));
      out_ds := doxie.Append_Gong_Biz(ph_ds)[1];
      RETURN IF(NOT TRIM(L.company_phone) IN ['0',''] ,IF(out_ds.verified,'YES','NO'),'');
    END;
     
    SHARED format_did(UNSIGNED6 did ) := FUNCTION
    RETURN IF(did<>0,(STRING12)did,'');
    END;


    SHARED format_bdid(UNSIGNED6 bdid ) := FUNCTION
    RETURN IF(bdid<>0,(STRING12)bdid,'');
    END;

    SHARED format_CPhone(STRING ph ) := FUNCTION
    RETURN IF(ph<>'0',ph,'');
    END;
     
    EXPORT paw_services.Layouts.layout_for_PAW_penalties xfm_prepend_underscore(Autokey_Batch.Layouts.rec_inBatchMaster l) :=
      TRANSFORM

        SELF._acctno := l.acctno;
                        
        SELF._name_first := l.name_first;
        SELF._name_middle := l.name_middle;
        SELF._name_last := l.name_last;
        SELF._name_suffix := l.name_suffix;
        
        SELF._comp_name := l.comp_name;
 
        SELF._prim_range := l.prim_range;
        SELF._predir := l.predir;
        SELF._prim_name := l.prim_name;
        SELF._addr_suffix := l.addr_suffix;
        SELF._postdir := l.postdir;
        SELF._unit_desig := l.unit_desig;
        SELF._sec_range := l.sec_range;
        SELF._p_city_name := l.p_city_name;
        SELF._st := l.st;
        SELF._z5 := l.z5;
        SELF._zip4 := l.zip4;
                        
        SELF._ssn := l.ssn;
        SELF._fein := l.fein;
        SELF._dob := l.dob;
        SELF._homephone := l.homephone;
        SELF._workphone := l.workphone;
                      
      END;
      
    EXPORT fn_apply_penalty(paw_services.Layouts.layout_for_PAW_penalties l,
                            paw_services.Layouts.batch_in r) :=
      FUNCTION

        persons_to_compare_1 :=
          MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv.full, OPT))

            // The 'input' name:
            EXPORT lastname := l._name_last;
            EXPORT middlename := l._name_middle;
            EXPORT firstname := l._name_first;
            EXPORT ssn := l._ssn;
            EXPORT dob := (INTEGER)l._dob;
            
            // The 'input' address:
            EXPORT predir := l._predir;
            EXPORT prim_name := l._prim_name;
            EXPORT prim_range := l._prim_range;
            EXPORT postdir := l._postdir;
            EXPORT addr_suffix := l._addr_suffix;
            EXPORT sec_range := l._sec_range;
            EXPORT p_city_name := l._p_city_name;
            EXPORT st := l._st;
            EXPORT z5 := l._z5;
      
            // The name in the matching record:
            EXPORT lname_field := r.lname;
            EXPORT mname_field := r.mname;
            EXPORT fname_field := r.fname;
            EXPORT ssn_field := r.ssn;
            EXPORT dob_field := '';
            
            // The address in the matching record:
            EXPORT allow_wildcard := FALSE;
            EXPORT city_field := r.city;
            EXPORT city2_field := '';
            EXPORT pname_field := r.prim_name;
            EXPORT postdir_field := r.postdir;
            EXPORT prange_field := r.prim_range;
            EXPORT predir_field := r.predir;
            EXPORT sec_range_field:= r.sec_range;
            EXPORT state_field := r.state;
            EXPORT zip_field := r.zip;
            
            EXPORT county_field := '';
            EXPORT DID_field := '';
            EXPORT phone_field := '';
            EXPORT suffix_field := r.addr_suffix;
            
            EXPORT useGlobalScope := FALSE;
          END;
          
        persons_to_compare_2 := // ...compare input address against matching RECORD's business address.
          MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv.full, OPT))

            // The 'input' name:
            EXPORT lastname := l._name_last;
            EXPORT middlename := l._name_middle;
            EXPORT firstname := l._name_first;
            EXPORT ssn := l._ssn;
            EXPORT dob := (INTEGER)l._dob;
            
            // The 'input' address:
            EXPORT predir := l._predir;
            EXPORT prim_name := l._prim_name;
            EXPORT prim_range := l._prim_range;
            EXPORT postdir := l._postdir;
            EXPORT addr_suffix := l._addr_suffix;
            EXPORT sec_range := l._sec_range;
            EXPORT p_city_name := l._p_city_name;
            EXPORT st := l._st;
            EXPORT z5 := l._z5;
      
            // The name in the matching record:
            EXPORT lname_field := r.lname;
            EXPORT mname_field := r.mname;
            EXPORT fname_field := r.fname;
            EXPORT ssn_field := r.ssn;
            EXPORT dob_field := '';
            
            // The address in the matching record:
            EXPORT allow_wildcard := FALSE;
            EXPORT pname_field := r.company_prim_name;
            EXPORT postdir_field := r.company_postdir;
            EXPORT prange_field := r.company_prim_range;
            EXPORT predir_field := r.company_predir;
            EXPORT suffix_field := r.company_addr_suffix;
            EXPORT sec_range_field := r.company_sec_range;
            EXPORT city_field := r.company_city;
            EXPORT state_field := r.company_state;
            EXPORT zip_field := r.company_zip;
            EXPORT city2_field := '';
            EXPORT county_field := '';
            EXPORT DID_field := '';
            EXPORT phone_field := '';
            
            EXPORT useGlobalScope := FALSE;
          END;

        businesses_to_compare :=
          MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Biz.full, OPT))

            // The 'input' name:
            EXPORT lastname := l._name_last;
            EXPORT middlename := l._name_middle;
            EXPORT firstname := l._name_first;
            EXPORT ssn := l._ssn;
            EXPORT dob := (INTEGER)l._dob;
            
            // The 'input' address:
            EXPORT predir := l._predir;
            EXPORT prim_name := l._prim_name;
            EXPORT prim_range := l._prim_range;
            EXPORT postdir := l._postdir;
            EXPORT addr_suffix := l._addr_suffix;
            EXPORT sec_range := l._sec_range;
            EXPORT p_city_name := l._p_city_name;
            EXPORT st := l._st;
            EXPORT z5 := l._z5;
      
            // The name in the matching record:
            EXPORT cname_field := r.company_name;
            EXPORT bdid_field := (STRING)r.bdid;
            
            // The address in the matching record:
            EXPORT allow_wildcard := FALSE;
            EXPORT fein_field := r.company_fein;
            EXPORT phone_field := r.company_phone;
            EXPORT pname_field := r.company_prim_name;
            EXPORT postdir_field := r.company_postdir;
            EXPORT prange_field := r.company_prim_range;
            EXPORT predir_field := r.company_predir;
            EXPORT suffix_field := r.company_addr_suffix;
            EXPORT sec_range_field := r.company_sec_range;
            EXPORT city_field := r.company_city;
            EXPORT state_field := r.company_state;
            EXPORT zip_field := r.company_zip;
            EXPORT city2_field := '';
            EXPORT county_field := '';
            
            EXPORT useGlobalScope := FALSE;
          END;
          
        person_penalty_1 := AutoStandardI.LIBCALL_PenaltyI_Indv.val(persons_to_compare_1);
        person_penalty_2 := AutoStandardI.LIBCALL_PenaltyI_Indv.val(persons_to_compare_2);
        business_penalty := AutoStandardI.LIBCALL_PenaltyI_Biz.val(businesses_to_compare);

        total_penalty := MAP( TRIM(l._comp_name) != '' AND TRIM(l._name_last) != '' => MIN(person_penalty_1, person_penalty_2) + business_penalty,
                                 TRIM(l._comp_name) != '' => business_penalty,
                                 /* ELSE .......................................... */ MIN(person_penalty_1, person_penalty_2) );

        RETURN total_penalty + 1;
        // We don't want to return '0' because we filter out records having '0' later. See
        // paw_services.Functions.fn_get_min_penalty().
        
      END;
      
      SHARED fn_get_min_penalty(UNSIGNED2 p1 = 0, UNSIGNED2 p2 = 0, UNSIGNED2 p3 = 0, UNSIGNED2 p4 = 0, UNSIGNED2 p5 = 0) :=
      FUNCTION
        penalties := DATASET([{p1},{p2},{p3},{p4},{p5}], {UNSIGNED2 penalt});
        RETURN MIN( penalties(penalt > 0), penalt );
      END;
       
      EXPORT paw_services.Layouts.batch_out format_batch_out (
        paw_services.Layouts.batch_in B,
        DATASET(paw_services.Layouts.batch_in) P) := 
        TRANSFORM
                                   
          SELF.penalt := fn_get_min_penalty( P[1].penalt, P[2].penalt, P[3].penalt, P[4].penalt, P[5].penalt);
         
          SELF.pawk_1_did := format_did(P[1].did) ;
          SELF.pawk_1_bdid := format_bdid(P[1].bdid) ;
          SELF.pawk_1_first := P[1].fname ;
          SELF.pawk_1_middle := P[1].mname ;
          SELF.pawk_1_last := P[1].lname;
          SELF.pawk_1_suffix := P[1].name_suffix ;
          SELF.pawk_1_ssn := P[1].ssn;
          SELF.pawk_1_title := P[1].company_title ;
          SELF.pawk_1_company_name := P[1].company_name ;
          SELF.pawk_1_department := P[1].company_department;
          SELF.pawk_1_fein := P[1].company_fein;
          SELF.pawk_1_address := format_addr(P[1]) ;
          SELF.pawk_1_city := P[1].company_city;
          SELF.pawk_1_state := P[1].company_state ;
          SELF.pawk_1_zip5 := P[1].company_zip;
          SELF.pawk_1_zip4 := P[1].company_zip4;
          SELF.pawk_1_phone10 := format_CPhone(P[1].company_phone) ;
          SELF.pawk_1_verified := check_ph_verified(p[1]);
          SELF.pawk_1_email := P[1].email_address;
          SELF.pawk_1_first_seen := P[1].dt_first_seen ;
          SELF.pawk_1_last_seen := P[1].dt_last_seen;
          SELF.pawk_1_confidence_level := P[1].score ;
         
          SELF.pawk_2_did := format_did(P[2].did) ;
          SELF.pawk_2_bdid := format_bdid(P[2].bdid) ;
          SELF.pawk_2_first := P[2].fname ;
          SELF.pawk_2_middle := P[2].mname ;
          SELF.pawk_2_last := P[2].lname;
          SELF.pawk_2_suffix := P[2].name_suffix ;
          SELF.pawk_2_ssn := P[2].ssn;
          SELF.pawk_2_title := P[2].company_title ;
          SELF.pawk_2_company_name := P[2].company_name ;
          SELF.pawk_2_department := P[2].company_department;
          SELF.pawk_2_fein := P[2].company_fein;
          SELF.pawk_2_address := format_addr(P[2]) ;
          SELF.pawk_2_city := P[2].company_city;
          SELF.pawk_2_state := P[2].company_state ;
          SELF.pawk_2_zip5 := P[2].company_zip;
          SELF.pawk_2_zip4 := P[2].company_zip4;
          SELF.pawk_2_phone10 := format_CPhone(P[2].company_phone) ;
          SELF.pawk_2_verified := check_ph_verified(p[2]);
          SELF.pawk_2_email := P[2].email_address;
          SELF.pawk_2_first_seen := P[2].dt_first_seen ;
          SELF.pawk_2_last_seen := P[2].dt_last_seen;
          SELF.pawk_2_confidence_level := P[2].score ;
          
          SELF.pawk_3_did := format_did(P[3].did) ;
          SELF.pawk_3_bdid := format_bdid(P[3].bdid) ;
          SELF.pawk_3_first := P[3].fname ;
          SELF.pawk_3_middle := P[3].mname ;
          SELF.pawk_3_last := P[3].lname;
          SELF.pawk_3_suffix := P[3].name_suffix ;
          SELF.pawk_3_ssn := P[3].ssn;
          SELF.pawk_3_title := P[3].company_title ;
          SELF.pawk_3_company_name := P[3].company_name ;
          SELF.pawk_3_department := P[3].company_department;
          SELF.pawk_3_fein := P[3].company_fein;
          SELF.pawk_3_address := format_addr(P[3]) ;
          SELF.pawk_3_city := P[3].company_city;
          SELF.pawk_3_state := P[3].company_state ;
          SELF.pawk_3_zip5 := P[3].company_zip;
          SELF.pawk_3_zip4 := P[3].company_zip4;
          SELF.pawk_3_phone10 := format_CPhone(P[3].company_phone) ;
          SELF.pawk_3_verified := check_ph_verified(p[3]);
          SELF.pawk_3_email := P[3].email_address;
          SELF.pawk_3_first_seen := P[3].dt_first_seen ;
          SELF.pawk_3_last_seen := P[3].dt_last_seen;
          SELF.pawk_3_confidence_level := P[3].score ;
          
          SELF.pawk_4_did := format_did(P[4].did) ;
          SELF.pawk_4_bdid := format_bdid(P[4].bdid) ;
          SELF.pawk_4_first := P[4].fname ;
          SELF.pawk_4_middle := P[4].mname ;
          SELF.pawk_4_last := P[4].lname;
          SELF.pawk_4_suffix := P[4].name_suffix ;
          SELF.pawk_4_ssn := P[4].ssn;
          SELF.pawk_4_title := P[4].company_title ;
          SELF.pawk_4_company_name := P[4].company_name ;
          SELF.pawk_4_department := P[4].company_department;
          SELF.pawk_4_fein := P[4].company_fein;
          SELF.pawk_4_address := format_addr(P[4]) ;
          SELF.pawk_4_city := P[4].company_city;
          SELF.pawk_4_state := P[4].company_state ;
          SELF.pawk_4_zip5 := P[4].company_zip;
          SELF.pawk_4_zip4 := P[4].company_zip4;
          SELF.pawk_4_phone10 := format_CPhone(P[4].company_phone) ;
          SELF.pawk_4_verified := check_ph_verified(p[4]);
          SELF.pawk_4_email := P[4].email_address;
          SELF.pawk_4_first_seen := P[4].dt_first_seen ;
          SELF.pawk_4_last_seen := P[4].dt_last_seen;
          SELF.pawk_4_confidence_level := P[4].score ;
          
          SELF.pawk_5_did := format_did(P[5].did) ;
          SELF.pawk_5_bdid := format_bdid(P[5].bdid) ;
          SELF.pawk_5_first := P[5].fname ;
          SELF.pawk_5_middle := P[5].mname ;
          SELF.pawk_5_last := P[5].lname;
          SELF.pawk_5_suffix := P[5].name_suffix ;
          SELF.pawk_5_ssn := P[5].ssn;
          SELF.pawk_5_title := P[5].company_title ;
          SELF.pawk_5_company_name := P[5].company_name ;
          SELF.pawk_5_department := P[5].company_department;
          SELF.pawk_5_fein := P[5].company_fein;
          SELF.pawk_5_address := format_addr(P[5]) ;
          SELF.pawk_5_city := P[5].company_city;
          SELF.pawk_5_state := P[5].company_state ;
          SELF.pawk_5_zip5 := P[5].company_zip;
          SELF.pawk_5_zip4 := P[5].company_zip4;
          SELF.pawk_5_phone10 := format_CPhone(P[5].company_phone) ;
          SELF.pawk_5_verified := check_ph_verified(p[5]);
          SELF.pawk_5_email := P[5].email_address;
          SELF.pawk_5_first_seen := P[5].dt_first_seen ;
          SELF.pawk_5_last_seen := P[5].dt_last_seen;
          SELF.pawk_5_confidence_level := P[5].score ;
          
          SELF := B;
          SELF := [];
        END;
      END;
  
END;
