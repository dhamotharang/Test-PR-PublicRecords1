import lib_StringLib;
EXPORT fQualified (string6 pMatchCodes)  :=
function
  string6  ReturnValue  :=  if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'NSD', 1) <> 0, 'NSD',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'VSD', 1) <> 0, 'VSD',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'NSB', 1) <> 0, 'NSB',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'VSB', 1) <> 0, 'VSB',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'NSB', 1) <> 0, 'NSB',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'NPD', 1) <> 0, 'NPD',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'VPD', 1) <> 0, 'VPD',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'NPB', 1) <> 0, 'NPB',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'VPB', 1) <> 0, 'VPB',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'S', 1) <> 0, 'S',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'NDACZ', 1) <> 0, 'NDACZ',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'NDAC', 1) <> 0, 'NDAC',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'NDAZ', 1) <> 0, 'NDAZ',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'VDACZ', 1) <> 0, 'VDACZ',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'VDAC', 1) <> 0, 'VDAC',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'VDAZ', 1) <> 0, 'VDAZ',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'NBACZ', 1) <> 0, 'NBACZ',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'NBAZ', 1) <> 0, 'NBAZ',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'VBACZ', 1) <> 0, 'VBACZ',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'VBAC', 1) <> 0, 'VBAC',
                          if(lib_StringLib.StringLib.StringFind(pMatchCodes, 'VBAZ', 1) <> 0, 'VBAZ',
                          '')))))))))))))))))))));
  return  ReturnValue;
end;

