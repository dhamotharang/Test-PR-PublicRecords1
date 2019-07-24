EXPORT bwr_get_score ( string lay, string  score_in )  := function


return( map(
               ( (integer8) score_in in [100,101,102,103,104,200,222] and  stringlib.stringfind(lay, 'RiskView', 1) > 0 ) => '-2',
																		
																	
							( (integer8) score_in in [200,210] and  stringlib.stringfind(lay, 'leadintegrity', 1) > 0 ) => '-2',

 
						 (((integer8) score_in   < 500  or (integer8) score_in   > 900 ) and (integer8) score_in not in [100,101,102,103,104,200,222] and stringlib.stringfind(lay, 'RiskView', 1) > 0 )  =>  '-1',
																		
																		
						(((integer8) score_in   < 300  or (integer8) score_in   > 999 ) and stringlib.stringfind(lay, 'fraudpoint', 1) > 0 )  =>  '-1',
																		
			      (((integer8) score_in   < 300  or (integer8) score_in   > 999 ) and stringlib.stringfind(lay, 'BNK4', 1) > 0 )  =>  '-1',
						(((integer8) score_in   < 300  or (integer8) score_in   > 999 ) and stringlib.stringfind(lay, 'PI02', 1) > 0 )  =>  '-1',
						(((integer8) score_in   < 300  or (integer8) score_in   > 999 ) and stringlib.stringfind(lay, 'cbbl', 1) > 0 )  =>  '-1',
																
				  	(((integer8) score_in   < 300  or (integer8) score_in   > 999 ) and (integer8) score_in not in [200,210] and stringlib.stringfind(lay, 'leadintegrity', 1) > 0 )   =>  '-1',	
																																	
						(((integer8) score_in   < 0  or (integer8) score_in   > 50 ) and stringlib.stringfind(lay, 'instant', 1) > 0 )  => '-1',
																		
																	
																		
						(((integer8) score_in   < -1  or (integer8) score_in   > 999 ) and stringlib.stringfind(lay, 'paro', 1) > -1 )  =>  '-1',
																			
																

                                    score_in
					  ));
end;