import Data_Services;
export	File_suppressionTPS_National	:=	dataset(Data_Services.foreign_prod + 'thor_data400::base::suppression::tps_national',DMA.layout_suppressionTPS.Base,flat);