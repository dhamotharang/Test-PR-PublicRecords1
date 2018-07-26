//computes the initial specificities and joins them to the input file
//assumes the existeence of t_cnt field
EXPORT MAC_Field_Initial_Specificities(infile,infield,outfile) := MACRO
	#uniquename(init_record)
		%init_record% := RECORD
			SALT310.StrType InitialChar := infile.infield[1]; // ask Edin if we need to do a lefttrim first?
			infile;
		END;
	#uniquename(Raw_Init)
		%Raw_Init% := TABLE(infile, %init_record%);
	#uniquename(Init_Counts)	
		%Init_Counts% := TABLE(%Raw_Init%, {InitialChar, Init_cnt:= SUM(GROUP, cnt) }, InitialChar, FEW);
		
	//Compute Init_Specificities 
	#uniquename(t)
		%t% := sum(%Init_Counts%, Init_cnt); // More accurate total cluster count
	#uniquename(isr)
	%isr% := RECORD
		%Init_Counts%;
		real8 InitialChar_specificity := log( (real8)%t% / (real8)%Init_Counts%.Init_cnt ) / log(2);
	END;
	
	#uniquename(Init_Spec)
	%Init_Spec% := TABLE(%Init_Counts%,%isr%);
	
	//Join the specificities to the input - ie join Raw_Init0 with Init_Spec on the basis of init
	outfile := JOIN(%Raw_Init%, %Init_Spec%, LEFT.InitialChar = RIGHT.InitialChar, LOOKUP);
ENDMACRO;
