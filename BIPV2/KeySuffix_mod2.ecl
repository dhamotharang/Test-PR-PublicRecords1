/*2016-06-22T18:47:08Z (Harrison Sun_prod)
Temp check in
*/
export KeySuffix_mod2 :=
MODULE
shared rec := record
	unsigned4 buildNumber;
	string1 	buildLetter := '';
	string10 versionDate;
	string10 ingestVersionDate; //if any
	string10 DateReleasedThor := '';
	string10 DateReleasedCertRoxie := '';
	string10 DateReleasedProdRoxie := '';
	string500 notes := '';
end;
//****
//****  this it the part that needs manual updating.
//****
/*
1) add a row for each sprint/build
2) update constant_ThisBuild_versionDate
*/
// Error C4029: Roxie requires constant filenames - expression alias cannot be computed at deployment
// ** so, when you update this, you need a corresponding row below, even though you wont know all the field values yet
// export constant_ThisBuild_versionDate := '20141113'; // S23
// export constant_ThisBuild_versionDate := '20141211'; // S24
// export constant_ThisBuild_versionDate := '20150115'; // S25
// export constant_ThisBuild_versionDate := '20150206'; // S26
// export constant_ThisBuild_versionDate := '20150312'; // S27
// export constant_ThisBuild_versionDate := '20150312a'; // S27
// export constant_ThisBuild_versionDate := '20150420'; // S27a
//export constant_ThisBuild_versionDate := '20150512'; // S28
// export constant_ThisBuild_versionDate := '20150618'; // S29
//export constant_ThisBuild_versionDate := '20150618a'; // S29
//export constant_ThisBuild_versionDate := '20150804'; // S30
//export constant_ThisBuild_versionDate := '20150828'; // S31
//export constant_ThisBuild_versionDate := '20151014'; // S32
//export constant_ThisBuild_versionDate := '20151201'; // S33
//export constant_ThisBuild_versionDate := '20151218'; // S34
//export constant_ThisBuild_versionDate := '20160112'; // S35
//export constant_ThisBuild_versionDate := '20160204'; // S36
//export constant_ThisBuild_versionDate := '20160304'; // S37
//export constant_ThisBuild_versionDate := '20160412'; // S38
//export constant_ThisBuild_versionDate := '20160509'; // S39
//export constant_ThisBuild_versionDate := '20160617'; // S40
//export constant_ThisBuild_versionDate := '20160722'; // S41
//export constant_ThisBuild_versionDate := '20160830'; // S42  
// export constant_ThisBuild_versionDate := '20161111'; // S43
//export constant_ThisBuild_versionDate := '20161216'; // S44
//export constant_ThisBuild_versionDate := '20170125'; // S45
//export constant_ThisBuild_versionDate := '20170315'; // S46
//export constant_ThisBuild_versionDate := '20170526'; // S47
// export constant_ThisBuild_versionDate := '20170622'; // S48
// export constant_ThisBuild_versionDate := '20170801'; // S49
// export constant_ThisBuild_versionDate := '20170901'; // S50
// export constant_ThisBuild_versionDate := '20170901a'; // S50a
// export constant_ThisBuild_versionDate := '20171002'; // S51
// export constant_ThisBuild_versionDate := '20171101'; // S52
// export constant_ThisBuild_versionDate := '20171129'; // S53
// export constant_ThisBuild_versionDate := '20180103'; // S54
//export constant_ThisBuild_versionDate := '20180201'; // S55
//export constant_ThisBuild_versionDate := '20180302'; // S56
//export constant_ThisBuild_versionDate := '20180402'; // S57
// export constant_ThisBuild_versionDate := '20180501'; // S58
// export constant_ThisBuild_versionDate := '20180601'; // S59
// export constant_ThisBuild_versionDate := '20180702'; // S60
// export constant_ThisBuild_versionDate := '20180801'; // S61
export constant_ThisBuild_versionDate := '20180901'; // S62



