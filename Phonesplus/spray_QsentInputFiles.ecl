import _Control;
export spray_QsentInputFiles(string filedate) := 
function
												
a := Fileservices.SprayVariable(_Control.IPAddress.edata12,'/hds_2/telephones/qsent_transfers/'+filedate +'.PhonesPlus.txt',,                  					// max rec size
                        '\t','\n',,'thor400_30',    					
                        '~thor400_30::in::phonesplus::'+filedate +'::qsent_transfer',,,,true,true,false);    

b:= fileservices.AddSuperFile('~thor_data400::in::qsent_update','~thor400_30::in::phonesplus::'+filedate +'::qsent_transfer',,false,false);


return sequential(a,b);
end;
