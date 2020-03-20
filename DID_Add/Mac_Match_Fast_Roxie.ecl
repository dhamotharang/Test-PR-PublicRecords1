/* before calling this, set a stored variable as below, with one of 3 values:
	dev = 40way dev roxie (windows)
	10way = 10way dev roxie (linux)
	lin_prod = 100way production roxie (linux)

	example:
	#stored('roxie_regression_system','dev');
*/


export Mac_Match_Fast_Roxie(infile,outfile,verify='\'BEST_ALL\'',appends='\'BEST_ALL,MAX_SSN\'',fz='\'ALL\'',glb='\'false\'',dedups='\'true\'',lookups = '\'false\'', livingsits = '\'false\'') := MACRO

// transform to new layout 
#UNIQUENAME(inLayout);
#UNIQUENAME(infileV2);
%inLayout% := didville.Layout_DID_InBatch_v2;
%infileV2% := project(infile, transform(didville.Layout_DID_InBatch_v2, 		
		self.relative_fname:= '',
  	self.relative_lname:='', self := left));

#uniquename(outLayout)
outLayout := DidVille.Layout_Did_OutBatch;
did_add.Mac_Match_Fast_Roxie_V2(%infileV2%, outfile1,verify,appends,fz,glb,dedups,lookups,livingsits);

outfile := project(outfile1, transform(DidVille.Layout_Did_OutBatch, self := left));
//'10.150.193.1-100:9876'
//'10.150.29.203-212:9876'
endmacro :DEPRECATED('Use DID_Add.Mac_Match_Fast_Roxie_V2 Instead');