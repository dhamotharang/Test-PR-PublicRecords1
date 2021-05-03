import Data_Services;
import VehLic;

lVINAFileBaseName := '~thor_Data400::in::VehReg_VINA_Info_';

export File_VINA	:=	dataset(Data_Services.foreign_prod+ 'thor_data400::in::vehreg_vina_info_all',VehLic.Layout_VINA,thor);