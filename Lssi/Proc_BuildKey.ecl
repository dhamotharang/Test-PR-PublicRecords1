import doxie,ut,RoxieKeybuild;

export proc_buildkey(string filedate) := function

ut.MAC_SF_BuildProcess(lssi.QuestionFile,'~thor_data400::Base::Questionfile',build_base,2,,pCompress:=true,pVersion:=filedate)

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(lssi.Key_Prep_Determiner,'~thor_data400::key::lssi.determiner','~thor_data400::key::lssi::'+filedate+'::determiner',build_key);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::lssi.determiner','~thor_data400::key::lssi::'+filedate+'::determiner',mv_key);

build_all := sequential(build_base,build_key,mv_key);

return IF(fileservices.getsuperfilesubname('~thor_data400::base::header',1)=fileservices.getsuperfilesubname('~thor_data400::base::headerkey_built',1), 
		output('Question file was not built'),build_all);
end;