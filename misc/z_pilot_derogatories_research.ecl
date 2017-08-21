import faa, sexoffender,doxie_files;

pdd := misc._pilot_derogatories_dedup;
output(pdd(unique_id in['2438572','4773744','2383576','2747841']));

crims:= pull(doxie_files.key_offenders(data_type='1'));
sors := pull(sexoffender.Key_SexOffender_Payload);

output(crims(sdid in [001103611075,000265074778,001281125771,001367662571]));
output(sors( did in  [001103611075,000265074778,001281125771,001367662571]));

