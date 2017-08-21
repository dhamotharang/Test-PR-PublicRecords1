EXPORT proc_GetBestName(DATASET(Spokeo.Layout_temp) src) := FUNCTION

			spk := DISTRIBUTE(src(LexId<>0), LexId);

			bst := DISTRIBUTE(Spokeo.File_Infutor_Best, did);

			j := JOIN(spk, bst, left.LexId=right.did,
								TRANSFORM(Spokeo.Layout_temp,
									self.Best_First_Name := right.fname;
									self.Best_Middle_Name := right.mname;
									self.Best_Last_Name := right.lname;
									self.Best_Name_Suffix := right.name_suffix;
									self.Best_Birth_YearMonth := IF(right.dob= 0, '', (string6)(right.dob div 100));
									self := left;), LEFT OUTER, LOCAL);
									
			return j & src(LexId=0);

END;