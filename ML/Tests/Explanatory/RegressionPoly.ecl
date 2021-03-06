IMPORT ML;
R := RECORD
INTEGER rid;
INTEGER Recs;
REAL Time;
END;
d := DATASET([{1,50000,1.00},{2,500000,2.29}, {3,5000000,16.15},{4,25000000,80.2},
{5,50000000,163},{6,100000000,316},
{7,10,0.83},{8,1500000,5.63}],R);
ML.ToField(d,flds);
X := flds(number in [1]);
Y := flds(number in [2]);
P := ML.Regress_Poly_X(X,Y,2);
extrapo := sort(P.Extrapolated(X), id);
JOIN(Y,extrapo,LEFT.id=RIGHT.id
         ,transform({UNSIGNED id,REAL actual,REAL extrapo}
                     ,SELF.id:=LEFT.id
                     ,SELF.actual:=LEFT.value
                     ,SELF.extrapo:=RIGHT.value
          )
    );