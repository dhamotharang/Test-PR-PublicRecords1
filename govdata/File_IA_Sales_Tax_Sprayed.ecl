IMPORT govdata, ut;

EXPORT File_IA_Sales_Tax_Sprayed := DATASET('~thor_data400::in::ia::sprayed::sales_tax', govdata.Layout_IA_Sales_Tax_Sprayed,
                                            CSV(HEADING(1), SEPARATOR([',']), TERMINATOR(['\n','\r\n','\n\r']), QUOTE('"')));