EXPORT Mac_get_payload_ids
  (ids, t, datasetPL, outPL, didL ='did', typeStr, FakeIDField = 'UNSIGNED6 fakeid', outNewDIDs) :=
MACRO

IMPORT doxie, ut;

  // note: this one uses hardcoded FakeID field; if named otherwise, use 3 lines below
  AutokeyB2.mac_get_payload (ids, t, datasetPL, outPLfat, didL, 0, typeStr, FakeIDField);

  // fids := ids (AutokeyB2.isFakeID(id,typeStr));
  // AutokeyB2.MAC_FID_Payload (datasetPL, '','','','','','','','','', didL, zero, t + 'Payload', plk, '', , FakeIDField)
  // outPLfat := join (fids , plk, (left.id = right.fakeid), limit(ut.limits.default, skip));

  outPL := PROJECT (outPLfat, {outPLfat.id, outPLfat.didL, outPLfat.vtid});

  //****** IN THE NEW STYLE AUTOKEYS, ALL IDS ARE RECORD IDS, SO ILL GET THE DID AND BDID OFF OF PAYLOAD RECORDS THAT HAVE THEM
  hasdid := outpl(didL > 0 AND ~AutokeyB2.ISFakeID (didL, typestr));

  //****** ENSURE THAT YOUR NEWDIDS ACTUALLY CAME FROM A PERSON SEARCH (AND BDIDS FROM COMPANY SEARCH)
  outNewDIDs := JOIN (hasdid, ids(isdid),
    LEFT.id = RIGHT.id,
    TRANSFORM(doxie.Layout_references, SELF.did := LEFT.didL));

ENDMACRO;
