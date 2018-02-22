IMPORT iesp;
EXPORT GetSearchFiles(DATASET(iesp.share.t_StringArrayItem) watchlists_original)  := FUNCTION

  DBNames_rec := ofac_xg5.Constants.DBNames_rec;

  fileList := 
              if('ADFA' in SET(watchlists_original, value),  dataset([ {'AUSTRALIA DEPT OF FOREIGN AFFAIRS AND TRADE.BDF'}], DBNames_rec) ) +
              if( 'BES' in SET(watchlists_original, value),  dataset([ {'BANK OF ENGLAND CONSOLIDATED LIST.BDF'}, {'HM TREASURY SANCTIONS.CDF'}], DBNames_rec) )  +
              if( 'CFTC' in SET(watchlists_original, value),  dataset([ {'COMMODITY FUTURES TRADING COMMISSION SANCTIONS.BDF'}], DBNames_rec) ) +
              if( 'DTC' in SET(watchlists_original, value),  dataset([ {'DTC DEBARRED PARTIES.BDF'}], DBNames_rec) ) +
              if( 'BIS' in SET(watchlists_original, value),  dataset([ {'BUREAU OF INDUSTRY AND SECURITY.BDF'}], DBNames_rec) )  +
              if( 'EUDT' in SET(watchlists_original, value),  dataset([ {'EU CONSOLIDATED LIST.BDF'}], DBNames_rec) ) +
              if( 'FATF' in SET(watchlists_original, value),  dataset([ {'FATF DEFICIENT JURISDICTIONS - COUNTRIES.CDF'}, {'FATF FINANCIAL ACTION TASK FORCE.CDF'}], DBNames_rec))  +
              if( 'FBI' in SET(watchlists_original, value),  dataset([ {'FBI TOP TEN MOST WANTED.BDF'}], DBNames_rec) )  +  
              if( 'FBIH' in SET(watchlists_original, value), dataset([ { 'FBI HIJACK SUSPECTS.BDF'}], DBNames_rec) ) +
              if( 'FBIS' in SET(watchlists_original, value),  dataset([ { 'FBI SEEKING INFORMATION.BDF'}], DBNames_rec) ) +
              if( 'FBIT' in SET(watchlists_original, value),  dataset([ {'FBI MOST WANTED TERRORISTS.BDF'}], DBNames_rec))  +
              if( 'FBIW' in SET(watchlists_original, value),  dataset([ {'FBI MOST WANTED.BDF'}], DBNames_rec)) +
              if( 'FAR' in SET(watchlists_original, value),  dataset([ {'FOREIGN AGENTS REGISTRATIONS.BDF'}], DBNames_rec))  + 
              if( 'HKMA' in SET(watchlists_original, value), dataset([{'HONG KONG MONETARY AUTHORITY.BDF'}], DBNames_rec)) +
              if( 'MASI' in SET(watchlists_original, value),  dataset([{'MONETARY AUTHORITY OF SINGAPORE.BDF'}], DBNames_rec)) + 
              if( 'OFFC' in SET(watchlists_original, value),  dataset([{'OFFSHORE FINANCIAL CENTERS.CDF'}], DBNames_rec)) + 
              if( 'OSFI' in SET(watchlists_original, value),  dataset([{'OSFI CONSOLIDATED LIST.BDF'}, {'OSFI COUNTRY.CDF'}], DBNames_rec)) + 
              if( 'OCC' in SET(watchlists_original, value),  dataset([{'UNAUTHORIZED BANKS.BDF'}], DBNames_rec)) + 
              if( 'PMLC' in SET(watchlists_original, value),  dataset([{'PRIMARY MONEY LAUNDERING CONCERN.BDF'}], DBNames_rec) ) + 
              if( 'PMLJ' in SET(watchlists_original, value),  dataset([{'PRIMARY MONEY LAUNDERING CONCERN - JURISDICTIONS.CDF'}], DBNames_rec)) +  
              if( 'SDT' in SET(watchlists_original, value),  dataset([{'OFAC SDN.BDF'},{'TERRORIST EXCLUSION LIST.BDF'}], DBNames_rec)) + 
              if('WBIF' in SET(watchlists_original, value), dataset([{'WORLD BANK INELIGIBLE FIRMS.BDF'}], DBNames_rec)) +
              if('UNNT' in SET(watchlists_original, value), dataset([{'UN CONSOLIDATED LIST.BDF'}], DBNames_rec)) +
              if('PEP' in SET(watchlists_original, value), dataset([{'CHIEFS OF STATE AND FOREIGN CABINET MEMBERS.BDF'}], DBNames_rec)) +
              if('OFAC' in SET(watchlists_original, value), OFAC_XG5.Constants.WCOFACNames);

  finalList := 
    MAP(
      'ALL'   IN SET(watchlists_original, value) =>	OFAC_XG5.Constants.WCOAddtnlFiles_ALL, 
      'ALLV4' IN SET(watchlists_original, value) =>	OFAC_XG5.Constants.WCOAddtnlFiles_ALLV4, 
      fileList
    );

  RETURN finalList;

END;