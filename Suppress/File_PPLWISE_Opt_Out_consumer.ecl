import ut;
export File_PPLWISE_Opt_Out_consumer := 
    dataset('~thor_data400::in::pplwise_opt_out_consumer',Suppress.Layout_PPLWISE_Opt_Out_consumer,
    csv(heading(1),terminator('\r\n'),quote('"'),maxlength(100000)));