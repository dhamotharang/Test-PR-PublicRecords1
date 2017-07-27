import LN_PropertyV2;

persistname := '~thor_data400::persist::deeds_source_dids';

dSourceFares := distribute(pull(LN_PropertyV2.file_search_building((did != 0 or bdid != 0) and ln_fares_id[2] = 'D' and (source_code ='OP' or source_code = 'SP'))), hash(ln_fares_id)) : persist(persistname);
// dSourceFares := dataset(persistname, recordof(LN_PropertyV2.file_search_building), thor);

/*
Need Land Use, pull from ADVO but it doesn't go back in time :( 
Address_Attributes.functions.getSFD( pass land use )
Address_Attributes.functions.getDwelling_Type( pass land use );
*/

export prop_transaction_base := dSourceFares;