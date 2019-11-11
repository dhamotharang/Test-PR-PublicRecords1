EXPORT bwr_SOCIO_get_score_bin( string lay, string  score_in )  := function


return( map(
             														
	
		       ((string80)     trim(score_in,left,right) = 'OO'  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )   =>  '-999',	
		       ((string80)     trim(score_in,left,right) = 'N/A' and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )   =>  '-999',	
		       ((decimal10_4)  score_in   < 0    and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )   => score_in,	
		       ((decimal10_4)  score_in   = 0    and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )   and score_in <>''  =>  '0',	
					 (((decimal10_4) score_in   > 0    and (decimal10_4) score_in   <=10)   and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '0.01-10',
					 (((decimal10_4) score_in   > 10   and (decimal10_4) score_in   <=20)   and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '10.01-20',
					 (((decimal10_4) score_in   > 20   and (decimal10_4) score_in   <=30)   and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '20.01-30',
					 (((decimal10_4) score_in   > 30   and (decimal10_4) score_in   <=40)   and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '30.01-40',
					 (((decimal10_4) score_in   > 40   and (decimal10_4) score_in   <=50)   and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '40.01-50',
					 (((decimal10_4) score_in   > 50   and (decimal10_4) score_in   <=60)   and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '50.01-60',
					 (((decimal10_4) score_in   > 60   and (decimal10_4) score_in   <=70)   and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '60.01-70',
					 (((decimal10_4) score_in   > 70   and (decimal10_4) score_in   <=80)   and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '70.01-80',
					 (((decimal10_4) score_in   > 80   and (decimal10_4) score_in   <=90)   and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '80.01-90',
					 (((decimal10_4) score_in   > 90   and (decimal10_4) score_in   <=100)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '90.01-100',					
					 (((decimal10_4) score_in   > 100  and (decimal10_4) score_in   <=200)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '100.01-200',					
					 (((decimal10_4) score_in   > 200  and (decimal10_4) score_in   <=300)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '200.01-300',					
					 (((decimal10_4) score_in   > 300  and (decimal10_4) score_in   <=400)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '300.01-400',					
					 (((decimal10_4) score_in   > 400  and (decimal10_4) score_in   <=500)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '400.01-500',					
					 (((decimal10_4) score_in   > 500  and (decimal10_4) score_in   <=600)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '500.01-600',					
					 (((decimal10_4) score_in   > 600  and (decimal10_4) score_in   <=700)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '600.01-700',					
					 (((decimal10_4) score_in   > 700  and (decimal10_4) score_in   <=800)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '700.01-800',					
					 (((decimal10_4) score_in   > 800  and (decimal10_4) score_in   <=900)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '800.01-900',					
					 (((decimal10_4) score_in   > 900  and (decimal10_4) score_in   <=1000)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )     and score_in<>''  =>  '900.01-1000',					
					 (((decimal10_4) score_in   > 1000 and (decimal10_4) score_in   <=1100)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )     and score_in<>''  =>  '1000.01-1100',					
					 (((decimal10_4) score_in   > 1100 and (decimal10_4) score_in   <=1200)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )     and score_in<>''  =>  '1100.01-1200',					
					 (((decimal10_4) score_in   > 1200 and (decimal10_4) score_in   <=1300)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )     and score_in<>''  =>  '1200.01-1300',					
					 (((decimal10_4) score_in   > 1300 and (decimal10_4) score_in   <=1400)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )     and score_in<>''  =>  '1300.01-1400',					
					 (((decimal10_4) score_in   > 1400 and (decimal10_4) score_in   <=1500)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )     and score_in<>''  =>  '1400.01-1500',					
					 (((decimal10_4) score_in   > 1500 and (decimal10_4) score_in   <=1600)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )     and score_in<>''  =>  '1500.01-1600',					
					 (((decimal10_4) score_in   > 1600 and (decimal10_4) score_in   <=1700)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )     and score_in<>''  =>  '1600.01-1700',					
					 (((decimal10_4) score_in   > 1700 and (decimal10_4) score_in   <=1800)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )     and score_in<>''  =>  '1700.01-1800',					
					 (((decimal10_4) score_in   > 1800 and (decimal10_4) score_in   <=1900)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )     and score_in<>''  =>  '1800.01-1900',					
					 (((decimal10_4) score_in   > 1900 and (decimal10_4) score_in   <=2000)  and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0 )     and score_in<>''  =>  '1900.01-2000',					
					 ((decimal10_4) score_in    > 2000 and stringlib.stringfind(lay, 'socioeconomic_v5_batch', 1) > 0  )     and score_in<>''  =>  '>2000',					

						score_in=''=> 'NULL', 
                   'UNDEFINED'));
end;