IMPORT Database_USA, data_services;

asIndustry := Database_USA.As_Industry();

OUTPUT(asIndustry,,named('asIndustry'));