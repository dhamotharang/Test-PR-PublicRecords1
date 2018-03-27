//Function to propagate email source to records with the same email and entity
//NOTE: This does a rollup (DEDUP) when multiple sources provided the same email address

import header, ut, mdr;
EXPORT Fn_Propagate_Src_From_Multiple_Srcs(dataset(recordof(_layouts.Base)) email_in) := FUNCTION
			//-----create a data set with email, entity and sources

			slim_layout := record
				string200 clean_email;
				unsigned did;
				string20 fname;
				string20 lname;
				string2  email_src;
				unsigned rec_src_all;
				unsigned email_src_all;
				unsigned email_src_num;
			end;

			slim_email := project(email_in, transform(slim_layout,
																								self.fname := left.clean_name.fname,
																								self.lname := left.clean_name.lname,
																								self := left));
																								
			slim_email_s := sort(distribute(slim_email, hash(clean_email)),clean_email, local);


			//Assign final source based on the following priority order
			//   Impulse or Wired Assets (No royalties)
			//   Acquired Web (0.03)
			//   Entiera (0.04)
										
			recordof(slim_email) t_rollup(slim_email le, slim_email ri) := transform
				self.email_src_all	:=  le.email_src_all | ri.email_src_all;
				self.email_src 			:= Translation_Codes.fCheapest_Src(self.email_src_all);
				self.email_src_num	:= Translation_Codes.fNum_Src(self.email_src_all);
				self := le;
			end;

			email_src_did := rollup(slim_email_s (did > 0),
								left.clean_email = right.clean_email and
								left.did = right.did,
								t_rollup(left, right));
								
			email_src_nm := rollup(slim_email_s,
								left.clean_email = right.clean_email and
								left.fname = right.fname and
								left.lname = right.lname,
								t_rollup(left, right));

			//----Append email source by did/email
			recordof(email_in) t_append_src (email_in le, slim_email_s ri) := transform
				self.email_src_all := le.rec_src_all | ri.email_src_all;
				self.email_src 		 :=Translation_Codes.fCheapest_Src(self.email_src_all);
				self.email_src_num := Translation_Codes.fNum_Src(self.email_src_all);
				self := le;
			end;

			//----Append email source by did
			apped_src_did := join(distribute(email_in, hash(clean_email)),
												distribute( email_src_did, hash(clean_email)),
												left.clean_email = right.clean_email and
												left.did = right.did,
												t_append_src(left, right),
												keep(1),
												left outer,
												local);
												
			//----Append email source by similar fname-lname								
			apped_src_nm := join(distribute(apped_src_did, hash(clean_email)),
												distribute( email_src_nm, hash(clean_email)),
												left.clean_email = right.clean_email and
												ut.DoNamesMatch(left.clean_name.fname,'', left.clean_name.lname, right.fname, '', right.lname, 4) < 4,
												t_append_src(left, right),
												keep(1),
												left outer,
												local);

			RETURN apped_src_nm;

END;