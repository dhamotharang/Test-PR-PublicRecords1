import autokeyb2, ut, zz_cemtemp, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild;

export Proc_BuildKeys(string filedate) := function

ds_forLayoutMaster_AKB := accurint_acclogs.file_SearchAutokey;

// SET_DL := ['ACCIDENTSEARCH','DLREPORT2','DLSEARCH2','MVSEARCH','MVSEARCH2'];
// SET_CHART := ['CORPREPORTV2'];
// SET_FEIN := ['CORPSEARCHV2','ENHANCEDBUSSRCH','FEINSEARCH','LIENSEARCH','ROLLBUSSEARCH','UCCSEARCHV2'];
// SET_LINKID := ['ADDRHISTREPORT','BANKRUPTREPORT2','BANKRUPTREPORT3','BANKRUPTSEARCH','BANKRUPTSEARCH2','COURTSEARCH','CRIMREPORT','DEA_REGISTRATION','DEATHREPORT','FICTITIOUSBIZSRH','FORECLOSEREPORT','STATEWIDEDOCCNTS','PROVIDERREPORT','PROVIDERSEARCH','SANCTIONSEARCH','LIENREPORT','MDSEARCH2','MVREPORT','MVREPORT2','PEOPLEATWORKV2','PROFLICSEARCH2','PROPERTYREPORT2','PROPERTYSEARCH2','SEXOFFREPORT','UCCREPORTV2','WATERCRAFTRPT2','WATERCRAFTSRH2'];

// ds_forLayoutMaster_AKB := project(accurint_acclogs.file_SearchAutokey,
										// TRANSFORM({recordof(accurint_acclogs.file_SearchAutokey),
														// string cat_fein,
														// string cat_chart,
														// string cat_dl,
														// string cat_linkid},	
										// self.cat_dl 	:= map(stringlib.stringtouppercase(left.orig_function_name) in set_dl => left.orig_unique_id,
														   // stringlib.stringtouppercase(left.orig_searchdescription) in set_dl => left.orig_unique_id, '');
										// self.cat_chart 	:= map(stringlib.stringtouppercase(left.orig_function_name) in set_chart => left.orig_unique_id,
														   // stringlib.stringtouppercase(left.orig_searchdescription) in set_chart => left.orig_unique_id, '');
										// self.cat_fein 	:= map(stringlib.stringtouppercase(left.orig_function_name) in set_fein => left.orig_unique_id,
														   // stringlib.stringtouppercase(left.orig_searchdescription) in set_fein => left.orig_unique_id, '');
										// self.cat_linkid := map(stringlib.stringtouppercase(left.orig_function_name) in set_linkid => left.orig_unique_id,
														   // stringlib.stringtouppercase(left.orig_searchdescription) in set_linkid => left.orig_unique_id, '');
										// self := left));
										
mBuildkeys(ds, suffix, buildkey, filedate) := macro
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(ds,
												Accurint_AccLogs.str_keylogicalname + '::@version@::' + suffix,
												Accurint_AccLogs.str_keylogicalname + '::' + filedate +'::'+ suffix,
												buildkey);

endmacro;

mMovekeys(ds, suffix, movekey, filedate) := macro
	Roxiekeybuild.Mac_SK_Move_to_Built_v2(Accurint_AccLogs.str_keylogicalname + '::@version@::' + suffix, 
										  Accurint_AccLogs.str_keylogicalname + '::' + filedate +'::'+ suffix, 
										  movekey);
endmacro;

mOutkeys(ds, suffix, outkey, filedate) := macro
	RoxieKeyBuild.Mac_SK_Move_V3(Accurint_AccLogs.str_keylogicalname + '::@version@::' + suffix,
								 'Q',
								 OutKey,
								 filedate);
endmacro;


/////// PAYLOAD KEY

RecordIDKey := index(accurint_acclogs.file_SearchAutokey, {record_id}, {accurint_acclogs.file_SearchAutokey}, Accurint_AccLogs.str_keylogicalname + '::' + doxie.Version_SuperKey + '::recordid');

/////// USER ID

tbrecord_idUserID := table(ds_forLayoutMaster_AKB, {string20 user_ID := user_id, integer4 date_added := (integer4) orig_dateadded, record_id});

UserIDKey := index(tbrecord_idUserID, {user_ID, date_added}, {record_id}, Accurint_AccLogs.str_keylogicalname + '::' + doxie.Version_SuperKey + '::userid');


/////// DOB

DOBNameSlim := table(ds_forLayoutMaster_AKB(dob not in ['','00000000'] and lname <> '') ,
						   {integer4 dob := (integer4)dob, lname, fname, record_id});

DOBKey := index(DOBNameSlim,{dob} , {lname, fname, record_id}, Accurint_AccLogs.str_keylogicalname + '::' + doxie.Version_SuperKey + '::dob');


/////// DRIVERS LICENSE

DLKeySlim1 := table(ds_forLayoutMaster_AKB(orig_dl <> ''), {string24 dl := orig_dl, record_id});
// DLKeySlim2 := table(ds_forLayoutMaster_AKB(cat_dl <> ''), {string24 dl := cat_dl, record_id});

DLKey := index(DLKeySlim1, {dl, record_id}, Accurint_AccLogs.str_keylogicalname + '::' + doxie.Version_SuperKey + '::dl');


/////// LINK ID from RAW

LinkIDKeySlim1 := table(ds_forLayoutMaster_AKB((unsigned)orig_did > 0 and ~regexfind('[^0-9]', trim(orig_did, all))), {unsigned6 link_id := (unsigned6)orig_did, record_id});
// LinkIDKeySlim2 := table(ds_forLayoutMaster_AKB((unsigned)cat_linkid > 0 and ~regexfind('[a-zA-Z]', cat_linkid)), {unsigned6 link_id := (unsigned6)cat_linkid, record_id});

