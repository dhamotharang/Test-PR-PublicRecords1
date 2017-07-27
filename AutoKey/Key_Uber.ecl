import doxie;


import ut;

export Key_Uber(string t) :=  MODULE


    shared vk_ds := DATASET([],Autokey.Layout_Uber.word_rec);
		shared ref_ds := DATASET([],Autokey.Layout_Uber.ref_rec);

    // note: "Dictionary" is a reserved word now.
    EXPORT _Dictionary := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0
															,INDEX(vk_ds, {word},{cnt,id,field_specificity}, TRIM(t)+'UberWords',OPT)
															,INDEX(vk_ds, {word},{cnt,id,field_specificity}, TRIM(t)+'UberWords' + '_' + doxie.Version_SuperKey,OPT));

		EXPORT Inversion := if ( stringlib.stringfind(trim(t),'::qa::',1) > 0
														,INDEX(ref_ds, {ref_ds},{}, TRIM(t)+'UberRefs',OPT)
														,INDEX(ref_ds, {ref_ds},{}, TRIM(t)+'UberRefs' + '_' + doxie.Version_SuperKey,OPT));


END;


