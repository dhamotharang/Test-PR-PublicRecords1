import _Control,tools,STD;

ModifyFileName(string ilfn, string rpt) := Std.Str.FindReplace(ilfn, 'ncf2', rpt);
ExtractFileName(string ilfn) := Std.Str.SplitWords(ilfn, '::')[4];


EXPORT ProcessContributoryFile(string version, string ip, string rootDir, string lfn) := function

		ready    := rootDir+'ready/';
		done     := rootDir+'done/';
		err      := rootDir+'error/';
		spraying := rootDir+'spraying/';
		outgoing := rootDir+'outgoing/';
		
		ilfn := '~nac::uber::in::'+lfn;

		MoveReadyToSpraying := STD.File.MoveExternalFile(IP, ready+lfn, spraying+lfn);
		MoveReadyToError    := nothor(STD.File.MoveExternalFile(IP, ready+lfn, err+lfn));
		MoveSprayingToError := nothor(STD.File.MoveExternalFile(IP, spraying+lfn, err+lfn));
		MoveSprayingToDone  := nothor(STD.File.MoveExternalFile(IP, spraying+lfn, done+lfn));
		
		SprayIt := sequential(
						output('Spraying: '+ ip + spraying + lfn + ' -> ' + '~nac::uber::in::'+lfn)
						,nothor(STD.File.SprayVariable(
							 IP
							,spraying + lfn
							,,,,
							,if(_Control.ThisEnvironment.Name='Dataland','thor400_dev01','thor400_36_02')
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
				
		reports := $.GetReports(ModifyFileName(ilfn, 'xxx2'));
		err_rate := reports.ErrorCount/reports.TotalRecords;
		ExcessiveInvalidRecordsFound :=	err_rate	> treshld_;
		
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
		
		doit := sequential(
											MoveReadyToSpraying
											,SprayIt										
											,OUTPUT(processed,,ModifyFileName(ilfn, 'xxx2'), COMPRESSED, OVERWRITE)
											,OUTPUT(reports.TotalRecords, named('total_records'))
											,OUTPUT(reports.ErrorCount, named('Error_Count'))
											//,Std.File.AddSuperFile('~nac::uber::in::pending', ModifyFileName(ilfn, 'xxx2')
											//,OUTPUT(err_rate, named('err_rate'))
											,MoveToTempOrReject
											,out_NCF_reports
											,$.Send_Email(st := lfn[6..7], fn := ModifyFileName(ilfn, 'ncr2')).FileValidationReport
											,despray_NCF_reports('ncx2')
											,despray_NCF_reports('ncd2')
											,despray_NCF_reports('ncr2')

						);
						//: $.Send_Email(st := lfn[6..7], fn := lfn).FileErrorAlert);


	return doit;
END;