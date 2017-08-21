import _control, versioncontrol;

FilesToSpray := DATASET([

   {_Control.IPAddress.edata10
   ,'/prod_data_build_10/production_data/business_headers/accutrend/out'
   ,'accutrend.d00'
   ,sizeof(BusReg.Layout_BusReg_In)
   ,'~thor_data400::in::accutrend_fbn_20070905'
   ,[{'~thor_data400::in::accutrend_fbn'}]
   ,'thor400_92'
   ,busreg.BusReg_Build_Date
   ,''
   }

], VersionControl.Layout_Sprays.Info);

//VersionControl.fSprayInputFiles(FilesToSpray);

export proc_spray_inputfile := VersionControl.fSprayInputFiles(FilesToSpray,,,true,,,,,'Accutrend Business Registrations');
