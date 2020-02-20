IMPORT DeathV2_Services,Didville,Doxie,Doxie_Raw,dx_death_master,Gateway,Suppress;

lBatchIn       := PhoneFinder_Services.Layouts.BatchInAppendDID;
lCommon        := PhoneFinder_Services.Layouts.PhoneFinder.Common;
lFinal         := PhoneFinder_Services.Layouts.PhoneFinder.Final;
lExcludePhones := PhoneFinder_Services.Layouts.PhoneFinder.ExcludePhones;
lPPResponse    := Doxie_Raw.PhonesPlus_Layouts.PhoneplusSearchResponse_Ext;

EXPORT PhoneSearch( DATASET(lBatchIn)                        dIn,
                    PhoneFinder_Services.iParam.SearchParams inMod,
                    DATASET(Gateway.Layouts.Config)          dGateways) :=
FUNCTION
  mod_access := PROJECT (inMod, doxie.IDataAccess);

  dResultsByPhone := PhoneFinder_Services.GetPhones(dIn,inMod,dGateways);

  // Search by PII - Don't use royalty based sources when searching on PII when phone is also sent in
  // Experian File One and Waterfall process
  wfMod := MODULE(PROJECT(inMod,PhoneFinder_Services.iParam.SearchParams))
    EXPORT BOOLEAN UseTransUnionIQ411      := FALSE;
    EXPORT BOOLEAN UseTransUnionPVS        := FALSE;
    EXPORT BOOLEAN UseLastResort := FALSE;
    EXPORT BOOLEAN UseInHousePhoneMetadataOnly := FALSE;
  END;

  dInDIDPopulated       := dIn(orig_did != 0 or did != 0);
  dWaterfallPhonesByDID := IF(EXISTS(dInDIDPopulated),
                              PhoneFinder_Services.GetWaterfallPhones(dInDIDPopulated,wfMod,,TRUE));

  // Check to see if the best waterfall phones contains the input phone number
  lFinal tWFIdentity(lFinal le, lBatchIn ri) :=
  TRANSFORM
    SELF.acctno        := le.acctno;
    SELF.did           := ri.did;
    SELF.phone         := le.phone; // populating phone and dates
    SELF.dt_first_seen := le.dt_first_seen;
    SELF.dt_last_seen  := le.dt_last_seen;
    SELF.penalt        := 0;
    SELF.src           := le.src;
    SELF.vendor_id     := le.vendor_id;
    SELF.phone_source  := le.phone_source;
    SELF               := [];
  END;

  dWFPhonesFilter := JOIN(dWaterfallPhonesByDID,
                          dIn,
                          LEFT.acctno = RIGHT.acctno AND
                          LEFT.phone  = RIGHT.homephone,
                          LIMIT(0), KEEP(1));

  dWFDedup := DEDUP(SORT(dWFPhonesFilter,acctno,did),acctno,did);

  dWFDIDs := DEDUP(SORT(PROJECT(dWFDedup,doxie.layout_references),did),did);

  // Best information
  dWFBestInfo := Doxie.best_records(dWFDIDs, includeDOD:=TRUE, modAccess := mod_access);

  lFinal tAppendBestInfo(dWFDedup le,dWFBestInfo ri) :=
  TRANSFORM
    SELF.acctno := le.acctno;
    SELF.phone  := le.phone;
    SELF.dod    := (INTEGER)ri.dod;
    SELF        := ri;
    SELF        := le;
  END;

  dWFAppendBest := JOIN(dWFDedup,
                        dWFBestInfo,
                        LEFT.did = RIGHT.did,
                        tAppendBestInfo(LEFT,RIGHT),
                        LEFT OUTER,
                        LIMIT(1,SKIP));

  // Add WF/Experian records to records searched by phone only if there is a match on the phone number
  dWFOnly := JOIN(dResultsByPhone,
                  dWFAppendBest,
                  LEFT.acctno = RIGHT.acctno and
                  LEFT.did    = RIGHT.did,
                  TRANSFORM(RIGHT),
                  RIGHT ONLY);

  dAll := PROJECT(dResultsByPhone, TRANSFORM(lFinal, SELF.isPrimaryPhone := TRUE, SELF := LEFT)) + dWFOnly;

  // Append DIDs
  dAppendDIDs := PhoneFinder_Services.Functions.AppendDIDs(dAll, TRUE);

  Suppress.MAC_Suppress(dAppendDIDs,dSuppress,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did,'','',TRUE,'',TRUE);

  // Deceased flag
  death_params := DeathV2_Services.IParam.GetRestrictions(mod_access);

  dDeceasedAppend := dx_death_master.Append.ByDid(dSuppress,did,death_params);
  dDeceased :=
    PROJECT(dDeceasedAppend,
      TRANSFORM(lfinal,
        SELF.deceased := IF(LEFT.death.is_deceased, 'Y', 'N');
        SELF.dod      := IF(LEFT.death.is_deceased, (UNSIGNED4)LEFT.death.dod8, 0);
        SELF          := LEFT;
        ));

  // Debug
  #IF(PhoneFinder_Services.Constants.Debug.PhoneNoSearch)
    OUTPUT(dIn,NAMED('dPhoneSearchIn'));
    OUTPUT(dResultsByPhone,NAMED('dResultsByPhone'));
    OUTPUT(dWaterfallPhonesByDID,NAMED('dWaterfallPhonesByDID'));
    OUTPUT(dWFPhonesFilter,NAMED('dWFPhonesFilter'));
    OUTPUT(dAll,NAMED('dAll'));
    OUTPUT(dAppendDIDs,NAMED('dAppendDIDs'));
    OUTPUT(dSuppress,NAMED('dPhoneSearchSuppress'));
    OUTPUT(dDeceased,NAMED('dDeceased'));
  #END

  RETURN dDeceased;
END;
