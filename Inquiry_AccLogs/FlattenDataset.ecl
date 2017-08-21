//This will output a dataset as a string for fileservices.sendmail.
Export
flattenDataset (string super) := function
	d:=nothor(fileservices.SuperFileContents(super,true));
	p:=project(d,{d,string4128 x:=''});
	r:=if(count(d)=1
				,dataset([{p[1].name,trim(p[1].name)+'\n'}],{p})
				,rollup(p,true,transform({p},self.x:=if(left.x='', trim(left.name) + '\n', trim(left.x))+trim(right.name)+'\n',self:=left))
				);
	return r[1].x;
end;
