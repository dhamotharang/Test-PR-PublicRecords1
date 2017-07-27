pversion    := '20110830';     // modify to current date ,this date will be used to populate dates(dt_first & dt_last)
folderDate  := '20101102'; 		//Raw file folder date, this date will be used to spray the raw files on thor
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// --    1. Put the Build Date in the pversion attribute above
// --    2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --          _control.MyInfo.EmailAddressNotify
// --        You will receive build emails to this address
// --    3. Check the following attribute to make sure it is correct:
// --          Diversity_Certification._Flags
/////////////////////////////////////////////////////////////
#workunit('name', 'Diversity Certification Build ' + pversion);
Diversity_Certification.Build_All(pversion,folderDate).all;