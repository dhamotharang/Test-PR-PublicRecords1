import lib_fileservices;
EXPORT SendMail(const varstring to, const varstring subject, const varstring body) :=
	lib_fileservices.fileservices.SendEmail(to,subject,body,'mailout.br.seisint.com',25,'hpcc@dataland.env');

