import ut;

export files := module

// todo on a rainy day:  change all of the other testseeds and queries calling them to use this attribute,
// and use this attribute for all testseed files going forward
export file_np80 := dataset('~testseeds::in::np2opr2is080', layout_np2opr2i, csv);
export file_np81 := dataset('~testseeds::in::np2opr2is081', layout_np2opr2i, csv);
export file_np82 := dataset('~testseeds::in::np2opr2is082', layout_np2opr2i, csv);
export file_b2bz := dataset('~testseeds::in::sd5osd5is001', layout_sd5osd5i, csv);


export file_np90 := dataset('~testseeds::in::np2opr2is090', layout_np2opr2i, csv);
export file_np91 := dataset('~testseeds::in::np2opr2is091', layout_np2opr2i, csv);
export file_np92 := dataset('~testseeds::in::np2opr2is092', layout_np2opr2i, csv);
export file_b2b4 := dataset('~testseeds::in::sd5osd5is004', layout_sd5osd5i, csv);

export file_bnk4 := dataset('~testseeds::in::bc1obc1is001', layout_bc1obc1i, csv);
export file_cbbl := dataset('~testseeds::in::bc1obc1is003', layout_bc1obc1i, csv);

export file_2x70 := dataset('~testseeds::in::sc1osd1is270', layout_sc1osd1i, csv);
export file_2x71 := dataset('~testseeds::in::sc1osd1is271', layout_sc1osd1i, csv);

export file_wfs3 := dataset('~testseeds::in::wf2owf2i003', layout_wf2o, csv);
export file_wfs4 := dataset('~testseeds::in::wf2owf2i004', layout_wf2o, csv);

end;