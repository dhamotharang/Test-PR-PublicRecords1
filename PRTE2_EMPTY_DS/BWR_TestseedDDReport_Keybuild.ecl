import STD,PRTE2, _control, PRTE, Data_Services, Vendor_Src; 

skipDOPS:=FALSE;
string emailTo:='';
// dops_name := 'VendorSourceKeys';

version :=(string8)STD.Date.CurrentDate(True);
pIndexVersion := '20190703114624';

layout_citizen_inputecho := RECORD
  string20 indatasetname;
  data16 hashvalue;
  string100 inaccountnumber;
  string20 infirstname;
  string20 inlastname;
  string5 inzip5;
  string9 inssn;
  string10 inphone;
  string15 lexid;
  string10 phone;
  string10 streetnumber;
  string2 streetpredirection;
  string28 streetname;
  string4 streetsuffix;
  string2 streetpostdirection;
  string10 unitdesignation;
  string8 unitnumber;
  string60 streetaddress1;
  string60 streetaddress2;
  string25 city;
  string2 state;
  string5 zip5;
  string4 zip4;
  string18 county;
  string9 postalcode;
  string50 statecityzip;
  string9 ssn;
  string62 fullname;
  string20 firstname;
  string20 middlename;
  string20 lastname;
  string5 suffix;
  string3 prefix;
  unsigned4 dob;
  string15 modelname;
  string10 phone2;
  string25 dlnumber;
  string2 dlstate;
  string100 emailaddress;
  unsigned8 __internal_fpos__;
 END;
 
 
 layout_citizen_riskindicator := RECORD
  string20 indatasetname;
  data16 hashvalue;
  string100 inaccountnumber;
  string20 infirstname;
  string20 inlastname;
  string5 inzip5;
  string9 inssn;
  string10 inphone;
  string3 citizenshipscore;
  string17 lexid;
  string5 lexidscore;
  string5 identityage;
  string5 emergenceageheader;
  string5 emergenceagebureau;
  string5 ssnissuanceage;
  string5 ssnissuanceyears;
  string5 relativecount;
  string5 ver_voterrecords;
  string5 ver_insurancerecords;
  string5 ver_studentfile;
  string5 firstseenaddr10;
  string5 reportedcuraddressyears;
  string5 addressfirstreportedage;
  string5 timesincelastreportednonbureau;
  string5 inputssnrandomlyissued;
  string5 inputssnrandomissuedinvalid;
  string5 inputssnissuedtononus;
  string5 inputssnitin;
  string5 inputssninvalid;
  string5 inputssnissuedpriordob;
  string5 inputssnassociatedmultlexids;
  string5 inputssnreporteddeceased;
  string5 inputssnnotprimarylexid;
  string5 lexidbestssninvalid;
  string5 lexidreporteddeceased;
  string5 lexidmultiplessns;
  string5 inputcomponentdivrisk;
  unsigned8 __internal_fpos__;
 END;


dsCitizen_InputEcho := dataset([], layout_citizen_inputecho);
dsCitizen_RiskIndicator := dataset([],  layout_citizen_riskindicator);


Key_inputEcho_citizen     	:= index(dsCitizen_InputEcho,{indatasetname,hashvalue},{dsCitizen_InputEcho},prte2.constants.prefix+'key::testseed::'+ pIndexVersion+'::citizenship::inputecho');
Key_RiskIndicator_citizen		:= index(dsCitizen_RiskIndicator,{indatasetname,hashvalue},{dsCitizen_RiskIndicator},prte2.constants.prefix+'key::testseed::'+ pIndexVersion+'::citizenship::riskindicators');

//---------- making DOPS optional -------------------------------
// notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
// NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
// updatedops					:= PRTE.UpdateVersion(dops_name, pIndexVersion, notifyEmail,'B','N','N');

// PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

build_keys := sequential(build(Key_inputEcho_citizen, update), 
												 build(Key_RiskIndicator_citizen, update), 
                         // PerformUpdateOrNot
												);

build_keys;                       
output ('successful');
