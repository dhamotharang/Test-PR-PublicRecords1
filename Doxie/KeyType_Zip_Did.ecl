import header;

h := header.File_Headers;

export KeyType_Zip_Did := record
  qstring20 lname;
  string1	   fi := h.fname[1];
  qstring20 fname;
  unsigned3 zip;
  unsigned4 dt_last_seen;  
  unsigned4 cnt;
  unsigned6 b_did;
  unsigned6 l_did;
  end;