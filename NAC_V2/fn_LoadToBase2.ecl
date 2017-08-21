/*
Convert NAC1 Load format to Base2 format
*/

EXPORT fn_LoadToBase2(DATASET(Layouts.vLoad) f0, string Version) := FUNCTION

	NAC_V2.Layouts.base tr(f0 l) := transform
			self.FileName := l.fn;
			sub:=stringlib.stringfind(l.fn,'20',1);
			sub2:=stringlib.stringfind(l.fn,'.dat',1)-6;
			self.ProcessDate := (unsigned)Version;
			NCF_FileDate := (unsigned)l.fn[sub..sub+7];
			NCF_FileTime := l.fn[sub2..sub2+5];
			self.NCF_FileDate := if(NCF_FileDate>20130000,NCF_FileDate,self.ProcessDate);
			self.NCF_FileTime :=map(
													NCF_FileTime in ['0000.a','0000.s','0000.o','0000.n'] =>'999999'
													,NCF_FileTime ='5527.a' =>'195527'
													,NCF_FileTime ='1911.a' =>'091911'
													,NCF_FileTime ='0359.s' =>'140359'
													,NCF_FileTime ='2744.s' =>'102744'
													,NCF_FileTime ='0033.o' =>'140033'
													,NCF_FileTime ='1935.o' =>'111935'
													,NCF_FileTime
													);

			self.Case_Email:=stringlib.stringtouppercase(l.Case_Email);
			self.Case_County_Parish_Name:=stringlib.stringtouppercase(l.Case_County_Parish_Name);
			self.Client_Email:=stringlib.stringtouppercase(l.Client_Email);

			self.State_Contact_Name:=stringlib.stringtouppercase(l.State_Contact_Name);
			self.State_Contact_Email:=stringlib.stringtouppercase(l.State_Contact_Email);

			self:=l;
			self:=[];
	END;
	
	f1 := project(f0, tr(LEFT));		// convert load to base1
	f2 := NAC_V2.fn_Base1ToBase2(f1);
	
	seed := max(NAC_v2.Files().Base2,PrepRecSeq)+1;
	f3 := Nac_V2.Build_Base2(f2,Version,seed);

	return f3;

END;