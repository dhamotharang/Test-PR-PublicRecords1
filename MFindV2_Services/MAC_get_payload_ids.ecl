export mac_get_payload_ids
(ids,t,datasetPL,outPL,didL ='did',typeStr='BC',FakeIDField = 'unsigned6 FakeID',
 outNewDIDs) := 
macro

#uniquename(a)
%a% := 0;

//****** GRAB THE PAYLOAD KEY
AutokeyB2.mac_get_payload(ids,t,datasetPL,outPLfat,didL,0, typestr)
outPL := project(outPLfat, {outPLfat.didL, outPLfat.trim_Vid});

//****** IN THE NEW STYLE AUTOKEYS, ALL IDS ARE RECORD IDS, SO ILL GET THE DID AND BDID OFF OF PAYLOAD RECORDS THAT HAVE THEM
outNewDIDs  := project(outpl(didL > 0 and ~AutokeyB2.ISFakeID(didL, typestr)),
							transform(doxie.layout_references,self.did := left.didL));




endmacro;