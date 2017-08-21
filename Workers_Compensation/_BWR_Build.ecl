// pversion    := '20110513';
// pversion    := '20110930';
// pversion    := '20111014';
// pversion    := '20111104';
// pversion    := '20111108';
// pversion    := '20111118';
// pversion    := '20120111';
// pversion    := '20120113';
// pversion    := '20120117';
// pversion    := '20120126';
// pversion    := '20120130';
pversion    := '20120201';
     
directory := '/hds_180/SIM/Workers_Compensation/' + pversion;

#workunit('name', 'Workers Compensation Build ' + pversion);
Workers_Compensation.Build_All(pversion).all;
