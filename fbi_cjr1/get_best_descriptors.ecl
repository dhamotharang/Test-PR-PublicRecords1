
ds_pre_rollup:=fbi_cjr1.get_descriptors;


//ROLLUP Transform
Layout_best_descriptors tRollup(DS_pre_rollup L, DS_pre_rollup R):= TRANSFORM
self.best_score_height := MAX(L.best_score_height , R.best_score_height);
self.best_score_weight := MAX(L.best_score_weight , R.best_score_weight);
self.best_score_race := MAX(L.best_score_race , R.best_score_race);
self.best_score_eye_color := MAX(L.best_score_eye_color , R.best_score_eye_color);
self.best_score_hair_color := MAX(L.best_score_hair_color , R.best_score_hair_color);
//Pick the field value where the score matches
  chooseleft:=if((L.best_score_height+L.best_score_weight+L.best_score_gender+L.best_score_eye_color+L.best_score_hair_color) >
                (R.best_score_height+R.best_score_weight+R.best_score_gender+R.best_score_eye_color+R.best_score_hair_color) ,true,false);
  
  self.source                   :=IF(chooseleft,L.source,R.source);// 'SexOffender';
  self.did						:=L.DID;
  self.source_code              :=IF(chooseleft,L.source_code,R.source_code);
  self.dt_first_seen			:=if(chooseleft,L.dt_first_seen,R.dt_first_seen);
  self.dt_last_seen				:=if(chooseleft,L.dt_last_seen,R.dt_last_seen);
  self.height					:=if (L.best_score_height >= R.best_score_height, L.height, R.height);
  self.weight					:=if (L.best_score_weight >= R.best_score_weight, L.weight, R.weight);
  self.race_code				:= if (L.best_score_race >= R.best_score_race, L.race_code, R.race_code);
  self.race_desc				:=if (L.best_score_race >= R.best_score_race, L.race_desc, R.race_desc);
  self.gender_code				:=if (L.best_score_gender >= R.best_score_gender, L.gender_code, R.gender_code);
  self.gender_desc				:= if (L.best_score_gender >= R.best_score_gender, L.gender_desc, R.gender_desc);
  self.eye_color_code			:=if (L.best_score_eye_color >= R.best_score_eye_color, L.eye_color_code, R.eye_color_code);
  self.eye_color_desc			:=if (L.best_score_eye_color >= R.best_score_eye_color, L.eye_color_desc, R.eye_color_desc);
  self.hair_color_code			:=if (L.best_score_hair_color >= R.best_score_hair_color, L.hair_color_code, R.hair_color_code);
  self.hair_color_desc			:=if (L.best_score_hair_color >= R.best_score_hair_color, L.hair_color_desc, R.hair_color_desc);
self:= L;
END;

res := ROLLUP(ds_pre_rollup, LEFT.did = RIGHT.did, tRollup(LEFT,RIGHT),LOCAL);


export get_best_descriptors := res	: persist('thor::persist::fbi_cjr1:get_best_descriptors');
