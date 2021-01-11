import doxie,Data_Services;

// Autokey build process adds some fields, this record definition takes care of that.

rec := RECORD
  unsigned6 fakeid;
  OSHAIR.layout_autokeys;
  unsigned1 zero;
  string1 blank;
  unsigned6 fdid;
END;

d := dataset([],rec);


EXPORT Key_OSHAIR_autokey_payload := INDEX({rec.fakeid},rec,Data_Services.Data_location.Prefix()+'thor_data400::key::oshair::' + doxie.Version_SuperKey + '::autokey::payload');
