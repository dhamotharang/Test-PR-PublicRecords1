import header, ut, STRATA, lib_fileservices;

#workunit('name', 'DL2 Build ' + DriversV2.Version_Development);

badDLnums := DriversV2.File_DL_TX_Update2(dl_number[1..2]<>'00');					 
					 
checkTX_DL_Numbers := if(exists(badDLnums),
						fail('TX DL numbers have increased - Development is needed!  The following attribute should also be changed:  Risk_Indicators.Validate_DL'),
						output('Continuing'));

zVerifyVersion	:=	if(ut.DaysApart(ut.GetDate, DriversV2.Version_Development) >= 10,
					   fail('Please check DriversV2.Version_Development.'),
					   output(DriversV2.Version_Development,named('Version_Development'))
					  );

dl_patched := Driversv2.DL;
d := dl_patched;

// ** general check
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

ut.MAC_SF_BuildProcess(dl_patched, DriversV2.Constants.Cluster+'base::DL2::drvlic_AID',bBuildDLBase,2);
														  
ut.MAC_SF_BuildProcess(dl_patched_slim + 
                       Driversv2.File_Dummy_Data, DriversV2.Constants.Cluster+'base::DL2::drvlic',aBuildDLBase,2);


// ---------------------------------------------------
// New Stats
// ---------------------------------------------------
zPopStats	:=	DriversV2.Out_Base_Stats_Population;
				 
STRATA.CreateAsHeaderStats(DriversV2.dls_as_header(Driversv2.File_Base_withAID),
                           'Drivers Licenses V2',
					       'data',
					       DriversV2.Version_Development,
					       '',
                           zAsHeaderStats
                          );

//---------------------------------------------------

e_mail_success := fileservices.sendemail('roxiebuilds@seisint.com;fhumayun@seisint.com;vniemela@seisint.com;giri.rajulapalli@lexisnexis.com',
										 'DL2 base files and status build Succeeded ' + DriversV2.Version_Development,
										 'Base files: -------,\n' +
										 '   1) '+'thor_200::'+'base::dl2::Drvlic,\n' + 
										 '   2) '+'thor_200::'+'base::dl2::CP_Convictions,\n' + 
										 '   3) '+'thor_200::'+'base::dl2::CP_Suspensions,\n' + 
										 '   4) '+'thor_200::'+'base::dl2::CP_DR_Info,\n' + 
										 '   5) '+'thor_200::'+'base::dl2::CP_Accidents,\n' + 
										 '   6) '+'thor_200::'+'base::dl2::CP_FRA_Insurance,\n' + 	
										 '   have been built.');
				
e_mail_fail := fileservices.sendemail('fhumayun@seisint.com;giri.rajulapalli@lexisnexis.com',
        							  'giri.rajulapalli@lexisnexis.com',	
											  'DL2 base files build FAILED',
									  failmessage);

_uc := DriversV2.Update_DL_ConvPoints.Update_DL_Convictions;
_upd_conv := DATASET(ut.foreign_prod + 'thor_200::dl2::cp_updated_convictions',
                DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions,thor);
ut.MAC_SF_BuildProcess(_upd_conv,DriversV2.Constants.Cluster+'base::DL2::CP_Convictions',aConvBuild,2);

_us := DriversV2.Update_DL_ConvPoints.Update_DL_Suspensions;
_upd_suspn := DATASET(ut.foreign_prod + 'thor_200::DL2::CP_Updated_Suspensions',
                      DriversV2.Layouts_DL_Conv_Points_Common.Layout_Suspensions,thor);
ut.MAC_SF_BuildProcess(_upd_suspn,DriversV2.Constants.Cluster+'base::DL2::CP_Suspensions',aSuspBuild,2);


_udi := DriversV2.Update_DL_ConvPoints.Update_DL_DR_Info;
_upd_di := DATASET(ut.foreign_prod + 'thor_200::DL2::CP_Updated_DR_Info',
                   DriversV2.Layouts_DL_Conv_Points_Common.Layout_Driver_Record_Info ,thor);
ut.MAC_SF_BuildProcess(_upd_di,DriversV2.Constants.Cluster+'base::DL2::CP_DR_Info',aDRInfoBuild,2);

_ua := DriversV2.Update_DL_ConvPoints.Update_DL_Accidents;
_upd_acc := DATASET(ut.foreign_prod + 'thor_200::DL2::CP_Updated_Accidents',
                     DriversV2.Layouts_DL_Conv_Points_Common.Layout_Accident ,thor);
ut.MAC_SF_BuildProcess(_upd_acc,DriversV2.Constants.Cluster+'base::DL2::CP_Accidents',aAccidBuild,2);

_ui := DriversV2.Update_DL_ConvPoints.Update_DL_Insurance;
_upd_ins := DATASET(ut.foreign_prod + 'thor_200::DL2::CP_Updated_Insurance',
                    DriversV2.Layouts_DL_Conv_Points_Common.Layout_FRA_Insurance,thor);
ut.MAC_SF_BuildProcess(_upd_ins,DriversV2.Constants.Cluster+'base::DL2::CP_FRA_Insurance',aFRABuild,2);

sequential(checkTX_DL_Numbers,
			 parallel(zVerifyVersion,
					  zOutput_Bad_Date_Seen,
					  zCount_Bad_Date_Seen,
					  zOld_Stats,
					  aBuildDLBase,
						bBuildDLBase
					 ),
			parallel(zPopStats,
					  zAsHeaderStats
					 ),
			parallel(SEQUENTIAL(_uc,aConvBuild), 
			         SEQUENTIAL(_us,aSuspBuild), 
					 SEQUENTIAL(_udi,aDRInfoBuild), 
					 SEQUENTIAL(_ua,aAccidBuild), 
					 SEQUENTIAL(_ui,aFRABuild))
		   ): 
		   success(e_mail_success), 
		   FAILURE(e_mail_fail);
           
