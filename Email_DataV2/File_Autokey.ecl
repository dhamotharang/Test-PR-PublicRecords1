//doing this just to add zero and blanks to the standardization dataset in order to pass it through the autokey mac.
IMPORT mdr;

email_prep := Email_dataV2.Files.Email_Base;

//email_ds := email_data.Prep_Build.Email_NonFCRA(email_prep); //Awaiting on ECL group to see how this is applied to this new set

autokey_file := PROJECT(email_prep,Layouts.Autokey_layout);
EXPORT File_AutoKey := autokey_file;