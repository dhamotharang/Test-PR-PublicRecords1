/*2007-10-02T12:19:46Z (Cecelie_p Guyton)
changed output to be sequential
*/
//////////////////////////////////////////////////////////////////////////////////////////
// Attribute 	: PROC_BUILD_HOGAN_BASE

// DEPENDENT ON : liensv2.layout_liens_main_module.layout_liens_main,
//				  Liensv2.File_Dummy_Main,
//				  liensV2.Mapping_Hogan_Main,
//				  liensV2.Hogan_DID

// PURPOSE	 	: Create new files for party and main Liensv2 files and add the
//				  base file for Hogan
//////////////////////////////////////////////////////////////////////////////////////////

import ut, RoxieKeyBuild, PromoteSupers, STD;

// Check if input liens superfile exists and has atleast on subfile in it

export proc_build_Hogan_base(string filedate) := function

checkfileexists(string FileName)
 := if(fileservices.SuperFileExists(FileName) and fileservices.GetSuperFileSubCount(Filename) > 0,
	     true,false	);


// Create dataset of the liens hogan main file
Hogan_main := dataset('~thor_data400::base::liens::main::hogan',liensv2.layout_liens_main_module_for_hogan.layout_liens_main,flat);

// Remove IRS dummy records from hogan main file //////////////////////////
liensv2.layout_liens_main_module_for_hogan.layout_liens_main remove_dummy
(liensv2.layout_liens_main_module_for_hogan.layout_liens_main L,liensv2.layout_liens_main_module_for_hogan.layout_liens_main R) := transform
	self := L;
end;

remove_dummy_project := join(Hogan_Main,Liensv2.File_Dummy_Main,
															left.rmsid = right.rmsid and left.tmsid = right.tmsid,
															remove_dummy(left,right),left only,lookup); //DF-24061 VC

/////////////////////////////////////////////////////////////////////////

// Create a new file which excludes IRS dummy records
create_new_main_file := output(remove_dummy_project,,'~thor_data400::in::liens::main::hogan::dummy_removed'+ filedate,overwrite);

// Add the new file to main base file
Add_new_main_file := sequential(
													fileservices.addsuperfile('~thor_data400::base::liens::main::hogan::dummy_delete','~thor_data400::base::liens::main::hogan::dummy_father',,true),
													fileservices.clearsuperfile('~thor_data400::base::liens::main::hogan::dummy_father'),
													fileservices.addsuperfile('~thor_data400::base::liens::main::hogan::dummy_father','~thor_data400::base::liens::main::hogan',,true),
													fileservices.clearsuperfile('~thor_data400::base::liens::main::hogan'),
													fileservices.addsuperfile('~thor_data400::base::liens::main::hogan','~thor_data400::in::liens::main::hogan::dummy_removed'+ filedate),
													fileservices.clearsuperfile('~thor_data400::base::liens::main::hogan::dummy_delete',true)
													);

//build Hogan main & party base file
// Add the IRS dummy records with new version stamped in process date
main_dataset := dataset('~thor_data400::in::liensv2::main::dummy_irs',liensv2.layout_liens_main_module.layout_liens_main,flat);

Liensv2.layout_liens_main_module_for_hogan.layout_liens_main change_dummy_ver(main_dataset d) := transform
	self.process_date := (string)STD.Date.Today();
	self.filing_date := (string)STD.Date.Today();
	self.orig_filing_date := (string)STD.Date.Today();
	self.orig_rmsid := '';
	self := d;
end;

dummy_project := project(main_dataset,change_dummy_ver(left));
											 
	//Patch to Populate date_first_seen fields - Bugzilla #67215
	ds_party 			:= liensV2.Hogan_DID;
	ds_main 			:= liensV2.Mapping_Hogan_Main + dummy_project;
	ds_fix				:= LiensV2._Functions.fn_HoganPopDtFirstSeen(ds_party, ds_main);

	//Patch to Populate date_first_seen fields - Bugzilla #67215	
	ds_full_party := dataset('~thor_data400::base::liens::party::Hogan_full_temp', liensv2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags, thor);
	ds_fix2				:= LiensV2._Functions.fn_HoganPopDtFirstSeen(ds_full_party, ds_main);
/*************************************************************DF-24044******************************************************************/
/****************************************************************Main*******************************************************************/
            
dHoganMainwithNewIds := LiensV2.Fn_Propagate_TMSIDRMSID_Main(ds_main);		
					

LiensV2.Layout_liens_main_module_for_hogan.layout_liens_main tAdobt_newTMSID (dHoganMainwithNewIds l) := Transform
self.tmsid := Map(l.BestEarliestTMSID <> '' => l.BestEarliestTMSID,
                  l.tmsid);
self.rmsid := Map(l.newrmsid <> '' => l.newrmsid,
                  l.rmsid);
self:= l;
end;

TMSIDPatch := Project(dHoganMainwithNewIds,tAdobt_newTMSID(left));
//DF-29287 Remove dups
Patch_sort := sort(TMSIDPatch,tmsid, rmsid, record_code, date_vendor_removed,  filing_jurisdiction, filing_state, orig_filing_number, orig_filing_type,  
                orig_filing_date, orig_filing_time ,  case_number, filing_number, filing_type_desc,  filing_date ,  filing_time,  vendor_entry_date, judge, case_title,  
							  filing_book, filing_page, release_date, amount, eviction, satisifaction_type, judg_satisfied_date, judg_vacated_date, tax_code, irs_serial_number, effective_date, 
							  lapse_date, accident_date, sherrif_indc, expiration_date, agencyID, agency_state, agency_county, legal_lot, legal_block, legal_borough, certificate_number, 
								orig_filing_time, -process_date,local);

