output(BIPV2_Build.files().workunit_history.qa,all);

// -- get all workunits that had errors
output(BIPV2_Build.files().workunit_history.qa(errors != ''),all);