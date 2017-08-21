// MDS0836 / Maryland Real Estate Commission / Real Estate / RL = 601 //

export layout_MDS0836 := RECORD
	string80   ORG_NAME;
	string100  OFFICENAME;
	string100  ADDRESS1_1;
	string100  ADDRESS2_1;
	string30   CITY_1;
	string20   STATE_1;
	string30   ZIP;
	string30   EXPDT;			//yyyy-mm-dd
	string50   LIC_TYPE;
	string30   SLNUM;
	string30   LAST_UPDT;	/*mm/dd/yyyy*/
	string1		 CR;
END;