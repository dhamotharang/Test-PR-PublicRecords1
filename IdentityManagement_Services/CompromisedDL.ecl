//This module contains functions related to checking the Compromised DL key for matching hash values
IMPORT header, python, STD;

EXPORT CompromisedDL := MODULE

  //Function that returns SHA512 hash of a given value
  string128 fn_hashValueSHA512(string s) := EMBED(Python)
      import hashlib
      return hashlib.sha512(s).hexdigest()
  ENDEMBED;

  //This function hashes a last name, ssn, and salt value and checks for a match in a key of hashes.
  //The salt value was provided by Equifax when they sent us the file of the hashes.
  EXPORT string128 fn_CheckForMatch(string lname, string9 ssn) := FUNCTION
    string salt := '8ea12e94-7805-44c2-b63f-9b07d1f0a8da';
    hashKey := header.key_compromised_dl_eq;
    cleanName(string name) :=  STD.Str.Filter(STD.Str.ToUpperCase(name), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');

    cleanedName := cleanName(lname);
    prehash := cleanedName + ssn + salt;

    //Get the hashed value. Hashes in key are converted to all uppercase.
    hashedValue := STD.Str.ToUpperCase(fn_hashValueSHA512(prehash));

    //Check if we have a match on our key. The values are all uppercase in the provided key.
    isMatchFound := EXISTS(hashKey(KEYED(lname_ssn_fixedrandom_hash = hashedValue)));

    //Return the hash itself, or a blank string if there is no match.
    RETURN IF(isMatchFound, hashedValue, '');
  END;

END;