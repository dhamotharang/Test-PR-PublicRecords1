import _control, std, data_services;

EXPORT _Constants := module

	export DatasetName 										:= 'InquiryHistory';
	export FCRA_ESP		  									:= _Control.IPAddress.prod_thor_esp;
	export LZ															:= _CONTROL.IPADDRESS.BCTLPEDATA10;
	export GROUPNAME											:= 'thor400_36'; //ThorLib.Group();
	export THOR_ROOT                      := 'uspr';
	export ROOTDIR 												:= '/data/inquiry_history_data_01/';
	export READYDIR												:= ROOTDIR + 'spray_ready/';
	export SPRAYINGDIR										:= ROOTDIR + 'spraying/';
	export READYENCRYPTEDDIR							:= ROOTDIR + 'spray_ready_encrypted/';
	export SPRAYINGENCRYPTEDDIR						:= ROOTDIR + 'spraying_encrypted/';
	export DONEDIR 												:= ROOTDIR + 'done/';
	export ERRORDIR 											:= ROOTDIR + 'error/';
	export FCRA_FILTERS 									:= ['*inq_hist*.txt'];
	export FILE_TYPES 										:= ['inqlffd'];
	export FCRA_DAILY_BASE_EVENTNAME			:= 'BLD_FCRA_HIST_DAILY_PROCESS_EVENT';
	export FCRA_DAILY_BLD_SCHEDULERNAME   := 'BLD_FCRA_HIST_DAILY_PROCESS';
	export FCRA_PPC                       := ['165','216'];
	export FCRA_PPC_EXCLUDE               := ['420','426'];
	
	EXPORT DECRYPTION_SERVICENAME:= 'KeyDecryption';
  EXPORT DECRYPTION_KEY_PUBLIC := '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxYjK33RDBwdUhvKGRUPK\nvda8ywj9WEqJWBYFJUoIkNFmdzH6yQwPorDffjFkKtyTF9rLYaH61iWWyKfDKRzK\n2YrThAm4cAPnyBExSTIxLz5KZ3OWoo7B8K9uZcSDeGl4ZAnUifNIc6GQTEyHwWW5\nvG3+bEJlGXmTjqKFXiaofbdA0NYRYFAh9Zlpq9bVaFdBXE9injpp29Bg4WEQ185N\nqFW4U+DnNf1s5OBNEzcuYzwk7n4eHqrf1kaJSUOPu5fV/kFdttux/E0SPpP1t4xY\nBcnSRyXi1K9Qhhy96L5WU44v5j+n6tLCkn/hj2e36k3bOpcmMxEfsduZB1Fm8m7A\nyQIDAQAB\n-----END PUBLIC KEY-----';
  EXPORT DECRYPTION_KEY_PRIVATE:= '-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAxYjK33RDBwdUhvKGRUPKvda8ywj9WEqJWBYFJUoIkNFmdzH6\nyQwPorDffjFkKtyTF9rLYaH61iWWyKfDKRzK2YrThAm4cAPnyBExSTIxLz5KZ3OW\noo7B8K9uZcSDeGl4ZAnUifNIc6GQTEyHwWW5vG3+bEJlGXmTjqKFXiaofbdA0NYR\nYFAh9Zlpq9bVaFdBXE9injpp29Bg4WEQ185NqFW4U+DnNf1s5OBNEzcuYzwk7n4e\nHqrf1kaJSUOPu5fV/kFdttux/E0SPpP1t4xYBcnSRyXi1K9Qhhy96L5WU44v5j+n\n6tLCkn/hj2e36k3bOpcmMxEfsduZB1Fm8m7AyQIDAQABAoIBADj/FXqQc16t0Mf3\nZqLJwtAwC92RxHgbWbHe+LEfwYT3xtcRxskH/+LzoikpWzu61X6GlTSgpl3wDqfr\nMDbGpglLM2jf3SYFGnXx8ASsxOBa2uEqywYwpukp1XLr1vuBg0lqRLdhSUCEF7zM\nQEefcI5cNpNKPR2ypM79OfpGsUtEeT0no/6tb9KtiRJWJAiewxB3Xy/hB5iNQplC\n63QzZ9+lo6UYZVZ10SMCJGpeBRcrqjULPAOIW3wgz9bjFHzGtS5J9u19qMePSFlY\ned3SM+b9acCiBtEVUHFcAw6ZqwE/3RYqJVGS6MIQnl2rbvRlBQojz9hrQYvseb8l\nce1u/VkCgYEA6rIMvt94k6axc+8imdmfecgEOr0IFQjietNqRSakUbf3oBP9CByn\nR8YS5aZr2GzRnrax0X14N9G8HWuVDafEAmXhxcy2Uom6hVHHGNwYA870W2+gWlyt\nPuyOzk9deneWrCRTxUn0j7FY+qiJKlP6NBhJ5h9JOee/WP4sTNdOua8CgYEA13ct\nKV8BU6kvVarz/aAQBfjRx8xmS+v2cGB4UNW0Vu0ES2KuhtIjmatxYbtxbMxbgXha\nmC/2bSYVWMgd9bgpCLstWgbyTfefCJkSPbrTzSUU3YMTY8QrhycuTJh5nH1oMujJ\nC8KS83t24KS58DndJolCQf8bdBU+sd3jl21XYwcCgYBcQMqzyKHb4B1Gxgwiz6FZ\nPF81O5LOueRUhX/zWKIkoRzMJq9Cngi/NMO+07D2rKelLIkvIJO91UqNgflgGb75\ndlTN7I8KWKshtqh9RB6IeLQisPkmK+HJpzDnNdk3x4RJfCoVleF1DjA8rzzjj4j9\nK0L5GvksssTLVXXSapu+bwKBgQCzbCyRXOnP7vzZy8fuFdICBxc5173/zviiz9Kh\nDbRlBm4jEIPhBTBcEOYTynFDdlFk2QIn5RjB/4qbKdm4+qhA+w1jAJHZ1y/5iu4j\ntWYWWKCtbS9CTuMoYrotUnNCmzOf4TU5s8eHNfLiUon7v1OneXlRV8xWuDJDD1Es\nkgLJFQKBgQCH5M7Nz8z+SCiUu6hGu8z0wR2J84sPpv7GVOkvmxO1NO00IOxk74kl\nKm/q3oXKhnMKGjOzBBSdl17aiLPrtcpOiIhp4Tvc+MelPkasIPPrwd8TvvgvIApd\n7byFh6zjfVL7rHGrY7LJ5RrjEWN7FwxG5/mNQB/HmMSvYdPaIw6XoA==\n-----END RSA PRIVATE KEY-----';
  EXPORT DECRYPTION_ESP_URL    := 'https://10.176.69.149:8720/WsSecureLogAccess/?internal';
END;