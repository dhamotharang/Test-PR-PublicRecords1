#workunit('name','Accutrend process ' + busreg.BusReg_Build_Date);
do1 := busreg.BWR_BusReg_Base : success(output('Finished Base file creation'));
do2 := busreg.BWR_Company_BDID : success(output('Finished Company BDID'));
do3 := busreg.BWR_Contact_DID : success(output('Finished Contact DID'));
do4 := busreg.BWR_4Accurint : success(output('Finished Output Files for Accurint'));
do5 := busreg.proc_build_keys : success(output('Finished Doxie keys'));
sequential(do1,do2,do3,do4,do5);