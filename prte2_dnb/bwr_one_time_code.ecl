//This file was generated as a starting point only.  
//You must check and customize this process BEFORE running it.


EXPORT BWR_ONE_TIME_CODE := MODULE

EXPORT DO := FUNCTION

FileServices.CreateSuperFile ('~prte::key::dnb::autokey::qa::addressb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::qa::citystnameb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::qa::nameb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::qa::namewords2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::qa::payload');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::qa::phoneb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::qa::stnameb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::qa::zipb2');
FileServices.CreateSuperFile ('~prte::key::dnb::qa::bdid');
FileServices.CreateSuperFile ('~prte::key::dnb::qa::dunsnum');
FileServices.CreateSuperFile ('~prte::key::dnb::qa::linkids');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::father::addressb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::father::citystnameb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::father::nameb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::father::namewords2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::father::payload');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::father::phoneb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::father::stnameb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::father::zipb2');
FileServices.CreateSuperFile ('~prte::key::dnb::father::bdid');
FileServices.CreateSuperFile ('~prte::key::dnb::father::dunsnum');
FileServices.CreateSuperFile ('~prte::key::dnb::father::linkids');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::grandfather::addressb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::grandfather::citystnameb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::grandfather::nameb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::grandfather::namewords2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::grandfather::payload');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::grandfather::phoneb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::grandfather::stnameb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::grandfather::zipb2');
FileServices.CreateSuperFile ('~prte::key::dnb::grandfather::bdid');
FileServices.CreateSuperFile ('~prte::key::dnb::grandfather::dunsnum');
FileServices.CreateSuperFile ('~prte::key::dnb::grandfather::linkids');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::delete::addressb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::delete::citystnameb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::delete::nameb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::delete::namewords2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::delete::payload');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::delete::phoneb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::delete::stnameb2');
FileServices.CreateSuperFile ('~prte::key::dnb::autokey::delete::zipb2');
FileServices.CreateSuperFile ('~prte::key::dnb::delete::bdid');
FileServices.CreateSuperFile ('~prte::key::dnb::delete::dunsnum');
FileServices.CreateSuperFile ('~prte::key::dnb::delete::linkids');



FileServices.CreateSuperFile ('~PRTE::IN::dnb::Companies');
FileServices.CreateSuperFile ('~PRTE::BASE::dnb_built');
FileServices.CreateSuperFile ('~PRTE::BASE::dnb_father');
FileServices.CreateSuperFile ('~PRTE::BASE::dnb_grandfather');
FileServices.CreateSuperFile ('~PRTE::BASE::dnb_delete');
FileServices.CreateSuperFile ('~PRTE::BASE::dnb');
RETURN 'SUCCESS';
End;

End;