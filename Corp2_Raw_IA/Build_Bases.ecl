IMPORT tools, ut;

EXPORT Build_Bases(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_IA.Layouts.crpAddLayoutIn)		pIncrpAdd 	= Corp2_Raw_IA.Files(pfiledate,puseprod).Input.crpAdd.logical,
	DATASET(Corp2_Raw_IA.Layouts.crpAddLayoutBase)	pBasecrpAdd	= IF(Corp2_Raw_IA._Flags.Base.crpAdd, Corp2_Raw_IA.Files(,pUseOtherEnvironment := FALSE).Base.crpAdd.qa, DATASET([], Corp2_Raw_IA.Layouts.crpAddLayoutBase)),
	DATASET(Corp2_Raw_IA.Layouts.crpAgtLayoutIn)		pIncrpAgt  	= Corp2_Raw_IA.Files(pfiledate,puseprod).Input.crpAgt.logical,
	DATASET(Corp2_Raw_IA.Layouts.crpAgtLayoutBase)	pBasecrpAgt	= IF(Corp2_Raw_IA._Flags.Base.crpAgt, Corp2_Raw_IA.Files(,pUseOtherEnvironment := FALSE).Base.crpAgt.qa, DATASET([], Corp2_Raw_IA.Layouts.crpAgtLayoutBase)),
	DATASET(Corp2_Raw_IA.Layouts.crpDesLayoutIn)		pIncrpDes   = Corp2_Raw_IA.Files(pfiledate,puseprod).Input.crpDes.logical,
	DATASET(Corp2_Raw_IA.Layouts.crpDesLayoutBase)	pBasecrpDes = IF(Corp2_Raw_IA._Flags.Base.crpDes, Corp2_Raw_IA.Files(,pUseOtherEnvironment := FALSE).Base.crpDes.qa, DATASET([], Corp2_Raw_IA.Layouts.crpDesLayoutBase)),
	DATASET(Corp2_Raw_IA.Layouts.crpFilLayoutIn)		pIncrpFil   = Corp2_Raw_IA.Files(pfiledate,puseprod).Input.crpFil.logical,
	DATASET(Corp2_Raw_IA.Layouts.crpFilLayoutBase)	pBasecrpFil	= IF(Corp2_Raw_IA._Flags.Base.crpFil, Corp2_Raw_IA.Files(,pUseOtherEnvironment := FALSE).Base.crpFil.qa, DATASET([], Corp2_Raw_IA.Layouts.crpFilLayoutBase)),
  DATASET(Corp2_Raw_IA.Layouts.crpHisLayoutIn)		pIncrpHis   = Corp2_Raw_IA.Files(pfiledate,puseprod).Input.crpHis.logical,
	DATASET(Corp2_Raw_IA.Layouts.crpHisLayoutBase)	pBasecrpHis	= IF(Corp2_Raw_IA._Flags.Base.crpHis, Corp2_Raw_IA.Files(,pUseOtherEnvironment := FALSE).Base.crpHis.qa, DATASET([], Corp2_Raw_IA.Layouts.crpHisLayoutBase)),
	DATASET(Corp2_Raw_IA.Layouts.crpNamLayoutIn)		pIncrpNam   = Corp2_Raw_IA.Files(pfiledate,puseprod).Input.crpNam.logical,
	DATASET(Corp2_Raw_IA.Layouts.crpNamLayoutBase)	pBasecrpNam	= IF(Corp2_Raw_IA._Flags.Base.crpNam, Corp2_Raw_IA.Files(,pUseOtherEnvironment := FALSE).Base.crpNam.qa, DATASET([], Corp2_Raw_IA.Layouts.crpNamLayoutBase)),
	DATASET(Corp2_Raw_IA.Layouts.crpOffLayoutIn)		pIncrpOff   = Corp2_Raw_IA.Files(pfiledate,puseprod).Input.crpOff.logical,
	DATASET(Corp2_Raw_IA.Layouts.crpOffLayoutBase)	pBasecrpOff	= IF(Corp2_Raw_IA._Flags.Base.crpOff, Corp2_Raw_IA.Files(,pUseOtherEnvironment := FALSE).Base.crpOff.qa, DATASET([], Corp2_Raw_IA.Layouts.crpOffLayoutBase)),
	DATASET(Corp2_Raw_IA.Layouts.crpPrtLayoutIn)		pIncrpPrt   = Corp2_Raw_IA.Files(pfiledate,puseprod).Input.crpPrt.logical,
	DATASET(Corp2_Raw_IA.Layouts.crpPrtLayoutBase)	pBasecrpPrt	= IF(Corp2_Raw_IA._Flags.Base.crpPrt, Corp2_Raw_IA.Files(,pUseOtherEnvironment := FALSE).Base.crpPrt.qa, DATASET([], Corp2_Raw_IA.Layouts.crpPrtLayoutBase)),
	DATASET(Corp2_Raw_IA.Layouts.crpRemLayoutIn)		pIncrpRem   = Corp2_Raw_IA.Files(pfiledate,puseprod).Input.crpRem.logical,
	DATASET(Corp2_Raw_IA.Layouts.crpRemLayoutBase)	pBasecrpRem	= IF(Corp2_Raw_IA._Flags.Base.crpRem, Corp2_Raw_IA.Files(,pUseOtherEnvironment := FALSE).Base.crpRem.qa, DATASET([], Corp2_Raw_IA.Layouts.crpRemLayoutBase)),
	DATASET(Corp2_Raw_IA.Layouts.crpStkLayoutIn)		pIncrpStk   = Corp2_Raw_IA.Files(pfiledate,puseprod).Input.crpStk.logical,
	DATASET(Corp2_Raw_IA.Layouts.crpStkLayoutBase)	pBasecrpStk	= IF(Corp2_Raw_IA._Flags.Base.crpStk, Corp2_Raw_IA.Files(,pUseOtherEnvironment := FALSE).Base.crpStk.qa, DATASET([], Corp2_Raw_IA.Layouts.crpStkLayoutBase))
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_IA.Build_Bases_crpAdd(pfiledate,pversion,puseprod,pIncrpAdd,pBasecrpAdd).ALL,
																		Corp2_Raw_IA.Build_Bases_crpAgt(pfiledate,pversion,puseprod,pIncrpAgt,pBasecrpAgt).ALL,
																		Corp2_Raw_IA.Build_Bases_crpDes(pfiledate,pversion,puseprod,pIncrpDes,pBasecrpDes).ALL,
																		Corp2_Raw_IA.Build_Bases_crpFil(pfiledate,pversion,puseprod,pIncrpFil,pBasecrpFil).ALL,
																		Corp2_Raw_IA.Build_Bases_crpHis(pfiledate,pversion,puseprod,pIncrpHis,pBasecrpHis).ALL,
																		Corp2_Raw_IA.Build_Bases_crpNam(pfiledate,pversion,puseprod,pIncrpNam,pBasecrpNam).ALL,
																		Corp2_Raw_IA.Build_Bases_crpOff(pfiledate,pversion,puseprod,pIncrpOff,pBasecrpOff).ALL,	
																		Corp2_Raw_IA.Build_Bases_crpPrt(pfiledate,pversion,puseprod,pIncrpPrt,pBasecrpPrt).ALL,
																		Corp2_Raw_IA.Build_Bases_crpRem(pfiledate,pversion,puseprod,pIncrpRem,pBasecrpRem).ALL,	
																		Corp2_Raw_IA.Build_Bases_crpStk(pfiledate,pversion,puseprod,pIncrpStk,pBasecrpStk).ALL,
																		Promote(pversion).BuildFiles.New2Built,
																		Promote().BuildFiles.Built2QA
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_IA.Build_Bases attribute')
									 );

END;
