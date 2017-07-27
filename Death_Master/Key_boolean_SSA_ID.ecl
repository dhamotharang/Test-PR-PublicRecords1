IMPORT Data_Services, liensv2;

id_rec := RECORD
  UNSIGNED INTEGER2 src;
  UNSIGNED INTEGER6 doc;
  STRING16 state_death_id;
  UNSIGNED INTEGER8 __filepos;
END;

id_table := dataset([],id_rec);

EXPORT Key_Boolean_SSA_ID := INDEX(id_table,{src,doc,state_death_id,__filepos},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::death_master_ssa::qa::docref.state_death_id');



