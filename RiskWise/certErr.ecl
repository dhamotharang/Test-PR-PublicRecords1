export certErr(string4 acecode, string2 predir, string28 prim_name, string4 addr_suffix ,string2 postdir, string2 st ) := function
			
	convertedCode		:= MAP(acecode in ['E101', 'E213', 'E214', 'E216', 'E302', 'E420', 'E421', 'E422']  => '4.1',
						acecode in ['E212', 'E429']				 => '2.1',
						acecode in ['E412', 'SB00']				 => '3.1',
						acecode in ['E413', 'E425', 'E431']	 => '6.1',
						acecode = 'E427' and postdir = ''			 => '6.1', 
						acecode = 'E427' and postdir != ''			 => '4.1', 
						acecode = 'E428'						 => '5.2',
						acecode in ['E500', 'E503'] 				 => '5.1',  
						acecode = 'E501'						 => '1.1',
						acecode = 'S400' and st = ''				 => '1.1',
						acecode[1..2] in ['S1']					 => '14.2',
						acecode = 'E502' and prim_name = '' 		 => '11.12',
						acecode = 'E430' 						 => '6.2',  //address line matches too close to choose
						acecode[1] in ['A', 'B', 'C'] 			 => '7.2',  // if first position is a,b,or c
													                     // then address is truncated
						acecode = 'SD00' 					      => '9.1',   // state determined by city
						acecode = 'S400'				   	      => '9.2',   // state determined by zip
						acecode[1..2] in ['S2', 'S6', 'SA', 'SE']     => '10.2',  // city determined by zip
						acecode in ['S300']		 				 => '10.2', 
						acecode in ['S090'] 			           => '11.1', // Street name changed
						acecode = 'S020' and predir = '' 		      => '11.2',  // Predirection dropped 
						acecode in ['S020', 'S060'] and predir != ''	 => '11.3',  // Predirection added
						acecode = 'E423' and addr_suffix !='' 	      => '11.4',  // Suffix dropped
						acecode in ['S010', 'S030','S050'] 		 => '11.5',  // Suffix added
						acecode = 'S860'						 => '11.6',
						acecode = 'S040'  and postdir = ''	    		 => '11.6',  // Postdirection dropped
						acecode in ['S040', 
								  'S060',
								  'S070',
								  'S0C0',
								  'S0D0',
								  'S0E0',
								  'S0F0']	 and postdir  !=''		       => '11.7',   //post-directional added	
						acecode in ['S990']	or acecode[1..3] in ['S08', 'S0B', 'S0A']  => '11.9', //primary name changed
						acecode in ['S011']                                 => '11.10',
						acecode = 'S001' 			 	          	  => '12.1',   // unit stdardized
						acecode = 'S060' and postdir =''      			  => '12.3',
						acecode = 'E505'		 						=> '12.5',  // bad rural
						acecode in ['E428', 'E503']						=> '14.1',  // bad zip, zip not found
						acecode in ['S900', 'S9C0']          				=> '14.2',  // zip changed
						acecode[1..2] in ['S8'] or acecode in ['E504'] 		=> '14.3',  // zip+4 changed
						acecode[1] = 's' and acecode [4] > '0' 				=> '14.4',  // route changed 
 						'');
					
	return convertedCode;
end;