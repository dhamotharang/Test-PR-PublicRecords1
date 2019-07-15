/*2014-12-02T21:56:59Z (vern_p bentley)
Check-in for BIPV2 Sprint 23 version 20141113
*/
import WorkMan,std;
EXPORT get_Attribute_Text(
	 string  pAttribute
	,boolean pSandbox					    = false											                                                // Get Sandboxed version?
  ,boolean pBackslashQuotes     = true
	,string  pESP							    = _Config.LocalEsp	// ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242:8145'
) :=
function
	
	//Parse In SPC file
	lindex 			:= stringlib.stringfind(pAttribute,'.',1);
	lmodule 		:= pAttribute[1..(lindex - 1)];
	lattribute 	:= pAttribute[(lindex + 1)..];
	
  lespPort4findAtt      := pESP + ':8145';
  lespPort4WsWorkunits  := pESP + ':8010';
  
	//Soapcall to Get SPC attribute
	datt := WorkMan.get_Attributes.fFindAttributes(lmodule,lattribute,lespPort4findAtt) : global;

  dreturn := '\'' + if(pBackslashQuotes and regexfind('\'',datt[1].text)  ,STD.Str.FindReplace(
                                                                      STD.Str.FindReplace(
                                                                        regexreplace('\'',datt[1].text,'\\\\\'')
                                                                      ,'\n'
                                                                      ,'\\n')
                                                                      ,'\r'
                                                                      ,''
                                                                    )
                                                                   
                                                                   ,datt[1].text
               )
               + '\'';

  return dreturn;
end;