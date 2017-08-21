EXPORT Files_raw := module



export dFiling := dataset('~thor_data400::in::vickers::insider_filing_raw',Vickers.Layouts_raw.Insider_Filing,csv ( heading(1),terminator('\r\n'),separator('|'),quote('')));

export dFiler := dataset('~thor_data400::in::vickers::insider_filer_raw',Vickers.Layouts_raw.Insider_Filer,csv ( heading(1),terminator('\r\n'),separator('|'),quote('')));

export  d13D13G := dataset('~thor_data400::in::vickers::13d13g_raw',Vickers.Layouts_raw.Layout_13D13G,thor);

export  security := dataset('~thor_data400::in::vickers::insider_security_raw',Vickers.Layouts_raw.Layout_Security,csv ( heading(1),terminator('\r\n'),separator('|'),quote('')));


end;