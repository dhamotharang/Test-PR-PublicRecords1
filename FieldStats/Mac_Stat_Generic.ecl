/*
	infile - input file
	outf   - name for output
	topcount - how many of top results to consider
	fldcnt - how many fields will be included
	limitFlds - boolean indicating that you should limit stat to 
			  1st 2 letters of fields for optimization
	fldx - field name in input file
	ftypx - 'string', 'number'
	flgx - 'F' (few), 'M' (many), ''  - flag to table command
*/
	
export Mac_Stat_Generic(infile, outf, topcount, fldcnt, limitFld,
					fld1, ftyp1, flg1, 
					fld2 = '', ftyp2 = '', flg2 = '', 
					fld3 = '', ftyp3 = '', flg3 = '', 
					fld4 = '', ftyp4 = '', flg4 = '', 
					fld5 = '', ftyp5 = '', flg5 = '', 
					fld6 = '', ftyp6 = '', flg6 = '', 
					fld7 = '', ftyp7 = '', flg7 = '') := macro

#uniquename(commonrec)
%commonrec% := record
	string8 	rundate;	
	string	fld_val;
	unsigned4	cnt;
end;

#uniquename(countrec)
%countrec% := record
	string	fld_val;
	unsigned4	cnt;
end;

#uniquename(today)
string8 %today% := ut.GetDate;

#uniquename (myrec)
%myrec% := record, maxlength(150000)
	string8	rundate;
	dataset(%countrec%)	fld1;
	#if (fldcnt >= 2)
		dataset(%countrec%)	fld2;
	#end
	#if (fldcnt >= 3)
		dataset(%countrec%)	fld3;
	#end
	#if (fldcnt >= 4)
		dataset(%countrec%)	fld4;
	#end
	#if (fldcnt >= 5)
		dataset(%countrec%)	fld5;
	#end
	#if (fldcnt >= 6)
		dataset(%countrec%)	fld6;
	#end
	#if (fldcnt >= 7)
		dataset(%countrec%)	fld7;
	#end
end;

#uniquename(parent)
#if (fldcnt = 1)
	%parent% := dataset([{ut.GetDate,[]}],%myrec%);
#end
#if (fldcnt = 2)
	%parent% := dataset([{ut.GetDate,[],[]}],%myrec%);
#end
#if (fldcnt = 3)
	%parent% := dataset([{ut.GetDate,[],[],[]}],%myrec%);
#end
#if (fldcnt = 4)
	%parent% := dataset([{ut.GetDate,[],[],[],[]}],%myrec%);
#end
#if (fldcnt = 5)
	%parent% := dataset([{ut.GetDate,[],[],[],[],[]}],%myrec%);
#end
#if (fldcnt = 6)
	%parent% := dataset([{ut.GetDate,[],[],[],[],[],[]}],%myrec%);
#end
#if (fldcnt = 7)
	%parent% := dataset([{ut.GetDate,[],[],[],[],[],[],[]}],%myrec%);
#end
#if (fldcnt < 1 or fldcnt > 7)
	%parent% := dataset([],%myrec%);
#end
					
#uniquename(into_myrec)
%myrec% %into_myrec%(%parent% L, %commonrec% R, integer C) := transform
	self.rundate := L.rundate;
	self.fld1 := if ( c = 1, L.fld1 + dataset([{R.fld_val,R.cnt}],%countrec%), L.fld1);
	#if (fldcnt >= 2)
		self.fld2 := if ( c = 2, L.fld2 + dataset([{R.fld_val,R.cnt}],%countrec%), L.fld2);
	#end
	#if (fldcnt >= 3)
		self.fld3 := if ( c = 3, L.fld3 + dataset([{R.fld_val,R.cnt}],%countrec%), L.fld3);
	#end
	#if (fldcnt >= 4)
		self.fld4 := if ( c = 4, L.fld4 + dataset([{R.fld_val,R.cnt}],%countrec%), L.fld4);
	#end
	#if (fldcnt >= 5)
		self.fld5 := if ( c = 5, L.fld5 + dataset([{R.fld_val,R.cnt}],%countrec%), L.fld5);
	#end
	#if (fldcnt >= 6)
		self.fld6 := if ( c = 6, L.fld6 + dataset([{R.fld_val,R.cnt}],%countrec%), L.fld6);
	#end	
	#if (fldcnt >= 7)
		self.fld7 := if ( c = 7, L.fld7 + dataset([{R.fld_val,R.cnt}],%countrec%), L.fld7);
	#end
