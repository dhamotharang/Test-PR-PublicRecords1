import Business_DOT,mdr,BIPV2,tools,BIPV2_Files; 

dDOT_Base       := Files().dotfile;

export In_DOT_Base := fAddForeignCorpKeyStateFields(dDOT_Base)
  : persist(filenames('0').base.logical);	//to make it easier, starting from scratch is iteration 0