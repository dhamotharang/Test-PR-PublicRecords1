export Constants := module

    // MobileTrac and Claims Discovery data filters business requirements
    export rptCodeSet := ['A','B','C','F','FA']; // Accident,Theft,TheftRecovery,Fire,FloridaAccident
    export vStatusSet := ['V']; // VIN has been validated
    export claimsApplicationType := 'INS';
    
    export MAX_RECS_ON_JOIN := 1000;
    export MAX_REQUIRED_INPUTS := 100;
    
    export FLAccident_source := ['FA']; // Florida Accident
    export NtlAccident_source := ['A']; // National Accident
    export eCrashAccident_source := ['IA','EA','TF']; // eCrash Accident

    EXPORT Report_States := ['FL'];
    EXPORT DPPA_States := ['NC'];

    EXPORT DOLRNG := 30;

    // BITMAP DATA FIELDS
    EXPORT UNSIGNED DOL := 0000000000000001b; // 1
    EXPORT UNSIGNED NAME := 0000000000000010b; // 2
    EXPORT UNSIGNED ADDR := 0000000000000100b; // 4
    EXPORT UNSIGNED VIN := 0000000000001000b; // 8
    EXPORT UNSIGNED DLNBR := 0000000000010000b; // 16
    EXPORT UNSIGNED TAG := 0000000000100000b; // 32
    EXPORT UNSIGNED SSN := 0000000001000000b; // 64
    EXPORT UNSIGNED DOB := 0000000010000000b; // 128

    EXPORT STRING sDOL := 'DOL';
    EXPORT STRING sNAME := 'NAME';
    EXPORT STRING sADDR := 'ADDR';
    EXPORT STRING sVIN := 'VIN';
    EXPORT STRING sDLNBR := 'DLNBR';
    EXPORT STRING sTAG := 'TAG';
    EXPORT STRING sSSN := 'SSN';
    EXPORT STRING sDOB := 'DOB';

end;
