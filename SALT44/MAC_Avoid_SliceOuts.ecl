/*
	Takes a set of matches in Did1,Did2 format and eliminates all DIDs that are implicated in the Sliceouts (Slices) file
	It is debateable whether or not the preferred target really needs to be eliminated; the lift of giving the 'new free record' first
	choice in a new iteration may not be that high.
	For now we will assume we have time for perfection; we can hack it later.
	It IS assumed that the sliceout list is tiny enough to fit in memory
	I COULD reduce this to 1 join (and avoid some data reading) by combining the DID streams into 1 and doing a ,ALL join
	However - that does make by 'fit in memory' requirement 4x stricter ....
	My logic here is that other than in the very early iterations my match list is small - and in the very early iterations my slice list
	should be miniscule
*/
EXPORT MAC_Avoid_SliceOuts(Matches,Did1,Did2,RejectedDid,AcceptedDid,Slices,Outfile) := MACRO
#uniquename(j)
%j% := JOIN(Matches,Slices,LEFT.Did1=RIGHT.RejectedDid,TRANSFORM(LEFT),LEFT ONLY,LOOKUP);
#uniquename(j1)
%j1% := JOIN(%j%,Slices,LEFT.Did1=RIGHT.AcceptedDid,TRANSFORM(LEFT),LEFT ONLY,LOOKUP);
#uniquename(j2)
%j2% := JOIN(%j1%,Slices,LEFT.Did2=RIGHT.AcceptedDid,TRANSFORM(LEFT),LEFT ONLY,LOOKUP);
outfile := JOIN(%j2%,Slices,LEFT.Did2=RIGHT.RejectedDid,TRANSFORM(LEFT),LEFT ONLY,LOOKUP);
ENDMACRO;
