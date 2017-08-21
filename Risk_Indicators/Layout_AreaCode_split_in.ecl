EXPORT Layout_AreaCode_split_in := RECORD
				STRING3		NPA;
				STRING3		NXX;
				STRING6		Date_established;
				STRING6		DisconnectDate; //applies only to old NXX
				STRING10	AreaExchngName;
				STRING2		lf;
			END;