end;

#uniquename(f1)
#uniquename(f1c)
#uniquename(f1c_pop)
#uniquename(f1count)
FieldStats.mac_stat_field(infile,fld1,ftyp1,%f1%,flg1,topcount,limitFld)

%commonrec% %f1count%(%f1% L) := transform
	self.rundate := %today%;
	self.fld_val := (string)L.fld1;
	self := L;
end;

#if (ftyp1 = 'string')
		%f1c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld1 != ''))}],%commonrec%);
#else 
	#if (ftyp1 = 'number')
		%f1c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld1 != 0))}],%commonrec%);
	#else
		%f1c_pop% := dataset([{%today%,'TOTAL POP',count(infile)}],%commonrec%);
	#end
#end

%f1c% := project(%f1%,%f1count%(LEFT)) + %f1c_pop%;

#uniquename(o1)
%o1% := denormalize(%parent%,%f1c%,left.rundate = right.rundate,%into_myrec%(LEFT,RIGHT,1));

#uniquename(f2)
#uniquename(o2)
#uniquename(f2c)
#uniquename(f2c_pop)
#uniquename(f2count)
#if (fldcnt >= 2)
	FieldStats.mac_stat_field(infile,fld2,ftyp2,%f2%,flg2,topcount,limitFld)
	%commonrec% %f2count%(%f2% L) := transform
		self.rundate := %today%;
		self.fld_val := (string)L.fld2;
		self := l;
	end;
	#if (ftyp2 = 'string')
		%f2c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld2 != ''))}],%commonrec%);
	#else 
		#if (ftyp2 = 'number')
		%f2c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld2 != 0))}],%commonrec%);
		#else
			%f2c_pop% := dataset([{%today%,'TOTAL POP',count(infile)}],%commonrec%);
		#end
	#end
	%f2c% := project(%f2%,%f2count%(LEFT)) + %f2c_pop%;
	%o2% := denormalize(%o1%,%f2c%,left.rundate = right.rundate,%into_myrec%(LEFT,RIGHT,2));
#else
	%o2% := %o1%;
#end

#uniquename(f3)
#uniquename(o3)
#uniquename(f3c)
#uniquename(f3c_pop)
#uniquename(f3count)
#if (fldcnt >= 3)
	FieldStats.mac_stat_field(infile,fld3,ftyp3,%f3%,flg3,topcount,limitFld)
	%commonrec% %f3count%(%f3% L) := transform
		self.rundate := %today%;
		self.fld_val := (string)L.fld3;
		self := l;
	end;
	#if (ftyp3 = 'string')
		%f3c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld3 != ''))}],%commonrec%);
	#else 
		#if (ftyp3 = 'number')
			%f3c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld3 != 0))}],%commonrec%);
		#else
			%f3c_pop% := dataset([{%today%,'TOTAL POP',count(infile)}],%commonrec%);
		#end
	#end
	%f3c% := project(%f3%,%f3count%(LEFT)) + %f3c_pop%;
	%o3%  := denormalize(%o2%,%f3c%,left.rundate = right.rundate,%into_myrec%(LEFT,RIGHT,3));
#else
	%o3% := %o2%;
#end

