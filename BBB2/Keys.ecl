import doxie,BBB2;
export Keys :=
module

	export Member :=
	module
		
		export BDID :=
		module
			export Building 	 := index(Files().Base.Member.Building,	{bdid},	{Files().Base.Member.Building},	Keynames().Member.Bdid.Building);
			export Built		   := index(Files().Base.Member.Built,		{bdid},	{Files().Base.Member.Built},		Keynames().Member.Bdid.Built);
			export QA			     := index(Files().Base.Member.QA,			{bdid},	{Files().Base.Member.QA},			Keynames().Member.Bdid.QA);
			export Prod			   := index(Files().Base.Member.Prod,		{bdid},	{Files().Base.Member.Prod},		Keynames().Member.Bdid.Prod);
			export Father		   := index(Files().Base.Member.Father,		{bdid},	{Files().Base.Member.Father},		Keynames().Member.Bdid.Father);
			export Grandfather := index(Files().Base.Member.Grandfather,	{bdid},	{Files().Base.Member.Grandfather},Keynames().Member.Bdid.Grandfather);
			export Delete		   := index(Files().Base.Member.Delete,		{bdid},	{Files().Base.Member.Delete},		Keynames().Member.Bdid.Delete);
			export New			   := index(Files().Base.Member.New,			{bdid},	{Files().Base.Member.New},		Keynames().Member.Bdid.New);
		end;
		
	end;
	
	export NonMember :=
	module
		
		export BDID :=
		module
			export Building 	 := index(Files().Base.NonMember.Building,		{bdid},	{Files().Base.NonMember.Building},	Keynames().NonMember.Bdid.Building);
			export Built		   := index(Files().Base.NonMember.Built,		{bdid},	{Files().Base.NonMember.Built},		Keynames().NonMember.Bdid.Built);
			export QA			     := index(Files().Base.NonMember.QA,			{bdid},	{Files().Base.NonMember.QA},			Keynames().NonMember.Bdid.QA);
			export Prod			   := index(Files().Base.NonMember.Prod,			{bdid},	{Files().Base.NonMember.Prod},		Keynames().NonMember.Bdid.Prod);
			export Father		   := index(Files().Base.NonMember.Father,		{bdid},	{Files().Base.NonMember.Father},		Keynames().NonMember.Bdid.Father);
			export Grandfather := index(Files().Base.NonMember.Grandfather,	{bdid},	{Files().Base.NonMember.Grandfather},	Keynames().NonMember.Bdid.Grandfather);
			export Delete		   := index(Files().Base.NonMember.Delete,		{bdid},	{Files().Base.NonMember.Delete},		Keynames().NonMember.Bdid.Delete);
			export New			   := index(Files().Base.NonMember.New,			{bdid},	{Files().Base.NonMember.New},			Keynames().NonMember.Bdid.New);
		end;
		
	end;


end;