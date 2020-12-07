IMPORT ALC, VersionControl;

EXPORT _Flags(BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT IsTesting := VersionControl._Flags.IsDataland;

  EXPORT FileExists := MODULE
	  EXPORT Input := MODULE
			EXPORT Accountants          := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames(, pUseProd).Accountants_lInputTemplate))) > 0;
			EXPORT Dental_Professionals := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames(, pUseProd).Dental_Professionals_lInputTemplate))) > 0;
			EXPORT Insurance_Agents     := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames(, pUseProd).Insurance_Agents_lInputTemplate))) > 0;
			EXPORT Lawyers              := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames(, pUseProd).Lawyers_lInputTemplate))) > 0;
			EXPORT Nurses1              := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames(, pUseProd).Nurses1_lInputTemplate))) > 0;
			EXPORT Nurses2              := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames(, pUseProd).Nurses2_lInputTemplate))) > 0;
			EXPORT Nurses3              := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames(, pUseProd).Nurses3_lInputTemplate))) > 0;
			EXPORT Nurses4              := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames(, pUseProd).Nurses4_lInputTemplate))) > 0;
			EXPORT Pharmacists          := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames(, pUseProd).Pharmacists_lInputTemplate))) > 0;
			EXPORT Pilots               := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames(, pUseProd).Pilots_lInputTemplate))) > 0;
			EXPORT Professionals1       := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames(, pUseProd).Professionals1_lInputTemplate))) > 0;
			EXPORT Professionals2       := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames(, pUseProd).Professionals2_lInputTemplate))) > 0;
			EXPORT Professionals3       := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames(, pUseProd).Professionals3_lInputTemplate))) > 0;
		END;

		EXPORT Base := COUNT(NOTHOR(FileServices.SuperFileContents(ALC.Filenames().Base.QA))) > 0;
	END;

  // Since all the inputs must exist for the program to run, I only need check for the base.
  EXPORT Update := FileExists.Base;

END;
