IMPORT STD;

EXPORT FCRAPurpose := MODULE

  EXPORT INTEGER NoValueProvided                      := -1;
  EXPORT INTEGER NoPermissiblePurpose                 := 0;
	// below are basic codes - full codes should have hard or soft indicator defined in dataset
  SHARED INTEGER CreditApplication                    := 10;
  SHARED INTEGER BenefitGranting                      := 11;
  SHARED INTEGER ChildSupport                         := 12;
  SHARED INTEGER Collections                          := 13;
  SHARED INTEGER CourtOrderOrSubpoena                 := 14;
  SHARED INTEGER DemandDeposit                        := 15;
  SHARED INTEGER EmploymentScreening                  := 16;
  SHARED INTEGER InsurancePrescreening                := 17;
  SHARED INTEGER Government                           := 18;
  SHARED INTEGER HealthcareCreditTransaction          := 19;
  SHARED INTEGER HealthcareLegitimateBusinessNeed     := 20;
  SHARED INTEGER HousingCounselingAgency              := 21;
  SHARED INTEGER InsuranceCreditApplication           := 22;
  SHARED INTEGER InsurancePortfolioReview             := 23;
  SHARED INTEGER InsuranceRenewal                     := 24;
  SHARED INTEGER InsuranceUnderwriting                := 25;
  SHARED INTEGER Investigation                        := 26;
  SHARED INTEGER LegitimateBusinessNeed               := 27;
  SHARED INTEGER AccountReview                        := 28;
  SHARED INTEGER PotentialInvestor                    := 29;
  SHARED INTEGER PreScreening                         := 30;
  SHARED INTEGER RentalCar                            := 31;
  SHARED INTEGER TenantScreening                      := 32;
  SHARED INTEGER InstructedByConsumer                 := 33;
  SHARED INTEGER WrittenConsentDirect2Consumer        := 34;
  SHARED INTEGER WrittenConsentPrequalification       := 35;
  
  // logging type - hard or soft
  SHARED INTEGER Hard := 100;
  SHARED INTEGER Soft := 200;
  
  SHARED ds_purposes := DATASET ([
    {NoValueProvided, NoValueProvided, '', 'No Value Provided'},
    {NoPermissiblePurpose, NoPermissiblePurpose,  'NO FCRA PURPOSE', 'I do not have an FCRA Permissible Use.'},
    {CreditApplication+Hard, 1, 'Credit Application','For the extension of credit to the consumer in connection with a credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {CreditApplication+Hard, 100, 'Credit Application','For the extension of credit to the consumer in connection with a credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {CreditApplication+Hard, 101, 'Credit Application','For the extension of credit to the consumer in connection with a credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {Collections+Hard, 2, 'Collections','For the collection of an account of the consumer in connection with a credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {Collections+Hard, 164, 'Collections','For the collection of an account of the consumer in connection with a credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {DemandDeposit+Hard, 106,'Demand Deposit','Demand Deposit'},
    {Government+Soft, 3,'Government License or Benefit','For use in connection with a determination of the consumer\'s eligibility for a license or other benefit granted by a governmental instrumentality required by law to consider an applicant\'s financial responsibility or status in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(D).'},
    {EmploymentScreening+Soft, 165,'Employment Screening','Employment Screening'},
    {HealthcareCreditTransaction+Soft, 4, 'Healthcare Credit Application','For the extension of credit to, or review or collection of an account of the consumer in connection with a medical or hospitalization credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {HealthcareLegitimateBusinessNeed+Soft, 5,'Healthcare Legitimate Business Need','In connection with medical care ability to pay assessments, a legitimate business need pursuant to 15 U.S.C. Sec. 1681(b)(a)(3)(F)(i).'},
    {InsuranceCreditApplication+Soft, 6, 'Insurance Credit Application','For use in connection with the underwriting of insurance involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(B).'},
    {InsurancePortfolioReview+Soft, 7, 'Insurance Portfolio Review','For use, as a potential investor or servicer, or current insurer, in connection with a valuation of, or an assessment of the credit or prepayment risks associated with, an existing credit obligation in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(E).'},
    {AccountReview+Soft, 8, 'Account Review','For the review of an account of the consumer in connection with a credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {AccountReview+Soft, 12, 'Account Review','For the review of an account of the consumer in connection with a credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {PreScreening+Soft, 9,'Prescreen','For firm offers of credit or insurance that are not initiated by the consumer in accordance with 15 U.S.C. Sec.1681(b)(c).'},
    {TenantScreening+Hard, 11, 'Tenant Screening','In connection with applications for apartment or other property rentals initiated by the consumer, a legitimate business need pursuant to 15 U.S.C. Sec. 1681(b)(a)(3)(F)(i).'},
    {InstructedByConsumer+Soft, 13,'Written Consent','Written Consent'}, //'Written Consent - Instructed By Consumer'

    {CreditApplication+Soft, NoValueProvided, 'Credit Application','For the extension of credit to the consumer in connection with a credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {Collections+Soft, NoValueProvided, 'Collections','For the collection of an account of the consumer in connection with a credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {Government+Hard, NoValueProvided,'Government License or Benefit','For use in connection with a determination of the consumer\'s eligibility for a license or other benefit granted by a governmental instrumentality required by law to consider an applicant\'s financial responsibility or status in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(D).'},
    {HealthcareCreditTransaction+Hard, NoValueProvided, 'Healthcare Credit Application','For the extension of credit to, or review or collection of an account of the consumer in connection with a medical or hospitalization credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {HealthcareLegitimateBusinessNeed+Hard, NoValueProvided,'Healthcare Legitimate Business Need','In connection with medical care ability to pay assessments, a legitimate business need pursuant to 15 U.S.C. Sec. 1681(b)(a)(3)(F)(i).'},
    {InsuranceCreditApplication+Hard, NoValueProvided, 'Insurance Credit Application','For use in connection with the underwriting of insurance involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(B).'},
    {InsurancePortfolioReview+Hard, NoValueProvided, 'Insurance Portfolio Review','For use, as a potential investor or servicer, or current insurer, in connection with a valuation of, or an assessment of the credit or prepayment risks associated with, an existing credit obligation in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(E).'},
    {AccountReview+Hard, NoValueProvided, 'Account Review','For the review of an account of the consumer in connection with a credit transaction involving the consumer in accordance with 15 U.S.C. Sec.1681(b)(a)(3)(A).'},
    {PreScreening+Hard, NoValueProvided,'Prescreen','For firm offers of credit or insurance that are not initiated by the consumer in accordance with 15 U.S.C. Sec.1681(b)(c).'},
    {TenantScreening+Soft, NoValueProvided, 'Tenant Screening','In connection with applications for apartment or other property rentals initiated by the consumer, a legitimate business need pursuant to 15 U.S.C. Sec. 1681(b)(a)(3)(F)(i).'},
    {InstructedByConsumer+Hard, NoValueProvided,'Written Consent','Written Consent - Instructed By Consumer'},
    {DemandDeposit+Soft, NoValueProvided,'Demand Deposit','Demand Deposit'},
    {EmploymentScreening+Hard, NoValueProvided,'Employment Screening','Employment Screening'},
		
    {BenefitGranting+Hard, NoValueProvided,'Benefit Granting','Benefit Granting'},
    {BenefitGranting+Soft, NoValueProvided,'Benefit Granting','Benefit Granting'},
    {ChildSupport+Hard, NoValueProvided,'Child Support','Child Support'},
    {ChildSupport+Soft, NoValueProvided,'Child Support','Child Support'},
    {CourtOrderOrSubpoena+Hard, NoValueProvided,'Court Order Or Subpoena','Court Order Or Subpoena'},
    {CourtOrderOrSubpoena+Soft, NoValueProvided,'Court Order Or Subpoena','Court Order Or Subpoena'},
    {InsurancePrescreening+Hard, NoValueProvided,'Insurance Prescreening','Insurance Prescreening'},
    {InsurancePrescreening+Soft, NoValueProvided,'Insurance Prescreening','Insurance Prescreening'},
    {HousingCounselingAgency+Hard, NoValueProvided,'Housing Counseling Agency','Housing Counseling Agency'},
    {HousingCounselingAgency+Soft, NoValueProvided,'Housing Counseling Agency','Housing Counseling Agency'},
    {InsuranceRenewal+Hard, NoValueProvided,'Insurance Renewal','Insurance Renewal'},
    {InsuranceRenewal+Soft, NoValueProvided,'Insurance Renewal','Insurance Renewal'},
    {InsuranceUnderwriting+Hard, NoValueProvided,'Insurance Underwriting','Insurance Underwriting'},
    {InsuranceUnderwriting+Soft, NoValueProvided,'Insurance Underwriting','Insurance Underwriting'},
    {Investigation+Hard, NoValueProvided,'Investigation','Investigation'},
    {Investigation+Soft, NoValueProvided,'Investigation','Investigation'},
    {LegitimateBusinessNeed+Hard, NoValueProvided,'Legitimate Business Need','Legitimate Business Need'},
    {LegitimateBusinessNeed+Soft, NoValueProvided,'Legitimate Business Need','Legitimate Business Need'},
    {PotentialInvestor+Hard, NoValueProvided,'Potential Investor','Potential Investor'},
    {PotentialInvestor+Soft, NoValueProvided,'Potential Investor','Potential Investor'},
    {RentalCar+Hard, NoValueProvided,'Rental Car','Rental Car'},
    {RentalCar+Soft, NoValueProvided,'Rental Car','Rental Car'},
    {WrittenConsentDirect2Consumer+Hard, NoValueProvided,'Written Consent - Direct to Consumert','Written Consent - Direct to Consumer'},
    {WrittenConsentDirect2Consumer+Soft, NoValueProvided,'Written Consent - Direct to Consumert','Written Consent - Direct to Consumer'},
    {WrittenConsentPrequalification+Hard, NoValueProvided,'Written Consent - Prequalification','Written Consent - Prequalification'},
    {WrittenConsentPrequalification+Soft, NoValueProvided,'Written Consent - Prequalification','Written Consent - Prequalification'}
  ], {INTEGER new_code, INTEGER old_code,  STRING name, STRING description});
  
  
  dict_newcodes := DICTIONARY(ds_purposes, {new_code});

  SHARED is_val_ok(INTEGER v) := ((v > NoPermissiblePurpose) AND (v IN dict_newcodes)); 
 
  SHARED dict_Old2New := DICTIONARY (ds_purposes(old_code > NoPermissiblePurpose), {old_code => new_code});
	
  convert_old2new(INTEGER __old_code) := dict_Old2New[__old_code].new_code;

  EXPORT INTEGER ConvertAndValidate(INTEGER _in_purpose = NoValueProvided) := FUNCTION
    INTEGER alt_val := convert_old2new(_in_purpose); // attempt to convert old purpose code to new value
    INTEGER purpose := MAP(is_val_ok(_in_purpose) => _in_purpose, 
                         is_val_ok(alt_val) => alt_val, 
                         NoPermissiblePurpose); 
    RETURN purpose;        
  END;
	
  EXPORT INTEGER Get(STRING in_fcra_purpose = '') := FUNCTION
    STRING g_val := '' : STORED('FCRAPurpose');    
    val := IF(in_fcra_purpose <> '', in_fcra_purpose, g_val);
    INTEGER ival := (INTEGER) val; 
		RETURN MAP(is_val_ok(ival) => ival,  // we expect new codes for permissible purpose
		           ival = 6 => InsuranceCreditApplication+Soft, // for insurance application we will support/convert old to new code till we switch to use new only
							 ival IN dict_Old2New => ival,  // old permissible code is accepted till we switch to use new only
							 NoPermissiblePurpose);        
  END;

  EXPORT Params := INTERFACE
    EXPORT INTEGER FCRAPurpose := NoValueProvided;
  END;

  EXPORT BOOLEAN isInsuranceCreditApplication(INTEGER __code) := __code in [InsuranceCreditApplication+Soft, InsuranceCreditApplication+Hard];
  EXPORT BOOLEAN isEmploymentScreening(INTEGER __code) := __code in [EmploymentScreening+Soft, EmploymentScreening+Hard];
  EXPORT BOOLEAN isDemandDeposit(INTEGER __code) := __code in [DemandDeposit+Soft, DemandDeposit+Hard];
  EXPORT BOOLEAN isCollections(INTEGER __code) := __code in [Collections+Soft, Collections+Hard];
  EXPORT BOOLEAN isCreditApplication(INTEGER __code) := __code in [CreditApplication+Soft, CreditApplication+Hard];

END;