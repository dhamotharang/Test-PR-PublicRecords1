IMPORT ALC, tools;

EXPORT Filenames(STRING  pversion = '',
                 BOOLEAN pUseProd = FALSE) := MODULE

  SHARED InText   := ALC._Dataset(pUseProd).thor_cluster_files + 'in::' + ALC._Dataset().name +
	                      IF(pversion != '', '::' + pversion, '');
  SHARED BaseText := ALC._Dataset(pUseProd).thor_cluster_files + 'base::' + ALC._Dataset().name;

	EXPORT Accountants_lInputTemplate 		:= InText + '::Accountants';
	EXPORT Accountants_lInputHistTemplate := InText + '::Accountants::history';

	EXPORT Dental_Professionals_lInputTemplate 		 := InText + '::Dental_Professionals';
	EXPORT Dental_Professionals_lInputHistTemplate := InText + '::Dental_Professionals::history';

	EXPORT Insurance_Agents_lInputTemplate 		 := InText + '::Insurance_Agents';
	EXPORT Insurance_Agents_lInputHistTemplate := InText + '::Insurance_Agents::history';

	EXPORT Lawyers_lInputTemplate 		:= InText + '::Lawyers';
	EXPORT Lawyers_lInputHistTemplate := InText + '::Lawyers::history';

	EXPORT Nurses1_lInputTemplate 		:= InText + '::Nurses1';
	EXPORT Nurses1_lInputHistTemplate := InText + '::Nurses1::history';

	EXPORT Nurses2_lInputTemplate 		:= InText + '::Nurses2';
	EXPORT Nurses2_lInputHistTemplate := InText + '::Nurses2::history';

	EXPORT Nurses3_lInputTemplate 		:= InText + '::Nurses3';
	EXPORT Nurses3_lInputHistTemplate := InText + '::Nurses3::history';

	EXPORT Nurses4_lInputTemplate 		:= InText + '::Nurses4';
	EXPORT Nurses4_lInputHistTemplate	:= InText + '::Nurses4::history';
	
	EXPORT Pharmacists_lInputTemplate 		:= InText + '::Pharmacists';
	EXPORT Pharmacists_lInputHistTemplate := InText + '::Pharmacists::history';

	EXPORT Pilots_lInputTemplate 		 := InText + '::Pilots';
	EXPORT Pilots_lInputHistTemplate := InText + '::Pilots::history';

	EXPORT Professionals1_lInputTemplate 		 := InText + '::Professionals1';
	EXPORT Professionals1_lInputHistTemplate := InText + '::Professionals1::history';

	EXPORT Professionals2_lInputTemplate 		 := InText + '::Professionals2';
	EXPORT Professionals2_lInputHistTemplate := InText + '::Professionals2::history';

	EXPORT Professionals3_lInputTemplate 		 := InText + '::Professionals3';
	EXPORT Professionals3_lInputHistTemplate := InText + '::Professionals3::history';

  EXPORT lBaseTemplate_built := BaseText + '::built::Data';
	EXPORT lBaseTemplate			 := BaseText + '::@version@::Data';
	EXPORT Base		  					 := tools.mod_FilenamesBuild(lBaseTemplate, pversion);

  EXPORT base_dAll_filenames := Base.dAll_filenames;

END;
