

import ut;

EXPORT  
in_sexoffender_main := dataset(
                                ut.foreign_prod +
														      //ut.foreign_dataland +
														       'thor_data400::base::sex_offender_mainpublic',scrubs_sexoffender_main.layout_sexoffender_main,flat);

