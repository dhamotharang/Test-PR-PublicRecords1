import SANCTN;

export spray_SANCTN_inputfile(string filedate) := function

#uniquename(groupname)
#uniquename(cluster_name)
#uniquename(spray_data)
#uniquename(super_input)

#workunit('name','SANCTN data spray');

%groupname% := 'thor_dell400';

%spray_data% := fileservices.SprayVariable('10.150.12.240'
                                        ,'/thor_back5/sanctn/data/'+filedate+'/'+filedate+'_combined.dat'
										,
										,''
										,'\n'
										,
										,%groupname%
										,SANCTN.cluster + 'in::sanctn::'+filedate+'::payload'
										,
										,
										,
										,true
										,true
										,false
										);

			
		
// Do superfile transactions
%super_input% := sequential(FileServices.StartSuperFileTransaction()
                             ,FileServices.ClearSuperFile(SANCTN.cluster + 'in::SANCTN::payload')
							 ,FileServices.AddSuperFile(SANCTN.cluster + 'in::SANCTN::payload'
							                           ,SANCTN.cluster + 'in::sanctn::'+filedate+'::payload')
			                 ,FileServices.FinishSuperFileTransaction());

return sequential(%spray_data%,%super_input%);
end;
