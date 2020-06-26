EXPORT Constants := MODULE

  EXPORT ssn_indicators := MODULE
    EXPORT is_partial := 1b;
    EXPORT is_itin    := 10b;
    EXPORT is_666     := 100b;
    EXPORT is_eae     := 1000b;
    EXPORT is_advertising := 10000b;
    EXPORT is_woolworth   := 100000b;
    EXPORT is_invalid_area := 1000000b;
    EXPORT is_invalid_group := 10000000b;
    EXPORT area_group_not_issued := 100000000b;
    EXPORT is_invalid_serial := 1000000000b;
  END;

  EXPORT no_longer_reported := MODULE
                            //                    en      eq
                            //                 xnadsp  xnadsp
                            // rrrrrrrrrrrrrrrr000000rr000000rr
    // *** Experian
    EXPORT did_not_in_en    := 00000000000000001000000000000000b; // 32768
    EXPORT name_not_in_en   := 00000000000000000100000000000000b; // 16384
    EXPORT addr_not_in_en   := 00000000000000000010000000000000b; //  8192
    EXPORT dob_not_in_en    := 00000000000000000001000000000000b; //  4096
    EXPORT ssn_not_in_en    := 00000000000000000000100000000000b; //  2048
    EXPORT phone_not_in_en    := 00000000000000000000010000000000b; //  1024
    EXPORT lname_not_in_en    := 00000000000000000000001000000000b; //  1024
    // *** Equifax
    EXPORT did_not_in_eq    := 00000000000000000000000010000000b; //   128
    EXPORT name_not_in_eq   := 00000000000000000000000001000000b;
    EXPORT addr_not_in_eq   := 00000000000000000000000000100000b; //    32
    EXPORT dob_not_in_eq    := 00000000000000000000000000010000b;
    EXPORT ssn_not_in_eq    := 00000000000000000000000000001000b; //     8
    EXPORT phone_not_in_eq    := 00000000000000000000000000000100b;
    EXPORT lname_not_in_eq    := 00000000000000000000000000000010b;
    // *** Transunion #74029
    EXPORT did_not_in_tn    := 00000000100000000000000000000000b; //
    EXPORT name_not_in_tn   := 00000000010000000000000000000000b;
    EXPORT addr_not_in_tn   := 00000000001000000000000000000000b; //
    EXPORT dob_not_in_tn    := 00000000000100000000000000000000b;
    EXPORT ssn_not_in_tn    := 00000000000010000000000000000000b; //
    EXPORT phone_not_in_tn    := 00000000000001000000000000000000b;
    EXPORT lname_not_in_tn    := 00000000000000100000000000000000b;
  END;

  // QH (quick header) AKA: FH (Fast Header) is merged with full header at query time.  Max rid in header today is less than 200,000,000,000.
  // therefore, starting QH rids at 999,999,999,999 to avoid rid collissions
  EXPORT QH_start_rid := 999999999999;

  // LexID types
  EXPORT DidType := MODULE
    EXPORT string DEAD     := 'DEAD';
    EXPORT string NOISE    := 'NOISE';
    EXPORT string H_MERGE  := 'H_MERGE';
    EXPORT string C_MERGE  := 'C_MERGE';
    EXPORT string INACTIVE := 'INACTIVE';
    EXPORT string AMBIG    := 'AMBIG';
    EXPORT string NO_SSN   := 'NO_SSN';
    EXPORT string CORE     := 'CORE';
  END;

  EXPORT string DataSetName := 'header_8'; //for testing the build
END;
