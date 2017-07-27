import doxie;

f := riskwise.File_CityStateZip;
export Key_CityStZip:= INDEX(f,{zip5},{f},'~thor_data400::key::citystzip_'+ doxie.Version_SuperKey);
