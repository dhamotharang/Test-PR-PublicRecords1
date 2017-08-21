d := file_crimHist;

export Key_CrimHist_sid := INDEX(d, {string8 ssid := d.sid}, {d}, '~matrixbuild::key::CrimHist_sid2');