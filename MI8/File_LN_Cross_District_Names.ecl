

export File_LN_Cross_District_Names := dataset('~thor_data400::in::ln_to_cp::sourcelkp_cross_district_names',Layout_LN_Cross_District_Names,
            						         CSV(//heading(1),
																           SEPARATOR(['|','|\'']), TERMINATOR(['\n','\r\n','\n\r'])));	