export files := module

export f_vendor   := dataset('~thor_data400::in::ixi',          ixi.layouts.l_vendor,csv(heading(1),quote('"')));
export f_address  := dataset('~thor_data400::base::ixi_address',ixi.layouts.l_address,flat);
export f_assessor := dataset('~thor_data400::base::ixi_tax',    ixi.layouts.l_assessor,flat);
export f_deed     := dataset('~thor_data400::base::ixi_deed',   ixi.layouts.l_deed,flat);
export f_people   := dataset('~thor_data400::base::ixi_people', ixi.layouts.l_people,flat);
export f_raw      := dataset('~thor_data400::base::ixi_raw',    ixi.layouts.l_raw,flat);

end;