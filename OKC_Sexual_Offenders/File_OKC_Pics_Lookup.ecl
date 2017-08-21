 ds := dataset('~thor_200::in::OKC_Sex_Off::Lookup::Superfile',OKC_Sexual_Offenders.Layout_OKC_Pics_Lookup,csv(separator('/'),terminator(['\r\n','\r','\n']),quote('"')));
 
 OKC_Sexual_Offenders.Layout_OKC_Pics_Lookup fixState(ds l):= transform
 self.state_of_origin := regexreplace('SOR',StringLib.StringToUpperCase(l.state_of_origin),'');
 self := l;
 end;
 
 ds_project := project(ds,fixState(left));
 
 export File_OKC_Pics_Lookup := ds_project;