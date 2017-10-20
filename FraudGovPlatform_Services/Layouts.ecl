IMPORT BatchShare, business_risk, CriminalRecords_BatchService, DeathV2_Services, FraudShared, FraudShared_Services, 
       patriot, riskwise, VehicleV2_Services;

EXPORT Layouts := MODULE

	EXPORT velocity_counts := RECORD
		STRING velocity_count;
		STRING description;
	END;
		
	EXPORT Velocities := RECORD
		BatchShare.Layouts.ShareAcct;
		INTEGER foundCnt;
		STRING description;
		DATASET(FraudShared.Layouts_Key.Main) ds_payload;
	END;
  
  EXPORT BatchOut := RECORD
    FraudShared_Services.Layouts.BatchIn_rec;
    BatchShare.Layouts.ShareErrors;
    INTEGER RiskCount;
    STRING Reason1;
    STRING Reason2;
    STRING Reason3;
    STRING Reason4;
    STRING Reason5;
    string30 ClientID;            //Unique Identifier  
    string30 CaseID  ;
    string1  ExceedsVelocityMax;  //Y if greater that max value, N if lessthan or equal to max value, blank if not matches found
    String8  Activity_Date1;
    string40 Activity_Reason1;
    string40 Activity_Place1;
    string8  Activity_Date2;
    string40 Activity_Reason2;
    string40 Activity_Place2;
    String8  Activity_Date3;
    string40 Activity_Reason3;
    string40 Activity_Place3;
    String8  Activity_Date4;
    string40 Activity_Reason4;
    string40 Activity_Place4;
    String8  Activity_Date5;
    string40 Activity_Reason5;
    string40 Activity_Place5;
    String8  Activity_Date6;
    string40 Activity_Reason6;
    string40 Activity_Place6;  
    String8  Activity_Date7;
    string40 Activity_Reason7;
    string40 Activity_Place7;  
    String8  Activity_Date8;
    string40 Activity_Reason8;
    string40 Activity_Place8;
    String8  Activity_Date9;
    string40 Activity_Reason9;
    string40 Activity_Place9;  
    String8  Activity_Date10;
    string40 Activity_Reason10;
    string40 Activity_Place10;
    
    DeathV2_Services.layouts.BatchOut;
    CriminalRecords_BatchService.Layouts.batch_out;
    riskwise.layouts.red_flags_batch_layout;  //Red Flag
    patriot.layout_batch_out;   //Global Watchlist/Patriot

  END;  
  
  EXPORT fragment_counters_rec := RECORD
    unsigned4 matches_IP_ADDRESS := 0;
    unsigned4 matches_BUSINESS := 0;
    unsigned4 matches_ADDRESS := 0;
    unsigned4 matches_SSN := 0;
    unsigned4 matches_PHONE := 0;
    unsigned4 matches_DEVICE_ID := 0;
    unsigned4 matches_LICENSED_PROFESSIONAL := 0;
    unsigned4 matches_PERSON := 0;
    unsigned4 matches_TIN := 0;
    unsigned4 matches_PROVIDER := 0;
    unsigned4 matches_EMAIL_ADDRESS := 0;
    unsigned4 howManyPayloadRecs := 0;
    FraudShared_Services.Layouts.BatchIn_Valid_rec;
    DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) payloadRecs;
  END;
	
  EXPORT KnownFrauds_rec := RECORD
    BatchShare.Layouts.ShareAcct;
    DATASET(FraudShared_Services.Layouts.Raw_Payload_rec) childRecs_KnownFrauds;
  END;

  EXPORT KnownFrauds_BatchOut_rec := RECORD
    BatchShare.Layouts.ShareAcct;
    unsigned4 known_risks_cnt := 0;            // How many KNFD records?
    string100 known_risk_reason1 := '';
    string100 known_risk_reason2 := '';
    string100 known_risk_reason3 := '';
    string100 Known_risk_reason4 := '';
    string100 Known_risk_reason5 := '';
  END;

  EXPORT Payload_Match_rec := RECORD
    FraudShared_Services.Layouts.BatchIn_Valid_rec batchinValidRec;
    FraudShared_Services.Layouts.Raw_Payload_rec   payloadRec;
    boolean matchesFullName           := false;
    boolean matchesPhysicalAddress    := false;
    boolean matchesMailingAddress     := false;
    boolean matchesSSN                := false;
    boolean matchesDOB                := false;
    boolean matchesPhone              := false;
    boolean matchesPerson             := false;  //matchesDID ??
    boolean matchesBusiness           := false;
    boolean matchesEmailAddress       := false;
    boolean matchesDevice             := false;
    boolean matchesIpAddress          := false;
    boolean matchesProfessionalid     := false;
    boolean matchesLnpid              := false;
    boolean matchesNpi                := false;
    boolean matchesAppendedproviderid := false;
    boolean matchesTin                := false;
    boolean matchesGeo                := false;
    boolean matchesBankAccount        := false;
    boolean matchesDL                 := false;
  END;
	
	EXPORT BatchOut_risk := RECORD
		unsigned2 risk_score := 0;                 // 0 - 100
    string6   risk_level := '';                // High, Medium, Low
    string1   identity_resolved := '';         // Y or N             ?? Isn't this just whether the LexId field below is not zero ??
    unsigned6 LexID := 0;         
	END;

  EXPORT BatchOut_rec := RECORD
    unsigned4 seq;                             // join back as needed   
    BatchShare.Layouts.ShareAcct;              
    BatchOut_risk;
    unsigned4 identity_activities_cnt := 0;    // How many IDDT records?
    unsigned2 velocity_exceeded_cnt := 0;
    string100 velocity_exceeded_reason1;
    string100 velocity_exceeded_reason2;
    string100 velocity_exceeded_reason3;
    KnownFrauds_BatchOut_rec - BatchShare.Layouts.ShareAcct;
  END;
	
	EXPORT combined_layouts := RECORD
		UNSIGNED seq;
		riskwise.layouts.red_flags_online_layout;
		riskwise.layouts.red_flags_batch_layout;
	END;	
	
  EXPORT Batch_out_pre_rec := RECORD
		BatchOut_risk;    
    BatchShare.Layouts.ShareAcct;              // to join back to input criteria
    FraudShared_Services.Layouts.BatchIn_rec batchin_rec;
    DATASET(DeathV2_Services.layouts.BatchOut) childRecs_Death;
    DATASET(CriminalRecords_BatchService.Layouts.batch_out) childRecs_Criminal;
    DATASET(combined_layouts) childRecs_RedFlag;
    DATASET(Patriot.layout_batch_out) childRecs_Patriot;
		DATASET(KnownFrauds_BatchOut_rec) childRecs_KnownFrauds;
    DATASET(Velocities) childRecs_Velocities;
  END;
END;