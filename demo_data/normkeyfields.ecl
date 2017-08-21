export normkeyfields(string datasetname, string filename,string filedate) := function

string infilename := regexreplace(datasetname+'_DATE',filename,filedate);

ds := demo_data.getkeyedcolumn(infilename);


string_rec1 := record
		string keyfields;
end;

norm_recs := record
string lname;
dataset(string_rec1) keycols1;
dataset(string_rec1) keycols2;
dataset(string_rec1) keycols3;
dataset(string_rec1) keycols4;
dataset(string_rec1) keycols5;
dataset(string_rec1) keycols6;
dataset(string_rec1) keycols7;
dataset(string_rec1) keycols8;
dataset(string_rec1) keycols9;
dataset(string_rec1) keycols10;
dataset(string_rec1) keycols11;
dataset(string_rec1) keycols12;
dataset(string_rec1) keycols13;
dataset(string_rec1) keycols14;
dataset(string_rec1) keycols15;
dataset(string_rec1) keycols16;
dataset(string_rec1) keycols17;
dataset(string_rec1) keycols18;
dataset(string_rec1) keycols19;
dataset(string_rec1) keycols20;
/*dataset(string_rec1) nonkeycols1;
dataset(string_rec1) nonkeycols2;
dataset(string_rec1) nonkeycols3;
dataset(string_rec1) nonkeycols4;
dataset(string_rec1) nonkeycols5;
dataset(string_rec1) nonkeycols6;
dataset(string_rec1) nonkeycols7;
dataset(string_rec1) nonkeycols8;
dataset(string_rec1) nonkeycols9;
dataset(string_rec1) nonkeycols10;
dataset(string_rec1) nonkeycols11;
dataset(string_rec1) nonkeycols12;
dataset(string_rec1) nonkeycols13;
dataset(string_rec1) nonkeycols14;
dataset(string_rec1) nonkeycols15;
dataset(string_rec1) nonkeycols16;
dataset(string_rec1) nonkeycols17;
dataset(string_rec1) nonkeycols18;
dataset(string_rec1) nonkeycols19;
dataset(string_rec1) nonkeycols20;*/
end;

norm_recs proj_me(ds l) := transform
	self.lname := l.logicalname;
	self := l;
	
end;

proj_out := project(ds,proj_me(left));

out_recs := record
	string lname;
	string keycol;
	integer cnt;
end;


out_recs norm_me(proj_out l,string_rec1 r,integer c) := transform
	self.lname := l.lname;
	self.keycol := r.keyfields;
	self.cnt := c;
end;

norm_out1 := normalize(proj_out,left.keycols1,norm_me(left,right,counter));
norm_out2 := normalize(proj_out,left.keycols2,norm_me(left,right,counter));
norm_out3 := normalize(proj_out,left.keycols3,norm_me(left,right,counter));
norm_out4 := normalize(proj_out,left.keycols4,norm_me(left,right,counter));
norm_out5 := normalize(proj_out,left.keycols5,norm_me(left,right,counter));
norm_out6 := normalize(proj_out,left.keycols6,norm_me(left,right,counter));
norm_out7 := normalize(proj_out,left.keycols7,norm_me(left,right,counter));
norm_out8 := normalize(proj_out,left.keycols8,norm_me(left,right,counter));
norm_out9 := normalize(proj_out,left.keycols9,norm_me(left,right,counter));
norm_out10 := normalize(proj_out,left.keycols10,norm_me(left,right,counter));
norm_out11 := normalize(proj_out,left.keycols11,norm_me(left,right,counter));
norm_out12 := normalize(proj_out,left.keycols12,norm_me(left,right,counter));
norm_out13 := normalize(proj_out,left.keycols13,norm_me(left,right,counter));
norm_out14 := normalize(proj_out,left.keycols14,norm_me(left,right,counter));
norm_out15 := normalize(proj_out,left.keycols15,norm_me(left,right,counter));
norm_out16 := normalize(proj_out,left.keycols16,norm_me(left,right,counter));
norm_out17 := normalize(proj_out,left.keycols17,norm_me(left,right,counter));
norm_out18 := normalize(proj_out,left.keycols18,norm_me(left,right,counter));
norm_out19 := normalize(proj_out,left.keycols19,norm_me(left,right,counter));
norm_out20 := normalize(proj_out,left.keycols20,norm_me(left,right,counter));

fullds := norm_out1 + norm_out2 + norm_out3 + norm_out4
		+ norm_out5 + norm_out6 + norm_out7
		+ norm_out8 + norm_out9 + norm_out10
		+ norm_out11 + norm_out12 + norm_out13
		+ norm_out14 + norm_out15 + norm_out16
		+ norm_out17 + norm_out18 + norm_out19
		+ norm_out20;


// normalize keyed records

normalize_recs := record
	string infilename;
	string keyedfields;
end;

dummyds := dataset([{infilename,''}],normalize_recs);

normalize_recs getkeyfields(dummyds l,fullds r) := transform
self.infilename := l.infilename;
self.keyedfields := l.keyedfields + ',' + r.keycol;

end;

normalize_out := denormalize(dummyds,fullds,left.infilename = right.lname,getkeyfields(left,right));

		
return normalize_out;
end;