 import mdr,FCRA_ExperianCred,PRTE2_Header,Header_Incremental,SALT37,std,ut,PromoteSupers;

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export File_FCRA_Header_prep(string filedate) :=header.file_headers(src<>'EN',src in mdr.sourceTools.set_scoring_FCRA,pflag3<>'I',pflag3<>'V',did>0);
#ELSE 

export File_FCRA_Header_prep(string filedate) := FUNCTION

hr0 := header.file_headers(src<>'EN',src in mdr.sourceTools.set_scoring_FCRA,pflag3<>'I',pflag3<>'V'):independent;

basename:='~thor_data400::base::header::FCRA_ExperianCred_prep';
new_en_as_header:= FCRA_ExperianCred.as_header(,true)(did>0);
old_en_fcra_prep:= dataset(basename,{header.Layout_Header},thor,opt);

max_en_rid:=max(header.constants.EN_start_rid,max( old_en_fcra_prep,rid)):independent;

header.Layout_New_Records add_rid_all(old_en_fcra_prep l, new_en_as_header r) := transform
 self.rid            := l.rid;
 self                := r;
end;

join_old_new_en :=  join( distribute(old_en_fcra_prep,hash(prim_name,zip,lname)),
							distribute(new_en_as_header,hash(prim_name,zip,lname)),

				left.fname      =right.fname       	and
				left.mname		=right.mname		and
				left.lname      =right.lname       	and
				left.name_suffix=right.name_suffix 	and
				left.phone      =right.phone       	and
				left.ssn        =right.ssn         	and
				left.dob        =right.dob         	and
				left.prim_range =right.prim_range  	and
				left.predir     =right.predir      	and
				left.prim_name  =right.prim_name   	and
				left.suffix     =right.suffix      	and
				left.postdir    =right.postdir     	and
				left.unit_desig =right.unit_desig  	and	
				left.sec_range  =right.sec_range  	and	
				left.city_name  =right.city_name   	and
				left.st         =right.st          	and
				left.zip        =right.zip         	and
				left.zip4       =right.zip4        	and 
				left.county     =right.county
				
                ,add_rid_all(left,right)
				,right outer
				,local
				): persist('~thor_data400::persist::hbm::fcra_en::' ,expire(14),REFRESH(TRUE));

with_no_rid_no_uid := join_old_new_en(rid=0):independent;
with_old_rid_w_uid := join_old_new_en(rid>0):independent;

// re-sequence to minimize new rid range
ut.MAC_Sequence_Records(with_no_rid_no_uid,uid,with_no_rid_new_uid);

with_new_rid := project( with_no_rid_new_uid, transform(header.layout_header,SELF.rid:= max_en_rid+LEFT.uid,SELF:=LEFT)):independent;
with_old_rid := project(with_old_rid_w_uid,header.Layout_Header):independent;

table_duplicates:=table(with_old_rid+with_new_rid,{rid,cnt:=count(group)},rid,merge)(cnt>1);
duplicate_rid_count:=count(table_duplicates);
duplicate_rid_sample:=(with_old_rid+with_new_rid)(rid in set(choosen(table_duplicates,100),rid));

new_file_FCRA_Header_prep:= (hr0 + with_old_rid + with_new_rid);

all_en := sort( with_old_rid + with_new_rid,

		fname,			mname,	lname,	name_suffix,	
		phone,			ssn,	dob,
		prim_range,		predir,		prim_name,	suffix,	postdir,
		unit_desig,		sec_range,	city_name,	st,		zip,		zip4,

		rid,local);

all_en_unique_join := dedup (all_en,

		fname,			mname,	lname,	name_suffix,	
		phone,			ssn,	dob,
		prim_range,		predir,		prim_name,	suffix,	postdir,
		unit_desig,		sec_range,	city_name,	st,		zip,		zip4,

		// we take the lowest rid. We rollup by dates anyway and want to preseve the rid over time

		local);

PromoteSupers.MAC_SF_BuildProcess(all_en_unique_join,basename,bld_new_en_as_header,2,,true,filedate);

update_and_reports:=sequential(

	bld_new_en_as_header,
	output(max_en_rid,named('max_en_rid')),
    output(choosen(with_no_rid_no_uid,100),named('with_no_rid_no_uid')),
    output(count(with_no_rid_no_uid),named('cnt_with_no_rid_no_uid')),
    output(choosen(with_old_rid_w_uid,100),named('with_old_rid_w_uid')),
	output(count(with_old_rid_w_uid),named('cnt_with_old_rid_w_uid')),
    output(duplicate_rid_count,named('duplicate_rid_count')),
    output(choosen(duplicate_rid_sample,100),named('duplicate_rid_sample'))

):independent;

pre_fcra := when(new_file_FCRA_Header_prep,update_and_reports,before);

return Header_Incremental.File_headers_inc_FCRA(pre_fcra);
end;

#END;