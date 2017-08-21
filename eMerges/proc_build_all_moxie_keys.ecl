do1 := emerges.MOXIE_EMERGES_HUNTERS_KEYS : success(output('EMERGES HUNTERS MOXIE KEYBUILD FINISHED SUCCESSFULLY'));
do2 := emerges.MOXIE_EMERGES_CCW_KEYS : success(output('EMERGES CCW MOXIE KEYBUILD FINISHED SUCCESSFULLY'));



export proc_build_all_moxie_keys := sequential(do1,do2);