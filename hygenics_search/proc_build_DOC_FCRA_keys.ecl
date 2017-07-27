import doxie_files,doxie,roxiekeybuild,ut;
export proc_build_DOC_FCRA_keys(string filedate) := function

//RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie_files.Key_BocaShell_Crim ,'~thor_data400::key::corrections_offenders::bocashell_did','~thor_data400::key::corrections_offenders::'+filedate+'::bocashell_did', a);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_search.Key_BocaShell_Crim_FCRA,'~thor_data400::key::corrections_offenders::fcra::bocashell_did','~thor_data400::key::corrections_offenders::fcra::'+filedate+'::bocashell_did', b);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_search.Key_Offenders_FCRA,'~thor_200::key::criminal_offenders::fcra::' + doxie.Version_SuperKey + '::did','~thor_200::key::criminal_offenders::fcra::'+filedate+'::did',c);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_search.Key_Offenses_FCRA,'~thor_200::key::criminal_offenses::fcra::' + doxie.Version_SuperKey + '::offender_key','~thor_200::key::criminal_offenses::fcra::'+filedate+'::offender_key',d);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_search.Key_Punishment_FCRA,'~thor_200::key::criminal_punishment::fcra::'+ doxie.Version_SuperKey + '::offender_key.punishment_type','~thor_200::key::criminal_punishment::fcra::'+filedate+'::offender_key.punishment_type',e);


//RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::corrections_offenders::bocashell_did','~thor_data400::key::corrections_offenders::'+filedate+'::bocashell_did', f);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::corrections_offenders::fcra::bocashell_did','~thor_data400::key::corrections_offenders::fcra::'+filedate+'::bocashell_did', g);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::criminal_offenders::fcra::@version@::did','~thor_200::key::criminal_offenders::fcra::'+filedate+'::did',h);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::criminal_offenses::fcra::@version@::offender_key','~thor_200::key::criminal_offenses::fcra::'+filedate+'::offender_key',i);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_200::key::criminal_punishment::fcra::@version@::offender_key.punishment_type','~thor_200::key::criminal_punishment::fcra::'+filedate+'::offender_key.punishment_type',j);

RoxieKeyBuild.Mac_SK_Move('~thor_data400::key::corrections_offenders::fcra::bocashell_did','Q', do10);
RoxieKeyBuild.Mac_SK_Move('~thor_200::key::criminal_offenders::fcra::@version@::did','Q',do11);
RoxieKeyBuild.Mac_SK_Move('~thor_200::key::criminal_offenses::fcra::@version@::offender_key','Q',do12);
RoxieKeyBuild.Mac_SK_Move('~thor_200::key::criminal_punishment::fcra::@version@::offender_key.punishment_type','Q',do13);
return sequential(
       parallel(/*a,*/b,c,d,e),/*f,*/g,h,i,j,do10,do11,do12,do13);

end;