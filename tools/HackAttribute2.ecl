import wk_ut;
EXPORT HackAttribute2(

   // string                           pModule              
  // ,string                           pAttribute 
   dataset(layout_attribute_hacks2) pAttributeHacks
  ,boolean                          pShouldSaveAttribute  = false        
  ,string                           pEsp                  = wk_ut._Constants.LocalEsp + ':8145'

) :=
module

  // shared fGetAttribute(STRING att                 ):=mod_Soapcalls.fGetAttributes(pModule,att,pEsp)(COUNT(results)>0)[1].results[1].Text : independent;
  shared fPutAttribute(string pmod,STRING att,STRING ecl_text ):=OUTPUT(mod_Soapcalls.fSaveAttribute(pmod,att,ecl_text,pEsp),named('SavedAttributes'),extend);

  // shared dgetatt := dataset([{fGetAttribute(pAttribute)}],{string payload});

  // export ds_att_prep := project(pAttributeHacks ,transform(recordof(left)
    // ,self.eclcode := if(left.themodule != '' and left.theattribute != ''  ,mod_Soapcalls.fGetAttributes(left.themodule,left.theattribute,pEsp)(COUNT(results)>0)[1].results[1].Text ,'')
    // ,self         := left
  // )) : independent;

  export ds_att_prep := group(sort(pAttributeHacks(themodule != '', theattribute != ''),themodule, theattribute),themodule, theattribute);

  export diterate := iterate(ds_att_prep,transform(layout_attribute_hacks2,
    //get eclcode once per attribute, then apply all hacks to that code 
    eclcode             := iff(left.themodule = '',mod_Soapcalls.fGetAttributes(right.themodule,right.theattribute,pEsp)(COUNT(results)>0)[1].results[1].Text  ,left.eclcode);
    // eclcode             := right.eclcode;
    
    hackedeclcondition  :=     (right.regex      = '' or     regexfind(right.regex     ,eclcode,nocase))
                           and (right.not_regex  = '' or not regexfind(right.not_regex ,eclcode,nocase))
                           ;
                           
    hackedecl           := if(hackedeclcondition
                              ,regexreplace(right.regex,eclcode,right.replacement,nocase) 
                              ,eclcode
                            );
                            
    HackMessage         := left.HackMessage + if(not hackedeclcondition  ,'Did not Hack ' + trim(right.themodule) + '.' + trim(right.theattribute) + ' to ' + right.description + '\n','');
  
  
    self.eclcode      := hackedecl;
    self.WillApplyHack  := hackedeclcondition;
    self.HackMessage  := HackMessage;
    self.cnt          := counter;
    self              := right;
  )) : independent;

  export lastrecord   := diterate[count(diterate)] : independent;
  export eclcode      := lastrecord.eclcode;
  export hackmessage  := count(diterate(HackMessage != ''));
  export appliedhack  := lastrecord.WillApplyHack;

  //dedup to get the last record per attribute which will have all of the hacks for that attribute applied.
  export saveatt := apply(dedup(diterate,themodule, theattribute,right)  ,fPutAttribute(themodule,theattribute,eclcode));

  export layout_slim :=
  record
    string  themodule            ;
    string  theattribute         ;
    boolean WillApplyHack := false ;
    string  HackMessage := ''    ;
    string  regex                ;
    string  not_regex            ;
    string  replacement          ;
    string  description          ;
    unsigned cnt := 0;
  end;

  export ds_slim := project(diterate  ,layout_slim);
  // export saveit := output(diterate,named('diterate'),all);
  export saveit := sequential(iff(pShouldSaveAttribute and hackmessage = 0 ,saveatt  ,sequential(output(ds_slim,named('HackedEcl_slim'),extend),output(diterate,named('HackedEcl'),extend)))/*,output(hackmessage  ,named(pAttribute + 'Hack_message'))*/);

end;