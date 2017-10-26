

import Data_Services;

EXPORT  
in_sexoffender_main := dataset(Data_Services.foreign_prod  +
														        'thor_data400::base::sex_offender_mainpublic',scrubs_sexoffender_main.layout_sexoffender_main,flat);

