Import FBNV2;
EXPORT files := module

//Input Files
EXPORT fbnv2_business_boca        := DATASET(constants.In_fbnv2_Business, Layouts.Business_Base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
EXPORT fbnv2_contact_boca   := DATASET(constants.In_fbnv2_contact, Layouts.Contact_Base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));

EXPORT fbnv2_business_ins        := DATASET(constants.In_fbnv2_Business+ '::ins', Layouts.Business_Base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
EXPORT fbnv2_contact_ins   := DATASET(constants.In_fbnv2_contact + '::ins', Layouts.Contact_Base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));

EXPORT business_combine := fbnv2_business_boca + fbnv2_business_ins;
EXPORT contact_combine	:= fbnv2_contact_boca + fbnv2_contact_ins;

// Business File
EXPORT fbnv2_business_base_ext  := DATASET(constants.Base_fbnv2_Business, Layouts.Combined_Business_Base_ext, FLAT );
EXPORT fbnv2_business_base := project(fbnv2_business_base_ext, Layouts.Combined_Business_Base);

// Contact File
EXPORT fbnv2_contact_base_ext := DATASET(constants.Base_fbnv2_contact, Layouts.Combined_Contact_Base_ext, FLAT );
EXPORT fbnv2_contact_base := project(fbnv2_contact_base_ext, Layouts.Combined_Contact_Base);

	 
Export Business_Base_1 := project(fbnv2_business_base,Layouts.Business_AID);
  
Export Contact_Base_1 := project(fbnv2_contact_base,Layouts.contact_AID);	 

Export Business_Base_2 := project(fbnv2_business_base, 
Transform(Layouts.Business,
self.Zip5 := (string5)Left.Bus_Zip;
self := Left;
self := [];
));
	
Export Contact_Base_2 := project(fbnv2_contact_base, 
Transform(Layouts.Contact,
self.Zip5 := (string5)Left.Contact_Zip;
self := Left;
self := [];
));

BdidSlim		    := TABLE(Business_Base_2(Bdid>0), {Bdid,tmsid,rmsid})+Table(Contact_Base_2(Bdid>0),{Bdid,tmsid,rmsid});
BdidSort        := sort(BdidSlim, Bdid,tmsid,rmsid);
Export DS_Bdid  := dedup(BdidSort ,Bdid,tmsid,rmsid);

DidSlim		      := TABLE(Contact_Base_2(did>0), {did,tmsid,rmsid});
DidSort         := sort(DidSlim, did,tmsid,rmsid);
Export DS_Did   := dedup(DidSort ,did,tmsid,rmsid);

Export dfilingnum		    := TABLE(Business_Base_2(filing_number>''), {filing_number,tmsid,rmsid});

recordof(dfilingnum)    tranFilingNumber(Business_Base_2 pInput):= TRANSFORM
                        self.filing_number := pInput.orig_filing_number;
                        self:= pInput;
 END;
Export dFiling		      :=dfilingnum + PROJECT(Business_Base_2(orig_filing_number>''), tranFilingNumber(left));

Export DS_Business_File_Num := sort(dedup(dFiling,all),filing_number,tmsid,rmsid);

END;