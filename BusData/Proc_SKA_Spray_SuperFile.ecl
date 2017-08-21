import _control;

export Proc_SKA_Spray_SuperFile(string Mainfile,string skatype, integer recsize, string filedate,string group_name) := function


sourceIP := _control.IPAddress.bctlpedata11;

spray_file := FileServices.SprayFixed(sourceIP,Mainfile, recsize,group_name,'~thor_data400::in::'+skatype+'_'+filedate ,-1,,,true,true);

super_file := sequential(
							FileServices.ClearSuperFile('~thor_data400::base::'+skatype),
							FileServices.addSuperFile('~thor_data400::base::'+skatype,'~thor_data400::in::'+skatype+'_'+filedate)
				);

return sequential(spray_file,super_file);

end;