export ds :=
dataset([
//data for previous sprints is below.  and thor release date, if needed, can be mined from keysuffix check in history on prod
//						version,			ingest			ToThor			ToCertRox		ToProdRox		//these are not exact field names.  they just help w read and update.
 {	7,	'',		'20131025',		'',					'20131105',	'',					'',					'No Ingest, LiensV2 naturalized (promoted B to A)'}
,{	7,	'a',	'20131025a',	'',					'20131111',	'',					'',					'Sprint7 restart: Processing restarted at Hrchy with small code changes'}
,{	8,	'',		'20131112',		'20131031',	'20131202',	'',					'',					'Ingests 20131031 data, 27 sources (added Experian FEIN), DERIVED Vehicle source_record_id'}
//roxie release dates up to this point unknown
,{	9,	'',		'20131203',		'20131031',	'20131218',	'',					'',					'Re-Ingests 20131031 data, no hacks needed, no significant changes expected. not released to roxie because of holidays'}
,{	10,	'',		'20131220',		''        , '20140107',	'20140108',	'',					'No Ingest, build started at Prox'}
,{  11, '',   '20140115',   ''        , '20140128', '20140128', '',					'Attempted ingest of 20140113 data, abandoned due to bloat, build started at Prox'}
,{  12, '',   '20140129',   ''        , ''        , ''        , '',					'Attempted ingest of 20140121 data (28 sources w/ Experian_CRDB). Whole build abandoned due to cluster count increase.'}
,{  13, '',   '20140217',   '20140206', ''        , ''        , '',					'Not Released.  Ingest 20140206 data, 28 sources (w/ Experian_CRDB), S11 as base. DERIVED source_record_id, vl_id, and duns_number for DN. DERIVED vl_id for D. Problem with orgid/ultid'}
,{  13, 'a',  '20140217a',  '20140206', ''        , ''        , '',					'Not Released.  same as above, with patch for orgid issue.  Back up and start at empid down.'}
,{  13, 'b',  '20140217b',  '20140206', '20140310', '20140310', '',					'same as above, found problem with empid and powid.  removed pow up and empid entirely.  Restarting from pow down result file with Q3 fix at hacked sele to only do Q3 fix.'}
,{  14, '',   '20140314' ,  '20140206', '20140318', '20140318', '',					'Start at hierarchy, use proxid iter 75b.  don\'t do powid up or empid up.  Put in Q3 fix at hacked sele.'}
,{  15, '',   '20140402' ,  '20140307', '20140425', '20140425', '',					'Ingested into S14 base with new layout. HACKS for Experian_CRDB dates and DNB_FEIN source_record_id. Fixed id integrity.  WAS ROLLED BACK IMMEDIATELY BECAUSE OF ID INTEGRITY ISSUES.'}
,{  15, 'a',  '20140402a',  ''        , '20140428', '20140428', '20140506',	'Patched version of S15 to fix 800K seleids with multiple parents.  Also fixed separate cert roxie spinning issue.'}
,{  16, '',   '20140424' ,  '20140414', '20140516', '20140522', '20140603',	'Ingested into S15 base.  HACK to blank BusReg vl_id.  Fixed id integrity.'}
,{  17, '',   '20140529' ,  '20140526', '20140624', '20140624', '20140701', 'Ingested into Prox-104, which was 1 iter post-S16.  No hacks!  Fixed id integrity.'}
,{  18, '',   '20140626' ,  '20140624', '20140724', '20140804', '20140812',	'Ingested into S17 base.  No hacks besides id integrity fix in post-process.'}
,{  19, '',   '20140725' ,  '20140722', '20140821', '20140903', '20140909',	'Ingested into S18 base.  No hacks besides id integrity fix in post-process.'}
,{  20, '',   '20140821' ,  '20140820', '20140917', '20140930', '20141007',	'Ingested into S19 base.  No hacks besides id integrity fix in post-process.'}
,{  21, '',   '20140918' ,  '20140915', '20141014', '20141015', '20141021',	'Ingested into S20 base.  No hacks besides id integrity fix in post-process.'}
,{  22, '',   '20141015' ,  '20141013', '20141110', '20141110', '20141118', 'Ingested into S21 base.  No hacks.'}
,{  23, '',   '20141113' ,  '20141112', '20141202', '20141202', '20141212', 'Ingested into S22 base.  No hacks.'}
,{  24, '',   '20141211' ,  '20141210', '20150109', '20150109', '20150114', 'Ingested into S23 base.  No hacks.'}
,{  25, '',   '20150115' ,  '20150115', '20150205', '20150218', '20150224', 'Ingested into S24 base.  No hacks.'}
,{  26, '',   '20150206' ,  '20150206', '20150309', '20150316', '20150324', 'Ingested into S25 base.  No hacks.'}
,{  27, '',   '20150312' ,  '20150312', '20150413', '20150413', ''        , 'Ingested into S26 base.  BIPV2_LGID3._proc_lgid3 pulled in previous(S26) lgid3 file(bug).  So no new data this time.  Fixed in S28.  didn\'t go to prod because of experian crdb.'}
,{  27, '',   '20150312a',  '20150312', '20150424', '20150422', '20150422', 'Rebuilt directories linkids key and contact linkids key, using the last good experian crdb file, renamed the rest of the keys.'}
,{  27, 'a',  '20150420' ,  '20150420', '20150508', '20150508', '20150518', 'Ingested into S27 base.  No hacks.'}
,{  28, '',   '20150512' ,  '20150512', '20150612', '20150623', '20150714', 'Ingested into S27a base.  Removed Property from source ingest because of source record id problem.'}
,{  29, '',   '20150618' ,  '20150618', '20150718', '20150720', ''        , 'Ingested S28 base. Removed Property from source ingest because of source record id problem.  Failed build because bizlinkfull was using ds_prod instead of ds_clean.'}
,{  29, '',   '20150618a',  '20150618', '20150730', '20150803', '20150811', 'Rebuild of S29 bizlinkfull keys using ds_clean.  Also copied xlink keys, xlink sample, weekly keys.  Then renamed rest of keys to match "a" version.'}
,{  30, '',   '20150804' ,  '20150804', '20150821', '20150821', '20150831', 'Ingested S29 base. Add back Property from source ingest. Data release only.'}
,{  31, '',   '20150828' ,  '20150828', '20151008', '20151012', '20151020', 'Ingested S30 base. Add Cclue(B source) and SBFE(A source).  Make sure SBFE and Cclue records only make it into the xlink search keys, not the xlink payload, or the other key.'}
,{  32, '',   '20151014' ,  '20151014', '20151014', ''        , ''        , 'Ingested S31 base. BIPV2_LGID3 (give LGID3 access to more proxids), BIPV2_Proxid (account for F/D corp key data errors), BIPV2_Company_Names for PTA/PTO. BizLinkFull.'}
,{  33, '',   '20151201' ,  '20151201', '20151201', '20151216', ''        , 'Ingested S32 base. Data release only'}
,{  34, '',   '20151218' ,  '20151218', '20151218', '20160119', '20160126', 'Ingested S33 base. IPV2_LGID3(give LGID3 access to more proxids), Bug: 178357-Linking 2.2 EmpID-propagate DID across EmpID and measure impact, Bug 184232 - LINKING: EmpID/DID Issues '}
,{  35, '',   '20160112' ,  '20160112', '20160112', '20160203', '20160209', 'Ingested S34 base. Data release only'}
,{  36, '',   '20160204' ,  '20160204', '20160204', '', 				'', 				'Ingested S35 base. BIPV2_LGID3(186760 lower threshold to 40), bug 188309 LINKING: unlink Lawcopy, Bug 197272 - LINKING: powid up overlinking, Bug 137308: ProxID linking changes (new FEIN OR clause) '}
,{  37, '',   '20160304' ,  '20160304', '20160304', '20160411', '20160419', 'Ingested S36 base. Bug 178442 - Linking 2.2 : empid, seleid, orgid relationship,  Bug: 182544 - company name FIELDTYPEs in DOT ,  Bug: 197761 - LINKING: upgrade POWID up to 3.3'}
,{  38, '',   '20160412' ,  '20160412', '20160412', '', 				'', 				'Ingested S37 base. Bug: 200948 - Update company name cleaner to remove warnings,  Bug: 197270 - LINKING: proxid overlinking because of duns_number corrections, Hrchy performance enhancement'}
,{  39, '',   '20160509' ,  '20160509', '20160509', '', 				'', 			  'Ingested S38 base. Data release only'}
,{  40, '',   '20160617' ,  '20160617', '20160617', '', 				'', 			  'Ingested S39 base. BH-13 Tune Strata alerts more intelligently - phase 1 (ID integrity) '}
,{  41, '',   '20160722' ,  '20160722', '20160722', '', 				'', 			  'Ingested S40 base. BH-46 Service or defined process for how did this link? part one; BH-31 Fix Hierarchy ID Integrity Issues  '}
,{  42, '',   '20160830' ,  '20160830', '20160830', '', 				'', 			  'Ingested S41 base. BH-29 Linking ETS: Tune Strata alerts more intelligently - phase 2; BH-19 Service or defined process for "how did this link?" part two; BH-49 fix blank sele_seg, prox_seg records; BH-14 Hierarchy shouldnot always break lgid3 leaf node clusters'}
,{  43, '',   '20161111' ,  '20161111', '20161111', '', 				'', 			  'Ingested S42 base. BH-75,BH-64,BH-63,BH52,BH-55,BH-76,BH-91,BH-94,BH-18,BH-77,BH-80,BH-95,BH-96,BH-93'}
,{  44, '',   '20161216' ,  '20161216', '20161216', '', 				'', 			  'Ingested S43 base. RR-10850'}
,{  45, '',   '20170125' ,  '20170125', '', '', 				'', 			  'Ingested S44 base. RR-10877'}
,{  46, '',   '20170315' ,  '20170315', '', '', 				'', 			  'Ingested S45 base. RR-11034'}
,{  47, '',   '20170526' ,  '20170526', '', '', 				'', 			  'Ingested S46 base. RR-11124'}
,{  48, '',   '20170622' ,  '20170622', '', '', 				'', 			  'Ingested S47 base. RR-11251'}
,{  49, '',   '20170801' ,  '20170801', '', '', 				'', 			  'Ingested S48 base. BH-316 -- BIP Build 49 - August 2017'}
,{  50, '',   '20170901' ,  '20170901', '', '', 				'', 			  'Ingested S49 base. BH-328 -- BIP Build 50 - September 2017'}
,{  50, 'a',  '20170901a',  '20170901', '', '', 				'', 			  'RR for xlink 3.7 upgrade.  uses S50 file. RR-11735 -- BIPV2 Bizlinkfull keys upgrade to salt 3.7'}//never went, rolled back!!!!
,{  51, '',   '20171002' ,  '20171002', '', '', 				'', 			  'Ingested S50 base. BH-358 -- BIP Build 51 - October 2017'}
,{  52, '',   '20171101' ,  '20171101', '', '', 				'', 			  'Ingested S51 base. BH-362 -- BIP Build 52 - November 2017'}
,{  52, 'a',  '20171101a',  '20171101', '', '', 		    '', 			  'RR-11900 -- BIPV2 BizLinkFull keys upgrade to SALT 3.7'}
,{  53, '',   '20171129' ,  '20171129', '', '', 				'', 			  'Ingested S52 base. BH-385 -- BIP Build 53 - December 2017'}
,{  54, '',   '20180103' ,  '20180103', '', '', 				'', 			  'Ingested S53 base. BH-396 -- BIP Build 54 - January 2018'}
,{  55, '',   '20180201' ,  '20180201', '', '', 				'', 			  'Ingested S54 base. BH-397 -- BIP Build 55 - February 2018'}
,{  56, '',   '20180302' ,  '20180302', '', '',         '',         'Ingested S55 base. BH-424 -- BIP Build 56 - March 2018'}
,{  57, '',   '20180402' ,  '20180402', '', '',         '',         'Ingested S56 base + BH-449 patch. BH-458 -- BIP Build 57 - April 2018'}
,{  58, '',   '20180501' ,  '20180501', '', '',         '',         'Ingested S57 base + BH-333 patch. BH-459 -- BIP Build 58 - May 2018'}
,{  59, '',   '20180601' ,  '20180601', '', '',         '',         'Ingested S58 base. BH-460 -- BIP Build 59 - June 2018'}
,{  60, '',   '20180702' ,  '20180702', '', '',         '',         'Ingested S59 base. BH-478 -- BIP Build 60 - July 2018'}
,{  61, '',   '20180801' ,  '20180801', '', '',         '',         'Ingested S60 base + BH-504 patch. BH-479 -- BIP Build 61 - August 2018'}
,{  62, '',   '20180901' ,  '20180901', '', '',         '',         'Ingested S61 base + BH-524 patch. BH-480 -- BIP Build 62 - September 2018'}


//						version,			ingest			ToThor			ToCertRox		ToProdRox		//these are not exact field names.  they just help w read and update.
],rec);
//****
//****  end of the part that needs manual updating.
//****
//FUNCTIONS FOR CONVERTING BUILD NUMBERS INTO DATES COULD BE USEFUL HERE
//USE THESE AT YOUR OWN RISK.  MAY NOT BE EXACTLY WHAT YOU WANT
shared MostRecent                       := sort(ds, -buildNumber, -buildLetter);
shared MostRecentWithIngest             := MostRecent(ingestVersionDate <> '');
export MostRecentWithIngestVersionDate  := MostRecentWithIngest[1].ingestVersionDate;
export MostRecentSprintNumber           := (string)MostRecent[1].buildNumber + MostRecent[1].buildLetter;
export SprintNumber(string pversion)    := trim((string)MostRecent(versionDate = pversion)[1].buildNumber,all) + trim(MostRecent(versionDate = pversion)[1].buildLetter,all);
export ThisBuild                        := MostRecent[1];
export PreviousBuild                    := MostRecent[2];//in the case of 7a type builds it might not be quite what you want
export PreviousBuildDate                := MostRecent[2].versionDate;//in the case of 7a type builds it might not be quite what you want
shared isConsistent                     := (constant_ThisBuild_versionDate = ThisBuild.versionDate); // It's smart to confirm this is TRUE!!!
export SanityCheck                      := assert(isConsistent, 'KeySuffix is inconsistent', fail);
END;//KeySuffix_mod2
// EXPORT KeySuffix := '20130330'; // Uses the prod 20130321 data
// EXPORT KeySuffix := '20130418'; // Uses the prod 20130410 data
// EXPORT KeySuffix := '20130515'; // Uses the prod 20130514 data, "top 8" plus YP
// EXPORT KeySuffix := '20130515b'; // Uses the prod 20130514 data, "top 8" plus YP, Liens, Property, UCC, Vehicle, WC
// EXPORT KeySuffix := '20130515c'; // Uses the prod 20130514 data, "top 8" plus YP, Liens, Property, UCC, Vehicle, WC -- improved source_record_id Ingest logic, vl_id not derived
// EXPORT KeySuffix := '20130519'; // Uses the prod 20130519 data, "top 8" plus YP, Liens, Property, UCC, Vehicle, WC
// EXPORT KeySuffix := '20130521'; // Uses the prod 20130519 data, Bankruptcy only (it was an error to not include this in 20130519!)
// EXPORT KeySuffix := '20130718'; // Sprint1: Ingests 20130701 data, 17 sources (Added CA Sales Tax and ABIUS)
// EXPORT KeySuffix := '20130808'; // Sprint2: Ingests 20130726 data, 17 sources, UCC naturalized (promoted B to A), liens source_record_ids updated
// EXPORT KeySuffix := '20130823'; // Sprint3: Same as S2
// EXPORT KeySuffix := '20130905'; // Sprint4: Ingests 20130904 data, 19 sources (added IRS_5500 and IRS_Non_Profit), Property source_record_ids updated
// EXPORT KeySuffix := '20131001'; // Sprint5: Ingests 20130922 data, 26 sources (added Credit_Unions,FDIC,FAA,DEA,TXBUS,OSHAIR,BBB,and OR-Watercraft), DERIVED Property&BusReg source_record_id, DERIVED address value-added fields
// EXPORT KeySuffix := '20131017'; // Sprint6: No Ingest, busted singleton and non-root ghosts
// sprint7 and beyond moved to ds above]