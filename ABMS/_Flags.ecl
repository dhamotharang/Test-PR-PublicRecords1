IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT IsTesting := tools._Constants.IsDataland;

	EXPORT FileExists := MODULE
		EXPORT Input := MODULE
		  EXPORT Address          := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Address.Sprayed))) > 0;
			EXPORT BIOG  			      := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.BIOG.Sprayed))) > 0;
		  EXPORT Career           := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Career.Sprayed))) > 0;
		  EXPORT Cert             := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Cert.Sprayed))) > 0;
		  EXPORT Contact          := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Contact.Sprayed))) > 0;
		  EXPORT Deceased         := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Deceased.Sprayed))) > 0;
		  EXPORT Education        := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Education.Sprayed))) > 0;
		  EXPORT Membership       := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Membership.Sprayed))) > 0;
		  EXPORT MOCParticipation := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.MOCParticipation.Sprayed))) > 0;
		  EXPORT TypeOfPractice   := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.TypeOfPractice.Sprayed))) > 0;
		  EXPORT Schools          := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Schools.Sprayed))) > 0;
		  EXPORT Specialty        := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Specialty.Sprayed))) > 0;
			EXPORT Raw_input				:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Raw_input.Sprayed))) > 0;
		END;
		
		EXPORT Base := MODULE
		  EXPORT Main           := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Base.Main.QA))) > 0;
		  EXPORT Career         := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Base.Career.QA))) > 0;
		  EXPORT Cert           := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Base.Cert.QA))) > 0;
		  EXPORT Education      := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Base.Education.QA))) > 0;
		  EXPORT Membership     := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Base.Membership.QA))) > 0;
		  EXPORT TypeOfPractice := COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Base.TypeOfPractice.QA))) > 0;
		END;
	END;

  EXPORT Update := MODULE
	  EXPORT Main           := (FileExists.Input.BIOG OR FileExists.Input.Deceased OR
		                             FileExists.Input.MOCParticipation OR FileExists.Input.Address OR
																 FileExists.Input.Contact) AND FileExists.Base.Main;
	  EXPORT Career         := FileExists.Input.Career AND FileExists.Base.Career;
	  EXPORT Cert           := FileExists.Input.Cert AND FileExists.Base.Cert;
	  EXPORT Education      := FileExists.Input.Education AND FileExists.Base.Education;
	  EXPORT Membership     := FileExists.Input.Membership AND FileExists.Base.Membership;
	  EXPORT TypeOfPractice := FileExists.Input.TypeOfPractice AND FileExists.Base.TypeOfPractice;
	END;

END;