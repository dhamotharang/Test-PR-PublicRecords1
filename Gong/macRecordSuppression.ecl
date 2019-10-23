export macRecordSuppression(inDS, outDS, inphone) := macro // person suppressions only
import dops;

#UNIQUENAME(SuppressionLayout)
#UNIQUENAME(phone)
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

%SuppressionLayout% := record
	gong.layout_gong.name_prefix;
	gong.layout_gong.name_first;
	gong.layout_gong.name_middle;
	gong.layout_gong.name_last;
	gong.layout_gong.name_suffix;
	string    %phone%;
	gong.layout_gong.prim_range;
	gong.layout_gong.predir;
	gong.layout_gong.prim_name;
	gong.layout_gong.suffix;
	gong.layout_gong.postdir;
	gong.layout_gong.unit_desig;
	gong.layout_gong.sec_range;
	gong.layout_gong.p_city_name;
	gong.layout_gong.v_city_name;
	gong.layout_gong.st;
	gong.layout_gong.z5;
end;

/* Enter in fields exactly the way they are in the gong, gong history, and gong master for suppression as needed. 
  Create as many records as needed for the suppression.
  Matches by name and number first, then will try name and address */
  
dops.SuppressRecords.GetRecords(%SuppressionLayout%,'gong',,,,%SuppressionDS%);
//%SuppressionDS% := dataset([ /* LIST TO SUPPRESS - enter fields the same way they appear in gong, gong history, and master */
														/*{'name_prefix','name_first','name_middle','name_last','name_suffix','phone','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','z5'},
														{'','david','','souter','','','530','','N','','','','','washington','washington','dc','20024'},
														{'','j','r','rosa','','','','','sweet clover','','','','','','','','89509'},
														{'','david','','elwood','','3369982510','','','','','','','','','','',''},
														{'','ruthie','','chavis','','6095870176','6','','chamberlin','ct','','','','lawrence twp','lawrence township','nj','08648'},
														{'','Ron','','Mcclain','','3172952115','','','','','','','','','','',''},
														{'','Gail','M','Shepard','','7725593733','','','','','','','','Sebastion','','fl','32958'},
														{'','','','RHEINGOLD','','4237103241','','','','','','','','','','',''},
														{'','FURNITU','RE','MUNIRE','','','55','','westbro','rd','','','','clifton','','nj','07012'},
														{'','FURNITU','RE','MUNIRE','','','55','','webro','rd','','','','clifton','','nj','07012'},
														{'','FURNITU','RE','MUNIRE','','','91','','new england','ave','','','','piscataway','','nj','08854'},
														{'','Marjorie','Bing','Stanislaw','','7245275568','437','','Cedar','st','','','','JEANNETTE','','PA','15644'},
														{'','James','','Hahn','','3103998213','2950','','Neilson','way','','','','Santa Monica','','CA','90405'},
														{'MR','David','H','Souter','','','','','','','','','','EAST WEARE','WEARE','NH','03281'},
														{'MR','David','H','Souter','','','','','','','','','','WEARE','WEARE','NH','03281'},
														{'MR','David','H','Souter','','','','','','','','','','WEARE','WEARE','NH','03281'},
														{'MR','David','H','Souter','','','','','','','','','','WEARE','EAST WEARE','NH','03281'},
														{'MR','David','H','Souter','','','','','','','','','','WEARE','EAST WEARE','NH','03281'}
														], %SuppressionLayout%); */

%StandarizeField%(string %inField%) := stringlib.stringtouppercase(trim(%inField%, left, right));

%nneqor%(string %in1%, string %in2%, string %in3%) := %StandarizeField%(%in1%) = %StandarizeField%(%in2%) or 
																											%StandarizeField%(%in1%) = %StandarizeField%(%in3%) or 
																											%in1% = '';

%nbeqor%(string %in1%, string %in2%, string %in3%) := (%StandarizeField%(%in1%) = %StandarizeField%(%in2%) or 
																											%StandarizeField%(%in1%) = %StandarizeField%(%in3%)) and 
																											%in1% <> '';
																											
%nneq%(string %in1%, string %in2%) := %in1%='' or %in2%='' or %StandarizeField%(%in1%)=%StandarizeField%(%in2%);

%nbeq%(string %in1%, string %in2%) := %in1%<>'' and %StandarizeField%(%in1%)=%StandarizeField%(%in2%);

%eq%(string %in1%, string %in2%) := %StandarizeField%(%in1%)=%StandarizeField%(%in2%);

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
										 (left.inphone <> '' and %eq%(left.inphone, right.%phone%))), 
										 transform({recordof(inDS)}, self := left), left only, lookup);
									

endmacro;