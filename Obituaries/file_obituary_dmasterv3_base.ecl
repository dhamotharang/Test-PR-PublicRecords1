Import Obituaries, header;
EXPORT file_obituary_dmasterv3_base := dataset('~thor_data400::base::did_death_masterv3_obituary',header.Layout_Did_Death_MasterV3,flat);

/*Previous file nameing comvention. Changed to be more generic as ObituaryData source is included in feed. - SL 4/4/2014 */
//EXPORT file_obituary_dmasterv3_base :=	dataset('~thor_data400::base::did_death_masterv3_tributes',header.Layout_Did_Death_MasterV3,flat);