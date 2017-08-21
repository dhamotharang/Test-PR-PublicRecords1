#OPTION('multiplePersistInstances',FALSE);
import Business_HeaderV2,Gong_v2;

export As_Business_Contact(
	
	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) :=
module

	shared basefile := if(pUsingInBusinessHeader	,files().base.BusinessHeader										,files().base.QA											);
	shared gongfile := if(pUsingInBusinessHeader	,Gong_v2.Files().base.gongmaster.BusinessHeader	,Gong_v2.Files().base.gongmaster.root	);
	
	export Jigsaw := fAs_Business_Contact_Jigsaw(basefile,gongfile) : persist(persistnames().AsBusinessContact);

	export all :=
	sequential(

		 output(enth(Jigsaw,1000),named('As_Business_Contact_Jigsaw'),all)
	
	);
	
end;