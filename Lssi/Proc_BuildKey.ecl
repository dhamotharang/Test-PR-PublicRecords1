import doxie,ut;

ut.MAC_SF_BuildProcess(lssi.QuestionFile,'~thor_data400::Base::Questionfile',build_base,2)
ut.MAC_SK_BuildProcess(lssi.Key_Prep_Determiner,'~thor_data400::key::lssi.determiner','~thor_data400::key::lssi.determiner',build_key,2)

build_all := sequential(build_base,build_key);

export proc_buildkey := IF(fileservices.getsuperfilesubname('~thor_data400::base::header',1)=fileservices.getsuperfilesubname('~thor_data400::base::headerkey_built',1), 
		output('Question file was not built'),build_all);