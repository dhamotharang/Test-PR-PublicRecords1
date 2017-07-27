EXPORT Mac_get_payload_ids
  (ids, t, datasetPL, outPL, didL ='did', typeStr, FakeIDField = 'unsigned6 fakeid', outNewDIDs) := 
MACRO

import doxie, ut;

// (note: this one uses hardcoded FakeID field; if named otherwise, use 3 lines below
  AutokeyB2.mac_get_payload (ids, t, datasetPL, outPLfat, didL, 0, typeStr, FakeIDField);

    // fids := ids (AutokeyB2.isFakeID(id,typeStr));
    // AutokeyB2.MAC_FID_Payload (datasetPL, '','','','','','','','','', didL, zero, t + 'Payload', plk, '', , FakeIDField)
    // outPLfat := join (fids , plk, (left.id = right.fakeid), limit(ut.limits.default, skip));

  outPL := project (outPLfat, {outPLfat.id, outPLfat.didL, outPLfat.vtid});

  //****** IN THE NEW STYLE AUTOKEYS, ALL IDS ARE RECORD IDS, SO ILL GET THE DID AND BDID OFF OF PAYLOAD RECORDS THAT HAVE THEM
  hasdid  := outpl(didL > 0 and ~AutokeyB2.ISFakeID (didL, typestr));

  //****** ENSURE THAT YOUR NEWDIDS ACTUALLY CAME FROM A PERSON SEARCH (AND BDIDS FROM COMPANY SEARCH)
  outNewDIDs := JOIN (hasdid, ids(isdid),
				left.id = right.id,
				transform(doxie.Layout_references, self.did := left.didL));

ENDMACRO;