export FCRA_WatercraftKeys := macro
	output(choosen(watercraft.key_watercraft_did(true),10));
	output(choosen(watercraft.key_watercraft_sid(true),10));
    output(choosen(watercraft.key_watercraft_cid(true),10));
	output(choosen(watercraft.key_watercraft_wid(true),10));
	output(choosen(doxie.key_watercraft_did_FCRA,10));
	output(choosen(doxie.key_watercraft_sid_FCRA,10));

endmacro;