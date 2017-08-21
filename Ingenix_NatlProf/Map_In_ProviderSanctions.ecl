import ut;
export Map_In_ProviderSanctions(string filedate) := function

 SanctionedProviderDB := dataset('~thor_data400::in::ingenix_natlprof_sanctions_vwsanctionsdb',Ingenix_NatlProf.Layout_in_SanctionProviders.raw,CSV(quote(''),separator('|'),maxlength(8192)));
Ingenix_NatlProf.Layout_in_SanctionProviders.raw_srctype tSanctionedProviders( SanctionedProviderDB l) := transform
self.filetyp := 'SANCTIONS';
self.processdate := filedate;
self.SANC_LNME := if(regexfind(' *([Aa]-[Zz]+)?$',l.SANC_LNME) = false,'',l.SANC_LNME);
self.SANC_FNME := if(regexfind(' *([Aa]-[Zz]+)?$',l.SANC_FNME) = false,'',l.SANC_FNME);
self := l;
end;

 File_Out_ProviderSanctions := project(SanctionedProviderDB,tSanctionedProviders(LEFT));

Out_ProviderSanctions := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_SanctionedProviders', '~thor_data400::in::ingenix_natlprof_SanctionedProviders_' + filedate) > 0,Output('SanctionedProviders Logical File Already Added'),                          
        sequential(
                 output(File_Out_ProviderSanctions,,'~thor_data400::in::Ingenix_NatlProf_SanctionedProviders_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),

						   FileServices.AddSuperFile('~thor_data400::in::Ingenix_NatlProf_SanctionedProviders', '~thor_data400::in::Ingenix_NatlProf_SanctionedProviders_' + filedate)
                           ));

return Out_ProviderSanctions;
end;