//This module contains functions related to checking the Compromised DL key for matching hash values
IMPORT doxie, header, IdentityManagement_Services, python, STD, UT;

EXPORT CompromisedDL := MODULE
    SHARED string cleanName(string name) :=  STD.Str.Filter(STD.Str.ToUpperCase(name), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
    SHARED string salt := 'a7b0de53-fa7f-43ba-bcee-6cf4056dbc61';
    SHARED hashKey := header.key_compromised_dl_eq;

    //Function that returns SHA512 hash of a given value
    SHARED STRING128 fn_hashValueSHA512(string valueToHash) := FUNCTION
        string128 sha512(string s) := EMBED(Python)
            import hashlib
            return hashlib.sha512(s).hexdigest()
        ENDEMBED;

        RETURN sha512(valueToHash);
    END;

    //This function hashes a last name, ssn, and salt value and checks for a match in a key of hashes.
    //The salt value was provided by Equifax when they sent us the file of the hashes.
    EXPORT string128 fn_CheckForMatch(string lname, string9 ssn) := FUNCTION
        cleanedName := cleanName(lname);
        prehash := cleanedName + ssn + salt;

        //Get the hashed value
        hashedValue := fn_hashValueSHA512(prehash);

        //Check if we have a match on our key. The values are all uppercase in the provided key.
        isMatchFound := EXISTS(hashKey(lname_ssn_fixedrandom_hash = STD.Str.ToUpperCase(hashedValue)));

        //Return the hash itself, or a blank string if there is no match.
        RETURN IF(isMatchFound, STD.Str.ToUpperCase(hashedValue), '');
    END;

END;