dNewHoganMainBasewithNewIds := dedup(Patch_sort,tmsid, rmsid, record_code, date_vendor_removed,  filing_jurisdiction, filing_state, orig_filing_number, orig_filing_type,  
                orig_filing_date, orig_filing_time ,  case_number, filing_number, filing_type_desc,  filing_date ,  filing_time,  vendor_entry_date, judge, case_title,  
							  filing_book, filing_page, release_date, amount, eviction, satisifaction_type, judg_satisfied_date, judg_vacated_date, tax_code, irs_serial_number, effective_date, 
							  lapse_date, accident_date, sherrif_indc, expiration_date, agencyID, agency_state, agency_county, legal_lot, legal_block, legal_borough, certificate_number,local);


/************************************************************Mapping File**************************************************************/ 
//Generate Mapping file for distribution
LiensV2.Layout_TMSIDRMSID_Mappingfile tGenerateMapping (dHoganMainwithNewIds L) :=TRANSFORM

self.TMSID_old := L.TMSID;
self.RMSID_old := L.RMSID;
self.TMSID     := L.BestEarliestTMSID; 
self.RMSID     := L.NewRMSID;
end;

dMappingfile_out := Project(dHoganMainwithNewIds(BestEarliestTMSID <> tmsid and BestEarliestTMSID <> ''),tGenerateMapping(left));
dMappingFile_outdeduped := dedup(sort(dMappingfile_out,record),record);

dMappingfile_tosend := Project(dHoganMainwithNewIds(BestEarliestTMSID <> tmsid and BestEarliestTMSID <> '' and process_date < (STRING8)Std.Date.Today()),tGenerateMapping(left));
dMappingFile_tosenddeduped := dedup(sort(dMappingfile_tosend,record),record);
/**************************************************Party*************************************************************************/
//Propagate the new IDS to Party file
dHoganPartywithnewids       := LiensV2.Fn_Propagate_TMSIDRMSID_Party(dMappingFile_outdeduped,ds_fix);

//Propagate the new IDS to Party full file
dHoganPartyfullwithnewids   := LiensV2.Fn_Propagate_TMSIDRMSID_Party(dMappingFile_outdeduped,ds_fix2);

liensv2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags tAdobt_newTMSID2 (dHoganPartywithnewids l) := Transform
self.tmsid := MAP(l.newtmsid <> '' => l.newtmsid,
                  l.tmsid);
self.rmsid := MAP(l.newrmsid <> '' => l.newrmsid,
                  l.rmsid);
self:= l;
end;
dNewHoganPartyBasewithNewIds := Project(dHoganPartywithnewids,tAdobt_newTMSID2(left));

liensv2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags tAdobt_newTMSID3 (dHoganPartyfullwithnewids l) := Transform
self.tmsid := MAP(l.newtmsid <> '' => l.newtmsid,
                  l.tmsid);
self.rmsid := MAP(l.newrmsid <> '' => l.newrmsid,
                  l.rmsid);
self:= l;
end;
dNewHoganPartyFullBasewithNewIds := Project(dHoganPartyfullwithnewids,tAdobt_newTMSID3(left));

/**********************************************************************************************************/

// Set_tmsid:=['HG0003519452339NYRICC1                            ','HG0004078143642NYRICC1                            ','HG000435541625NYRICC1                             ','HG0004397045031NYRICC1                            ','HG0007359331988KYKENC1                            '];

// output(ds_main(tmsid in Set_tmsid),named('o21')); 
// output(dHoganMainwithNewIds(tmsid in Set_tmsid),named('o22')); 
// output(dNewHoganMainBasewithNewIds(tmsid in Set_tmsid),named('o23')); 
PromoteSupers.MAC_SF_BuildProcess(dNewHoganMainBasewithNewIds,
                       '~thor_data400::base::Liens::Main::Hogan',bld_hogan_main, 2,,true);
PromoteSupers.MAC_SF_BuildProcess(dMappingFile_tosenddeduped,
                       '~thor_data400::base::Liens::Mappingfile::Hogan',bld_hogan_Mappingfile, 2,,true);											 
											 
PromoteSupers.MAC_SF_BuildProcess(dNewHoganPartyBasewithNewIds,'~thor_data400::base::Liens::party::Hogan', bld_hogan_party, 2,,true);

RoxieKeybuild.Mac_SF_BuildProcess_V2(dNewHoganPartyFullBasewithNewIds,'~thor_data400::base::liens::party','hogan_full',filedate,hoganfull,,,true);

 return if(checkfileexists('~thor_data400::in::liensv2::hgn::okclien'),
sequential(

Liensv2.AddSuperFileContents('HOGAN'),

// Removing IRS records from Party file
fileservices.removesuperfile('~thor_data400::base::Liens::party::Hogan','~thor_data400::in::liensv2::party::dummy_irs2'),
create_new_main_file,add_new_main_file,
bld_hogan_Mappingfile,
bld_hogan_main,bld_hogan_party,
// Adding back the IRS records to party file
fileservices.addsuperfile('~thor_data400::base::Liens::party::Hogan','~thor_data400::in::liensv2::party::dummy_irs2'),
//Replace full file
hoganfull,

Liensv2.Clear_Liensv2_Input_SuperFiles('HOGAN'),

FileServices.DeleteLogicalFile('~thor_data400::base::liens::party::Hogan_full_temp')

),

output('No New files for HOGAN')

);

end;