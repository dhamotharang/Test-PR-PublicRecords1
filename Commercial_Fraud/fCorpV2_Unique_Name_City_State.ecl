import corp2;

lay_corpv2 := Corp2.Layout_Corporate_Direct_Corp_Base;

export fCorpV2_Unique_Name_City_State(

	 dataset(lay_corpv2	)	pCorpV2				= Prep_CorpV2.fCorp()
	,string 							pTestFilter		= ''
	,string								pPersistname	= Persistnames().fCorpV2UniqueNameCityState
	
) :=
function

		/////////////////////////////////////////////////////////////////////////////////////
		// -- ones without bdid need to run through name, city, state match
		/////////////////////////////////////////////////////////////////////////////////////
		export dCorpV2_nonblanks	:= pCorpV2(corp_legal_name != '',corp_key != '');
		export dCorpV2_nonblanks_cities := normalize(dCorpV2_nonblanks, 2,transform(
			{unsigned6 bdid, string corp_key, string corp_legal_name, string city, string state}
			,self.city := choose(counter,left.corp_addr1_v_city_name,left.corp_addr1_p_city_name);
			 self.state := left.corp_addr1_state;
			 self := left)
		);
		export dCorpV2_nonblanks_cities_dedup := dedup(dCorpV2_nonblanks_cities(city != '', state != ''),hash64(bdid,corp_legal_name,city,state),all);

		export dCorpV2_vslim			:= table(dCorpV2_nonblanks,{corp_key,string corp_legal_name := trim(corp_legal_name,left,right),string city := trim(corp_addr1_v_city_name),string state := trim(corp_addr1_state,left,right)},corp_key,corp_legal_name,corp_addr1_v_city_name,corp_addr1_state);
		export dCorpV2_pslim			:= table(dCorpV2_nonblanks,{corp_key,string corp_legal_name := trim(corp_legal_name,left,right),string city := trim(corp_addr1_p_city_name),string state := trim(corp_addr1_state,left,right)},corp_key,corp_legal_name,corp_addr1_p_city_name,corp_addr1_state);

		export dCorpV2_all := dedup(dCorpV2_vslim + dCorpV2_pslim(city != '', state != ''), corp_key, corp_legal_name, city,state,all);
		
		export dCorpV2_all_cnts	:= table(dCorpV2_all,{corp_legal_name,city,state,unsigned8 cnt_corp_keys := count(group)},corp_legal_name,city,state);
		export dCorpV2_all_one_corp_key_per_city_state :=  dCorpV2_all_cnts(cnt_corp_keys = 1);
		
		export dCorpV2_slim_cnt_1_withcorp_key := join(
			 distribute(dCorpV2_nonblanks_cities_dedup					,hash64(corp_legal_name,city,state))
			,distribute(dCorpV2_all_one_corp_key_per_city_state	,hash64(corp_legal_name,city,state))
			,		left.corp_legal_name	= right.corp_legal_name
			and left.city							= right.city
			and left.state						= right.state
			,transform(
				 Layouts.Temporary.fCorpV2UniqueNameCityState
				,self := left;
				 self := right;
			)
			,local
		)
		: persist(pPersistname);
		
		export countdCorpV2_nonblanks_cities_dedup	:= count(dCorpV2_nonblanks_cities_dedup);
		export countdCorpV2_slim_cnt_1_withcorp_key := count(dCorpV2_slim_cnt_1_withcorp_key);

		export dCorpV2_nonblanks_filt												:= dCorpV2_nonblanks											(regexfind(pTestFilter,corp_legal_name,nocase));
		export dCorpV2_nonblanks_cities_filt								:= dCorpV2_nonblanks_cities								(regexfind(pTestFilter,corp_legal_name,nocase));
		export dCorpV2_nonblanks_cities_dedup_filt					:= dCorpV2_nonblanks_cities_dedup					(regexfind(pTestFilter,corp_legal_name,nocase));
		export dCorpV2_vslim_filt														:= dCorpV2_vslim													(regexfind(pTestFilter,corp_legal_name,nocase));
		export dCorpV2_pslim_filt														:= dCorpV2_pslim													(regexfind(pTestFilter,corp_legal_name,nocase));
		export dCorpV2_all_filt															:= dCorpV2_all														(regexfind(pTestFilter,corp_legal_name,nocase));
		export dCorpV2_all_cnts_filt												:= dCorpV2_all_cnts												(regexfind(pTestFilter,corp_legal_name,nocase));
		export dCorpV2_all_one_corp_key_per_city_state_filt	:= dCorpV2_all_one_corp_key_per_city_state(regexfind(pTestFilter,corp_legal_name,nocase));
		export dCorpV2_slim_cnt_1_withcorp_key_filt					:= dCorpV2_slim_cnt_1_withcorp_key				(regexfind(pTestFilter,corp_legal_name,nocase));
		
	return dCorpV2_slim_cnt_1_withcorp_key;


end;
