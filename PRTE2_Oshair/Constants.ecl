EXPORT Constants := module

Export dops_name := 'OshairKeys';

Export In_Accident := '~PRTE::IN::oshair::accident';
Export In_Inspection := '~PRTE::IN::oshair::inspection';
Export In_Violations := '~PRTE::IN::oshair::violations';
Export In_Substance := '~PRTE::IN::oshair::substance';
Export In_Program := '~PRTE::IN::oshair::program';

EXPORT Base_Accident := '~PRTE::Base::oshair::accident';
EXPORT Base_Inspection := '~PRTE::Base::oshair::inspection';
EXPORT Base_Violations := '~PRTE::Base::oshair::violations';
EXPORT Base_Substance := '~PRTE::Base::oshair::substance';
EXPORT Base_Program := '~PRTE::Base::oshair::program';

EXPORT KeyName_oshair := 	'~prte::key::oshair::'; 

EXPORT ak_keyname := KeyName_oshair + '@version@::autokey::'; 
 
EXPORT ak_logical(string filedate) := KeyName_oshair + filedate + '::autokey::'; 
EXPORT ak_skipSet:= ['C','Q']; 
EXPORT ak_typestr := 'AK'; 

END;