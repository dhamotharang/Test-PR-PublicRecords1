import corrections, crim_common;
			
df := hygenics_crim.Out_Moxie_DOC_Punishment;

	hygenics_crim.layout_crimpunishment into(df L) := transform
		self.orig_state 										:= L.source_file[1..2];
		self.conviction_override_date				:= '';
		self.conviction_override_date_type	:= '';
		self.fcra_date				              := '';
		self.fcra_date_type	                := '';
		self := l;
		
	end;

export AllPunishments := project(df,into(LEFT)):persist('~thor40_241::persist::doc_punishments');