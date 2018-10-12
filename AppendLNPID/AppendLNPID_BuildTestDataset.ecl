Input_Record := RECORD
  string firstname;
  string middlename;
  string lastname;
  string namesuffix;
  string gender;
  string ssn;
  string dateofbirth;
  string primaryrange;
  string primaryname;
  string secondaryrange;
  string cityname_vanity;
  string state;
  string zip5;
  string phone;
  string fax;
  string licensenumber;
  string licensestate;
  string upin;
  string npinumber;
  string deanumber;
  string taxonomy;
  string vendorid;
END;

ds := DATASET
    (
        [
            {'JULIO','EDGARDO','ESCOBAR','','M','','00000000','5','PINE CONE','','DAYTON','NV','89403','7752207788','','5572','NV','','1003000167','','122300000X','1003000167'}
        ],
        Input_Record
    );

OUTPUT(ds,,'~qa::cleanappendlnpid::appendlnpid::input',OVERWRITE);