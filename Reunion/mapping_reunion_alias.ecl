EXPORT mapping_reunion_alias(unsigned1 mode = 1, STRING sVersion = reunion.constants.sVersion) := MODULE

//-----------------------------------------------------------------------------
// Dataset containing any names that exist in the Non-GLB header that are
// different than the name in the main file.
//-----------------------------------------------------------------------------
dMain:=DEDUP(SORT(DISTRIBUTE(reunion.mapping_reunion_main(mode, sVersion).all,HASH(did)),RECORD,LOCAL),LOCAL);
dHeaderNames:=DEDUP(SORT(DISTRIBUTE(PROJECT(reunion.files(mode).infutor_header,TRANSFORM(reunion.layouts.lAlias,SELF.main_adl:=INTFORMAT(LEFT.did,12,1);SELF:=LEFT;)),HASH((UNSIGNED6)main_adl)),RECORD,LOCAL),LOCAL);

dAliases:=JOIN(dMain,dHeaderNames,LEFT.did=(UNSIGNED6)RIGHT.main_adl,TRANSFORM(RECORDOF(dHeaderNames),SELF:=RIGHT;),LOCAL);
dAliasesDeduped:=DEDUP(SORT(DISTRIBUTE(dAliases,HASH(main_adl)),RECORD,LOCAL),LOCAL);
dAliasesOnly:=JOIN(dAliasesDeduped,dMain,LEFT.main_adl=RIGHT.adl AND LEFT.title=RIGHT.best_title AND LEFT.fname=RIGHT.best_fname AND LEFT.mname=RIGHT.best_mname AND LEFT.lname=RIGHT.best_lname AND LEFT.name_suffix=RIGHT.best_name_suffix,TRANSFORM(RECORDOF(dAliasesDeduped),SELF:=LEFT;),LEFT ONLY,LOCAL);

EXPORT all := dAliasesOnly:PERSIST('~thor::persist::mylife::mapping_aliases::' + reunion.Constants.sMode(mode));

END;

