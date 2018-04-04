import Header, Watercraft, Gong_Neustar, InfutorCID, Impulse_Email,iBehavior, AutoStandardI, Suppress,PromoteSupers, prof_license, doxie_build, ut,FCRA_LIST,STD,_control,Risk_Indicators;

EXPORT Proc_CreateList(STRING pversion = '', boolean pUseProd = false) := module

// pversion := '';
// pUseProd := true;

//Proflic 

approved_proflic := prof_license.proflic_as_header(,,,true);

//FCRA header 
incoming_file := //Header.File_FCRA_Headers;
                 doxie_build.File_FCRA_header_building;

dsMarketing_1 := incoming_file(src in FCRA_list.constants.FCRA_hdr_ApprovedSourcesList);
dsMarketing_2 := incoming_file(src in FCRA_list.constants.FCRA_hdr_ApprovedSourcesExcludingNY, st <> 'NY');
dsMarketing_3 := incoming_file(src in FCRA_list.constants.FCRA_hdr_ApprovedSourcesExcludingOtherStates, st not in FCRA_list.constants.SetStatesExexcluded);

dsMarket_combine := dsMarketing_1 + dsMarketing_2 + dsMarketing_3;

approved_header := dsMarket_combine;

//Watercraft Sources(8W)

//approved_watercraft := watercraft.Watercraft_as_Header(,,,,true);

//Combine all sources
combine_file := project(fcra_list.fn_header_joined(approved_proflic), header.Layout_Header)+ approved_header;

dedup_all := dedup(sort(distribute(combine_file, hash(did)), record, local), record, local): persist('~thor_data400::persist::header_list_generate_fcra_pre_correction');
/* ****************************************************
 *                  Apply Corrections                 *
 ****************************************************** */
base_hf_corrected := Risk_Indicators.Header_Corrections_Function(dedup_all);

PromoteSupers.MAC_SF_BuildProcess(base_hf_corrected,'~thor_data400::base::header_list_generate_fcra',buildFCRA,3,,true);

export buildbase := buildFCRA;

end;
