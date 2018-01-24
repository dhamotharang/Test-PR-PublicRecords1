export macRecordSuppression(inDS, outDS, inphone, isFcra = false) := macro // person suppressions only
import dops;

#UNIQUENAME(SuppressionDS)
#UNIQUENAME(nneqor)
#UNIQUENAME(nneq)
#UNIQUENAME(nbeqor)
#UNIQUENAME(nbeq)
#UNIQUENAME(eq)
#UNIQUENAME(in1)
#UNIQUENAME(in2)
#UNIQUENAME(in3)
#UNIQUENAME(StandarizeField)
#UNIQUENAME(inField)


/* Enter in fields exactly the way they are in the gong, gong history, and gong master for suppression as needed. 
  Create as many records as needed for the suppression.
  Matches by name and number first, then will try name and address */
  

%StandarizeField%(string %inField%) := std.str.touppercase(trim(%inField%, left, right));

%nneqor%(string %in1%, string %in2%, string %in3%) := %StandarizeField%(%in1%) = %StandarizeField%(%in2%) or 
																											%StandarizeField%(%in1%) = %StandarizeField%(%in3%) or 
																											%in1% = '';

%nbeqor%(string %in1%, string %in2%, string %in3%) := (%StandarizeField%(%in1%) = %StandarizeField%(%in2%) or 
																											%StandarizeField%(%in1%) = %StandarizeField%(%in3%)) and 
																											%in1% <> '';
																											
%nneq%(string %in1%, string %in2%) := %in1%='' or %in2%='' or %StandarizeField%(%in1%)=%StandarizeField%(%in2%);

%nbeq%(string %in1%, string %in2%) := %in1%<>'' and %StandarizeField%(%in1%)=%StandarizeField%(%in2%);

%eq%(string %in1%, string %in2%) := %StandarizeField%(%in1%)=%StandarizeField%(%in2%);



/* Enter in fields exactly the way they are in the gong, gong history, and gong master for suppression as needed. 
  Create as many records as needed for the suppression.
  Matches by name and number first, then will try name and address */
  
dops.SuppressRecords.GetRecords(gong_neustar.SuppressionLayout,'gong',,isFcra,,%SuppressionDS%);
OutDS := join(inDS, %SuppressionDS%,
								/* MATCH BY NAME AND...*/		
										%eq%(left.name_last, right.name_last) and
										%eq%(left.name_first, right.name_first) and
										%eq%(left.name_suffix, right.name_suffix) and
								/* MATCH BY ADDRESS OR */		
										((left.inphone = '' and 
																					%eq%(left.prim_name, right.prim_name) and 
																					%eq%(left.prim_range, right.prim_range) and 
																					%eq%(left.sec_range, right.sec_range) and 
																					((%nbeq%(left.st, right.st) and %nbeqor%(left.p_city_name, right.p_city_name, right.v_city_name)) or
																					  %eq%(left.z5, right.z5))) or
								/* MATCH BY ADDRESS AND PHONE OR */		
										 // (left.inphone <> '' and left.prim_name <> '' and 
																					// %eq%(left.inphone, right.%phone%) and 
																					// %eq%(left.prim_name, right.prim_name) and 
																					// %eq%(left.prim_range, right.prim_range) and 
																					// %nneq%(left.sec_range, right.sec_range) and 
																					// %nneq%(left.st, right.st) and
																					// %nneqor%(left.p_city_name, right.p_city_name, right.v_city_name) and
																					// %eq%(left.z5, right.z5)) or
								/* MATCH BY PHONE */		
										 (left.inphone <> '' and %eq%(left.inphone, right.__phone__2__))), 
										 transform({recordof(inDS)}, self := left), left only, lookup);
									

endmacro;