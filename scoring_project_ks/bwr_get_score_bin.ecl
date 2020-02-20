EXPORT bwr_get_score_bin ( string lay, string  score_in )  := function


return( map(


    (((integer8) score_in   < 500  or (integer8) score_in   > 900 ) and (integer8) score_in not in [100,101,102,103,104,200,222] and stringlib.stringfind(lay, 'RiskView', 1) > 0 )   and score_in<>'' =>  'UNDEFINED',	
																	  
																		( ((integer8) score_in   < 300 or (integer8) score_in   > 999 ) and stringlib.stringfind(lay, 'fraudpoint', 1) > 0 )   and score_in<>''   =>  'UNDEFINED',
																		
																		( ((integer8) score_in   < 300 or (integer8) score_in   > 999 )and stringlib.stringfind(lay, 'BNK4', 1) > 0 )   and score_in<>''   =>  'UNDEFINED',	
																		( ((integer8) score_in   < 300 or (integer8) score_in   > 999 )and stringlib.stringfind(lay, 'PI02', 1) > 0 )   and score_in<>''   =>  'UNDEFINED',	
																		( ((integer8) score_in   < 300 or (integer8) score_in   > 999 )and stringlib.stringfind(lay, 'cbbl', 1) > 0 )   and score_in<>''   =>  'UNDEFINED',	
																		
																		
			                            	( ((integer8) score_in   < 300  or (integer8) score_in   > 999 )and (integer8) score_in not in [200,210] and stringlib.stringfind(lay, 'leadintegrity', 1) > 0 )   and score_in<>''  =>  'UNDEFINED',
																		

																		
																		(((integer8) score_in   < -1  or (integer8) score_in   > 999 ) and stringlib.stringfind(lay, 'paro', 1) > 0  ) and score_in<>''  =>  'UNDEFINED',
																	
																																				
		                                (((integer8) score_in   >=0  and (integer8) score_in   <= 50 ) and  stringlib.stringfind(lay, 'instant', 1) > 0 ) and score_in<>''  => score_in,
             // score_in   = '' => '0',

                                (integer8) score_in   = 100 => '100', //'Insufficient verification to return a score under  CA law Insufficient verification of input (CA Only) CA Statute 1785.14 (a) (1)', 
                                (integer8) score_in   = 101 => '101',  // 'Security Freeze Consumer initiated security freeze', 
                                (integer8) score_in   = 102 => '102',  //'Security Alert Consumer initiated security alert', 
                                (integer8) score_in   = 103 => '103',  //'Identity Theft Alert Consumer initiated identity theft alert', 
                                (integer8) score_in   = 104 => '104',  //'Dispute on file Consumer statement on file', 
                                (integer8) score_in   = 200 => '200',  //'The input SSN is reported as deceased Consumer is deceased'                                           , 
                                (integer8) score_in   = 210 => '210',  //'Subject is listed in the Direct Marketing association List'                                           , 																
                                (integer8) score_in   = 222 => '222', //'Insufficient information on file Insufficient data available to generate a score', 
																
																		 (((integer8) score_in   >= 0  and (integer8) score_in   <=10 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )      and score_in<>''  =>  '1-10',
																		 (((integer8) score_in   >= 11  and (integer8) score_in   <=20 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )     and score_in<>''  =>  '11-20',
																		 (((integer8) score_in   >= 21  and (integer8) score_in   <=30 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )     and score_in<>''  =>  '21-30',
																		 (((integer8) score_in   >= 31  and (integer8) score_in   <=40 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )     and score_in<>''  =>  '31-40',
																		 (((integer8) score_in   >= 41  and (integer8) score_in   <=50 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )     and score_in<>'' =>  '41-50',
																		 (((integer8) score_in   >= 51  and (integer8) score_in   <=60 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )     and score_in<>'' =>  '51-60',
																		 (((integer8) score_in   >= 61  and (integer8) score_in   <=70 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )     and score_in<>'' =>  '61-70',
																		 (((integer8) score_in   >= 71  and (integer8) score_in   <=80 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )     and score_in<>'' =>  '71-80',
																	   (((integer8) score_in   >= 81  and (integer8) score_in   <=90 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )     and score_in<>'' =>  '81-90',
																     (((integer8) score_in   >= 91  and (integer8) score_in   <=100 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )    and score_in<>'' =>  '91-100',
																		 (((integer8) score_in   >= 101  and (integer8) score_in   <=110 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '101-110',
																		 (((integer8) score_in   >= 111  and (integer8) score_in   <=120 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '111-120',
																		 (((integer8) score_in   >= 121  and (integer8) score_in   <=130 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>''  =>  '121-130',
															 		   (((integer8) score_in   >= 131  and (integer8) score_in   <=140 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>''  =>  '131-140',
																	   (((integer8) score_in   >= 141  and (integer8) score_in   <=150 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>''  =>  '141-150',
																		 (((integer8) score_in   >= 151  and (integer8) score_in   <=160 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '151-160',
																		 (((integer8) score_in   >= 161  and (integer8) score_in   <=170 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '161-170',
																		 (((integer8) score_in   >= 171  and (integer8) score_in   <=180 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '171-180',
																		 (((integer8) score_in   >= 181  and (integer8) score_in   <=190 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '181-190',
																	   (((integer8) score_in   >= 191  and (integer8) score_in   <=200 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '191-200',
																		 (((integer8) score_in   >= 201  and (integer8) score_in   <=210 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '201-210',
																	   (((integer8) score_in   >= 211  and (integer8) score_in   <=220 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '211-220',
																		 (((integer8) score_in   >= 221  and (integer8) score_in   <=230 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '221-230',
													    			 (((integer8) score_in   >= 231  and (integer8) score_in   <=240 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '231-240',
																		 (((integer8) score_in   >= 241  and (integer8) score_in   <=250 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '241-250',
																		 (((integer8) score_in   >= 251  and (integer8) score_in   <=260 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '251-260',
																	   (((integer8) score_in   >= 261  and (integer8) score_in   <=270 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '261-270',
																		 (((integer8) score_in   >= 271  and (integer8) score_in   <=280 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '271-280',
																	   (((integer8) score_in   >= 281  and (integer8) score_in   <=290 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '281-290',
																		 (((integer8) score_in   >= 291  and (integer8) score_in   <=300 ) and stringlib.stringfind(lay, 'paro', 1) > 0  )   and score_in<>'' =>  '291-300',
																							
																													
																													
																													
																		 
                                    
																		(integer8) score_in   between 300 and 310 =>'300-310' , 
                                    (integer8) score_in   between 311 and 320 =>'311-320' , 
                                    (integer8) score_in   between 321 and 330 =>'321-330' , 
                                    (integer8) score_in   between 331 and 340 =>'331-340' , 
                                    (integer8) score_in   between 341 and 350 =>'341-350' , 
                                    (integer8) score_in   between 351 and 360 =>'351-360' , 
                                    (integer8) score_in   between 361 and 370 =>'361-370' , 
                                    (integer8) score_in   between 371 and 380 =>'371-380' , 
                                    (integer8) score_in   between 381 and 390 =>'381-390' , 
                                    (integer8) score_in   between 391 and 400 =>'391-400' ,                                  
                                    (integer8) score_in   between 401 and 410 =>'401-410' , 
                                    (integer8) score_in   between 411 and 420 =>'411-420' , 
                                    (integer8) score_in   between 421 and 430 =>'421-430' , 
                                    (integer8) score_in   between 431 and 440 =>'431-440' , 
                                    (integer8) score_in   between 441 and 450 =>'441-450' , 
                                    (integer8) score_in   between 451 and 460 =>'451-460' , 
                                    (integer8) score_in   between 461 and 470 =>'461-470' , 
                                    (integer8) score_in   between 471 and 480 =>'471-480' , 
                                    (integer8) score_in   between 481 and 490 =>'481-490' , 
                                    (integer8) score_in   between 491 and 500 =>'491-500' ,                                 
                                    (integer8) score_in   between 501 and 510 =>'501-510' , 
                                    (integer8) score_in   between 511 and 520 =>'511-520' , 
                                    (integer8) score_in   between 521 and 530 =>'521-530' , 
                                    (integer8) score_in   between 531 and 540 =>'531-540' , 
                                    (integer8) score_in   between 541 and 550 =>'541-550' , 
                                    (integer8) score_in   between 551 and 560 =>'551-560' , 
                                    (integer8) score_in   between 561 and 570 =>'561-570' , 
                                    (integer8) score_in   between 571 and 580 =>'571-580' , 
                                    (integer8) score_in   between 581 and 590 =>'581-590' , 
                                    (integer8) score_in   between 591 and 600 =>'591-600' ,                                 
                                    (integer8) score_in   between 601 and 610 =>'601-610' , 
                                    (integer8) score_in   between 611 and 620 =>'611-620' , 
                                    (integer8) score_in   between 621 and 630 =>'621-630' , 
                                    (integer8) score_in   between 631 and 640 =>'631-640' , 
                                    (integer8) score_in   between 641 and 650 =>'641-650' , 
                                    (integer8) score_in   between 651 and 660 =>'651-660' , 
                                    (integer8) score_in   between 661 and 670 =>'661-670' , 
                                    (integer8) score_in   between 671 and 680 =>'671-680' , 
                                    (integer8) score_in   between 681 and 690 =>'681-690' , 
                                    (integer8) score_in   between 691 and 700 =>'691-700' ,                                 
                                    (integer8) score_in   between 701 and 710 =>'701-710' , 
                                    (integer8) score_in   between 711 and 720 =>'711-720' , 
                                    (integer8) score_in   between 721 and 730 =>'721-730' , 
                                    (integer8) score_in   between 731 and 740 =>'731-740' , 
                                    (integer8) score_in   between 741 and 750 =>'741-750' , 
                                    (integer8) score_in   between 751 and 760 =>'751-760' , 
                                    (integer8) score_in   between 761 and 770 =>'761-770' , 
                                    (integer8) score_in   between 771 and 780 =>'771-780' , 
                                    (integer8) score_in   between 781 and 790 =>'781-790' , 
                                    (integer8) score_in   between 791 and 800 =>'791-800' ,                                  
                                    (integer8) score_in   between 801 and 810 =>'801-810' , 
                                    (integer8) score_in   between 811 and 820 =>'811-820' , 
                                    (integer8) score_in   between 821 and 830 =>'821-830' , 
                                    (integer8) score_in   between 831 and 840 =>'831-840' , 
                                    (integer8) score_in   between 841 and 850 =>'841-850' , 
                                    (integer8) score_in   between 851 and 860 =>'851-860' , 
                                    (integer8) score_in   between 861 and 870 =>'861-870' , 
                                    (integer8) score_in   between 871 and 880 =>'871-880' , 
                                    (integer8) score_in   between 881 and 890 =>'881-890' , 
                                    (integer8) score_in   between 891 and 900 =>'891-900' ,                                  
                                    (integer8) score_in   between 901 and 910 =>'901-910' , 
                                    (integer8) score_in   between 911 and 920 =>'911-920' , 
                                    (integer8) score_in   between 921 and 930 =>'921-930' , 
                                    (integer8) score_in   between 931 and 940 =>'931-940' , 
                                    (integer8) score_in   between 941 and 950 =>'941-950' , 
                                    (integer8) score_in   between 951 and 960 =>'951-960' , 
                                    (integer8) score_in   between 961 and 970 =>'961-970' , 
                                    (integer8) score_in   between 971 and 980 =>'971-980' , 
                                    (integer8) score_in   between 981 and 990 =>'981-990' , 
                                    (integer8) score_in   between 991 and 999 =>'991-999' ,                          
																		
																
																		
																		score_in=''=> 'NULL',
                                  'UNDEFINED'

					  ));
end;