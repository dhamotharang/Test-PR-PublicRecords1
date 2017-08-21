EXPORT proc_prep_all(string filedate) := module



export build_all := Sequential(  Spray_In(filedate).raw,
                                 fConvert_13d13g(filedate).d13g13g_thor,
                                 proc_InsiderFiling(filedate).dInsiderFinal,
                                 proc_13d13g(filedate).d13D13GFinal,
																 proc_security(filedate).dSecurityFinal
																 ) : success(Send_Email(filedate,'prep').BuildSuccess) , failure(Send_Email(filedate,'prep').BuildFailure);
																 
end;
                             