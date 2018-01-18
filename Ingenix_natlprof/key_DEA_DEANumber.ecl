import Doxie, data_services;

file_in := ingenix_natlprof.Basefile_ProviderAddressDEANumber;
file_sort :=dedup(sort(distribute(file_in,hash(trim(providerid,left,right),trim(DEANumber,left,right))),providerid,DEANumber,local),providerid,DEANumber,local);
export key_DEA_DEANumber := index(file_sort, 
                                {string9 l_DEANumber := DEANumber},{providerid,DEANumber},
				            data_services.data_location.prefix() + 'thor_data400::key::ingenix_DEA_DEANumber_' + Doxie.Version_SuperKey);


