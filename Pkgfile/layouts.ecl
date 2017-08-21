EXPORT layouts := module

	export xml_layouts := module
		export subfile := record
			string value {XPATH('@value')} := '';
		end;

		export superfile := record
			string id {XPATH('@id')} := '';
			dataset(subfile) subfiles {XPATH('SubFile')};
		end;

		export keys := record
			string id {XPATH('@id')} := '';
			dataset(superfile) superfiles {XPATH('SuperFile')};
		end;

		export base := record
			string id {XPATH('@id')} := '';
		end;

		export environment := record
			string id {XPATH('@id')} := '';
			string val {XPATH('@val')} := '';
		end;

		export packageid := record, maxlength(30000)
			string id {XPATH('@id')} := '';
			string pkgcode {XPATH('@pkgcode')} := '';
			string daliip {XPATH('@daliip')} := '';
			dataset(superfile) superfiles {XPATH('SuperFile')};
			string compulsory {XPATH('@compulsory')} := '';
			string eft {XPATH('@enablefieldtranslation')} := '';
			dataset(base) bases {XPATH('Base')};
			dataset(environment) environments {XPATH('Environment')};
		end;
		
    export keys_flat := record,maxlength(50000)
      string superkey {xpath('superkey')};
      string logicalkey {xpath('logicalkey')};
    end;
	end;

	export flat_layouts := module
		
		export subfile := record
			string value;
		end;

		export superfile := record
			string id := '';
			dataset(subfile) subfiles;
		end;
		
		export keys := record
			string id := '';
			dataset(superfile) superfiles;
		end;
		
		export queries := record
			string id := '';
			string compulsory  := '';
				string eft := '';
				string baseid := '';
		end;
		
		export FileRecord := record
			string packageid := '';
			string superfile := '';
			string subfile := '';
			boolean isfullreplace := true;
			boolean isdeltareplace := false;
			string daliip := '';
		end;
		
		export packageid := record, maxlength(30000)
			string pkgcode;
			string id := '';
			ifblock(stringlib.stringtouppercase(self.pkgcode) = 'K')
				string daliip := '';
				string superfileid := '';
				string subfilevalue := '';
				boolean isfullreplace := true;
			END;
			ifblock(stringlib.stringtouppercase(self.pkgcode) = 'Q')
				string compulsory  := '';
				string eft := '';
				string baseid := '';
			END;
			ifblock(stringlib.stringtouppercase(self.pkgcode) = 'E')
				string environmentid  := '';
				string environmentval := '';
				
			END;
			string whenupdated;
		end;
	
		
	end;
	
	
	export old_flat_layouts := module
		
		export subfile := record
			string value;
		end;

		export superfile := record
			string id := '';
			dataset(subfile) subfiles;
		end;
		
		export keys := record
			string id := '';
			dataset(superfile) superfiles;
		end;
		
		export queries := record
			string id := '';
			string compulsory  := '';
				string eft := '';
				string baseid := '';
		end;
		
		export FileRecord := record
			string packageid := '';
			string superfile := '';
			string subfile := '';
			boolean isfullreplace := true;
			string daliip := '';
		end;
		
		export packageid := record, maxlength(30000)
			string pkgcode;
			string id := '';
			ifblock(stringlib.stringtouppercase(self.pkgcode) = 'K')
				string daliip := '';
				string superfileid := '';
				string subfilevalue := '';
			END;
			ifblock(stringlib.stringtouppercase(self.pkgcode) = 'Q')
				string compulsory  := '';
				string eft := '';
				string baseid := '';
			END;
			ifblock(stringlib.stringtouppercase(self.pkgcode) = 'E')
				string environmentid  := '';
				string environmentval := '';
				
			END;
			string whenupdated;
		end;
	
		
	end;
	
end;