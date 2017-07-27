// this macro will take a dataset with one column and move it to a string comma delimited
export MAC_ds_to_string(infile,instring,outstring) := macro
#uniquename(outrec)
	%outrec% := record
		string instring;
	end;
#uniquename(new_infile)
	
%new_infile% := project(infile,transform(%outrec%,self.instring := left.instring));
	
#uniquename(outtran)
	%outrec%	%outtran%(%outrec% l, %outrec% r) := transform
		self.instring:= trim(l.instring) + ',' + r.instring;
	end;
	
#uniquename(outfile)
	%outfile% :=rollup(%new_infile%,true,%outtran%(left,right));	
	outstring := %outfile%[1].instring;
endmacro;