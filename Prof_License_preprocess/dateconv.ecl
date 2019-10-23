import ut,lib_stringlib;
export dateconv( string10 date) := function

 return  IF (  trim(date) <> ''  , case ( length(trim(date)) , 10 =>  map ( trim(date[1..2]) <= '12'  and trim(date) [4..5] > '12' =>  Prof_License_preprocess.fSlashedMDYtoCYMD ( trim(date)),
                                                                            trim(date[1..2]) in [ '19','20' ] and trim(date)[5] in ['-', '/'] and trim(date)[6..7] <= '12' =>  trim(date[1..4]) + trim(date)[6..7] + trim(date)[9..10],
																																                                            trim(date[1..2]) in [ '19','20' ] and trim(date)[5] in ['-', '/'] and trim(date)[6..7] > '12' =>  trim(date[1..4]) + trim(date)[9..10] + trim(date)[6..7] ,
																																                                           Prof_License_preprocess.fSlashedDMYtoCYMD ( trim(date))
																														                                            ),
 
																		                                             9 =>  map ( regexfind('[aA-zZ]', trim(date)) = true => Prof_License_preprocess.CleanPLDate ( trim(date)) ,
																										                                                regexfind( '[-,/]',trim(date)) and trim(date) [1..2] in [ '19','20' ] and trim(date) [3..4] not in ['-', '/'] and trim(date)[5] in ['-', '/'] and  trim( date) [7] not in ['-', '/'] and trim(date)[6..7] > '12' => trim(date) [1..4] + '0' + trim(date)[9] + trim(date)[6..7],
																															                                           regexfind( '[-,/]',trim(date)) and  trim(date)[2] in ['-', '/'] =>  trim(date) [6..9] + '0' + trim(date)[1] + trim(date)[3..4],
																															                                           regexfind( '[-,/]',trim(date)) and trim(date) [1..2] in [ '19','20' ] and trim(date) [3..4] not in ['-', '/'] and trim(date)[5] in ['-', '/'] and trim( date) [7] in ['-', '/'] and trim(date)[8..9] > '12' => trim(date) [1..4] + '0' + trim(date)[6] + trim(date)[8..9],
																															                                           regexfind( '[-,/]',trim(date)) and trim(date) [1..2] in [ '19','20' ] and trim(date) [3..4] not in ['-', '/'] and trim(date)[5] in ['-', '/'] and trim( date) [7] in ['-', '/']  => trim(date) [1..4] + '0' + trim(date)[6] + trim(date)[8..9],
																															                                           regexfind( '[-,/]',trim(date)) and trim(date) [1..2] > '12' and trim(date)[3] in ['-', '/'] and trim( date) [5] in ['-', '/'] => trim(date) [6..9] + '0' + trim( date) [4] + trim(date) [1..2],
																															                                           regexfind( '[-,/]',trim(date)) and trim(date)[3] in ['-', '/'] and trim( date) [5] in ['-', '/'] => trim(date) [6..9] + '0' + trim( date) [4] + trim(date) [1..2],
																															 
																														                                                             ''
																															                                           ),
																															  
																		
																		                                           8 =>   map ( regexfind( '[-,/]',trim(date)) and trim(date)[3] in ['-','/'] and trim(date)[7] in ['1','0']  and trim(date[1..2]) <= '12' => '20' + trim(date)[7..8] +  trim(date)[1..2] + trim(date)[4..5],
																										                                                regexfind( '[-,/]',trim(date)) and trim(date)[3] in ['-','/']  and trim(date)[7] in ['1','0'] and  trim(date[1..2]) > '12' => '20' + trim(date)[7..8] + trim(date)[4..5]  +  trim(date)[1..2],
																		                                                        regexfind( '[-,/]',trim(date)) and trim(date)[3] in ['-','/'] and trim(date)[7..8] > '30' and trim(date[1..2]) <= '12' => '19' + trim(date)[7..8] +  trim(date)[1..2] + trim(date)[4..5],
																																                                          regexfind( '[-,/]',trim(date)) and trim(date)[3] in ['-','/'] and trim(date)[7..8] > '30' and trim(date[1..2]) > '12' => '19' + trim(date)[7..8] + trim(date)[4..5] +  trim(date)[1..2],
																															                                           regexfind( '[-,/]',trim(date)) = false and trim(date)[1..2] 	in [ '19','20' ]  and trim(date[5..6]) <= '12' => trim(date),
																																                                          regexfind( '[-,/]',trim(date)) = false and trim(date)[1..2] 	in [ '19','20' ]  and trim(date[5..6]) > '12' and trim( date)[5..6] not in [ '19','20' ] => trim(date[1..4]) + trim(date[7..8]) + trim(date[5..6]),
																																                                          regexfind( '[-,/]',trim(date)) = false and trim(date)[1..2] 	in [ '19','20' ]  and trim(date[3..4]) <= '12' and trim( date)[5..6]  in [ '19','20' ] => trim(date[5..8]) + trim(date[3..4]) + trim(date[1..2]),

																																                                           regexfind( '[-,/]',trim(date)) = false and trim(date)[5..6] in [ '19','20' ] and trim(date[1..2]) <= '12'  => trim(date[5..8]) + trim(date[1..2]) + trim(date[3..4]),
																																                                           regexfind( '[-,/]',trim(date)) = false and trim(date)[5..6] in [ '19','20' ] and trim(date[1..2]) >  '12' => trim(date[5..8]) + trim(date[3..4]) + trim(date[1..2]), 
                                                                           ''
																																                                         ),
																		                                           7  => map (  regexfind( '[-,/]',trim(date)) = false and trim(date)[4..5] in [ '19','20' ] => trim(date[4..7]) + '0' + trim(date[1..3]),
																										                                                regexfind( '[-,/]',trim(date)) and trim(date)[6..7] > '30' and trim(date)[3] in ['-','/'] and trim(date)[1..2] > '12' => '19' +trim(date)[6..7] + '0'+ trim(date)[4] + trim(date) [1..2] ,
																																                                          regexfind( '[-,/]',trim(date)) and trim(date)[6..7] > '30' and trim(date)[3] in ['-','/']  and trim(date)[1..2] <= '12' => '19' +trim(date)[6..7] + trim(date) [1..2] + '0'+ trim(date)[4] ,
																																                                          regexfind( '[-,/]',trim(date)) and trim(date)[6..7] < '30' and trim(date)[3] in ['-','/'] and trim(date)[1..2] > '12' => '20' +trim(date)[6..7] + '0'+ trim(date)[4] + trim(date) [1..2], 
																																                                          regexfind( '[-,/]',trim(date)) and trim(date)[6..7] < '30' and trim(date)[3] in ['-','/'] and trim(date)[1..2] <= '12' => '20' +trim(date)[6..7] + trim(date) [1..2] + '0'+ trim(date)[4] , 
																																                                          regexfind( '[-,/]',trim(date)) and trim(date)[6..7] > '30' and trim(date)[2] in ['-','/'] and trim(date)[3..4] > '12'  => '19' +trim(date)[6..7] + '0'+ trim(date)[1] + trim(date) [3..4],
																																                                          regexfind( '[-,/]',trim(date)) and trim(date)[6..7] > '30' and trim(date)[2] in ['-','/']and trim(date)[3..4] <= '12'  => '19' +trim(date)[6..7] + trim(date) [3..4] + '0'+ trim(date)[1],
																																                                          regexfind( '[-,/]',trim(date)) and trim(date)[6..7] < '30' and trim(date)[2] in ['-','/'] and trim(date)[3..4] > '12'  => '20' +trim(date)[6..7] + '0'+ trim(date)[1] + trim(date) [3..4],
																																                                          regexfind( '[-,/]',trim(date)) and trim(date)[6..7] < '30' and trim(date)[2] in ['-','/'] and trim(date)[3..4] <= '12'  => '20' +trim(date)[6..7] + trim(date) [3..4] + '0'+ trim(date)[1],''),
																		
																                                            6 => map (                         trim(date)[3..4] in [ '19','20' ]  and ( trim(date)[1..2]  not in [ '19','20' ] )  => trim(date)[3..6] + '0'+ trim(date)[1]+ '0' + trim(date)[2] ,
																																 trim(date)[1..2] in [ '19','20' ]  and ( trim(date)[3..4]  not in [ '19','20' ] ) => trim(date)[1..4] + '0'+ trim(date)[5]+ '0' + trim(date)[6] ,	
																																 trim(date)[1..2] > '50' and trim(date)[3] = '0' and trim(date)[5] = '0' => '19' + trim(date)[1..6],
																																 
																																	trim(date)[5] in ['1','0','2'] and trim(date)[1..2] <= '12'  => '20' + trim(date)[5..6] + trim(date)[1..4],
																										                                             trim(date)[5] in ['1','0','2'] and trim(date)[1..2] > '12'  => '20' + trim(date)[5..6] + trim(date)[3..4] + trim(date)[1..2],
																													                                          trim(date)[5] not in ['1','0','2'] and trim(date)[1..2] <= '12'   =>  '19' + trim(date)[5..6] + trim(date)[1..4],
																																 	                                     trim(date)[5] not in ['1','0','2'] and trim(date)[1..2] > '12'   =>  '19' + trim(date)[5..6] + trim(date)[3..4] + trim(date)[1..2],
																																	                                       ''

																																                                      ) ,
																																 
																			                              ''),
						              '');
                                                             
 
 

	end;