// Process to build the Voters Registration Files.
//-------------------------------------------------------------------
// Note: The vendor layout for the vote history will change annualy. 
// Please pay special attention to the layout changes and notify
// data fabrication team.
//-------------------------------------------------------------------
import orbit_report,Lib_FileServices, STRATA, PromoteSupers, roxiekeybuild, risk_indicators, _control, Scrubs, Scrubs_Voters, tools, STD, ut, Orbit3, dops;

export proc_build_all(string filedate) := function

	mailTargetSuccess := _Control.MyInfo.EmailAddressNotify + ';kgummadi@seisint.com;fhumayun@seisint.com;roxiebuilds@seisint.com';
	mailTarget := _Control.MyInfo.EmailAddressNotify + ';kgummadi@seisint.com;fhumayun@seisint.com';

	send_mail (string pSubject, string pBody) := lib_fileservices.FileServices.sendemail(mailTarget, pSubject, pBody);

	RoxieKeyBuild.Mac_Daily_Email_Local('EMERGES VOTE','SUCC',filedate,sendSuccMsg,mailTargetSuccess);
	RoxieKeyBuild.Mac_Daily_Email_Local('EMERGES VOTE','FAIL',fileDate,sendFailMsg,mailTarget);

  //DF-26929 - MA recs were determined to be Census records and not Voter Regs and thus need removed
  voter_reg := VotersV2.Translate_Voters_Codes;
	PromoteSupers.MAC_SF_BuildProcess(voter_reg(source_state != 'MA'),VotersV2.Cluster+'base::Voters_Reg',aVotersMainBuild,3,,true);
	PromoteSupers.MAC_SF_BuildProcess(voter_reg(source_state = 'MA'),VotersV2.Cluster+'base::MA_Census',aCensusMainBuild,3,,true);
  voter_hist      := VotersV2.Mapping_Voters_VoteHistory;
  voter_hist_only := VotersV2.Extract_Census_History(voter_reg, voter_hist).VoteHistOnly;
  census_hist     := VotersV2.Extract_Census_History(voter_reg, voter_hist).VoteHistCensus;
	PromoteSupers.MAC_SF_BuildProcess(voter_hist_only,VotersV2.Cluster+'base::Voters::Vote_History',aVotersChildBuild,2,,true);
	PromoteSupers.MAC_SF_BuildProcess(census_hist,VotersV2.Cluster+'base::MA_Census::History',aCensusChildBuild,2,,true);

	build_base := parallel(aVotersMainBuild, aVotersChildBuild) : success(output('Base files built successfully')), failure(output('Building of base files failed'));
	build_census := parallel(aCensusMainBuild, aCensusChildBuild) : success(output('Census base files built successfully')), failure(output('Building of census base files failed'));
	
	build_keys := sequential(VotersV2.Proc_build_voters_keys(filedate),
													 VotersV2.Proc_Build_Boolean_keys(filedate)
													) : success(sendSuccMsg), failure(sendFailMsg);
	
	update_dops := sequential(dops.updateversion('VotersV2Keys',filedate,mailTarget,,'N|B'),
	                          dops.updateversion('FCRA_VotersV2Keys',filedate,mailTarget,,'F')
															);
	
	build_stats := VotersV2.Out_Base_Stats_Population_Voters(filedate);
	orbit_report.Voters_Stats(getretval);
  build_gender := risk_indicators.Gender_Base;
															
	orbit_update := sequential(Orbit3.proc_Orbit3_CreateBuild_AddItem('Voter Registrations',filedate,'N|B'),
																	Orbit3.proc_Orbit3_CreateBuild_AddItem('FCRA Voter Registrations',filedate,'F')
																);
	return if(thorlib.wuid()[2..5] <= VotersV2._Flags.stop_year,
	          sequential(
						           
                       Scrubs.ScrubsPlus('Voters','Scrubs_Voters','Scrubs_Voters_In_Reg' ,'In_Reg' ,filedate,mailTarget),
						           build_base,
                       build_census,
                       Scrubs.ScrubsPlus('Voters','Scrubs_Voters','Scrubs_Voters_Base_History','Base_History',filedate,mailTarget),
                       Scrubs.ScrubsPlus('Voters','Scrubs_Voters','Scrubs_Voters_Base_Reg' ,'Base_Reg' ,filedate,mailTarget),
										   build_keys,
										   build_gender,
										   parallel(update_dops,build_stats),
										   SampleRecs,
										   orbit_update,
										   send_mail('Emerges Voters Build','Base files, keys & stats completed successfully!'),
											 getretval
										   ),
					 sequential(
							send_mail('STOP IMMEDIATELY - Emerges Voters Build',
												'It has been a year since Data Fabrication has verified that the layout ' +
													 'has not changed.  Do NOT sandbox the year, in order to get this build ' +
													 'to run.  Contact Data Fabrication to verify there doesn\'t need to be ' +
													 'a layout change.  The proper year will be migrated, once everything ' +
													 'is verified.  Workunit of failed build is ' + thorlib.wuid()),
							fail('CONTACT DATA FABRICATION IMMEDIATELY')));
end;