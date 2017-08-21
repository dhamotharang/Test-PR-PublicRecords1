import wk_ut,std;
EXPORT get_Attribute_Text_4_regex(
	 string  pAttribute
	,boolean pHandle_Special_Chars  = false											                                                // Get Sandboxed version?
	,string  pESP							      = _constants.LocalEsp	// ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242:8145'
) :=
function
    //parentheses
    //dots
    //quotes
    //*s
    //brackets
    //break up string by line feeds
  
  
  
	//Parse In SPC file
	lindex 			:= stringlib.stringfind(pAttribute,'.',1);
	lmodule 		:= pAttribute[1..(lindex - 1)];
	lattribute 	:= pAttribute[(lindex + 1)..];
	
  lespPort4findAtt      := pESP + ':8145';
  lespPort4WsWorkunits  := pESP + ':8010';
  
	//Soapcall to Get SPC attribute
	datt := wk_ut.get_Attributes.fFindAttributes(lmodule,lattribute,lespPort4findAtt) : global;

  dreturn := '\'' + STD.Str.FindReplace(
                                                                      STD.Str.FindReplace(
                                                                        if(pHandle_Special_Chars = true
                                                                          ,regexreplace('([][().*{}|])',regexreplace('\'',datt[1].text,'\\\\\''),'[$1]')
                                                                          ,regexreplace('\'',datt[1].text,'\\\\\'')
                                                                        )
                                                                      ,'\n'
                                                                      ,if(pHandle_Special_Chars = true  ,'[[:space:]]*\'\n+ \'' ,'\\n\'\n+ \''))
                                                                      ,'\r'
                                                                      ,''
                                                                    )
                                                                   
               
               + '\'';

  return dreturn;
end;