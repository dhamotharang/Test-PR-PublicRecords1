IMPORT Doxie_Raw, Progressive_Phone, Phone_Shell, Risk_Indicators, RiskWise, UT;

EXPORT Layouts := MODULE
  EXPORT layout_Title := RECORD
    Progressive_Phone.layout_did_seq;
    STRING20 Title := '';
  END;

  EXPORT Layout_Relatives := RECORD
    Doxie_Raw.Layout_RelativeRawBatchInput;
    UNSIGNED4 Rel_Rank;
  END;

  EXPORT layoutWithCohabitDid := RECORD
    Progressive_Phone.layout_progressive_batch_out_with_did;
    INTEGER rel_prim_range;
    BOOLEAN same_lname;
    UNSIGNED8 recent_cohabit;
    UNSIGNED4 rel_rank;
    UNSIGNED1 TitleNo := 0;
    STRING8 DateOfBirth;
  END;

  EXPORT Layout_Parent_Spouse_Relative_RawData := RECORD
    Progressive_Phone.layout_progressive_batch_out_with_did;
    STRING8 DateOfBirth;
    UNSIGNED1 TitleNo := 0;
  END;

  EXPORT layoutUniqueAddresses := RECORD
    UNSIGNED8 seq := 0;
    UNSIGNED8 DID := 0;
    STRING20 FirstName := '';
    STRING20 LastName := '';
    STRING10 HomePhone := '';
    STRING10 WorkPhone := '';
    STRING8 DateOfBirth := '';
    STRING9 SSN := '';
    STRING8 DateLastSeen := '';
    STRING10 Prim_Range := '';
    STRING2 Predir := '';
    STRING28 Prim_Name := '';
    STRING4 Addr_Suffix := '';
    STRING8 Sec_Range := '';
    STRING5 Zip5 := '';
    STRING25 City := '';
    STRING2 State := '';
  END;

  EXPORT	Bureau_Phones := record
    Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus.Clean_Input.Seq;
    UNSIGNED8 DID	;
    STRING8 Bureau_Last_Update;
    STRING10 Gathered_Phone;
    BOOLEAN Bureau_Verified;
  END;

END;
