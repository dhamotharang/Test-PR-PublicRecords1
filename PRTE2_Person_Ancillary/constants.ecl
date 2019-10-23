EXPORT Constants := module

Export Test_Cases:= '~prte::in::ancillary::ancillary';

Export SuperName1:='~prte::base::insuranceheader::allpossiblessns';

Export Base_Name_Part_1  :='~prte::base::insuranceheader::';
Export Base_Name_Part_2  :='::allpossiblessns::';

EXPORT key_Name          := '~prte::key::insuranceheader::allpossiblessns::'; 
EXPORT key_Name_Part_1   := '~prte::key::insuranceheader::';
EXPORT key_Name_Part_2   := '::allpossiblessns';
//EXPORT key_super_Name    := '~prte::key::insuranceheader::allpossiblessns::qa';

EXPORT key_Name_did          := '~prte::key::insuranceheader::did::'; 
EXPORT key_Name_Part_1_did   := '~prte::key::insuranceheader::';
EXPORT key_Name_Part_2_did   := '::did';
//EXPORT key_super_Name_did    := '~prte::key::insuranceheader::did::qa';

EXPORT key_Name_dln         := '~prte::key::insuranceheader::dln::'; 
EXPORT key_Name_Part_1_dln   := '~prte::key::insuranceheader::';
EXPORT key_Name_Part_2_dln   := '::dln';
//EXPORT key_super_Name_dln    := '~prte::key::insuranceheader::dln::qa';

Export AncillaryTemp:='~PRTE::Ancillary::AncillaryTemp';
Export AncillaryTempB:='~PRTE::Ancillary::AncillaryTempB';

Export TU_sources := ['TU','TS','LT','TN']; 

END;