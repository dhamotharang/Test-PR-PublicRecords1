import Data_Services;

export file_axciomCanRes := module

export v1 := dataset('~thor400_60::in::axciomRes',
											CanadianPhones.layout_axciomCanRes.v1,csv(terminator('\n'), separator(','), quote('"')));
											
export v2 := dataset('~thor400_60::in::axciomRes',
											CanadianPhones.layout_axciomCanRes.v2,csv(terminator('\n'), separator(','), quote('"')));
											
end;