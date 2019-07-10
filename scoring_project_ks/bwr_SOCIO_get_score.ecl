EXPORT bwr_SOCIO_get_score ( string lay, string  score_in )  := function


return( map(

																			
		        (((decimal10_4) score_in   <0  or (decimal10_4) score_in   > 100 ) and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 ) => '-1',	
		        (score_in  = '' and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 ) => '-1',	
															
				     score_in
					  ));
end;