LinkIDKey := index(LinkIDKeySlim1(link_id > 0), {link_id, record_id}, Accurint_AccLogs.str_keylogicalname + '::' + doxie.Version_SuperKey + '::linkid');


/////// CHARTER NUMBER

ChartKeySlim1 := table(ds_forLayoutMaster_AKB(orig_charter_nbr <> ''), {string17 charter_number := orig_charter_nbr, record_id});
// ChartKeySlim2 := table(ds_forLayoutMaster_AKB(cat_chart <> ''), {string17 charter_number := cat_chart, record_id});

CharterKey := index(ChartKeySlim1, {charter_number, record_id}, Accurint_AccLogs.str_keylogicalname + '::' + doxie.Version_SuperKey + '::Charter');


/////// UCC NUMBER

UCCKey := index(ds_forLayoutMaster_AKB(orig_ucc_nbr <> ''), {string17 ucc_number := orig_ucc_nbr, record_id}, Accurint_AccLogs.str_keylogicalname + '::' + doxie.Version_SuperKey + '::UCC');


/////// DOMAIN

DomainKey := index(ds_forLayoutMaster_AKB(orig_domain <> ''), {string50 Domain := orig_domain, record_id}, Accurint_AccLogs.str_keylogicalname + '::' + doxie.Version_SuperKey + '::domain');


/////// DATE TIME USING DATEADDED

DateTimeTB := table(ds_forLayoutMaster_AKB,{string8 Date := orig_dateadded[1..8], string16 Time := trim(orig_dateadded[9..], left, right), record_id});

DateTimeKey := index(DateTimeTB(Date <> ''), {date, time, record_id}, Accurint_AccLogs.str_keylogicalname + '::' + doxie.Version_SuperKey + '::DateTime');


/////// FEIN NUMBER

FEINKey := index(ds_forLayoutMaster_AKB((unsigned6)orig_ein > 0 and ~regexfind('[a-zA-Z]', trim(orig_ein, all))), {unsigned6 fein := (unsigned6)regexreplace('[^0-9]', orig_ein, '') , record_id}, Accurint_AccLogs.str_keylogicalname + '::' + doxie.Version_SuperKey + '::fein');

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

mBuildkeys(RecordIDKey, 'recordid', buildRecID, filedate);
mMovekeys(RecordIDKey, 'recordid', moveRecID, filedate);
mOutkeys(RecordIDKey, 'recordid', outRecID, filedate);

mBuildkeys(UserIDKey, 'userid', buildUserID, filedate);
mMovekeys(UserIDKey, 'userid', moveUserID, filedate);
mOutkeys(UserIDKey, 'userid', outUserID, filedate);

mBuildkeys(DOBKey, 'dob', buildDOB, filedate);
mMovekeys(DOBKey, 'dob', moveDOB, filedate);
mOutkeys(DOBKey, 'dob', outDOB, filedate);

mBuildkeys(DLKey, 'dl', buildDl, filedate);
mMovekeys(DLKey, 'dl', moveDl, filedate);
mOutkeys(DLKey, 'dl', outDl, filedate);

mBuildkeys(LinkIDKey, 'LinkID', buildLinkID, filedate);
mMovekeys(LinkIDKey, 'LinkID', moveLinkID, filedate);
mOutkeys(LinkIDKey, 'LinkID', outLinkID, filedate);

mBuildkeys(CharterKey, 'Charter', buildCharter, filedate);
mMovekeys(CharterKey, 'Charter', moveCharter, filedate);
mOutkeys(CharterKey, 'Charter', outCharter, filedate);

mBuildkeys(UCCKey, 'UCC', buildUCC, filedate);
mMovekeys(UCCKey, 'UCC', moveUCC, filedate);
mOutkeys(UCCKey, 'UCC', outUCC, filedate);

mBuildkeys(DomainKey, 'Domain', buildDomain, filedate);
mMovekeys(DomainKey, 'Domain', moveDomain, filedate);
mOutkeys(DomainKey, 'Domain', outDomain, filedate);

mBuildkeys(DateTimeKey, 'DateTime', buildDateTime, filedate);
mMovekeys(DateTimeKey, 'DateTime', moveDateTime, filedate);
mOutkeys(DateTimeKey, 'DateTime', outDateTime, filedate);


mBuildkeys(FEINKey, 'FEIN', buildFEIN, filedate);
mMovekeys(FEINKey, 'FEIN', moveFEIN, filedate);
mOutkeys(FEINKey, 'FEIN', outFEIN, filedate);

// mBuildkeys(FilingNbrKey, 'Filing', buildFiling, filedate);
// mMovekeys(FilingNbrKey, 'Filing', moveFiling, filedate);
// mOutkeys(FilingNbrKey, 'Filing', outFiling, filedate);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
return sequential(
parallel(
				buildCharter,
				buildDateTime,
				buildDl,
				buildDOB,
				buildDomain,
				buildLinkID,
				buildRecID,
				buildUCC,
				buildUserID,
				buildFEIN),
parallel(
				moveCharter,
				moveDateTime,
				moveDl,
				moveDOB,
				moveDomain,
				moveLinkID,
				moveRecID,
				moveUCC,
				moveUserID,
				moveFEIN),
parallel(
				outCharter,
				outDateTime,
				outDl,
				outDOB,
				outDomain,
				outLinkID,
				outRecID,
				outUCC,
				outUserID,
				outFEIN));
				
end;