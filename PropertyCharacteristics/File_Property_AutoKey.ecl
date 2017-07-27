import	Address,ut;

PropertyCharacteristics.Layout_Property_AutoKey	tReformat(PropertyCharacteristics.Files.Base.Property	pInput)	:=
transform
	self.Property_RawAID	:=	pInput.property_raw_aid;
	self									:=	pInput;
end;

export	File_Property_AutoKey	:=	project(PropertyCharacteristics.Files.Base.Property,tReformat(left));