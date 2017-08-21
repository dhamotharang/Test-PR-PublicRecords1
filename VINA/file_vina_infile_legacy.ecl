import Data_Services;

EXPORT file_vina_infile_legacy := DATASET(Data_Services.foreign_prod+'thor_data400::in::vina::processed::vin_infile_legacy',VINA.layout_vina_infile,THOR);