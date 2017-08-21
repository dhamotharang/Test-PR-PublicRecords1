import BuildFax,ut;

EXPORT ProcessBuildFax(Layout_BuildFax.input_rec_online input) := FUNCTION

currdate := stringlib.GetDateYYYYMMDD();

// Calculate ages with cleand address
calcinput  := PROJECT(DATASET(input),TRANSFORM(Layout_BuildFax.seq_input_rec,self:=left,self:=[]));
calcrslts  := CalcAges(calcinput);

RETURN calcrslts;
END;



