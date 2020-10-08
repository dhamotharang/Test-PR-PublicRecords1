EXPORT mac_get_payload_ids
(ids,t,datasetPL,outPL,didL ='append_did',bdidL ='append_bdid',typeStr='BC',FakeIDField = 'UNSIGNED6 FakeID',
 outNewDIDs, outNewBDIDs,
 outOldDIDs, outOldBDIDs) :=
MACRO

IMPORT AutokeyB2, doxie_cbrs;

#uniquename(a)
%a% := 0;

//****** GRAB THE PAYLOAD KEY A
AutokeyB2.mac_get_payload(ids,t,datasetPL,outPLfat,didL,bdidL, typestr,FakeIDField)
outPL := PROJECT(outPLfat, {outPLfat.id, outPLfat.didL, outPLfat.bdidL,
  outPLfat.vehicle_key, outPLfat.iteration_key, outPLfat.sequence_key});

//****** IN THE NEW STYLE AUTOKEYS, ALL IDS ARE RECORD IDS, SO ILL GET THE DID AND BDID OFF OF PAYLOAD RECORDS THAT HAVE THEM
hasdid := outpl(didL > 0 AND ~AutokeyB2.ISFakeID(didL, typestr));
hasBdid := outpl(bdidL > 0 AND ~AutokeyB2.ISFakeID(bdidL, typestr));

//****** ENSURE THAT YOUR NEWDIDS ACTUALLY CAME FROM A PERSON SEARCH (AND BDIDS FROM COMPANY SEARCH)
outNewDIDs := JOIN(hasdid, ids(isdid),
  LEFT.id = RIGHT.id,
  TRANSFORM(doxie.Layout_references, SELF.did := LEFT.didL));

outNewBDIDs := JOIN(hasBdid, ids(isbdid),
  LEFT.id = RIGHT.id,
  TRANSFORM(doxie_cbrs.layout_references, SELF.bdid := LEFT.bdidL));

ENDMACRO;
