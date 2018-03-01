IMPORT tools,STD, FraudGovPlatform_Validation, FraudShared, ut, NAC, lib_FileServices,_Control;
EXPORT Build_Input_NAC(
	string pversion,
	string ip = NAC.Constants.LandingZoneServer,
	string rootDir = NAC.Constants.LandingZonePathBase + '/msh/done/', 
	string destinationGroup = if(_Control.ThisEnvironment.Name='Dataland','thor400_dev01_2','thor400_30')	 
) :=
module
	

	SHARED fn_dedup(inputs):=FUNCTIONMACRO
		in_srt:=sort(inputs, RECORD, ProcessDate, FileName, -FileDate , -FileTime,LOCAL);
		in_ddp:=rollup(in_srt,
								TRANSFORM(Layouts.Input.NAC,SELF := LEFT; SELF := []),
								RECORD,
								EXCEPT ProcessDate, FileName, FileDate , FileTime,
								LOCAL);	
		return in_ddp;
	ENDMACRO;	
	
	dsFileList:=nothor(FileServices.RemoteDirectory(ip, rootDir, 'FL_MSH_' + pversion + '*.dat')):independent;

	dsFileListSorted := sort(dsFileList,modified);
	fname	:=dsFileListSorted[1].Name:independent;

	FileSprayed := Filenames().Sprayed.FileSprayed+'::'+ fname;
	NAC_Sprayed := Filenames().Sprayed.NAC;

	SprayIt:= sequential(
							output('Spraying: '+ ip + rootDir + fname + ' -> ' + FileSprayed) ,
							lib_FileServices.fileservices.SprayFixed(	
							sourceIP								:=	ip,
							sourcePath							:= rootDir + fname,
							recordSize							:=	sizeof(NAC.Layouts.MSH),
							destinationGroup					:=	destinationGroup,
							destinationLogicalName			:=	FileSprayed,
							compress								:=	true),
							fileservices.AddSuperfile(NAC_Sprayed,FileSprayed));	
	

	Sprayed_NAC := Files(pversion).Sprayed.NAC;
	
	Layouts.Input.NAC tr(Sprayed_NAC l) := transform
		sub:=stringlib.stringfind(fname,'20',1);
		sub2:=stringlib.stringfind(fname,'.dat',1)-6;
		FileDate := (unsigned)l.fn[sub..sub+7];
		FileTime := ut.CleanSpacesAndUpper(fname[sub2..sub2+5]);
		self.FileName := fname;
		self.ProcessDate := (unsigned)pversion;
		self.FileDate := FileDate;
		self.FileTime :=FileTime;
		self:=l;
		self:=[];
	end;

	f1_valid:=project(Sprayed_NAC,tr(left));

	f1_dedup:=fn_dedup(files().Input.NAC.sprayed + f1_valid );

	Build_Input_File :=  OUTPUT(f1_dedup,,Filenames().Input.NAC.New(pversion),CSV(separator(['~|~']),quote(''),terminator('~<EOL>~')), COMPRESSED);							

	Promote_Input_File := 
		sequential(
			 STD.File.StartSuperFileTransaction()
			 //Promote Input Records
			,STD.File.ClearSuperFile(Filenames().Input.NAC.Used, TRUE)
			,STD.File.AddSuperfile(
				 Filenames().Input.NAC.Sprayed
				,Filenames().Input.NAC.Used
				,addcontents := true
			)
			,STD.File.ClearSuperFile(Filenames().Input.NAC.Sprayed)
			,STD.File.AddSuperfile(
				 Filenames().Input.NAC.Sprayed
				,Filenames().Input.NAC.New(pversion)
			)
			//Clear Individual Sprayed Files
			,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._NACPassed, TRUE)
			// ,STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._NACRejected, TRUE)
			,STD.File.FinishSuperFileTransaction()	
		);
// Return
	export build_prepped := 
			 sequential(
				 SprayIt
				,Build_Input_File
				,Promote_Input_File
			);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,build_prepped
		,output('No Valid version parameter passed, skipping Build_Input_NAC atribute')
	);

end;


