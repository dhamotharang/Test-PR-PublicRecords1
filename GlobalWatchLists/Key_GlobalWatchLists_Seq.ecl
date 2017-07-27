Import doxie;

p := DEDUP(File_GlobalWatchLists_Keybuild,pty_key,orig_vessel_name,fname,mname,lname,cname,all);

l :=
RECORD
            unsigned4 seq;
            unsigned4 source;
            p.pty_key;
            p.first_name;
            p.last_name;
            p.cname;
			unsigned4 max_seq;
END;
l seq(p le, integer i) :=
TRANSFORM
	SELF.source := IF(le.pty_key[1..4]='OFAC',1,2);
	SELF.seq := i;
	SELF.max_seq := i;
	SELF.first_name := Stringlib.StringToUppercase(le.first_name);
	SELF.last_name := Stringlib.StringToUppercase(le.last_name);
	SELF.cname := IF(le.orig_vessel_name<>'',Stringlib.StringToUppercase(le.orig_vessel_name),le.cname);
	SELF := le;
END;

proj := PROJECT(p,seq(LEFT, counter));
srt := SORT(proj,-seq);

l iterator(l le, l ri) :=
TRANSFORM
	SELF.max_seq := IF(le.max_seq=0,ri.max_seq,le.max_seq);
	SELF := ri;
END;

iter := ITERATE(srt, iterator(LEFT,RIGHT));

Export Key_GlobalWatchLists_seq := INDEX(iter,{seq},{iter},'~thor_data400::key::globalwatchlists::seq_'+doxie.Version_SuperKey);