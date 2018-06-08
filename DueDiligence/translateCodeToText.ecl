EXPORT translateCodeToText := MODULE

SHARED DEFAULT_EMPTY := '';
SHARED DEFAULT_UNKNOWN := 'Unknown';


EXPORT YesNoUnknownText(STRING1 code) := CASE(code,
                                                DueDiligence.Constants.YES => 'Yes',
                                                DueDiligence.Constants.NO => 'No',
                                                DEFAULT_UNKNOWN); 
                                                
EXPORT GenderText(STRING1 code) := CASE(code,
                                          'F' => 'Female',
                                          'M' => 'Male',
                                          DEFAULT_UNKNOWN);                                                

EXPORT LegalStateFederalText(STRING1 code) := CASE(code,
                                                    DueDiligence.Constants.STATE_CRIMINAL_DATA => 'State',
                                                    DueDiligence.Constants.FEDERAL_CRIMINAL_DATA => 'Federal',
                                                    DEFAULT_EMPTY);
                                                    
EXPORT OffenseScoreText(STRING1 code) := CASE(code,
                                                DueDiligence.Constants.FELONY => 'Felony',
                                                DueDiligence.Constants.MISDEMEANOR => 'Misdemeanor',
                                                DueDiligence.Constants.INFRACTION => 'Infraction',
                                                DueDiligence.Constants.TRAFFIC => 'Traffic',
                                                DEFAULT_UNKNOWN);
                                                
EXPORT OffenseLevelText(STRING1 code) := CASE(code,
                                                DueDiligence.Constants.NONTRAFFIC_CONVICTED => 'Nontraffic Convicted',
                                                DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED => 'Nontraffic Not Convicted',
                                                DueDiligence.Constants.TRAFFIC_CONVICTED => 'Traffic Convicted',
                                                DueDiligence.Constants.TRAFFIC_NOT_CONVICTED => 'Traffic Not Convicted',
                                                DEFAULT_UNKNOWN);
END;;