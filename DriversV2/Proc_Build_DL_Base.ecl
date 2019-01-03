import header, ut, STRATA, lib_fileservices, MDR, std, PromoteSupers;


#workunit('priority','high');
#workunit('priority',11);
#OPTION('multiplePersistInstances',FALSE);

export proc_build_dl_base(string		pversion)
:= function

stateSet	:=	['CT','FL','LA','MI','MN','NE','OH'];

zVerifyVersion	:=	if(ut.DaysApart((string8)Std.Date.Today(), pversion) >= 10,
					   fail('Please check Version date passed ' + pversion),
					   output(pversion,named('Version_Date'))
					  );
 
zTXData       :=  DriversV2.File_DL_TX_Update_Clean;
zVerifyTXData	:=	if (count(zTXData(length(trim(dl_number)) = 10 and trim(dl_number)[1..2]!='00' and trans_indicator ='U')) > 0,
												fail('TX DLs is sending data containing something other than 2 leading zeroes in the DL_number field  - Development is needed!')
											);

// Split the restricted DL information out of the data.
dl_patched    := Driversv2.DL(source_code != MDR.sourceTools.src_MN_RESTRICTED_DL);
dl_restricted := Driversv2.DL(source_code = MDR.sourceTools.src_MN_RESTRICTED_DL);

// The restricted DL information has already been removed at this point
d := dl_patched;

//** general check
zOutput_Bad_Date_Seen	:=	output(choosen(d(dt_first_seen > dt_last_seen), 1000),named('Bad_Date_Seen'));
zCount_Bad_Date_Seen	:=	output(count(d(dt_first_seen > dt_last_seen)),named('Count_Bad_Date_Seen')); //should be zero

stat_rec := record
  d.source_code;
  d.orig_state;
  counted       := count(group);
  pcnt_did      := AVE(GROUP,IF(d.did=0,0,100));
  pcnt_preglb   := AVE(GROUP,IF(d.preglb_did=0,0,100));
  pcnt_ssn      := AVE(GROUP,IF((unsigned8)d.ssn=0,0,100));
  pcnt_historic := AVE(GROUP,IF(d.history='H',100,0));
  pcnt_expired  := AVE(GROUP,IF(d.history='E',100,0));
end;

ta := table(dl_patched,stat_rec,d.source_code,d.orig_state);

zOld_Stats	:=	output(ta,named('Old_Stats'));

DriversV2.Layout_DL_Extended tSlim(DriversV2.Layout_Base_withAID L) := TRANSFORM
	 SELF  :=  L;
END;
dl_patched_slim := PROJECT(dl_patched,tSlim(LEFT));						  

PromoteSupers.MAC_SF_BuildProcess(dl_patched_slim + 
                       Driversv2.File_Dummy_Data(pversion), DriversV2.Constants.Cluster+'base::DL2::drvlic',aBuildDLBase,3, ,true);

/* Transform/Project the dummy data to map to Base w/AID format */
DriversV2.Layout_Base_withAID tMapping(DriversV2.Layout_DL_Extended L) := TRANSFORM
	SELF.Append_MailAddress1		:= 	'';
	SELF.Append_MailAddressLast	:=  ''; 	
	SELF.Append_MailRawAID := 0;
	SELF.Append_MailACEAID := 0;
	SELF  :=  L;
END;
dMapping := PROJECT(Driversv2.File_Dummy_Data(pversion),tMapping(LEFT));

PromoteSupers.MAC_SF_BuildProcess(dl_patched + dMapping, DriversV2.Constants.Cluster+'base::DL2::drvlic_AID',bBuildDLBase,3, ,true);
											                                                          
PromoteSupers.MAC_SF_BuildProcess(dl_restricted, DriversV2.Constants.Cluster+'base::DL2::RESTRICTED_drvlic_AID',resBuildDLBase,3, ,true);

DriversV2.Layout_DL_For_Insurance trfSlim(DriversV2.File_DL_Extended input) := TRANSFORM
// Note! In June of 2009 a layout change for TX occured where dl_numbers went from 8 to 10 in length
// To be consistent with the numbers our customers are alreay using, we are leaving them as 8 in length
// for the BOCA Applications and adding the leading zeroes to match with current dl numbers for insurance.
	self.dl_number	:=	if(input.orig_state='TX',
														'00' + input.dl_number,
														input.dl_number
												 );
	self.ssn				:=	'';
	// December 2018 - DF-23661:  Insurance team requested that for FL records, orig_county be populated with 
	// values from state field if 01-67 because those are actually county codes. 
	self.orig_county := if(input.orig_state = 'FL' and (integer)input.state >= 01 and (integer)input.state <= 67
												 ,input.state, '');
	SELF 						:= 	input;
END;
											 
dSlimDLBase	:=	project(DriversV2.File_DL_Extended(source_code != 'CY'), trfSlim(left));

PromoteSupers.MAC_SF_BuildProcess(dSlimDLBase, DriversV2.Constants.Cluster+'base::DL2::InsuranceSlim',aSlimDLBase,3, ,true);

//---------------------------------------------------
// New Stats
//---------------------------------------------------
zPopStats	:=	DriversV2.Out_Base_Stats_Population(pversion);

zPopStats_restricted := DriversV2.Out_Restricted_Base_Stats_Population(pversion);

STRATA.CreateAsHeaderStats(DriversV2.dls_as_header(DriversV2.File_Base_withAID),
                           'Drivers Licenses V2',
					       'data',
					       pversion,
					       '',
                           zAsHeaderStats
                          );

