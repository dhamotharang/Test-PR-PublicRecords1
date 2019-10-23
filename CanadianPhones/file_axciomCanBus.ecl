import Data_Services;

export file_axciomCanBus := module

export v1 := dataset('~thor_data400::in::axciombus',
											CanadianPhones.layout_axciomCanBus.v1,csv(terminator('\n'), separator(','), quote('"')));
										
export v2 := dataset('~thor_data400::in::axciombus',
											CanadianPhones.layout_axciomCanBus.v2,csv(terminator('\n'), separator(','), quote('"')));
											
end;