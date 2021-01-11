IMPORT autokeyi, autoheaderi, autostandardi;
EXPORT input := MODULE

  EXPORT params := INTERFACE(
    AutoKeyI.AutoKeyStandardFetchBaseInterface,
    AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
    AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
    EXPORT BOOLEAN skip_ids_search := FALSE; // controls whether to run autokey AND deep-dive search when fetching IDs
                                             // or use only provided DIDs, BDIDs, etc.
  END;
  
  EXPORT it := AutoStandardI.InterfaceTranslator;
  EXPORT gm := AutoStandardI.GlobalModule();

END;
