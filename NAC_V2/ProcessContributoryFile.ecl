import _Control,tools,STD;

ModifyFileName(string ilfn, string rpt) := Std.Str.FindReplace(ilfn, 'ncf2', rpt);
ExtractFileName(string ilfn) := Std.Str.SplitWords(ilfn, '::')[4];

GetErrorRate(integer total, string lfn) := FUNCTION
		errs := dataset(lfn, $.ValidationCodes, rError);
		



EXPORT ProcessContributoryFile(string version, string ip, string rootDir, string lfn) := function

		ready    := rootDir+'ready/';
		done     := rootDir+'done/';
		err      := rootDir+'error/';
		spraying := rootDir+'spraying/';
		
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
				

		
		doit := sequential(
											MoveReadyToSpraying
											,SprayIt										
											,OUTPUT(processed,,ModifyFileName(ilfn, 'xxx2'), COMPRESSED, OVERWRITE)
											//,Std.File.AddSuperFile('~nac::uber::in::pending', ModifyFileName(ilfn, 'xxx2')
											//,OUTPUT(err_rate, named('err_rate'))
											//,MoveToTempOrReject/
											,$.Send_Email(st := lfn[6..7], fn := lfn).FileValidationReport
											//,DeleteTemp
											//,if(IsEmptyFile,$.Send_Email(st := UpSt,fn:=fname).FileEmptyErrorAlert)
											//,out_NCF_reports
											//,despray_NCF_reports('ncx2')
											//,despray_NCF_reports('ncd2')
											//,despray_NCF_reports('ncr2')

						);
						//: $.Send_Email(st := lfn[6..7], fn := lfn).FileErrorAlert);


	return doit;
END;