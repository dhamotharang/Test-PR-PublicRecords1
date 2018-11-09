import SANCTN,RoxieKeyBuild,PromoteSupers,Scrubs_SANCTNKeys, dops;

export MAC_SANCTN_Build(filedate,skipTest=false) := MACRO
#workunit('name','SANCTN Build ' + filedate);


#uniquename(spray_payload)
#uniquename(input_delta)
#uniquename(input_test)
#uniquename(parse_data)
#uniquename(clean_data)
// #uniquename(append_did)
#uniquename(base_transfer)
#uniquename(base_delta)
#uniquename(base_test)
#uniquename(build_keys)
#uniquename(updatedops)
#uniquename(qa_samp)



// Spray the new file onto Thor
%spray_payload% := SANCTN.spray_SANCTN_inputfile(filedate);

%input_delta%		:= SANCTN.fnDeltaInput(filedate);
%input_test%		:= SANCTN.fnInputFileCheck(filedate);
													 

// Parse each of the records types out of the combined file
%parse_data%     := parallel(output(choosen(SANCTN.parse_SANCTN_incident_in,100))
														,output(choosen(SANCTN.parse_SANCTN_incident_varying_in,100))
														,output(choosen(SANCTN.parse_SANCTN_party_in,100))
														,output(choosen(SANCTN.parse_SANCTN_party_varying_in,100))
														,output(choosen(SANCTN.parse_SANCTN_rebuttal_in,100))
														,output(choosen(SANCTN.parse_SANCTN_license_in,100))
														,output(choosen(SANCTN.parse_SANCTN_aka_dba,100))
														);

// Clean the incident and party data
%clean_data%     := parallel(SANCTN.clean_incident(filedate)
                             ,SANCTN.clean_party(filedate)
														 ,SANCTN.map_rebuttal_text(filedate)
														 ,SANCTN.clean_license_nbr(filedate)
														 ,SANCTN.map_party_aka_dba(filedate)
														 );


combined_incident_data := SANCTN.file_out_incident_cleaned;
combined_party_data    := SANCTN.Party_DID(SANCTN.file_out_party_cleaned);
rebuttal_data					 := SANCTN.file_rebuttal_clean;
license_data					 := SANCTN.file_license_clean;
aka_dba_dba						 := SANCTN.file_aka_dba_clean;


PromoteSupers.MAC_SF_BuildProcess(aka_dba_dba, SANCTN.cluster_name +'base::SANCTN::party_aka_dba', base_aka_dba_out, 3, /*csvout*/false, /*compress*/false);
PromoteSupers.MAC_SF_BuildProcess(license_data, SANCTN.cluster_name +'base::SANCTN::license_nbr', base_license_out, 3, /*csvout*/false, /*compress*/false);
PromoteSupers.MAC_SF_BuildProcess(rebuttal_data, SANCTN.cluster_name +'base::SANCTN::rebuttal', base_rebuttal_out, 3, /*csvout*/false, /*compress*/false);
PromoteSupers.MAC_SF_BuildProcess(combined_party_data , SANCTN.cluster_name +'base::SANCTN::party', base_party_out, 3, /*csvout*/false, /*compress*/false);
PromoteSupers.MAC_SF_BuildProcess(combined_incident_data, SANCTN.cluster_name +'base::SANCTN::incident', base_incident_out, 3, /*csvout*/false, /*compress*/false);

%base_transfer% := parallel(base_aka_dba_out,base_license_out,base_rebuttal_out, base_party_out,base_incident_out);

%base_delta%		:= SANCTN.fnDeltaBaseFiles(filedate);
%base_test%		:= SANCTN.fnBaseFilesCheck(filedate);

%build_keys%  := SANCTN.proc_build_SANCTN_keys(filedate);
							 
%updatedops% := dops.updateversion('SanctnKeys',filedate,'skasavajjala@seisint.com',,'N|B');

%qa_samp%    := SANCTN.out_incident_party_samples;

orbit_report.sanctn_stats(getretval);

//V2 for the new layout change. 11/26/13 
SANCTN.Out_File_SANCTN_Stats_Population_V2 (SANCTN.file_base_incident
																						,SANCTN.file_base_party
																						,SANCTN.file_base_rebuttal
																						,SANCTN.file_base_license
																						,SANCTN.file_base_party_aka_dba
																						,filedate
																						,do_STRATA);


sequential(
					%spray_payload%
					,%input_delta%
					#if(skiptest=true)
					,if(%input_test%=false,fail)
					#end
          ,%parse_data%
          ,%clean_data%
					,%base_transfer%
					,%base_delta%
					#if(skiptest=true)
					,if(%base_test%=false,fail)
					#end
					,%build_keys%
					,%qa_samp%
					,%updatedops%
				  ,getretval
					,do_STRATA
					,Scrubs_SANCTNKeys.fn_RunScrubs(filedate,'Harry.Gist@lexisnexis.com,Terri.Hardy-George@lexisnexis.com')
		   );

endmacro;