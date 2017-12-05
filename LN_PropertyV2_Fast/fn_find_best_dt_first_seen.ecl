IMPORT AID,ut,LN_PropertyV2,mdr,header;

EXPORT fn_find_best_dt_first_seen(dataset(recordof(header.file_headers)) File_Header) := FUNCTION

		headerfile:=distribute(File_Header(src in mdr.sourcetools.set_LnPropertyV2),
		  hash64(did, prim_range, prim_name, zip));

		search_base:=LN_PropertyV2.File_Search_DID(did>0, dt_first_seen>0);

		temprec1:=record
			unsigned6 did;
			unsigned4 dt_first_seen;
			string10	prim_range;
			string2   predir;
			string28	prim_name;
			string4		suffix;
			string2		postdir;
			string10	unit_desig;
			string8		sec_range;
			string25	v_city_name;
			string2		st;
			string5		zip;
			string4		zip4;
			string12	ln_fares_id;
			AID.Common.xAID	Append_RawAID;
			unsigned4 cntaddr:=0;
		end;

		selectedrecs:=project(search_base,transform(temprec1,self:=left,self.cntaddr:=counter));

		temprec2:=record
			unsigned6 did;
				unsigned4 dt_first_seen;
				string10		prim_range;
				string2   predir;
				string28		prim_name;
				string4			suffix;
				string2			postdir;
				string10		unit_desig;
				string8			sec_range;
				string25		v_city_name;
				string2			st;
				string5			zip;
			string12		ln_fares_id;
				AID.Common.xAID	Append_RawAID;
			unsigned4 cntaddr;
			unsigned4 cntdt:=1;
		end;

		GroupSelected:=
			 group(
				  sort(
					   distribute(
										project(selectedrecs,temprec2),
								    hash64(did, prim_range, prim_name, zip)),
				    did, prim_range, prim_name, zip, -dt_first_seen,local),
			   did, prim_range, prim_name, zip);
		
		temprec2 xformac(temprec2 l, temprec2 r, integer c):=transform
			self.cntaddr:=if(l.cntaddr=0,r.cntaddr,l.cntaddr);
			self:=r;
		end;

		accnt:=
			ungroup(
				iterate(GroupSelected(ln_fares_id[2]='A'),xformac(left,right,counter))
			);
		
		aconly:=
			rollup(accnt,
				left.did=right.did and
				left.prim_range=right.prim_range and
				left.prim_name=right.prim_name and
				left.zip=right.zip,
				transform(temprec2,
					self.cntdt:=left.cntdt+1;
					self.dt_first_seen:=ut.min2(left.dt_first_seen,right.dt_first_seen);
					self:=left;)
			);

		droponesac:=aconly((cntaddr>1 and cntdt>1) or (cntaddr=1 and cntdt=1));

		decnt:=
			ungroup(
				iterate(GroupSelected(ln_fares_id[2]='D'),xformac(left,right,counter))
			);

		deonly:=
			rollup(decnt,
				left.did=right.did and
				left.prim_range=right.prim_range and
				left.prim_name=right.prim_name and
				left.zip=right.zip,
				transform(temprec2,
					self.cntdt:=left.cntdt+1;
								self.dt_first_seen:=ut.min2(left.dt_first_seen,right.dt_first_seen);
					self:=left;)
			);

		temprec2 xformselect(temprec2 l, temprec2 r):=transform
				self.dt_first_seen:=if(l.dt_first_seen=0,r.dt_first_seen,l.dt_first_seen),
					self:=if(l.did=0,r,l);
		end;

		selectdate:=join(deonly,droponesac,
				left.did=right.did and
    Left.prim_range=right.prim_range and
    Left.prim_name=right.prim_name and
    Left.zip=right.zip and
    Ut.nneq(left.sec_range,right.sec_range),
						xformselect(left,right),full outer);

		cleanedheader:=join(headerfile,selectdate,
				left.did=right.did and
    Left.prim_range=right.prim_range and
    Left.prim_name=right.prim_name and
    Left.zip=right.zip and
    Ut.nneq(left.sec_range,right.sec_range),
						transform(recordof(headerfile),
								self.dt_first_seen:=if(left.dt_first_seen[1..4]>=right.dt_first_seen[1..4],
								left.dt_first_seen,0),
							 self:=left),
						left outer, keep(1),local);

  nonpropertyheader:=	File_Header(src not in mdr.sourcetools.set_LnPropertyV2);

  fullcleanedheader:=distribute(nonpropertyheader+cleanedheader,hash64(did, prim_range, prim_name, zip));

  return fullcleanedheader;
END;