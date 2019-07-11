EXPORT bwr_SOCIO_get_score_bin( string lay, string  score_in )  := function


return( map(
             														
	
		       (((decimal10_4) score_in   < 0   or (decimal10_4) score_in   > 100 )  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )   and score_in<>'' =>  'UNDEFINED',	
		        ((decimal10_4) score_in   = 0   and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )   and score_in<>'' =>  '0',	
					 (((decimal10_4) score_in   > 0   and (decimal10_4) score_in   <=10 ) and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '0.01-10',
					 (((decimal10_4) score_in   > 10  and (decimal10_4) score_in   <=20 ) and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '10.01-20',
					 (((decimal10_4) score_in   > 20  and (decimal10_4) score_in   <=30 ) and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '20.01-30',
					 (((decimal10_4) score_in   > 30  and (decimal10_4) score_in   <=40 ) and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '30.01-40',
					 (((decimal10_4) score_in   > 40  and (decimal10_4) score_in   <=50 ) and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>'' =>  '40.01-50',
					 (((decimal10_4) score_in   > 50  and (decimal10_4) score_in   <=60 ) and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>'' =>  '50.01-60',
					 (((decimal10_4) score_in   > 60  and (decimal10_4) score_in   <=70 ) and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>'' =>  '60.01-70',
					 (((decimal10_4) score_in   > 70  and (decimal10_4) score_in   <=80 ) and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>'' =>  '70.01-80',
					 (((decimal10_4) score_in   > 80  and (decimal10_4) score_in   <=90 ) and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>'' =>  '80.01-90',
					 (((decimal10_4) score_in   > 90  and (decimal10_4) score_in   <=100) and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>'' =>  '90.01-100',					

						score_in=''=> 'NULL', 
                   'UNDEFINED'));
end;