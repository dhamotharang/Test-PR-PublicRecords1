IMPORT AutoKeyI, AutoStandardI, AutoHeaderI, doxie;
IMPORT autokeyb2, bankruptcyv2, bankruptcyv3, doxie_cbrs, STD;
doxie_cbrs.mac_Selection_Declare();

EXPORT bankruptcy_ids(
  DATASET(doxie.layout_references) in_dids,
  DATASET(doxie_cbrs.layout_references) in_bdids,
  DATASET(bankruptcyv3_services.layouts.layout_tmsid_ext) in_tmsids,
  UNSIGNED in_limit,
  STRING1 in_party_type = '',
  BOOLEAN isFCRA = FALSE,
  BOOLEAN isCaseNumberSearch = FALSE,
  BOOLEAN isAttorneySearch = FALSE
  ) :=
    FUNCTION
      get_tmsids_from_bdids(
        DATASET(bankruptcyv3_services.layouts.layout_bdid_ext) in_bdids,
        UNSIGNED in_limit = 0) :=
          FUNCTION
            
            sbdids := SORT(in_bdids(bdid != 0), bdid, IF(isdeepdive,1,0));
            dbdids := SORT(DEDUP(sbdids, bdid), IF(isdeepdive,1,0), bdid);
            
            res := JOIN(dbdids, bankruptcyv3.key_bankruptcyV3_bdid(isFCRA),
              KEYED(LEFT.bdid = RIGHT.p_bdid) AND
              (
                in_party_type = '' OR EXISTS(bankruptcyV3.key_bankruptcyV3_search_full_bip(isFCRA)((UNSIGNED)bdid=LEFT.bdid AND
                tmsid = RIGHT.tmsid AND name_type[1] = STD.STR.ToUpperCase(in_party_type)[1]))
              ),
              TRANSFORM(bankruptcyv3_services.layouts.layout_tmsid_ext,
                SELF := RIGHT,
                SELF := LEFT),
              LIMIT(20000,SKIP),
              KEEP(1000));
            ded := SORT(DEDUP(SORT(res,tmsid,IF(isdeepdive,1,0)),tmsid),IF(isdeepdive,1,0),tmsid);
            RETURN IF(in_limit = 0,ded,CHOOSEN(ded,in_limit));
          END;
      get_tmsids_from_dids(
        DATASET(bankruptcyv3_services.layouts.layout_did_ext) in_dids,
        UNSIGNED in_limit = 0) :=
          FUNCTION

            bk_search_key := bankruptcyV3.key_bankruptcyV3_search_full_bip(isFCRA);
            sdids := SORT(in_dids(did != 0), did, IF(isdeepdive,1,0));
            ddids := SORT(DEDUP(sdids, did), IF(isdeepdive,1,0), did);
            
            res := JOIN(ddids, bankruptcyv3.key_bankruptcyV3_did(isFCRA),
              KEYED(LEFT.did = RIGHT.did) AND
              (
                in_party_type = '' OR EXISTS(bk_search_key((UNSIGNED)did = LEFT.did AND tmsid = RIGHT.tmsid 
                AND name_type[1] = STD.STR.ToUpperCase(in_party_type)[1]))
              ),
              TRANSFORM(bankruptcyv3_services.layouts.layout_tmsid_ext,
                SELF := RIGHT,
                SELF := LEFT),
              LIMIT(20000,SKIP),
              KEEP(1000));
            ded := SORT(DEDUP(SORT(res,tmsid,IF(isdeepdive,1,0)),tmsid),IF(isdeepdive,1,0),tmsid);
            RETURN IF(in_limit = 0,ded,CHOOSEN(ded,in_limit));
          END;
      get_tmsids_from_casenumbers(
        DATASET(bankruptcyv3_services.layouts.layout_casenumber_ext) in_casenumbers,
        UNSIGNED in_limit = 0) :=
          FUNCTION
            
            scase_nums := SORT(in_casenumbers(orig_case_number != ''), orig_case_number, 
              filing_jurisdiction, IF(isdeepdive,1,0));
            dcase_nums := SORT(DEDUP(scase_nums, orig_case_number), IF(isdeepdive,1,0), 
              orig_case_number, filing_jurisdiction);
            
            res := JOIN(dcase_nums, bankruptcyv3.key_bankruptcyV3_casenumber(isFCRA),
              KEYED(LEFT.orig_case_number = RIGHT.case_number) AND
              KEYED(LEFT.filing_jurisdiction = '' OR LEFT.filing_jurisdiction = RIGHT.filing_state),
              TRANSFORM(bankruptcyv3_services.layouts.layout_tmsid_ext,
                SELF := RIGHT,
                SELF := LEFT),
              KEEP(1000));

            ded := SORT(DEDUP(SORT(res,tmsid,IF(isdeepdive,1,0)),tmsid),IF(isdeepdive,1,0),tmsid);
            RETURN IF(in_limit = 0,ded,CHOOSEN(ded,in_limit));
          END;
          
      outrec := bankruptcyv3_services.layouts.layout_tmsid_ext;
      ak := BankruptcyV2.Constants('', isFCRA);
      tempmod := MODULE(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
        EXPORT STRING autokey_keyname_root := ak.ak_keyname;
        EXPORT STRING typestr := 'AK';
        EXPORT SET of STRING1 get_skip_set := [];
        EXPORT BOOLEAN workHard := TRUE;
        EXPORT BOOLEAN noFail := FALSE;
        EXPORT BOOLEAN useAllLookups := TRUE;
      END;
      
      ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

      // Autokey
      AutokeyB2.mac_get_payload_ids (ids, tempmod.autokey_keyname_root, BankruptcyV2.file_search_autokey(isFCRA), outpl, intDID, intbdid, 'AK', , newdids, newbdids, olddids, oldbdids, tmsid, zero)
      by_auto := PROJECT(outpl, TRANSFORM(outrec,SELF.isdeepdive := FALSE,SELF := LEFT));

      // NEW vs OLD: probably old is not required anymore, which would make the code much easier to read,
      // for now I keep this portion untouched.

      adids := IF(NOT nodeepdive,
        PROJECT(olddids,TRANSFORM(bankruptcyv3_services.layouts.layout_did_ext,SELF.isdeepdive := FALSE,SELF := LEFT))
        + PROJECT(newdids,TRANSFORM(bankruptcyv3_services.layouts.layout_did_ext,SELF.isdeepdive := TRUE,SELF := LEFT)));
      abdids := IF(NOT nodeepdive,
        PROJECT(oldbdids,TRANSFORM(bankruptcyv3_services.layouts.layout_bdid_ext,SELF.isdeepdive := FALSE,SELF := LEFT))
        + PROJECT(newbdids,TRANSFORM(bankruptcyv3_services.layouts.layout_bdid_ext,SELF.isdeepdive := TRUE,SELF := LEFT)));

      tempbhmod := MODULE(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,OPT))
        EXPORT BOOLEAN noFail := TRUE;
        EXPORT BOOLEAN use_exec_search := FALSE;
      END;

      bdids := AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempbhmod);

      by_bdid := IF(NOT nodeepdive,
                    get_tmsids_from_bdids(PROJECT(bdids,
                                                  TRANSFORM(bankruptcyv3_services.layouts.layout_bdid_ext,
                                                            SELF.isdeepdive := TRUE,
                                                            SELF := LEFT))));
      noFail := TRUE;
      forceLocal := TRUE;
      tempmod2 := MODULE(PROJECT(AutoStandardI.GlobalModule(isFCRA),AutoheaderI.LIBIN.FetchI_Hdr_Indv.full,OPT))
        EXPORT forceLocal := ^.forceLocal;
        EXPORT noFail := ^.noFail;
      END;
      dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(tempmod2);

      by_did := IF(NOT nodeepdive,
                    get_tmsids_from_dids(PROJECT(dids,
                                                 TRANSFORM(bankruptcyv3_services.layouts.layout_did_ext,
                                                 SELF.isdeepdive := TRUE,
                                                 SELF := LEFT))));

      // case number
      ds_cnum := DATASET([{CaseNumber_value,State_value,FALSE}], bankruptcyv3_services.layouts.layout_casenumber_ext);
      by_cnum := get_tmsids_from_casenumbers(ds_cnum);

      //***** ADD THE FLAG SO WE CAN SHOW IT ON SEARCH RESULTS
      isLRS := FALSE : STORED('isLocationReportService');//hacky workaround for bug 25247
      msids :=
        MAP(
          EXISTS(in_bdids(bdid != 0)) OR EXISTS(in_dids(did != 0)) =>
            get_tmsids_from_bdids(PROJECT(in_bdids,TRANSFORM(bankruptcyv3_services.layouts.layout_bdid_ext,SELF.isdeepdive:=FALSE,SELF:=LEFT)),in_limit) +
            get_tmsids_from_dids(PROJECT(in_dids,TRANSFORM(bankruptcyv3_services.layouts.layout_did_ext,SELF.isdeepdive:=FALSE,SELF:=LEFT)),in_limit),
          EXISTS(in_tmsids(tmsid != '')) =>
            in_tmsids,
          bdid_value != 0 =>
            get_tmsids_from_bdids(DATASET([{bdid_value,FALSE}],bankruptcyv3_services.layouts.layout_bdid_ext)),
          (UNSIGNED)did_value != 0 =>
            get_tmsids_from_dids(DATASET([{(UNSIGNED)did_value,FALSE}],bankruptcyv3_services.layouts.layout_did_ext)),
          tmsid_value != '' =>
            DATASET([{tmsid_value,FALSE}],bankruptcyv3_services.layouts.layout_tmsid_ext),
          isCRS OR isLRS => DATASET([],bankruptcyv3_services.layouts.layout_tmsid_ext),
         isFCRA AND isCaseNumberSearch AND isAttorneySearch => by_cnum,
        PROJECT(by_auto,bankruptcyv3_services.layouts.layout_tmsid_ext)
          +
          get_tmsids_from_bdids(PROJECT(abdids,bankruptcyv3_services.layouts.layout_bdid_ext)) +
          by_bdid +
          get_tmsids_from_dids(PROJECT(adids,bankruptcyv3_services.layouts.layout_did_ext)) +
          by_did +
          by_cnum
        );

      tmsids_raw := DEDUP(SORT(msids,tmsid,IF(isDeepDive,1,0)),tmsid);

      RETURN tmsids_raw;

    END;
