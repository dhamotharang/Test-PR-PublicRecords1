o1:=output(choosen(misc._hps_201002_phase3_report((has_doc<>'' or has_court<>'' or has_sor<>'') and offenses<>''),5000));
o2:=output(choosen(misc._hps_201002_phase3_report(has_sor='Y' and offenses=''),5000));
o3:=output(choosen(misc._hps_201002_phase3_report(has_doc='Y' and offenses=''),5000));
o4:=output(choosen(misc._hps_201002_phase3_report(has_court='Y' and offenses=''),5000));

export _hps_201002_bwr := sequential(o1,o2,o3,o4);
