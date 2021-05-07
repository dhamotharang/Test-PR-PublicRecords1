IMPORT AutoKeyB2,AutoKeyI,doxie,doxie_cbrs,PAW;

EXPORT AutoKey_IDs := MODULE
  EXPORT params := INTERFACE(AutoKeyI.AutoKeyStandardFetchBaseInterface)
    EXPORT BOOLEAN workHard := TRUE;
    EXPORT BOOLEAN noFail := FALSE;
    EXPORT nodeepdive := FALSE;
  END;
  EXPORT val(params in_mod) := FUNCTION
    ak_keyname := PAW.Constant('').ak_QAname;
    ak_typestr := PAW.Constant('').ak_typeStr;
    ak_dataset := PAW.file_SearchAutokey(PAW.File_Base);

    // custom autokey-search behavior: person-search just by address or by phone may bring a lot of matches,
    // we can prevent query from failure when there's enough company info in the input.
    BOOLEAN skip_person_search := (in_mod.companyname != '' OR in_mod.fein != '') AND
                                  (in_mod.lastname = '') AND (in_mod.firstname = '') AND (in_mod.ssn = '');
    
    tempmod := MODULE(PROJECT(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
      EXPORT STRING autokey_keyname_root := ak_keyname;
      EXPORT STRING typestr := ak_typeStr;
      EXPORT SET of STRING1 get_skip_set := IF (skip_person_search, ['C'], []);
      EXPORT BOOLEAN useAllLookups := TRUE;
    END;
    ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
    
    AutokeyB2.mac_get_payload(ids, ak_keyname, ak_dataset, outpl, did, bdid, ak_typeStr)
    by_auto := DEDUP(SORT(PROJECT(outpl,paw_services.Layouts.search),RECORD),RECORD);
    
    // Get DIDs from autokey results
    hasdid := outpl(did > 0 AND ~AutokeyB2.ISFakeID(did, ak_typeStr));
    newdids := JOIN(
      hasdid, ids(isdid),
      LEFT.id = RIGHT.id,
      TRANSFORM(doxie.layout_references, SELF.did := LEFT.did)
    );
    
    // Get BDIDs from autokey results
    hasbdid := outpl(bdid > 0 AND ~AutokeyB2.ISFakeID(bdid, ak_typeStr));
    newbdids := JOIN(
      hasbdid, ids(isbdid),
      LEFT.id = RIGHT.id,
      TRANSFORM(doxie_cbrs.layout_references, SELF.bdid := LEFT.bdid)
    );
    
    // NOTE: This would usually have been done in AutokeyB2.mac_get_payload_ids
    // but that approach requires the use of tmsids & rmsids
    
    // Deep dive those DIDs and BDIDs
    contact_ids := PAW_Raw.getContactIDs.byDIDs(newdids) +
      IF(~in_mod.noDeepDive,PROJECT(PAW_Raw.getContactIDs.byBDIDs(newbdids),
        TRANSFORM(paw_services.Layouts.search,SELF.isDeepDive:=TRUE,SELF:=LEFT))
      );
    
    // Assemble results
    dups := by_auto + contact_ids;
    results := DEDUP(SORT(dups, contact_id,IF(isDeepDive,1,0)), contact_id);

    RETURN results;
  END;
END;
