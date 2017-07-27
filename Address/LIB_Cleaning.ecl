/*2012-04-06T17:41:33Z (Krishna Turlapathi_prod)

*/
/*--LIBRARY--*/

// This library performs common cleaning / parsing.

import _Control, BO_Address;

#if (not _Control.LibraryUse.ForceOff_Address__LIB_Cleaning)
export LIB_Cleaning (ILIB.ICleaningInput args) := MODULE, LIBRARY (ILIB.ICleaningResults)
#else
export LIB_Cleaning (ILIB.ICleaningInput args) := MODULE (ILIB.ICleaningResults (args))
#end

  // There are two sets of address/name cleaners avaialble; conditional choosing them doesn't work
  // due to some platform features. This library should be deployed with one set of functions commented out.
  // Queries will not have to be recompiled: library interface stays the same no matter 
  // if it points to new or old cleaners.

  // --------- old name and address cleaner ---------

  shared CorrectServer_old := Address.Constants.oldserver;
  shared CorrectPort_old   := Address.Constants.oldport;
  shared CorrectCAServer_old := Address.Constants.oldcserver;
  shared CorrectCAPort_old := Address.Constants.oldcport;
/*
  shared caddr_182 := AddrCleanLib.CleanAddress182 (args.address_line_1, args.address_line_2, CorrectServer_old, CorrectPort_old);  
  shared caddr_183 := AddrCleanLib.CleanAddress183 (args.address_line_1, args.address_line_2, CorrectServer_old, CorrectPort_old);  
  shared cperson_73 := AddrCleanLib.CleanPerson73 (args.name, CorrectServer_old, CorrectPort_old);  
  shared cperson_FML73 := AddrCleanLib.CleanPersonFML73 (args.name, CorrectServer_old, CorrectPort_old);  
  shared cperson_LFM73 := AddrCleanLib.CleanPersonLFM73 (args.name, CorrectServer_old, CorrectPort_old);  
  shared cdualname_140 := AddrCleanLib.CleanDualName140 (args.dualname, CorrectServer_old, CorrectPort_old); 
  shared cdualname_LFM140 := AddrCleanLib.CleanDualNameLFM140 (args.dualname, CorrectServer_old, CorrectPort_old);
  shared zip9_geo34 := AddrCleanLib.Zip9ToGeo34 (args.zip9, CorrectServer_old, CorrectPort_old);
*/
  // Canadian address:
  shared caddr_ca109 := CanadaCleanLib.CanadaAddress109 (args.address_line_1, args.address_line_2,
                                                         args.lang, CorrectCAServer_old, CorrectCAPort_old); 


  // --------- new name and address cleaner ---------
  shared CorrectServer := Address.Constants.newserver;
  shared CorrectPort   := Address.Constants.newport;
  shared CorrectCAServer := Address.Constants.newcserver;
  shared CorrectCAPort   := Address.Constants.newcport;

  shared caddr_182 := BO_Address.CleanAddress182 (args.address_line_1, args.address_line_2, CorrectServer, CorrectPort);
  shared caddr_183 := BO_Address.CleanAddress183 (args.address_line_1, args.address_line_2, CorrectServer, CorrectPort);
  shared cperson_73 := BO_Address.CleanPerson73 (args.name, CorrectServer, CorrectPort);
	shared cperson_FML73 := BO_Address.CleanPersonFML73 (args.name, CorrectServer, CorrectPort);  
	shared cperson_LFM73 := BO_Address.CleanPersonLFM73 (args.name, CorrectServer, CorrectPort);  
  shared cdualname_140 := BO_Address.CleanDualName140 (args.dualname, CorrectServer, CorrectPort); 
  shared cdualname_LFM140 := BO_Address.CleanDualNameLFM140 (args.dualname, CorrectServer, CorrectPort);
  shared zip9_geo34 := BO_Address.Zip9ToGeo34 (args.zip9, CorrectServer, CorrectPort);
  // Canadian address:
  // shared caddr_ca109 := BO_Address.CleanCanadaAddress109 (args.address_line_1, args.address_line_2, 
                                                          // CorrectCAServer, CorrectCAPort, args.lang); 

  EXPORT string182 cleaned_address_182 := caddr_182;
  EXPORT string183 cleaned_address_183 := caddr_183;
  EXPORT string73 cleaned_person_73 := cperson_73;
  EXPORT string73 cleaned_person_FML73 := cperson_FML73;
  EXPORT string73 cleaned_person_LFM73 := cperson_LFM73;
	EXPORT string140 cleaned_dualname_140 := cdualname_140; 
  EXPORT string140 cleaned_dualname_LFM140 := cdualname_LFM140;
  EXPORT string34 geo_34 := zip9_geo34;
  EXPORT string109 cleaned_address_canada := caddr_ca109;

END;