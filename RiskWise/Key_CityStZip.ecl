import doxie,data_services;

f := riskwise.File_CityStateZip;
export Key_CityStZip:= INDEX(f,{zip5},{f},data_services.data_location.prefix() + 'thor_data400::key::citystzip_'+ doxie.Version_SuperKey);
