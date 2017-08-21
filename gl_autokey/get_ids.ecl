import autokeyb2,doxie;
export get_IDs(
	string autokey_keyname,
	string autokey_typestr,
	set of string1 get_skip_set,
	boolean useAllLookups,
	gl_autokey.autokey_interfaces.ids in_parms) :=
		function

			idsrec := {unsigned6 ID, boolean isDID := false, boolean isBDID := false, boolean IsFake};
			 
			idsrec makedids(doxie.layout_references l) := transform
				self.isDID := true;
				self.isFake := autokeyb2.isfakeid(l.DID,autokey_typestr);
				self.ID := l.DID;
			end;
			
			dids := project(gl_autokey.get_dids(autokey_keyname,get_skip_set,useAllLookups,in_parms), makedids(left)); 

			idsrec makebdids(doxie.layout_ref_bdid l) := transform
				self.isBDID := true;
				self.isFake := autokeyb2.isfakeid(l.BDID,autokey_typestr);
				self.ID := l.BDID;
			end;

			bdids := if('B' not in get_skip_set, project(gl_autokey.get_bdids(autokey_keyname,get_skip_set,in_parms), makebdids(left))); 
			 
			//ids := dids + bdids;
			ids := dids+bdids;

			return ids;

		END;