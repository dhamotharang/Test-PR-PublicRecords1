IMPORT ML.Mat AS ML_Mat;
IMPORT ML.Mat.Types AS Types;



Produce_Random () := FUNCTION

G := 1000000;

R := (RANDOM()%G) / (REAL8)G;

RETURN R;

END;



//return a matrix with "Nrows" number of rows and "NCols" number of cols. The  matrix is initilized with random numbers
EXPORT RandMat (UNSIGNED Nrows, UNSIGNED NCols, REAL8 density=1.0) := FUNCTION


ONE := DATASET ([{1,1,0}],Types.Element);

Types.Element RandomizeMat(Types.Element l, UNSIGNED4 C) := TRANSFORM, SKIP(Produce_Random() > density)
  r1 := Produce_Random();
  SELF.x := ((C-1) DIV NCols) + 1;
  SELF.y := ((C-1) % NCols) + 1;
  SELF.Value := r1;
END;

Result := NORMALIZE(ONE, Nrows*NCols, RandomizeMat(LEFT,COUNTER));



RETURN Result;

END;