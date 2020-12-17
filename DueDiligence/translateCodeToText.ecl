IMPORT DueDiligence, Header;

EXPORT translateCodeToText := MODULE

SHARED DEFAULT_EMPTY := DueDiligence.Constants.EMPTY;
SHARED DEFAULT_UNKNOWN := 'Unknown';


EXPORT YesNoUnknownText(STRING1 code) := CASE(code,
                                                DueDiligence.Constants.YES => 'Yes',
                                                DueDiligence.Constants.NO => 'No',
                                                DueDiligence.Constants.UNKNOWN => DEFAULT_UNKNOWN,
                                                DEFAULT_EMPTY); 
                                                
EXPORT GenderText(STRING1 code) := CASE(code,
                                          'F' => 'Female',
                                          'M' => 'Male',
                                          DEFAULT_EMPTY);                                                

                                                    
EXPORT OffenseLevelText(STRING1 code) := CASE(code,
                                                DueDiligence.ConstantsLegal.FELONY => 'Felony',
                                                DueDiligence.ConstantsLegal.MISDEMEANOR => 'Misdemeanor',
                                                DueDiligence.ConstantsLegal.INFRACTION => 'Infraction',
                                                DueDiligence.ConstantsLegal.TRAFFIC => 'Traffic',
                                                DEFAULT_UNKNOWN);
																								
EXPORT IndustryRiskText(STRING code) := CASE(code,
                                              DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL => 'Cash Intensive',
                                              DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL => 'Cash Intensive',
                                              DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS => 'Money Service',
                                              DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS => 'Non-Banking Financial Institution',
                                              DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING => 'Casino and Gaming',
                                              DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL => 'Legal, Accountant, Telemarketing, Flight, Travel',
                                              DueDiligence.Constants.INDUSTRY_AUTOMOTIVE => 'Automotive',
                                              DueDiligence.Constants.RISK_LEVEL_HIGH => 'High-Risk',
                                              DueDiligence.Constants.RISK_LEVEL_MEDIUM => 'Medium-Risk',
                                              DueDiligence.Constants.RISK_LEVEL_LOW => 'Low-Risk',
                                              DEFAULT_EMPTY);

EXPORT RelationshipText(UNSIGNED code) := CASE(code,
                                                DueDiligence.Constants.RELATIONSHIP_ROOM_MATE => 'Roommate',
                                                DueDiligence.Constants.RELATIONSHIP_BUSINESS => 'Business',
                                                DueDiligence.Constants.RELATIONSHIP_REAL_ESTATE => 'Real Property',
                                                DueDiligence.Constants.RELATIONSHIP_OTHER_PROPERTY => 'Personal Property',
                                                Header.relative_titles.fn_get_str_title(code));                                          

END;;