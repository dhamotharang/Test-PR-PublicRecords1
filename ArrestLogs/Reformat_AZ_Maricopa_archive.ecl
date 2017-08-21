import arrestlogs;

p	:= Arrestlogs.file_AZ_Maricopa_archive;

fMaricopa := p(trim(p.Last_Name,left,right)<>'Last name' and
			   trim(p.First_Name,left,right)<>'First name' and
			   trim(p.Middle_Name,left,right)<>'Middle name' and
			   trim(p.Middle_Name,left,right)<>'MALE' and
			   trim(p.Middle_Name,left,right)<>'FEMALE' and
			   trim(p.ID,left,right)<>'ID' and
			   trim(p.Race,left,right)<>'Race' and
			   trim(p.Hair_Color,left,right)<>'Hair Color' and
			   trim(p.Eye_Color,left,right)<>'Eye Color' and
			   trim(p.Weight,left,right)<>'Weight');

arrestlogs.layout_AZ_Maricopa_new tMaricopa(fMaricopa input) := Transform

self.ID 			:= input.ID;
self.Name 			:= trim(input.Last_Name,left,right)+' '+trim(input.First_Name,left,right)+' '+trim(input.Middle_Name,left,right);
self.Date_Booked 	:= input.Booked_Dt;
self.Sex 			:= input.Sex;
self.Race 			:= input.Race;
self.DOB 			:= input.DOB;
self.Height 		:= input.Height;
self.Weight 		:= input.Weight;
self.Eye 			:= input.Eye_Color;
self.Hair 			:= input.Hair_Color;
self.Photo 			:= input.Photo;
self.Cnt 			:= input.Cnt;

end;

pMaricopa 	:= project(fMaricopa,tMaricopa(left));

export Reformat_AZ_Maricopa_archive := pMaricopa;