//---------------------------------------------------
e_mail_success := fileservices.sendemail('roxiebuilds@seisint.com;fhumayun@seisint.com;vniemela@seisint.com;giri.rajulapalli@lexisnexis.com;michael.gould@lexisnexis.com;melanie.jackson@lexisnexis.com',
										 'DL2 base files and status build Succeeded ' + pversion,
										 'Base files: -------,\n' +
										 '   1) '+DriversV2.Constants.cluster+'base::dl2::Drvlic,\n' + 
										 '   2) '+DriversV2.Constants.cluster+'base::dl2::CP_Convictions,\n' + 
										 '   3) '+DriversV2.Constants.cluster+'base::dl2::CP_Suspensions,\n' + 
										 '   4) '+DriversV2.Constants.cluster+'base::dl2::CP_DR_Info,\n' + 
										 '   5) '+DriversV2.Constants.cluster+'base::dl2::CP_Accidents,\n' + 
										 '   6) '+DriversV2.Constants.cluster+'base::dl2::CP_FRA_Insurance,\n' + 		
										 '   have been built.');
				
e_mail_fail := fileservices.sendemail('fhumayun@seisint.com;giri.rajulapalli@lexisnexis.com',
        						 'michael.gould@lexisnexis.com,com;giri.rajulapalli@lexisnexis.com;melanie.jackson@lexisnexis.com',
										 'DL2 base files build FAILED',
									  failmessage);

// _uc := DriversV2.Update_DL_ConvPoints.Update_DL_Convictions;
// _upd_conv := DATASET('~thor_200::dl2::cp_updated_convictions',
                // DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions,thor);
// ut.MAC_SF_BuildProcess(_upd_conv,DriversV2.Constants.Cluster+'base::DL2::CP_Convictions',aConvBuild,2, ,true);


// _us := DriversV2.Update_DL_ConvPoints.Update_DL_Suspensions;
// _upd_suspn := DATASET('~thor_200::DL2::CP_Updated_Suspensions',
                      // DriversV2.Layouts_DL_Conv_Points_Common.Layout_Suspensions,thor);
// ut.MAC_SF_BuildProcess(_upd_suspn,DriversV2.Constants.Cluster+'base::DL2::CP_Suspensions',aSuspBuild,2, ,true);


// _udi := DriversV2.Update_DL_ConvPoints.Update_DL_DR_Info;
// _upd_di := DATASET('~thor_200::DL2::CP_Updated_DR_Info',
                   // DriversV2.Layouts_DL_Conv_Points_Common.Layout_Driver_Record_Info ,thor);
// ut.MAC_SF_BuildProcess(_upd_di,DriversV2.Constants.Cluster+'base::DL2::CP_DR_Info',aDRInfoBuild,2, ,true);


// _ua := DriversV2.Update_DL_ConvPoints.Update_DL_Accidents;
// _upd_acc := DATASET('~thor_200::DL2::CP_Updated_Accidents',
                     // DriversV2.Layouts_DL_Conv_Points_Common.Layout_Accident ,thor);
 // ut.MAC_SF_BuildProcess(_upd_acc,DriversV2.Constants.Cluster+'base::DL2::CP_Accidents',aAccidBuild,2, ,true);


// _ui := DriversV2.Update_DL_ConvPoints.Update_DL_Insurance;
// _upd_ins := DATASET('~thor_200::DL2::CP_Updated_Insurance',
                    // DriversV2.Layouts_DL_Conv_Points_Common.Layout_FRA_Insurance,thor);
// ut.MAC_SF_BuildProcess(_upd_ins,DriversV2.Constants.Cluster+'base::DL2::CP_FRA_Insurance',aFRABuild,2, ,true);

PromoteSupers.MAC_SF_BuildProcess(DriversV2.Update_DL_ConvPoints.Update_DL_Convictions,DriversV2.Constants.Cluster+'base::DL2::CP_Convictions',aConvBuild,3, ,true);

PromoteSupers.MAC_SF_BuildProcess(DriversV2.Update_DL_ConvPoints.Update_DL_Convictions_Restricted,DriversV2.Constants.Cluster+'base::DL2::CP_Convictions_Restricted',aResConvBuild,3, ,true);

PromoteSupers.MAC_SF_BuildProcess(DriversV2.Update_DL_ConvPoints.Update_DL_Suspensions,DriversV2.Constants.Cluster+'base::DL2::CP_Suspensions',aSuspBuild,3, ,true);

PromoteSupers.MAC_SF_BuildProcess(DriversV2.Update_DL_ConvPoints.Update_DL_DR_Info,DriversV2.Constants.Cluster+'base::DL2::CP_DR_Info',aDRInfoBuild,3, ,true);

PromoteSupers.MAC_SF_BuildProcess(DriversV2.Update_DL_ConvPoints.Update_DL_Accidents,DriversV2.Constants.Cluster+'base::DL2::CP_Accidents',aAccidBuild,3, ,true);

PromoteSupers.MAC_SF_BuildProcess(DriversV2.Update_DL_ConvPoints.Update_DL_Insurance,DriversV2.Constants.Cluster+'base::DL2::CP_FRA_Insurance',aFRABuild,3, ,true);

results := sequential(parallel(zVerifyVersion,
						zVerifyTXData,
					  zOutput_Bad_Date_Seen,
					  zCount_Bad_Date_Seen,
					  zOld_Stats,
					  aBuildDLBase
					 ),
			bBuildDLBase,
			resBuildDLBase,
			parallel(aSlimDLBase,
						zPopStats,
						zPopStats_restricted,
					  zAsHeaderStats
					 ),
			parallel(aConvBuild, aResConvBuild, aSuspBuild, aDRInfoBuild, aAccidBuild, aFRABuild)
		   ): 
		   success(e_mail_success), 
		   FAILURE(e_mail_fail);

return results;
end;
