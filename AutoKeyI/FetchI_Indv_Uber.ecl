import AutoStandardI,ut,doxie,autokey,	DriversV2_Services;
export FetchI_Indv_Uber := module
   	export new := module
   		export params := module
   			export full := interface
   				export string autokey_keyname_root;
   				export dataset(Autokey.Layout_Uber.word_params) word_inp;
   				export boolean noFail := true;
   			end;
   		end;

		export do(params.full in_mod) := function
			tempmod := module(params.full)
				export string autokey_keyname_root := in_mod.autokey_keyname_root;
				export boolean noFail := in_mod.noFail;
				export dataset(Autokey.Layout_Uber.word_params) word_inp :=	in_mod.word_inp;
			end;
			
		//KEYS
		word_key := AutoKey.key_uber(in_mod.autokey_keyname_root)._Dictionary;
		inv_key := AutoKey.key_uber(in_mod.autokey_keyname_root).Inversion;
		error_code := 203;
		
		//READING DICTIONARY
		wids_org := JOIN(in_mod.word_inp,word_key,KEYED(LEFT.word = RIGHT.word)
		             ,TRANSFORM({AutoKey.Layout_uber.ref_rec,integer cnt}
								        ,SELF.word_id:=RIGHT.id
												,SELF.cnt := RIGHT.cnt
												,SELF.field := LEFT.field
												,SELF := []));
    //Preemptive check when Word =1 and word frequency is higher 												
    pre_word := IF(count(wids_org)=1
		              ,IF(wids_org[1].cnt<=ut.limits.FETCH_LEV2_UNKEYED
									,wids_org,FAIL(wids_org,error_code,doxie.ErrorCodes(error_code)))
									,wids_org);
		wids := PROJECT(sort(pre_word, cnt),AutoKey.Layout_uber.ref_rec); //sort by count here allows us to set priority by the counter in doIndexRead

		//READING INVERSION
		doIndexRead(unsigned4 id,unsigned2 fld,unsigned2 pri) :=
		 STEPPED( PROJECT(inv_key(KEYED(word_id = id  AND field=fld))
		 ,AutoKey.Layout_uber.ref_rec), uid, priority(pri));
    
		//JOIN ALL THE INVERSION DATASETS - NORMAL AND
		doJoin(set of dataset(AutoKey.Layout_uber.ref_rec) inputs) := function
				AutoKey.Layout_uber.ref_rec createMatchRecord(AutoKey.Layout_uber.ref_rec firstMatch) := transform
						self := firstMatch;
						SELF := [];
				end;
				return limit(join(inputs, stepped(left.uid = right.uid), createMatchRecord(LEFT), sorted(uid)),ut.limits.FETCH_LEV2_UNKEYED,fail(error_code,doxie.ErrorCodes(error_code)));
		end;


		doAction(set of dataset(AutoKey.Layout_uber.ref_rec) allInputs, dataset(AutoKey.Layout_uber.ref_rec) words, integer stage) := function
				numWords := count(words);
				sillyIntegerDs := normalize(dataset([0],{integer x}), numWords, transform({integer x}, self.x := counter));
				sillyIntegerSet := set(sillyIntegerDs, x);
				result := if (stage <= numWords,
							doIndexRead(words[stage].word_id,words[stage].field,stage),
							doJoin(RANGE(allInputs, sillyIntegerSet)));
			return result;
		end;

		nullInput := dataset([], AutoKey.Layout_uber.ref_rec);
		s := GRAPH(nullInput, count(wids)+1, doAction(rowset(left), wids, counter), parallel);
    res := PROJECT(s,TRANSFORM(autokey.layout_fetch,SELF.did := LEFT.uid));
		
		RETURN res;
		end;
	end;
end;
