// updated for NAC2
import _Control,tools,STD;

EXPORT SprayAndQualifyInput(string version,string ip,string rootDir) := function

ready    := rootDir+'ready/';
done     := rootDir+'done/';
err      := rootDir+'error/';
spraying := rootDir+'spraying/';

dsFileList := nothor(STD.File.RemoteDirectory(ip, ready, '*.dat')):independent;
fname := dsFileList[1].Name:independent;
fNCM:=regexreplace('NCF',fname,'NCM',nocase):independent;
fNCD:=regexreplace('NCF',fname,'NCD',nocase):independent;
fNCR:=regexreplace('NCF',fname,'NCR',nocase):independent;
UpSt:=stringlib.stringtouppercase(fname[1..2]);
rSize:=sizeof(Layouts.load);

MoveReadyToSpraying := nothor(STD.File.MoveExternalFile(IP,ready+fname,spraying+fname));
MoveReadyToError    := nothor(STD.File.MoveExternalFile(IP,ready+fname,err+fname));
MoveSprayingToError := nothor(STD.File.MoveExternalFile(IP,spraying+fname,err+fname));
MoveSprayingToDone  := nothor(STD.File.MoveExternalFile(IP,spraying+fname,done+fname));

FileFound:=exists(dsFileList);
ReportFileFound:=if(FileFound
					,output(fname,named('Found_File_To_Spray'))
					,output('No File To Spray',named('No_File_To_Spray'))
					);

IsEmptyFile:=dsFileList[1].size = 0;
ReportEmptyFile:=if(IsEmptyFile
					,output('File '+ip+ready+fname+' empty',named('File_empty'))
					,output('File '+ip+ready+fname+' has content',named('File_not_empty'))
					);

dRaw := dataset('~nac::uber::in::'+fname+'_temp',{string FullRecord},csv(terminator(['\r\n', '\n']), separator([]), quote([]), notrim));
rMax := max(dRaw,length(FullRecord)):independent;
isValidRecordLength:=rMax < rSize + 5 and dsFileList[1].size > 0;
ReportisValidRecordLength:=if(isValidRecordLength
					,output(ip+ready+fname+' file size '+dsFileList[1].size+' is valid',named('Valid_File_Size'))
					,output(ip+ready+fname+' file size '+dsFileList[1].size+' is not divisible by '+rSize,named('Invalid_File_Size'))
					);

SprayIt := sequential(
						output('Spraying: '+ ip + spraying + fname + ' -> ' + '~nac::uber::in::'+fname)
						,nothor(STD.File.SprayVariable(
							 IP
							,spraying + fname
							,,,,
							,if(_Control.ThisEnvironment.Name='Dataland','thor40_241','thor400_30')
							,'~nac::uber::in::'+fname+'_temp'
							,
							,
							,
							,true
							,true
							,true
							))
						);

d := dataset('~nac::uber::in::'+fname+'_temp',{string FullRecord},csv(terminator(['\r\n', '\n']), separator([]), quote([]), notrim));
Layouts.load t(d l) := transform
	string4096 lString   := l.FullRecord;
	Layouts.load lRecord := transfer(lString, Layouts.load);
	self                 := lRecord;
end;
p := project(d,t(left));
PatchIt:=output(p,,'~nac::in::'+fname,compressed);
DeleteTemp:=nothor(STD.File.DeleteLogicalFile('~nac::in::'+fname+'_temp'));

treshld_  := Mod_Sets.threshld;
FileStats := Mod_stats.ValidateInputFields(fname).ValidationResults;
ExcessiveInvalidRecordsFound:=exists(FileStats(err[1]='E',err_cnt/RecordsTotal>treshld_));
QualifyIt:=if(ExcessiveInvalidRecordsFound
					,output('File '+fname+' contains excesive errors.  File will be rejected',named('File_content_rejected'))
					,output('File '+fname+' content accepted',named('File_content_accepted'))
					);

sfn:=if(ExcessiveInvalidRecordsFound or ~isValidRecordLength
							,'~nac::in::'+UpSt+'::rejected'
							,'~nac::in::'+UpSt+'::temp');
MoveToTempOrReject:=sequential(
															if(ExcessiveInvalidRecordsFound or ~isValidRecordLength
																,MoveSprayingToError
																,if(FileFound and IsEmptyFile
																	,MoveReadyToError
																	,MoveSprayingToDone))
															,fileservices.AddSuperfile(sfn,'~nac::in::'+fname)
															,output('Moved: nac::in::'+fname +' to -> '+sfn)
															);


out_NCF_reports:=	sequential(
											FileServices.StartSuperFileTransaction()
											,FileServices.ClearSuperFile('~nac::out::ncm_father',true)
											,FileServices.AddSuperFile('~nac::out::ncm_father','~nac::out::ncm',,true)
											,FileServices.FinishSuperFileTransaction()
											,FileServices.ClearSuperFile('~nac::out::ncm')
											,NAC_V2.Mod_NCD(fname).ProcOutputNCMFile
											,FileServices.AddSuperFile('~nac::out::ncm','~nac::out::'+fNCM)

											,FileServices.StartSuperFileTransaction()
											,FileServices.ClearSuperFile('~nac::out::ncd_father',true)
											,FileServices.AddSuperFile('~nac::out::ncd_father','~nac::out::ncd',,true)
											,FileServices.FinishSuperFileTransaction()
											,FileServices.ClearSuperFile('~nac::out::ncd')
											,NAC_V2.Mod_NCD(fname).ProcOutputNCDFile
											,FileServices.AddSuperFile('~nac::out::ncd','~nac::out::'+fNCD)

											,FileServices.StartSuperFileTransaction()
											,FileServices.ClearSuperFile('~nac::out::ncr_father',true)
											,FileServices.AddSuperFile('~nac::out::ncr_father','~nac::out::ncr',,true)
											,FileServices.FinishSuperFileTransaction()
											,FileServices.ClearSuperFile('~nac::out::ncr')
											,output(NAC_V2.InputFileValidationReport(fname).NCR,,'~nac::out::'+fNCR,compressed)
											,FileServices.AddSuperFile('~nac::out::ncr','~nac::out::'+fNCR)
											);

despray_NCF_reports(string rep):=function
	fn:=regexreplace('ncf',fname,rep,nocase);
	pThorFilename:='~nac::out::'+fn;
	pDestinationFile:= rootDir + STD.Str.ToLowerCase(trim(rep)) + '/' + trim(fn);
	return fileservices.Despray(pThorFilename,ip,pDestinationFile,,,,TRUE);
end;


outputwork
			:=
				if(fname=''
						,output('No new contributory files to process')
						,sequential(
											ReportFileFound
											,ReportEmptyFile
											,if(FileFound
														,sequential(
																			MoveReadyToSpraying
																			,SprayIt
																			,ReportisValidRecordLength
																			,PatchIt
																			,QualifyIt
																			,MoveToTempOrReject
																			,Send_Email(st:=UpSt,fn:=fname).FileValidationReport
																			,DeleteTemp
																			,if(IsEmptyFile,Send_Email(st := UpSt,fn:=fname).FileEmptyErrorAlert)
																			,out_NCF_reports
																			,despray_NCF_reports('ncx2')
																			,despray_NCF_reports('ncd2')
																			,despray_NCF_reports('ncr2')
																			)
														,Send_Email(st:=UpSt,fn:=fname).FileErrorAlert)
											)
						):failure(Send_Email(st:=UpSt,fn:=fname).NAC_Input_Prep_failure)
						;

	return outputwork;

end;