#uniquename(f4)
#uniquename(o4)
#uniquename(f4c)
#uniquename(f4c_pop)
#uniquename(f4count)
#if (fldcnt >= 4)
	FieldStats.mac_stat_field(infile,fld4,ftyp4,%f4%,flg4,topcount,limitFld)
	%commonrec% %f4count%(%f4% L) := transform
		self.rundate := %today%;
		self.fld_val := (string)L.fld4;
		self := l;
	end;
	#if (ftyp4 = 'string')
		%f4c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld4 != ''))}],%commonrec%);
	#else 
		#if (ftyp4 = 'number')
			%f4c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld4 != 0))}],%commonrec%);
		#else
			%f4c_pop% := dataset([{%today%,'TOTAL POP',count(infile)}],%commonrec%);
		#end
	#end
	%f4c% := project(%f4%,%f4count%(LEFT)) + %f4c_pop%;
	%o4%  := denormalize(%o3%,%f4c%,left.rundate = right.rundate,%into_myrec%(LEFT,RIGHT,4));
#else
	%o4% := %o3%;
#end

#uniquename(f5)
#uniquename(o5)
#uniquename(f5c)
#uniquename(f5c_pop)
#uniquename(f5count)
#if (fldcnt >= 5)
	FieldStats.mac_stat_field(infile,fld5,ftyp5,%f5%,flg5,topcount,limitFld)
	%commonrec% %f5count%(%f5% L) := transform
		self.rundate := %today%;
		self.fld_val := (string)L.fld5;
		self := l;
	end;
	#if (ftyp5 = 'string')
		%f5c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld5 != ''))}],%commonrec%);
	#else 
		#if (ftyp5 = 'number')
			%f5c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld5 != 0))}],%commonrec%);
		#else
			%f5c_pop% := dataset([{%today%,'TOTAL POP',count(infile)}],%commonrec%);
		#end
	#end
	%f5c% := project(%f5%,%f5count%(LEFT)) + %f5c_pop%;
	%o5%  := denormalize(%o4%,%f5c%,left.rundate = right.rundate,%into_myrec%(LEFT,RIGHT,5));
#else
	%o5% := %o4%;
#end

#uniquename(f6)
#uniquename(o6)
#uniquename(f6c)
#uniquename(f6c_pop)
#uniquename(f6count)
#if (fldcnt >= 6)
	FieldStats.mac_stat_field(infile,fld6,ftyp6,%f6%,flg6,topcount,limitFld)
	%commonrec% %f6count%(%f6% L) := transform
		self.rundate := %today%;
		self.fld_val := (string)L.fld6;
		self := l;
	end;
	#if (ftyp6 = 'string')
		%f6c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld6 != ''))}],%commonrec%);
	#else 
		#if (ftyp6 = 'number')
			%f6c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld6 != 0))}],%commonrec%);
		#else
			%f6c_pop% := dataset([{%today%,'TOTAL POP',count(infile)}],%commonrec%);
		#end
	#end
	%f6c% := project(%f6%,%f6count%(LEFT)) + %f6c_pop%;
	%o6%  := denormalize(%o5%,%f6c%,left.rundate = right.rundate,%into_myrec%(LEFT,RIGHT,6));
#else
	%o6% := %o5%;
#end

#uniquename(f7)
#uniquename(o7)
#uniquename(f7c)
#uniquename(f7c_pop)
#uniquename(f7count)
#if (fldcnt >= 7)
	FieldStats.mac_stat_field(infile,fld7,ftyp7,%f7%,flg7,topcount,limitFld)
	%commonrec% %f7count%(%f7% L) := transform
		self.rundate := %today%;
		self.fld_val := (string)L.fld7;
		self := l;
	end;
	#if (ftyp7 = 'string')
		%f7c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld7 != ''))}],%commonrec%);
	#else 
		#if (ftyp7 = 'number')
			%f7c_pop% := dataset([{%today%,'TOTAL POP',count(infile(fld7 != 0))}],%commonrec%);
		#else
			%f7c_pop% := dataset([{%today%,'TOTAL POP',count(infile)}],%commonrec%);
		#end
	#end
	%f7c% := project(%f7%,%f7count%(LEFT)) + %f7c_pop%;
	%o7%  := denormalize(%o6%,%f7c%,left.rundate = right.rundate,%into_myrec%(LEFT,RIGHT,7));
#else
	%o7% := %o6%;
#end


outf := %o7% : global;

endmacro;
