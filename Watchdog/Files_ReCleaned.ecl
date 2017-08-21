import header,mdr,ut;
export Files_ReCleaned
	:=
		module
			export Infutor_ := dataset('~thor_data400::BASE::infutor_AID_reclean',header.layout_header,flat);
      export Infutor_narc := dataset('~thor_data400::BASE::infutor_narc_AID_reclean',header.layout_header,flat);	
			export header_  := project(dataset('~thor_data400::BASE::header_AID_reclean',header.layout_header,flat)(src != mdr.sourcetools.src_TU_CreditHeader),
			                   transform(header.layout_header, 
												 self.dt_vendor_first_reported := if(left.src = 'SL', 0,left.dt_vendor_first_reported),
		                     self.dt_vendor_last_reported  := if(left.src = 'SL', 0,left.dt_vendor_last_reported),
												 self := left));
			export header_NonGLB
				:=
						header_(~Mdr.sourcetools.SourceIsGLB(src))
					+ header_(header.isPreGLB(header_(src=mdr.sourcetools.src_Equifax)));

		end;
	