 export ExtractSourceGroups(inHeader) := functionmacro
   SourceGroupRec := record
       inHeader.seleID;
	  boolean hasPublicRecords;
	  boolean hasDirectory;
	  boolean hasBureau;
	  boolean hasTelephone;
   end;
   
   getUniqueSources := dedup(inHeader, seleid, source, all, hash);
   slimDs           := project(getUniqueSources,
                               transform(SourceGroupRec,
					                self.hasPublicRecords := BIPV2.mod_sources.isPublicRecordFn(left.source),
					                self.hasDirectory     := BIPV2.mod_sources.isDirectoryFn(left.source),
					                self.hasBureau        := BIPV2.mod_sources.isBureauFn(left.source),
					                self.hasTelephone     := BIPV2.mod_sources.isTelephoneFn(left.source),
							      self                  := left));

   groupDs          := group(sort(distribute(slimDs, hash32(seleid)), seleid, local), local);
   
   rollSourceGroups := rollup(groupDs,
                              true,
						transform(SourceGroupRec,
						          self.hasPublicRecords := left.hasPublicRecords or right.hasPublicRecords, 
						          self.hasDirectory     := left.hasDirectory or right.hasDirectory,
						          self.hasBureau        := left.hasBureau or right.hasBureau,
						          self.hasTelephone     := left.hasTelephone or right.hasTelephone,
								self                  := left));

  return ungroup(rollSourceGroups);
endmacro;