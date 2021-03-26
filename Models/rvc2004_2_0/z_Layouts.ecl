EXPORT z_layouts := MODULE
  EXPORT Input_Layout := z_layouts_Input;

  EXPORT Input_Layouts := RECORD
	  Input_Layout;
      BOOLEAN do_RVC2004_2_0 := TRUE;
  END;

  EXPORT StandLayouts := RECORD
    Input_Layout;
	STRING STD_scr;
	STRING STDRawScore;
    SET OF STRING5 STD_RC := [];
    SET OF STRING5 STD_RC1 := [];
	STRING SOURCE;
  END;

  EXPORT CompLayouts := RECORD
    Input_Layout;
	STRING SOURCE;
  END;

  EXPORT AuditLayouts := RECORD
/* 	•	Attribute value;
   	•	Point assignments;
   	•	Contribution value;
   	•	Raw score;
   	•	Final score;
   	•	Reason code;
   	•	Group type;
   	•	Reason code messages.
*/
    Input_Layout;
    STRING GROUPTYPE;
    STRING RCMessage1;
    STRING RCMessage2;
    STRING RCMessage3;
    STRING RCMessage4;
    STRING RCMessage5;

	END;
END;
