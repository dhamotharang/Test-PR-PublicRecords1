import STD,ut,FraudShared,tools;

export Append_RinSource (
        dataset(FraudShared.Layouts.Base.Main) pBaseFile = FraudShared.Files().Base.Main.Built 
) := 
FUNCTION 

    /************************       Documentation        ***********************
    https://confluence.rsi.lexisnexis.com/display/GTG/Data+Source+Identification
    ****************************************************************************/

        
    FraudShared.Layouts.Base.Main appendLabel(FraudShared.Layouts.Base.Main L) := TRANSFORM
        SELF.RIN_SourceLabel 
					:= MAP(
									L.RIN_Source = 1 	=> 'IDENTITY FILE',
									L.RIN_Source = 2 	=> 'FILE',
									L.RIN_Source = 5 	=> 'RIN WEB',
									L.RIN_Source = 3 	=> 'FILE',
									L.RIN_Source = 6 	=> 'RIN',
									L.RIN_Source = 7 	=> 'RIN WEB',
									L.RIN_Source = 4 	=> 'RIN WEB',
									L.RIN_Source = 12 => 'RIN BATCH FILE',
									L.RIN_Source = 13 => 'RIN API',
									L.RIN_Source = 15 => 'NAC API',
									L.RIN_Source = 10 => 'NAC BATCH',
									L.RIN_Source = 11 => 'NAC COLLISION',
									L.RIN_Source = 9 	=> 'RDP',
									L.RIN_Source = 14 => 'RIN',
									L.RIN_Source = 8 	=> 'NAC SEARCH',
									''
						);
        SELF := L;
    end;
                                                                        
    result  := project( pBaseFile, appendLabel(LEFT));
    

		return result;

end;
