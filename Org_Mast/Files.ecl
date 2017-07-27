IMPORT tools;

// currently set up to process the original large data files
// to process the smaller files for purposes of saving time during testing, reverse the commenting
// that is, comment out the uncommented lines, and uncomment the commented ones

EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE
	 SHARED in_affiliations_file			:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	 + _Dataset().name + '::Org_Master_affiliations::'+pversion;//@version@';
	 SHARED in_aha_file								:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	 + _Dataset().name + '::Org_Master_aha::'+pversion;//@version@';
	 SHARED in_dea_file								:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	 + _Dataset().name + '::Org_Master_dea::'+pversion;//@version@';
	 SHARED in_npi_file								:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	 + _Dataset().name + '::Org_Master_npi::'+pversion;//@version@';
	 SHARED in_organization_file			:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	 + _Dataset().name + '::Org_Master_organization::'+pversion;//@version@';
	 SHARED in_pos_file								:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	 + _Dataset().name + '::Org_Master_pos::'+pversion;//@version@';
	 SHARED in_crosswalk_file					:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	 + _Dataset().name + '::Org_Master_crosswalk::'+pversion;//@version@';
	 EXPORT affiliations              := DATASET(in_affiliations_file, layouts.affiliations_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT aha									      := DATASET(in_aha_file, layouts.aha_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('\"') ));
	 EXPORT dea    						        := DATASET(in_dea_file, layouts.dea_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT npi												:= DATASET(in_npi_file, layouts.npi_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT organization				 		  := DATASET(in_organization_file, layouts.organization_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT pos									  		:= DATASET(in_pos_file, layouts.pos_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 EXPORT crosswalk									:= DATASET(in_crosswalk_file, layouts.crosswalk_in, csv( separator('\t'), heading(1), terminator(['\n', '\r\n']), QUOTE('') ));
	 /* Base File Versions */
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).affiliations_base, layouts.affiliations_base, affiliations_base);
   tools.mac_FilesBase(Filenames(pversion,pUseProd).aha_base, layouts.aha_base, aha_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).dea_base, layouts.dea_base, dea_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).npi_base, layouts.npi_base, npi_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).organization_base, layouts.organization_base, organization_base);
	 tools.mac_FilesBase(Filenames(pversion,pUseProd).Relationship_base, layouts.Relationship_base, Relationship_base);	 
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).pos_base, layouts.pos_base, pos_base);
 	 tools.mac_FilesBase(Filenames(pversion,pUseProd).crosswalk_base, layouts.crosswalk_base, crosswalk_base);
	 
END;