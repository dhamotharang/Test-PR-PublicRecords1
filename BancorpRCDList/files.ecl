export Files:=MODULE
  export Base := dataset('~thor_data400::base::BancorpRCDList::qa::SSN',
                           BancorpRCDList.layouts.base,thor,opt);

  export infile := dataset('~thor_data400::in::BancorpRCDList::sprayed',
                           BancorpRCDList.layouts.inrec,csv,opt);                           
END;
