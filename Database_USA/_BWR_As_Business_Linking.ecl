IMPORT Database_USA, data_services;

databaseUSABase := DATASET(data_services.foreign_prod +'thor_data400::base::Database_USA::qa::data',Database_USA.layouts.Base,THOR);

Database_USAOutput := Database_USA.As_Business_Linking (
	false
	,databaseUSABase
  ,true	
	);
	
OUTPUT(Database_USAOutput,,named('Database_USAOutput'));