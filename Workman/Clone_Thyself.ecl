/*
  Works to clone the existing wuid, but causes weird issues like things not running, hanging, etc.
  Only use if you feel lucky.
*/
import WsWorkunits;
EXPORT Clone_Thyself(

   string pWuid           = workunit
  ,string pESP            = _Config.LocalEsp
  ,string pESPPort        = '8010'
  ,string pEmailAddresses = WorkMan._Config.EmailAddressNotify
  ,string pEmailSubject   = ''
  ,string pEmailBody      = ''
  ,string pErrors         = '(mp link closed|soap dataset|unauthorized|timeout|failed to connect|connection is broken|workunit terminated unexpectedly|workunit access denied)'

) := 
function


  // -- SHOULD PROBABLY ONLY DO THIS IF I GET NON-BLANKS FROM ECL AND CLUSTER
  // -- OTHERWISE, WHAT TO DO????  EMAIL PROBABLY.  MAYBE AN EMAIL THAT HAS A LINK THAT COULD RE-KICK THIS OFF
  // -- KIND OF LIKE HOW I HAVE A LINK TO NOTIFY THAT NOTIFIES WHEN YOU CLICK.  HOW TO DO THAT WITH SOAPCALL WUSUBMIT??
  
  ecl_code_raw  := WsWorkunits.Get_Query  (pWuid,pESP) ;
  cluster_      := WsWorkunits.Get_Cluster(pWuid,pESP) ;
  errors        := WorkMan.get_Errors     (pWuid,pESP);
  
  regex := '^output[(].*?named[(].Parent_Wuid__html.[)][)];\n(.*)$';
  
  ecl_code  := regexreplace(regex ,ecl_code_raw ,'$1' ,nocase);

  // -- with git, might want to use WsWorkunits.get_Debug_Values to get the debug values to make sure it uses the same
  // -- repository as the original
  
  wuid := WorkMan.CreateWuid_raw(ecl_code  ,cluster_ ,pESP ,pESPPort);
  
  EmailSubject  := if(pEmailSubject = '' ,workunit + ' has failed to clone itself.',pEmailSubject);
  EmailBody     := if(pEmailBody    = '' ,'http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Summary\n' ,pEmailBody   );
  
  send_email_ := WorkMan.Send_Email(pEmailAddresses,EmailSubject,EmailBody);
  
  // return ecl_code;
  parent_wuid := regexfind('W[[:digit:]]{8}[^#]*' ,WorkMan.get_Scalar_Result(workunit  ,'Parent_Wuid__html') ,0);
  clone_number := (unsigned)WorkMan.get_Scalar_Result(trim(parent_wuid),'Clone_Number');
  
  return 
    iff(ecl_code != '' and cluster_ != '' and (pErrors = '' or regexfind(pErrors,errors,nocase)) // only do this for platform errors, not our errors.  skip THOR ABORT probably.
      ,sequential(
         output('<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + wuid + '#/stub/Summary">Clone Workunit</a>'   ,named('Clone_Wuid__html'),overwrite)
        ,output(clone_number + 1  ,named('Clone_Number'),overwrite)
      )
      ,sequential(
         output('Failed to get the ecl code and cluster from a soapcall or the error is not platform, so couldn\'t clone myself, sorry. :('                                      ,named('Clone_Wuid__html'),overwrite)
        ,if(pEmailAddresses != '' and EmailSubject != '' and EmailBody != ''  ,send_email_)
      )
    );
end;