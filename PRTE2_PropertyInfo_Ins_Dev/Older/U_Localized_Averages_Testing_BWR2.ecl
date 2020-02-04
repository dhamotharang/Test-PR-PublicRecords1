IMPORT PRTE2_PropertyInfo;

MyRec := RECORD
STRING Value1;
STRING Value2;
STRING Value3;
END;

inDS := DATASET([{'C','G','A'},{'C','C','A'},{'A','X','A'},{'C','C','A'},{'A','X','A'},{'C','C','A'},{'A','X','A'},{'C','C','A'},{'A','X','A'}],MyRec);
SomeData := inDS+inDS+inDS;

SomeData trx1(SomeData L, UNSIGNED RND) := TRANSFORM
		SELF.Value1 := PRTE2_PropertyInfo.U_Localized_Averages_Sets.BUILDING_SQ_FT_FROM(RND);
		SELF := L;
END;
SomeData trx2(SomeData L) := TRANSFORM
		SELF.Value2 := L.Value1;
		SELF.Value3 := PRTE2_PropertyInfo.U_Localized_Averages_Sets.NUM_OF_ROOMS_RANDOM(L.Value1);
		SELF := L;
END;

SomeDS2 := Project(SomeData,trx1(LEFT,RANDOM()));
DS := Project(SomeDS2,trx2(LEFT));
OUTPUT(DS);