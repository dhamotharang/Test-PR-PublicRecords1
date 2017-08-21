// These are the metrics we're generating...
//
// 1. total old proxids
// 2.	lost proxids Â– an old proxid is completely gone; its base record isn't in the new file (rollup of base file dups by Ingest)
// 3.	merged proxids Â– an old proxid is no longer a proxid; its base record merged into a lower cluster
// 4.	stable proxids - an old proxid is still a proxid
// 5.	split proxids Â– a new proxid's base record is in the old file, but it wasnÂ’t a proxid then (evidence of cleave/sliceout)
// 6.	fresh proxids Â– a new proxid's base record isn't in the old file (newly Ingested data)
// 7. total new proxids
//
// 1=2+3+4
// 7=4+5+6

// NOTE: It's efficient to assume datasets would pass BIPV2_Tools.idIntegrity (DidsNoRid0 in particular), and hopefully true!

import BIPV2_Files, BIPV2;

null := dataset([],BIPV2_Files.layout_dotid);

export idDrift(dataset(BIPV2_Files.layout_dotid)in_old=null, dataset(BIPV2_Files.layout_dotid)in_new=null) := module

	shared dist_old := distribute(table(in_old,{rcid,source,dotid,proxid,lgid3,powid,empid,seleid,orgid,ultid}), hash32(rcid)) : global;
	shared dist_new := distribute(table(in_new,{rcid,source,dotid,proxid,lgid3,powid,empid,seleid,orgid,ultid}), hash32(rcid)) : global;

	export custom(fm_old, fm_new, did, rid='rcid', src='source') := functionmacro
		ds_old := distribute(table(fm_old,{rid,src,did}), hash32(rcid));
		ds_new := distribute(table(fm_new,{rid,src,did}), hash32(rcid));
		base_old := ds_old(rid=did);
		base_new := ds_new(rid=did);

		ds_lost		:= join(base_old, ds_new, left.rid=right.rid, transform(left), left only, local);
		ds_merged	:= join(base_old, ds_new, left.rid=right.rid and right.rid<>right.did, transform(left), local);
		ds_stable	:= join(base_old, base_new, left.rid=right.rid, transform(left), atmost(1), local);
		ds_split	:= join(ds_old, base_new, left.rid=right.rid and left.rid<>left.did, transform(right), local);
		ds_fresh	:= join(ds_old, base_new, left.rid=right.rid, transform(right), right only, local);
		xt_fresh	:= table(ds_new, {src, cnt:=count(group)}, src, merge);
		xt_fresh2	:= table(ds_new, {src_desc:=BIPV2.mod_sources.TranslateSource_aggregate(src), cnt:=count(group)}, BIPV2.mod_sources.TranslateSource_aggregate(src), merge);

		c1 := output(count(base_old), named('cnt_total_old_'+#text(did)));
		c2 := output(count(ds_lost), named('cnt_lost_'+#text(did)));
		c3 := output(count(ds_merged), named('cnt_merged_'+#text(did)));
		c4 := output(count(ds_stable), named('cnt_stable_'+#text(did)));
		c5 := output(count(ds_split), named('cnt_split_'+#text(did)));
		c6 := output(count(ds_fresh), named('cnt_fresh_'+#text(did)));
		c7 := output(count(base_new), named('cnt_total_new_'+#text(did)));
		
		p1 := output(100.0*count(base_old)/count(base_old), named('pct_total_old_'+#text(did)));
		p2 := output(100.0*count(ds_lost)/count(base_old), named('pct_lost_'+#text(did)));
		p3 := output(100.0*count(ds_merged)/count(base_old), named('pct_merged_'+#text(did)));
		p4 := output(100.0*count(ds_stable)/count(base_old), named('pct_stable_'+#text(did)));
		p5 := output(100.0*count(ds_split)/count(base_old), named('pct_split_'+#text(did)));
		p6 := output(100.0*count(ds_fresh)/count(base_old), named('pct_fresh_'+#text(did)));
		p7 := output(100.0*count(base_new)/count(base_old), named('pct_total_new_'+#text(did)));
		
		x1 := output(xt_fresh, named('xt_fresh_'+#text(did)));
		x2 := output(xt_fresh2, named('xt_fresh2_'+#text(did)));
		
		sep := output('----------------------------------------------');
		
		return parallel(c1,c2,c3,c4,c5,c6,c7,p1,p2,p3,p4,p5,p6,p7,x1,x2,sep);
	endmacro;

	export dot := custom(dist_old, dist_new, dotid);
	export prox := custom(dist_old, dist_new, proxid);
	export sele := custom(dist_old, dist_new, seleid);
	export org := custom(dist_old, dist_new, orgid);
	export ult := custom(dist_old, dist_new, ultid);
	export lgid3 := custom(dist_old, dist_new, lgid3);
	export pow := custom(dist_old, dist_new, powid);
	export emp := custom(dist_old, dist_new, empid);
	
	export omni := sequential(dot,prox,sele,org,ult);
	export plus := sequential(lgid3,pow,emp);
	export triple := sequential(prox,sele,pow);
end;