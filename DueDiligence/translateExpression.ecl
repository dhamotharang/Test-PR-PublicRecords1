IMPORT DueDiligence, STD;

EXPORT translateExpression := MODULE

    //List of category levels
    EXPORT LEVEL_9 := 9;
    EXPORT LEVEL_8 := 8;
    EXPORT LEVEL_7 := 7;
    EXPORT LEVEL_6 := 6;
    EXPORT LEVEL_5 := 5;
    EXPORT LEVEL_4 := 4;
    EXPORT LEVEL_3 := 3;
    EXPORT LEVEL_2 := 2;
    SHARED LEVEL_0 := 0;  //not actual level - used to catch if it doesn't fall into a level hit (ie UNCATEGORIZED)
    
    //Unique ID used to identify a category - these should not change and new ones being added at the end
    //DO NOT CHANGE ORDER OF THESE
    SHARED OffenseID := ENUM(UNCATEGORIZED = 0, NO_OFFENSE_PROVIDED, HUNT_FISH, LIVESTOCK_DOMESTIC_ANIMAL, ORDINANCE_INFRACTION, 
                                ELDER_EXPLOIT, FAMILY_PROVIDER_ABUSE, ANIMAL_FIGHT, DUI, ALCOHOL, GANG, FUGITIVE, RIOT, POISON, EPA, 
                                ZONING, TREASON, HARASS, CYBER_STALK, VIOLATE_ORDER, PROBATION_VIOLATION, MISCONDUCT, CYBER, ARSON, 
                                B_AND_E, BURGLARY, CARJACK, TRAFFIC, SYNDICALISM, SANCTION, HOMOCIDE, KIDNAP, HATE_CRIME, RETALIATION, 
                                CORRUPT_MINOR, RAPE, BOOBY_TRAP, SABOTAGE, VANDALISM, CHILD_SUPPORT, COURT, AGG_THEFT, THEFT, SOLICITATION, 
                                SOLICITATION_SEX, PORN, PROSTITUTION, SEX, MONEY_LAUNDER, GAMBLE, DISORDERLY_CONDUCT, TERRORISM, 
                                ORGANIZED_CRIME, OBSTRUCT_JUSTICE, ELECTION_CORRUPTION, POLITICAL_CORRUPTION, CORRUPTION_BRIBERY, 
                                FRAUD, WIRE_FRAUD, BANK_FRAUD, FINANCIAL_FRAUD, TAX_FRAUD, MORTGAGE_FRAUD, HEALTHCARE_FRAUD, 
                                EMPLOYMENT_FRAUD, INSURANCE_FRAUD, ORGANIZED_FRAUD, INVOICE_FRAUD, CHECK_FRAUD, CONSPIRACY, PERJURY, 
                                OBSTRUCTION, TAMPERING, TAX_EVASION, COUNTERFEIT, ID_FRAUD_THEFT, IMPERSONATION, BLACKMAIL, CHOP_SHOP, 
                                ROBBERY, BANK_ROBBERY, ARMED_ROBBERY, DEADLY_CONDUCT, ASSAULT, RESISTING_ARREST, DIGITAL_CURRENCY, 
                                ANTITRUST, SECURITIES_COMMODITIES, RACKETEERING, MONEY_TRANSMITTER, STRUCTURING, IMPORT_EXPORT, 
                                TRANSPORTATION, COMMUNICATION_INTERCEPT, OPERATE_NO_LICENSE, EMBEZZLEMENT, TAX, CONCEAL_FUNDS_PROPERTY, 
                                OBTAIN_PROP_FALSE_PRETENSE, DAMAGE_DESTROY, SHOPLIFTING, TRESPASSING, CRIMINAL_PROCEEDS, HUMAN_TRAFFICKING, 
                                DRUG_TRAFFICKING, ARMS_TRAFFICKING, OTHER_TRAFFICKING, EXPLOSIVES, WEAPONS, DRUGS, IMMIGRATION, DIST_DRUGS_WEAPONS);
    
    //When weight/priority changes, just need to change order of the enum list here
    //list in ascending order from least important to highest - largest offense will have highest weight/priority
    EXPORT OffensePriority := ENUM(UNCATEGORIZED = 0, NO_OFFENSE_PROVIDED,  
    
                                  //Level 2 order
                                  ORDINANCES_AND_INFRACTIONS, COURT_CHARGES, LIVESTOCK_DOMESTIC_ANIMALS, HUNT_FISH_GAME_OFFENSES,
                                  ALCOHOL_RELATED, TRAFFIC_OFFENSES, ZONING, DUI, CHILD_SUPPORT,
                                  // ALCOHOL_RELATED, ZONING, DUI, CHILD_SUPPORT,
                                  ALIEN_AND_IMMIGRATION, DISORDERLY_CONDUCT, TRESPASSING, SHOPLIFTING, 

                                  //Level 3 order
                                  SANCTIONS, DAMAGE_DESTROY_ITEMS, TAMPERING, OBSTRUCTION_HINDER, PERJURY, CONSPIRACY,
                                  DIGITAL_CURRENCY, GAMBLING, COMPUTER_AND_CYBER, MISCONDUCT, 
                                  
                                  //Level 4 order                            
                                  RESISTING_ARREST_ESCAPE, PROBATION_PAROLE_VIOLATION, VIOLATING_ORDERS,
                                  FUGITIVE_OR_WARRANT, EPA_WASTE, POISONING, VANDALISM, ARSON, 
                                  FAMILY_AND_PROVIDER_ABUSE, ELDER_EXPLOITATION, SABOTAGE, RETALIATION, 
                                  HATE_CRIME_AND_CIVIL_RIGHTS, BOOBY_TRAP, RIOT_CIVIL_DISORDER, CYBER_STALKING, STALK_HARASS_TERRORIZE,
                                  ASSAULT, DEADLY_CONDUCT, KIDNAPPING_FALSE_IMPRISONMENT, MURDER_HOMOCIDE, ANIMAL_FIGHTING,
                                  
                                  //Level 5 order                            
                                  RAPE, SEX_OFFENSES, PROSTITUTION, PORNOGRAPHY, SOLICITATION, SOLICITATION_SEX, CORRUPTION_OF_MINOR, 
                                  
                                  //Level 6 order
                                  THEFT, FELONY_OR_AGGRAVATED_THEFT, BREAKING_AND_ENTERING, CAR_JACK, BURGLARY, ROBBERY, ARMED_ROBBERY, BANK_ROBBERY, 
                                  
                                  //Level 7 order
                                  FALSE_STATEMENTS_IMPERSONATION, OBTAIN_PROP_BY_FALSE_PRETENSE, CONCEAL_FUNDS_OR_PROPERTY, TAX_OFFENSES, 
                                  FRAUD, CHECK_FRAUD, IDENTITY_FRAUD_AND_THEFT, INVOICE_FRAUD, ORGANIZED_FRAUD, INSURANCE_FRAUD, 
                                  EMPLOYMENT_WORK_COMP_FRAUD, HEALTHCARE_FRAUD, MORTGAGE_FRAUD, TAX_FRAUD, CREDIT_CARD_FRAUD, BANK_FRAUD,
                                  WIRE_FRAUD, EMBEZZLEMENT, OPERATE_WITHOUT_LICENSE, FORGE_AND_COUNTERFEIT,
                                  
                                  //Level 8 order
                                  DRUGS, WEAPONS, EXPLOSIVES_DESTRUCTION_DEVICES, DISTRIBUTION_DRUGS_OR_WEAPONS, TRAFFICKING_SMUGGLING_OTHER,
                                  TRAFFICKING_SMUGGLING_ARMS, TRAFFICKING_SMUGGLING_DRUGS, TRAFFICKING_SMUGGLING_HUMAN,
                                  
                                  //Level 9 order
                                  COMMUNICATION_INTERCEPTION, CHOP_SHOP, GANG_ACTIVITIES, TRANSPORTATION_VIOLATIONS, IMPORT_EXPORT,
                                  STRUCTURING, MONEY_TRANSMITTER, CRIMINAL_PROCEEDS, CORRUPTION_OR_BRIBERY, POLITICAL_CORRUPTION, ELECTION_CORRUPTION, 
                                  OBSTRUCTION_OF_JUSTICE, ORGANIZED_CRIME, EXTORTION_AND_BLACKMAIL, RACKETEERING, SECURITIES_AND_COMMODITIES, 
                                  ANTITRUST_VIOLATIONS, TAX_EVASION, MONEY_LAUNDERING, CRIMINAL_SYNDICALISM, TREASON_ESPIONAGE, TERRORISM);
                                  // ANTITRUST_VIOLATIONS, TAX_EVASION, MONEY_LAUNDERING, CRIMINAL_SYNDICALISM, TREASON_ESPIONAGE, TERRORISM, TRAFFIC_OFFENSES);
    

                                  
                                  
                                  
                                  
    SHARED ExpressionDSLayout := RECORD
      UNSIGNED4 id; //this is a unique ID per offense - this should not change
      UNSIGNED4 priorityOrder; //identifier used as a weight for picking priority
      STRING expressionToUse;
      UNSIGNED1 level; 
      STRING100 description;     
    END;
    

    SHARED expressionDS := DATASET([
                                    {OffenseID.UNCATEGORIZED,              OffensePriority.UNCATEGORIZED,                  DueDiligence.Constants.EMPTY,                                            LEVEL_0,   'Uncategorized'},
                                                                                                                                                                  
                                    {OffenseID.NO_OFFENSE_PROVIDED,        OffensePriority.NO_OFFENSE_PROVIDED,            DueDiligence.Constants.EMPTY,                                            LEVEL_2,   'No Offense Provided'},
                                    {OffenseID.HUNT_FISH,                  OffensePriority.HUNT_FISH_GAME_OFFENSES,        DueDiligence.RegularExpressions.HUNT_FISH_GAME_OFFENSES,                 LEVEL_2,   'Hunt, Fish and Game Offenses'},
                                    {OffenseID.LIVESTOCK_DOMESTIC_ANIMAL,  OffensePriority.LIVESTOCK_DOMESTIC_ANIMALS,     DueDiligence.RegularExpressions.LIVESTOCK_DOMESTIC_ANIMALS,              LEVEL_2,   'Livestock and Domestic Animal Offenses'},
                                    {OffenseID.ORDINANCE_INFRACTION,       OffensePriority.ORDINANCES_AND_INFRACTIONS,     DueDiligence.RegularExpressions.ORDINANCES_AND_INFRACTIONS,              LEVEL_2,   'Ordinances and Infractions'},
                                    {OffenseID.DUI,                        OffensePriority.DUI,                            DueDiligence.RegularExpressions.DUI,                                     LEVEL_2,   'DUI'},
                                    {OffenseID.ALCOHOL,                    OffensePriority.ALCOHOL_RELATED,                DueDiligence.RegularExpressions.ALCOHOL,                                 LEVEL_2,   'Alcohol Related'},
                                    {OffenseID.ZONING,                     OffensePriority.ZONING,                         DueDiligence.RegularExpressions.ZONING_BUILDING_VIOLATIONS,              LEVEL_2,   'Zoning and Building Violations'},
                                    {OffenseID.TRAFFIC,                    OffensePriority.TRAFFIC_OFFENSES,               DueDiligence.RegularExpressions.TRAFFIC_RELATED,                         LEVEL_2,   'Traffic Related'},
                                    {OffenseID.CHILD_SUPPORT,              OffensePriority.CHILD_SUPPORT,                  DueDiligence.RegularExpressions.CHILD_SUPPORT_AND_CUSTODY,               LEVEL_2,   'Child Support and Custody'},
                                    {OffenseID.COURT,                      OffensePriority.COURT_CHARGES,                  DueDiligence.RegularExpressions.COURT_CHARGES,                           LEVEL_2,   'Court Charges'},
                                    {OffenseID.DISORDERLY_CONDUCT,         OffensePriority.DISORDERLY_CONDUCT,             DueDiligence.RegularExpressions.DISORDERY_CONDUCT,                       LEVEL_2,   'Disorderly Conduct'},
                                    {OffenseID.SHOPLIFTING,                OffensePriority.SHOPLIFTING,                    DueDiligence.RegularExpressions.SHOPLIFTING,                             LEVEL_2,   'Shoplifting'},
                                    {OffenseID.TRESPASSING,                OffensePriority.TRESPASSING,                    DueDiligence.RegularExpressions.TRESPASSING,                             LEVEL_2,   'Trespassing'},
                                    {OffenseID.IMMIGRATION,                OffensePriority.ALIEN_AND_IMMIGRATION,          DueDiligence.RegularExpressions.IMMIGRATION_ALIEN,                       LEVEL_2,   'Immigration and Alien'},
                                                                                                                                                                                                      
                                    {OffenseID.MISCONDUCT,                 OffensePriority.MISCONDUCT,                     DueDiligence.RegularExpressions.MISCONDUCT,                              LEVEL_3,   'Misconduct'},
                                    {OffenseID.CYBER,                      OffensePriority.COMPUTER_AND_CYBER,             DueDiligence.RegularExpressions.COMPUTER_AND_CYBER,                      LEVEL_3,   'Computer and Cyber'},
                                    {OffenseID.SANCTION,                   OffensePriority.SANCTIONS,                      DueDiligence.RegularExpressions.SANCTIONS_GENERAL,                       LEVEL_3,   'Sanctions'},
                                    {OffenseID.GAMBLE,                     OffensePriority.GAMBLING,                       DueDiligence.RegularExpressions.GAMBLING_AND_CASINO,                     LEVEL_3,   'Gambling and Casino'},
                                    {OffenseID.CONSPIRACY,                 OffensePriority.CONSPIRACY,                     DueDiligence.RegularExpressions.CONSPIRACY,                              LEVEL_3,   'Conspiracy - General'},
                                    {OffenseID.PERJURY,                    OffensePriority.PERJURY,                        DueDiligence.RegularExpressions.PERJURY,                                 LEVEL_3,   'Perjury - General'},
                                    {OffenseID.OBSTRUCTION,                OffensePriority.OBSTRUCTION_HINDER,             DueDiligence.RegularExpressions.OBSTRUCTION_HINDER,                      LEVEL_3,   'Obstruction and Hinder - General'},
                                    {OffenseID.TAMPERING,                  OffensePriority.TAMPERING,                      DueDiligence.RegularExpressions.TAMPERING,                               LEVEL_3,   'Tampering - General'},
                                    {OffenseID.DIGITAL_CURRENCY,           OffensePriority.DIGITAL_CURRENCY,               DueDiligence.RegularExpressions.DIGITAL_CURRENCY,                        LEVEL_3,   'Digital Currency'},
                                    {OffenseID.DAMAGE_DESTROY,             OffensePriority.DAMAGE_DESTROY_ITEMS,           DueDiligence.RegularExpressions.DAMAGE_AND_DESTROY,                      LEVEL_3,   'Damage and Destroy Items - General'},
                                                                                                                                                                                                      
                                    {OffenseID.ELDER_EXPLOIT,              OffensePriority.ELDER_EXPLOITATION,             DueDiligence.RegularExpressions.ELDER_EXPLOITATION,                      LEVEL_4,   'Elder Exploitation'},
                                    {OffenseID.FAMILY_PROVIDER_ABUSE,      OffensePriority.FAMILY_AND_PROVIDER_ABUSE,      DueDiligence.RegularExpressions.FAMILY_AND_PROVIDER_ABUSE,               LEVEL_4,   'Family and Provider Abuse'},
                                    {OffenseID.ANIMAL_FIGHT,               OffensePriority.ANIMAL_FIGHTING,                DueDiligence.RegularExpressions.ANIMAL_FIGHTING,                         LEVEL_4,   'Animal Fighting'},
                                    {OffenseID.FUGITIVE,                   OffensePriority.FUGITIVE_OR_WARRANT,            DueDiligence.RegularExpressions.FUGITIVE_OR_WARRANT,                     LEVEL_4,   'Fugitive or Warrant'},
                                    {OffenseID.RIOT,                       OffensePriority.RIOT_CIVIL_DISORDER,            DueDiligence.RegularExpressions.RIOTS_AND_CIVIL_DISORDER,                LEVEL_4,   'Riot and Civil Disorder'},
                                    {OffenseID.POISON,                     OffensePriority.POISONING,                      DueDiligence.RegularExpressions.POISONING,                               LEVEL_4,   'Poisoning'},
                                    {OffenseID.EPA,                        OffensePriority.EPA_WASTE,                      DueDiligence.RegularExpressions.EPA_WASTE,                               LEVEL_4,   'EPA and Waste'},
                                    {OffenseID.HARASS,                     OffensePriority.STALK_HARASS_TERRORIZE,         DueDiligence.RegularExpressions.STALKING_TERRORIZE,                      LEVEL_4,   'Stalking and Terrorize'},
                                    {OffenseID.CYBER_STALK,                OffensePriority.CYBER_STALKING,                 DueDiligence.RegularExpressions.CYBER_STALKING,                          LEVEL_4,   'Cyber Stalking'},
                                    {OffenseID.VIOLATE_ORDER,              OffensePriority.VIOLATING_ORDERS,               DueDiligence.RegularExpressions.VIOLATING_ORDERS,                        LEVEL_4,   'Violating Orders'},
                                    {OffenseID.PROBATION_VIOLATION,        OffensePriority.PROBATION_PAROLE_VIOLATION,     DueDiligence.RegularExpressions.PROBATION_PAROLE_VIOLATION,              LEVEL_4,   'Probation or Parole Violation'},
                                    {OffenseID.ARSON,                      OffensePriority.ARSON,                          DueDiligence.RegularExpressions.ARSON,                                   LEVEL_4,   'Arson'},
                                    {OffenseID.HOMOCIDE,                   OffensePriority.MURDER_HOMOCIDE,                DueDiligence.RegularExpressions.MURDER_HOMOCIDE,                         LEVEL_4,   'Murder and Homicide'},
                                    {OffenseID.KIDNAP,                     OffensePriority.KIDNAPPING_FALSE_IMPRISONMENT,  DueDiligence.RegularExpressions.KIDNAPPING_FALSE_IMPRISONMENT,           LEVEL_4,   'Kidnapping and False Imprisonment'},
                                    {OffenseID.HATE_CRIME,                 OffensePriority.HATE_CRIME_AND_CIVIL_RIGHTS,    DueDiligence.RegularExpressions.HATE_CRIME_AND_CIVIL_RIGHTS,             LEVEL_4,   'Hate Crime and Civil Rights'},
                                    {OffenseID.RETALIATION,                OffensePriority.RETALIATION,                    DueDiligence.RegularExpressions.RETALIATION,                             LEVEL_4,   'Retaliation'},
                                    {OffenseID.BOOBY_TRAP,                 OffensePriority.BOOBY_TRAP,                     DueDiligence.RegularExpressions.BOOBY_TRAP,                              LEVEL_4,   'Booby Trap'},
                                    {OffenseID.SABOTAGE,                   OffensePriority.SABOTAGE,                       DueDiligence.RegularExpressions.SABOTAGE,                                LEVEL_4,   'Sabotage'},
                                    {OffenseID.VANDALISM,                  OffensePriority.VANDALISM,                      DueDiligence.RegularExpressions.VANDALISM,                               LEVEL_4,   'Vandalism and Criminal Mischief'},
                                    {OffenseID.DEADLY_CONDUCT,             OffensePriority.DEADLY_CONDUCT,                 DueDiligence.RegularExpressions.DEADLY_CONDUCT,                          LEVEL_4,   'Deadly Conduct'},
                                    {OffenseID.ASSAULT,                    OffensePriority.ASSAULT,                        DueDiligence.RegularExpressions.ASSAULT,                                 LEVEL_4,   'Assault'},
                                    {OffenseID.RESISTING_ARREST,           OffensePriority.RESISTING_ARREST_ESCAPE,        DueDiligence.RegularExpressions.RESIST_ARREST_OR_ESCAPE,                 LEVEL_4,   'Resist Arrest or Escape'},
                                                                                                                                                                                                      
                                    {OffenseID.CORRUPT_MINOR,              OffensePriority.CORRUPTION_OF_MINOR,            DueDiligence.RegularExpressions.CORRUPT_MINOR,                           LEVEL_5,   'Corruption of Minor'},
                                    {OffenseID.RAPE,                       OffensePriority.RAPE,                           DueDiligence.RegularExpressions.RAPE,                                    LEVEL_5,   'Rape'},
                                    {OffenseID.SOLICITATION,               OffensePriority.SOLICITATION,                   DueDiligence.RegularExpressions.SOLICITATION,                            LEVEL_5,   'Solicitation - General'},
                                    {OffenseID.SOLICITATION_SEX,           OffensePriority.SOLICITATION_SEX,               DueDiligence.RegularExpressions.SOLICITATION_SEX,                        LEVEL_5,   'Solicitation - Sex Offense Related'},
                                    {OffenseID.PORN,                       OffensePriority.PORNOGRAPHY,                    DueDiligence.RegularExpressions.PORN,                                    LEVEL_5,   'Pornography'},
                                    {OffenseID.PROSTITUTION,               OffensePriority.PROSTITUTION,                   DueDiligence.RegularExpressions.PROSTITUTION,                            LEVEL_5,   'Prostitution'},
                                    {OffenseID.SEX,                        OffensePriority.SEX_OFFENSES,                   DueDiligence.RegularExpressions.SEX_OFFENSES,                            LEVEL_5,   'Sex Offenses'},
                                                                                                                                                                                                      
                                    {OffenseID.B_AND_E,                    OffensePriority.BREAKING_AND_ENTERING,          DueDiligence.RegularExpressions.BREAKING_AND_ENTERING,                   LEVEL_6,   'Breaking and Entering'},
                                    {OffenseID.BURGLARY,                   OffensePriority.BURGLARY,                       DueDiligence.RegularExpressions.BURGLARY,                                LEVEL_6,   'Burglary'},
                                    {OffenseID.CARJACK,                    OffensePriority.CAR_JACK,                       DueDiligence.RegularExpressions.CAR_JACKING,                             LEVEL_6,   'Car Jacking'},
                                    {OffenseID.AGG_THEFT,                  OffensePriority.FELONY_OR_AGGRAVATED_THEFT,     DueDiligence.RegularExpressions.FELONY_AGGRAVATED_THEFT,                 LEVEL_6,   'Felony and Aggravated Theft'},
                                    {OffenseID.THEFT,                      OffensePriority.THEFT,                          DueDiligence.RegularExpressions.GENERAL_THEFT,                           LEVEL_6,   'General Theft'},
                                    {OffenseID.BANK_ROBBERY,               OffensePriority.BANK_ROBBERY,                   DueDiligence.RegularExpressions.BANK_ROBBERY,                            LEVEL_6,   'Bank Robbery'},
                                    {OffenseID.ARMED_ROBBERY,              OffensePriority.ARMED_ROBBERY,                  DueDiligence.RegularExpressions.ARMED_ROBBERY,                           LEVEL_6,   'Armed Robbery'},
                                    {OffenseID.ROBBERY,                    OffensePriority.ROBBERY,                        DueDiligence.RegularExpressions.ROBBERY,                                 LEVEL_6,   'Robbery'},
                                                                                                                                                                                                      
                                    {OffenseID.WIRE_FRAUD,                 OffensePriority.WIRE_FRAUD,                     DueDiligence.RegularExpressions.WIRE_FRAUD,                              LEVEL_7,   'Wire Fraud'},
                                    {OffenseID.BANK_FRAUD,                 OffensePriority.BANK_FRAUD,                     DueDiligence.RegularExpressions.BANK_FRAUD,                              LEVEL_7,   'Bank Fraud'},
                                    {OffenseID.FINANCIAL_FRAUD,            OffensePriority.CREDIT_CARD_FRAUD,              DueDiligence.RegularExpressions.FINANCIAL_CARD_FRAUD,                    LEVEL_7,   'Financial Card Fraud'},
                                    {OffenseID.TAX_FRAUD,                  OffensePriority.TAX_FRAUD,                      DueDiligence.RegularExpressions.TAX_FRAUD,                               LEVEL_7,   'Tax Fraud'},
                                    {OffenseID.MORTGAGE_FRAUD,             OffensePriority.MORTGAGE_FRAUD,                 DueDiligence.RegularExpressions.MORTGAGE_FRAUD,                          LEVEL_7,   'Mortgage Fraud'},
                                    {OffenseID.HEALTHCARE_FRAUD,           OffensePriority.HEALTHCARE_FRAUD,               DueDiligence.RegularExpressions.HEALTHCARE_FRAUD,                        LEVEL_7,   'Healthcare Fraud'},
                                    {OffenseID.EMPLOYMENT_FRAUD,           OffensePriority.EMPLOYMENT_WORK_COMP_FRAUD,     DueDiligence.RegularExpressions.EMPLOYEMENT_WORK_COMP_FRAUD,             LEVEL_7,   'Employment and Work Comp Fraud'},
                                    {OffenseID.INSURANCE_FRAUD,            OffensePriority.INSURANCE_FRAUD,                DueDiligence.RegularExpressions.INSURANCE_FRAUD,                         LEVEL_7,   'Insurance Fraud'},
                                    {OffenseID.ORGANIZED_FRAUD,            OffensePriority.ORGANIZED_FRAUD,                DueDiligence.RegularExpressions.ORGANIZED_FRAUD,                         LEVEL_7,   'Organized Fraud'},
                                    {OffenseID.INVOICE_FRAUD,              OffensePriority.INVOICE_FRAUD,                  DueDiligence.RegularExpressions.INVOICE_FRAUD,                           LEVEL_7,   'Invoice Fraud'},
                                    {OffenseID.CHECK_FRAUD,                OffensePriority.CHECK_FRAUD,                    DueDiligence.RegularExpressions.CHECK_FRAUD,                             LEVEL_7,   'Check Fraud'},
                                    {OffenseID.FRAUD,                      OffensePriority.FRAUD,                          DueDiligence.RegularExpressions.GENERAL_FRAUD,                           LEVEL_7,   'General Fraud'},
                                    {OffenseID.COUNTERFEIT,                OffensePriority.FORGE_AND_COUNTERFEIT,          DueDiligence.RegularExpressions.FORGE_AND_COUNTERFEIT,                   LEVEL_7,   'Forge and Counterfeit'},
                                    {OffenseID.ID_FRAUD_THEFT,             OffensePriority.IDENTITY_FRAUD_AND_THEFT,       DueDiligence.RegularExpressions.ID_FRAUD_AND_THEFT,                      LEVEL_7,   'Identity Fraud and Theft'},
                                    {OffenseID.IMPERSONATION,              OffensePriority.FALSE_STATEMENTS_IMPERSONATION, DueDiligence.RegularExpressions.FALSE_STATEMENT_OR_IMPERSONATION,        LEVEL_7,   'False Statement or Impersonation'},
                                    {OffenseID.OPERATE_NO_LICENSE,         OffensePriority.OPERATE_WITHOUT_LICENSE,        DueDiligence.RegularExpressions.OPERATE_WITHOUT_LICENSE,                 LEVEL_7,   'Operate Without License'},
                                    {OffenseID.EMBEZZLEMENT,               OffensePriority.EMBEZZLEMENT,                   DueDiligence.RegularExpressions.EMBEZZLE_MISAPPROPRIATE_MISMANAGE_FUNDS, LEVEL_7,   'Embezzle, Misappropriate, and Mismanagement of Funds'},
                                    {OffenseID.TAX,                        OffensePriority.TAX_OFFENSES,                   DueDiligence.RegularExpressions.TAX_OFFENSES,                            LEVEL_7,   'Tax Offenses - General'},
                                    {OffenseID.CONCEAL_FUNDS_PROPERTY,     OffensePriority.CONCEAL_FUNDS_OR_PROPERTY,      DueDiligence.RegularExpressions.CONCEAL_FUNDS_OR_PROPERTY,               LEVEL_7,   'Concealment of Funds or Property'},
                                    {OffenseID.OBTAIN_PROP_FALSE_PRETENSE, OffensePriority.OBTAIN_PROP_BY_FALSE_PRETENSE,  DueDiligence.RegularExpressions.OBTAIN_PROPERTY_BY_FALSE_PRETENSE,       LEVEL_7,   'Obtain Property by False Pretense'},

                                    {OffenseID.HUMAN_TRAFFICKING,          OffensePriority.TRAFFICKING_SMUGGLING_HUMAN,    DueDiligence.RegularExpressions.HUMAN_TRAFFICKING_SMUGGLING,             LEVEL_8,   'Human Trafficking and Smuggling'},
                                    {OffenseID.DRUG_TRAFFICKING,           OffensePriority.TRAFFICKING_SMUGGLING_DRUGS,    DueDiligence.RegularExpressions.DRUG_TRAFFICKING_SMUGGLING,              LEVEL_8,   'Drugs Trafficking and Smuggling'},
                                    {OffenseID.ARMS_TRAFFICKING,           OffensePriority.TRAFFICKING_SMUGGLING_ARMS,     DueDiligence.RegularExpressions.ARMS_TRAFFICKING_SMUGGLING,              LEVEL_8,   'Arms Trafficking and Smuggling'},
                                    {OffenseID.OTHER_TRAFFICKING,          OffensePriority.TRAFFICKING_SMUGGLING_OTHER,    DueDiligence.RegularExpressions.OTHER_TRAFFICKING_SMUGGLING,             LEVEL_8,   'Other Trafficking and Smuggling'},
                                    {OffenseID.EXPLOSIVES,                 OffensePriority.EXPLOSIVES_DESTRUCTION_DEVICES, DueDiligence.RegularExpressions.EXPLOSIVES_DEVICES,                      LEVEL_8,   'Explosives and Devices'},
                                    {OffenseID.WEAPONS,                    OffensePriority.WEAPONS,                        DueDiligence.RegularExpressions.WEAPONS,                                 LEVEL_8,   'Weapons'},
                                    {OffenseID.DRUGS,                      OffensePriority.DRUGS,                          DueDiligence.RegularExpressions.DRUGS,                                   LEVEL_8,   'Drugs'},
                                    {OffenseID.DIST_DRUGS_WEAPONS,         OffensePriority.DISTRIBUTION_DRUGS_OR_WEAPONS,  DueDiligence.RegularExpressions.MANUFACTURE_DISTRIBUTE_DRUGS_WEAPONS,    LEVEL_8,   'Manufacture and Distribute Drugs and Weapons'},

                                    {OffenseID.GANG,                       OffensePriority.GANG_ACTIVITIES,                DueDiligence.RegularExpressions.GANG_ACTIVITIES,                         LEVEL_9,   'Gang Activities'},
                                    {OffenseID.TREASON,                    OffensePriority.TREASON_ESPIONAGE,              DueDiligence.RegularExpressions.TREASON_ESPIONAGE,                       LEVEL_9,   'Treason and Espionage'},
                                    {OffenseID.SYNDICALISM,                OffensePriority.CRIMINAL_SYNDICALISM,           DueDiligence.RegularExpressions.CRIMINAL_SYNDICALISM,                    LEVEL_9,   'Criminal Syndicalism'},
                                    {OffenseID.MONEY_LAUNDER,              OffensePriority.MONEY_LAUNDERING,               DueDiligence.RegularExpressions.MONEY_LAUNDERING,                        LEVEL_9,   'Money Laundering'},
                                    {OffenseID.TERRORISM,                  OffensePriority.TERRORISM,                      DueDiligence.RegularExpressions.TERRORISM,                               LEVEL_9,   'Terrorism'},
                                    {OffenseID.ORGANIZED_CRIME,            OffensePriority.ORGANIZED_CRIME,                DueDiligence.RegularExpressions.ORGANIZED_CRIME,                         LEVEL_9,   'Organized Crime'},
                                    {OffenseID.OBSTRUCT_JUSTICE,           OffensePriority.OBSTRUCTION_OF_JUSTICE,         DueDiligence.RegularExpressions.OBSTRUCTION_OF_JUSTICE,                  LEVEL_9,   'Obstruction of Justice'},
                                    {OffenseID.ELECTION_CORRUPTION,        OffensePriority.ELECTION_CORRUPTION,            DueDiligence.RegularExpressions.ELECTION_CRIMES_CORRUPTION,              LEVEL_9,   'Election Crimes and Corruption'},
                                    {OffenseID.POLITICAL_CORRUPTION,       OffensePriority.POLITICAL_CORRUPTION,           DueDiligence.RegularExpressions.POLITICAL_CRIMES_CORRUPTION,             LEVEL_9,   'Political Crimes and Corruption'},
                                    {OffenseID.CORRUPTION_BRIBERY,         OffensePriority.CORRUPTION_OR_BRIBERY,          DueDiligence.RegularExpressions.CORRUPTION_BRIBERY_KICKBACKS,            LEVEL_9,   'Corruption, Bribery and Kickbacks'},
                                    {OffenseID.TAX_EVASION,                OffensePriority.TAX_EVASION,                    DueDiligence.RegularExpressions.TAX_EVASION,                             LEVEL_9,   'Money Laundering - Product Tax Evasion'},
                                    {OffenseID.BLACKMAIL,                  OffensePriority.EXTORTION_AND_BLACKMAIL,        DueDiligence.RegularExpressions.EXTORTION_AND_BLACKMAIL,                 LEVEL_9,   'Extortion and Blackmail'},
                                    {OffenseID.CHOP_SHOP,                  OffensePriority.CHOP_SHOP,                      DueDiligence.RegularExpressions.CHOP_SHOP,                               LEVEL_9,   'Chop Shop'},
                                    {OffenseID.ANTITRUST,                  OffensePriority.ANTITRUST_VIOLATIONS,           DueDiligence.RegularExpressions.ANTITRUST_VIOLATIONS,                    LEVEL_9,   'Antitrust Violations'},
                                    {OffenseID.SECURITIES_COMMODITIES,     OffensePriority.SECURITIES_AND_COMMODITIES,     DueDiligence.RegularExpressions.SECURITIES_AND_COMMODITIES,              LEVEL_9,   'Securities and Commodities'},
                                    {OffenseID.RACKETEERING,               OffensePriority.RACKETEERING,                   DueDiligence.RegularExpressions.RACKETEERING,                            LEVEL_9,   'Racketeering'},
                                    {OffenseID.MONEY_TRANSMITTER,          OffensePriority.MONEY_TRANSMITTER,              DueDiligence.RegularExpressions.MONEY_TRANSMITTER,                       LEVEL_9,   'Money Transmitter'},
                                    {OffenseID.STRUCTURING,                OffensePriority.STRUCTURING,                    DueDiligence.RegularExpressions.STRUCTURING,                             LEVEL_9,   'Structuring'},
                                    {OffenseID.IMPORT_EXPORT,              OffensePriority.IMPORT_EXPORT,                  DueDiligence.RegularExpressions.IMPORT_EXPORT_OFFENSES,                  LEVEL_9,   'Import and Export Offenses'},
                                    {OffenseID.TRANSPORTATION,             OffensePriority.TRANSPORTATION_VIOLATIONS,      DueDiligence.RegularExpressions.TRANSPORTATION_VIOLATIONS,               LEVEL_9,   'Transportation Violations'},
                                    {OffenseID.COMMUNICATION_INTERCEPT,    OffensePriority.COMMUNICATION_INTERCEPTION,     DueDiligence.RegularExpressions.COMMUNICATION_INTERCEPTION,              LEVEL_9,   'Communication Interception'},
                                    {OffenseID.CRIMINAL_PROCEEDS,          OffensePriority.CRIMINAL_PROCEEDS,              DueDiligence.RegularExpressions.CRIMINAL_PROCEEDS,                       LEVEL_9,   'Criminal Proceeds'}], ExpressionDSLayout);

                                
    SHARED expressionDCT := DICTIONARY(expressionDS, {id => expressionDS}); 
    EXPORT dctByPriority := DICTIONARY(expressionDS, {priorityOrder => expressionDS}); 
  

    
    SHARED additionalChecksToExpression(UNSIGNED expressionID, UNSIGNED expressionPriority, STRING1 offenseLevel, STRING1 trafficFlag, UNSIGNED offenseCategory, BOOLEAN foundUsingExpression) := FUNCTION
        
        isTrafficking := foundUsingExpression AND offenseLevel <> DueDiligence.Constants.TRAFFIC AND trafficFlag <> DueDiligence.Constants.YES;
        
        //check based on the expression we are currently evaluating
        additionalCheck := CASE(expressionID,
                                    //check that trafficking is not traffic related
                                    OffenseID.HUMAN_TRAFFICKING => IF(isTrafficking, expressionPriority, OffensePriority.UNCATEGORIZED),
                                    OffenseID.DRUG_TRAFFICKING => IF(isTrafficking, expressionPriority, OffensePriority.UNCATEGORIZED),
                                    OffenseID.ARMS_TRAFFICKING => IF(isTrafficking, expressionPriority, OffensePriority.UNCATEGORIZED),
                                    OffenseID.OTHER_TRAFFICKING => IF(isTrafficking, expressionPriority, OffensePriority.UNCATEGORIZED),
                                    
                                    //check for traffic offense
                                    OffenseID.TRAFFIC => IF(foundUsingExpression OR
                                                            offenseLevel = DueDiligence.Constants.TRAFFIC OR
                                                            trafficFlag = DueDiligence.Constants.YES OR
                                                            offenseCategory = 1073741824, expressionPriority, OffensePriority.UNCATEGORIZED),
                                                            
                                    expressionPriority);
                                    
        RETURN additionalCheck;
    END;
    
    //Common routine to determine if the text contains the definition of the expression
		SHARED getOffensePriorityByLevel(UNSIGNED4 enumReferenceByID, STRING textToSearch, STRING1 offenseLevel, STRING1 trafficFlag, UNSIGNED offenseCategory) := FUNCTION
    
    
        additionalChecksRequired := [OffenseID.HUMAN_TRAFFICKING, OffenseID.DRUG_TRAFFICKING, OffenseID.ARMS_TRAFFICKING, OffenseID.OTHER_TRAFFICKING, OffenseID.TRAFFIC];
        
        notProvidedSpecified := ['NOT SPECIFIED', 'NOT PROVIDED BY SOURCE'];
    
        trimTextToSearch := TRIM(textToSearch, LEFT, RIGHT);
        expressionDetails := expressionDCT[enumReferenceByID];
        expressionFound := REGEXFIND(expressionDetails.expressionToUse, textToSearch, NOCASE);
        
        expressionResults := MAP(trimTextToSearch = DueDiligence.Constants.EMPTY => IF(expressionDetails.level = LEVEL_2 AND expressionDetails.id = OffenseID.NO_OFFENSE_PROVIDED, OffensePriority.NO_OFFENSE_PROVIDED, OffensePriority.UNCATEGORIZED),
                                 STD.str.ToUpperCase(trimTextToSearch) IN notProvidedSpecified => IF(expressionDetails.level = LEVEL_2 AND expressionDetails.id = OffenseID.NO_OFFENSE_PROVIDED, OffensePriority.NO_OFFENSE_PROVIDED, OffensePriority.UNCATEGORIZED),
                                 expressionDetails.expressionToUse = DueDiligence.Constants.EMPTY => OffensePriority.UNCATEGORIZED,
                                 expressionDetails.id IN additionalChecksRequired => additionalChecksToExpression(expressionDetails.id, expressionDetails.priorityOrder, offenseLevel, trafficFlag, offenseCategory, expressionFound),
                                 IF(expressionFound, expressionDetails.priorityOrder, OffensePriority.UNCATEGORIZED));      
                                                               
       
        RETURN expressionResults;
		END;
    
    
    
    EXPORT getMaxLevel(STRING charge, STRING1 offenseScore, UNSIGNED offenseCategory, STRING1 trafficFlag, UNSIGNED1 inLevel) := FUNCTION
        
        allInLevel := expressionDS(level = inLevel);
        
        determineMaxPriorityForLevel := PROJECT(allInLevel, TRANSFORM({RECORDOF(LEFT) -expressionToUse, UNSIGNED levelResult},
                                                                      SELF.levelResult := getOffensePriorityByLevel(LEFT.id, charge, offenseScore, trafficFlag, offenseCategory);
                                                                      SELF := LEFT;));
        
        
        getMaxLevelByLevel := DEDUP(SORT(determineMaxPriorityForLevel, -levelResult, -priorityOrder), level);

        RETURN getMaxLevelByLevel[1].levelResult;
    END;
END;