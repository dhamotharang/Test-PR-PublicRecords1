IMPORT AutoStandardI, Gateway, iesp, Suppress, ut;

EXPORT IParams := MODULE

  EXPORT DatasetSelection := INTERFACE
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
    EXPORT BOOLEAN IncludeInquiries;    
    EXPORT BOOLEAN IncludeLiens;    
    EXPORT BOOLEAN IncludeMarriageDivorce;    
    EXPORT BOOLEAN IncludeOffenders;    
    EXPORT BOOLEAN IncludeOptOut;    
    EXPORT BOOLEAN IncludePAW;    
    EXPORT BOOLEAN IncludePilot;    
    EXPORT BOOLEAN IncludeProfLicense;    
    EXPORT BOOLEAN IncludeProperties;    
    EXPORT BOOLEAN IncludeSSN;    
    EXPORT BOOLEAN IncludeSSNFromInquiries;    
    EXPORT BOOLEAN IncludeStudent;    
    EXPORT BOOLEAN IncludeThrive;    
    EXPORT BOOLEAN IncludeUCC;    
    EXPORT BOOLEAN IncludeWatercraft;    
  END;

  EXPORT IParam := INTERFACE(DatasetSelection)
    EXPORT INTEGER nss;
    EXPORT DATASET(Gateway.Layouts.Config) gateways;
    EXPORT BOOLEAN ReturnSuppressed;
    EXPORT BOOLEAN ReturnOverwritten;    
    EXPORT BOOLEAN ReturnDisputed;
  END;

  EXPORT GetParams(iesp.fcradataservice.t_FcraDataServiceOptions options) := FUNCTION
  
    BOOLEAN includeAll := options.DatasetSelection.IncludeAll;
    
    inmod := MODULE  (PROJECT(AutoStandardI.GlobalModule(), IParam, opt))  
      EXPORT BOOLEAN ReturnDisputed := options.ReturnDisputedRecords;
      EXPORT INTEGER nss := ut.GetNonSubjectSuppression(Suppress.Constants.NonSubjectSuppression.doNothing);
      EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
      EXPORT BOOLEAN ReturnSuppressed := options.ReturnSuppressedRecords;
      EXPORT BOOLEAN ReturnOverwritten := options.ReturnOverwrittenRecords;
      EXPORT BOOLEAN IncludeAircraft := options.DatasetSelection.IncludeAircraft OR includeAll;
      EXPORT BOOLEAN IncludeAdvo := options.DatasetSelection.IncludeAdvo OR includeAll;
      EXPORT BOOLEAN IncludeATF := options.DatasetSelection.IncludeATF OR includeAll;
      EXPORT BOOLEAN IncludeAVM := options.DatasetSelection.IncludeAVM OR includeAll;
      EXPORT BOOLEAN IncludeBankruptcy := options.DatasetSelection.IncludeBankruptcy OR includeAll;
      EXPORT BOOLEAN IncludeCriminal := options.DatasetSelection.IncludeCriminal OR includeAll;
      EXPORT BOOLEAN IncludeDeath := options.DatasetSelection.IncludeDeath OR includeAll;
      EXPORT BOOLEAN IncludeEmail := options.DatasetSelection.IncludeEmail OR includeAll;    
      EXPORT BOOLEAN IncludeGong := options.DatasetSelection.IncludeGong OR includeAll;      
      EXPORT BOOLEAN IncludeHeader := options.DatasetSelection.IncludeHeader OR includeAll;      
      EXPORT BOOLEAN IncludeHuntingFishing := options.DatasetSelection.IncludeHuntingFishing OR includeAll;      
      EXPORT BOOLEAN IncludeInfutor := options.DatasetSelection.IncludeInfutor OR includeAll;    
      EXPORT BOOLEAN IncludeInquiries := options.DatasetSelection.IncludeInquiries OR includeAll;    
      EXPORT BOOLEAN IncludeLiens := options.DatasetSelection.IncludeLiens OR includeAll;    
      EXPORT BOOLEAN IncludeMarriageDivorce := options.DatasetSelection.IncludeMarriageDivorce OR includeAll;    
      EXPORT BOOLEAN IncludeOffenders := options.DatasetSelection.IncludeOffenders OR includeAll;    
      EXPORT BOOLEAN IncludeOptOut := options.DatasetSelection.IncludeOptOuts OR includeAll;    
      EXPORT BOOLEAN IncludePAW := options.DatasetSelection.IncludePeopleAtWork OR includeAll;    
      EXPORT BOOLEAN IncludePilot := options.DatasetSelection.IncludePilot OR includeAll;    
      EXPORT BOOLEAN IncludeProfLicense := options.DatasetSelection.IncludeProfessionalLicenses OR includeAll;    
      EXPORT BOOLEAN IncludeProperties := options.DatasetSelection.IncludeProperties OR includeAll;    
      EXPORT BOOLEAN IncludeSSN := options.DatasetSelection.IncludeSSN OR includeAll;    
      EXPORT BOOLEAN IncludeSSNFromInquiries := (IncludeSSN AND IncludeInquiries) OR includeAll;    
      EXPORT BOOLEAN IncludeStudent := options.DatasetSelection.IncludeStudents OR includeAll;    
      EXPORT BOOLEAN IncludeThrive := options.DatasetSelection.IncludeThrive OR includeAll;    
      EXPORT BOOLEAN IncludeUCC := options.DatasetSelection.IncludeUCC OR includeAll;    
      EXPORT BOOLEAN IncludeWatercraft := options.DatasetSelection.IncludeWatercraft OR includeAll;    
    END;
    
    RETURN inmod;
  END;
  
  EXPORT SetInputUser(iesp.share.t_User user) := FUNCTION
    // Non subject suppression
    UNSIGNED1 non_subject_suppression := GLOBAL(user).NonSubjectSuppression; 
    #STORED('NonSubjectSuppression', non_subject_suppression);
    RETURN OUTPUT(DATASET([],{INTEGER x}),NAMED('__internal__'),EXTEND);
  END;
  

END;