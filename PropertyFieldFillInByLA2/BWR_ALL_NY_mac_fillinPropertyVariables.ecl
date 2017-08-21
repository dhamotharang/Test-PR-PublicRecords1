// BWR_ALL_NY_mac_fillinPropertyVariables.ecl
set_debug := 1;
SomeStates := ['NY'];
StatesLabel := 'NY2';
in_version := '20110729';
PropertyFieldFillinByLA2.mac_prepPropertiesAndProcessWithLA(in_version, SomeStates, StatesLabel,FilledInVars_NY_ADVO_BASE_with_Hedonics);
output(count(FilledInVars_NY_ADVO_BASE_with_Hedonics),named('size_of_FilledInVars_NY_ADVO_BASE_with_Hedonics'));
