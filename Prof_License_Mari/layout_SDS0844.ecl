// SDS0844 / South Dakota Real Estate Commission / Real Estate //

export layout_SDS0844 := MODULE
	export raw := RECORD
	string5    TITLE;
	string30   LAST_NAME;
	string25   FIRST_NAME;
	string20   MID_NAME;
	string15   SLNUM;
	string30   LIC_TYPE;
	string100  OFFICENAME;
	string50   ADDRESS1;
	string35   CITY;
	string10   STATE;
	string10   ZIP;
	string10   RENEWAL;
	string100  Email;
END;

export src := RECORD
  raw;
	string8 ln_filedate;
END;

end;