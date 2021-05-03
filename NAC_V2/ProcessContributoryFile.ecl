import _Control,tools,STD;

ModifyFileName(string ilfn, string rpt) := Std.Str.FindReplace(ilfn, 'ncf2', rpt);
ExtractFileName(string ilfn) := Std.Str.SplitWords(ilfn, '::')[4];
Archive(varstring ilfn) := NOTHOR(IF(STD.File.FindSuperFileSubName($.Superfile_List.sfNCF2,ilfn)=0,
													STD.File.AddSuperFile($.Superfile_List.sfNCF2,ilfn)));

Lower(string s) := Std.Str.ToLowerCase(s);

boolean IsOnboarding(string gid) := NAC_V2.dNAC2Config(GroupID=gid)[1].Onboarding in ['y','Y'];
													
/**
  dataDir			has incoming and ougoing subdirectories
	maintenance	has spraying, done, error subdirectories
*/
EXPORT ProcessContributoryFile(string ip, string dataDir, string lfn, string maintenance, string version) := function

		ready    := dataDir + 'incoming/';
		done     := maintenance+'done/';
		err      := maintenance+'error/';
		spraying := maintenance+'spraying/';
		outgoing := dataDir+'outgoing/';
		
		gid := Lower(lfn[6..9]);
		onboarding := IsOnboarding(gid);			// If not onboard, send reports but do not process file
		
		ilfn := '~nac::uber::in::'+lfn;

		MoveReadyToSpraying := nothor(STD.File.MoveExternalFile(ip, ready+lfn, spraying+lfn));
		MoveReadyToError    := nothor(STD.File.MoveExternalFile(ip, ready+lfn, err+lfn));
		MoveSprayingToError := nothor(STD.File.MoveExternalFile(ip, spraying+lfn, err+lfn));
		MoveSprayingToDone  := nothor(STD.File.MoveExternalFile(ip, spraying+lfn, done+lfn));
		
		SprayIt := sequential(
						output('Spraying: '+ ip + ready + lfn + ' -> ' + '~nac::uber::in::'+lfn)
						,nothor(STD.File.SprayVariable(
							 IP
							,spraying + lfn
							,,,,
							,if(_Control.ThisEnvironment.Name='Dataland','thor400_dev01','thor400_44')
							,ilfn
							,
							,
							,
							,true
							,true
							,true
							))
						);		

		treshld_  := $.Mod_Sets.threshld;
		
		processed := $.PreprocessNCF2(ilfn);
		IsEmptyFile:= NOT EXISTS(processed);

		//base2 := $.fn_constructBase2FromNCFEx(processed, version);				
		reports := $.GetReports(processed, ilfn, FALSE);
		ExcessiveInvalidRecordsFound :=	reports.RejectFile;
		
		MoveToTempOrReject := 	if(ExcessiveInvalidRecordsFound
												,MoveSprayingToError
												,MoveSprayingToDone
											);

		
		out_NCF_reports := PARALLEL(
					OUTPUT(reports.dsNcr2,,ModifyFileName(ilfn, 'ncr2'), COMPRESSED, OVERWRITE, named('ncr2')),
					OUTPUT(reports.dsNcd2,,ModifyFileName(ilfn, 'ncd2'), COMPRESSED, OVERWRITE, named('ncd2')),
					OUTPUT(reports.dsNcx2,,ModifyFileName(ilfn, 'ncx2'), COMPRESSED, OVERWRITE, named('ncx2'))
					);
		
		despray_NCF_reports(string rep):=function
			fn := ModifyFileName(ilfn, rep);
			pDestinationFile:= outgoing + trim(ExtractFileName(fn));
			return fileservices.Despray(fn,ip,pDestinationFile,,,,TRUE);
		end;
		
		queueFileForProcessing := ORDERED(
					OUTPUT(processed,,ModifyFileName(ilfn, 'ncfx'), COMPRESSED, OVERWRITE),
					IF(Onboarding,
							NOTHOR(Std.File.AddSuperFile(NAC_V2.Superfile_List.sfOnboarding, ModifyFileName(ilfn, 'ncfx'))),
							NOTHOR(Std.File.AddSuperFile(NAC_V2.Superfile_List.sfReady, ModifyFileName(ilfn, 'ncfx')))
					)
				);

		doit :=  
			sequential(
					MoveReadyToSpraying
					,SprayIt
					,Archive(ilfn)
					,OUTPUT(processed,,ModifyFileName(ilfn, 'nac2'), COMPRESSED, OVERWRITE)
					,OUTPUT(reports.TotalRecords, named('total_records'))
					,OUTPUT(reports.ErrorCount, named('Error_Count'))
					,MoveToTempOrReject
					,out_NCF_reports
					,IF(NOT ExcessiveInvalidRecordsFound, queueFileForProcessing)
					,despray_NCF_reports('ncx2')
					,despray_NCF_reports('ncd2')
					,despray_NCF_reports('ncr2')
					,IF(IsEmptyFile, NAC_V2.Send_Email(fn := ilfn, groupid := lfn[6..9]).FileEmptyErrorAlert, 
							NAC_V2.Send_Email(fn := ilfn, groupid := lfn[6..9]).FileValidationReport)
					);
	return doit;
END;



