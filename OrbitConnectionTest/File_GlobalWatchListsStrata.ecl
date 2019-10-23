import data_services, globalwatchlists;

EXPORT File_GlobalWatchListsStrata := dataset(data_services.foreign_prod + 'thor_data400::base::globalwatchlists', GlobalWatchlists.Layout_GlobalWatchLists, thor);