IMPORT Header_Crosswalk;

#WORKUNIT('name', 'headercrosswalk.pbi_service');

STRING str_input_version := '' : STORED('version');

OUTPUT(Header_Crosswalk.Files.Build_Summary(IF(str_input_version <> '', version = str_input_version, TRUE)), NAMED('build_summary'), ALL);