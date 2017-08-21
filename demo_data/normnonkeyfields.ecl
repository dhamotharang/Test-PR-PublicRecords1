export normnonkeyfields(string datasetname, string filename,string filedate) := function

string infilename := regexreplace(datasetname+'_DATE',filename,filedate);

ds := demo_data.getkeyedcolumn(infilename);


string_rec1 := record
		string keyfields;
end;

norm_recs := record
string lname;
/*dataset(string_rec1) keycols1;
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
dataset(string_rec1) keycols20;*/
dataset(string_rec1) nonkeycols1;
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
dataset(string_rec1) nonkeycols20;
end;

norm_recs proj_me(ds l) := transform
	self.lname := l.logicalname;
	self := l;
	
end;

proj_out := project(ds,proj_me(left));

out_recs := record
	string lname;
	string keycol;
end;

out_recs norm_me(proj_out l,string_rec1 r) := transform
	self.lname := l.lname;
	self.keycol := r.keyfields;
end;




// nonkeyed

nonnorm_out1 := normalize(proj_out,left.nonkeycols1,norm_me(left,right));
nonnorm_out2 := normalize(proj_out,left.nonkeycols2,norm_me(left,right));
nonnorm_out3 := normalize(proj_out,left.nonkeycols3,norm_me(left,right));
nonnorm_out4 := normalize(proj_out,left.nonkeycols4,norm_me(left,right));
nonnorm_out5 := normalize(proj_out,left.nonkeycols5,norm_me(left,right));
nonnorm_out6 := normalize(proj_out,left.nonkeycols6,norm_me(left,right));
nonnorm_out7 := normalize(proj_out,left.nonkeycols7,norm_me(left,right));
nonnorm_out8 := normalize(proj_out,left.nonkeycols8,norm_me(left,right));
nonnorm_out9 := normalize(proj_out,left.nonkeycols9,norm_me(left,right));
nonnorm_out10 := normalize(proj_out,left.nonkeycols10,norm_me(left,right));
nonnorm_out11 := normalize(proj_out,left.nonkeycols11,norm_me(left,right));
nonnorm_out12 := normalize(proj_out,left.nonkeycols12,norm_me(left,right));
nonnorm_out13 := normalize(proj_out,left.nonkeycols13,norm_me(left,right));
nonnorm_out14 := normalize(proj_out,left.nonkeycols14,norm_me(left,right));
nonnorm_out15 := normalize(proj_out,left.nonkeycols15,norm_me(left,right));
nonnorm_out16 := normalize(proj_out,left.nonkeycols16,norm_me(left,right));
nonnorm_out17 := normalize(proj_out,left.nonkeycols17,norm_me(left,right));
nonnorm_out18 := normalize(proj_out,left.nonkeycols18,norm_me(left,right));
nonnorm_out19 := normalize(proj_out,left.nonkeycols19,norm_me(left,right));
nonnorm_out20 := normalize(proj_out,left.nonkeycols20,norm_me(left,right));

nonfullds := nonnorm_out1 + nonnorm_out2 + nonnorm_out3 + nonnorm_out4
		+ nonnorm_out5 + nonnorm_out6 + nonnorm_out7
		+ nonnorm_out8 + nonnorm_out9 + nonnorm_out10
		+ nonnorm_out11 + nonnorm_out12 + nonnorm_out13
		+ nonnorm_out14 + nonnorm_out15 + nonnorm_out16
		+ nonnorm_out17 + nonnorm_out18 + nonnorm_out19
		+ nonnorm_out20;


// normalize nonkeyed records

nonnormalize_recs := record
	string infilename;
	string nonkeyedfields;
end;

nondummyds := dataset([{infilename,''}],nonnormalize_recs);

nonnormalize_recs getnonkeyfields(nondummyds l,nonfullds r) := transform
self.infilename := l.infilename;
self.nonkeyedfields := l.nonkeyedfields + ',' + r.keycol;

end;

nonnormalize_out := denormalize(nondummyds,nonfullds,left.infilename = right.lname,getnonkeyfields(left,right));

return nonnormalize_out(nonkeyedfields <> '');

end;