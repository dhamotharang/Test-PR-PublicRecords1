/* Modeling group is calling this model CEN509_0_1 as it is the second version with score caps added. We are keeping the 
		original name CEN509_0_0  */

import risk_indicators;

export CEN509_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam) := 

FUNCTION


Layout_ModelOut doModel(clam le) := transform

     add1_census_age_cred := MAP(le.address_verification.input_address_information.census_age = '' => 35,
						   (integer)le.address_verification.input_address_information.census_age <= 25 => 25,
						   (integer)le.address_verification.input_address_information.census_age >= 52 => 52,
						   (integer)le.address_verification.input_address_information.census_age);


     add1_census_income_cred := MAP(le.address_verification.input_address_information.census_income = '' => 43000,
							 (integer)le.address_verification.input_address_information.census_income <= 15000 => 19000,
							 (integer)le.address_verification.input_address_information.census_income >= 100000 => 120000,
							 (integer)le.address_verification.input_address_information.census_income);


     add1_census_education_cred := MAP(le.address_verification.input_address_information.census_education = '' => 13,
							    (integer)le.address_verification.input_address_information.census_education <= 12 => 12,
							    (integer)le.address_verification.input_address_information.census_education >= 15 => 16,
							    (integer)le.address_verification.input_address_information.census_education);



     cenmod_cred1 := 0.7971724944
				+ add1_census_age_cred  * -0.044671991
				+ add1_census_income_cred  * -0.000014599
				+ add1_census_education_cred  * -0.090235395;
     cenmod_cred2 := (exp(cenmod_cred1)) / (1+exp(cenmod_cred1));
     cenmod_cred3 := round(10000 * cenmod_cred2);
	cenmod_cred := cenmod_cred3 / 10;

     Cen6Boca1 := round(10 * ( (0.0015)*cenmod_cred*cenmod_cred + (0.1699)*cenmod_cred + 12.399));
	Cen6Boca_pre_cap := Cen6Boca1 / 10;
	
	Cen6Boca := MAP(Cen6Boca_pre_cap > 99 => 99,
									Cen6Boca_pre_cap < 1 => 1,
									Cen6Boca_pre_cap);

	SELF.score := (string)Cen6Boca;
	SELF.seq := le.seq;
	SELF.ri := [];
END;
out := PROJECT(clam, doModel(LEFT));

RETURN (out);

END;