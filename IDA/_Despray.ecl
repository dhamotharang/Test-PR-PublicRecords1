import std,versioncontrol;

EXPORT _Despray(string pversion='', boolean pUseProd=FALSE) := function

version:=if(pversion='',IDA._Constants(pUseProd).filesdate,pversion);

DailyBase:=IDA.Files().Basedaily.Built;

DesprayTable:=TABLE(DailyBase,{did,clientassigneduniquerecordid,orig_filecategory});

DesprayOut:=OUTPUT(DesprayTable,,'~thor_data400::out::ida::'+version+'::LEXID_APPEND',CSV(HEADING(SINGLE),SEPARATOR('|')),COMPRESSED);

Prommote := SEQUENTIAL(STD.File.StartSuperFileTransaction()
                       ,STD.File.PromoteSuperFileList(['~thor_data400::out::ida::despray::built'],'~thor_data400::out::ida::'+version+'::LEXID_APPEND')
	              	   ,STD.File.ClearSuperfile(TRIM(IDA.Filenames(version,pUseProd).lDesprayTemplate_qa))
	 				   ,STD.File.addsuperfile(TRIM(IDA.Filenames(version,pUseProd).lDesprayTemplate_qa),TRIM(IDA.Filenames(version,pUseProd).lDesprayTemplate_built),,TRUE)
					   ,STD.File.ClearSuperfile(TRIM(IDA.Filenames(version,pUseProd).lDesprayTemplate_father))
					   ,STD.File.addsuperfile(TRIM(IDA.Filenames(version,pUseProd).lDesprayTemplate_father),TRIM(IDA.Filenames(version,pUseProd).lDesprayTemplate_qa),,TRUE)
					   ,STD.File.ClearSuperfile(TRIM(IDA.Filenames(version,pUseProd).lDesprayTemplate_delete),true)
					   ,STD.File.addsuperfile(TRIM(IDA.Filenames(version,pUseProd).lDesprayTemplate_delete),TRIM(IDA.Filenames(version,pUseProd).lDesprayTemplate_father),,TRUE)	
   					   ,STD.File.FinishSuperFileTransaction());	
							
return SEQUENTIAL(DesprayOut,Prommote);

end;