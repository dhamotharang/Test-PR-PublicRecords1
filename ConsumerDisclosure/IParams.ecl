IMPORT AutoStandardI, ConsumerDisclosure, FFD, Gateway, iesp, Suppress, ut;

EXPORT IParams := MODULE

	EXPORT DatasetSelection := INTERFACE
		EXPORT BOOLEAN includeAll;
		EXPORT BOOLEAN IncludeAircraft;
		EXPORT BOOLEAN IncludeAdvo;
		EXPORT BOOLEAN IncludeATF;
		EXPORT BOOLEAN IncludeAVM;
		EXPORT BOOLEAN IncludeBankruptcy;		
		EXPORT BOOLEAN IncludeCriminal;		
		EXPORT BOOLEAN IncludeDeath;		
		EXPORT BOOLEAN IncludeGong;		
		EXPORT BOOLEAN IncludeEmail;		
		EXPORT BOOLEAN IncludeHeader;		
		EXPORT BOOLEAN IncludeHuntingFishing;		
		EXPORT BOOLEAN IncludeInfutor;		
		EXPORT BOOLEAN IncludeLiens;		
		EXPORT BOOLEAN IncludeMarriageDivorce;		
		EXPORT BOOLEAN IncludeOffenders;		
		EXPORT BOOLEAN IncludePAW;		
		EXPORT BOOLEAN IncludePilot;		
		EXPORT BOOLEAN IncludeProfLicense;		
		EXPORT BOOLEAN IncludeProperties;		
		EXPORT BOOLEAN IncludeStudent;		
		EXPORT BOOLEAN IncludeUCC;		
		EXPORT BOOLEAN IncludeWatercraft;		
	END;

	EXPORT IParam := INTERFACE(DatasetSelection)
		EXPORT integer nss;
		EXPORT dataset(Gateway.Layouts.Config) gateways;
		EXPORT BOOLEAN ReturnSuppressed;
		EXPORT BOOLEAN ReturnOverwritten;		
		EXPORT BOOLEAN ReturnDisputed;
	END;

	EXPORT GetParams(iesp.fcradataservice.t_FcraDataServiceOptions options) := FUNCTION
	
		inmod := MODULE	(PROJECT(AutoStandardI.GlobalModule(), IParam, opt))	
			EXPORT BOOLEAN ReturnDisputed := options.ReturnDisputedRecords;
			EXPORT INTEGER nss := ut.GetNonSubjectSuppression(Suppress.Constants.NonSubjectSuppression.doNothing);
			EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
			EXPORT BOOLEAN ReturnSuppressed := options.ReturnSuppressedRecords;
			EXPORT BOOLEAN ReturnOverwritten := options.ReturnOverwrittenRecords;
			EXPORT BOOLEAN includeAll := options.DatasetSelection.IncludeAll;
			EXPORT BOOLEAN IncludeAircraft := options.DatasetSelection.IncludeAircraft;
			EXPORT BOOLEAN IncludeAdvo := options.DatasetSelection.IncludeAdvo;
			EXPORT BOOLEAN IncludeATF := options.DatasetSelection.IncludeATF;
			EXPORT BOOLEAN IncludeAVM := options.DatasetSelection.IncludeAVM;
			EXPORT BOOLEAN IncludeBankruptcy := options.DatasetSelection.IncludeBankruptcy;
			EXPORT BOOLEAN IncludeCriminal := options.DatasetSelection.IncludeCriminal;
			EXPORT BOOLEAN IncludeDeath := options.DatasetSelection.IncludeDeath;
			EXPORT BOOLEAN IncludeEmail := options.DatasetSelection.IncludeEmail;		
			EXPORT BOOLEAN IncludeGong := options.DatasetSelection.IncludeGong;			
			EXPORT BOOLEAN IncludeHeader := options.DatasetSelection.IncludeHeader;			
			EXPORT BOOLEAN IncludeHuntingFishing := options.DatasetSelection.IncludeHuntingFishing;			
			EXPORT BOOLEAN IncludeInfutor := options.DatasetSelection.IncludeInfutor;		
			EXPORT BOOLEAN IncludeLiens := options.DatasetSelection.IncludeLiens;		
			EXPORT BOOLEAN IncludeMarriageDivorce := options.DatasetSelection.IncludeMarriageDivorce;		
			EXPORT BOOLEAN IncludeOffenders := options.DatasetSelection.IncludeOffenders;		
			EXPORT BOOLEAN IncludePAW := options.DatasetSelection.IncludePeopleAtWork;		
			EXPORT BOOLEAN IncludePilot := options.DatasetSelection.IncludePilot;		
			EXPORT BOOLEAN IncludeProfLicense := options.DatasetSelection.IncludeProfessionalLicenses;		
			EXPORT BOOLEAN IncludeProperties := options.DatasetSelection.IncludeProperties;		
			EXPORT BOOLEAN IncludeStudent := options.DatasetSelection.IncludeStudents;		
			EXPORT BOOLEAN IncludeUCC := options.DatasetSelection.IncludeUCC;		
			EXPORT BOOLEAN IncludeWatercraft := options.DatasetSelection.IncludeWatercraft;		
		END;
		
		RETURN inmod;
	END;
	
	EXPORT SetInputUser(iesp.share.t_User user) := FUNCTION
		// Non subject suppression
		unsigned1 non_subject_suppression := GLOBAL(user).NonSubjectSuppression; 
		#stored('NonSubjectSuppression', non_subject_suppression);
		RETURN OUTPUT(DATASET([],{INTEGER x}),NAMED('__internal__'),EXTEND);
	END;
	

END;