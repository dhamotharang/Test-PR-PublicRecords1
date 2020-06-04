export ExtractParentSeleidInfo(inHeader) := functionmacro
   SlimRec := record
      inHeader.seleid;
      inHeader.orgid;
	 inHeader.is_org_level;
   end;

   getParentSeleId := dedup(sort(distribute(inHeader(is_org_level), hash32(orgid)), orgid, seleid), orgid, all,hash);
   
   return getParentSeleId;
endmacro;   