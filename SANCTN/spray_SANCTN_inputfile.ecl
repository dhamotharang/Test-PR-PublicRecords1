import SANCTN,_Control;

export spray_SANCTN_inputfile(string filedate) := function

#uniquename(groupname)
#uniquename(cluster_name)
#uniquename(spray_data)
#uniquename(super_input)

#workunit('name','SANCTN data spray');

// %groupname% := 'thor200_144';
//%groupname% := 'thor20_241_10';
%groupname% := 'thor400_44';
%cluster_name% := SANCTN.cluster_name;

%spray_data% := fileservices.SprayVariable(_Control.IPAddress.bctlpedata12
                                        ,'/data/thor_back5/sanctn/public/data/'+filedate+'/'+filedate+'_combined.dat'
										,
										,''
										,'\n'
										,'~~~'
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
         ,FileServices.PromoteSuperFileList([SANCTN.cluster + 'in::SANCTN::payload',SANCTN.cluster + 'in::SANCTN::payload_father']) 
                           //  ,FileServices.ClearSuperFile(SANCTN.cluster + 'in::SANCTN::payload')
							 ,FileServices.AddSuperFile(SANCTN.cluster + 'in::SANCTN::payload'
							                           ,SANCTN.cluster + 'in::sanctn::'+filedate+'::payload')
			                 ,FileServices.FinishSuperFileTransaction());

return sequential(%spray_data%,%super_input%);
end;
