import _Control;

export proc_build_abius_all(string filedate) := function 

// Spray file
pre := InfoUSA.fSprayInputFiles(_control.IPAddress.edata10
						,'/prod_data_build_13/eval_data/infousa/abius/out'
						,'abius_'+filedate+'.d00'
						,'abius'
						,'thor_data400');

// Create Base File
do1 := InfoUSA.Make_ABIUS_Company_Base;

// Build BDID Keys
do2 := InfoUSA.Proc_Build_Keys(filedate,'ABIUS');

// Build Auto Keys
do3 := InfoUSA.proc_build_Autokey(filedate,'ABIUS');

retval := sequential(pre,do1, do2, do3);
return retval;
end;
