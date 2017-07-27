import doxie,doxie_build,ut, hygenics_images;

MAC_Field_Declare()

did_set := IF(did_values<>[],did_values,SET(did_data,did));

state_check :=
MACRO
	ut.NNEQ(state_value, state)
ENDMACRO;

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

seq_check :=
MACRO
	(seq >= seq_b_value OR seq_b_value = -1) AND 
	(seq <= seq_e_value OR seq_e_value = -1) AND
	(seq = seq_value OR seq_value = -1)
ENDMACRO;

i :=  Key_Images;
d :=  Key_DID;

Layout_ImageService idToCommon(i le) :=
TRANSFORM
	SELF := le;
	self.did := 0;
END;
pic := PROJECT(i(state_value = state, id_value = id, 
			  rtype_value = rtype, date_check(), seq_check()), idToCommon(LEFT));

Layout_ImageService didToCommon(d le) :=
TRANSFORM
	SELF := le;
	SELF.source := doxie_build.buildstate;
END;
pic_did := PROJECT(d((UNSIGNED)did_value = did, state_check(), type_check(), date_check(), seq_check()), didToCommon(LEFT));
pic_dids := PROJECT(d(did IN did_set, 					state_check(), type_check(), date_check(), seq_check()), didToCommon(LEFT));

crim_ids := hygenics_images.Image_Local;

so_ids := MAP(did_value 	!= '' =>	pic_did,
	did_set	!= [] =>	pic_dids,
	id_value	!= '' =>	pic,
	pic(false))(rtype='SO');

final_ids := so_ids + crim_ids;

export Image_Local := 
#if(doxie_build.buildstate NOT IN ['PUBLIC','FL'])
dataset([],Layout_ImageService);
#else
final_ids;
#end