// ORS0839 / Oregon Real Estate Agency / Real Estate //

export layout_ORS0839 := MODULE

		export individual := RECORD
				string30   LAST_NAME;
				STRING1		 FILLER1;	
				string30   FIRST_NAME;
				STRING1		 FILLER2;	
				string30   MID_NAME;
				STRING1		 FILLER3;	
				string50   ADDRESS1;	
				STRING1		 FILLER4;	
				string50   ADDRESS2;	
				STRING1		 FILLER5;	
				string30   CITY;
				STRING1		 FILLER6;	
				string2    STATE;
				string10   ZIP;
				STRING1		 FILLER7;	
				string30   COUNTY;
				STRING1		 FILLER8;	
				// string20   PHONE;
				string30   LIC_NUMBER;
				STRING1		 FILLER9;	
				//string30   LIC_ISSUE_DATE;  not provided since 20130131
				string30   LIC_EXP_DATE;
				STRING1		 FILLER10;	
				string30   LIC_STATUS;
				//string30   LIC_TYPE;   not provided by vendor since 20130131
				//string30   SECONDARY_LIC_TYPE;
				string100  ORG_NAME;
		END;
		//Used for 20140102 and before
		// export individual := RECORD
				// string30   LAST_NAME;
				// string30   FIRST_NAME;
				// string30   MID_NAME;
				// string50   ADDRESS1;	
				// string50   ADDRESS2;	
				// string30   CITY;
				// string2    STATE;
				// string10   ZIP;
				// string30   COUNTY;
				//string20   PHONE;
				// string30   LIC_NUMBER;
				//string30   LIC_ISSUE_DATE;  not provided since 20130131
				// string30   LIC_EXP_DATE;
				// string30   LIC_STATUS;
				//string30   LIC_TYPE;   not provided by vendor since 20130131
				// string30   SECONDARY_LIC_TYPE;
				// string100  ORG_NAME;
		// END;

		export business := RECORD
				string100  ORG_NAME;
				STRING1		 FILLER1;	
				string50   ADDRESS1;	
				STRING1		 FILLER2;	
				string50   ADDRESS2;	
				STRING1		 FILLER3;	
				string30   CITY;
				STRING1		 FILLER4;	
				string2    STATE;
				string10   ZIP;
				STRING1		 FILLER5;	
				string30   COUNTY;
				string20   PHONE;
				STRING1		 FILLER6;	
				string30   LIC_NUMBER;
				STRING1		 FILLER7;	
				// string30   LIC_ISSUE_DATE;
				// string30   LIC_EXP_DATE;
		END;
		//Used for 20140102 and before
		// export business := RECORD
				// string100  ORG_NAME;
				// string50   ADDRESS1;	
				// string50   ADDRESS2;	
				// string30   CITY;
				// string2    STATE;
				// string10   ZIP;
				// string30   COUNTY;
				// string20   PHONE;
				// string30   LIC_NUMBER;
				// string30   LIC_ISSUE_DATE;
				// string30   LIC_EXP_DATE;
		// END;

END;