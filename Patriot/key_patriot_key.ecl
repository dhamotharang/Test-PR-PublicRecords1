import doxie;

f := file_patriot_keybuild;

export key_patriot_key := INDEX(f,{pty_key},{f},'~thor_data400::key::patriot_key_'+doxie.Version_SuperKey);