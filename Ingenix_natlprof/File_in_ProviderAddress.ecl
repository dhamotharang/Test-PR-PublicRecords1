  export File_in_ProviderAddress := Module
	
 export Allied_Health := dataset('~thor_data400::in::ingenix_natlprof_alliedhealth_provideraddress',Ingenix_NatlProf.Layout_in_ProviderAddress.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export DentalProf :=  dataset('~thor_data400::in::ingenix_natlprof_dentists_provideraddress',Ingenix_NatlProf.Layout_in_ProviderAddress.raw,CSV(quote(''),separator('|'), maxlength(8192)));
  export Physician :=  dataset('~thor_data400::in::ingenix_natlprof_physicians_provideraddress',Ingenix_NatlProf.Layout_in_ProviderAddress.raw,CSV(quote(''),separator('|'), maxlength(8192)));
 
 File_in_PAddress := dataset('~thor_data400::in::Ingenix_NatlProf_ProviderAddress',Ingenix_NatlProf.Layout_in_ProviderAddress.raw_srctype,CSV(quote(''),separator('|'), maxlength(8192)));
 
 File_in_PBadAddress := File_in_PAddress(trim(GeoReturn) = 'X' );
 File_in_PValidAddress := File_in_PAddress(trim(GeoReturn) <> 'X');

 
 
 File_Sort_PBadAddress := dedup(sort(File_in_PBadAddress,ProviderID,AddressID),ProviderID,AddressID);
 
 
 Ingenix_NatlProf.Layout_in_ProviderAddress.raw_srctype tPAddress(File_in_PValidAddress l,File_Sort_PBadAddress r) := transform

   self.Address            := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,'',l.Address);
   self.Address2           := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.Address2,l.Address2);
   self.City               := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.City,l.City);
   self.State              := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.State,l.State);
   self.County             := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.County,l.County);
   self.ZIP                := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.ZIP,l.ZIP);
   self.ExtZip             := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.ExtZip,l.ExtZip);
	 self.Latitude           := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.Latitude,l.Latitude);
   self.Longitute          := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.Longitute,l.Longitute);
   self.GeoReturn          := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.GeoReturn,l.GeoReturn);
   self.HighRisk           := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.HighRisk,l.HighRisk);
   self.ProviderAddressCompanyCount := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.ProviderAddressCompanyCount,l.ProviderAddressCompanyCount);
   self.ProviderAddressTierTypeID := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.ProviderAddressTierTypeID,l.ProviderAddressTierTypeID);
   self.ProviderAddressVerificationStatusCode := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.ProviderAddressVerificationStatusCode,l.ProviderAddressVerificationStatusCode);
   self.ProviderAddressVerificationDate := if(l.ProviderID = r.ProviderID and l.AddressID = r.AddressID and r.processdate > l.processdate,r.ProviderAddressVerificationDate,l.ProviderAddressVerificationDate);
   self := l; 
end;

 Allsrc_preclean := Join(File_in_PValidAddress,File_Sort_PBadAddress,LEFT.ProviderID = RIGHT.ProviderID and LEFT.AddressID = RIGHT.AddressID,tPAddress(LEFT,RIGHT),left outer,lookup);

 // Clean the garbage "ascii box" out of the address and 4-digit part of the zipcode 
 Ingenix_NatlProf.Layout_in_ProviderAddress.raw_srctype xfm_addr2(Ingenix_NatlProf.Layout_in_ProviderAddress.raw_srctype L) := TRANSFORM 
   SELF.address2 := REGEXREPLACE('[\\x00]', TRIM(L.address2), '');
   SELF.ExtZip := REGEXREPLACE('[\\x00]', TRIM(L.ExtZip), '');
   SELF := L;
 END;
 
 export Allsrc := PROJECT(Allsrc_preclean, xfm_addr2(LEFT));
 
 end;