import OSHAIR, _Control;

export spray_OSHAIR_inputfile(string hostname // the actual name of the either edata10, edata12, or edata14
                             ,string filedate
                             ,string filename) := function

#uniquename(groupname)
#uniquename(cluster_name)
#uniquename(spray_data)
#uniquename(super_input)

#workunit('name','OSHAIR data spray');

%groupname% := 'thor_dataland_linux';

string hostname_ip := map(hostname = 'edata10' => _Control.IPAddress.edata10
                         ,hostname = 'edata12' => _Control.IPAddress.edata12
					     ,hostname = 'edata14' => _Control.IPAddress.edata14
                         ,'');

%spray_data% := fileservices.SprayVariable(hostname_ip
                                          ,'/hds_4/oshair/data/'+filedate+'/'+filedate+'.'+filename
										  ,
										  ,''
										  ,''
										  ,
										  ,%groupname%
										  ,OSHAIR.cluster + 'in::OSHAIR::'+filedate+'::payload'
										  ,
										  ,
										  ,
										  ,true
										  ,true
										  ,false
										  );

	
		
// Do superfile transactions
%super_input% := sequential(FileServices.StartSuperFileTransaction()
                             ,FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::payload')
							 ,FileServices.AddSuperFile(OSHAIR.cluster + 'in::OSHAIR::payload'
							                           ,OSHAIR.cluster + 'in::OSHAIR::'+filedate+'::payload')
			                 ,FileServices.FinishSuperFileTransaction());

return sequential(%spray_data%,%super_input%);
end;
