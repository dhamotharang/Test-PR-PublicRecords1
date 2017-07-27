IMPORT Business_Header, ut;
#workunit ('name', 'Build Business_Contacts_Output');

// Create the Business Contacts Output File
do1 := OUTPUT(Business_Header.BC_Out,,'OUT::Business_Contacts', OVERWRITE) : success(output('Bus Contacts Output File Created'));
// Create the Employment/People at Work Output File
do2 := OUTPUT(Business_Header.Emp_Out,,'OUT::Employment', OVERWRITE) : success(output('Employment Output File Created'));

do3 := output('Bus contacts Dids: ' + count(business_header.File_Business_Contacts_Out((integer) did > 0)));
do4 := output('PAW dids: ' + count(business_header.File_Employment_Out((integer) did > 0)));

export Make_Business_Contacts_Out := sequential(do1,do2,do3,do4);

