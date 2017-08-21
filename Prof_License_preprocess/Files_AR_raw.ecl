EXPORT Files_AR_raw := module

export DDS := dataset('~thor_data400::in::prolic::ar::dds::raw',Layouts_AR_raw.DDS,CSV( heading(1),separator(','),terminator(['\n']),Quote('"')));
export RDA := dataset('~thor_data400::in::prolic::ar::rda::raw',Layouts_AR_raw.RDA,CSV( heading(1),separator(','),terminator(['\n']),Quote('"')));
export RDH := dataset('~thor_data400::in::prolic::ar::rdh::raw',Layouts_AR_raw.RDH,CSV( heading(1),separator(','),terminator(['\n']),Quote('"')));
export optometry := dataset('~thor_data400::in::prolic::ar::optometrists::raw',Layouts_AR_raw.optometry,CSV( heading(1),separator(','),terminator(['\n']),Quote('"')));
export pharmacy := dataset('~thor_data400::in::prolic::ar::pharmacist::raw',Layouts_AR_raw.pharmacy,CSV( heading(1),separator(','),terminator(['\n']),Quote('"')));

end;