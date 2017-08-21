IMPORT Infogroup, tools;

EXPORT Filenames(STRING  pversion = '',
                 BOOLEAN pUseProd = FALSE) := MODULE

  SHARED InText   := Infogroup._Dataset(pUseProd).thor_cluster_files + 'in::' + Infogroup._Dataset().name +
	                      IF(pversion != '', '::' + pversion, '');
  SHARED BaseText := Infogroup._Dataset(pUseProd).thor_cluster_files + 'base::' + Infogroup._Dataset().name;

	EXPORT Data_lInputTemplate		 := InText + '::Data';
	EXPORT Data_lInputHistTemplate := InText + '::Data::history';

  EXPORT lBaseTemplate_built := BaseText + '::built::Data';
	EXPORT lBaseTemplate			 := BaseText + '::@version@::Data';
	EXPORT Base		  					 := tools.mod_FilenamesBuild(lBaseTemplate, pversion);

  EXPORT base_dAll_filenames := Base.dAll_filenames;

END;
