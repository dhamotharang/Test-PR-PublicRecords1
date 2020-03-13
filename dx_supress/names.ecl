import Data_Services, doxie;
export names(boolean isfcra) := module
    KeyName         := 'thor_data400::key::new_suppression::';
    KeyName_fcra    := 'thor_data400::key::new_suppression::fcra::';
    export key := Data_Services.Data_location.Prefix('NONAMEGIVEN')+ if(isFCRA,KeyName_fcra,KeyName) +	doxie.Version_SuperKey+'::link_type_link_id';
end;