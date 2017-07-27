//doing this just to populate the orig_login_date with the ln_login_date per Bug# 51741.
entiera_ds := entiera.File_Entiera_Base;

Layouts.Base tFormatLoginDate(entiera_ds l) := transform
self.orig_login_date	:=	l.ln_login_date;
self:=l;	
end;

entiera_basekey_file := project(entiera_ds,tFormatLoginDate(left));


export File_Entiera_Base_for_Keys := entiera_basekey_file;