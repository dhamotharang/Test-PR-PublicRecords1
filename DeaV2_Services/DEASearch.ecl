

export DEASearch(String3 Searchtype='DSS',DATASET(assorted_Layouts.layout_DeaKey) keys,Interfaces.Search_params in_params) := FUNCTION

if( SearchType = 'DSS',DEASearchService_ids(keys, in_params),

END;