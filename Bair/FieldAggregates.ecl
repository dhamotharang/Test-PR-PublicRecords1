IMPORT * FROM $;

EXPORT FieldAggregates(DATASET(Types.NumericField) d) := MODULE

SingleField := RECORD
  d.number;
  Types.t_FieldStr minval  :=MIN(GROUP,d.Value);
  Types.t_FieldStr maxval  :=MAX(GROUP,d.Value);
  Types.t_FieldStr countval:=COUNT(GROUP);
END;

EXPORT Simple:=TABLE(d,SingleField,Number,FEW);

RankableField := RECORD
  d;
  UNSIGNED Pos := 0;
  END;

T := TABLE(SORT(D,Number,Value,skew(1)),RankableField);

Utils.mac_SequenceInField(T,Number,Pos,P)

EXPORT SimpleRanked := P;

MR := RECORD
  SimpleRanked.Number;
  SimpleRanked.Value;
  Types.t_FieldStr Pos := AVE(GROUP,SimpleRanked.Pos);
  UNSIGNED valcount:=COUNT(GROUP);
END;

SHARED T := TABLE(SimpleRanked,MR,Number,Value);

dModeVals:=TABLE(T,{number;UNSIGNED modeval:=MAX(GROUP,valcount);},number,FEW);
EXPORT Modes:=JOIN(T,dModeVals,LEFT.number=RIGHT.number AND LEFT.valcount=RIGHT.modeval,
                   TRANSFORM({TYPEOF(T.number) number;TYPEOF(T.value) mode; UNSIGNED cnt},
                             SELF.cnt := LEFT.valcount;SELF.mode:=LEFT.value;SELF:=LEFT;),LOOKUP);

EXPORT Cardinality:=TABLE(T,{number;UNSIGNED cardinality:=COUNT(GROUP);},number);

AveRanked := RECORD
  d;
  Types.t_FieldStr Pos;
  END;

AveRanked Into(D le,T ri) := TRANSFORM
  SELF.Pos := ri.pos;
  SELF := le;
  END;

EXPORT RankedInput := JOIN(D,T,
                          LEFT.Number=RIGHT.Number AND LEFT.Value = RIGHT.Value,
                          Into(LEFT,RIGHT),skew(1));

{RECORDOF(RankedInput);Types.t_Discrete ntile;}
tNTile(RankedInput L,Simple R,Types.t_Discrete n):=TRANSFORM
  SELF.ntile:=IF(L.pos=R.countval,n,(Types.t_Discrete)(n*(((Types.t_FieldReal)L.pos-1)/(Types.t_FieldReal)R.countval))+1);
  SELF:=L;
END;
EXPORT NTiles(Types.t_Discrete n):=JOIN(RankedInput,
                                        Simple,LEFT.number=RIGHT.number,
                                        tNTile(LEFT,RIGHT,n),LOOKUP);
EXPORT NTileRanges(Types.t_Discrete n):=TABLE(NTiles(n),
                    {number;ntile;Types.t_FieldStr Min:=MIN(GROUP,value);
                     Types.t_FieldStr Max:=MAX(GROUP,value);
                     UNSIGNED cnt:=COUNT(GROUP);},number,ntile,skew(1));

END;
