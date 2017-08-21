import Business_Header,address,Business_Header_SS;
export File_business_header_fetch(

	 dataset(Layout_Business_Header_Base_Plus_Orig)	pbh						= Business_Header.File_Business_Header_Base_for_keybuild
	,string																					pPersistname	= persistnames().FileBusinessHeaderFetch

) :=
function

h := pbh;

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

j := JOIN(PostMultiCity, look, LEFT.rcid = RIGHT.rcid, rejoin(LEFT, RIGHT), HASH);

Business_Header_SS.layout_MakeCNameWords proj(j le, unsigned c) :=
TRANSFORM
	self.company_name := choose(c,le.cname,datalib.companyclean(le.cname));
	self.state := le.state;
	self.__filepos := le.rcid;
  self.bdid := le.rcid;
	self 			:= le;
END;

p1 := PROJECT(j(cname<>''), proj(LEFT,1));
p2 := PROJECT(j(cname<>''), proj(LEFT,2));
f1 := business_header_ss.Fn_MakeCNameWords(p1);
f2 := business_header_ss.Fn_MakeCNameWords(p2);

j3 := distribute(j,rcid);
f3 := distribute(f1 + f2,bh_filepos);

final := join(j3,f3,left.rcid = right.bh_filepos,transform(Layouts.File_Hdr_Biz_Keybuild_Layout,
	self.word := right.word,
	self := left),local)
	: persist(pPersistname)
	;
return final;
end;