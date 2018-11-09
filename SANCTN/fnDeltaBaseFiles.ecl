import file_compare,std,sanctn;

party_layout:=record
SANCTN.layout_SANCTN_party_in;
  string255      party_text;
	end;

file_base_incident_new := dataset(SANCTN.cluster_name + 'base::SANCTN::incident',SANCTN.layout_SANCTN_incident_clean,thor);
													 
file_base_incident_father := dataset(SANCTN.cluster_name + 'base::SANCTN::incident_father',SANCTN.layout_SANCTN_incident_clean,thor);	
													 
file_base_license_new := dataset(SANCTN.cluster_name +'base::SANCTN::license_nbr',SANCTN.layout_SANCTN_license_clean,thor);

file_base_license_father := dataset(SANCTN.cluster_name +'base::SANCTN::license_nbr_father',SANCTN.layout_SANCTN_license_clean,thor);

file_base_party_new := dataset(SANCTN.cluster_name + 'base::SANCTN::party',SANCTN.layout_SANCTN_did,thor);

file_base_party_father := dataset(SANCTN.cluster_name + 'base::SANCTN::party_father',SANCTN.layout_SANCTN_did,thor);

file_base_party_aka_dba_new := dataset(SANCTN.cluster_name + 'base::SANCTN::party_aka_dba',SANCTN.layout_SANCTN_aka_dba_in,thor);

file_base_party_aka_dba_father := dataset(SANCTN.cluster_name + 'base::SANCTN::party_aka_dba_father',SANCTN.layout_SANCTN_aka_dba_in,thor);

file_base_rebuttal_new := dataset(SANCTN.cluster_name + 'base::SANCTN::rebuttal',SANCTN.layout_SANCTN_rebuttal_in,thor);

file_base_rebuttal_father := dataset(SANCTN.cluster_name + 'base::SANCTN::rebuttal_father',SANCTN.layout_SANCTN_rebuttal_in,thor);

EXPORT fnDeltaBaseFiles(string version) := ordered(
file_compare.Fn_File_Compare(file_base_incident_father,file_base_incident_new,SANCTN.layout_SANCTN_incident_clean-[incident_date_clean,fcr_date_clean,cln_modified_date, cln_load_date],,SANCTN.layout_SANCTN_incident_clean-[incident_date_clean,fcr_date_clean,cln_modified_date, cln_load_date],true,,true,true,'SANCTN','file_base_incident',version),
file_compare.Fn_File_Compare(file_base_license_father,file_base_license_new,SANCTN.layout_SANCTN_license_clean-[CLN_LICENSE_NUMBER,std_type_desc],,SANCTN.layout_SANCTN_license_clean-[CLN_LICENSE_NUMBER,std_type_desc],true,,true,true,'SANCTN','file_base_license',version),
file_compare.Fn_File_Compare(file_base_party_father,file_base_party_new,party_layout,,party_layout,true,,true,true,'SANCTN','file_base_party',version),
file_compare.Fn_File_Compare(file_base_party_aka_dba_father,file_base_party_aka_dba_new,SANCTN.layout_SANCTN_aka_dba_in,,SANCTN.layout_SANCTN_aka_dba_in,true,,true,true,'SANCTN','file_base_party_aka_dba',version),
file_compare.Fn_File_Compare(file_base_rebuttal_father,file_base_rebuttal_new,SANCTN.layout_SANCTN_rebuttal_in,,SANCTN.layout_SANCTN_rebuttal_in,true,,true,true,'SANCTN','file_base_rebuttal',version)
);