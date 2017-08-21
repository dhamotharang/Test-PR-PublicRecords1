import lib_stringlib, pfs;

// The version is set to the current date unless another date is specified. The
// workunit cannot accept a non-constant date, so the user should take care to match them
pversion     := stringlib.getDateYYYYMMDD();
workunitDate := '20141002';
     
#workunit('name', 'Physician Time Files (PFS) Build ' + workunitDate);
// This call will build all of the required files including spraying the csv file to the repository
pfs.Build_All(pversion);

// This call will build all of the required files WITHOUT spraying the csv file to the repository
// pfs.Process_Files(pversion);
