﻿IMPORT Data_Services;
EXPORT Input_In_IA_SalesTax := DATASET(Data_Services.foreign_prod + 'thor_data400::in::ia::sprayed::sales_tax', Scrubs_IA_SalesTax.Input_Layout_IA_SalesTax,
                                            CSV(HEADING(1), SEPARATOR([',']), TERMINATOR(['\n','\r\n','\n\r']), QUOTE('"')));