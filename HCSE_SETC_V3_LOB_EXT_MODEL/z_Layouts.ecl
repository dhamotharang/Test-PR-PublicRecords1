EXPORT z_layouts := MODULE
  EXPORT Input_Layout := RECORD
  // To be provided from actual file layout
  END;
  EXPORT Input_Layouts := RECORD
	  Input_Layout;
      BOOLEAN do_Model1 := TRUE;
  END;

  EXPORT StandLayouts := RECORD
    Input_Layout;
	STRING STD_scr;
	STRING STDRawScore;
    SET OF STRING5 STD_RC := [];
	STRING SOURCE;
  END;

  EXPORT CompLayouts := RECORD
    Input_Layout;
	STRING SOURCE;
  END;

  EXPORT AuditLayouts := RECORD
/* 	�	Attribute value;
   	�	Point assignments;
   	�	Contribution value;
   	�	Raw score;
   	�	Final score;
   	�	Reason code;
   	�	Group type;
   	�	Reason code messages.
*/
    Input_Layout;
    STRING GROUPTYPE;
	END;
END;
