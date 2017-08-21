import ut;
export File_LN_Opt_Out := 
    dataset('~thor_data400::in::ln_opt_out',Suppress.Layout_LN_Opt_Out,
    csv(heading(1),terminator('\r\n'),quote('"'),maxlength(100000)));