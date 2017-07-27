export KeyType_Troy := record
  unsigned4 zip;
  string1   gender;
  unsigned6 dob;
  unsigned6 did;
  unsigned6 first_seen := 0;
  unsigned6 last_seen := 0;
  unsigned1 age := 0;
  end;