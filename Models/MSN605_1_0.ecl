//
// IBO Charity Score ***   model MSN605_1_0 ***
//
import ut, risk_indicators ,address, Easi, Riskwise;

export MSN605_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam,  dataset(easi.layout_census) easi_census, boolean ofac_only=true) := 
  
FUNCTION
 
layout_bseasi := record 
	Risk_Indicators.Layout_Boca_Shell  bs;
	Easi.layout_census  ea;
end;

layout_bseasi join2recs(clam le, easi_census rt) :=transform
	self.bs		:=le;
	self.ea        :=rt;
	self			:=[];
end; 
						 
						 
results :=join(clam, easi_census,
			right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk,
			join2recs(left,right),
			left outer, lookup);
  
  
Layout_ModelOut doModel(results le) := transform

     /* make easi census IVs */
	IV_ecen_lghh := if((real)le.ea.hhsize > 4, 1, 0);

     IV_ecen_highinp := (real)le.ea.in75K_p + (real)le.ea.in100K_p + (real)le.ea.in125K_p + 
 				    (real)le.ea.in150K_p + (real)le.ea.in200K_p + (real)le.ea.in201K_p;	
	
	// nulls are handled differently than zeroes.
	IV_ecen_highinp0_f := if(IV_ecen_highinp =  0 and le.ea.in75k_p !='', 1, 0);
 	
	IV_ecen_new_homes := map((real)le.ea.new_homes <= 0 => 0,
						le.ea.new_homes = '' => 0,
						(real)le.ea.new_homes > 200 => 200,
						(real)le.ea.new_homes);
  
     IV_ecen_lowrent		:= map(le.ea.med_rent = ''	=> 1,
						(real)le.ea.med_rent <  500	=> 1,
						0);
						 

     IV_ecen_high_housingCPI_f :=if(le.ea.housingcpi = '' or ((real)le.ea.housingcpi < 0 or
							   (real)le.ea.housingcpi > 200), 1, 0);  	
	
     IV_ecen_rental_lot_f	:= if(le.ea.rental = '' or (real)le.ea.rental < 0 or
							  (real)le.ea.rental > 100, 1, 0);
							  
	IV_ecen_milemp_f		:=if ((real)le.ea.mil_emp > 0,1,0);
	
     IV_ecen_crime_high_f	:=if((real)le.ea.totcrime <= 75 and le.ea.totcrime !='',0,1);
     
     
     IV_ecen_lowrent_p 		 := (real)le.ea.rnt250_p +  (real)le.ea.rnt500_p;
	
	IV_ecen_lowrent_p2		 :=if(le.ea.rnt250_p = '' or le.ea.rnt500_p='' or IV_ecen_lowrent_p < 0 or
							IV_ecen_lowrent_p > 100, 100, IV_ecen_lowrent_p);
	
	

     IV_ecen_lowrent_p2_log 	:= log(IV_ecen_lowrent_p2+1)/0.434294481903;
	   

     /* make Boca IVs */
	
	iv_ver_nas 	:= map(le.bs.iid.NAS_Summary = 0 				 => 3,
					 le.bs.iid.NAS_Summary  = 1				 => 1,
					 le.bs.iid.NAS_Summary in [4,6,7,9,10,11,12]  => 2,
					 4); 
		
	// the following 2 fields are boolean  and found in the  layout input validation part of the boca shell layout
	// check to see if they have a value, if so, set to 1 otherwise 0 
	 
	ssnpop := if(le.bs.input_validation.ssn, 1, 0);
	hphnpop := if(le.bs.input_validation.homephone, 1, 0);

	iv_ver_nas4	:=if(iv_ver_nas = 4 and ssnpop = 0,1,0);				
     
     IV_phone_not_found :=if(le.bs.iid.nap_summary = 0 and hphnpop = 1,1,0);
    
     nap_ver :=if(le.bs.iid.nap_summary >=10,1,0);
     dwelling_type :=StringLib.StringToUpperCase(le.bs.iid.dwelltype);
 		
     IV_special_deliver :=if(dwelling_type  = 'S',1,0);
   
   
	IV_criminal_flag := map(le.bs.bjl.criminal_count = 0 => 0,
					    le.bs.bjl.criminal_count = 1 => 1,
					    2);

	lien_unrel_count :=map(le.bs.bjl.liens_historical_unreleased_count = 0 =>0,
					   le.bs.bjl.liens_historical_unreleased_count = 1 =>1,
					   2); 
					   
     lien_unrel_count_m := map(lien_unrel_count = 0 =>0.0994734,
						 lien_unrel_count = 1 =>0.0570805,
						 0.0454223);
						 
     rel_income :=map(le.bs.relatives.relative_incomeover100_count > 0 => 101,
			    	le.bs.relatives.relative_incomeunder100_count  > 0 => 100,
				le.bs.relatives.relative_incomeunder75_count   > 0 => 75,
				le.bs.relatives.relative_incomeunder50_count   > 0 => 50,
				le.bs.relatives.relative_incomeunder25_count   > 0 => 25,
				0);
			
		
     IV_rel_low_income := if(rel_income <= 50,1,0);
    

     /* model */
     mod21 := (-4.661186905
                  + IV_ecen_lghh  * 0.4371127128
                  + IV_ecen_highinp0_f  * 1.8356704584
                  + IV_ecen_new_homes  * -0.002448306
                  + IV_ecen_lowrent  * 0.2812170448
                  + IV_ecen_high_housingCPI_f  * 1.5500254078
                  + IV_ecen_rental_lot_f  * 0.126382867
                  + IV_ecen_milemp_f  * -0.207909979
                  + IV_ecen_crime_high_f  * 0.781418693
                  + IV_ecen_lowrent_p2_log  * 0.0833357434
                  + iv_ver_nas4  * 0.346843096
                  + IV_phone_not_found  * 0.724417215
                  + nap_ver  * 0.3015057117
                  + IV_special_deliver  * 1.5805474958
                  + IV_criminal_flag  * 0.2879313436
                  + lien_unrel_count_m  * 13.113143968
                  + IV_rel_low_income  * 0.2517276159)
     ;

     phat := (exp(mod21 )) / (1+exp(mod21 ));


	base  := 685;
     odds  := .090;
     point := -105;     

     temp_score := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
		
    
	MSN605_1_0 :=map(temp_score <=1 => 1,
				  temp_score >=999 =>999,
				  temp_score);   

     

/************************************************************************************
 * Return MSN605_1_0                                                                *
 ************************************************************************************/
		
	
	SELF.score := (string)MSN605_1_0;
	SELF.seq := le.bs.seq;
	self       := [];
END;

scores := PROJECT(results, doModel(LEFT));

RETURN (scores);


end;