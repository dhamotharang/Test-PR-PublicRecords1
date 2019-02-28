IMPORT SALT311;
SALT311.MAC_Default_SPC(_Scrubs_VendorSrc_MasterList.in_masterlist, outspc);
output(outspc,all);

SALT311.MAC_Profile(_Scrubs_VendorSrc_MasterList.in_masterlist);