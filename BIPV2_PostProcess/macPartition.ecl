import BIPV2;
EXPORT macPartition(
   Infile
  ,idName 
	,outFileFreeSourced
	,outFileProbationOnly
) :=
macro

#uniquename(Infile_Dist)
#uniquename(marked)
#uniquename(frees)

%Infile_Dist% := distribute(infile, hash(idName));
%frees% := dedup(sort(%Infile_Dist%(BIPV2.mod_sources.srcIsCitizen(source)), idname, local), idname, local);

shared %marked% := 
join(
	%Infile_Dist%, 
	%frees%,
	left.idName = right.idName,
	transform(
		{Infile, boolean Free},
		self.Free := right.idName > 0,
		self := left
	)
	,local
	,left outer
);

// output(enth(%marked%, 100), named('marked'));
shared outFileFreeSourced		:= project(%marked%(    Free), recordof(Infile));
shared outFileProbationOnly	:= project(%marked%(not Free), recordof(Infile));

ENDmacro;