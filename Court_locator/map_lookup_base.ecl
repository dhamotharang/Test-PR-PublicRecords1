import AID;

export map_lookup_base(string filedate) := function

////////////////////////////////////////////////////////////////////////////////////////
// Pass to Address ID Prep Macro
////////////////////////////////////////////////////////////////////////////////////////
Court_locator.aid_mAppdFields(Court_locator.file_lookup,MailAddress1,MailAddress2,MailCity,MailState,MailZip,dPreClean);

////////////////////////////////////////////////////////////////////////////////////////
// Pass to Address ID Macro
////////////////////////////////////////////////////////////////////////////////////////
unsigned4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(dPreClean,
Append_Prep_Address1, Append_Prep_AddressLast, rawaid,
dClean,
lAIDAppendFlags
);
////////////////////////////////////////////////////////////////////////////////////////
// Pass to Parse Address Macro
////////////////////////////////////////////////////////////////////////////////////////
Court_locator.aid_ParseCleanAddress(dClean,Court_locator.layout_lookup_base,filedate,outf);

///////////////////////////////////////////////////////////////////////////////////////
// Output Files
////////////////////////////////////////////////////////////////////////////////////////
sfShuffle := sequential(
	fileservices.addsuperfile('~thor_data400::base::CourtLocatorLookup_delete','~thor_data400::base::CourtLocatorLookup_grandfather',0,true),
	fileservices.deletesuperfile('~thor_data400::base::CourtLocatorLookup_delete',true),
	fileservices.startsuperfiletransaction(),
	fileservices.createsuperfile('~thor_data400::base::CourtLocatorLookup_delete'),
	fileservices.clearsuperfile('~thor_data400::base::CourtLocatorLookup_grandfather'),
	fileservices.addsuperfile('~thor_data400::base::CourtLocatorLookup_grandfather','~thor_data400::base::CourtLocatorLookup_father',0,true),
	fileservices.clearsuperfile('~thor_data400::base::CourtLocatorLookup_father'),
	fileservices.addsuperfile('~thor_data400::base::CourtLocatorLookup_father','~thor_data400::base::ntlcrash_inquiry',0,true),
	fileservices.clearsuperfile('~thor_data400::base::CourtLocatorLookup'),
	fileservices.addsuperfile('~thor_data400::base::CourtLocatorLookup','~thor_data400::base::'+filedate+'::CourtLocatorLookup'),
	fileservices.finishsuperfiletransaction()
	);

return
sequential(
output(dedup(outf,record,all),,'~thor_data400::base::'+filedate+'::CourtLocatorLookup',overwrite,__compressed__)
,sfShuffle);
end;
