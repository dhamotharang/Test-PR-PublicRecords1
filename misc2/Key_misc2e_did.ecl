import doxie, email_data, Data_Services;

in_ds := misc2.file_in_misc2e(did >0 and trim(clean_email) <> '');

Email_Data.Layout_Email.base xToEmail(in_ds L) := TRANSFORM
    self := L ;
end ;

out_ds := project (in_ds, xToEmail(left)) ;


export Key_misc2e_did  := index(out_ds,{did},{out_ds}, Data_Services.Data_location.Prefix()+'thor_data400::key::misc2e::did_' + doxie.Version_SuperKey);