import data_services, doxie, prte2_demowatchlistscreening;

EXPORT Keys := module

EXPORT matches_entity_name := index(files.match_name, {matches_entity_name}, {files.match_name}, 
																				data_services.data_location.prefix ('') + constants.keyname + doxie.Version_SuperKey + '::matches_entity_name');

end;																				
 
