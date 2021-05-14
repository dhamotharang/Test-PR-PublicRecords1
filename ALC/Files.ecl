IMPORT ALC, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseProd = FALSE) := MODULE

  /* Input File Versions */
	EXPORT Input := MODULE
		EXPORT Accountants          := DATASET(ALC.Filenames(pversion, pUseProd).Accountants_lInputTemplate, ALC.Layouts.Input.Accountants, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
		EXPORT Dental_Professionals := DATASET(ALC.Filenames(pversion, pUseProd).Dental_Professionals_lInputTemplate, ALC.Layouts.Input.Dental_Professionals, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
		EXPORT Insurance_Agents     := DATASET(ALC.Filenames(pversion, pUseProd).Insurance_Agents_lInputTemplate, ALC.Layouts.Input.Insurance_Agents, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
		EXPORT Lawyers              := DATASET(ALC.Filenames(pversion, pUseProd).Lawyers_lInputTemplate, ALC.Layouts.Input.Lawyers, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
		EXPORT Nurses1              := DATASET(ALC.Filenames(pversion, pUseProd).Nurses1_lInputTemplate, ALC.Layouts.Input.Nurses, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
		EXPORT Nurses2              := DATASET(ALC.Filenames(pversion, pUseProd).Nurses2_lInputTemplate, ALC.Layouts.Input.Nurses, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
		EXPORT Nurses3              := DATASET(ALC.Filenames(pversion, pUseProd).Nurses3_lInputTemplate, ALC.Layouts.Input.Nurses, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
		EXPORT Nurses4              := DATASET(ALC.Filenames(pversion, pUseProd).Nurses4_lInputTemplate, ALC.Layouts.Input.Nurses4, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));		
		EXPORT Pharmacists          := DATASET(ALC.Filenames(pversion, pUseProd).Pharmacists_lInputTemplate, ALC.Layouts.Input.Pharmacists, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
		EXPORT Pilots               := DATASET(ALC.Filenames(pversion, pUseProd).Pilots_lInputTemplate, ALC.Layouts.Input.Pilots, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
		EXPORT Professionals1       := DATASET(ALC.Filenames(pversion, pUseProd).Professionals1_lInputTemplate, ALC.Layouts.Input.Professionals, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
		EXPORT Professionals2       := DATASET(ALC.Filenames(pversion, pUseProd).Professionals2_lInputTemplate, ALC.Layouts.Input.Professionals, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
		EXPORT Professionals3       := DATASET(ALC.Filenames(pversion, pUseProd).Professionals3_lInputTemplate, ALC.Layouts.Input.Professionals, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
	END;

	/* Base File Versions */
	tools.mac_FilesBase(ALC.Filenames(pversion, pUseProd).Base, ALC.Layouts.Base, Base);

END;