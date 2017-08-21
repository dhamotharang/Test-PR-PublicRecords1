import FLAccidents;

flc8_v3_in := dataset('~thor_data400::sprayed::flcrash8',
                                  FLAccidents.Layout_FLCrash8_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])))(accident_nbr <> 'report_number');


flc8_v3_rec := FLAccidents.Layout_FLCrash8;

flc8_v3_rec flc8_convert_to_old(flc8_v3_in l) := transform
self.rec_type_8  := '8';
self.section_no	:= Intformat((integer)l.section_no,2,1);
self.carrier_zip := map( trim(l.carrier_zip[6..9],left,right) = '0000' and  regexfind('[1-9]',trim(l.carrier_zip,left,right)) = true => l.carrier_zip[1..5],
                     regexfind('[1-9]',trim(l.carrier_zip,left,right)) = false => '',l.carrier_zip);

self            := l;
self            := [];
end;

export InFile_FLCrash8_v4 := project(flc8_v3_in,flc8_convert_to_old(left));