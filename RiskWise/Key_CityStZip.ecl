import doxie,data_services, vault, _control;

f := riskwise.File_CityStateZip;

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_CityStZip:= vault.RiskWise.Key_CityStZip;
#ELSE
export Key_CityStZip:= INDEX(f,{zip5},{f},data_services.data_location.prefix() + 'thor_data400::key::citystzip_'+ doxie.Version_SuperKey);
#END;


