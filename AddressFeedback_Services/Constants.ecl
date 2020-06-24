import AddressFeedback;

export Constants := module

  export Limits := module
    export unsigned2 FEEDBACK_PER_ADDRESS := 1000;
  end;

  // --------------------------------------------------------------
  // Shared constants
  // --------------------------------------------------------------
  
  export FEEDBACK_TYPE := module
    export unsigned1 RIGHT_PARTY_CONTACT := 1;
    export unsigned1 RELATIVE_ASSOCIATE_CONTACT := 2;
    export unsigned1 WRONG_PARTY_CLAIM := 3;
    // export unsigned1 PHONE_DISCONNECTED := 4;
    export unsigned1 NO_CONTACT := 5;
    // export unsigned1 ALTERNATE_PHONE_ENTERED := 7;
    export unsigned1 OTHER_INFO_ENTERED := 8;
  end;

  export FEEDBACK_SOURCE := module
    export unsigned1 PERSON_SEARCH := 1;
    export unsigned1 ADV_PERSON_SEARCH := 2; // same value also for deep skip search
    export unsigned1 PHONES_PLUS := 3;
    // export unsigned1 PHONES_BASIC_LOOKUP := 4;
    // export unsigned1 PHONES_REVERSE_LOOKUP := 5;
    export unsigned1 CONTACT_PLUS := 6;
    export unsigned1 PEOPLE_AT_WORK := 7;
  end;
  
  export ADDR_FEEDBACK_TYPE_INCLUDES := [
        FEEDBACK_TYPE.RIGHT_PARTY_CONTACT,
        FEEDBACK_TYPE.RELATIVE_ASSOCIATE_CONTACT,
        FEEDBACK_TYPE.WRONG_PARTY_CLAIM,
        FEEDBACK_TYPE.NO_CONTACT
      ];
  
end;
