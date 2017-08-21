import ut;

TextRecord := RECORD

            string line{maxlength(3000000)};

end;

 

TextData_In := DATASET('~thor_data50::in::webtext',

                                     TextRecord,

                                     csv(separator(''), TERMINATOR('<MALGLUE>'), QUOTE(''),

                                     MAXLENGTH(3000000)));

                                     

f := choosen(Textdata_in(LENGTH(line)>10), 2000);

ExtractInput := RECORD 
  STRING content {MAXLENGTH(3000000)};
	INTEGER MaxDids;
	INTEGER MaxFull;
	integer docid;
END;

extractinput proj(TextData_In l, INTEGER c) :=
TRANSFORM
	SELF.docid := c;
	SELF.content := l.line;
	Self.MaxDids := 2;
	Self.MaxFull := 1;
END;

result_score :=
	record
		integer score;
	end;
	
result_address := 
	record(result_score)
		string street :='';
		string city := '';
		string2 st := '';
		string5 zip5 := '';
  end;

result_person := 
	record(result_score)
		string fname :='';
		string lname := '';
		integer did := 0;
		dataset(result_address) addresses { maxcount(1) };
  end;

entity :=
  record
	  string orig := '';
		unsigned4 docId;
		unsigned4 pos;
	end;

entity_person := 
	record(entity)
	  Address.Layout_Clean_Name clean;
		DATASET(result_person) people { maxcount(100) };
  end;

p := PROJECT(f, proj(LEFT, COUNTER));

res := soapcall(p, 'http://rchapmanserver:9876', 'gordon.extractor', {p}, 
				DATASET(entity_person), PARALLEL(1), xpath('gordon.extractorResponse/Results/Result/Dataset[@name="person"]/Row'));
				

output(res);