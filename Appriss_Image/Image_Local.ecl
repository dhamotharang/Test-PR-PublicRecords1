import doxie,doxie_build,ut, Appriss_Image, Images;

Images.MAC_Field_Declare()

did_set := IF(did_values<>[],did_values,SET(did_data,did));

type_check :=
MACRO
	ut.NNEQ(rtype_value, rtype)
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

i := Appriss_Image.Key_Images;
d := Appriss_Image.Key_DID;

Images.Layout_ImageService idToCommon(i le) :=
TRANSFORM	
	self.did := 0;	
	self.id := le.booking_sid;
	SELF := le;
END;

pic := PROJECT(i(id_value = booking_sid, 
			  rtype_value = rtype, seq_check(), state_check()), idToCommon(LEFT));

Images.Layout_ImageService didToCommon(d le) :=
TRANSFORM	
	SELF.source := doxie_build.buildstate;	
	self.id := le.booking_sid;
	SELF := le;
END;
pic_did := PROJECT(d((UNSIGNED)did_value = did, state_check(), type_check(), seq_check()), didToCommon(LEFT));
pic_dids := PROJECT(d(did IN did_set, 					state_check(), type_check(), seq_check()), didToCommon(LEFT));


export Image_Local := 
#if(doxie_build.buildstate NOT IN ['PUBLIC','FL'])
dataset([],Layout_ImageService);
#else
MAP(did_value 	!= '' =>	pic_did,
	did_set	!= [] =>	pic_dids,
	id_value	!= '' =>	pic,
	pic(false));
#end

