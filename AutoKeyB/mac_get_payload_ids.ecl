export mac_get_payload_ids
(ids,t,datasetPL,outPL,didL ='did',bdidL ='bdid',typeStr='BC',FakeIDField = 'unsigned6 FakeID',
 outNewDIDs, outNewBDIDs,
 outOldDIDs, outOldBDIDs) := 
macro

#uniquename(a)
%a% := 0;

//****** GRAB THE PAYLOAD KEY A
autokeyb.mac_get_payload(ids,t,datasetPL,outPL,didL,bdidL, typestr)

//****** IN THE NEW STYLE AUTOKEYS, ALL IDS ARE RECORD IDS, SO ILL GET THE DID AND BDID OFF OF PAYLOAD RECORDS THAT HAVE THEM
hasdid  := outpl(didL > 0 and ~autokeyB.ISFakeID(didL, typestr));
hasBdid := outpl(bdidL > 0 and ~autokeyB.ISFakeID(bdidL, typestr));

//****** ENSURE THAT YOUR NEWDIDS ACTUALLY CAME FROM A PERSON SEARCH (AND BDIDS FROM COMPANY SEARCH)
outNewDIDs := join(hasdid, ids(isdid),
				left.id = right.id,
				transform(doxie.Layout_references, self.did := left.didL));
outNewBDIDs := join(hasBdid, ids(isbdid),
				 left.id = right.id,
				 transform(doxie_cbrs.layout_references, self.bdid := left.bdidL));


//****** PULL THE DIDS AND BDIDS DIRECTLY FROM THE OLD STYLE AUTOKEYS (THESE DATASETS EMPTY AFTER REBUILD)
outOldDIDs  := project(ids(isdid and not isfake), transform(doxie.Layout_references, self.did := left.id));
outOldBDIDs := project(ids(isbdid and not isfake), transform(doxie_cbrs.layout_references, self.bdid := left.id));


endmacro;