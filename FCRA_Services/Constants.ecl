EXPORT Constants :=
MODULE

  EXPORT Limits :=
  MODULE
    EXPORT UNSIGNED1 MaxBankruptcyPerDID := 50;
    EXPORT UNSIGNED1 MaxLiensPerDID      := 50;
    EXPORT UNSIGNED2 MaxBankruptcies     := 1000;
    EXPORT UNSIGNED2 MaxLiens            := 1000;
    EXPORT UNSIGNED2 MaxPropPerDID       := 100;
    EXPORT UNSIGNED2 MaxPropSearchPerFID := 50;
    EXPORT UNSIGNED2 MaxOverrides        := 100;
  END;
 
END;