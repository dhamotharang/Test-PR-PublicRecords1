export mac_get_payload_ids
(ids,t,datasetPL,outPL,didL ='did',bdidL ='bdid',typeStr='\'AK\'',FakeIDField = 'unsigned6 FakeID',
 outNewDIDs, outNewBDIDs) := 
macro
import doxie_cbrs,doxie;
#uniquename(a)
%a% := 0;

//****** GRAB THE PAYLOAD KEY A
AutokeyB2.mac_get_payload(ids,t,datasetPL,outPLfat,didL,bdidL, typestr)
// outPL := dataset([],{outPLfat.id, outPLfat.didL, outPLfat.bdidL, outPLfat.tmsid, outPLfat.rmsid});
outPL := project(outPLfat, {outPLfat.id, outPLfat.didL, outPLfat.bdidL, outPLfat.TaxPayer_Number});

//****** IN THE NEW STYLE AUTOKEYS, ALL IDS ARE RECORD IDS, SO ILL GET THE DID AND BDID OFF OF PAYLOAD RECORDS THAT HAVE THEM
hasdid  := outpl(didL > 0 and ~AutokeyB2.ISFakeID(didL, typestr));
hasBdid := outpl(bdidL > 0 and ~AutokeyB2.ISFakeID(bdidL, typestr));

//****** ENSURE THAT YOUR NEWDIDS ACTUALLY CAME FROM A PERSON SEARCH (AND BDIDS FROM COMPANY SEARCH)
outNewDIDs := join(hasdid, ids(isdid),
				left.id = right.id,
				transform(doxie.Layout_references, self.did := left.didL));
outNewBDIDs := join(hasBdid, ids(isbdid),
				 left.id = right.id,
				 transform(doxie_cbrs.layout_references, self.bdid := left.bdidL));


endmacro;