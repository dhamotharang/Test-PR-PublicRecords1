export Constants := module

export SEQ_MAX_LIMIT := 500;
export age_threshold := 18;
export mile_threshold := 100;

export DOB_RISKCODE := 'EDOB';  // new risk code for DOB based on below line logic.
export DOB_RISKCODE_MESSAGE := 'Number of years on the job/in that profession inconsistent with borrower(s) age';

export MILES_BETWEEN_HOME_WORK_RISKCODE := 'EMIL'; // new RISK code for Miles apart between person and employer
export MILES_BETWEEN_HOME_WORK_RISKCODE_MESSAGE:= 
               'The input home address and work/ business address are geographically distant (>100 miles)';
							 
export BORROWER_SALARY_UNDER_MARKET_CODE := 'SLUM';						 
export BORROWER_SALARY_UNDER_MARKET_MSG  := 'Income stated is below Estimated Earning Range for Profession';

export BORROWER_SALARY_WITHIN_MARKET_CODE := 'SLWM';
export BORROWER_SALARY_WITHIN_MARKET_MSG  := 'Income stated is within Estimated Earning Range for Profession';

export BORROWER_SALARY_ABOVE_MARKET_CODE := 'SLAM';
export BORROWER_SALARY_ABOVE_MARKET_MSG  := 'Income stated is above Estimated Earning Range for Profession';

export GATEWAY_ERROR_CODE := 'Missing gateway information';

end;