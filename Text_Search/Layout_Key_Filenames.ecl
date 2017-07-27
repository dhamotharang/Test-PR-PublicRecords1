//physical and super key names for each key managed.
//Can be used to provide a list of keys that need to be co-ordinated with Boolean Build
EXPORT Layout_Key_Filenames := RECORD
  STRING physical;
  STRING alias;           // QA
  STRING backup;          // Father
  STRING past_backup;     // Grandfather
  STRING obsolete_backup; // DELETE
  BOOLEAN delete_obsolete;
END;