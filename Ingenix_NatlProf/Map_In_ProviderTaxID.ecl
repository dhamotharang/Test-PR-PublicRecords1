export Map_In_ProviderTaxID (string filedate) := function;


Layout_in_ProviderAddressTaxID.raw_srctype t_DProviderTaxID(Ingenix_NatlProf.File_in_ProviderAddressTaxID.DentalProf l) := transform
self.FILETYP := 'DDS';
self.ProcessDate := filedate;
self.TaxIDCompanyCount := l.CompanyCount;
self.TaxIDTierTypeID := l.TierTypeID;
self := l;
end;

File_Dental_ProviderTaxID := Project(Ingenix_NatlProf.File_in_ProviderAddressTaxID.DentalProf,t_DProviderTaxID(LEFT));


//Physician Profession Provider Pre Process

Layout_in_ProviderAddressTaxID.raw_srctype t_PhyProviderTaxID(Ingenix_NatlProf.File_in_ProviderAddressTaxID.Physician l) := transform
self.FILETYP := 'PHY';
self.ProcessDate := filedate;
self.TaxIDCompanyCount := l.CompanyCount;
self.TaxIDTierTypeID := l.TierTypeID;
self := l;
end;

File_Physician_ProviderTaxID := Project(Ingenix_NatlProf.File_in_ProviderAddressTaxID.Physician,t_PhyProviderTaxID(LEFT));

//Alled Health Profession Provider Pre Process

Layout_in_ProviderAddressTaxID.raw_srctype t_AHProviderTaxID(Ingenix_NatlProf.File_in_ProviderAddressTaxID.Allied_Health l) := transform
self.FILETYP := 'AH';
self.ProcessDate := filedate;
self.TaxIDCompanyCount := l.CompanyCount;
self.TaxIDTierTypeID := l.TierTypeID;
self := l;
end;

File_AH_ProviderTaxID := Project(Ingenix_NatlProf.File_in_ProviderAddressTaxID.Allied_Health,t_AHProviderTaxID(LEFT));


File_All_ProviderTaxID := File_Dental_ProviderTaxID + File_Physician_ProviderTaxID + File_AH_ProviderTaxID;

Out_ProviderTaxID := if ( FileServices.FindSuperFileSubName( '~thor_data400::in::ingenix_natlprof_ProviderTaxID', '~thor_data400::in::ingenix_natlprof_ProviderTaxID_' + filedate) > 0,Output('SanctionedProviders Logical File Already Added'),                          
                  Sequential(
                          output(File_All_ProviderTaxID,,'~thor_data400::in::ingenix_natlprof_ProviderTaxID_' + filedate,CSV(quote(''),separator('|'), maxlength(8192)),overwrite),
						   FileServices.AddSuperFile('~thor_data400::in::ingenix_natlprof_ProviderTaxID', '~thor_data400::in::ingenix_natlprof_ProviderTaxID_' + filedate)
                           ));
return Out_ProviderTaxID;
end;
