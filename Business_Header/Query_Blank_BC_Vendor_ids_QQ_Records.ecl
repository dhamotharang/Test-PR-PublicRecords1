bc := business_header.File_Business_Contacts;
bc_father := business_header.File_Business_Contacts_father;

output(count(bc), named('TotalBusinessContactsRecords'));
output(count(bc(dppa = true)), named('TotalBusinessContactsDppaRecords'));
output(count(bc(dppa = true and vendor_id = '')), named('TotalBusinessContactsDppaRecordsWithBlankVendorid'));

output(count(bc(source = 'QQ')), named('TotalBusinessContactsQQRecords'));
output(count(bc_father(source = 'QQ')), named('TotalBusinessContactsFatherQQRecords'));
output('The current total QQ business contacts records should be greater than or equal to the father');
output('If not, there is a problem');