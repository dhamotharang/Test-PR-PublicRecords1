import _control;

export EBCDIC_to_ASCII_conversion (string filedate
								  ,string filename
								  ,string version) := function

#option('skipFileFormatCrcCheck', 1);

d	:=	dataset('~file::'+ _Control.IPAddress.edata12 +'::hds_4::oshair::data::'+filedate+'::'+filename
               ,OSHAIR.layout_OSHAIR_in.Inspection_rec
			   ,thor);

dA	:=	ascii(d);

OSHAIR.layout_OSHAIR_in_ASCII.Inspection_rec segments_to_ASCII(da pInput) := transform 
     self.Programs             := ascii(pInput.programs); 
     self.Related_Activties    := ascii(pInput.Related_Activties); 
     self.Optional_Information := ascii(pInput.Optional_Information); 
     //self.Debts			   	   := project(ascii(pInput.Debts),recordof(ascii(self.Debts)));//ascii(pInput.Debts);
	 self.Violations           := ascii(pInput.Violations); 
     self.Hazardous_Substances := ascii(pInput.Hazardous_Substances); 
     self.Accidents            := ascii(pInput.Accidents); 
	 //self.Admin_Payment		   := project(ascii(pInput.Admin_Payment),recordof(ascii(self.Admin_Payment)));//ascii(pInput.Admin_Payment);
     self                      := pInput;
end; 

All_ASCII :=project(da,segments_to_ASCII(left));
  
super_input := sequential(FileServices.StartSuperFileTransaction()
                             ,FileServices.ClearSuperFile('~thor_data400::in::OSHAIR::payload')
							 ,FileServices.AddSuperFile('~thor_data400::in::OSHAIR::payload'
							                           ,'~thor_data400::in::OSHAIR::'+version+'::payload')
			                 ,FileServices.FinishSuperFileTransaction());

return sequential(							 
		output(distribute(All_ASCII,hash32(All_ASCII.Activity_Number)),,OSHAIR.cluster + 'in::OSHAIR::'+version+'::payload',overwrite),
		super_input);

end;
