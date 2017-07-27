import AutoKeyI, doxie, RoxieKeyBuild, ut;

export MAutokeyBuild := MODULE

	export LatLong := MODULE

		//***** DEFINE THE INTERFACE
		export params := AutoKeyI.InterfaceForBuild;

		export nameFrag := 'LatLong';
		
		//***** INDEX BUILD CODE		
		export keybuild(params in_mod) := FUNCTION
			recs := PROJECT(
				in_mod.L_indata, 
				transform(
					layout_LatLong,
					lat				:= (integer4)(left.lat  * ut.geoBox.scale);
					long			:= (integer4)(left.long * ut.geoBox.scale);
					self.lat	:= if(lat<>0 or long<>0, lat, skip);
					self.long	:= long;
					self			:= left.p
				)
			);
			recs_d := DEDUP(recs, ALL, HASH);
			key := INDEX(recs_d, {recs_d}, in_mod.L_inkeyname + '_' + doxie.Version_SuperKey);
			RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key,  '',in_mod.L_inlogical+nameFrag,  do_Key, , in_mod.L_diffing);
			return do_Key;
		END;
		
		//***** INDEX MOVE CODE		
		export keymove(params in_mod) := FUNCTION
			RoxieKeyBuild.Mac_SK_Move_to_Built_v2(in_mod.L_inkeyname+nameFrag, in_mod.L_inlogical+nameFrag,  mv_Key, , in_mod.L_diffing);
			return mv_Key;
		END;
		
		//***** INDEX MOVE QA CODE		
		export keymoveQA(params in_mod) :=
		FUNCTION
			RoxieKeyBuild.MAC_SK_Move_v2(in_mod.L_inkeyname+nameFrag, 'Q',  mv_Key, , in_mod.L_diffing);
			return mv_Key;
		END;
		
	END; // LatLong	
	
END; // MAutokeyBuild