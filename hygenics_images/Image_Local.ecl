import doxie,doxie_build,ut, hygenics_images, Images;

Images.MAC_Field_Declare()

did_set := IF(did_values<>[],did_values,SET(did_data,did));

type_check :=
MACRO
	ut.NNEQ(rtype_value, rtype)
ENDMACRO;

date_check :=
MACRO
	date = '' OR
	((date >= date_b_value OR date_b_value = '') AND
	(date <= date_e_value OR date_e_value = ''))
ENDMACRO;

state_check :=
MACRO
	ut.NNEQ(state_value, state)
ENDMACRO;

seq_check :=
MACRO
	(seq >= seq_b_value OR seq_b_value = -1) AND 
	(seq <= seq_e_value OR seq_e_value = -1) AND
	(seq = seq_value OR seq_value = -1)
ENDMACRO;

i	:= hygenics_images.key_images;
d	:= hygenics_images.key_did;

Images.Layout_ImageService idToCommon(i le) :=
TRANSFORM	
	self.did := 0;	
	SELF := le;
END;

pic := PROJECT(i(state_value = state, id_value = id, 
			  rtype_value = rtype, date_check(), seq_check()), idToCommon(LEFT));

Images.Layout_ImageService didToCommon(d le) :=
TRANSFORM		
	SELF := le;
	SELF.source := doxie_build.buildstate;
END;
pic_did := PROJECT(d((UNSIGNED)did_value = did, state_check(), type_check(), date_check(), seq_check()), didToCommon(LEFT));
pic_dids := PROJECT(d(did IN did_set, 					state_check(), type_check(), date_check(), seq_check()), didToCommon(LEFT));


export Image_Local := 
#if(doxie_build.buildstate NOT IN ['PUBLIC','FL'])
dataset([],Layout_ImageService);
#else
MAP(did_value 	!= '' =>	pic_did,
	did_set	!= [] =>	pic_dids,
	id_value	!= '' =>	pic,
	pic(false))(rtype<>'SO');
#end

