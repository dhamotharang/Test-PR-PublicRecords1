import Business_DOT,mdr,BIPV2,tools; 

dDOT_Base       := Files().dotfile;

export In_DOT_Base := project(dDOT_Base,transform(layouts.dot_base,
  ismailing               := if(left.prim_range = '' and regexfind('box',left.prim_name,nocase), true, false);
  
  self.proxid                := if(left.proxid<>0,left.proxid,left.dotid);  
  self.physical_prim_range   := if(ismailing ,'',left.prim_range );
  self.physical_prim_name    := if(ismailing ,'',left.prim_name  );
  self.physical_sec_range    := if(ismailing ,'',left.sec_range  );
  self.physical_v_city_name  := if(ismailing ,'',left.v_city_name);
  self.physical_st           := if(ismailing ,'',left.st         );
  self.physical_zip          := if(ismailing ,'',left.zip        );
  self                       := left                                  ;
))
  : persist(filenames('0').base.logical);	//to make it easier, starting from scratch is iteration 0
  
//Drop_Indicator = 'C' //cmra
//OWGM_Indicator nonblank?  //indicates post office box, but might not include all of them
//Record_Type_Code = 'P' //indicates po box
//Address_Type = '9' //indicates po box
//Advo.Files().File_Cleaned_Base;