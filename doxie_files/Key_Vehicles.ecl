import doxie_build, doxie, ut;

ds_preprocessed := doxie_build.Vehlic_Decoded;

export Key_Vehicles := INDEX(ds_preprocessed, {sseq_no := seq_no}, {ds_preprocessed},
  '~thor_data400::key::'+doxie_build.buildstate+'vehiclefull_'+doxie.Version_SuperKey);
