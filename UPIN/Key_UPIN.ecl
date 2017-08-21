import liensv2, doxie;

file_in := UPIN.File_UPIN_base(UPIN!= '');

dist_upin := distribute(file_in, hash(UPIN));
sort_upin := sort(dist_upin, UPIN,local);

export Key_UPIN  := index(sort_upin, 
                                {UPIN,l_st := physician_Clean_st},{sort_upin},
				            '~thor_data400::key::UPIN::UPIN_' + doxie.Version_SuperKey);



