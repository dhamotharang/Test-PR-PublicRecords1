import official_records,Address;
export Clean_n_valid_name := function
InFile := dataset('~thor_200::in::official_records_party_'+official_records.Version_Development,official_records.Layout_Moxie_Party,thor) ;

export RemFile := InFile(~(regexfind(',',cname1) = true and ~regexfind('&',cname1) = true));
export ToClean := InFile(regexfind(',',cname1) = true and ~regexfind('&',cname1) = true);
export off_rec_clean_layout := record
official_records.Layout_Moxie_Party;
string80 clean_name ;
end;

off_rec_clean_layout cleantrs(ToClean le) := transform

self.clean_name := Address.CleanPersonLFM73(le.entity_nm);
self := le;
end;

Clean_Validate := project(ToClean,cleantrs(LEFT));

off_rec_clean_layout t_clean_persontr(Clean_Validate le) := transform

self.title1				:=	le.clean_name[1..5];
self.fname1				:=	le.clean_name[6..25];
self.mname1				:=	le.clean_name[26..45];
self.lname1				:=	le.clean_name[46..65];
self.suffix1	:=	le.clean_name[66..70];
self.cname1 := '';
self := le;
end;

Namediv := project(Clean_Validate,t_clean_persontr(LEFT));

//output(prj2);

official_records.Layout_Moxie_Party t_clean_final(Namediv le) := transform
self.cname1 := '';
self := le;

end;

Clean_Name_File := project(Namediv,t_clean_final(LEFT));

//clean Rem File
official_records.Layout_Moxie_Party t_clean_Rem(RemFile le) := transform
self.fname1 := if(le.entity_nm = 'BROWN ARCH ALEXANDER','ARCH',le.fname1);
self.mname1 := if(le.entity_nm = 'BROWN ARCH ALEXANDER','ALEXANDER',le.mname1);
self.lname1 := if(le.entity_nm = 'BROWN ARCH ALEXANDER','BROWN',le.lname1);
self.cname1 := if(le.entity_nm = 'BROWN ARCH ALEXANDER','',le.cname1);
self := le;
end;

Clean_Rem_File := project(RemFile,t_clean_Rem(LEFT));

concat_clean  := Clean_Rem_File + Clean_Name_File;


Out_Clean := output(concat_clean,,'~thor_200::in::official_records_party_tmp'+official_records.Version_Development,overwrite);

return Out_Clean;
end;



