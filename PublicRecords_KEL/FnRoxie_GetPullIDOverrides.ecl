import ut;


EXPORT FnRoxie_GetPullIDOverrides(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData) := FUNCTION 
			
		
		
		
MyRec := record
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster;
end;

ds := project(InputData, transform(MyRec, self := left, self := [])); 


SetFieldNames := ['g_procuid', 'p_inpacct', 'b_inpacct', 'g_procbusuid'];

#DECLARE(text_layout);
#SET(text_layout,'');

#DECLARE(i); 
#SET(i,0);

#DECLARE(int_default);
#SET(int_default, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);

#DECLARE(str_default);
#SET(str_default, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);

#DECLARE(str_zeroDefault);
#SET(str_zeroDefault, '0');

#DECLARE(Bool_Default);
#SET(Bool_Default, FALSE);

#EXPORTXML(fields, RECORDOF(MyRec));
	#FOR (fields)
	 #FOR (field)
		#IF (%'{@isEnd}'% <> '')
			OUTPUT('END');
		#ELSE
		  #IF(%'{@name}'%  IN SetFieldNames)
					#APPEND(text_layout, 'self.'+%'@label'%+' := LEFT.' + %'{@name}'% + ';');
			#ELSE
			#IF(%'@type'% = 'boolean')
						#APPEND(text_layout, 'self.'+%'@label'%+' :=  '  + %'Bool_Default'%  +';\n');	
			#ELSEIF(%'@type'% = 'string')
						#IF(%@size%=1)
							 #APPEND(text_layout, 'self.'+%'@label'%+' := (string) '  + %'str_zeroDefault'%  +';\n');		
						#ELSE	 
							#APPEND(text_layout, 'self.'+%'@label'%+' := (string) '  + %'str_default'%  +';\n');		
						#END
					#ELSE
						#APPEND(text_layout, 'self.'+%'@label'%+' := '  + %int_default%  +';\n');		
					#END
				#END
		#END
	#END
#END

outdefaults := project( ds, transform(myrec, 	%text_layout%; ));
					
			
Defaults := outdefaults;				
				
						
		RETURN Defaults;
		
	END;	