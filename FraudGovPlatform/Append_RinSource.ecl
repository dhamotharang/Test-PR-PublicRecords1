import STD,ut,tools;

export Append_RinSource (
        dataset(FraudGovPlatform.Layouts.Base.Main) pBaseFile = FraudGovPlatform.Files().Base.Main.Built 
) := 
FUNCTION 

    /************************       Documentation        ***********************
    https://confluence.rsi.lexisnexis.com/display/GTG/Data+Source+Identification
    ****************************************************************************/

        
    FraudGovPlatform.Layouts.Base.Main appendLabel(FraudGovPlatform.Layouts.Base.Main L) := TRANSFORM
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
