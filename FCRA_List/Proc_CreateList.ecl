import Header, Watercraft, Gong_Neustar, InfutorCID, Impulse_Email, HMS, Infogroup, iBehavior, AutoStandardI, Suppress,PromoteSupers, ALC, prof_license, doxie_build, ut,FCRA_LIST,STD,_control;

EXPORT Proc_CreateList(STRING pversion = '', boolean pUseProd = false) := module

// pversion := '';
// pUseProd := true;

//Proflic 

approved_proflic := FCRA_list.proflic_as_header(,,true);

//FCRA header 
incoming_file := //Header.File_FCRA_Headers;
                 doxie_build.File_FCRA_header_building;

dsMarketing_1 := incoming_file(src in FCRA_list.constants.FCRA_hdr_ApprovedSourcesList);
dsMarketing_2 := incoming_file(src in FCRA_list.constants.FCRA_hdr_ApprovedSourcesExcludingNY, st <> 'NY');
dsMarketing_3 := incoming_file(src in FCRA_list.constants.FCRA_hdr_ApprovedSourcesExcludingOtherStates, st not in FCRA_list.constants.SetStatesExexcluded);

dsMarket_combine := dsMarketing_1 + dsMarketing_2 + dsMarketing_3;

approved_header := dsMarket_combine;

//Watercraft Sources(8W)

approved_watercraft := watercraft.Watercraft_as_Header(,,,,true);

//Neustar(GN)
approved_gong := FCRA_List.Gong_as_header(,true);

//Infutor Data Solutions(IR)
approved_InfutorCID := FCRA_list.InfutorCID_as_header(,true);

//Purchase Activity(IB) will be added in phase2 
//approved_iBehavior_Consumer := FCRA_list.iBehavior_as_header;

//Impulse Subprime Credit Information Requests(IM)
//approved_Impulse_Email := FCRA_list.Impulse_Email_as_header(,true);

//CNLD_Practitioner

approved_CNLD := FCRA_list.CNLD_Practitioner_as_header(,true);

//NCPDP

approved_NCPDP := FCRA_list.NCPDP_as_header(,true);

//Proflic Mari

approved_Proflic_Mari := FCRA_list.Mari_as_header(,true);

//the below sources will be added in phase2
//HMS
//approved_HMS	:= HMS.Files(pversion,pUseProd).Individual_Base.Built(did != 0);

//ALC-- in development
//approved_ALC := ALC.Files().Base.Built(did != 0);

//Infogroup(X3)
//approved_Infogroup := Infogroup.Files(pversion,false).Base.Built(did != 0);

//Combine all sources 

combine_file := project(approved_proflic + approved_Watercraft + approved_gong + approved_infutorCID 
 + approved_CNLD + approved_NCPDP + approved_Proflic_Mari, header.Layout_Header)
 + approved_header;// + convert_infogroup + convert_HMS + convert_alc + approved_iBehavior_Consumer;


dedup_all := dedup(sort(distribute(combine_file, hash(did)), record, local), record, local);

PromoteSupers.MAC_SF_BuildProcess(dedup_all,'~thor_data400::base::header_list_generate_fcra',buildFCRA,3,,true);

export buildbase := buildFCRA;

end;
