IMPORT DueDiligence;

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
    EXPORT LEVEL_0 := 0;  
    
    
    

    EXPORT DEFAULT_UNCATEGORIZED_TEXT := 'Uncategorized';
    
    
    
    
    //Unique ID used to identify a category - these should not change and new ones being added at the end
    //old/unused IDs should not be removed either - so once entered cannot be removed
    //DO NOT CHANGE ORDER OF THESE!!!
    EXPORT OffenseID := ENUM(UNCATEGORIZED = 0, NO_OFFENSE_PROVIDED, HUNT_FISH, LIVESTOCK_DOMESTIC_ANIMAL, ORDINANCE_INFRACTION, 
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
    
                                  TRAFFIC_OFFENSES, ORDINANCES_AND_INFRACTIONS, LIVESTOCK_DOMESTIC_ANIMALS, HUNT_FISH_GAME_OFFENSES, DAMAGE_DESTROY_ITEMS, 
                                  OBSTRUCTION_HINDER, ZONING, CHILD_SUPPORT, ALIEN_AND_IMMIGRATION, TRESPASSING, SHOPLIFTING, 

                                  SANCTIONS, TAMPERING, PERJURY, CONSPIRACY, DIGITAL_CURRENCY, GAMBLING, COMPUTER_AND_CYBER, 
                                  MISCONDUCT, TRANSPORTATION_VIOLATIONS, ALCOHOL_RELATED, DUI, DISORDERLY_CONDUCT, 
                                                           
                                  RESISTING_ARREST_ESCAPE, VIOLATING_ORDERS, FUGITIVE_OR_WARRANT, POISONING, VANDALISM, 
                                  ARSON, ELDER_EXPLOITATION, SABOTAGE, RETALIATION, HATE_CRIME_AND_CIVIL_RIGHTS, BOOBY_TRAP, 
                                  RIOT_CIVIL_DISORDER, CYBER_STALKING, STALK_HARASS_TERRORIZE, ASSAULT, FAMILY_AND_PROVIDER_ABUSE, 
                                  DEADLY_CONDUCT, KIDNAPPING_FALSE_IMPRISONMENT, MURDER_HOMOCIDE, ANIMAL_FIGHTING, EPA_WASTE,
                                                            
                                  PROSTITUTION, SEX_OFFENSES, PORNOGRAPHY, SOLICITATION, RAPE, SOLICITATION_SEX, CORRUPTION_OF_MINOR, 
                                  
                                  THEFT, FELONY_OR_AGGRAVATED_THEFT, BREAKING_AND_ENTERING, CAR_JACK, BURGLARY, ROBBERY, ARMED_ROBBERY, 
                                  BANK_ROBBERY, 
                                  
                                  OBTAIN_PROP_BY_FALSE_PRETENSE, CONCEAL_FUNDS_OR_PROPERTY, TAX_OFFENSES, FRAUD, CHECK_FRAUD, 
                                  IDENTITY_FRAUD_AND_THEFT, INVOICE_FRAUD, ORGANIZED_FRAUD, INSURANCE_FRAUD, EMPLOYMENT_WORK_COMP_FRAUD, 
                                  HEALTHCARE_FRAUD, MORTGAGE_FRAUD, TAX_FRAUD, CREDIT_CARD_FRAUD, BANK_FRAUD, WIRE_FRAUD, EMBEZZLEMENT, 
                                  OPERATE_WITHOUT_LICENSE, FORGE_AND_COUNTERFEIT, IMPORT_EXPORT, FALSE_STATEMENTS_IMPERSONATION,  
                                  
                                  DRUGS, WEAPONS, EXPLOSIVES_DESTRUCTION_DEVICES, DISTRIBUTION_DRUGS_OR_WEAPONS, TRAFFICKING_SMUGGLING_OTHER,
                                  TRAFFICKING_SMUGGLING_ARMS, TRAFFICKING_SMUGGLING_DRUGS, TRAFFICKING_SMUGGLING_HUMAN,
                                  
                                  COMMUNICATION_INTERCEPTION, CHOP_SHOP, GANG_ACTIVITIES, STRUCTURING, MONEY_TRANSMITTER, CRIMINAL_PROCEEDS, 
                                  CORRUPTION_OR_BRIBERY, POLITICAL_CORRUPTION, ELECTION_CORRUPTION, OBSTRUCTION_OF_JUSTICE, ORGANIZED_CRIME, 
                                  EXTORTION_AND_BLACKMAIL, RACKETEERING, SECURITIES_AND_COMMODITIES, ANTITRUST_VIOLATIONS, MONEY_LAUNDERING, 
                                  CRIMINAL_SYNDICALISM, TREASON_ESPIONAGE, TERRORISM, COURT_CHARGES, PROBATION_PAROLE_VIOLATION);
    

                                  
                                  
                                  
                                  
    SHARED ExpressionDSLayout := RECORD
      UNSIGNED4 id; //this is a unique ID per offense - this should not change
      UNSIGNED1 level; 
      UNSIGNED4 priorityOrder; //identifier used as a weight for picking priority - as of 01/14/2020 no longer used in logic (keeping until can be removed from esp/web) 
    END;
    

    SHARED expressionDS := DATASET([
                                    {OffenseID.UNCATEGORIZED,              LEVEL_0,		OffensePriority.UNCATEGORIZED                  },
                                                                                      
                                    {OffenseID.NO_OFFENSE_PROVIDED,        LEVEL_2,		OffensePriority.NO_OFFENSE_PROVIDED            },
                                    {OffenseID.HUNT_FISH,                  LEVEL_2,		OffensePriority.HUNT_FISH_GAME_OFFENSES        },
                                    {OffenseID.LIVESTOCK_DOMESTIC_ANIMAL,  LEVEL_2,		OffensePriority.LIVESTOCK_DOMESTIC_ANIMALS     },
                                    {OffenseID.ORDINANCE_INFRACTION,       LEVEL_2,		OffensePriority.ORDINANCES_AND_INFRACTIONS     },
                                    {OffenseID.ZONING,                     LEVEL_2,		OffensePriority.ZONING                         },
                                    {OffenseID.TRAFFIC,                    LEVEL_2,		OffensePriority.TRAFFIC_OFFENSES               },
                                    {OffenseID.CHILD_SUPPORT,              LEVEL_2,		OffensePriority.CHILD_SUPPORT                  },
                                    {OffenseID.DISORDERLY_CONDUCT,         LEVEL_2,		OffensePriority.DISORDERLY_CONDUCT             },
                                    {OffenseID.SHOPLIFTING,                LEVEL_2,		OffensePriority.SHOPLIFTING                    },
                                    {OffenseID.TRESPASSING,                LEVEL_2,		OffensePriority.TRESPASSING                    },
                                    {OffenseID.IMMIGRATION,                LEVEL_2,		OffensePriority.ALIEN_AND_IMMIGRATION          },
                                                                                      
                                    {OffenseID.ANIMAL_FIGHT,               LEVEL_3,		OffensePriority.ANIMAL_FIGHTING                },
                                    {OffenseID.DUI,                        LEVEL_3,		OffensePriority.DUI                            },
                                    {OffenseID.ALCOHOL,                    LEVEL_3,		OffensePriority.ALCOHOL_RELATED                },
                                    {OffenseID.MISCONDUCT,                 LEVEL_3,		OffensePriority.MISCONDUCT                     },
                                    {OffenseID.CYBER,                      LEVEL_3,		OffensePriority.COMPUTER_AND_CYBER             },
                                    {OffenseID.SANCTION,                   LEVEL_3,		OffensePriority.SANCTIONS                      },
                                    {OffenseID.CORRUPT_MINOR,              LEVEL_3,		OffensePriority.CORRUPTION_OF_MINOR            },
                                    {OffenseID.GAMBLE,                     LEVEL_3,		OffensePriority.GAMBLING                       },
                                    {OffenseID.CONSPIRACY,                 LEVEL_3,		OffensePriority.CONSPIRACY                     },
                                    {OffenseID.PERJURY,                    LEVEL_3,		OffensePriority.PERJURY                        },
                                    {OffenseID.OBSTRUCTION,                LEVEL_3,		OffensePriority.OBSTRUCTION_HINDER             },
                                    {OffenseID.TAMPERING,                  LEVEL_3,		OffensePriority.TAMPERING                      },
                                    {OffenseID.DIGITAL_CURRENCY,           LEVEL_3,		OffensePriority.DIGITAL_CURRENCY               },
                                    {OffenseID.TRANSPORTATION,             LEVEL_3,		OffensePriority.TRANSPORTATION_VIOLATIONS      },
                                    {OffenseID.COMMUNICATION_INTERCEPT,    LEVEL_3,		OffensePriority.COMMUNICATION_INTERCEPTION     },
                                    {OffenseID.TAX,                        LEVEL_3,		OffensePriority.TAX_OFFENSES                   },
                                    {OffenseID.DAMAGE_DESTROY,             LEVEL_3,		OffensePriority.DAMAGE_DESTROY_ITEMS           },
                                    {OffenseID.DRUGS,                      LEVEL_3,		OffensePriority.DRUGS                          },
                                    
                                    {OffenseID.ELDER_EXPLOIT,              LEVEL_4,		OffensePriority.ELDER_EXPLOITATION             },
                                    {OffenseID.FAMILY_PROVIDER_ABUSE,      LEVEL_4,		OffensePriority.FAMILY_AND_PROVIDER_ABUSE      },
                                    {OffenseID.FUGITIVE,                   LEVEL_4,		OffensePriority.FUGITIVE_OR_WARRANT            },
                                    {OffenseID.RIOT,                       LEVEL_4,		OffensePriority.RIOT_CIVIL_DISORDER            },
                                    {OffenseID.POISON,                     LEVEL_4,		OffensePriority.POISONING                      },
                                    {OffenseID.EPA,                        LEVEL_4,		OffensePriority.EPA_WASTE                      },
                                    {OffenseID.HARASS,                     LEVEL_4,		OffensePriority.STALK_HARASS_TERRORIZE         },
                                    {OffenseID.CYBER_STALK,                LEVEL_4,		OffensePriority.CYBER_STALKING                 },
                                    {OffenseID.VIOLATE_ORDER,              LEVEL_4,		OffensePriority.VIOLATING_ORDERS               },
                                    {OffenseID.PROBATION_VIOLATION,        LEVEL_4,		OffensePriority.PROBATION_PAROLE_VIOLATION     },
                                    {OffenseID.ARSON,                      LEVEL_4,		OffensePriority.ARSON                          },
                                    {OffenseID.HOMOCIDE,                   LEVEL_4,		OffensePriority.MURDER_HOMOCIDE                },
                                    {OffenseID.KIDNAP,                     LEVEL_4,		OffensePriority.KIDNAPPING_FALSE_IMPRISONMENT  },
                                    {OffenseID.HATE_CRIME,                 LEVEL_4,		OffensePriority.HATE_CRIME_AND_CIVIL_RIGHTS    },
                                    {OffenseID.RETALIATION,                LEVEL_4,		OffensePriority.RETALIATION                    },
                                    {OffenseID.BOOBY_TRAP,                 LEVEL_4,		OffensePriority.BOOBY_TRAP                     },
                                    {OffenseID.SABOTAGE,                   LEVEL_4,		OffensePriority.SABOTAGE                       },
                                    {OffenseID.VANDALISM,                  LEVEL_4,		OffensePriority.VANDALISM                      },
                                    {OffenseID.COURT,                      LEVEL_4,		OffensePriority.COURT_CHARGES                  },
                                    {OffenseID.OBSTRUCT_JUSTICE,           LEVEL_4,		OffensePriority.OBSTRUCTION_OF_JUSTICE         },
                                    {OffenseID.DEADLY_CONDUCT,             LEVEL_4,		OffensePriority.DEADLY_CONDUCT                 },
                                    {OffenseID.ASSAULT,                    LEVEL_4,		OffensePriority.ASSAULT                        },
                                    {OffenseID.RESISTING_ARREST,           LEVEL_4,		OffensePriority.RESISTING_ARREST_ESCAPE        },
                                    {OffenseID.WEAPONS,                    LEVEL_4,		OffensePriority.WEAPONS                        },
                                    
                                    {OffenseID.RAPE,                       LEVEL_5,		OffensePriority.RAPE                           },
                                    {OffenseID.SOLICITATION,               LEVEL_5,		OffensePriority.SOLICITATION                   },
                                    {OffenseID.SOLICITATION_SEX,           LEVEL_5,		OffensePriority.SOLICITATION_SEX               },
                                    {OffenseID.PORN,                       LEVEL_5,		OffensePriority.PORNOGRAPHY                    },
                                    {OffenseID.PROSTITUTION,               LEVEL_5,		OffensePriority.PROSTITUTION                   },
                                    {OffenseID.SEX,                        LEVEL_5,		OffensePriority.SEX_OFFENSES                   },
                                                                                      
                                    {OffenseID.GANG,                       LEVEL_6,		OffensePriority.GANG_ACTIVITIES                },
                                    {OffenseID.B_AND_E,                    LEVEL_6,		OffensePriority.BREAKING_AND_ENTERING          },
                                    {OffenseID.BURGLARY,                   LEVEL_6,		OffensePriority.BURGLARY                       },
                                    {OffenseID.CARJACK,                    LEVEL_6,		OffensePriority.CAR_JACK                       },
                                    {OffenseID.AGG_THEFT,                  LEVEL_6,		OffensePriority.FELONY_OR_AGGRAVATED_THEFT     },
                                    {OffenseID.THEFT,                      LEVEL_6,		OffensePriority.THEFT                          },
                                    {OffenseID.CHOP_SHOP,                  LEVEL_6,		OffensePriority.CHOP_SHOP                      },
                                    {OffenseID.ROBBERY,                    LEVEL_6,		OffensePriority.ROBBERY                        },
                                    {OffenseID.BANK_ROBBERY,               LEVEL_6,		OffensePriority.BANK_ROBBERY                   },
                                    {OffenseID.ARMED_ROBBERY,              LEVEL_6,		OffensePriority.ARMED_ROBBERY                  },
                                                                                      
                                    {OffenseID.ELECTION_CORRUPTION,        LEVEL_7,		OffensePriority.ELECTION_CORRUPTION            },
                                    {OffenseID.POLITICAL_CORRUPTION,       LEVEL_7,		OffensePriority.POLITICAL_CORRUPTION           },
                                    {OffenseID.CORRUPTION_BRIBERY,         LEVEL_7,		OffensePriority.CORRUPTION_OR_BRIBERY          },
                                    {OffenseID.FRAUD,                      LEVEL_7,		OffensePriority.FRAUD                          },
                                    {OffenseID.WIRE_FRAUD,                 LEVEL_7,		OffensePriority.WIRE_FRAUD                     },
                                    {OffenseID.BANK_FRAUD,                 LEVEL_7,		OffensePriority.BANK_FRAUD                     },
                                    {OffenseID.FINANCIAL_FRAUD,            LEVEL_7,		OffensePriority.CREDIT_CARD_FRAUD              },
                                    {OffenseID.TAX_FRAUD,                  LEVEL_7,		OffensePriority.TAX_FRAUD                      },
                                    {OffenseID.MORTGAGE_FRAUD,             LEVEL_7,		OffensePriority.MORTGAGE_FRAUD                 },
                                    {OffenseID.HEALTHCARE_FRAUD,           LEVEL_7,		OffensePriority.HEALTHCARE_FRAUD               },
                                    {OffenseID.EMPLOYMENT_FRAUD,           LEVEL_7,		OffensePriority.EMPLOYMENT_WORK_COMP_FRAUD     },
                                    {OffenseID.INSURANCE_FRAUD,            LEVEL_7,		OffensePriority.INSURANCE_FRAUD                },
                                    {OffenseID.ORGANIZED_FRAUD,            LEVEL_7,		OffensePriority.ORGANIZED_FRAUD                },
                                    {OffenseID.INVOICE_FRAUD,              LEVEL_7,		OffensePriority.INVOICE_FRAUD                  },
                                    {OffenseID.CHECK_FRAUD,                LEVEL_7,		OffensePriority.CHECK_FRAUD                    },
                                    {OffenseID.COUNTERFEIT,                LEVEL_7,		OffensePriority.FORGE_AND_COUNTERFEIT          },
                                    {OffenseID.ID_FRAUD_THEFT,             LEVEL_7,		OffensePriority.IDENTITY_FRAUD_AND_THEFT       },
                                    {OffenseID.IMPERSONATION,              LEVEL_7,		OffensePriority.FALSE_STATEMENTS_IMPERSONATION },
                                    {OffenseID.ANTITRUST,                  LEVEL_7,		OffensePriority.ANTITRUST_VIOLATIONS           },
                                    {OffenseID.SECURITIES_COMMODITIES,     LEVEL_7,		OffensePriority.SECURITIES_AND_COMMODITIES     },
                                    {OffenseID.MONEY_TRANSMITTER,          LEVEL_7,		OffensePriority.MONEY_TRANSMITTER              },
                                    {OffenseID.STRUCTURING,                LEVEL_7,		OffensePriority.STRUCTURING                    },
                                    {OffenseID.IMPORT_EXPORT,              LEVEL_7,		OffensePriority.IMPORT_EXPORT                  },
                                    {OffenseID.OPERATE_NO_LICENSE,         LEVEL_7,		OffensePriority.OPERATE_WITHOUT_LICENSE        },
                                    {OffenseID.EMBEZZLEMENT,               LEVEL_7,		OffensePriority.EMBEZZLEMENT                   },
                                    {OffenseID.CONCEAL_FUNDS_PROPERTY,     LEVEL_7,		OffensePriority.CONCEAL_FUNDS_OR_PROPERTY      },
                                    {OffenseID.OBTAIN_PROP_FALSE_PRETENSE, LEVEL_7,		OffensePriority.OBTAIN_PROP_BY_FALSE_PRETENSE  },
                                    
                                    {OffenseID.HUMAN_TRAFFICKING,          LEVEL_8,		OffensePriority.TRAFFICKING_SMUGGLING_HUMAN    },
                                    {OffenseID.DRUG_TRAFFICKING,           LEVEL_8,		OffensePriority.TRAFFICKING_SMUGGLING_DRUGS    },
                                    {OffenseID.ARMS_TRAFFICKING,           LEVEL_8,		OffensePriority.TRAFFICKING_SMUGGLING_ARMS     },
                                    {OffenseID.OTHER_TRAFFICKING,          LEVEL_8,		OffensePriority.TRAFFICKING_SMUGGLING_OTHER    },
                                    {OffenseID.EXPLOSIVES,                 LEVEL_8,		OffensePriority.EXPLOSIVES_DESTRUCTION_DEVICES },
                                    {OffenseID.DIST_DRUGS_WEAPONS,         LEVEL_8,		OffensePriority.DISTRIBUTION_DRUGS_OR_WEAPONS  },
                                                                                      
                                    {OffenseID.TREASON,                    LEVEL_9,		OffensePriority.TREASON_ESPIONAGE              },
                                    {OffenseID.SYNDICALISM,                LEVEL_9,		OffensePriority.CRIMINAL_SYNDICALISM           },
                                    {OffenseID.MONEY_LAUNDER,              LEVEL_9,		OffensePriority.MONEY_LAUNDERING               },
                                    {OffenseID.TERRORISM,                  LEVEL_9,		OffensePriority.TERRORISM                      },
                                    {OffenseID.ORGANIZED_CRIME,            LEVEL_9,		OffensePriority.ORGANIZED_CRIME                },
                                    {OffenseID.BLACKMAIL,                  LEVEL_9,		OffensePriority.EXTORTION_AND_BLACKMAIL        },
                                    {OffenseID.RACKETEERING,               LEVEL_9,		OffensePriority.RACKETEERING                   },
                                    {OffenseID.CRIMINAL_PROCEEDS,          LEVEL_9,		OffensePriority.CRIMINAL_PROCEEDS              }], ExpressionDSLayout);

                                
    EXPORT expressionDCT := DICTIONARY(expressionDS, {id => expressionDS}); 
  

 
END;