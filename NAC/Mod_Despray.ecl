import ut,header,STD;
EXPORT Mod_Despray(string version,string ip,string rootDir) := module

	NAC.Layouts.MSH tr(NAC.Layouts.Collisions l, integer c):=transform
		self.ActivityType:=intformat((integer)l.ActivityType,1,1);
		self.MRFRecordNumber:=intformat((integer)0,10,1);
		self.SearchSSN:=intformat((integer)l.SearchSSN,9,1);
		self.SearchDOB:=intformat((integer)l.SearchDOB,8,1);
		self.SearchBenefitMonth:=intformat((integer)l.SearchBenefitMonth,6,1);
		self.SearchAddress1Zip:=intformat((integer)l.SearchAddress1Zip,9,1);
		self.SearchAddress2Zip:=intformat((integer)l.SearchAddress2Zip,9,1);
		self.CaseBenefitMonth:=intformat((integer)l.CaseBenefitMonth,6,1);
		self.CasePhone1:=intformat((integer)l.CasePhone1,10,1);
		self.CasePhone2:=intformat((integer)l.CasePhone2,10,1);
		self.CasePhysicalZip:=intformat((integer)l.CasePhysicalZip,9,1);
		self.CaseMailZip:=intformat((integer)l.CaseMailZip,9,1);
		self.ClientDOB:=intformat((integer)l.ClientDOB,8,1);
		self.ClientEligibilityDate:=intformat((integer)l.ClientEligibilityDate,8,1);
		self.ClientPhone:=intformat((integer)l.ClientPhone,10,1);
		self.StateContactPhone:=intformat((integer)l.StateContactPhone,10,1);
		self.LexIdScore:=intformat((integer)l.LexIdScore,3,1);
		self.SequenceNumber:=intformat(c,4,1);
		self:=l;
		self:=[];
	end;

	suffix:=version[1..8]+'_'+workunit[11..16]+'.dat';
	dbcFname:='~nac::out::xx_dbc_'+suffix;
	drqFname:='~nac::out::xx_drq_'+suffix;
	curr_month:=version[1..6];
	
fn_out_st_files(string st):=function

	sfn:='~nac::out::'+map(st='dbc'=>'dbc', st='drq'=>'drq', 'msh');
	mshFname:='~nac::out::'+st+'_msh_'+suffix;
	drqFile:=Files().Base(  header.convertyyyymmtonumberofmonths((integer)curr_month)
												- header.convertyyyymmtonumberofmonths((integer)case_benefit_month) < 3 );

	return sequential(
							map(
									st='dbc' =>output(project(dataset('~nac::out::collisions_'+version,Layouts.Collisions,flat)
																						,transform(NAC.Layouts.DBC
																							,self:=left
																							,Self.SequenceNumber:=intformat(counter,4,1)
																							))
																			,,dbcFname,compressed)
									,st='drq' =>output(project(drqFile,Layouts.load)
																			,,drqFname,compressed)
									,output(project(Files().Collisions(
																				BenefitState=STD.Str.ToUpperCase(st)
																				,SearchBenefitMonth=curr_month)
																				,tr(left,counter))
																			,,mshFname,compressed)
									)
							,FileServices.AddSuperFile(sfn,map(st='dbc'=>dbcFname, st='drq'=>drqFname, mshFname))
							);
end;

out_state_files:=	sequential(
											FileServices.StartSuperFileTransaction()
											,FileServices.ClearSuperFile('~nac::out::msh_father',true)
											,FileServices.AddSuperFile('~nac::out::msh_father','~nac::out::msh',,true)
											,FileServices.FinishSuperFileTransaction()
											,FileServices.ClearSuperFile('~nac::out::msh')
											,fn_out_st_files('al')
											,fn_out_st_files('fl')
											,fn_out_st_files('ga')
											,fn_out_st_files('la')
											,fn_out_st_files('ms')
											,FileServices.StartSuperFileTransaction()
											,FileServices.ClearSuperFile('~nac::out::dbc_father',true)
											,FileServices.AddSuperFile('~nac::out::dbc_father','~nac::out::dbc',,true)
											,FileServices.FinishSuperFileTransaction()
											,FileServices.ClearSuperFile('~nac::out::dbc')
											,fn_out_st_files('dbc')
											,FileServices.StartSuperFileTransaction()
											,FileServices.ClearSuperFile('~nac::out::drq_father',true)
											,FileServices.AddSuperFile('~nac::out::drq_father','~nac::out::drq',,true)
											,FileServices.FinishSuperFileTransaction()
											,FileServices.ClearSuperFile('~nac::out::drq')
											,fn_out_st_files('drq')
											);

despray(string st):=function
	prefix:=STD.Str.ToUpperCase(map(st='dbc' => 'xx_dbc_'
																,st='drq' => 'xx_drq_'
																,st+'_msh_'));
	dir:=map(st='dbc' => 'test/dbc1/'
					,st='drq' => 'drq/'
					,'msh/');
	fname:=prefix + suffix;
	pThorFilename:='~nac::out::'+fname;
	pDestinationFile:= rootDir + trim(dir) + trim(fname);
	return fileservices.Despray(pThorFilename,ip,pDestinationFile,,,,TRUE);
end;

export Odespray:=sequential(out_state_files
														,parallel(
																		// despray('al')
																		// ,despray('fl')
																		// ,despray('ga')
																		// ,despray('la')
																		// ,despray('ms')
																		despray('dbc')
																		,despray('drq')
																		)
														);

end;