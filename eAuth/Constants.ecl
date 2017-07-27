IMPORT iesp, ut;

export Constants := MODULE
  export QNUM := 23; //adjust, when removing or adding questions

  // question ID: city, etc.
  export QID := module
    export unsigned1 NONE := 0;
    export unsigned1 COUNTY1 := 1;
    export unsigned1 ZIP1 := 2;
    export unsigned1 CITY1 := 3;
    export unsigned1 CITY2 := 4;
    export unsigned1 CITY3 := 5;
    export unsigned1 CITY4 := 6;
    export unsigned1 CITY5 := 7;
    export unsigned1 CITY6 := 8;
    export unsigned1 PEOPLE1 := 9;
    export unsigned1 PROPERTY1 := 10;
    export unsigned1 PROPERTY2 := 11;
    export unsigned1 PROPERTY3 := 12;
    export unsigned1 PROPERTY4 := 13;
    export unsigned1 PROPERTY5 := 14;
    export unsigned1 PROPERTY6 := 15;
    export unsigned1 PROPERTY7 := 16;
    export unsigned1 VEHICLE1 := 17;
    export unsigned1 VEHICLE2 := 18;
    export unsigned1 VEHICLE3 := 19;
    export unsigned1 VEHICLE4 := 20;
    export unsigned1 VEHICLE5 := 21;
    export unsigned1 ADDRESS1 := 22;
    export unsigned1 SSN1 := 23;
  end;

  export TIMELINE := module
    export unsigned1 CURRENT := 0;
    export unsigned1 PREVIOUS := 1;
    export unsigned1 OLDEST := 2;
  end;

  // number of invalid cities to generate in response to "city6" question
  export unsigned1 INVALID_CITIES := ut.Min2 (12, iesp.Constants.EAUTHORIZE.MaxInvalidAnswers);

  export t_prompt := typeof (iesp.eAuth.t_QuestionResp.Prompt);
END;
