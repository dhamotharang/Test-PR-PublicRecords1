// updated for NAC2
import _Control,tools,STD;

EXPORT SprayAndQualifyInput(string version, string ip, string rootDirm, string lfn) := function

ready    := rootDir+'ready/';
done     := rootDir+'done/';
err      := rootDir+'error/';
spraying := rootDir+'spraying/';

dsFileList := STD.File.RemoteDirectory(ip, ready, '*.dat');
fname := dsFileList[1].Name : independent;
//fNCM := regexreplace('ncf2',fname,'NCM',nocase):independent;
fNCX := regexreplace('ncf2',fname,'ncx2',nocase):independent;
fNCD := regexreplace('ncf2',fname,'ncd2',nocase):independent;
fNCR := regexreplace('ncf2',fname,'ncr2',nocase):independent;
UpSt:=stringlib.stringtouppercase(fname[1..2]);
rSize:=sizeof(Layouts.load);

MoveReadyToSpraying := STD.File.MoveExternalFile(IP, ready+fname, spraying+fname);
MoveReadyToError    := nothor(STD.File.MoveExternalFile(IP, ready+fname,err+fname));
MoveSprayingToError := nothor(STD.File.MoveExternalFile(IP, spraying+fname,err+fname));
MoveSprayingToDone  := nothor(STD.File.MoveExternalFile(IP, spraying+fname,done+fname));

FileFound := exists(dsFileList);
ReportFileFound:=if(FileFound
					,output(fname,named('Found_File_To_Spray'))
					,output('No File To Spray',named('No_File_To_Spray'))
					);

IsEmptyFile := dsFileList[1].size = 0;
ReportEmptyFile:=if(IsEmptyFile
					,output('File '+ip+ready+fname+' empty',named('File_empty'))
					,output('File '+ip+ready+fname+' has content',named('File_not_empty'))
					);

dRaw := dataset('~nac::uber::in::'+fname+'_temp',{string FullRecord},csv(terminator(['\r\n', '\n']), separator([]), quote([]), notrim));

ilfn := '~nac::uber::in::'+fname;

SprayIt := sequential(
						output('Spraying: '+ ip + spraying + fname + ' -> ' + '~nac::uber::in::'+fname)
						,nothor(STD.File.SprayVariable(
							 IP
							,spraying + fname
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

d := dataset('~nac::uber::in::'+fname+'_temp',{string FullRecord},csv(terminator(['\r\n', '\n']), separator([]), quote([]), notrim));
Layouts.load t(d l) := transform
	string4096 lString   := l.FullRecord;
	Layouts.load lRecord := transfer(lString, Layouts.load);
	self                 := lRecord;
end;
p := project(d,t(left));
PatchIt:=output(p,,'~nac::in::'+fname,compressed);
DeleteTemp:=nothor(STD.File.DeleteLogicalFile('~nac::in::'+fname+'_temp'));

treshld_  := $.Mod_Sets.threshld;
FileStats := Mod_stats.ValidateInputFields(fname).ValidationResults;

err_rate := $.PreprocessNCF2File(ilfn);
//ExcessiveInvalidRecordsFound := err_rate > treshld_;
ExcessiveInvalidRecordsFound := false;
QualifyIt := if(ExcessiveInvalidRecordsFound
					,output('File '+fname+' contains excesive errors.  File will be rejected',named('File_content_rejected'))
					,output('File '+fname+' content accepted',named('File_content_accepted'))
					);


sfn:=if(ExcessiveInvalidRecordsFound
							,'~nac::uber::in:::rejected'
							,'~nac::uber::in:::pending');
							
MoveToTempOrReject:=sequential(
															if(ExcessiveInvalidRecordsFound
																,MoveSprayingToError
																,if(FileFound and IsEmptyFile
																	,MoveReadyToError
																	,MoveSprayingToDone))
															,Std.File.AddSuperfile(sfn,ilfn)
															,output('Moved: ' + ilfn + '+sfn')
															);

/*
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
*/
despray_NCF_reports(string rep):=function
	fn := regexreplace('ncf2',ilfn,rep,nocase);
	//pThorFilename:='~nac::out::'+fn;
	pDestinationFile:= rootDir + STD.Str.ToLowerCase(trim(rep)) + '/' + trim(fn);
	return fileservices.Despray(fn,ip,pDestinationFile,,,,TRUE);
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
						):failure($.Send_Email(st:=UpSt,fn:=fname).NAC_Input_Prep_failure)
						;

	return outputwork;

end;