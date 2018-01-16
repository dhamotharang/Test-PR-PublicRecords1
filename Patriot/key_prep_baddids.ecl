import Data_Services;
export key_prep_baddids :=index(baddies,{did,other_count,first_seen,rel_count,dummy},Data_Services.Data_location.Prefix()+'thor_data400::key::Baddids_' + thorlib.wuid());