import OSHAIR;

export EBCDIC_to_ASCII_conversion (string source_location // Should be in the following format: '10.150.13.201::data_build_5::oshair'
                                  ,string filedate) := function

#option('skipFileFormatCrcCheck', 1);
// Rather than spray the initial input file, which is in the EBCDIC format, pull it directly from the source location
d	:=	dataset('~file::'+source_location+'::'+filedate+'.initial_load'
               ,OSHAIR.layout_OSHAIR_in.Inspection_rec
			   ,thor);

// Change the primary data string values to ASCII
dA	:=	ascii(d);//choosen(d,100));

// Change all the child dataset values to ASCII
OSHAIR.layout_OSHAIR_in_ASCII.Inspection_rec segments_to_ASCII(da pInput) := transform 
     self.Programs             := ascii(pInput.programs); 
     self.Related_Activties    := ascii(pInput.Related_Activties); 
     self.Optional_Information := ascii(pInput.Optional_Information); 
     self.Violations           := ascii(pInput.Violations); 
     self.Hazardous_Substances := ascii(pInput.Hazardous_Substances); 
     self.Accidents            := ascii(pInput.Accidents); 
// We are currently simply passing through the Debt, Event, and Admin/Payment datasets in 
// the EBCDIC format because they're difficult to process and are not currently in use.
     self                      :=       pInput;
end; 

All_ASCII :=project(da,segments_to_ASCII(left));

output(distribute(All_ASCII,hash32(All_ASCII.Activity_Number))
       ,
	   ,OSHAIR.cluster + 'in::OSHAIR::'+filedate+'::payload'
	   ,overwrite); 
			   
return All_ASCII;

end;
