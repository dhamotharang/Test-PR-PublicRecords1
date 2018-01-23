EXPORT MACRO_Parsing_Numbers(file_name,fieldname, cname) := functionmacro
PATTERN ws               := PATTERN('[ \t\r\n]');
PATTERN Alpha_num            := PATTERN('[A-Z0-9]');
PATTERN number 					 := PATTERN('[0-9]')+; //numbers
PATTERN Word             := Alpha_num+;
PATTERN JustAWord        := number PENALTY(1);
PATTERN NounPhraseComp1  := JustAWord | ws number ;


r_FIELD_NAME := record
  string100 field_name := fieldname;
	string100 category := cname;
  string30 distribution_type := 'DISTINCT-VALUE';
STRING100 att_val := MATCHTEXT(NounPhraseComp1);
end;

p1  := PARSE(file_name,file_name.#expand(fieldname),NounPhraseComp1,r_FIELD_NAME,BEST,MANY);


rf1 := record
recordof(p1);
String50 attribute_value;
end;


t_FIELD_NAME := PROJECT(p1, TRANSFORM(rf1, self.attribute_value := MAP((integer)left.att_val = 0 => '0',
																																			 (integer)left.att_val[1..4] <= 2010 => '2010 or less',
																																			 (integer)left.att_val[1..4] = 2011 => '2011',
																																			 (integer)left.att_val[1..4] = 2012 => '2012',
																																			 (integer)left.att_val[1..4] = 2013 => '2013',
																																			 (integer)left.att_val[1..4] = 2014 => '2014',
																																			 '>2014');
																						self := left;));

rf2 := record
t_FIELD_NAME.field_name;
t_FIELD_NAME.category;
t_FIELD_NAME.distribution_type;
t_FIELD_NAME.attribute_value;
decimal20_4 frequency := count(group);
end;

tb := Table(t_FIELD_NAME, rf2, t_FIELD_NAME.attribute_value);

r_null := record 
  string100 field_name := fieldname;
		string100 category := cname;
  string30 distribution_type := 'DISTINCT-VALUE';
  string50 attribute_value := If(file_name.#expand(fieldname) = '', '', 'Valid');
decimal20_4 frequency := count(group);
end;


t_null := table(file_name,r_null,If(file_name.#expand(fieldname) = '', '', 'Valid'));
t_null_filter := t_null(attribute_value = '');

return t_null_filter + tb;
                           
endmacro;