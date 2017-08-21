import mdr,address;
// Check for a UCC Person Only Record or Not a Person-Company
EXPORT BOOLEAN CheckUCC(STRING2 source, STRING120 company_name, STRING20 fname, STRING20 mname, STRING20 lname, STRING5 name_suffix) :=
  MDR.sourceTools.SourceIsUCCs(source) AND
  ((((INTEGER)(Datalib.NameClean(company_name)[142]) < 3 or
    (INTEGER)(Datalib.NameClean(fname + ' ' + mname + ' ' + lname + ' ' + name_suffix)[142]) < 3) AND
  Datalib.CompanyClean(company_name)[41..120] = '')
  or
  (NOT ((Address.Business.GetNameType(fname + ' ' + mname + ' ' + lname + ' ' + name_suffix)) in ['P','D'] AND
  (INTEGER)(Datalib.NameClean(fname + ' ' + mname + ' ' + lname + ' ' + name_suffix)[142]) < 3 AND
  Datalib.CompanyClean(company_name)[41..120] <> ''))
);