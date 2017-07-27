// Process to build the Voters Registration Files.
//-------------------------------------------------------------------
// Note: The vendor layout for the vote history will change annualy. 
// Please pay special attention to the layout changes and notify
// data fabrication team.
//-------------------------------------------------------------------
import Lib_FileServices, STRATA, ut;

#workunit('name','Voters Reg Build -'+VotersV2.Version);

mailTarget := 'giri.rajulapalli@lexisnexis.com';

send_mail (string pSubject, string pBody) := lib_fileservices.FileServices.sendemail(mailTarget, pSubject, pBody);

ut.MAC_SF_BuildProcess(VotersV2.Transulate_Voters_Codes,VotersV2.Cluster+'base::Voters_Reg',aVotersMainBuild,2);

ut.MAC_SF_BuildProcess(VotersV2.Mapping_Voters_VoteHistory,VotersV2.Cluster+'base::Voters::Vote_History',aVotersChildBuild,2);

build_main_base  := aVotersMainBuild : success(output('Source base file built successfully')), failure(output('build of Source base file failed'));

build_child_base := aVotersChildBuild : success(output('Vote History base file built successfully')), failure(output('build of Vote History base file failed'));

build_keys  := VotersV2.Proc_build_voters_keys(VotersV2.Version) : success(output('roxie key build completed')), failure(output('roxie key build failed'));

build_stats   := VotersV2.Out_Base_Stats_Population_Voters;

sequential(parallel(build_main_base, build_child_base)			
				  ,parallel(build_keys, build_stats)
          ,send_mail('Emerges Voters Build',' - building base files, keys & stats completed successfully '));
