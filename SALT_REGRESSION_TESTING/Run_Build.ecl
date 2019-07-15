import wk_ut;

EXPORT Run_Build(

   string pModule1
  ,string pModule2
  ,string pBWR_Attribute        //to run the validate of the code
  ,string pToSaltVersion  = ''
  ,string pAttRegex       = ''  //to test only 1 attribute or whatever attribute(s) match this regex
  ,string pUnique_Output  = ''

  ,string pcluster        = wk_ut._constants.LocalHthor
  ,string pESP            = wk_ut._constants.LocalEsp
  ,string pESPPort        = '8010'

) :=
function

  compare_the_salt_code := SALT_REGRESSION_TESTING.Compare_SALT_Code(pModule1,pModule2,pToSaltVersion,pAttRegex,pUnique_Output);
  validate_salt_code    := SALT_REGRESSION_TESTING.Validate_Code(pModule2,pBWR_Attribute,pcluster,pESP,pESPPort);

  return sequential(
     compare_the_salt_code
    ,output(validate_salt_code ,named('validate_salt_code_' + pUnique_Output))
  );

end;