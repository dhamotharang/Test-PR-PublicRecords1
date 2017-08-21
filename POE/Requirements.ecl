/*
During the data load,  if a record has an employer name, but is missing the company phone,
the system must attempt to find a phone prior to returning the record (use zip (if needed) 
and name and find BDID and populate record with the corresponding phone).  Records where 
both home phone and company phone are blank cannot be returned to clients


*/