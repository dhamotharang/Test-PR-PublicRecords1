IMPORT ut, Data_Services;

EXPORT File_ComprehensiveStats := module

EXPORT NonFCRA_CompanyIDs(string version) 		:= dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry_acclogs::'+Version+'::comprehensive_table_companyids', Layout_ComprehensiveStats.nonfcra_companyids, csv(separator('\t')));
EXPORT NonFCRA_CompanyIDProducts(string version) 		:= dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry_acclogs::'+Version+'::comprehensive_table_companyid_products', Layout_ComprehensiveStats.NonFCRA_CompanyIDsProducts, csv(separator('\t')));
EXPORT NonFCRA_NoDate(string version) 				:= dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry_acclogs::'+Version+'::comprehensive_table_nodate', Layout_ComprehensiveStats.nonfcra_nodate, csv(separator('\t')));
EXPORT NonFCRA_YYYYMMDD(string version) 	 		:= dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry_acclogs::'+Version+'::comprehensive_table_yyyymmdd', Layout_ComprehensiveStats.nonfcra_yyyymmdd, csv(separator('\t')));
EXPORT NonFCRA_YYYYMMDDOnly(string version) 	:= dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry_acclogs::'+Version+'::comprehensive_table_yyyymmdd_only', Layout_ComprehensiveStats.nonfcra_yyyymmddonly, csv(separator('\t')));
EXPORT NonFCRA_BlankIndustry(string version)	:= dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry_acclogs::'+Version+'::comprehensive_table_blankindustry', Layout_ComprehensiveStats.nonfcra_blankindustry, csv(separator('\t')));
EXPORT NonFCRA_Population(string version) 		:= dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry_acclogs::'+Version+'::comprehensive_table_population', Layout_ComprehensiveStats.nonfcra_population, csv(separator('\t')));
EXPORT NonFCRA_PopulationSlim(string version) := dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry_acclogs::'+Version+'::comprehensive_table_populationslim', Layout_ComprehensiveStats.nonfcra_populationslim, csv(separator('\t')));

EXPORT FCRA_CompanyIDs(string version) 		:= dataset(Data_Services.foreign_fcra_logs + 'thor20_11::out::inquiry_acclogs::fcra::'+Version+'::comprehensive_table_companyids', Layout_ComprehensiveStats.fcra_companyids, csv(separator('\t')));
EXPORT FCRA_CompanyIDProducts(string version) := dataset(Data_Services.foreign_fcra_logs + 'thor20_11::out::inquiry_acclogs::fcra::'+Version+'::comprehensive_table_companyid_products', Layout_ComprehensiveStats.NonFCRA_CompanyIDsProducts, csv(separator('\t')));
EXPORT FCRA_NoDate(string version) 				:= dataset(Data_Services.foreign_fcra_logs + 'thor20_11::out::inquiry_acclogs::fcra::'+Version+'::comprehensive_table_nodate', Layout_ComprehensiveStats.fcra_nodate, csv(separator('\t')));
EXPORT FCRA_YYYYMMDD(string version) 	 		:= dataset(Data_Services.foreign_fcra_logs + 'thor20_11::out::inquiry_acclogs::fcra::'+Version+'::comprehensive_table_yyyymmdd', Layout_ComprehensiveStats.fcra_yyyymmdd, csv(separator('\t')));
EXPORT FCRA_YYYYMMDDOnly(string version) 	:= dataset(Data_Services.foreign_fcra_logs + 'thor20_11::out::inquiry_acclogs::fcra::'+Version+'::comprehensive_table_yyyymmdd_only', Layout_ComprehensiveStats.fcra_yyyymmddonly, csv(separator('\t')));
EXPORT FCRA_BlankIndustry(string version) := dataset(Data_Services.foreign_fcra_logs + 'thor20_11::out::inquiry_acclogs::fcra::'+Version+'::comprehensive_table_blankindustry', Layout_ComprehensiveStats.fcra_blankindustry, csv(separator('\t')));

end;
