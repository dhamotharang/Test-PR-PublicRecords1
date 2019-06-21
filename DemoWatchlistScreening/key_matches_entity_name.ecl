import $;
import data_services, doxie, demowatchlistscreening;

ds := demowatchlistscreening.files.base;

lfn := data_services.data_location.prefix ('') + 'thor_data400::key::demo_watchlist_screening::' + doxie.Version_SuperKey + '::matches_entity_name';

EXPORT key_matches_entity_name := index(ds, {matches_entity_name}, {ds}, lfn);
