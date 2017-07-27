VehLic_VISF.Layout_In_orig tnew(VehLic_VISF.File_In_orig l) := Transform
self.LH_MAIL_ADDRESS := '';
self.ADDL_LH_MAIL_ADD := '';
self := l;
end;

export Transform_orig := Project(VehLic_VISF.File_In_orig,tnew(left));