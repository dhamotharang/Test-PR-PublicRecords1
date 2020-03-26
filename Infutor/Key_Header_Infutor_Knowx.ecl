import doxie, dx_header, data_services;
//CCPA-101	- use the header layout from dx_module which should have 2 new CCPA fields
ds := PROJECT(infutor_header,TRANSFORM(dx_header.layout_key_header-[s_did],SELF:=LEFT;SELF:=[]));

export Key_Header_Infutor_Knowx := INDEX(ds, {unsigned6 s_did := did}, {ds}, data_services.data_location.prefix()+'thor_data400::key::header.adl.infutor.knowx_' + doxie.Version_SuperKey, OPT);
