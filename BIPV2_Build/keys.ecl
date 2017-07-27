import riskwise,data_services,tools;

EXPORT keys(
   string   pversion              = ''
  ,boolean	pUseOtherEnvironment	= false

) :=
module

  f := riskwise.File_CityStateZip;

  EXPORT ZipCitySt := tools.macf_FilesIndex('f,{city,state},{f}',keynames(pversion,pUseOtherEnvironment).zipcityst);

end;
