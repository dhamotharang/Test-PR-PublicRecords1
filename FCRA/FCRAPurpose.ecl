IMPORT STD;

EXPORT FCRAPurpose := MODULE

	EXPORT integer NoValueProvided 											:= -1;
	EXPORT integer NoPermissiblePurpose 								:= 0;
	EXPORT integer Application 													:= 1;
	EXPORT integer Collections 													:= 2;
	EXPORT integer Government 													:= 3;
	EXPORT integer HealthcareCreditTransaction 					:= 4;
	EXPORT integer HealthcareLegitimateBusinessNeed 		:= 5;
	EXPORT integer InsuranceApplication 								:= 6;
	EXPORT integer InsurancePortfolioReview 						:= 7;
	EXPORT integer PortfolioReview 											:= 8;
	EXPORT integer PreScreening 												:= 9;
	EXPORT integer RentalCarLossDamageWaiver 						:= 10;
	EXPORT integer TenantScreening 											:= 11;
	EXPORT integer AccountReview 												:= 12;
	EXPORT integer InstructedByConsumer 								:= 13;
  
	EXPORT Params := INTERFACE
		EXPORT integer FCRAPurpose := NoValueProvided;
	END;

 ds_purposes := DATASET ([
				{NoValueProvided, '', 'No Value Provided'},
				{NoPermissiblePurpose, 'NOFCRAPURPOSE', 'I do not have an FCRA Permissible Use.'},
    {Application, 'APPLICATION','For the extension of credit to the consumer in connection with a credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {Collections, 'COLLECTIONS','For the collection of an account of the consumer in connection with a credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {Government,'GOVERNMENT','For use in connection with a determination of the consumer\'s eligibility for a license or other benefit granted by a governmental instrumentality required by law to consider an applicant\'s financial responsibility or status in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(D).'},
    {HealthcareCreditTransaction,'HEALTHCARECREDITTRANSACTION','For the extension of credit to, or review or collection of an account of the consumer in connection with a medical or hospitalization credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {HealthcareLegitimateBusinessNeed,'HEALTHCARELEGITIMATEBUSINESSNEED','In connection with medical care ability to pay assessments, a legitimate business need pursuant to 15 U.S.C. Sec. 1681(b)(a)(3)(F)(i).'},
    {InsuranceApplication,'INSURANCEAPPLICATION','For use in connection with the underwriting of insurance involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(B).'},
    {InsurancePortfolioReview,'INSURANCEPORTFOLIOREVIEW','For use, as a potential investor or servicer, or current insurer, in connection with a valuation of, or an assessment of the credit or prepayment risks associated with, an existing credit obligation in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(E).'},
    {PortfolioReview,'PORTFOLIOREVIEW','For the review of an account of the consumer in connection with a credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {PreScreening,'PRESCREENING','For firm offers of credit or insurance that are not initiated by the consumer in accordance with 15 U.S.C. Sec.1681(b)(c).'},
    {RentalCarLossDamageWaiver,'RENTALCARLOSSDAMAGEWAIVER','In connection with a rental car transaction involving determination of loss damage waiver where the transaction is initiated by the consumer, a legitimate business need pursuant to 15 U.S.C. Sec. 1681b(a)(3)(F)(i).'},
    {TenantScreening,'TenantScreening','In connection with applications for apartment or other property rentals initiated by the consumer, a legitimate business need pursuant to 15 U.S.C. Sec. 1681(b)(a)(3)(F)(i).'},
    {AccountReview,'ACCOUNTREVIEW','Account Review'},
    {InstructedByConsumer,'INSTRUCTEDBYCONSUMER','Instructed By Consumer'}
  ], {INTEGER number, STRING word, STRING description});


	is_val_ok(integer v) := ((v > NoPermissiblePurpose) and (v <= InstructedByConsumer)); 
 
 dict_String2Number := DICTIONARY (ds_purposes, {word => number});
	convert_word2number(STRING in_str) := dict_String2Number[STD.Str.ToUpperCase(in_str)].number;

	EXPORT integer Get(string in_fcra_purpose = '') := FUNCTION
		string g_val := '' : stored('FCRAPurpose');		
		val := IF(in_fcra_purpose <> '', in_fcra_purpose, g_val);
		integer ival := (integer) val; 
		integer alt_val := convert_word2number(val); // attempt to convert purpose coming as wording to integer
		integer purpose := MAP(is_val_ok(ival) => ival, 
                         is_val_ok(alt_val) => alt_val, 
                         NoPermissiblePurpose); 
		return purpose;				
	END;

END;