import SANCTN;

export MAC_SANCTN_Build(filedate) := MACRO

#uniquename(spray_payload)
#uniquename(parse_data)
#uniquename(clean_data)
#uniquename(super_incident)
#uniquename(super_party)
#uniquename(super_files)
#uniquename(incident_transfer)
#uniquename(party_transfer)
#uniquename(base_transfer)
#uniquename(build_keys)

#workunit('name','SANCTN Build ' + filedate);

// Spray the new file onto Thor
%spray_payload% := SANCTN.spray_SANCTN_inputfile(filedate);

// Parse each of the records types out of the combined file
%parse_data%     := parallel(output(SANCTN.parse_SANCTN_incident_in)
		                     ,output(SANCTN.parse_SANCTN_incident_varying_in)
					         ,output(SANCTN.parse_SANCTN_party_in)
					         ,output(SANCTN.parse_SANCTN_party_varying_in));

// Clean the incident and party data
%clean_data%     := parallel(SANCTN.clean_incident(filedate)
                             ,SANCTN.clean_party(filedate));

// Add the newly cleaned incident data to the superfile with the rest of the cleaned data
%super_incident% := sequential(FileServices.StartSuperFileTransaction()
                               ,FileServices.AddSuperFile(SANCTN.cluster_name + 'out::sanctn::incident_cleaned'
							                             ,SANCTN.cluster_name + 'out::sanctn::' + filedate + '::incident_cleaned')
							   ,FileServices.FinishSuperFileTransaction());
%super_party% := sequential(FileServices.StartSuperFileTransaction()
                               ,FileServices.AddSuperFile(SANCTN.cluster_name + 'out::sanctn::party_cleaned'
							                             ,SANCTN.cluster_name + 'out::sanctn::' + filedate + '::party_cleaned')
							   ,FileServices.FinishSuperFileTransaction());

%super_files% := parallel(%super_incident%,%super_party%);
						  
%incident_transfer% := sequential(FileServices.StartSuperFileTransaction()
                                   ,FileServices.AddSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident_delete'
                                                             ,SANCTN.cluster_name + 'base::SANCTN::incident_grandfather',, true)
						       	   ,FileServices.ClearSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident_grandfather')
       							   ,FileServices.AddSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident_grandfather'
       							                             ,SANCTN.cluster_name + 'base::SANCTN::incident_father',, true)
		       					   ,FileServices.ClearSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident_father')
				       			   ,FileServices.AddSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident_father' 
                                                                ,SANCTN.cluster_name + 'base::SANCTN::incident',, true)
       							   ,FileServices.ClearSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident')
		       					   ,FileServices.AddSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident'
                                                             ,SANCTN.cluster_name + 'out::sanctn::' + filedate + '::incident_cleaned',,true)
						           ,FileServices.FinishSuperFileTransaction()
       							   ,FileServices.ClearSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident_delete'));
%party_transfer% := sequential(FileServices.StartSuperFileTransaction()
                               ,FileServices.AddSuperFile(SANCTN.cluster_name + 'base::SANCTN::party_delete'
                                                         ,SANCTN.cluster_name + 'base::SANCTN::party_grandfather',, true)
							   ,FileServices.ClearSuperFile(SANCTN.cluster_name + 'base::SANCTN::party_grandfather')
							   ,FileServices.AddSuperFile(SANCTN.cluster_name + 'base::SANCTN::party_grandfather'
							                             ,SANCTN.cluster_name + 'base::SANCTN::party_father',, true)
							   ,FileServices.ClearSuperFile(SANCTN.cluster_name + 'base::SANCTN::party_father')
							   ,FileServices.AddSuperFile(SANCTN.cluster_name + 'base::SANCTN::party_father' 
                                                         ,SANCTN.cluster_name + 'base::SANCTN::party',, true)
							   ,FileServices.ClearSuperFile(SANCTN.cluster_name + 'base::SANCTN::party')
							   ,FileServices.AddSuperFile(SANCTN.cluster_name + 'base::SANCTN::party'
                                                         ,SANCTN.cluster_name + 'out::sanctn::' + filedate + '::party_cleaned',,true)
						       ,FileServices.FinishSuperFileTransaction()
							   ,FileServices.ClearSuperFile(SANCTN.cluster_name + 'base::SANCTN::party_delete'));

%base_transfer% := parallel(%incident_transfer%,%party_transfer%);

%build_keys%  := SANCTN.proc_build_SANCTN_keys(filedate);

sequential(%spray_payload%
           ,%parse_data%
           ,%clean_data%
		   ,%super_files%
		   ,%base_transfer%
		   ,%build_keys%
		   );
		   
ENDMACRO;
