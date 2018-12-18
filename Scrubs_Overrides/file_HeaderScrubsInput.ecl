import FCRA,Scrubs_Headers_Monthly;

kf := FCRA.File_Header_Correct ((unsigned)head.did<>0);

ScrubsSetup:=project(kf,transform(Scrubs_Headers_Monthly.layout_File,self:=Left.head;self:=[]));



EXPORT file_HeaderScrubsInput :=ScrubsSetup;