import Business_DOT,mdr,BIPV2,tools,BIPV2_Files; 

dDOT_Base       := Files().dotfile;

export In_DOT_Base := project(dDOT_Base,transform(layouts.dot_base,
  isBad                   := MDR.sourceTools.SourceIsDunn_Bradstreet_Fein(left.source);
  self.active_duns_number := if(isBad ,'' ,Left.active_duns_number);
  self.hist_duns_number   := if(isBad ,'' ,Left.hist_duns_number  );
  self.proxid             := if(left.proxid<>0,left.proxid,left.dotid);  
  self                    := left                                  ;
))
  : persist(filenames('0').base.logical);	//to make it easier, starting from scratch is iteration 0