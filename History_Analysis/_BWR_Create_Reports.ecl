
// Make sure your version matches the version in Send_Email.ecl

version := ' 20200615';

#workunit('name', 'Prod History Report ' + version );

_Create_Reports(version).full_report