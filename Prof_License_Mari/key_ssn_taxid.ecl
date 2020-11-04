import doxie, Data_Services, Prof_License_Mari;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_search_delta_rid
// ---------------------------------------------------------------

df := Prof_License_Mari.file_mari_search(ssn_taxid_1 != '' or ssn_taxid_2 != '');

slim_ssn := record
  unsigned6 mari_rid;
  string2 tax_type;
  string9 ssn_taxid;
  unsigned8 MLTRECKEY;
  unsigned8 CMC_SLPK;
  unsigned8 PCMC_SLPK;
end;
        
slim_ssn  xformTIN(Prof_License_Mari.layouts.final L, integer cnt) := transform
  self.tax_type		:= 	choose(cnt,L.tax_type_1,L.tax_type_2);
  self.ssn_taxid	:= 	choose(cnt,L.ssn_taxid_1,L.ssn_taxid_2);
  self.mari_rid		:= L.mari_rid;
  self.mltreckey	:= L.mltreckey;
  self.cmc_slpk		:= L.cmc_slpk;		
  self.pcmc_slpk	:= L.pcmc_slpk;
  self := L;
end;
NormTIN_SSN := normalize(df,2,xformTIN(LEFT,COUNTER));

isSSN := NormTIN_SSN(tax_type = 'S');

slim_ssn	xformSSN4(isSSN L) := transform
  self.tax_type  := 'S4';
  self.ssn_taxid := if(L.ssn_taxid != '' and L.ssn_taxid[6..9] != '0000', L.ssn_taxid[6..9],'');
  self := L;
end;

dsSSN4	:=	project(isSSN,xformSSN4(left));

dsTIN_SSN := NormTIN_SSN + dsSSN4;

dsTaxidSsn_dedup := dsTIN_SSN(tax_type != '' and ssn_taxid != '');

KeyName := 'thor_data400::key::proflic_mari::';

export key_ssn_taxid := index(dsTaxidSsn_dedup
                          ,{ssn_taxid, tax_type}
                          ,{dsTaxidSsn_dedup}
                          ,Data_Services.Data_location.Prefix('mari')+ KeyName +doxie.Version_SuperKey+'::ssn_taxid');
