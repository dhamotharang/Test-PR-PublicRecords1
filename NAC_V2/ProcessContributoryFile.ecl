import _Control,tools,STD;

EXPORT ProcessContributoryFile(string version, string ip, string rootDir, string lfn) := function



		doit := sequential(
											MoveReadyToSpraying
											,SprayIt										
											,QualifyIt
											,OUTPUT(err_rate, named('err_rate'))
											,MoveToTempOrReject
											,$.Send_Email(st:=UpSt,fn:=fname).FileValidationReport
											//,DeleteTemp
											//,if(IsEmptyFile,$.Send_Email(st := UpSt,fn:=fname).FileEmptyErrorAlert)
											//,out_NCF_reports
											//,despray_NCF_reports('ncx2')
											//,despray_NCF_reports('ncd2')
											//,despray_NCF_reports('ncr2')

											)
						,$.Send_Email(st:=UpSt,fn:=fname).FileErrorAlert)
			)


	return doit;
END;