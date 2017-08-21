// setUidPatternTag.ecl
//==================================================================================================
// This function sets the userid pattern tag, e.g. lexisnexis.com's userid pattern tag is 'fname_dot_lname'
export string setUidPatternTag( string100 userid, string fname, string lname ) := FUNCTION

string fname1 := StringLib.StringFilter(trim(fname,LEFT,RIGHT), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ.0123456789');
string lname1 := StringLib.StringFilter(trim(lname,LEFT,RIGHT), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ.0123456789');
string uid := trim(userid, LEFT, RIGHT);
string UidPatternTag :=
    IF( regexfind('^[A-Z]'+lname1+'\\d*$',uid), 'finit_lname'
       ,IF( regexfind('^[A-Z][A-Z]'+lname1+'\\d*$',uid), 'finit_minit_lname'
           ,IF( regexfind('^'+lname1+'[A-Z]\\d*$',uid), 'lname_fi'
               ,IF( regexfind('^'+lname1+'[A-Z][A-Z]\\d*$',uid), 'lname_fi_mi'
                   ,IF( regexfind('^'+fname1+'[A-Z]\\d*$',uid), 'fname_linit'
                       ,IF( regexfind('^'+fname1+lname1+'\\d*$',uid), 'fname_lname'
                           ,IF( regexfind('^'+fname1+'\\.'+lname1+'\\d*$',uid), 'fname_dot_lname'
                               ,IF( regexfind('^'+fname1+'.'+lname1+'\\d*$',uid), 'fname_sep_lname'
                                   ,IF( regexfind('^'+fname1+'[^a-zA-Z][A-Z][^a-zA-Z]'+lname1+'\\d*$',uid), 'fname_sep_mi_sep_lname'
                                       ,IF( regexfind('^'+fname1+'\\d*$',uid), 'fname' // Ideally, nicknames should be included in this.
                                           ,IF( regexfind('^'+lname1+'\\d*$',uid), 'lname'
                                               ,IF( regexfind('^'+fname1+'.+$',uid), 'fname_plus'
                                                   ,IF( regexfind('^'+lname1+'.+$',uid), 'lname_plus','')
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    );
return UidPatternTag;
END;
