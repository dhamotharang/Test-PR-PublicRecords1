IMPORT AutokeyB2_Batch, Autokey_batch, BatchServices;

Autokey_batch.Layouts.rec_inBatchMaster xfm_capitalize(Autokey_batch.Layouts.rec_inBatchMaster l) :=
TRANSFORM
    SELF.name_first  := StringLib.StringToUpperCase(l.name_first);
    SELF.name_middle := StringLib.StringToUpperCase(l.name_middle);
    SELF.name_last   := StringLib.StringToUpperCase(l.name_last);
    SELF.name_suffix := StringLib.StringToUpperCase(l.name_suffix);	
    
    SELF.comp_name   := StringLib.StringToUpperCase(l.comp_name);

    SELF.prim_range  := StringLib.StringToUpperCase(l.prim_range);	
    SELF.predir      := StringLib.StringToUpperCase(l.predir);	
    SELF.prim_name   := StringLib.StringToUpperCase(l.prim_name);	
    SELF.addr_suffix := StringLib.StringToUpperCase(l.addr_suffix);	
    SELF.postdir     := StringLib.StringToUpperCase(l.postdir);	
    SELF.unit_desig  := StringLib.StringToUpperCase(l.unit_desig);	
    SELF.sec_range   := StringLib.StringToUpperCase(l.sec_range);	

    SELF.p_city_name := StringLib.StringToUpperCase(l.p_city_name);	
    SELF.st          := StringLib.StringToUpperCase(l.st);	
    
    SELF             := l;
END;

EXPORT get_fids(DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in = DATASET([],Autokey_batch.Layouts.rec_inBatchMaster),
                STRING autokey_file,
								BatchServices.Interfaces.i_AK_Config config
                ) := FUNCTION

	ds_input_capitalized := PROJECT(ds_batch_in, xfm_capitalize(LEFT));
	

	
  ak_out := AutokeyB2_batch.Get_IDs_Batch(ds_input_capitalized, autokey_file, config.skip_set, config.isBareAddr, 
	                                        config.workHard, config.nofail, config.useAllLookups, 
																					config.isTestHarness);				
   // output(ds_input_capitalized, named('ds_input_capitalized'));																					
   // output(ds_in, named('ds_in'));
	
	RETURN ak_out;
	
END;

