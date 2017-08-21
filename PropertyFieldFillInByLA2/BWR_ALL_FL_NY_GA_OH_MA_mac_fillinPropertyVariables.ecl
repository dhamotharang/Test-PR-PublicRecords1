// BWR_ALL_FL_NY_GA_OH_MA_mac_fillinPropertyVariables.ecl
set_debug := 1;
SomeStates := ['FL', 'NY', 'GA', 'OH', 'MA'];
StateLabel := 'FL_NY_GA_OH_MA';
in_version := '20110729';
PropertyFieldFillinByLA2.mac_prepPropertiesAndProcessWithLA(in_version, SomeStates, StatesLabel,FilledInVars_FL_NY_GA_OH_MA_ADVO_BASE_with_Hedonics);
output(count(FilledInVars_FL_NY_GA_OH_MA_ADVO_BASE_with_Hedonics),named('size_of_FilledInVars_FL_NY_GA_OH_MA_ADVO_BASE_with_Hedonics'));
