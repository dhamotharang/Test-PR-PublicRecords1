f := TM_Test.File_Traffix_Test_In;

layout_traffix_stat := record
unsigned4 cnt_total := count(group);
unsigned4 cnt_EMPLOYER := count(group, f.EMPLOYER <> '');
unsigned4 cnt_FIRSTNAME := count(group, f.FIRSTNAME <> '');
unsigned4 cnt_LASTNAME := count(group, f.LASTNAME <> '');
unsigned4 cnt_ADDRESS := count(group, f.ADDRESS <> '');
unsigned4 cnt_CITY := count(group, f.CITY <> '');
unsigned4 cnt_STATE := count(group, f.STATE <> '');
unsigned4 cnt_ZIP_CODE := count(group, f.ZIP_CODE <> '');
unsigned4 cnt_PHONE := count(group, f.PHONE <> '');
unsigned4 cnt_GENDER := count(group, f.GENDER <> '');
unsigned4 cnt_EMAILADDRESS := count(group, f.EMAILADDRESS <> '');
unsigned4 cnt_DOB := count(group, f.DOB <> '');
unsigned4 cnt_REG_DATE := count(group, f.REG_DATE <> '');
end;

fstat := table(f, layout_traffix_stat, few);

output(fstat, all);