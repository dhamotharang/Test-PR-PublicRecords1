Import Bair_Composite, Bair;

build_type := false : STORED('build_type');

comp_fn := '~thor400_data::base::composite_public_safety_data_' + if(build_type, 'delta_building', 'full'); 

composite_base	:= Dataset(comp_fn, Bair.layouts.rCompositeBase,flat);
External_base		:= Project(composite_base, Transform(Layout_Classify_Ps,self:=left));
EXPORT File_Classify_PS := External_base;
