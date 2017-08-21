// File_in := dataset('~thor_data400::in::Ingenix_NatlProf_SanctionedProviders',Ingenix_NatlProf.Layout_in_SanctionProviders.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));
File_in := dataset('~thor_data400::base::ingenix_sanctions_did',ingenix_natlprof.layout_sanctions_DID_RecID,flat);
 
 recordof(File_in) tnme(File_in l) := transform
 self.SANC_LNME := if(regexfind('(^[A-Z]+)',trim(l.SANC_LNME,left,right)) = false and l.SANC_LNME <> '','',l.SANC_LNME);
self.SANC_FNME := if(regexfind('(^[A-Z]+)',trim(l.SANC_FNME,left,right)) = false and l.SANC_FNME <> '' ,'',l.SANC_FNME);
self := l;
end;

export File_in_SanctionedProviders := project(File_in,tnme(LEFT));