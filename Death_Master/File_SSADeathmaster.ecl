IMPORT Data_Services,ut;
vSSARawFileName	:=	Data_Services.Data_location.prefix('Death')+'thor_data400::in::ssa_deathm_raw';

EXPORT File_SSADeathmaster	:=	IF(NOTHOR(FileServices.GetSuperFileSubCount(vSSARawFileName) <> 0),
																DATASET(vSSARawFileName,Layout_SSADeathMaster,flat));
