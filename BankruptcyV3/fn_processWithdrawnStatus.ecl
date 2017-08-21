IMPORT	BankruptcyV3, VersionControl,	STD;
EXPORT	fn_processWithdrawnStatus(STRING	pVersion)	:=	MODULE

	//	Transform Input file into Base file layout
	SHARED	Layout_BankruptcyV3_WithdrawnStatus.wsBase	tWithdrawnStatus(Layout_BankruptcyV3_WithdrawnStatus.wsVirtual	pInput)	:=	TRANSFORM
						fmtsin := [
							'%Y/%m/%d',
							'%Y-%m-%d'
						];
						fmtout	:=	'%Y%m%d';
						SELF.OriginalWithdrawnDate	:=	pInput.WithdrawnDate;
						SELF.WithdrawnDate					:=	IF(SELF.OriginalWithdrawnDate<>'',Std.date.ConvertDateFormatMultiple(SELF.OriginalWithdrawnDate,fmtsin,fmtout),'');
						SELF.OriginalWithdrawnDispositionDate	:=	pInput.WithdrawnDispositionDate;
						SELF.WithdrawnDispositionDate					:=	IF(SELF.OriginalWithdrawnDispositionDate<>'',Std.date.ConvertDateFormatMultiple(SELF.OriginalWithdrawnDispositionDate,fmtsin,fmtout),'');
						SELF												:=	pInput;
					END;
					
	EXPORT	dWithdrawnStatus							:=	PROJECT(File_BankruptcyV3_WithdrawnStatus().wsVirtual,tWithdrawnStatus(LEFT));
	EXPORT	dConsolidateWithdrawnStatus		:=	File_BankruptcyV3_WithdrawnStatus().wsBase;

	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.WithdrawnStatus.new	,dWithdrawnStatus							,Build_WithdrawnStatus_File				,TRUE);
	VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.WithdrawnStatus.new	,dConsolidateWithdrawnStatus	,Consolidate_WithdrawnStatus_File	,TRUE);

	EXPORT	build_withdrawnstatus	:=
		SEQUENTIAL(
			IF(NOTHOR(STD.File.GetSuperFileSubCount(Filenames(pVersion).Input.WithdrawnStatus.Sprayed))>0,
				//	If we have an input file then process and add to Superfile
				SEQUENTIAL(
					Promote(pVersion).inputfiles.Sprayed2Using
					,Build_WithdrawnStatus_File
					,Promote(pVersion).Inputfiles.Using2Used
					,Promote(pVersion, 'base',pIsDeltaBuild:=TRUE).buildfiles.New2Built
					,Promote(pVersion, 'base',pIsDeltaBuild:=TRUE).buildfiles.Built2QA	
				),
				//	If there's no input file then consolidate base file into one logical file
				SEQUENTIAL(
					Consolidate_WithdrawnStatus_File
					,Promote(pVersion, 'base',pIsDeltaBuild:=FALSE).buildfiles.New2Built
					,Promote(pVersion, 'base',pIsDeltaBuild:=FALSE).buildfiles.Built2QA	
				)
			)
		);

	EXPORT	ALL	:=
		IF(VersionControl.IsValidVersion(pVersion)
			,build_withdrawnstatus
			,output('No Valid version parameter passed, skipping BankruptcyV3.fn_processWithdrawnStatus().All attribute')
		);
END;