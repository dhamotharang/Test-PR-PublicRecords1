IMPORT address,Business_Header,Business_Header_SS;

h := Business_Header.File_Business_Header_Base_for_keybuild;

look := distribute(project(h,transform(Layouts.File_Hdr_Biz_Keybuild_Layout,
	self.prim_name := left.prim_name,
	self.prim_range := left.prim_range,
	self.sec_range := left.sec_range,
	self.p7        := if((unsigned)left.phone = 0,'',intformat((unsigned)left.phone,10,1)[4..10]);
	self.p3        := if((unsigned)left.phone = 0,'',intformat((unsigned)left.phone,10,1)[1..3]);
	self.city_name := left.city,
	self.city_code := hash((qstring25)left.city),
	self.cname     := left.company_name,
	self.zip       := left.zip,
	self.indic     := if(left.company_name = '','',trim(datalib.companyclean(left.company_name)[1..40])),
	self.sec       := if(left.company_name = '','',trim(datalib.companyclean(left.company_name)[41..80])),
	self := left,
	self := [])),hash(bdid));

SlimRec :=
RECORD,maxlength(4096)
	look.rcid;
	look.city_name;
	string5 zip5 := if(look.zip = 0,'',intformat(look.zip,5,1));
END;

PreMultiCity := TABLE(look, SlimRec);

address.mac_multi_city(PreMultiCity,city_name,zip5,PostMultiCity)

//MyFields rejoin (SlimRec L, MyFields R) :=
Layouts.File_Hdr_Biz_Keybuild_Layout rejoin (SlimRec L, Layouts.File_Hdr_Biz_Keybuild_Layout R) :=
TRANSFORM
	SELF := L;
	SELF := R;
END;

j := JOIN(PostMultiCity, look, LEFT.rcid = RIGHT.rcid, rejoin(LEFT, RIGHT), HASH, LOCAL);

Business_Header_SS.layout_MakeCNameWords proj(j le, unsigned c) :=
TRANSFORM
	self.company_name := choose(c,le.cname,datalib.companyclean(le.cname)[1..40]);
	self.state := le.state;
	self.__filepos := le.rcid;
	self 			:= le;
END;

p := NORMALIZE(j(cname<>''), 2, proj(LEFT,COUNTER));
f := business_header_ss.Fn_MakeCNameWords(p);

j3 := distribute(j,hash(bdid));
f3 := distribute(f,hash(bdid));

final := join(j3,f3,left.rcid = right.bh_filepos,transform(Layouts.File_Hdr_Biz_Keybuild_Layout,
	self.word := right.word,
	self := left),local);

export File_business_header_fetch := final
	: persist(persistnames().FileBusinessHeaderFetch);