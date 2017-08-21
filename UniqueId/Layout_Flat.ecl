

EXPORT Layout_Flat := RECORD

	unsigned8 primarykey := 0;
  string WatchListName;
  string id;
  string WatchListDate;
  string WatchListType;
  string type;
  string Entity_Unique_ID;
  unicode title;
  unicode first_name;
  unicode middle_name;
  unicode last_name;
  unicode generation;
  unicode full_name;
  string gender;
  string listed_date;
  string modified_date;
  string entity_added_by;
  string reason_listed;
  string reference_id;
	unicode	akas := '';
	unicode	addresses := '';
	unicode	infos := '';
	unicode	ids := '';
	unicode	phones := '';
	string	dob := '';
  unicode comments;
	integer n_aka := 0;
	integer n_address := 0;
	integer n_info := 0;
	integer n_id := 0;
	integer n_phone := 0;

END;