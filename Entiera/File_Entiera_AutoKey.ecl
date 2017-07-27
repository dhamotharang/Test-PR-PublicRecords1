//doing this just to add zero and blanks to the standardization dataset in order to pass it through the autokey mac.
entiera_ds := entiera.File_Entiera_Base;

Entiera.All_Entiera_Layouts.Entiera_Autokey_layout tForAutokeys1(entiera_ds l) := transform
self.orig_login_date	:=	l.ln_login_date;
self:=l;	
end;

entiera_autokey_file := project(entiera_ds,tForAutokeys1(left));


export File_Entiera_AutoKey := entiera_autokey_file;