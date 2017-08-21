pversion  := '20080215'                                                                             ;     // modify to current date
directory := '/prod_data_build_13/eval_data/experian_national_business/20080211' ;
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// --    1. Put the Build Date in the pversion attribute above
// --    2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --          _control.MyInfo.EmailAddressNotify
// --        You will receive build emails to this address
// --    3. Check the following attribute to make sure it is correct:
// --          ENB._Flags
/////////////////////////////////////////////////////////////
#workunit('name', 'Experian National Business Build ' + pversion);
ENB.Build_All(pversion, directory).all;
