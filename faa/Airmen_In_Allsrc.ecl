EXPORT Airmen_In_Allsrc :=  module

export File_In_pilot := dataset('~thor_data400::in::faa::airmen_pilot',faa.layouts.airmen.pilotraw,thor);
export File_In_nonpilot := dataset('~thor_data400::in::faa::airmen_nonpilot',faa.layouts.airmen.nonpilotraw,thor);
export File_In_certificate := dataset('~thor_data400::in::faa::airmen_certificate',layout_airmen_certificate.v1,thor);

end;