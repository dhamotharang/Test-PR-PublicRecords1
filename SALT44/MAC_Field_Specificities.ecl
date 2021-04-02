// Assumes CNT field contains count
export MAC_Field_Specificities(infile,outfile) := MACRO
#uniquename(atot)
//%atot% := sum(infile,cnt);
%atot% := TotalClusters; // More accurate total cluster count
#uniquename(fsr)
%fsr% := record
  infile;
  real8 field_specificity := log( (real8)%atot% / (real8)infile.cnt ) / log(2);
  end;
outfile := table(infile,%fsr%);
  ENDMACRO;
