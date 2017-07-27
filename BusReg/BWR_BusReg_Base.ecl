#workunit('name','Accutrend Base File ' + busreg.BusReg_Build_Date);
base := BusReg.Busreg_Temp;
//output(base,,'BASE::BusReg_Base_' + BusReg.BusReg_Build_Date,overwrite);
ut.MAC_SF_BuildProcess(base,'~thor_data400::base::busreg_base',do1,2);
export BWR_BusReg_Base := do1;

