﻿import doxie, data_services;

df := govdata.File_FDIC_BDID(bdid != 0);

export key_fdic_bdid := index(df,{bdid},{df},data_services.data_location.prefix() + 'thor_Data400::key::govdata_fdic_bdid_' + doxie.Version_SuperKey);
