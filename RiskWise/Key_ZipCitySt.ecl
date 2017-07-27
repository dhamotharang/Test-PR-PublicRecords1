Import Data_Services, doxie, ut;

f := riskwise.File_CityStateZip;
EXPORT Key_ZipCitySt := INDEX(f,{city,state},{f}, Data_Services.Data_location.Prefix('citystatezip') + 'thor_data400::key::zipcityst_'+ doxie.Version_SuperKey);