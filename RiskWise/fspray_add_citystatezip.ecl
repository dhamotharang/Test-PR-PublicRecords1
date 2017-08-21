import _control, ut; 
export  fspray_add_citystatezip(string filedate) := function

// version := ut.GetDate;  


return SEQUENTIAL(
FileServices.SprayFixed(_control.IPAddress.bctlpedata11,'/data/data_build_1/citystatezip/data/'+filedate+'/ctystate.txt',129,'thor400_20','~thor_data400::in::usps::'+filedate+'::citystatezip',-1,,,true,true,true);
FileServices.ClearSuperFile('~thor_data400::in::usps::citystatezip'),FileServices.AddSuperFile('~thor_data400::in::usps::citystatezip', '~thor_data400::in::usps::'+filedate+'::citystatezip'));
end;  