export mac_get_payload_ids_ingenix
(ids,t,datasetPL,outPL,didL ='did',uniqueid='Sanc_Id', typeStr='\'AK\'',FakeIDField = 'unsigned6 FakeID',
 outNewDIDs) := 
macro
import doxie_cbrs,doxie;
#uniquename(a)
%a% := 0;

//****** GRAB THE PAYLOAD KEY A
AutokeyB2.mac_get_payload(ids,t,datasetPL,outPLfat,didL,bdidL, typestr)
// outPL := dataset([],{outPLfat.id, outPLfat.didL, outPLfat.bdidL, outPLfat.tmsid, outPLfat.rmsid});
shared outPL := project(outPLfat, {outPLfat.id, outPLfat.didL,outPLfat.uniqueid});

//****** IN THE NEW STYLE AUTOKEYS, ALL IDS ARE RECORD IDS, SO ILL GET THE DID AND BDID OFF OF PAYLOAD RECORDS THAT HAVE THEM
shared hasdid  := outpl(didL > 0 and ~AutokeyB2.ISFakeID(didL, typestr));


//****** ENSURE THAT YOUR NEWDIDS ACTUALLY CAME FROM A PERSON SEARCH (AND BDIDS FROM COMPANY SEARCH)
shared outNewDIDs := join(hasdid, ids(isdid),
				left.id = right.id,
				transform(doxie.Layout_references, self.did := left.didL));


endmacro;