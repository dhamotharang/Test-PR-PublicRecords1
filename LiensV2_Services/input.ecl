IMPORT autokeyi, autoheaderi, autostandardi;
EXPORT input := MODULE

  EXPORT params := INTERFACE(
    AutoKeyI.AutoKeyStandardFetchBaseInterface,
    AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
    AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
  END;
  
  EXPORT it := AutoStandardI.InterfaceTranslator;

END;
