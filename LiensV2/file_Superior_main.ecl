import ut;

file_Superior_main0 := dataset('~thor_data400::base::liens::main::superior',LiensV2.Layout_liens_main_module.layout_liens_main,flat);

export file_Superior_main := project(file_Superior_main0, transform(liensv2.Layout_liens_main_module.layout_liens_main, 

			      self.filing_status:= row({left.filing_status[1].filing_status, map(
						                                                                 stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))=  'A'  => 'CONSOLIDATED',    
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='B'  => 'RESTORED',            
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='C'  => 'DISCHARGED',            
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='D'  => 'DISMISSED',            
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='E'  => 'SETTLED',            
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='F'  => 'STAVED' ,           
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='G'  => 'DISPOSED',            
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='H'  => 'STAVED - PENDING' ,   
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='I'  => 'DISPOSED - PENDING' ,   
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='J'  => 'DISPOSED - HEARING' ,   
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='K'  => 'STRIKE',            
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='L'  => 'CLOSED',           
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='M'  => 'REMOVED', 
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='N'  => 'NOT ACTIVE',
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='O'  => 'VOID',
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='P'  => 'POSSESSION',
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='Q' => 'DISCONTINUED',
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='R'  => 'RELEASED',
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='S'  => 'SATISFIED',
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='T'  => 'TRANSFER',
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='U'  => 'UNSATISFIED',
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='V'  => 'VACATED',
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='W' => 'WITHDRAWN',
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='X'  => 'FILED IN ERROR',
stringlib.stringtouppercase(trim(left.filing_status[1].filing_status,left,right))='Z' => 'DELETED',
						
left.filing_status[1].filing_status_desc)},liensv2.Layout_liens_main_module.layout_filing_status);
			 self:= left)); 