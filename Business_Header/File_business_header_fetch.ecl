IMPORT Business_Header,address,Business_Header_SS;
EXPORT File_business_header_fetch(

	 DATASET(Business_Header.Layout_Business_Header_Base_Plus_Orig)	pbh						= Business_Header.File_Business_Header_Base_for_keybuild
	,STRING																					                pPersistname	= Business_Header.persistnames().FileBusinessHeaderFetch

) :=
FUNCTION

h := pbh;

look := PROJECT(h,TRANSFORM(Business_Header.Layouts.File_Hdr_Biz_Keybuild_Layout,
	SELF.prim_name := LEFT.prim_name,
	SELF.prim_range := LEFT.prim_range,
	SELF.sec_range := LEFT.sec_range,
	SELF.p7        := IF((UNSIGNED)LEFT.phone = 0,'',INTFORMAT((UNSIGNED)LEFT.phone,10,1)[4..10]);
	SELF.p3        := IF((UNSIGNED)LEFT.phone = 0,'',INTFORMAT((UNSIGNED)LEFT.phone,10,1)[1..3]);
	SELF.city_name := LEFT.city,
	SELF.city_code := HASH((QSTRING25)LEFT.city),
	SELF.cname     := LEFT.company_name,
	SELF.zip       := LEFT.zip,
	SELF.indic     := IF(LEFT.company_name = '','',trim(datalib.companyclean(LEFT.company_name)[1..40])),
	SELF.sec       := IF(LEFT.company_name = '','',trim(datalib.companyclean(LEFT.company_name)[41..80])),
	SELF := LEFT,
	SELF := []));

SlimRec :=
RECORD,MAXLENGTH(4096)
	look.rcid;
	look.city_name;
	STRING5 zip5 := IF(look.zip = 0,'',INTFORMAT(look.zip,5,1));
END;

PreMultiCity := TABLE(look, SlimRec);

address.mac_multi_city(PreMultiCity,city_name,zip5,PostMultiCity)

//MyFields rejoin (SlimRec L, MyFields R) :=
Business_Header.Layouts.File_Hdr_Biz_Keybuild_Layout rejoin (SlimRec L, Business_Header.Layouts.File_Hdr_Biz_Keybuild_Layout R) :=
TRANSFORM
	SELF := L;
	SELF := R;
END;

j := JOIN(PostMultiCity, look, LEFT.rcid = RIGHT.rcid, rejoin(LEFT, RIGHT), HASH);

Business_Header_SS.layout_MakeCNameWords proj(j le, UNSIGNED c) :=
TRANSFORM
	SELF.company_name := CHOOSE(c,le.cname,datalib.companyclean(le.cname));
	SELF.state := le.state;
	SELF.__filepos := le.rcid;
  SELF.bdid := le.rcid;
	SELF 			:= le;
END;

p1 := PROJECT(j(cname<>''), proj(LEFT,1));
p2 := PROJECT(j(cname<>''), proj(LEFT,2));
f1 := business_header_ss.Fn_MakeCNameWords(p1);
f2 := business_header_ss.Fn_MakeCNameWords(p2);

j3 := DISTRIBUTE(j,rcid);
f3 := DISTRIBUTE(f1 + f2,bh_filepos);

final := JOIN(j3,f3,LEFT.rcid = RIGHT.bh_filepos,TRANSFORM(Business_Header.Layouts.File_Hdr_Biz_Keybuild_Layout,
	SELF.word := RIGHT.word,
	SELF := LEFT),LOCAL)
	: PERSIST(pPersistname)
	;
RETURN final;
END;