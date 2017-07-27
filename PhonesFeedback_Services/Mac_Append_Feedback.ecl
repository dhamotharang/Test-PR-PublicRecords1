export Mac_Append_Feedback (pInputfile		// Input File
					  ,pDIDField
					  ,pPhoneField
					  ,pOutputFile	// Output file with feedback dataset
					  ,dFeedback='Feedback' // Feedback dataset name
					  ) :=
macro
  //import cannot be inside macro when the macro is being called from within a transform

		// sequence input: designates [phone, DID] combination as unique
		#uniquename(input_layout_seq)
		#uniquename(pInputfile_seq)
		%input_layout_seq%:=record
			recordof(pInputfile);
			unsigned seq_tmp;
		end;
		ut.MAC_Sequence_Records_NewRec(pInputfile,%input_layout_seq%,seq_tmp,%pInputfile_seq%);
		
		#uniquename(skip_set)
		%skip_set%:=['7','8'];

		// first, read feedbacks into the flat layout for the further rollup.
		#uniquename(base_feedback_rec)
		%base_feedback_rec% := PhonesFeedback_Services.Layouts.Layout_PhonesFeedback_base;

		#uniquename(feedback_flat)
		#uniquename(feedback_rec_flat)
		%feedback_rec_flat%:=record
			%input_layout_seq%;
			%base_feedback_rec% %feedback_flat%; // using named subrecord to avoid name collisions
		end;

		#uniquename(join_data);
		%feedback_rec_flat% %join_data% (%pInputfile_seq% l, PhonesFeedback.Key_PhonesFeedback_phone r):=transform
			self:=l;
			self.%feedback_flat% := r;
		end;
		
		#uniquename(joinup);
		%joinup% := join(%pInputfile_seq%, PhonesFeedback.Key_PhonesFeedback_phone,
										(left.pPhoneField <> '') and
										keyed (left.pPhoneField =  right.Phone_number) and 
										(unsigned) left.pDIDField= (unsigned) right.did and
										right.phone_contact_type not in %skip_set%,
										%join_data%(Left,right),left outer, limit(0), keep(1000));

		// group and rollup to create a child feedback data
		#uniquename(feedback_data)
		#uniquename(tmp_rec_layout)
		%tmp_rec_layout%:=record
			%input_layout_seq%;
			dataset(%base_feedback_rec%) %feedback_data% := dataset([],%base_feedback_rec%);
		end;

		#uniquename(grouped_recs);											 
		%grouped_recs% := group(sort(%joinup%, seq_tmp), seq_tmp);

		#uniquename(rolled_recs);
		#uniquename(SetFeedbackChild);
		%tmp_rec_layout% %SetFeedbackChild% (%feedback_rec_flat% L, dataset (%feedback_rec_flat%) R) := transform
			Self.%feedback_data% := project (r (%feedback_flat%.phone_number != ''), transform (%base_feedback_rec%, Self := Left.%feedback_flat%));
			Self := L;
		end;
		%rolled_recs% := rollup (%grouped_recs%, group, %SetFeedbackChild% (Left, ROWS (Left)));

		// call main function for each child datast; it must return a single feedback
		#uniquename(AppendFeedback)
		recordof(pInputfile) %AppendFeedback%(%rolled_recs% l) := transform
			self.dFeedback := PhonesFeedback_Services.Functions.GetReport(l.%feedback_data%);
			self					:= l;
		end;
			
		pOutputFile		:=	project(%rolled_recs%,%AppendFeedback%(left));					 
endmacro;