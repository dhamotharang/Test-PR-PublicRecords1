// Count SIC codes
bhs := Business_Header.BH_BDID_SIC;

count(dedup(bhs, bdid, sic_code, all));
count(dedup(bhs, bdid, all));

// Count Duns Numbers
bh := Business_Header.File_Business_Header;

bh_dnb := bh(source='D');

count(bh_dnb(vendor_id[1] <> 'D'));
count(bh_dnb(vendor_id[1] = 'D'));
count(dedup(bh_dnb(vendor_id[1] <> 'D'), bdid, all));
count(dedup(bh_dnb(vendor_id[1] = 'D'), bdid, all));

// Count NAICS
layout_bdid_naics := record
unsigned6 bdid;
string6 naics;
end;

busreg_naics := project(BusReg.File_BusReg_Company((integer)naics <> 0),
                        transform(layout_bdid_naics, self := left));
				    
yp_naics := project(YellowPages.Files.Base.QA(source='Y', (integer)naics_code <> 0),
                    transform(layout_bdid_naics, self.naics := left.naics_code, self := left));
				
naics_combined := busreg_naics + yp_naics;

count(dedup(naics_combined, bdid, naics, all));
count(dedup(naics_combined, bdid, all));

// Total fein
count(dedup(bh(fein <> 0), bdid, fein, all));
count(dedup(bh(fein <> 0), bdid, all));


