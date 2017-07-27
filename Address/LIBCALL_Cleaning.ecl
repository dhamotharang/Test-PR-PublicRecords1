import _Control;

export LIBCALL_Cleaning := MODULE;

#if (not _Control.LibraryUse.ForceOff_Address__LIB_Cleaning)
shared templib (ILIB.ICleaningInput args) := library ('Address.LIB_Cleaning', ILIB.ICleaningResults (args));
#else
shared templib (ILIB.ICleaningInput args) := LIB_Cleaning (args);
#end

  EXPORT string182 cleaned_address_182     (ILIB.ICleaningInput args) := templib (args).cleaned_address_182;
  EXPORT string183 cleaned_address_183     (ILIB.ICleaningInput args) := templib (args).cleaned_address_183;
  EXPORT string73 cleaned_person_73        (ILIB.ICleaningInput args) := templib (args).cleaned_person_73;
  EXPORT string73 cleaned_person_FML73     (ILIB.ICleaningInput args) := templib (args).cleaned_person_FML73;
  EXPORT string73 cleaned_person_LFM73     (ILIB.ICleaningInput args) := templib (args).cleaned_person_LFM73;
	EXPORT string140 cleaned_dualname_140    (ILIB.ICleaningInput args) := templib (args).cleaned_dualname_140; 
  EXPORT string140 cleaned_dualname_LFM140 (ILIB.ICleaningInput args) := templib (args).cleaned_dualname_LFM140;
  EXPORT string34 geo_34                   (ILIB.ICleaningInput args) := templib (args).geo_34;
  EXPORT string109 cleaned_address_canada  (ILIB.ICleaningInput args) := templib (args).cleaned_address_canada;

end;
