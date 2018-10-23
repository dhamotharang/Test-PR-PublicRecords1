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
                                                DueDiligence.Constants.FELONY => 'Felony',
                                                DueDiligence.Constants.MISDEMEANOR => 'Misdemeanor',
                                                DueDiligence.Constants.INFRACTION => 'Infraction',
                                                DueDiligence.Constants.TRAFFIC => 'Traffic',
                                                DEFAULT_UNKNOWN);
                                                

END;;