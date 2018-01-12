import std, bair_composite;
EXPORT Mod_Report_LexID(string version = '', boolean pDelta = false) := module;
	
	shared rLexID := record
		string rectype;
		unsigned cnt_before;
		unsigned cnt_after;
		string6 percent;
	end;
	
	shared DevList			:=  'debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;';
	shared ProductList	:= DevList;
	shared footer				:='</table>';
	
	shared fnTextOut(pHeader,pBody,pFooter) := FUNCTIONMACRO
		OutText:=
				pHeader
				+trim(rollup(pBody,true
				,transform({pBody}
					,self.x:=trim(left.x)+trim(right.x)
					,self:=left
					))[1].x)
				+pFooter
				;

		RETURN OutText;
	ENDMACRO;
	
	header:=
		'<table border="1">\n'
		+'<caption>'
		+'LEXID Report ' + if(pDelta, 'DELTA - ', 'FULL - ') + version
		+'</caption>\n'
		+'<tr><td>'
		+'rec_type'
		+'</td><td>'
		+'cnt_before'
		+'</td><td>'
		+'cnt_after'
		+'</td><td>'
		+'percent'
		+'</td></tr>\n'
		;
	
	com_a := table(dataset(bair_composite.Filenames(,pDelta).composite_input, bair.layouts.rCompositeBase, flat, opt)(lexid <> 0), {eid, lexid}, record, few, merge);
	com_b := table(dataset(bair_composite.Filenames(,pDelta).composite_input + '_father', bair.layouts.rCompositeBase, flat, opt)(lexid <> 0), {eid, lexid}, record, few, merge);
	
	per_b 			:= table(bair.files(,,pDelta).persons_base.delete(lexid <> 0), {eid, lexid}, record, few, merge);
	cfs_b 			:= table(bair.files(,,pDelta).cfs_base.delete(lexid <> 0), {eid, lexid}, record, few, merge);
	off_b 			:= table(bair.files(,,pDelta).offenders_base.delete(lexid <> 0), {eid, lexid}, record, few, merge);
	cra_b 			:= table(bair.files(,,pDelta).crash_base.delete(lexid <> 0), {eid, lexid}, record, few, merge);
	
	per_a 			:= table(bair.files(,,pDelta).persons_base.built(lexid <> 0), {eid, lexid}, record, few, merge);
	cfs_a 			:= table(bair.files(,,pDelta).cfs_base.built(lexid <> 0), {eid, lexid}, record, few, merge);
	off_a 			:= table(bair.files(,,pDelta).offenders_base.built(lexid <> 0), {eid, lexid}, record, few, merge);
	cra_a 			:= table(bair.files(,,pDelta).crash_base.built(lexid <> 0), {eid, lexid}, record, few, merge);

	com_lexid_cnt_b 		:= count(com_b);
	com_lexid_uniqcnt_b := count(dedup(com_b, lexid, all));
	cfs_lexid_cnt_b 		:= count(cfs_b);
	cfs_lexid_uniqcnt_b := count(dedup(cfs_b, lexid, all));
	per_lexid_cnt_b 		:= count(per_b);
	per_lexid_uniqcnt_b := count(dedup(per_b, lexid, all));
	off_lexid_cnt_b 		:= count(off_b);
	off_lexid_uniqcnt_b := count(dedup(off_b, lexid, all));
	cra_lexid_cnt_b 		:= count(cra_b);
	cra_lexid_uniqcnt_b := count(dedup(cra_b, lexid, all));

	com_lexid_cnt_a 		:= count(com_a);
	com_lexid_uniqcnt_a := count(dedup(com_a, lexid, all));
	cfs_lexid_cnt_a 		:= count(cfs_a);
	cfs_lexid_uniqcnt_a := count(dedup(cfs_a, lexid, all));
	per_lexid_cnt_a 		:= count(per_a);
	per_lexid_uniqcnt_a := count(dedup(per_a, lexid, all));
	off_lexid_cnt_a 		:= count(off_a);
	off_lexid_uniqcnt_a := count(dedup(off_a, lexid, all));
	cra_lexid_cnt_a 		:= count(cra_a);
	cra_lexid_uniqcnt_a := count(dedup(cra_a, lexid, all));

	lexids := dataset([{'com', com_lexid_cnt_b, com_lexid_cnt_a, REALFORMAT((real4)(com_lexid_cnt_a - com_lexid_cnt_b)*100/com_lexid_cnt_b, 6, 2)},
	{'com_uniq', com_lexid_uniqcnt_b, com_lexid_uniqcnt_a, REALFORMAT((real4)(com_lexid_uniqcnt_a - com_lexid_uniqcnt_b)*100/com_lexid_uniqcnt_b, 6, 2)},
	{'cfs', cfs_lexid_cnt_b, cfs_lexid_cnt_a, REALFORMAT((real4)(cfs_lexid_cnt_a - cfs_lexid_cnt_b)*100/cfs_lexid_cnt_b, 6, 2)},
	{'cfs_uniq', cfs_lexid_uniqcnt_b, cfs_lexid_uniqcnt_a, REALFORMAT((real4)(cfs_lexid_uniqcnt_a - cfs_lexid_uniqcnt_b)*100/cfs_lexid_uniqcnt_b, 6, 2)},
	{'per', per_lexid_cnt_b, per_lexid_cnt_a, REALFORMAT((real4)(per_lexid_cnt_a - per_lexid_cnt_b)*100/per_lexid_cnt_b, 6, 2)},
	{'per_uniq', per_lexid_uniqcnt_b, per_lexid_uniqcnt_a, REALFORMAT((real4)(per_lexid_uniqcnt_a - per_lexid_uniqcnt_b)*100/per_lexid_uniqcnt_b, 6, 2)},
	{'off', off_lexid_cnt_b, off_lexid_cnt_a, REALFORMAT((real4)(off_lexid_cnt_a - off_lexid_cnt_b)*100/off_lexid_cnt_b, 6, 2)},
	{'off_uniq', off_lexid_uniqcnt_b, off_lexid_uniqcnt_a, REALFORMAT((real4)(off_lexid_uniqcnt_a - off_lexid_uniqcnt_b)*100/off_lexid_uniqcnt_b, 6, 2)},
	{'cra', cra_lexid_cnt_b, cra_lexid_cnt_a, REALFORMAT((real4)(cra_lexid_cnt_a - cra_lexid_cnt_b)*100/cra_lexid_cnt_b, 6, 2)},
	{'cra_uniq', cra_lexid_uniqcnt_b, cra_lexid_uniqcnt_a, REALFORMAT((real4)(cra_lexid_uniqcnt_a - cra_lexid_uniqcnt_b)*100/cra_lexid_uniqcnt_b, 6, 2)}]
	, rLexID);
	
	lexids_s := sort(lexids, -percent);	
	
	body:=
		table(lexids_s,{string x:=
		'<tr><td>'
		+rectype
		+'</td><td>'
		+cnt_before
		+'</td><td>'
		+cnt_after
		+'</td><td>'
		+percent
		+'</td></tr>\n'
		});

	EXPORT sendLexid :=
		STD.System.Email.SendEmailAttachText(
						ProductList
						,'LEXID Report ' + if(pDelta, 'DELTA - ', 'FULL - ') + version
						,'Attached is a LEXID report'
						,fnTextOut(header,body,footer)
						,'text/plain; charset=ISO-8859-3'
						,'LEXID_Report.html'
						);
		
	header:=
		'<table border="1">\n'
		+'<caption>'
		+'PAYLOAD Report ' + if(pDelta, 'DELTA - ', 'FULL - ') + version
		+'</caption>\n'
		+'<tr><td>'
		+'rec_type'
		+'</td><td>'
		+'cnt_before'
		+'</td><td>'
		+'cnt_after'
		+'</td><td>'
		+'percent'
		+'</td></tr>\n'
		;

	cfs_cnt_a 	:= count(bair.files(,, pDelta).cfs_base.qa);
	mo_cnt_a 		:= count(bair.files(,, pDelta).mo_base.qa);
	per_cnt_a 	:= count(bair.files(,, pDelta).persons_base.qa);
	veh_cnt_a 	:= count(bair.files(,, pDelta).vehicle_base.qa);
	mudf_cnt_a 	:= count(bair.files(,, pDelta).mo_udf_base.qa);
	pudf_cnt_a 	:= count(bair.files(,, pDelta).persons_udf_base.qa);
	cra_cnt_a 	:= count(bair.files(,, pDelta).crash_base.qa);
	off_cnt_a 	:= count(bair.files(,, pDelta).offenders_base.qa);
	off_p_cnt_a := count(bair.files(,, pDelta).offenders_picture_base.qa);
	int_cnt_a 	:= count(bair.files(,, pDelta).intel_base.qa);
	lpr_cnt_a 	:= count(bair.files(,, pDelta).lpr_base.qa);
	shot_cnt_a 	:= count(bair.files(,, pDelta).shotspotter_base.qa);
	notes_cnt_a := count(bair.files(,, pDelta).notes_base.qa);
	img_cnt_a 	:= count(bair.files(,, pDelta).images_base.qa);
	geo_cnt_a 	:= count(bair.files(,, pDelta).geohash_base.qa);
	
	cfS_cnt_b 	:= count(bair.files(,, pDelta).cfs_base.delete);
	mo_cnt_b 		:= count(bair.files(,, pDelta).mo_base.delete);
	per_cnt_b 	:= count(bair.files(,, pDelta).persons_base.delete);
	veh_cnt_b 	:= count(bair.files(,, pDelta).vehicle_base.delete);
	mudf_cnt_b 	:= count(bair.files(,, pDelta).mo_udf_base.delete);
	pudf_cnt_b 	:= count(bair.files(,, pDelta).persons_udf_base.delete);
	cra_cnt_b 	:= count(bair.files(,, pDelta).crash_base.delete);
	off_cnt_b 	:= count(bair.files(,, pDelta).offenders_base.delete);
	off_p_cnt_b := count(bair.files(,, pDelta).offenders_picture_base.delete);
	int_cnt_b 	:= count(bair.files(,, pDelta).intel_base.delete);
	lpr_cnt_b 	:= count(bair.files(,, pDelta).lpr_base.delete);
	shot_cnt_b 	:= count(bair.files(,, pDelta).shotspotter_base.delete);
	notes_cnt_b := count(bair.files(,, pDelta).notes_base.delete);
	img_cnt_b 	:= count(bair.files(,, pDelta).images_base.delete);
	geo_cnt_b 	:= count(bair.files(,, pDelta).geohash_base.delete);
	
	payloads := dataset([{'cfs_rec', cfs_cnt_b, cfs_cnt_a, REALFORMAT((real4)(cfs_cnt_a - cfs_cnt_b)*100/cfs_cnt_b, 6, 2)},
	{'mo_rec', mo_cnt_b, mo_cnt_a, REALFORMAT((real4)(mo_cnt_a - mo_cnt_b)*100/mo_cnt_b, 6, 2)},
	{'per_rec', per_cnt_b, per_cnt_a, REALFORMAT((real4)(per_cnt_a - per_cnt_b)*100/per_cnt_b, 6, 2)},
	{'veh_rec', veh_cnt_b, veh_cnt_a, REALFORMAT((real4)(veh_cnt_a - veh_cnt_b)*100/veh_cnt_b, 6, 2)},
	{'off_rec', off_cnt_b, off_cnt_a, REALFORMAT((real4)(off_cnt_a - off_cnt_b)*100/off_cnt_b, 6, 2)},
	{'off_pic_rec', off_p_cnt_b, off_p_cnt_a, REALFORMAT((real4)(off_p_cnt_a - off_p_cnt_b)*100/off_p_cnt_b, 6, 2)},
	{'cra_rec', cra_cnt_b, cra_cnt_a, REALFORMAT((real4)(cra_cnt_a - cra_cnt_b)*100/cra_cnt_b, 6, 2)},
	{'int_rec', int_cnt_b, int_cnt_a, REALFORMAT((real4)(int_cnt_a - int_cnt_b)*100/int_cnt_b, 6, 2)},
	{'shot_rec', shot_cnt_b, shot_cnt_a, REALFORMAT((real4)(shot_cnt_a - shot_cnt_b)*100/shot_cnt_b, 6, 2)},
	{'lpr_rec', lpr_cnt_b, lpr_cnt_a, REALFORMAT((real4)(lpr_cnt_a - lpr_cnt_b)*100/lpr_cnt_b, 6, 2)},
	{'mo_udf_rec', mudf_cnt_b, mudf_cnt_a, REALFORMAT((real4)(mudf_cnt_a - mudf_cnt_b)*100/mudf_cnt_b, 6, 2)},
	{'per_udf_rec', pudf_cnt_b, pudf_cnt_a, REALFORMAT((real4)(pudf_cnt_a - pudf_cnt_b)*100/pudf_cnt_b, 6, 2)},
	{'notes_rec', notes_cnt_b, notes_cnt_a, REALFORMAT((real4)(notes_cnt_a - notes_cnt_b)*100/notes_cnt_b, 6, 2)},
	{'images_rec', img_cnt_b, img_cnt_a, REALFORMAT((real4)(img_cnt_a - img_cnt_b)*100/img_cnt_b, 6, 2)},
	{'geohash_rec', geo_cnt_b, geo_cnt_a, REALFORMAT((real4)(geo_cnt_a - geo_cnt_b)*100/geo_cnt_b, 6, 2)}]
	, rLexID);
	
	payloads_s := sort(payloads, -percent);
	
	body:=
		table(payloads_s,{string x:=
		'<tr><td>'
		+rectype
		+'</td><td>'
		+cnt_before
		+'</td><td>'
		+cnt_after
		+'</td><td>'
		+percent
		+'</td></tr>\n'
		});
		
	EXPORT sendPayload :=
		STD.System.Email.SendEmailAttachText(
						ProductList
						,'PAYLOAD Report ' + if(pDelta, 'DELTA - ', 'FULL - ') + version
						,'Attached is a PAYLOAD report'
						,fnTextOut(header,body,footer)
						,'text/plain; charset=ISO-8859-3'
						,'PAYLOAD_Report.html'
						);
END;

