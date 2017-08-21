IMPORT _Control, tools;

EXPORT _Flags := MODULE

	EXPORT IsTesting := tools._Constants.IsDataland;

	EXPORT FileExists := MODULE
		EXPORT Input := MODULE
		  EXPORT Accident						:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Accident.Sprayed))) > 0;
			EXPORT AccidentAbstract		:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.AccidentAbstract.Sprayed))) > 0;
		  EXPORT AccidentInjury			:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.AccidentInjury.Sprayed))) > 0;
		  EXPORT Inspection					:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Inspection.Sprayed))) > 0;
		  EXPORT OptionalInfo				:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.OptionalInfo.Sprayed))) > 0;
		  EXPORT RelatedActivity		:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.RelatedActivity.Sprayed))) > 0;
		  EXPORT StrategicCodes			:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.StrategicCodes.Sprayed))) > 0;
		  EXPORT Violation					:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.Violation.Sprayed))) > 0;
		  EXPORT GenDutyStd					:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.GenDutyStd.Sprayed))) > 0;
		  EXPORT ViolationEvent			:= COUNT(NOTHOR(FileServices.SuperFileContents(Filenames().Input.ViolationEvent.Sprayed))) > 0;
		END;
		
	END;

END;