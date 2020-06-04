IMPORT _Control, Data_Services;

EXPORT Constants := MODULE

  SHARED Prefix := IF(_Control.ThisEnvironment.Name='Dataland', '~', Data_Services.foreign_prod);
  EXPORT Base_Prefix := '~prte::base::';
  EXPORT key_prefix  := '~prte::key::certegy::';

END;