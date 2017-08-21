//Utility count by state John J. Bulten 20070423-20070425
//Attribute corrected to file_util_in 20070510
//W20080110-100852

dDev := UtilFile.file_util_in;
rDev := record
  dDev.address_state;
  count(group);
end;
sortDev := sort(table(dDev,rDev,address_state,few),address_state);
output(sortDev,all);