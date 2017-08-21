//Group and Propogate group id 
EXPORT proc_addGroup(dataset(layout_gongMaster) infile) := FUNCTION
		cleanUpdate := SORT(DISTRIBUTE(infile, (integer)seisintid), seisintid, LOCAL);

		//Group and Propogate group id 
		g_cleanUpdate:= group(cleanUpdate,seisintid,LOCAL);

		g_cleanUpdate t_propseq(g_cleanUpdate L, g_cleanUpdate R, integer c) := transform
		 self.group_seq	:= (string10)c;
		 self           := R;
		end;

		i_cleanUpdate := iterate(g_cleanUpdate,t_propseq(left,right,counter));
		u_cleanUpdate := ungroup(i_cleanUpdate);
		return u_cleanUpdate;
END;
