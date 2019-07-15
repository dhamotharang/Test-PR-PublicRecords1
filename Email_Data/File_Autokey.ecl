//doing this just to add zero and blanks to the standardization dataset in order to pass it through the autokey mac.
import mdr;

email_prep := Email_data.File_Email_Base(append_is_valid_domain_ext and current_rec);

email_ds := email_data.Prep_Build.Email_NonFCRA(email_prep);

autokey_file := project(email_ds,Layout_email.Autokey_layout);
export File_AutoKey := autokey_file;