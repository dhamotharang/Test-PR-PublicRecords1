IMPORT data_services,Relationship,header_services;
EXPORT File_Relatives_Insurance(boolean suppressed=false) :=FUNCTION

		file := dataset(
		 	data_services.Data_Location.Relatives
		 +'thor_data400::base::relatives_insurance::boca_copy'
		,Relationship.layout_output.titled
		,flat);
		
		suppression_code := MODULE

							Drop_Header_Layout := Record
								string13  did1;
								string13  did2;
								string8   recent_cohabit;
								string8   zip;
								string5   prim_range;
								string1   same_lname;
								string5   number_cohabits;
								string2   eor;
							end; 

							header_services.Supplemental_Data.mac_verify('file_relatives_inj.txt',Drop_Header_Layout,attr);
							 
							Base_File_Append_In := attr();

							Relationship.layout_output.titled reformat_header(Base_File_Append_In L) := transform
									self.did1 := (unsigned6) L.did1;
									self.did2 := (unsigned6) L.did2;

									self := L;
									self:= []; 
									
							 end;
							Base_File_Append := project(Base_File_Append_In, reformat_header(left));

							ro 	 := file;

							Suppression_Layout := header_services.Supplemental_Data.layout_in;

							header_services.Supplemental_Data.mac_verify('associates_sup.txt',Suppression_Layout,supp_ds_func);
							 
							Suppression_In := supp_ds_func();

							dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

							rHashVal := header_services.Supplemental_Data.layout_out;

							ro_temp_rec := record
								 Relationship.layout_output.titled;
								 data16 hval1;
								 data16 hval2;
								 data16 hval3;
								 data16 hval4;
							end;

							ro_temp_rec tHash_vals(Relationship.layout_output.titled l) := transform                            
								 self.hval1 := hashmd5(intformat(l.did1,15,1),intformat(l.did2,15,1));
								 self.hval2 := hashmd5(intformat(l.did2,15,1),intformat(l.did1,15,1));
								 self.hval3 := hashmd5(intformat(l.did1,15,1));
								 self.hval4 := hashmd5(intformat(l.did2,15,1));
								 self := l;
							end;

							ro_temp := project(ro, tHash_vals(left));

							Relationship.layout_output.titled tSuppress(ro_Temp l, dSuppressedIn r) := transform
							 self := l;
							end;

							rs := join(		ro_temp,dSuppressedIn,
														(left.hval1=right.hval or left.hval2=right.hval or left.hval3=right.hval or left.hval4=right.hval),
														tSuppress(left,right),
														left only,all);

							export File_Relatives_Plus := rs + Base_File_Append;
		
		END;

		return if(not(suppressed),file,suppression_code.File_Relatives_Plus);

END;