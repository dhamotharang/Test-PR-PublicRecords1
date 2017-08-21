export mac_wordbag_addweights(infile,infield,value_file,outfile) := MACRO
  #uniquename(r1)
	%r1% := record,maxlength(8193)
	  infile;
		unsigned6 num;
		unsigned2 node;
	  end;
	#uniquename(seq)
	%r1% %seq%(infile le,unsigned6 c) := transform
	  self.num := c;
	  self.node := thorlib.node();
	  self := le;
	  end;
		
	#uniquename(p)
	%p% := project(infile,%seq%(left,counter));
  #uniquename(r)
	%r% := record,maxlength(8193)
		unsigned6 num;
		unsigned2 node;
		string word := '';
	  end;
	#uniquename(nt)
	%r% %nt%(%p% le,unsigned c) := transform
		self.word := ut.Word(le.infield,c);
		self := le;
	  end;
	#uniquename(n)
	%n% := normalize(%p%,STD.Str.CountWords(left.infield, ' '),%nt%(left,counter));
	#uniquename(add_s)
	%r% %add_s%(%n% le,value_file ri) := transform
	  self.word := le.word + ' ' + (string)((unsigned)ri.field_specificity);
	  self := le;
	  end;
	#uniquename(j)
	%j% := sort(distribute(join(%n%,value_file,left.word = right.infield,%add_s%(left,right),skew(1.0)),node),num,word,local);
		
	#uniquename(rt)
	%r% %rt%(%j% le, %j% ri) := transform
	  self.word := le.word + ' ' + ri.word;
	  self := le;
	  end;
	#uniquename(o)	
	%o% := rollup(%j%,left.num=right.num,%rt%(left,right),local);
	#uniquename(r3)
	%r3% := record,maxlength(9000)
	  infile;
		string word;
	  end;
	#uniquename(take_word)
	%r3% %take_word%(%p% le,%o% ri) := transform
	  self.word := ri.word;
	  self := le;
	  end;
		
	outfile := join(%p%,%o%,left.num=right.num,%take_word%(left,right),local);
		
  ENDMACRO;
