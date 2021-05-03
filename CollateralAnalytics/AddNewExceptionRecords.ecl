import CollateralAnalytics, PromoteSupers;

export AddNewExceptionRecords(string pversion):=function

SortLayout:=record
CollateralAnalytics.layouts.ExceptionListLayout;
unsigned IsOld;
end;

loadfile:=project(CollateralAnalytics.file_ExceptionList,transform(SortLayout,self.Isold:=0;self:=left;));

newfile:=project(CollateralAnalytics.file_ExceptionListin,transform(SortLayout,self.Isold:=1;self:=left;));

 SortLayout tUpdate(loadfile L, newfile R):=TRANSFORM
    self.PC_MappedCode:=R.PC_MappedCode;
    self.FinalMatchedValue:=R.FinalMatchedValue;
    self:=L;
END;

CombinedFile:=sort(loadfile+newfile,FieldName,Raw_Value,IsOld);

UpdateRecords:=rollup(CombinedFile,left.FieldName=right.fieldName and left.raw_value=right.raw_value,tUpdate(left,right));

RemoveIsOld:=project(UpdateRecords,transform(CollateralAnalytics.layouts.ExceptionListLayout,self:=left;));

PromoteSupers.Mac_SF_BuildProcess(RemoveIsOld,'~thor_data400::base::collateralanalytics::exceptionlist',build_base,,,TRUE,pversion);

return build_base;

end;