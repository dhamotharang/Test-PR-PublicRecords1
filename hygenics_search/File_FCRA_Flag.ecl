import Data_Services;

export File_FCRA_Flag := dataset(Data_Services.foreign_prod+'thor_data400::in::fcra_flag',
							Layout_FCRA_Flag,flat,unsorted);