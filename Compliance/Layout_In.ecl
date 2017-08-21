EXPORT Layout_In := 
	RECORD
		string orig_LexID := '';		//As of January 2014. If this is populated then is the only search criteria considered.
		string TimeStamp := '';
		string Time := '';
		string Data_Src := '';
		string Action := '';
		string DPPA := '';
		string GLBA := '';
		string REFERENCE := '';
		string IP_Address := '';
		string IP_Location := '';
		string Billgroup := '';
		string WebID := '';
		string LexisID := '';
		string Password := '';
		string lib := '';
		string file := '';
		string Document_Num := '';
		string Database := '';
		string Ansr_Count := '';
		string permission_5A := '';
		string Orig_Search_Terms := '';		//"searchstr" in original spreadsheet. Have to change the name because "searchstr" is used later.
		string Edited_Search_Terms := '';	//This may be original data, but usually have to calculate. Using an Excel formula for now; have to write ECL for it some time.

//Above fields provided by IADP. Following are added fields:
		integer8  orig_rid := 0;					//added Sept 2014, to keep track of original rows, given some rows may now have multiple orig_LexID, which is now the main search criteria
		string		search_str := '';				//this is the same as Edited_Search_Terms; need it later on
		integer8  append_row_ID := 0;			//add a row identifier to (normalized) file
	END;

//----------------------------------------------------	

/*	
	RECORD
  string timestamp;
  string time;
  string data_src;
  string action;
  string dppa;
  string glba;
  string reference;
  string ip_address;
  string ip_location;
  string billgroup;
  string webid;
  string lexisid;
  string password;
  string lib;
  string file;
  string document_num;
  string database;
  string ansr_count;
  string permission_5a;
  string search_str;
  string edited_search_terms;
  integer8 append_row_id;
  
 END;
*/