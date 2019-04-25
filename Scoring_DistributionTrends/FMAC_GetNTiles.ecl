// EXPORT FMAC_GetNTiles() := FUNCTIONMACRO
EXPORT FMAC_GetNTiles(filename_in , layout, mname_in ,date_f) := FUNCTIONMACRO
	IMPORT Scoring_DistributionTrends.Constants as C;

		filename := filename_in + date_f + C.FileTag;
		ds := dataset(filename,layout,thor);
	
	ML.Types.NumericField XF(ds L, integer Cn) := TRANSFORM
		 SELF.id := Cn;
		 // SELF.number := (integer)L.Date;
		 SELF.number := (integer)date_f;
		 // SELF.value := (integer)L.Score;
		 SELF.value := (integer)l.#expand(mname_in);
	END;
	P := PROJECT(ds,XF(LEFT,COUNTER));
	AVG2(REAL L, REAL R) := AVE(L,R);
	Simples := ML.FieldAggregates(P).Simple;
	Quarts := ML.FieldAggregates(P).NTileRanges(10);

	layJoin := RECORD
		RECORDOF(Quarts);
		RECORDOF(Simples)-number;
	END;

	dsJoin := join(Simples,Quarts,left.number = right.number,transform(layJoin,self:=left;self:=right;));

out := if(STD.File.FileExists(filename),dsJoin);


	RETURN out;

ENDMACRO;