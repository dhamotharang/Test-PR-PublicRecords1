Import Data_Services, doxie, ut;

f := riskwise.File_CityStateZip;
export Key_CityStZip:= INDEX(f,{zip5},{f}, Data_Services.Data_location.Prefix('citystatezip') + 'thor_data400::key::citystzip_'+ doxie.Version_SuperKey);
