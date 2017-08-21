


export File_LN_Cross_Counties := dataset('~thor_400::in::ln_to_cp::sourcelkp_cross_counties', Layout_LN_Cross_Counties,
            						         CSV(//heading(1),
																           SEPARATOR(['|','|\'']), TERMINATOR(['\n','\r\n','\n\r'])));	