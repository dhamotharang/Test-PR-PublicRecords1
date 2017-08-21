import gong_v2, gong;

export Proc_Build_Gong_hhcnts(string rundate) := function

/////////////////////////////////////////////////////////////////////////////////////
///// Create file for gong counts - Superfile swap
/////////////////////////////////////////////////////////////////////////////////////

slim := 
record
  string5 z5;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string1 listing_type_bus;
  string1 listing_type_res;
  string1 listing_type_gov;
  string1 publish_code;
end;

slim_file := project(distribute(Gong.File_Gong_Full_Prepped_For_Keys, hash(z5)), slim);

srt_slim_file := sort(slim_file, record, local);

z5_add_counts_layout := 
record
  string5 z5 := srt_slim_file.z5;
  string10 prim_range := srt_slim_file.prim_range;
  string2 predir := srt_slim_file.predir;
  string28 prim_name := srt_slim_file.prim_name;
  string4 suffix := srt_slim_file.suffix;
  string2 postdir := srt_slim_file.postdir;
  string8 gov_count := intformat(count(group, srt_slim_file.listing_type_gov = 'G'), 8, 1);
  string8 gov_unlisted_count := intformat(count(group, srt_slim_file.listing_type_gov = 'G' and srt_slim_file.publish_code = 'U'), 8, 1);
  string8 gov_nonpub_count := intformat(count(group, srt_slim_file.listing_type_gov = 'G' and srt_slim_file.publish_code = 'N'), 8, 1);
  string8 bus_count := intformat(count(group, srt_slim_file.listing_type_bus = 'B'), 8, 1);
  string8 bus_unlisted_count := intformat(count(group, srt_slim_file.listing_type_bus = 'B' and srt_slim_file.publish_code = 'U'), 8, 1);
  string8 bus_nonpub_count := intformat(count(group, srt_slim_file.listing_type_bus = 'B' and srt_slim_file.publish_code = 'N'), 8, 1);
  string8 res_count := intformat(count(group, srt_slim_file.listing_type_res = 'R'), 8, 1);
  string8 res_unlisted_count := intformat(count(group, srt_slim_file.listing_type_res = 'R' and srt_slim_file.publish_code = 'U'), 8, 1);
  string8 res_nonpub_count := intformat(count(group, srt_slim_file.listing_type_res = 'R' and  srt_slim_file.publish_code = 'N'), 8, 1);
end;

out2 := table(srt_slim_file, z5_add_counts_layout, z5, prim_range, predir, prim_name, suffix, postdir, local);

outfile := 			
sequential(
	output(out2,,Gong_v2.thor_cluster+'base::'+rundate+'::gong_hhcnts',overwrite),
			fileServices.StartSuperFileTransaction(),
			fileservices.clearsuperfile(gong_v2.thor_cluster+'base::gong_hhcnts'),
			
			fileServices.AddSuperFile(gong_v2.thor_cluster+'base::gong_hhcnts',
									  gong_v2.thor_cluster+'base::'+rundate+'::gong_hhcnts',,,),
			
			fileServices.FinishSuperFileTransaction());


return outfile;
end;
