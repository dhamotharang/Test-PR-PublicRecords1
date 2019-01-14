EXPORT macComputeBusinessPersonNameIndex(dIn, InFirstName, InMiddleName, InLastName, InNameSuffix, InRawName = '', InJobId, keyName, InContextUID = '',
  dContactIn = '', InContactFirstName = '', InContactMiddleName = '', InContactLastName = '', InContactNameSuffix = '', InContactContextUID = '') := FUNCTIONMACRO
  IMPORT Address, NID, lib_metaphone;
  
  LOCAL rBusinessPerson := RECORD
    dIn;
    STRING100  #EXPAND(keyName + 'FirstName');
    STRING20  #EXPAND(keyName + 'MiddleName');
    STRING100  #EXPAND(keyName + 'LastName');
    STRING10  #EXPAND(keyName + 'NameSuffix');
    STRING6  #EXPAND(keyName + 'PhoneticLastName');
		STRING20 #EXPAND(keyName + 'PreferredFirstName');
  END;
  
  LOCAL dBestName := PROJECT(dIn(InLastName <> ''), 
		TRANSFORM(rBusinessPerson,
      SELF.#EXPAND(keyName + 'FirstName') := LEFT.InFirstName;
      SELF.#EXPAND(keyName + 'MiddleName') := LEFT.InMiddleName;
      SELF.#EXPAND(keyName + 'LastName') := LEFT.InLastName;
      SELF.#EXPAND(keyName + 'NameSuffix') := LEFT.InNameSuffix;
			SELF.#EXPAND(keyName + 'PhoneticLastName') 	:= metaphonelib.DMetaPhone1(LEFT.InLastName)[1..6],
			SELF.#EXPAND(keyName + 'PreferredFirstName') := NID.PreferredFirstNew(LEFT.InFirstName),
			SELF := LEFT));
  
  LOCAL dRawName := 
  #IF(#TEXT(InRawName) != '')
    PROJECT(dIn(InRawName <> ''),
      TRANSFORM(rBusinessPerson,
        CleanInputName := Address.CleanNameFields(Address.CleanPerson73(LEFT.InRawName)).CleanNameRecord;
        SELF.#EXPAND(keyName + 'FirstName') := CleanInputName.fname;
        SELF.#EXPAND(keyName + 'MiddleName') := CleanInputName.mname;
        SELF.#EXPAND(keyName + 'LastName') := CleanInputName.lname;
        SELF.#EXPAND(keyName + 'NameSuffix') := CleanInputName.name_suffix;
        SELF.#EXPAND(keyName + 'PhoneticLastName') 	:= metaphonelib.DMetaPhone1(CleanInputName.lname)[1..6],
        SELF.#EXPAND(keyName + 'PreferredFirstName') := NID.PreferredFirstNew(CleanInputName.fname),
        SELF := LEFT));
  #ELSE
    DATASET([], rBusinessPerson);
  #END
  
  LOCAL dContactName := 
  #IF(#TEXT(dContactIn) != '' AND #TEXT(InContactFirstName) != '' AND #TEXT(InContactLastName) != '')
    PROJECT(dContactIn(InContactLastName <> ''),
      TRANSFORM(rBusinessPerson,
        SELF.#EXPAND(keyName + 'FirstName') := LEFT.InContactFirstName;
        #IF(#TEXT(InContactMiddleName) != '')
          SELF.#EXPAND(keyName + 'MiddleName') := LEFT.InContactMiddleName;
        #END
        SELF.#EXPAND(keyName + 'LastName') := LEFT.InContactLastName;
        #IF(#TEXT(InContactNameSuffix) != '')
          SELF.#EXPAND(keyName + 'NameSuffix') := LEFT.InContactNameSuffix;
        #END
        SELF.#EXPAND(keyName + 'PhoneticLastName') 	:= metaphonelib.DMetaPhone1(LEFT.InContactLastName)[1..6],
        SELF.#EXPAND(keyName + 'PreferredFirstName') := NID.PreferredFirstNew(LEFT.InContactFirstName),
        #IF(#TEXT(InContextUID) != '' AND #TEXT(InContactContextUID) != '')
          SELF.InContextUID := LEFT.InContactContextUID,
        #END
        SELF := LEFT,
        SELF := []));
  #ELSE
    DATASET([], rBusinessPerson);
  #END
  
  LOCAL dKey := dBestName + dRawName + dContactName;
  
  LOCAL strKeyName      := '~biz::key::'+ (STRING)keyName + 'name::' + (STRING)InJobId;
	LOCAL KeyBusinessPersonName := INDEX(dKey, 
    {#EXPAND(keyName + 'PhoneticLastName'),#EXPAND(keyName + 'LastName'), #EXPAND(keyName + 'PreferredFirstName'),
		 #EXPAND(keyName + 'MiddleName'),#EXPAND(keyName + 'FirstName')},
     {dKey}, strKeyName);
  RETURN KeyBusinessPersonName;
ENDMACRO;