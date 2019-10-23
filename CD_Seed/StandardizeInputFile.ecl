IMPORT  ut;

EXPORT StandardizeInputFile (string filedate, boolean pUseProd = false):= MODULE

	EXPORT CD_seed	:= FUNCTION
		ds	:= Files(filedate,pUseProd).input;

		p:=project(ds
					,TRANSFORM({string filedate,layouts.input}
						,self.filedate:=regexfind('(.*)([0-9]{8})(.*)',left.fn,2,nocase)
						,self:=left
						,self:=[]
						));

		RETURN p
	END;
	
END;