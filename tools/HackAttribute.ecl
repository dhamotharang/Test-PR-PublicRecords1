import wk_ut;
EXPORT HackAttribute(

   string                           pModule              
  ,string                           pAttribute 
  ,dataset(layout_attribute_hacks)  pAttributeHacks
  ,boolean                          pShouldSaveAttribute  = false        
  ,string                           pEsp                  = wk_ut._Constants.LocalEsp + ':8145'

) :=
module

  shared fGetAttribute(STRING att                 ):=mod_Soapcalls.fGetAttributes(pModule,att,pEsp)(COUNT(results)>0)[1].results[1].Text : independent;
  shared fPutAttribute(STRING att,STRING ecl_text ):=OUTPUT(mod_Soapcalls.fSaveAttribute(pModule,att,ecl_text,pEsp));

  // shared dgetatt := dataset([{fGetAttribute(pAttribute)}],{string payload});

  export diterate := iterate(pAttributeHacks,transform(layout_attribute_hacks,
    eclcode             := if(left.eclcode = '',fGetAttribute(pAttribute)  ,left.eclcode);
    
    hackedeclcondition  :=     (right.regex      = '' or     regexfind(right.regex     ,eclcode,nocase))
                           and (right.not_regex  = '' or not regexfind(right.not_regex ,eclcode,nocase))
                           ;
                           
    hackedecl           := if(hackedeclcondition
                              ,regexreplace(right.regex,eclcode,right.replacement,nocase) 
                              ,eclcode
                            );
                            
    HackMessage         := left.HackMessage + if(not hackedeclcondition  ,'Did not Hack ' + pAttribute + ' to ' + right.description + '\n','');
  
  
    self.eclcode      := hackedecl;
    self.AppliedHack  := hackedeclcondition;
    self.HackMessage  := HackMessage;
    self.cnt := counter;
    self              := right;
  )) : independent;

  export lastrecord   := diterate[count(diterate)] : independent;
  export eclcode      := lastrecord.eclcode;
  export hackmessage  := lastrecord.hackmessage;
  export appliedhack  := lastrecord.AppliedHack;

  export saveatt := fPutAttribute(pAttribute,eclcode);

  // export saveit := output(diterate,named('diterate'),all);
  export saveit := sequential(iff(pShouldSaveAttribute and hackmessage = '' ,saveatt  ,sequential(output(dataset([{eclcode}],{string ecl}),named(pAttribute + 'HackedEcl')))),output(hackmessage  ,named(pAttribute + 'Hack_message')));

end;